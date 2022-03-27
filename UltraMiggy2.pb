; UltraMiggy
;
; Version 0.2
;
; © 2020 Paul Vince (MrV2k)
;
; https://easymame.mameworld.info
;
; [ PB V5.7x / 64Bit / Windows / DPI ]
;
; A launcher for Commodore Amiga Software
;
; Includes & Credits=================================
;
; Name:        Module TinyIFF
; Description: A tiny module for loading IFF images.
; Author:      flype, flype44(at)gmail(dot)com
; Revision:    1.1 (2015-09-10)
;
;===================================================

EnableExplicit

XIncludeFile "TinyIFF.pbi"

Declare List_Files_Recursive(Dir.s, List Files.s(), Extension.s)
Declare Message_RequesterEx(Title$ , Message$ , width.i)
Declare.s Title_Extras()
Declare Draw_Info(number)
Declare Draw_List()
Declare.s Split_On_Capital(split_string.s)
Declare Fix_Gameslist(names_only.b=#False)
Declare Update_Amiga()
Declare Create_Gameslist()
Declare Image_Popup(type)
Declare Process_DB()
Declare Load_DB()
Declare Save_DB()
Declare Load_GL()
Declare Save_GL(path.s)
Declare Save_GL_CSV(path.s)
Declare Save_Prefs()
Declare Load_Prefs()
Declare Edit_GL(number)
Declare Draw_Main_Window()
Declare Check_Missing_Images(type.i)
Declare Choose_Icon()

Enumeration
  
  #MAIN_WINDOW
  #MAIN_STATUS
  #POPUP_WINDOW
  #PATH_WINDOW
  #EDIT_WINDOW
  #IFF_IMAGE
  #COVER_IMAGE
  #IFF_BLANK
  #IFF_POPUP
  #FTP
  
EndEnumeration

Enumeration FormMenu
  #MenuItem_1
  #MenuItem_2
  #MenuItem_3
  #MenuItem_4
  #MenuItem_5
  #MenuItem_6
  #MenuItem_7
  #MenuItem_8
  #MenuItem_9
  #MenuItem_10
  #MenuItem_11
  #MenuItem_12
  #MenuItem_13
  #MenuItem_14
  #MenuItem_15
  #MenuItem_16
  #MenuItem_17
  #MenuItem_18
  #MenuItem_19
  #MenuItem_20
  #MenuItem_21
  #MenuItem_22
  #MenuItem_23
  #MenuItem_24
  #MenuItem_25
  #MenuItem_26
  #MenuItem_27
  #MenuItem_28
  #MenuItem_29
  #MenuItem_30
  #MenuItem_31
  #MenuItem_32
  #MenuItem_33
  #MenuItem_34
  #MenuItem_35
  #MenuItem_36
  #MenuItem_37
  #MenuItem_38
  #MenuItem_39
EndEnumeration

Structure IG_Data
  IG_Title.s
  IG_Genre.s
  IG_Path.s
  IG_Folder.s
  IG_Subfolder.s
  IG_Slave.s
  IG_Slave_Date.s
  IG_LHAFile.s
  IG_Favourite.s
  IG_TimesPlayed.s
  IG_LastPlayed.s
  IG_Hidden.s
  IG_Language.s
  IG_Memory.s
  IG_AGA.b
  IG_NTSC.b
  IG_CD32.b
  IG_CDTV.b
  IG_CDROM.b
  IG_MT32.b
  IG_Disks.s
  IG_Demo.b
  IG_Intro.b
  IG_NoIntro.b
  IG_Coverdisk.b
  IG_Preview.b
  IG_Files.b
  IG_Image.b
  IG_Arcadia.b
  IG_Coder.s
  IG_Type.s
  IG_Year.s
  IG_Publisher.s
  IG_Default_Icon.s
  List IG_Icons.s()
  IG_Filtered.b
  IG_Installed.b
  IG_Available.b
  IG_Image_Avail.b
  IG_Cover_Avail.b
  IG_Title_Avail.b
  
EndStructure

Global NewList IG_Database.IG_Data()
Global NewList T_List.IG_data()

Structure f_data
  F_Title.s
  F_Genre.s
  F_Folder.s
  F_SubFolder.s
  F_Slave.s
  F_Slave_Date.s
  F_Path.s
  F_LHAFile.s
  F_Language.s
  F_Memory.s
  F_AGA.b
  F_NTSC.b
  F_CD32.b
  F_CDTV.b
  F_CDROM.b
  F_MT32.b
  F_Disks.s
  F_Demo.b
  F_Intro.b
  F_NoIntro.b
  F_Coverdisk.b
  F_Preview.b
  F_Files.b
  F_Image.b
  F_Arcadia.b
  F_DemoMaker.s
  F_Type.s
  F_Year.s
  F_Installed.b
  List F_Icons.s()
  F_Default_Icon.s
EndStructure

Global NewList Fix_List.f_data()

Global NewList List_Numbers.i()

Global NewList Files.s()
Global NewList File_List.s()

Global NewList Genre_List.s()
Global NewMap Genre_Map.s()
Global NewMap Duplicates.i()
Global NewList Dupe_List.i()

Structure Dat_Names
  Arc_Type.s
  Arc_Folder.s
  List Arc_Names.s()
EndStructure

Global NewList Dat_Archives.Dat_Names()

Global W_Title.s="UltraMiggy v0.2"
Global Main_Path.s, path.s, home_path.s, List_Type.s, List_Path.s
Global event.i, Main_Menu.i, Main_Image, Cover_Image, Main_Search, IFF_Image, listnum.i, temp$, count.i, i.i, j.i, k.i
Global Main_List, Info_List, LoadGL_Button, SaveDB_Button, New_Button, GamePath_Button, Fix_Button, Genres_Button, Prefs_Button, Clear_Button, CSV_Button, Play_Button
Global SaveGL_Button, Audit_Button, Edit_Button, Delete_Button, WHD_Path, WHDPath_Button, Path_Button, Make_Button, Main_Genre_Combo, Main_Type_Combo, Main_Filter_Combo
Global st_processed, st_removed, st_fixed, g_file, text$
Global merge_path_1.s,merge_path_2.s,merge_path_3.s, TitleScreen.b, main_image_title.i

Global LHA_Path.s=GetCurrentDirectory()+"7z.exe"
Global LZX_Path.s=GetCurrentDirectory()+"unlzx.exe"
Global IFF_Smooth.l=#PB_Image_Raw
Global whdtemp_dir.s=GetTemporaryDirectory()+"WHDTemp"
Global Genres_Path.s=GetCurrentDirectory()
Global DB_Path.s=GetCurrentDirectory()
Global Game_Img_Path.s="I:\UltraMiggy\Images\"
Global whd_uae_config.s=""
Global whd_update_config.s=""
Global whd_cd32_config.s=""
Global whd_lha_path.s=""
Global whd_lha_game.s=""
Global whd_lha_demo.s=""
Global whd_lha_beta.s=""
Global IGame_Path.s=""
Global WinUAE_Path.s=""
Global Close_UAE.b=#True
Global JSON_Backup=#False
Global TitleScreen=#False

Macro Window_Pause (window) ; <----------------------------------------> Stop Window Drawing
  SendMessage_(WindowID(window),#WM_SETREDRAW,#False,0)
EndMacro

Macro Window_Resume (window) ; <---------------------------------------> Resume Window Drawing
  SendMessage_(WindowID(window),#WM_SETREDRAW,#True,0) 
  RedrawWindow_(WindowID(window), #Null, #Null, #RDW_ERASE | #RDW_FRAME | #RDW_INVALIDATE | #RDW_ALLCHILDREN)
  SetActiveWindow(window)
EndMacro

Macro Window_Update() ; <---------------------------------------------> Waits For Window Update
  While WindowEvent() : Wend
EndMacro

Macro Set_Menu (s_bool)
  
  DisableGadget(SaveDB_Button,s_bool)
  DisableGadget(Path_Button,s_bool)
  DisableGadget(SaveGL_Button,s_bool)
  DisableGadget(CSV_Button,s_bool)
  DisableGadget(Fix_Button,s_bool)
  DisableGadget(Clear_Button,s_bool)
  DisableGadget(Edit_Button,s_bool)
  DisableGadget(Main_Genre_Combo,s_bool)
  
  DisableMenuItem(Main_Menu,#MenuItem_4,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_5,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_6,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_7,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_9,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_10,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_11,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_12,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_13,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_15,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_16,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_19,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_21,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_22,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_23,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_24,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_25,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_28,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_29,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_30,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_35,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_36,s_bool)
  DisableMenuItem(Main_Menu,#MenuItem_38,s_bool)
  
EndMacro

Macro DpiX(value) ; <--------------------------------------------------> DPI X Scaling
  DesktopScaledX(value)
EndMacro

Macro DpiY(value) ; <--------------------------------------------------> DPI Y Scaling
  DesktopScaledY(value)
EndMacro

Macro CopyListElement(Element, DestList, Location=#PB_List_Last)
  CompilerSelect Location
    CompilerCase #PB_List_After
      AddElement(DestList) : DestList = Element
    CompilerCase #PB_List_Before
      InsertElement(DestList) : DestList = Element
    CompilerCase #PB_List_First
      ResetList(DestList) : AddElement(DestList) : DestList = Element
    CompilerCase #PB_List_Last
      LastElement(DestList) : AddElement(DestList) : DestList = Element
  CompilerEndSelect
EndMacro

Macro Pause_Console()
  PrintN("Press A Key To Continue...")
  Repeat : Until Inkey()<>""
EndMacro

Macro PrintNCol(PText,PFCol,PBCol)
  ConsoleColor(PFCol,PBCol)
  PrintN(PText)
  ConsoleColor(7,0)
EndMacro

Macro Update_StatusBar()
  
  If IG_Database()\IG_Type="Demo"
      StatusBarText(#MAIN_STATUS,1,"Coder: "+Chr(10)+IG_Database()\IG_Coder)
    Else
      StatusBarText(#MAIN_STATUS,1,"Publisher: "+Chr(10)+IG_Database()\IG_Coder)
    EndIf
    
    StatusBarText(#MAIN_STATUS,0,"Genre: "+Chr(10)+IG_Database()\IG_Genre)  
    StatusBarText(#MAIN_STATUS,2,"Year: "+Chr(10)+IG_Database()\IG_Year)
  
EndMacro

Procedure List_Files_Recursive(Dir.s, List Files.s(), Extension.s) ; <------> Adds All Files In A Folder Into The Supplied List
  
  Protected NewList Directories.s()
  
  Protected FOLDER_LIST
  
  If Right(Dir, 1) <> "\"
    Dir + "\"
  EndIf
  
  If ExamineDirectory(FOLDER_LIST, Dir, Extension)
    While NextDirectoryEntry(FOLDER_LIST)
      Select DirectoryEntryType(FOLDER_LIST)
        Case #PB_DirectoryEntry_File
          AddElement(Files())
          Files() = Dir + DirectoryEntryName(FOLDER_LIST)
          Window_Update()
        Case #PB_DirectoryEntry_Directory
          Select DirectoryEntryName(FOLDER_LIST)
            Case ".", ".."
              Continue
            Default
              AddElement(Directories())
              Directories() = Dir + DirectoryEntryName(FOLDER_LIST)
          EndSelect
      EndSelect
    Wend
    FinishDirectory(FOLDER_LIST)
    ForEach Directories()
      List_Files_Recursive(Directories(), Files(), Extension)
    Next
  EndIf 
  
  FreeList(Directories())
  
EndProcedure

Procedure Message_RequesterEx(Title$ , Message$ , width.i) ; ------> Own Drawn Input Requester
  
  Protected Result$, Window, Button, Event, height, editor, i, x
  
  height=(CountString(Message$,#LF$)+1)*20
  
  Window = OpenWindow(#PB_Any,0,0,width,55+height,Title$,#PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
  
  StickyWindow(window,#True)
  
  x=5
  
  If Window
    For i=1 To CountString(message$,#LF$)+1
      TextGadget(#PB_Any,10,x+5,width-20,20,StringField(Message$,i,#LF$),#PB_Text_Center)
      x+20
    Next
    Button = ButtonGadget(#PB_Any,10,20+height,width-20,20,"Close")
    AddKeyboardShortcut(Window, #PB_Shortcut_Return, 1000)
    Repeat
      Event = WaitWindowEvent()
      
      If Event=#WM_KEYDOWN
        If EventwParam() = #VK_ESCAPE Or EventwParam() = #VK_RETURN
          Break
        EndIf
      EndIf
      
      If EventGadget() = Button
        Break
      EndIf
    ForEver
  EndIf
  CloseWindow(Window)
  
EndProcedure

Procedure.s Title_Extras()
  
  Protected extras.s=""
  
  If IG_Database()\IG_Memory<>""
    extras+" ("+IG_Database()\IG_Memory+")"
  EndIf   
  
  If IG_Database()\IG_Language<>""
    extras+" ("+IG_Database()\IG_Language+")"
  EndIf
  
  If IG_Database()\IG_Files<>0
    extras+" (Files)"
  EndIf
  
  If IG_Database()\IG_Image<>0
    extras+" (Image)"
  EndIf
      
  If IG_Database()\IG_Disks<>""
    extras+" ("+IG_Database()\IG_Disks+")"
  EndIf
  
  If IG_Database()\IG_NTSC<>0
    extras+" (NTSC)"
  EndIf
  
  If IG_Database()\IG_Demo<>0
    extras+" (Game Demo)"
  EndIf
  
  If IG_Database()\IG_Intro<>0
    extras+" (Intro)"
  EndIf
  
  If IG_Database()\IG_NoIntro<>0
    extras+" (No Intro)"
  EndIf
  
  If IG_Database()\IG_Preview<>0
    extras+" (Preview)"
  EndIf
  
  If IG_Database()\IG_Coverdisk<>0
    extras+" (Coverdisk)"
  EndIf

  If IG_Database()\IG_Arcadia<>0
    extras+" (Arcadia)"
  EndIf
  
  If IG_Database()\IG_MT32<>0
    extras+" (MT32)"
  EndIf
  
  If IG_Database()\IG_CDROM<>0
    extras+" (CD-ROM)"
  EndIf
  
  If IG_Database()\IG_CD32<>0
    extras+" (CD32)"
  EndIf
  
  If IG_Database()\IG_CDTV<>0
    extras+" (CDTV)"
  EndIf
  
  If IG_Database()\IG_AGA<>0 And IG_Database()\IG_CD32=0
    extras+" (AGA)"
  EndIf

  
  If IG_Database()\IG_Type="Beta"
    extras+" ("+IG_Database()\IG_Type+")"
  EndIf
    
  ProcedureReturn extras
  
EndProcedure

Procedure Load_IFF(imagename.s,imagenum.l)
    
  Protected my_image.l, IFF_Archive.l
  
  If IsImage(my_image) : FreeImage(my_image) : EndIf

  my_image=TinyIFF::Load(#PB_Any,imagename)
  DeleteDirectory(whdtemp_dir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
  
  If IsImage(my_image)
    CopyImage(my_image,imagenum)    
    FreeImage(my_image)
  EndIf 
  
EndProcedure

Procedure Filter_List()
  
  Protected Category.s, Filter_Type.s, Genre_Type.s
  
  Select GetGadgetState(Main_Type_Combo)
    Case 0 : Category=""
    Case 1 : Category="Game"
    Case 2 : Category="Demo"
    Case 3 : Category="Beta"
  EndSelect
  
  Filter_Type=GetGadgetText(Main_Filter_Combo)
  Genre_Type=GetGadgetText(Main_Genre_Combo)
  
  If Filter_Type="No Image"
    Check_Missing_Images(1)  
  EndIf
  
  If Filter_Type="No Cover"
    Check_Missing_Images(2)  
  EndIf
  
  If Filter_Type="No Title"
    Check_Missing_Images(3)  
  EndIf
  
  ForEach IG_Database()
    
    IG_Database()\IG_Filtered=#False
       
    If Category<>""
      If IG_Database()\IG_Type<>Category
        IG_Database()\IG_Filtered=#True
      EndIf
    EndIf
    
    If Genre_Type<>"All"
      If IG_Database()\IG_Genre<>Genre_Type
        IG_Database()\IG_Filtered=#True
      EndIf
    EndIf 
    
    Select Filter_Type
        
      Case "No Image"        
        If IG_Database()\IG_Image_Avail=#True
          IG_Database()\IG_Filtered=#True
        EndIf
        
      Case "No Cover"        
        If IG_Database()\IG_Cover_Avail=#True
          IG_Database()\IG_Filtered=#True
        EndIf
        
      Case "No Title"        
        If IG_Database()\IG_Title_Avail=#True
          IG_Database()\IG_Filtered=#True
        EndIf
        
      Case "Invalid Genre"
        If FindMapElement(Genre_Map(),IG_Database()\IG_Genre)
          IG_Database()\IG_Filtered=#True
        EndIf
        
      Case "Missing Type"
        If IG_Database()\IG_Type<>""
          IG_Database()\IG_Filtered=#True
        EndIf
        
      Case "Invalid Icon"
        ForEach IG_Database()\IG_Icons()
          If IG_Database()\IG_Default_Icon=IG_Database()\IG_Icons() : IG_Database()\IG_Filtered=#True : Break : EndIf
        Next
        
      Case "No Icon"
        ForEach IG_Database()\IG_Icons()
          If IG_Database()\IG_Default_Icon<>"" : IG_Database()\IG_Filtered=#True : Break : EndIf
        Next
        
    EndSelect
    
  Next
  
EndProcedure

Procedure Draw_Info(number)
  
  Window_Pause(#MAIN_WINDOW)  
  
  If IsImage(#IFF_IMAGE) : FreeImage(#IFF_IMAGE) : EndIf
  
  If number>-1
    
    SelectElement(IG_Database(),number)
    
    Update_StatusBar()
    
    If TitleScreen
      path=Game_Img_Path+"Titles\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
    Else
      path=Game_Img_Path+"Screenshots\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
    EndIf
  
    If FileSize(path)>0
      Load_IFF(path,#IFF_IMAGE)      
    Else
      CopyImage(#IFF_BLANK,#IFF_IMAGE)
    EndIf
    
    If IsImage(#IFF_IMAGE)
      ResizeImage(#IFF_IMAGE,316, 252,IFF_Smooth)
      StartDrawing(CanvasOutput(Main_Image))
      DrawImage(ImageID(#IFF_IMAGE),0,0,316,252)
      StopDrawing()
    EndIf
    
    path=Game_Img_Path+"Covers\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"

    If FileSize(path)>0
      Load_IFF(path,#IFF_IMAGE)      
    Else
      CopyImage(#IFF_BLANK,#IFF_IMAGE)
    EndIf
    
    If IsImage(#IFF_IMAGE)
      ResizeImage(#IFF_IMAGE,316, 408,IFF_Smooth)
      StartDrawing(CanvasOutput(Cover_Image))
      DrawImage(ImageID(#IFF_IMAGE),0,0,316,408)
      StopDrawing()
    EndIf
   
  Else  
    
    StatusBarText(#MAIN_STATUS,0,"Genre: ")     
    StatusBarText(#MAIN_STATUS,1,"Publisher: ")
    StatusBarText(#MAIN_STATUS,2,"Year: ")

    CopyImage(#IFF_BLANK,#IFF_IMAGE)
    
    If IsImage(#IFF_IMAGE)
      ResizeImage(#IFF_IMAGE,316, 252,IFF_Smooth)
      StartDrawing(CanvasOutput(Main_Image))
      DrawImage(ImageID(#IFF_IMAGE),0,0,316,252)
      StopDrawing()
      ResizeImage(#IFF_IMAGE,316, 408,IFF_Smooth)
      StartDrawing(CanvasOutput(Cover_Image))
      DrawImage(ImageID(#IFF_IMAGE),0,0,316,408)
      StopDrawing()
    EndIf
    
  EndIf

  Window_Resume(#MAIN_WINDOW)
  
EndProcedure
  
Procedure Draw_List()
  
  Protected star.s, game.i, demo.i, beta.i

  SortStructuredList(IG_Database(),#PB_Sort_Ascending|#PB_Sort_NoCase,OffsetOf(IG_Data\IG_Title),TypeOf(IG_Data\IG_Title))
  
  UseGadgetList(WindowID(#MAIN_WINDOW))
  
  Window_Pause(#MAIN_WINDOW)

  ClearList(List_Numbers())
  ClearGadgetItems(Main_List)
  
  Filter_List()
  
  game=0 : demo=0 : beta=0
  
  ForEach IG_Database()
    star=""
    If IG_Database()\IG_Genre="Unknown" : star="*" : EndIf
    If IG_Database()\IG_Title<>"" And IG_Database()\IG_Filtered=#False
      AddGadgetItem(Main_List,-1,star+IG_Database()\IG_Title+Title_Extras())
      AddElement(List_Numbers())
      List_Numbers()=ListIndex(IG_Database())
    EndIf
    If IG_Database()\IG_Type="Game" : game+1 : EndIf
    If IG_Database()\IG_Type="Demo" : demo+1 : EndIf
    If IG_Database()\IG_Type="Beta" : beta+1 : EndIf
  Next
  
  If GetWindowLongPtr_(GadgetID(Main_List), #GWL_STYLE) & #WS_VSCROLL
    SetGadgetItemAttribute(Main_List,0,#PB_ListIcon_ColumnWidth,GadgetWidth(Main_List)-20)
  Else
    SetGadgetItemAttribute(Main_List,0,#PB_ListIcon_ColumnWidth,GadgetWidth(Main_List)-5)
  EndIf
  
  For count=0 To CountGadgetItems(Main_List) Step 2
    SetGadgetItemColor(Main_List,count,#PB_Gadget_BackColor,$eeeeee)
  Next
  
  SetGadgetState(Main_List,0)
  
  Window_Resume(#MAIN_WINDOW)
  
  SetActiveGadget(Main_List)
  
  Select GetGadgetState(Main_Type_Combo)
    Case 0 : count=ListSize(IG_Database())
    Case 1 : count=game
    Case 2 : count=demo
    Case 3 : count=beta
  EndSelect
  
  SetWindowTitle(#MAIN_WINDOW, W_Title+" (Showing "+Str(CountGadgetItems(Main_List))+" of "+Str(count)+" Games)")
  
  If ListSize(List_Numbers())>0
    SelectElement(List_Numbers(),0)
    Draw_Info(List_Numbers())
  Else
    Draw_Info(-1)
  EndIf
  
EndProcedure
  
Procedure.s Split_On_Capital(split_string.s)
  
  Protected s_string.s="", s_add.s="", s_asc.i
  
  For count=1 To Len(split_string)
    If count=1 : s_string+Mid(split_string,count,1) : EndIf
    If count>1
      s_asc=Asc(Mid(split_string,count,1))
      Select s_asc
          
        Case 65 To 90, 38
            s_add=" "+Mid(split_string,count,1)
          
        Default
          s_add=Mid(split_string,count,1)
          
      EndSelect
      s_string+s_add
    EndIf
        
  Next
    
  ProcedureReturn s_string
  
EndProcedure

Procedure Run_Game(gamenumber.i)
  
  DisableWindow(#MAIN_WINDOW,#True)
  
  Protected output$, gameselect$, num.i, run_icon.s
  
  SelectElement(IG_Database(), gamenumber)  
  
  If IG_Database()\IG_Default_Icon=""
    ForEach IG_Database()\IG_Icons()
      output$+IG_Database()\IG_Icons()+Chr(10)
    Next
    
    gameselect$=InputRequester("Select An Icon",output$,"")
    
    SelectElement(IG_Database()\IG_Icons(),Val(gameselect$))
    
    run_icon=IG_Database()\IG_Icons()
  Else
    
    run_icon=IG_Database()\IG_Default_Icon
    
  EndIf
  
  Protected startup_file.i, whd_lha_path.s, startup_prog.i, old_pos.i, prog_path.s, config.s
  
  old_pos=GetGadgetState(Main_List)
    
  Select IG_Database()\IG_Type
    Case "Game"
      whd_lha_path=whd_lha_game
      prog_path="Game"
    Case "Demo"
      whd_lha_path=whd_lha_demo
      prog_path="Demo"
    Case "Beta"
      whd_lha_path=whd_lha_beta
      prog_path="Beta"
  EndSelect
  
  If FileSize(whdtemp_dir)=-2 : DeleteDirectory(whdtemp_dir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force) : EndIf
  
  If CreateDirectory(whdtemp_dir)
    
    SetCurrentDirectory(whdtemp_dir)
    
    startup_file=CreateFile(#PB_Any,"whd-startup")
    
    If startup_file
      WriteString(startup_file,"cd WHD-HDD:"+#LF$)
      WriteString(startup_file,"cd "+prog_path+"/"+IG_Database()\IG_Subfolder+IG_Database()\IG_Folder+"/"+#LF$)
      WriteString(startup_file,"kgiconload "+run_icon+#LF$)
      If Close_UAE : WriteString(startup_file,"c:uaequit") : EndIf
      FlushFileBuffers(startup_file)
      CloseFile(startup_file)      
    EndIf
    
    config=""
    
    If IG_Database()\IG_CD32 : config=whd_cd32_config : Else : config=whd_uae_config : EndIf
    
    startup_prog=RunProgram(WinUAE_Path, "-f "+config+" -s filesystem2=rw,DH1:WHDTemp:"+whdtemp_dir+",0","",#PB_Program_Wait)
    
    SetCurrentDirectory(home_path)
    
    DeleteDirectory(whdtemp_dir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
    
  EndIf
  
  DisableWindow(#MAIN_WINDOW,#False)
  
  SetGadgetState(Main_List,old_pos)
  
EndProcedure

Procedure Fix_Gameslist(names_only.b=#False)
  
  If MessageRequester("Load Gameslist", "Fix Gameslist?", #PB_MessageRequester_YesNo|#PB_MessageRequester_Info)=#PB_MessageRequester_Yes
    
    SetWindowTitle(#MAIN_WINDOW, "Fixing Gameslist...")
    
    Protected NewMap sortmap.i()
    Protected NewMap genremap.s()
    
    Protected igfile2, istring.s, extras.s, folder.s, g_file.i, g_string.s
    
    st_fixed=0
    st_processed=0
    
    If ReadFile(g_file,"genres")
      
      While Not Eof(g_file)
        g_string=ReadString(g_file)
        genremap(g_string)=g_string
      Wend
      
      CloseFile(g_file) 
      
    Else
      
      MessageRequester("Error","Cannot find genres file!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
      
    EndIf
    
    ForEach Fix_List()
      sortmap(LCase(Fix_List()\F_Folder+"/"+Fix_List()\F_Slave))=ListIndex(Fix_List())
    Next
    
    ForEach IG_Database()
      st_processed+1
      If FindMapElement(sortmap(),LCase(IG_Database()\IG_Folder+IG_Database()\IG_Slave))
        SelectElement(Fix_List(),sortmap())
        If IG_Database()\IG_Title<>Fix_List()\F_Title : st_fixed+1 :EndIf
        IG_Database()\IG_Title=Trim(Fix_List()\F_Title)
        If names_only<>#True
          If FindMapElement(genremap(),Fix_List()\F_Genre)
            IG_Database()\IG_Genre=Fix_List()\F_Genre
            If IG_Database()\IG_Genre="" : IG_Database()\IG_Genre="Unknown" : EndIf
          EndIf
          IG_Database()\IG_Folder=Fix_List()\F_Folder
          IG_Database()\IG_Slave=Fix_List()\F_Slave
          IG_Database()\IG_LHAFile=Fix_List()\F_LHAFile
          IG_Database()\IG_Language=Fix_List()\F_Language
          IG_Database()\IG_Memory=Fix_List()\F_Memory
          IG_Database()\IG_AGA=Fix_List()\F_AGA
          IG_Database()\IG_NTSC=Fix_List()\F_NTSC
          IG_Database()\IG_CD32=Fix_List()\F_CD32
          IG_Database()\IG_CDTV=Fix_List()\F_CDTV
          IG_Database()\IG_CDROM=Fix_List()\F_CDROM
          IG_Database()\IG_MT32=Fix_List()\F_MT32
          IG_Database()\IG_Disks=Fix_List()\F_Disks
          IG_Database()\IG_Demo=Fix_List()\F_Demo
          IG_Database()\IG_Intro=Fix_List()\F_Intro
          IG_Database()\IG_NoIntro=Fix_List()\F_NoIntro
          IG_Database()\IG_Coverdisk=Fix_List()\F_Coverdisk
          IG_Database()\IG_Preview=Fix_List()\F_Preview
          IG_Database()\IG_Files=Fix_List()\F_Files
          IG_Database()\IG_Image=Fix_List()\F_Image
          IG_Database()\IG_Arcadia=Fix_List()\F_Arcadia
          IG_Database()\IG_Coder=Fix_List()\F_DemoMaker
          IG_Database()\IG_Type=Fix_List()\F_Type
        EndIf
        Trim(IG_Database()\IG_Title)
      EndIf
      
    Next
    
    FreeMap(sortmap())
    FreeMap(genremap())
    
  EndIf
  
EndProcedure

Procedure Check_Availability()
  
  ForEach IG_Database()
    
    Select IG_Database()\IG_Type
      Case "Game" : path=whd_lha_game
      Case "Demo" : path=whd_lha_demo
      Case "Beta" : path=whd_lha_beta
    EndSelect
    
    If FileSize(ReplaceString(path+IG_Database()\IG_Subfolder+IG_Database()\IG_LHAFile,"/","\"))>-1
      IG_Database()\IG_Available=#True
    Else
      IG_Database()\IG_Available=#False
    EndIf
    
  Next
  
EndProcedure

Procedure FillTree(*CurrentNode)
  
  Define node.s
  Define attrib.s
  Define attribval.s
  Define nodetext.s
  
  ; Ignore anything except normal nodes. See the manual for
  ; XMLNodeType() for an explanation of the other node types.
  ;
  If XMLNodeType(*CurrentNode) = #PB_XML_Normal
    
    ; Add this node to the tree. Add name and attributes
    ;
    node = GetXMLNodeName(*CurrentNode) 
    
    If ExamineXMLAttributes(*CurrentNode)
      While NextXMLAttribute(*CurrentNode)
        attrib = XMLAttributeName(*CurrentNode)
        attribval = XMLAttributeValue(*CurrentNode) 
        
        Select node          
            
          Case "machine"
            Select attrib 
              Case "name" : AddElement(Dat_Archives()) : Dat_Archives()\Arc_Type=path : Dat_Archives()\Arc_Folder=attribval
            EndSelect
            
          Case "rom"
            Select attrib 
              Case "name" : AddElement(Dat_Archives()\Arc_Names()) : Dat_Archives()\Arc_Names()=attribval
            EndSelect
            
        EndSelect   
      Wend
      
      nodetext + GetXMLNodeText(*CurrentNode)
            
    EndIf
    
    ; Now get the first child node (if any)
    
    Define *ChildNode = ChildXMLNode(*CurrentNode)
    
    ; Loop through all available child nodes and call this procedure again
    ;
    While *ChildNode <> 0
      FillTree(*ChildNode)      
      *ChildNode = NextXMLNode(*ChildNode)
    Wend        
    
  EndIf
  
EndProcedure

; ################# UPDATE

Procedure Update_Icons()
  
  Protected NewMap Folder_Check.i()
  Protected NewMap Icon_Check.i()
  
  Protected newentry.i, IG_Program.i
  Protected Folder$, Slave$ , ReadO$, Date$, Year$, Month$, Day$
  
  path=whd_lha_path
  
  ClearList(File_List())
  
  List_Files_Recursive(path,File_List(),"") ; Create Archive List
  
  ForEach IG_Database() ; Add archive list to map
    Folder_Check(LCase(IG_Database()\IG_Type+"_"+IG_Database()\IG_Folder+"/"+IG_Database()\IG_Slave))=ListIndex(IG_Database())
    Icon_Check(LCase(IG_Database()\IG_Folder))=ListIndex(IG_Database())
    ClearList(IG_Database()\IG_Icons())
  Next 
  
  OpenConsole("Scanning Archives...")
  
  ForEach File_List()
    
    If GetExtensionPart(File_List())="lha"
      IG_Program=RunProgram(LHA_Path,"l "+#DOUBLEQUOTE$+File_List()+#DOUBLEQUOTE$,GetCurrentDirectory(),#PB_Program_Open|#PB_Program_Read)
      If IG_Program
        PrintN("Processing "+GetFilePart(File_List())+" ("+ListIndex(File_List())+" of "+ListSize(File_List())+")")        
        While ProgramRunning(IG_Program)          
          If AvailableProgramOutput(IG_Program)            
            ReadO$=ReadProgramString(IG_Program)           
            ReadO$=RemoveString(ReadO$,#DOUBLEQUOTE$)           
            ReadO$=ReplaceString(ReadO$,"\", "/")
            
            If FindString(ReadO$,".slave",0,#PB_String_NoCase)
              path=LCase(Mid(ReadO$,54,Len(ReadO$)))
              path=LCase(StringField(File_List(),4,"\"))+"_"+path
              If FindMapElement(Folder_Check(),path)
                SelectElement(IG_Database(),Folder_Check())
                Date$=StringField(ReadO$,1," ")
                Year$=Right(StringField(Date$,1,"-"),2)
                Month$=StringField(Date$,2,"-")
                Day$=StringField(Date$,3,"-")
                Select Month$
                  Case "01" : Month$="Jan"
                  Case "02" : Month$="Feb"
                  Case "03" : Month$="Mar"
                  Case "04" : Month$="Apr"
                  Case "05" : Month$="May"
                  Case "06" : Month$="Jun"
                  Case "07" : Month$="Jul"
                  Case "08" : Month$="Aug"
                  Case "09" : Month$="Sep"
                  Case "10" : Month$="Oct"
                  Case "11" : Month$="Nov"
                  Case "12" : Month$="Dec"
                EndSelect
                IG_Database()\IG_Slave_Date=Day$+"-"+Month$+"-"+Year$
              EndIf
            EndIf 
            
            If FindString(ReadO$,".info",0,#PB_String_NoCase)
              If CountString(ReadO$,"/")<>1 : Continue : EndIf
              path=LCase(Mid(ReadO$,54,Len(ReadO$)))
              path=StringField(path,1,"/")
              If FindMapElement(Icon_Check(),path)
                SelectElement(IG_Database(),Icon_Check())
                AddElement(IG_Database()\IG_Icons())
                IG_Database()\IG_Icons()=GetFilePart(ReadO$)
                If GetFilePart(ReadO$,#PB_FileSystem_NoExtension)=IG_Database()\IG_Folder : IG_Database()\IG_Default_Icon=GetFilePart(ReadO$) : EndIf
              EndIf 
            EndIf               
          EndIf
        Wend 
      EndIf
    EndIf
    
    
    If GetExtensionPart(File_List())="lzx"
      IG_Program=RunProgram(LZX_Path,"-v "+#DOUBLEQUOTE$+File_List()+#DOUBLEQUOTE$,GetCurrentDirectory(),#PB_Program_Open|#PB_Program_Read)
      If IG_Program
        PrintN("Processing "+GetFilePart(File_List())+" ("+ListIndex(File_List())+" of "+ListSize(File_List())+")")
        While ProgramRunning(IG_Program)
          If AvailableProgramOutput(IG_Program)
            ReadO$=ReadProgramString(IG_Program)
            ReadO$=RemoveString(ReadO$,#DOUBLEQUOTE$)
            ReadO$=ReplaceString(ReadO$,"\", "/")
            If FindString(ReadO$,".slave",0,#PB_String_NoCase)
              path=LCase(Mid(ReadO$,49,Len(ReadO$)))
              If FindMapElement(Folder_Check(),path)
                SelectElement(IG_Database(),Folder_Check())
                Date$=Mid(ReadO$,27,12)
                Year$=Right(StringField(Date$,3,"-"),2)
                Month$=StringField(Date$,2,"-")
                Day$=Trim(StringField(Date$,1,"-"))
                If Len(Day$)=1 : day$="0"+Day$ : EndIf
                Select Month$
                  Case "jan" : Month$="Jan"
                  Case "feb" : Month$="Feb"
                  Case "mar" : Month$="Mar"
                  Case "apr" : Month$="Apr"
                  Case "may" : Month$="May"
                  Case "jun" : Month$="Jun"
                  Case "jul" : Month$="Jul"
                  Case "aug" : Month$="Aug"
                  Case "sep" : Month$="Sep"
                  Case "oct" : Month$="Oct"
                  Case "nov" : Month$="Nov"
                  Case "dec" : Month$="Dec"
                EndSelect
                IG_Database()\IG_Slave_Date=Day$+"-"+Month$+"-"+Year$
              EndIf
            EndIf
            
            If FindString(ReadO$,".info",0,#PB_String_NoCase)
              If CountString(ReadO$,"/")<>2 : Continue : EndIf
              path=LCase(Mid(ReadO$,49,Len(ReadO$)))
              path=StringField(path,1,"/")
              If FindMapElement(Icon_Check(),path) 
                SelectElement(IG_Database(),Icon_Check())
                AddElement(IG_Database()\IG_Icons())
                IG_Database()\IG_Icons()=GetFilePart(ReadO$)
                If GetFilePart(ReadO$,#PB_FileSystem_NoExtension)=IG_Database()\IG_Folder : IG_Database()\IG_Default_Icon=GetFilePart(ReadO$) : EndIf
              EndIf 
            EndIf               
          EndIf
        Wend 
      EndIf
    EndIf   
  Next
  
  Delay(2000)
  
  CloseConsole()
  
  FreeMap(Folder_Check())
  
EndProcedure

Procedure Update_FTP()
  
  ; 1. Download dat files
  ; 2. Process XML into list
  ; 3. Compare lists to PC
  ; 4. Remove/Backup Un-Needed archives
  ; 5. Download new archives, scan and update DB (Flag As unprocessed)
  ; 6. Scan Miggy and compare to DB
  ; 7. Delete uneeded directories on Miggy
  ; 8. Copy and extract new archives to miggy.
  ; 9. Cleanup

  Protected NewList Dat_List.s()
  Protected NewList XML_List.s()
  Protected NewList Delete_List.s()
  Protected NewList Down_List.s()
  Protected NewMap  Arc_Map.s()
  Protected NewMap  DB_Map.s()
  Protected NewList Comp_List.s()
  
  Protected old_pos.i, prog_path.s
  Protected main_ftp.s, tempfolder.s, ftp_server.s, ftp_user.s, ftp_pass.s, ftp_port.i, ftp_passive.b
  Protected dat_archive.i, xml_file.i    
  Protected cd_file.i, output.s, path2.s 
  Protected IG_Program.i, time.i

  tempfolder=GetTemporaryDirectory()+"um_temp\"
  main_ftp="Retroplay WHDLoad Packs"
  ftp_server="grandis.nu"
  ftp_user="mrv2k"
  ftp_pass="Amiga123"
  ftp_passive=#True
  ftp_port=21
  
  ;{ 1. Download dat files #####################################################################################################################################################################  
  
  CreateDirectory(tempfolder)
  
  OpenConsole("FTP Download")
  
  PrintNCol("***************",10,0)
  PrintNCol("*             *",10,0)
  PrintNCol("*  Updating!  *",10,0)
  PrintNCol("*             *",10,0)
  PrintNCol("***************",10,0)
  PrintN("")
  PrintNCol("Downloading Dat Files...",3,0)
  PrintN("")
  PrintNCol("Connecting To EAB FTP Server...",14,0)
  PrintN("")
  If OpenFTP(#FTP,ftp_server,ftp_user,ftp_pass,ftp_passive,ftp_port)
    PrintNCol("Connected to "+ftp_server+" on port:"+Str(ftp_port),4,0)
    PrintN("")
    If SetFTPDirectory(#FTP,main_ftp)    
      If ExamineFTPDirectory(#FTP)
        While NextFTPDirectoryEntry(#FTP)
          If FTPDirectoryEntrySize(#FTP)>0
            If FTPDirectoryEntryType(#FTP)=#PB_FTP_File
              If FindString(FTPDirectoryEntryName(#FTP),"Commodore Amiga - WHDLoad - Games") Or FindString(FTPDirectoryEntryName(#FTP),"Commodore Amiga - WHDLoad - Demos")
                PrintN("Downloading : "+FTPDirectoryEntryName(#FTP))
                If FTPDirectoryEntrySize(#FTP)>0
                  ReceiveFTPFile(#FTP,FTPDirectoryEntryName(#FTP),tempfolder+FTPDirectoryEntryName(#FTP))
                  AddElement(Dat_List())
                  Dat_List()=FTPDirectoryEntryName(#FTP)
                EndIf
              EndIf
            EndIf
          EndIf
        Wend
        FinishFTPDirectory(#FTP)
        SetFTPDirectory(#FTP,"/") 
      EndIf
    EndIf
    
    CloseFTP(#FTP)
    
    PrintN("")
    PrintNCol("Processing Dat Files...",9,0)
    
    SetCurrentDirectory(tempfolder)  
    
    ForEach Dat_List()
      dat_archive=OpenPack(#PB_Any,Dat_List(),#PB_PackerPlugin_Zip)
      If dat_archive
        If ExaminePack(dat_archive)
          While NextPackEntry(dat_archive)
            UncompressPackFile(dat_archive,PackEntryName(dat_archive))
            AddElement(XML_List())
            XML_List()=PackEntryName(dat_archive)
          Wend
        EndIf
      EndIf
      ClosePack(dat_archive)
      DeleteFile(Dat_List(),#PB_FileSystem_Force)
    Next
    ;}
  ;{ 2. Process XML into list ##################################################################################################################################################################
    
    ForEach XML_List()
      
      If FindString(XML_List(), "Demos") : path="Demo" : EndIf
      If FindString(XML_List(), "Games") And Not FindString(XML_List(), "Beta"): path="Game" : EndIf
      If FindString(XML_List(), "Beta") : path="Beta" : EndIf
      
      xml_file=LoadXML(#PB_Any, XML_List()) 
      
      If xml_file            
        If XMLStatus(xml_file) <> #PB_XML_Success
          Define Message.s = "Error in the XML file:" + Chr(13)
          Message + "Message: " + XMLError(xml_file) + Chr(13)
          Message + "Line: " + Str(XMLErrorLine(xml_file)) + "   Character: " + Str(XMLErrorPosition(xml_file))
          MessageRequester("Error", Message)
          End
        EndIf
        Define *mainnode = MainXMLNode(xml_file)
        If *MainNode
          FillTree(*MainNode)
        EndIf   
        FreeXML(xml_file) ; Free Memory  
      EndIf
      
      DeleteFile(XML_List(),#PB_FileSystem_Force)
      
    Next
    
    FreeList(Dat_List())
    FreeList(XML_List())
    
    Protected NewList Arc_List.s()
    Protected NewMap Comp_Map.s()
    
    ForEach Dat_Archives()
      ForEach Dat_Archives()\Arc_Names()
        AddElement(Arc_List())
        Arc_List()=Dat_Archives()\Arc_Type+"\"+Dat_Archives()\Arc_Folder+"\"+Dat_Archives()\Arc_Names()
        Comp_Map(Dat_Archives()\Arc_Type+"\"+Dat_Archives()\Arc_Folder+"\"+Dat_Archives()\Arc_Names())=""
      Next
    Next
    ;}
  ;{ 3. Compare lists to PC ####################################################################################################################################################################
    
    path=whd_lha_path
    
    If path<>"" 
      PrintN("")  
      PrintNCol("Scanning Folders",9,0)

      ClearList(File_List())   
      List_Files_Recursive(path,File_List(),"") ; Create Archive List
    EndIf
    
    ForEach File_List()
      Arc_Map(StringField(File_List(),4,"\")+"\"+StringField(File_List(),5,"\")+"\"+StringField(File_List(),6,"\"))=""
      AddElement(Comp_List())
      Comp_List()=StringField(File_List(),4,"\")+"\"+StringField(File_List(),5,"\")+"\"+StringField(File_List(),6,"\")
    Next

    ForEach Arc_List()
      If Not FindMapElement(Arc_Map(),Arc_List())
        AddElement(Down_List())
        Down_List()=Arc_List()
      EndIf
    Next
    
    ForEach Comp_List()
      If Not FindMapElement(Comp_Map(),Comp_List())
        AddElement(Delete_List())
        Delete_List()=Comp_List()
      EndIf
    Next
    
    FreeList(Arc_List())
    FreeList(Comp_List())
    FreeMap(Arc_Map())
    FreeMap(Comp_Map())
    
    ;}
  ;{ 4. Remove/Backup Un-Needed archives #######################################################################################################################################################
    
    If ListSize(Delete_List())>0
      
      ForEach Delete_List()
        PrintNCol("Unneeded : "+Delete_List(),2,0)
      Next
      
      PrintN("")
      PrintNCol("Delete/Backup old archives? (Y/N/B)",4,0)
      PrintN("")
      Protected answer$
      
      Repeat : answer$=Inkey() : Until answer$="Y" Or answer$="y" Or answer$="N" Or answer$="n" Or answer$="B" Or answer$="b" 
      
      SetCurrentDirectory(path)
      
      If answer$="y" Or answer$="Y"
        ForEach Delete_List()
          PrintNCol("Deleting : "+GetCurrentDirectory()+Delete_List(),4,0)
          DeleteFile(GetCurrentDirectory()+Delete_List(),#PB_FileSystem_Force)
        Next
        PrintN("")
      EndIf
      
      If answer$="n" Or answer$="N"
        PrintN("")
        PrintN("Files left in place...")
      EndIf
      
      If answer$="b" Or answer$="B"
        PrintN("")
        PrintN("Backing Up Old Files...")
        If FileSize("i:\UltraMiggy\Backup")<0 : CreateDirectory("I:\UltraMiggy\Backup") : EndIf
        ForEach Delete_List()
          PrintN("Backing Up To : "+"I:\UltraMiggy\Backup\"+GetFilePart(Delete_List()))
          CopyFile(Delete_List(),"I:\UltraMiggy\Backup\"+GetFilePart(Delete_List()))
          DeleteFile(Delete_List())
        Next
      EndIf
      
      FreeList(Delete_List())
      
    Else
      
      PrintN("")
      PrintNCol("Nothing To Delete!",2,0)
      
    EndIf
    
    ;}  
  ;{ 5. Download new archives, scan and update DB ##############################################################################################################################################
    
    If ListSize(Down_List())>0
      
      PrintN("")      
      PrintNCol("Downloading New Archives...",9,0)
      PrintN("")
      
      If OpenFTP(#FTP,ftp_server,ftp_user,ftp_pass,ftp_passive,ftp_port)
        PrintN("Connected to "+ftp_server+" on port:"+Str(ftp_port))
        PrintN("")
        
        If SetFTPDirectory(#FTP,main_ftp)    
          ForEach Down_List()       
            If StringField(Down_List(),1,"\")="Game" 
              path="Game\"
              SetFTPDirectory(#ftp,"Commodore_Amiga_-_WHDLoad_-_Games")
            EndIf
            If StringField(Down_List(),1,"\")="Demo"
              path="Demo\"
              SetFTPDirectory(#ftp,"Commodore_Amiga_-_WHDLoad_-_Demos")
            EndIf
            If StringField(Down_List(),1,"\")="Beta"
              path="Beta\"
              SetFTPDirectory(#ftp,"Commodore_Amiga_-_WHDLoad_-_Games_-_Beta_&_Unreleased")
            EndIf
            SetFTPDirectory(#FTP,StringField(Down_List(),2,"\"))
            PrintN("Downloading : " + StringField(Down_List(),3,"\"))
            ReceiveFTPFile(#FTP,StringField(Down_List(),3,"\"), whd_lha_path+path+StringField(Down_List(),2,"\")+"\"+StringField(Down_List(),3,"\"))
            FinishFTPDirectory(#FTP)
            SetFTPDirectory(#FTP,"/")
            SetFTPDirectory(#FTP,main_ftp) 
          Next
        EndIf
      Else
        PrintN("Error: Can't Connect To FTP.")
        Delay(2000)
      EndIf
      
      CloseFTP(#FTP)
      
    Else
      
      PrintN("")
      PrintNCol("Archives Up To Date!",2,0)
      
    EndIf
    
    ;}
    
  Else
    PrintN("")
    PrintNCol("Error: Can't Connect To FTP.",3,0)
  EndIf
  
  FreeList(Dat_List())
  FreeList(XML_List())
  FreeList(Delete_List())
  FreeList(Down_List())
  FreeMap(Arc_Map())
  FreeList(Comp_List())
  
  PrintN("")
  Pause_Console()
  
  CloseConsole()  
  
  Save_DB()
  
  SetCurrentDirectory(home_path)  
  
  
EndProcedure

Procedure Update_PC()
    
  Structure add_entry
    add_file.s
    add_sub.s
    add_arc.s
    add_type.s
    add_full_arc.s
    add_date.s
    List Icons2.s()
  EndStructure 
  
  Protected NewList Miggy_List.s()
  Protected NewMap  Miggy_Map.s()
  Protected NewMap  PC_Map.i()
  Protected NewList PC_List.s()  
  Protected NewMap  Folder_Check.i()   ; Folder & Slave Lookup Map 
  Protected NewList Check_List.s()     ; Not Found List Of Main DB Element Numbers
  Protected NewMap  Check_Archives.i() ; LHA Lookup Map
  Protected NewList Add_List.add_entry() ; New Additions
  Protected NewMap  Miggy_Comp_Map.s()
  Protected NewList Copy_List.i()        ; Updated Entries
  Protected NewList Delete_List.s()
  Protected NewList Icon_List.s()
  
  Protected ipath.s
  Protected cd_file.i, output.s, path2.s, startup_file.i, startup_prog.i, exit.b
  Protected IG_Program.i, time.i
  Protected ReadO$, Output$, SubFolder$, Date$, Year$, Month$, Day$, length.i
  Protected oldpath.s
  
  OpenConsole("Update Amiga")
  ConsoleCursor(0)
  
  ;{ 6. Scan Miggy and compare to DB ###########################################################################################################################################################  
  
  PrintNCol("*****************",6,0)
  PrintNCol("*               *",6,0)
  PrintNCol("*  Updating PC  *",6,0)
  PrintNCol("*               *",6,0)
  PrintNCol("*****************",6,0)
  PrintN("")
  PrintNCol("Scanning Amiga HDD...",9,0)
  PrintN("")
  PrintNCol("Starting WinUAE...",14,0)
  PrintN("")

  If FileSize(whdtemp_dir)=-2 : DeleteDirectory(whdtemp_dir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force) : EndIf
  
  If CreateDirectory(whdtemp_dir)
    SetCurrentDirectory(whdtemp_dir)
    startup_file=CreateFile(#PB_Any,"whd-startup")
    If startup_file
      WriteString(startup_file,"cd WHD-HDD:"+#LF$)
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+"Creating Folders List... Please Wait!"+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+"This could take a few minutes..."+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+"Executing Command: list DIRS ALL LFORMAT %P%N"+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"list dirs all lformat %p%n >DH1:dirs.txt"+#LF$)
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+"Executing Command: list P=#?.slave DATES ALL LFORMAT %P%N_%D"+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"list P=#?.slave DATES ALL LFORMAT %P%N_%D >DH1:slaves.txt"+#LF$)
      WriteString(startup_file,"c:uaequit")
      FlushFileBuffers(startup_file)
      CloseFile(startup_file)      
    EndIf
    startup_prog=RunProgram(WinUAE_Path, "-f "+whd_update_config+" -s filesystem2=rw,DH1:WHDTemp:"+whdtemp_dir+",0","",#PB_Program_Wait)
    If FileSize(home_path+"dirs.txt")>0 : DeleteFile(home_path+"dirs.txt") : EndIf
    CopyFile("dirs.txt",home_path+"dirs.txt")
    CopyFile("slaves.txt",home_path+"slaves.txt")
    SetCurrentDirectory(home_path)
    DeleteDirectory(whdtemp_dir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
  EndIf
  
  ForEach IG_Database() ; Copy details of archives on pc to map
    path=LCase(IG_Database()\IG_Type+"/"+IG_Database()\IG_Subfolder+IG_Database()\IG_Folder)
    PC_Map(path)=ListIndex(IG_Database())
  Next
  
  ForEach PC_Map()
    AddElement(PC_List())
    PC_List()=MapKey(PC_Map())
  Next
  
  SortList(PC_List(),#PB_Sort_Ascending)
  
  cd_file=ReadFile(#PB_Any,home_path+"dirs.txt")
  
  If cd_file
    While Not Eof(cd_file)
      output=ReadString(cd_file)
      If output="Directory is empty" : Continue : EndIf
      If CountString(output,"/")<>2 : Continue : EndIf
      output=LCase(output)
      output=RTrim(output,"/")
      AddElement(Miggy_List())
      Miggy_List()=output
    Wend
    
    SortList(Miggy_List(),#PB_Sort_Ascending)
    
    ForEach Miggy_List()
      Miggy_Map(Miggy_List())=Miggy_List()  
    Next
    
    CloseFile(cd_file)
    
  EndIf 

  ForEach Miggy_Map() ; Not Needed On Miggy
    If Not FindMapElement(PC_Map(),MapKey(Miggy_Map())) ; check to see if it's not in the map
      PrintN("Not Needed: "+MapKey(Miggy_Map()))
      AddElement(Delete_List())
      Delete_List()="WHD-HDD:"+MapKey(Miggy_Map())
    EndIf
  Next 
  
  ;}
  ;{ 7. Delete uneeded directories & extract new archives to Miggy #############################################################################################################################
  
  PrintNCol("Updating Amiga HDD...",9,0)
  PrintN("")
  
  path=whd_lha_path

  If path<>""
        
    ClearList(File_List())
    
    List_Files_Recursive(path,File_List(),"") ; Create Archive List
    
    ForEach IG_Database() ; Add archive list to map
      Folder_Check(LCase(IG_Database()\IG_Type+"_"+IG_Database()\IG_Folder))=ListIndex(IG_Database())
      Check_Archives(LCase(IG_Database()\IG_Type+"_"+IG_Database()\IG_LHAFile))
    Next     
    
    ForEach File_List() ; Delete found archives
      path2=LCase(StringField(File_List(),4,"\"))
      If Not FindMapElement(Check_Archives(),LCase(path2+"_"+GetFilePart(File_List())))
        If GetFilePart(File_List())<>"EmeraldMines_v1.0_CD.lzx" And GetFilePart(File_List())<>"DangerFreak_v1.0_0975.lha"
          AddElement(Check_List())
          Check_List()=File_List()
        EndIf
      EndIf
    Next

    If ListSize(File_List())>0  
      
      ForEach Check_List() 
        
        count=CountString(Check_List(),"\")
        SubFolder$=StringField(Check_List(),count,"\")  
        
        If GetExtensionPart(Check_List())="lha"
          length=54
          i=1
          IG_Program=RunProgram(LHA_Path,"l "+#DOUBLEQUOTE$+Check_List()+#DOUBLEQUOTE$,GetCurrentDirectory(),#PB_Program_Open|#PB_Program_Read)
        EndIf
        
        If GetExtensionPart(Check_List())="lzx"
          length=49
          i=2
          IG_Program=RunProgram(LZX_Path,"-v "+#DOUBLEQUOTE$+Check_List()+#DOUBLEQUOTE$,GetCurrentDirectory(),#PB_Program_Open|#PB_Program_Read)
        EndIf
        
        If IG_Program
          
          AddElement(Add_List())
          Add_List()\add_sub=SubFolder$
          Add_List()\add_type=StringField(Check_List(),4,"\")
          Add_List()\add_arc=GetFilePart(Check_List())
          Add_List()\add_full_arc=Check_List() 
          
          PrintN("Processing "+GetFilePart(Check_List())+" ("+ListIndex(Check_List())+" of "+ListSize(Check_List())+")")    
          
          While ProgramRunning(IG_Program) 
            
            If AvailableProgramOutput(IG_Program)  

              ReadO$=ReadProgramString(IG_Program)           
              ReadO$=RemoveString(ReadO$,#DOUBLEQUOTE$)           
              ReadO$=ReplaceString(ReadO$,"\", "/")
                            
              If FindString(ReadO$,".slave",0,#PB_String_NoCase) Or FindString(ReadO$,".info",0,#PB_String_NoCase)

                path=Mid(ReadO$,length,Len(ReadO$)) ; Cut Out Slave Path

                If CountString(path,"/")=1
                  
                  If FindString(ReadO$,".slave",0,#PB_String_NoCase)
                    
                    Add_List()\add_file=path

                    If GetExtensionPart(Check_List())="lha" ; Get Slave Date For DB
                      Date$=StringField(ReadO$,1," ")
                      Year$=Right(StringField(Date$,1,"-"),2)
                      Month$=StringField(Date$,2,"-")
                      Day$=StringField(Date$,3,"-")
                      Select Month$
                        Case "01" : Month$="Jan"
                        Case "02" : Month$="Feb"
                        Case "03" : Month$="Mar"
                        Case "04" : Month$="Apr"
                        Case "05" : Month$="May"
                        Case "06" : Month$="Jun"
                        Case "07" : Month$="Jul"
                        Case "08" : Month$="Aug"
                        Case "09" : Month$="Sep"
                        Case "10" : Month$="Oct"
                        Case "11" : Month$="Nov"
                        Case "12" : Month$="Dec"
                      EndSelect
                      Add_List()\add_date=Day$+"-"+Month$+"-"+Year$
                    EndIf
                    
                    If GetExtensionPart(Check_List())="lzx"
                      Date$=Mid(ReadO$,27,12)
                      Year$=Right(StringField(Date$,3,"-"),2)
                      Month$=StringField(Date$,2,"-")
                      Day$=Trim(StringField(Date$,1,"-"))
                      If Len(Day$)=1 : day$="0"+Day$ : EndIf
                      Select Month$
                        Case "jan" : Month$="Jan"
                        Case "feb" : Month$="Feb"
                        Case "mar" : Month$="Mar"
                        Case "apr" : Month$="Apr"
                        Case "may" : Month$="May"
                        Case "jun" : Month$="Jun"
                        Case "jul" : Month$="Jul"
                        Case "aug" : Month$="Aug"
                        Case "sep" : Month$="Sep"
                        Case "oct" : Month$="Oct"
                        Case "nov" : Month$="Nov"
                        Case "dec" : Month$="Dec"
                      EndSelect
                      Add_List()\add_date=Day$+"-"+Month$+"-"+Year$
                    EndIf
                  EndIf  
                EndIf
                
                If FindString(path,".info",0,#PB_String_NoCase)
                  If CountString(path,"/")=1
                    AddElement(Add_List()\Icons2())
                    Add_List()\Icons2()=GetFilePart(path)
                  EndIf
                EndIf
              EndIf
            EndIf
          Wend
        EndIf
      Next 
            
      ForEach Add_List()

        If FindMapElement(Folder_Check(),Add_List()\add_type+"_"+LCase(RemoveString(GetPathPart(Add_List()\add_file),"/")))
          SelectElement(IG_Database(),Folder_Check())
          IG_Database()\IG_LHAFile=Add_List()\add_arc
          IG_Database()\IG_Slave_Date=Add_List()\add_date
          ClearList(IG_Database()\IG_Icons())
          CopyList(Add_List()\Icons2(), IG_Database()\IG_Icons())
          PrintN("")
          PrintN("Choose Default Icon for "+IG_Database()\IG_Title)
          PrintN("")
          count=1
          ForEach IG_Database()\IG_Icons()
            PrintN(Str(count)+": "+IG_Database()\IG_Icons())
            count+1
          Next
          PrintN("C: Cancel")
          PrintN("")
          Print("Select a number: ")
          path=Input()

          If Val(path)>0 And Val(path)<ListSize(IG_Database()\IG_Icons())+1 And LCase(path)<>"c"
            i=Val(path)
            If i<ListSize(IG_Database()\IG_Icons())+1
              oldpath=IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
              SelectElement(IG_Database()\IG_Icons(),i-1)
              IG_Database()\IG_Default_Icon=IG_Database()\IG_Icons()
              path=IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
              RenameFile(Game_Img_Path+"Screenshots\"+oldpath,Game_Img_Path+"Screenshots\"+path)
              RenameFile(Game_Img_Path+"Covers\"+oldpath,Game_Img_Path+"Covers\"+path)
              RenameFile(oldpath,path)
            Else
              PrintN("")
              PrintNCol("Error! Invalid Number",4,0)    
              Delay(2000)
            EndIf
          Else
            If LCase(path)<>"c"
              PrintN("")
              PrintNCol("Error! Invalid Entry",4,0) 
              Delay(2000)
            EndIf    
          EndIf
        Else
          AddElement(IG_Database())
          IG_Database()\IG_Title=Split_On_Capital(RemoveString(GetPathPart(Add_List()\add_file),"/"))
          IG_Database()\IG_Folder=GetPathPart(Add_List()\add_file)
          IG_Database()\IG_Subfolder=Add_List()\add_sub+"/"
          IG_Database()\IG_Path=Main_Path+Add_List()\add_sub+"/"+GetPathPart(Add_List()\add_file)
          IG_Database()\IG_Slave=GetFilePart(Add_List()\add_file)
          AddElement(IG_Database()\IG_Icons())
          IG_Database()\IG_Icons()=GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+".info"
          IG_Database()\IG_LHAFile=Add_List()\add_arc
          IG_Database()\IG_Genre="Unknown"
          IG_Database()\IG_Favourite="0"
          IG_Database()\IG_TimesPlayed="0"
          IG_Database()\IG_LastPlayed="0"
          IG_Database()\IG_Hidden="0"
          IG_Database()\IG_Type=Add_List()\add_type
          IG_Database()\IG_Slave_Date=Add_List()\add_date
          CopyList(Add_List()\Icons2(), IG_Database()\IG_Icons())
          PrintN("")
          PrintN("Choose Default Icon for "+IG_Database()\IG_Title)
          PrintN("")
          count=1
          ForEach IG_Database()\IG_Icons()
            PrintN(Str(count)+": "+IG_Database()\IG_Icons())
            count+1
          Next
          PrintN("C: Cancel")
          PrintN("")
          Print("Select a number: ")
          path=Input()
          If Val(path)>0 And Val(path)<ListSize(IG_Database()\IG_Icons())+1 And LCase(path)<>"c"
            i=Val(path)
            If i<ListSize(IG_Database()\IG_Icons())+1
              oldpath=IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
              SelectElement(IG_Database()\IG_Icons(),i-1)
              IG_Database()\IG_Default_Icon=IG_Database()\IG_Icons()
              path=IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
              RenameFile(Game_Img_Path+"Screenshots\"+oldpath,Game_Img_Path+"Screenshots\"+path)
              RenameFile(Game_Img_Path+"Covers\"+oldpath,Game_Img_Path+"Covers\"+path)
              RenameFile(oldpath,path)
            Else
              PrintN("")
              PrintNCol("Error! Invalid Number",4,0)    
              Delay(2000)
            EndIf
          Else
            If LCase(path)<>"c"
              PrintN("")
              PrintNCol("Error! Invalid Entry",4,0) 
              Delay(2000)
            EndIf    
          EndIf
        EndIf
      Next 
      
      cd_file=ReadFile(#PB_Any,home_path+"slaves.txt")
      
      If cd_file
        While Not Eof(cd_file)
          output=ReadString(cd_file)
          Miggy_Comp_Map(LCase(output))=LCase(output)
        Wend
      EndIf
      
      CloseFile(cd_file)
      
      ClearList(Copy_List())
      
      ForEach IG_Database()      
        path2=IG_Database()\IG_Type+"/"+IG_Database()\IG_Subfolder+IG_Database()\IG_Folder+"/"+IG_Database()\IG_Slave+"_"+IG_Database()\IG_Slave_Date
        If Not FindMapElement(Miggy_Comp_Map(),LCase(path2))
          AddElement(Copy_List())
          Copy_List()=ListIndex(IG_Database())
        EndIf
      Next
      
      ForEach Copy_List()
        SelectElement(IG_Database(),Copy_List())             
        PrintN("")
        Print("Update Available: "+IG_Database()\IG_Title+Title_Extras())
        PrintNCol(" Slave Date: "+IG_Database()\IG_Slave_Date,2,0)
      Next   
      
      If ListSize(Copy_List())>0
        
        PrintN("")
        PrintN("Select Full to delete drawer and create a new one.")
        PrintN("Select Overwrite to keep drawer and overwrite files.") 
        PrintN("")
        PrintN("Update Amiga (Full/Overwrite/Cancel) (F/O/C)?")
        
        Repeat : path2=Inkey() :  Until path2="F" Or path2="f" Or path2="O" Or path2="o" Or path2="C" Or path2="c"
        
        exit=#False
        
        If path2="c" Or path2="C"   
          exit=#True
        EndIf
        
        If Not exit
          PrintNCol(#LF$+"WARNING!WARNING!WARNING!"+#LF$,4,0)
          PrintNCol("You are about to make changes to the Amiga drive! Continue (Y/N)?",15,0)
          Repeat : path=Inkey() :  Until path="Y" Or path="y" Or path="N" Or path="n"
          PrintN("")
          
          
          If path="y" Or path="Y"
            
            PrintNCol("Starting WinUAE...",14,0)
            PrintN("")
            
            output=""
            
            ForEach Delete_List()
              output+"Echo "+#DOUBLEQUOTE$+"Deleting "+Delete_List()+#DOUBLEQUOTE$+#LF$
              output+"delete "+Delete_List()+" ALL FORCE >NIL:"+#LF$
            Next
            
            output+"DH1:"+#LF$  
            
            ForEach Copy_List()
              SelectElement(IG_Database(),Copy_List())
              If path2="F" Or path2="f"
                output+"Echo "+#DOUBLEQUOTE$+"Deleting WHD-HDD:"+IG_Database()\IG_Type+"/"+IG_Database()\IG_Subfolder+IG_Database()\IG_Folder+#DOUBLEQUOTE$+#LF$
                output+"delete WHD-HDD:"+IG_Database()\IG_Type+"/"+IG_Database()\IG_Subfolder+IG_Database()\IG_Folder+" ALL FORCE >NIL:"+#LF$
                output+"Echo "+#DOUBLEQUOTE$+"Deleting WHD-HDD:"+IG_Database()\IG_Type+"/"+IG_Database()\IG_Subfolder+IG_Database()\IG_Folder+".info"+#DOUBLEQUOTE$+#LF$
                output+"delete WHD-HDD:"+IG_Database()\IG_Type+"/"+IG_Database()\IG_Subfolder+IG_Database()\IG_Folder+".info FORCE >NIL:"+#LF$
              EndIf
              output+"Echo "+#DOUBLEQUOTE$+"Extracting "+IG_Database()\IG_LHAFile+#DOUBLEQUOTE$+#LF$
              output+"xadunfile FROM "+Str(ListIndex(Copy_List()))+"."+GetExtensionPart(IG_Database()\IG_LHAFile)+"  WHD-HDD:"+IG_Database()\IG_Type+"/"+IG_Database()\IG_Subfolder+" OW Q"+#LF$
            Next
            Output$+"c:uaequit"+#LF$
                        
            If FileSize(whdtemp_dir)=-2 : DeleteDirectory(whdtemp_dir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force) : EndIf
            
            Protected result.i        
            
            If CreateDirectory(whdtemp_dir)
              SetCurrentDirectory(whdtemp_dir)
              startup_file=CreateFile(#PB_Any,"whd-startup")
              If startup_file
                WriteString(startup_file,output)
                ForEach Copy_List()
                  SelectElement(IG_Database(),Copy_List())
                  path=ReplaceString(whd_lha_path+IG_Database()\IG_Type+"\"+IG_Database()\IG_Subfolder+IG_Database()\IG_LHAFile,"/","\")
                  If GetExtensionPart(IG_Database()\IG_LHAFile)="lha"
                    result=CopyFile(path,Str(ListIndex(Copy_List()))+".lha")
                    Delay(100)
                    Continue
                  EndIf
                  If GetExtensionPart(IG_Database()\IG_LHAFile)="lzx"
                    result=CopyFile(path,Str(ListIndex(Copy_List()))+".lzx")
                    Delay(100)
                    Continue
                  EndIf                
                Next
                FlushFileBuffers(startup_file)
                CloseFile(startup_file) 
              EndIf
              startup_prog=RunProgram(WinUAE_Path, "-f "+whd_update_config+" -s filesystem2=rw,DH1:WHDTemp:"+whdtemp_dir+",0","",#PB_Program_Wait)
              SetCurrentDirectory(home_path)
              DeleteDirectory(whdtemp_dir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
            EndIf
          EndIf
        EndIf  
        
      Else
        PrintNCol("Nothing to update!",2,0)
      EndIf
    EndIf
    
  EndIf
  
  PrintN("")
  PrintNCol("Cleaning Up Database...",9,0)
  
  ForEach IG_Database()
    If FileSize(whd_lha_path+IG_Database()\IG_Type+"\"+IG_Database()\IG_Subfolder+IG_Database()\IG_LHAFile)=-1
      PrintN(IG_Database()\IG_Title+" is no longer required. Delete (Y/N/C)?")
      Repeat : path2=Inkey() :  Until path2="Y" Or path2="y" Or path2="N" Or path2="n" Or path2="C" Or path2="c"
      If path2="y" Or path2="Y"
        ConsoleColor(4,0)
        PrintN("Deleting Database Entry For "+IG_Database()\IG_Title)
        DeleteElement(IG_Database())
        If MessageRequester("Warning!", "Remove Associated Images?",#PB_MessageRequester_YesNo)=#PB_MessageRequester_Yes
          DeleteDirectory(Game_Img_Path+"Screenshots\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\","*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
          DeleteDirectory(Game_Img_Path+"Covers\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\","*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
        EndIf
        ConsoleColor(7,0)
      EndIf
      If path2="n" Or path2="N"
        Continue
      EndIf
      If path2="c" Or path2="C"
        Break
      EndIf
    EndIf
  Next
        
  ;}  
  
  PrintN("")
  Pause_Console()
  
  CloseConsole()
  
  Save_DB()
  
  Draw_List()
  
  FreeList(Miggy_List())
  FreeMap(Miggy_Map())
  FreeList(PC_List())
  FreeMap(PC_Map())
  FreeMap(Folder_Check())
  FreeMap(Check_Archives())
  FreeList(Check_List())
  FreeList(Add_List())  

EndProcedure

; ########################

Procedure.s Select_Window()
  
  Protected c_window.i, c_game_button.i, c_demo_button.i, c_beta_button.i, c_cancel_button.i, old_gadget_list, type$
  
  c_window=OpenWindow(#PB_Any, 0,0,200,120,"Select List Type...", #PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
  
  If c_window
    
    old_gadget_list=UseGadgetList(WindowID(c_window))
    
    StickyWindow(c_window,#True)
    c_game_button=ButtonGadget(#PB_Any,0,0,200,30,"Game")
    c_demo_button=ButtonGadget(#PB_Any,0,30,200,30,"Demo")
    c_beta_button=ButtonGadget(#PB_Any,0,60,200,30,"Beta / Unreleased")
    c_cancel_button=ButtonGadget(#PB_Any,0,90,200,30,"Cancel")
    
    Repeat
      event=WaitWindowEvent()
      
      Select EventGadget()
        Case c_game_button
          type$="Game"
        Case c_demo_button
          type$="Demo"
        Case c_beta_button
          type$="Beta"
        Case c_cancel_button
          type$="exit"
      EndSelect
      
    Until type$<>""
    
    UseGadgetList(old_gadget_list)   
    CloseWindow(c_window)
  EndIf
  
  ProcedureReturn(type$)
  
EndProcedure

Procedure.s Select_Window_Make()
  
  Protected c_window.i, c_folder_button.i, c_archive_button.i, c_cancel_button.i, old_gadget_list, type$
  
  c_window=OpenWindow(#PB_Any, 0,0,200,90,"Select Scan Type...", #PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
  
  If c_window
    
    old_gadget_list=UseGadgetList(WindowID(c_window))
    
    StickyWindow(c_window,#True)
    c_folder_button=ButtonGadget(#PB_Any,0,0,200,30,"Folder")
    c_archive_button=ButtonGadget(#PB_Any,0,30,200,30,"Archive")
    c_cancel_button=ButtonGadget(#PB_Any,0,60,200,30,"Cancel")
    
    Repeat
      event=WaitWindowEvent()
      
      Select EventGadget()
        Case c_folder_button
          type$="Folder"
        Case c_archive_button
          type$="Archive"
        Case c_cancel_button
          type$="exit"
      EndSelect
      
    Until type$<>""
    
    UseGadgetList(old_gadget_list)   
    CloseWindow(c_window)
  EndIf
  
  ProcedureReturn(type$)
  
EndProcedure

Procedure.s Select_Window_IFF()
  
  Protected c_window.i, c_folder_button.i, c_archive_button.i, c_tiny_button.i, c_cancel_button.i, old_gadget_list, type$
  
  c_window=OpenWindow(#PB_Any, 0,0,200,120,"Select Scan Type...", #PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
  
  If c_window
    
    old_gadget_list=UseGadgetList(WindowID(c_window))
    
    StickyWindow(c_window,#True)
    c_folder_button=ButtonGadget(#PB_Any,0,0,200,30,"Folder")
    c_archive_button=ButtonGadget(#PB_Any,0,30,200,30,"IGame")
    c_tiny_button=ButtonGadget(#PB_Any,0,60,200,30,"Tiny Launcher")
    c_cancel_button=ButtonGadget(#PB_Any,0,90,200,30,"Cancel")
    
    Repeat
      event=WaitWindowEvent()
      
      Select EventGadget()
        Case c_folder_button
          type$="Folder"
        Case c_archive_button
          type$="IGame"
        Case c_tiny_button
          type$="Tiny"
        Case c_cancel_button
          type$="exit"
      EndSelect
      
    Until type$<>""
    
    UseGadgetList(old_gadget_list)   
    CloseWindow(c_window)
  EndIf
  
  ProcedureReturn(type$)
  
EndProcedure

Procedure CreatePath(Folder.s)
   
  Protected Path.s,Temp.s
  Protected BackSlashs.i,iLoop.i
   
  BackSlashs = CountString(Folder, "\")

  For iLoop = 1 To BackSlashs + 1
    Temp = StringField(Folder, iLoop, "\")
   
    If StringField(Folder, iLoop + 1, "\") > ""
      Path + Temp + "\"
    Else
      Path + temp
    EndIf
    
    CreateDirectory(Path)
   
  Next iLoop
 
EndProcedure

Procedure Extract_IFF_Archive()
  
  Protected f_path$, f_newpath$, f_archive$, f_subfolder$, f_program.i, f_pack.i, f_output$, result.i, old_title$
  
  f_path$=PathRequester("Select Output Folder","")
  
  If f_path$<>""  
    old_title$=GetWindowTitle(#MAIN_WINDOW)
    SetCurrentDirectory(f_path$)
    f_archive$=OpenFileRequester("Select Image Archive Folder","","*.*",0)
    If GetExtensionPart(f_archive$)="zip"
      f_pack=OpenPack(#PB_Any,f_archive$,#PB_PackerPlugin_Zip)
      If ExaminePack(f_pack)
        While NextPackEntry(f_pack)
          f_newpath$=ReplaceString(GetPathPart(PackEntryName(f_pack)),"/","\")
          CreatePath(f_path$+"\"+f_newpath$)
          SetWindowTitle(#MAIN_WINDOW,"Extracting... "+f_path$+f_newpath$+GetFilePart(PackEntryName(f_pack)))
          Window_Update()
          UncompressPackFile(f_pack,f_path$+f_newpath$+GetFilePart(PackEntryName(f_pack)))
        Wend
        If GetExtensionPart(f_archive$)="lha"
          f_program=RunProgram(LHA_Path,"x "+f_archive$+" -o"+f_path$+" -y","",#PB_Program_Wait)
        EndIf
      EndIf
    EndIf
    SetWindowTitle(#MAIN_WINDOW,old_title$)
  EndIf
  
EndProcedure

Procedure IsDirEmpty(path$)
  If Right(path$, 1) <> "\": path$ + "\": EndIf
  Protected dirID = ExamineDirectory(#PB_Any, path$, "*.*")
  Protected result
 
  If dirID
    result = 1
    While NextDirectoryEntry(dirID)
      If DirectoryEntryType(dirID) = #PB_DirectoryEntry_File Or (DirectoryEntryName(dirID) <> "." And DirectoryEntryName(dirID) <> "..")
        result = 0
        Break
      EndIf 
    Wend 
    FinishDirectory(dirID)
  EndIf 
  
  ProcedureReturn result
  
EndProcedure

Procedure Audit_Images()

  Protected NewMap DB_Map.s()
  Protected NewList Delete_List.s()
  
  Protected type.s, del_dir.i, result.i
  
  OpenConsole("Check Images")  
  
  ClearList(File_List())
  
  PrintNCol("Checking Images...",9,0)  
  
  List_Files_Recursive(Game_Img_Path+"Screenshots\",File_List(),"") ; Create Archive List
  
  ForEach IG_Database()
    path=Game_Img_Path+"Screenshots\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
    DB_Map(LCase(path))=path
  Next
  
  ForEach File_List()
    If Not FindMapElement(DB_Map(),LCase(File_List()))
      DeleteFile(File_List(),#PB_FileSystem_Force)
    EndIf
    If IsDirEmpty(GetPathPart(File_List()))=1
      DeleteDirectory(GetPathPart(File_List()),"*.*",#PB_FileSystem_Force)
    EndIf
  Next

  CloseConsole()
  
  FreeMap(DB_Map())
  
  ClearList(File_List())
  
EndProcedure

Procedure Create_IFF_Archive()
  
  Protected f_path$, f_archive$, f_output$, f_pack.i, count2.i, old_title$, f_zip$, f_type$, count3.i, f_subfolder$
  
  ClearList(File_List())
  
  old_title$=GetWindowTitle(#MAIN_WINDOW)
  
  f_type$=Select_Window_IFF()
  
  f_path$=PathRequester("Select Input Folder","")
  
  If f_path$
    
    f_zip$=OpenFileRequester("Archive File","","*.zip",0)
    
    If GetExtensionPart(f_zip$)<>"zip" : f_zip$+".zip" : EndIf
    
    f_pack=CreatePack(#PB_Any,f_zip$,#PB_PackerPlugin_Zip,9)
    
    If f_pack

      For count=1 To CountString(f_path$,"\")  
        f_archive$+StringField(f_path$,count,"\")+"\"        
      Next
      
      SetWindowTitle(#MAIN_WINDOW,"Scanning Folder...")
      
      List_Files_Recursive(f_path$,File_List(),"")
      
      count=0
      
      ForEach File_List()
        If FindString(File_List(),"igame.iff")
          count+1
        EndIf
      Next
      
      count2=1
      
      ForEach File_List()
        
        If FindString(File_List(),"igame.iff")
          
          Select f_type$
              Case "Folder"
                count3=CountString(File_List(),"\")
                f_output$=StringField(File_List(),count3,"\")+".iff"
              Case "IGame"
                f_output$=RemoveString(File_List(),f_archive$)
              Case "Tiny"
                count3=CountString(File_List(),"\")
                f_output$=StringField(File_List(),count3,"\")+"_SCR0.iff"
            EndSelect
            
          AddPackFile(f_pack,File_List(),f_output$)
          Window_Update()
          SetWindowTitle(#MAIN_WINDOW,"Adding "+Str(count2)+" of "+Str(count))
          count2+1
        EndIf
        
      Next 
      
      ClosePack(f_pack)
      
    EndIf
    
  EndIf
  
  SetWindowTitle(#MAIN_WINDOW,old_title$)
  
EndProcedure

Procedure Create_IFF_Folders()
  
  Protected olddir$, outname$, newdir$, title$, result.i, response.s, category.s, source.s
  
  source=PathRequester("Select Source Folder",Game_Img_Path)  
  If source<>""
    path=PathRequester("Select Output Folder","")  
    If path<>""
      OpenConsole("Create IFF Folder")
      ConsoleCursor(0)
      EnableGraphicalConsole(#True)
      PrintNCol("Select Screenshot Type.",9,0)
      PrintN("")
      PrintN("1. Screenshot")
      PrintN("2. Cover Art")
      PrintN("3. Titles")
      PrintN("C. Cancel")
      PrintN("")
      Print("Please select a number: ")
      response=Input()
      PrintN("")
      If LCase(response)<>"c"
        If response ="1" : category="Screenshots" : EndIf
        If response ="2" : category="Covers" : EndIf
        If response ="3" : category="Titles" : EndIf
        PrintNCol("Select Output Type.",9,0)
        PrintN("")
        PrintN("1. IGame (igame.iff)")
        PrintN("2. TinyLauncher Screen (slavename_SCR0.iff)")
        PrintN("3. TinyLauncher Cover (slavename_SCR1.iff)")
        PrintN("4. TinyLauncher Title (slavename_SCR2.iff)")
        PrintN("5. AGS (slavename.iff)")
        PrintN("6. Duplicate")
        PrintN("C. Cancel")
        PrintN("")
        Print("Please select a number: ")
        response=Input()
        ClearConsole()
        If LCase(response)<>"c"
          If path<>""
            SetCurrentDirectory(path)
            ForEach IG_Database()
              
              While WindowEvent() : Wend
              
              ConsoleLocate(0,0)
              PrintN("Processing: "+Str(ListIndex(IG_Database())+1)+" of "+Str(ListSize(IG_Database())))
              CreateDirectory(category)
              SetCurrentDirectory(category)
              CreateDirectory(IG_Database()\IG_Type)
              SetCurrentDirectory(GetCurrentDirectory()+IG_Database()\IG_Type)
              olddir$=source+category+"\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"          
              
              If response="1"
                CreateDirectory(ReplaceString(IG_Database()\IG_Subfolder,"/","\"))
                SetCurrentDirectory(GetCurrentDirectory()+ReplaceString(IG_Database()\IG_Subfolder,"/","\"))
                CreateDirectory(GetCurrentDirectory()+IG_Database()\IG_Folder)
                newdir$=path+category+"\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"
                SetCurrentDirectory(newdir$)
                result=CopyFile(olddir$,"igame.iff")    
              EndIf
              
              If response="2"
                result=CopyFile(olddir$,GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+"_SCR0.iff")   
              EndIf
              
              If response="3"
                result=CopyFile(olddir$,GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+"_SCR1.iff")   
              EndIf
              
              If response="4"
                result=CopyFile(olddir$,GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+"_SCR2.iff")   
              EndIf
              
              If response="5"
                result=CopyFile(olddir$,GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+".iff")
              EndIf  
              
              If response="6"
                CreateDirectory(ReplaceString(IG_Database()\IG_Subfolder,"/","\"))
                SetCurrentDirectory(GetCurrentDirectory()+ReplaceString(IG_Database()\IG_Subfolder,"/","\"))
                CreateDirectory(GetCurrentDirectory()+IG_Database()\IG_Folder)
                newdir$=path+category+"\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"
                SetCurrentDirectory(newdir$)
                result=CopyFile(olddir$,GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff")    
              EndIf 
              
              SetCurrentDirectory(path)
            Next
          EndIf
        EndIf
      EndIf

      SetCurrentDirectory(home_path)
      PrintN("")
      Pause_Console()
      CloseConsole()
      
    EndIf
  EndIf
  
EndProcedure

Procedure Create_Game_Folder()
  
  Protected f_path$, f_archive$, f_subfolder$, f_program.i
    
  f_path$=PathRequester("Select Output Folder","")
  
  If f_path$ <>""
    
    f_archive$=PathRequester("Select Archive Folder","")
    
    If f_archive$<>"" :  List_Files_Recursive(f_archive$,File_List(),"") : EndIf
    
    OpenConsole()
    
    ForEach File_List()
      
      count=CountString(File_List(),"\")
      f_subfolder$=StringField(File_List(),count,"\")
      
      PrintN("Processing "+GetFilePart(File_List()))
      
       If GetExtensionPart(File_List())="lha"
         f_program=RunProgram(LHA_Path,"x "+#DOUBLEQUOTE$+File_List()+#DOUBLEQUOTE$+" -o"+f_path$+f_subfolder$+"\ -y","",#PB_Program_Wait|#PB_Program_Hide)
       EndIf
      
      If GetExtensionPart(File_List())="lzx"
        CopyFile(File_List(),f_path$+f_subfolder$+"\"+GetFilePart(File_List()))
        f_program=RunProgram(LZX_Path,"-x "+GetFilePart(File_List()),f_path$+f_subfolder$,#PB_Program_Wait|#PB_Program_Hide)
        If FileSize(f_path$+f_subfolder$+"\"+GetFilePart(File_List()))>0
          DeleteFile(f_path$+f_subfolder$+"\"+GetFilePart(File_List()),#PB_FileSystem_Force)
        EndIf
      EndIf
      
    Next      
    
    CloseConsole()
    
  EndIf
  
  ClearList(File_List())
  
EndProcedure  

Procedure Create_Gameslist_Folder()

  Protected NewList Unknown.s()
  Protected IG_Program.i, LHA_File.s, LZX_File.s, time.i
  Protected Found.b
  Protected ReadO$, Output$, SubFolder$, c_path$
  
  c_path$=Select_Window()
  
  If c_path$<>"exit"
    
    ClearList(IG_Database())
    
    path=PathRequester("WHDLoad Path",Main_Path)
    
    List_Type=c_path$
    
    If path<>"" And 
       
      SetWindowTitle(#MAIN_WINDOW,"Scanning Folders")
      
      ClearList(File_List())
      
      List_Files_Recursive(path,File_List(),"") ; Create Archive List
      
      time=ElapsedMilliseconds()
      
      ForEach File_List()      
        If FindString(File_List(),".slave",0,#PB_String_NoCase)
          count=CountString(File_List(),"\")
          If FindString(File_List(),"\data\",#PB_String_NoCase)=0 And FindString(File_List(),"/data/",#PB_String_NoCase)=0
            AddElement(IG_Database())
            IG_Database()\IG_Title=GetFilePart(File_List(),#PB_FileSystem_NoExtension)
            IG_Database()\IG_Slave=StringField(File_List(),count+1,"\")
            IG_Database()\IG_Folder=StringField(File_List(),count,"\")+"/"
            IG_Database()\IG_Subfolder=StringField(File_List(),count-1,"\")+"/"
            IG_Database()\IG_Path=IG_Database()\IG_Subfolder+IG_Database()\IG_Folder
            IG_Database()\IG_LHAFile="Folder"
            IG_Database()\IG_Genre="Unknown"
            IG_Database()\IG_Favourite="0"
            IG_Database()\IG_TimesPlayed="0"
            IG_Database()\IG_LastPlayed="0"
            IG_Database()\IG_Hidden="0"
            IG_Database()\IG_Type=c_path$
          EndIf
        EndIf
      Next      
    EndIf
  EndIf
  
  If ListSize(IG_Database())>0
    Set_Menu(#False)
    Draw_List()
    If MessageRequester("Amiga Path","Set Amiga WHD Path?",#PB_MessageRequester_Info|#PB_MessageRequester_YesNo)=#PB_MessageRequester_Yes
      PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_13)
    EndIf
  EndIf
  
EndProcedure

Procedure Create_Gameslist()
  
  Structure InfoStruct
    LHAName.s
    SlaveName.s
    SubFolder.s
    List InfoList.s()
  EndStructure
  
  Protected NewList Unknown.s()
  Protected NewList InfoTemp.InfoStruct()
  Protected IG_Program.i, LHA_File.s, LZX_File.s, time.i
  Protected ReadO$, Output$, SubFolder$, c_path$
  
  c_path$=Select_Window()
  
  If c_path$<>"exit"
    
    ClearList(IG_Database())
    
    path=PathRequester("WHDLoad Path",Main_Path)
    
    List_Type=c_path$
    
    If path<>"" And 
       
      SetWindowTitle(#MAIN_WINDOW,"Scanning Folders")
      
      ClearList(File_List())
      
      List_Files_Recursive(path,File_List(),"") ; Create Archive List
      
      time=ElapsedMilliseconds()
      
      OpenConsole("Scanning Archives...")
      
      ForEach File_List()
        
        If GetExtensionPart(File_List())="lha"
          IG_Program=RunProgram(LHA_Path,"l "+#DOUBLEQUOTE$+File_List()+#DOUBLEQUOTE$,GetCurrentDirectory(),#PB_Program_Open|#PB_Program_Read)
        EndIf
        
        If GetExtensionPart(File_List())="lzx"
          IG_Program=RunProgram(LZX_Path,"-v "+#DOUBLEQUOTE$+File_List()+#DOUBLEQUOTE$,GetCurrentDirectory(),#PB_Program_Open|#PB_Program_Read)
        EndIf
        
        If IG_Program
          
          PrintN("Processing "+GetFilePart(File_List())+" ("+ListIndex(File_List())+" of "+ListSize(File_List())+")")
          
          AddElement(InfoTemp())
          InfoTemp()\LHAName=GetFilePart(File_List())
          
          count=CountString(File_List(),"\")
          InfoTemp()\SubFolder=StringField(File_List(),count,"\")
          
          While ProgramRunning(IG_Program)
            
            If AvailableProgramOutput(IG_Program)
              
              ReadO$=ReadProgramString(IG_Program)
              
              ReadO$=RemoveString(ReadO$,#DOUBLEQUOTE$)
              
              ReadO$=ReplaceString(ReadO$,"\", "/")
              
              If FindString(ReadO$,".info",0,#PB_String_NoCase)
                If FindString(ReadO$,"Manual.info",0,#PB_String_NoCase) : Continue : EndIf
                If FindString(ReadO$,"ReadMe.info",0,#PB_String_NoCase) : Continue : EndIf
                If FindString(ReadO$,"Hints.info",0,#PB_String_NoCase) : Continue : EndIf
                If FindString(ReadO$,"Instructions.info",0,#PB_String_NoCase) : Continue : EndIf
                If FindString(ReadO$,"Solution.info",0,#PB_String_NoCase) : Continue : EndIf
                If FindString(ReadO$,"QuickDocs.info",0,#PB_String_NoCase) : Continue : EndIf
                If FindString(ReadO$,"Docs.info",0,#PB_String_NoCase) : Continue : EndIf
                If FindString(ReadO$,"Codes.info",0,#PB_String_NoCase) : Continue : EndIf
                If FindString(ReadO$,"Cheat.info",0,#PB_String_NoCase) : Continue : EndIf
                If FindString(ReadO$,"Tips.info",0,#PB_String_NoCase) : Continue : EndIf
                If FindString(ReadO$,"Lists.info",0,#PB_String_NoCase) : Continue : EndIf
                If FindString(ReadO$,"Spells.info",0,#PB_String_NoCase) : Continue : EndIf
                If FindString(ReadO$,"Keys.info",0,#PB_String_NoCase) : Continue : EndIf
                If FindString(ReadO$,"Map.info",0,#PB_String_NoCase) : Continue : EndIf
                If FindString(ReadO$,"Refs.info",0,#PB_String_NoCase) : Continue : EndIf
                If CountString(ReadO$,"/")<>1 : Continue : EndIf
                AddElement(InfoTemp()\InfoList())
                InfoTemp()\InfoList()=GetFilePart(ReadO$)  
              EndIf               
              
              If FindString(ReadO$,".slave",0,#PB_String_NoCase)
                If CountString(ReadO$,"/")<>1 : Continue : EndIf
                count=CountString(ReadO$," ")
                InfoTemp()\SlaveName=StringField(ReadO$,count+1," ")
              EndIf
              
            EndIf
            
          Wend
          
        EndIf
        
      Next
      
      ForEach InfoTemp()
        AddElement(IG_Database())
        Output$=InfoTemp()\SlaveName
        Subfolder$=InfoTemp()\SubFolder
        IG_Database()\IG_Title=RemoveString(GetPathPart(Output$),"/")
        IG_Database()\IG_Folder=GetPathPart(Output$)
        IG_Database()\IG_Subfolder=SubFolder$+"/"
        IG_Database()\IG_Path=SubFolder$+"/"+GetPathPart(Output$)
        IG_Database()\IG_Slave=GetFilePart(Output$)
        IG_Database()\IG_LHAFile=InfoTemp()\LHAName
        IG_Database()\IG_Genre="Unknown"
        IG_Database()\IG_Favourite="0"
        IG_Database()\IG_TimesPlayed="0"
        IG_Database()\IG_LastPlayed="0"
        IG_Database()\IG_Hidden="0"
        IG_Database()\IG_Type=c_path$
        ForEach InfoTemp()\InfoList()
          AddElement(IG_Database()\IG_Icons())
          IG_Database()\IG_Icons()=InfoTemp()\InfoList()
        Next
        
      Next
      
      PrintN("")
      PrintN("Found "+Str(ListSize(IG_Database()))+" slave files in "+Str((ElapsedMilliseconds()-time)/1000)+" Seconds.")
      PrintN("")
      PrintN("Scan Complete...")
      
      Delay(2000)
      
      CloseConsole()
      
    EndIf
  EndIf
  
  If ListSize(IG_Database())>0
    Set_Menu(#False)
    Draw_List()
    If MessageRequester("Amiga Path","Set Amiga WHD Path?",#PB_MessageRequester_Info|#PB_MessageRequester_YesNo)=#PB_MessageRequester_Yes
      PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_13)
    EndIf
  EndIf
  
EndProcedure

Procedure Check_Missing_Images(type.i)
  
  Protected path2.s
  
  ForEach IG_Database()  
    IG_Database()\IG_Image_Avail=#False
    IG_Database()\IG_Cover_Avail=#False

    If type=1
      path=Game_Img_Path+"Screenshots\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
      If FileSize(path)>0
        IG_Database()\IG_Image_Avail=#True
      Else
        IG_Database()\IG_Image_Avail=#False
      EndIf
    EndIf
    
    If type=2
      path2=Game_Img_Path+"Covers\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
      If FileSize(path2)>0
        IG_Database()\IG_Cover_Avail=#True
      Else
        IG_Database()\IG_Cover_Avail=#False
      EndIf
    EndIf
    
    If type=3
      path=Game_Img_Path+"Titles\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
      If FileSize(path)>0
        IG_Database()\IG_Title_Avail=#True
      Else
        IG_Database()\IG_Title_Avail=#False
      EndIf
    EndIf
    
  Next
  
EndProcedure

Procedure Image_Popup(type.i)
  
  Protected popup_imagegadget, pevent, popup_image, ww.i, wh.i
  
  SelectElement(List_Numbers(),GetGadgetState(Main_List))
  SelectElement(IG_Database(),List_Numbers())
  
  DisableWindow(#MAIN_WINDOW,#True)
  
  If type=1
    If TitleScreen
      path=Game_Img_Path+"Titles\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
    Else
      path=Game_Img_Path+"Screenshots\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
    EndIf
    ww=480 : wh=384
  EndIf
  
  If type=2
    path=Game_Img_Path+"Covers\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+".iff"
    ww=480 : wh=620
  EndIf

  Load_IFF(path,#IFF_POPUP)
  
  If IsImage(#IFF_POPUP)
    ResizeImage(#IFF_POPUP,DpiX(ww), DpiY(wh),IFF_Smooth)
    StartDrawing(ImageOutput(#IFF_POPUP))
    DrawingMode(#PB_2DDrawing_Outlined)
    Box(0,0,ww-1,wh-1,#Black)
    StopDrawing()
    SetGadgetState(Main_Image,ImageID(#IFF_POPUP))
    
    If OpenWindow(#POPUP_WINDOW,0,0,ww,wh,"",#PB_Window_BorderLess|#PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
      StickyWindow(#POPUP_WINDOW,#True)
      SetClassLongPtr_(WindowID(#POPUP_WINDOW),#GCL_STYLE,$00020000) ; Add Drop Shadow
      ImageGadget(popup_imagegadget,0,0,ww,wh,ImageID(#IFF_POPUP))
      
      Repeat 
        pevent=WaitWindowEvent()
        
        If pevent=#WM_KEYDOWN
          If EventwParam() = #VK_ESCAPE
            Break
          EndIf
        EndIf
        
        If EventGadget() = popup_imagegadget
          If EventType()=#PB_EventType_LeftDoubleClick
            Break
          EndIf
        EndIf
      ForEver
      
      CloseWindow(#POPUP_WINDOW)
      FreeImage(#IFF_POPUP)
      DisableWindow(#MAIN_WINDOW,#False)
      SetActiveGadget(Main_List)
      
    EndIf
  EndIf

EndProcedure

Procedure Path_Window()
  
  Protected Path_Game_String, Path_Demo_String, Path_Beta_String, Path_LHA_String, Path_LZX_String, Path_Temp_String, Path_UAE_String, Path_Game_Button, Path_Demo_Button
  Protected Path_Beta_Button, Path_LHA_Button, Path_LZX_Button, Path_Temp_Button, Path_UAE_Button, Path_WinUAE_String, Path_WinUAE_Button
  Protected Path_Genres_Button, Path_Genres_String, Path_Database_Button, Path_Database_String, Path_CD32_Button, Path_CD32_String
  Protected Path_Amiga_String, Path_Amiga_Button, Path_IGame_String, Path_IGame_Button, Path_Game_LHA_String, Path_Demo_LHA_String, Path_Beta_LHA_String, Path_Game_LHA_Button, Path_Demo_LHA_Button, Path_Beta_LHA_Button
  Protected old_pos, old_gadget_list, Path_Update_String, Path_Update_Button
  Protected change.b=#False

  old_pos=GetGadgetState(Main_List)
  
  If OpenWindow(#PATH_WINDOW, 0, 0, 490, 490, "IG_Tool Paths", #PB_Window_SystemMenu|#PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
    
    old_gadget_list=UseGadgetList(WindowID(#PATH_WINDOW))
    
    Path_Game_String = StringGadget(#PB_Any, 130, 10, 300, 20, Game_Img_Path, #PB_String_ReadOnly)
    Path_Game_Button = ButtonGadget(#PB_Any, 440, 10, 40, 20, "Set")
;     Path_Demo_String = StringGadget(#PB_Any, 130, 40, 300, 20, Demo_Img_Path, #PB_String_ReadOnly)
;     Path_Demo_Button = ButtonGadget(#PB_Any, 440, 40, 40, 20, "Set")
;     Path_Beta_String = StringGadget(#PB_Any, 130, 70, 300, 20, Beta_Img_Path, #PB_String_ReadOnly)
;     Path_Beta_Button = ButtonGadget(#PB_Any, 440, 70, 40, 20, "Set")
    Path_LHA_String = StringGadget(#PB_Any, 130, 100, 300, 20, LHA_Path, #PB_String_ReadOnly)
    Path_LHA_Button = ButtonGadget(#PB_Any, 440, 100, 40, 20, "Set")
    Path_LZX_String = StringGadget(#PB_Any, 130, 130, 300, 20, LZX_Path, #PB_String_ReadOnly)
    Path_LZX_Button = ButtonGadget(#PB_Any, 440, 130, 40, 20, "Set")
    Path_Temp_String = StringGadget(#PB_Any, 130, 160, 300, 20, whdtemp_dir, #PB_String_ReadOnly)
    Path_Temp_Button = ButtonGadget(#PB_Any, 440, 160, 40, 20, "Set")
    Path_UAE_String = StringGadget(#PB_Any, 130, 190, 300, 20, whd_uae_config, #PB_String_ReadOnly)
    Path_UAE_Button = ButtonGadget(#PB_Any, 440, 190, 40, 20, "Set")
    Path_CD32_String = StringGadget(#PB_Any, 130, 220, 300, 20, whd_cd32_config, #PB_String_ReadOnly)
    Path_CD32_Button = ButtonGadget(#PB_Any, 440, 220, 40, 20, "Set")
    Path_WinUAE_String = StringGadget(#PB_Any, 130, 250, 300, 20, WinUAE_Path, #PB_String_ReadOnly)
    Path_WinUAE_Button = ButtonGadget(#PB_Any, 440, 250, 40, 20, "Set")
    Path_Game_LHA_String = StringGadget(#PB_Any, 130, 280, 300, 20, whd_lha_path, #PB_String_ReadOnly)
    Path_Game_LHA_Button = ButtonGadget(#PB_Any, 440, 280, 40, 20, "Set")
    Path_IGame_String = StringGadget(#PB_Any, 130, 370, 300, 20, IGame_Path, #PB_String_ReadOnly)
    Path_IGame_Button = ButtonGadget(#PB_Any, 440, 370, 40, 20, "Set")
    Path_Genres_String = StringGadget(#PB_Any, 130, 400, 300, 20, Genres_Path, #PB_String_ReadOnly)
    Path_Genres_Button = ButtonGadget(#PB_Any, 440, 400, 40, 20, "Set")
    Path_Database_String = StringGadget(#PB_Any, 130, 430, 300, 20, DB_Path, #PB_String_ReadOnly)
    Path_Database_Button = ButtonGadget(#PB_Any, 440, 430, 40, 20, "Set")
    Path_Update_String = StringGadget(#PB_Any, 130, 460, 300, 20, whd_update_config, #PB_String_ReadOnly)
    Path_Update_Button = ButtonGadget(#PB_Any, 440, 460, 40, 20, "Set")

    TextGadget(#PB_Any, 10, 10, 110, 20, "Game Image Folder", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 40, 110, 20, "Demo Image Folder", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 70, 110, 20, "Beta Image Folder", #PB_Text_Right) 
    TextGadget(#PB_Any, 10, 100, 110, 30, "LHA Archiver", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 130, 110, 20, "LZX Archiver", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 160, 110, 20, "Temp Folder", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 190, 110, 20, "A1200 Config Path", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 220, 110, 20, "CD32 Config Path", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 250, 110, 20, "WinUAE Path", #PB_Text_Right) 
    TextGadget(#PB_Any, 10, 280, 110, 20, "WHD LHA Path", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 370, 110, 20, "IGame Path", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 400, 110, 20, "Genres Path", #PB_Text_Right)    
    TextGadget(#PB_Any, 10, 430, 110, 20, "Database Path", #PB_Text_Right)   
    TextGadget(#PB_Any, 10, 460, 110, 20, "Update Config Path", #PB_Text_Right) 

    Repeat
      
      event=WaitWindowEvent()
      
      Select event
          
        Case #PB_Event_Gadget
          Select EventGadget()
              
            Case Path_Game_Button
              path=PathRequester("Game Image Path",Game_Img_Path)
              If path<>"" : Game_Img_Path=path : SetGadgetText(Path_Game_String,Game_Img_Path) : change=#True : EndIf
;             Case Path_Demo_Button
;               path=OpenFileRequester("Demo Image Path",Demo_Img_Path,"*.zip",0)
;               If path<>"" : Demo_Img_Path=path : SetGadgetText(Path_Demo_String,Demo_Img_Path) : change=#True : EndIf
;             Case Path_Beta_Button
;               path=OpenFileRequester("Beta Image Path",Beta_Img_Path,"*.zip",0)
;               If path<>"" : Beta_Img_Path=path : SetGadgetText(Path_Beta_String,Beta_Img_Path) : change=#True : EndIf
            Case Path_LHA_Button
              path=OpenFileRequester("LHA Path",LHA_Path,"*.exe",0)
              If path<>"" : LHA_Path=path : SetGadgetText(Path_LHA_String,LHA_Path) : change=#True : EndIf
            Case Path_LZX_Button
              path=OpenFileRequester("LZX Path",LZX_Path,"*.exe",0)
              If path<>"" : LZX_Path=path : SetGadgetText(Path_LZX_String,LZX_Path) : change=#True : EndIf
            Case Path_Temp_Button
              path=PathRequester("Temp Path",whdtemp_dir)
              If path<>"" : whdtemp_dir=path : SetGadgetText(Path_Temp_String,whdtemp_dir) : change=#True : EndIf
            Case Path_UAE_Button
              path=OpenFileRequester("UAE Config Path",whd_uae_config,"*.uae",0)
              If path<>"" : whd_uae_config=path : SetGadgetText(Path_UAE_String,whd_uae_config) : change=#True : EndIf
            Case Path_Update_Button
              path=OpenFileRequester("Update Config Path",whd_update_config,"*.uae",0)
              If path<>"" : whd_update_config=path : SetGadgetText(Path_Update_String,whd_update_config) : change=#True : EndIf
            Case Path_CD32_Button
              path=OpenFileRequester("UAE Config Path",whd_cd32_config,"*.uae",0)
              If path<>"" : whd_cd32_config=path : SetGadgetText(Path_CD32_String,whd_cd32_config) : change=#True : EndIf
            Case Path_Game_LHA_Button
              path=PathRequester("WHD LHA Folder Path",whd_lha_path)
              If path<>"" : whd_lha_path=path : SetGadgetText(Path_Game_LHA_String,whd_lha_path) : change=#True : EndIf    
            Case Path_IGame_Button
              path=PathRequester("IGame Folder Path",IGame_Path)
              If path<>"" : IGame_Path=path : SetGadgetText(Path_IGame_String,IGame_Path) : change=#True : EndIf
            Case Path_WinUAE_Button
              path=OpenFileRequester("WinUAE Path",WinUAE_Path,"*.exe",0)
              If path<>"" : WinUAE_Path=path : SetGadgetText(Path_WinUAE_String,WinUAE_Path) : change=#True : EndIf
            Case Path_Genres_Button
              path=PathRequester("WinUAE Path",Genres_Path)
              If path<>"" : Genres_Path=path : SetGadgetText(Path_Genres_String,Genres_Path) : change=#True : EndIf
            Case Path_Database_Button
              path=PathRequester("Database Path",DB_Path)
              If path<>"" : DB_Path=path : SetGadgetText(Path_Database_String,DB_Path) : change=#True : EndIf
          EndSelect                
          
          
        Case #PB_Event_CloseWindow  
          Break
      EndSelect
      
    ForEver
    
    If change
      If MessageRequester("Save","Save Changes?",#PB_MessageRequester_Info|#PB_MessageRequester_YesNo)=#PB_MessageRequester_Yes
        Save_Prefs()
      EndIf
    EndIf
    
    
    UseGadgetList(old_gadget_list) 
    
    CloseWindow(#PATH_WINDOW)
    
  EndIf

EndProcedure

Procedure Load_DB()
  
  Protected lFileSize, lFile, lUncompressedSize, lJSON, *lJSONBufferCompressed, *lJSONBuffer
  
  path="um_full"
  
  ClearList(Fix_List())

;   lFileSize = FileSize(path+".dat")
;   If lFileSize
;     lFile = ReadFile(#PB_Any, path+".dat")
;     If lFile
;       *lJSONBufferCompressed = AllocateMemory(lFileSize)
;       *lJSONBuffer = AllocateMemory(lFileSize*60)       
;       ReadData(lFile, *lJSONBufferCompressed, lFileSize)
;       lUncompressedSize = UncompressMemory(*lJSONBufferCompressed, lFileSize, *lJSONBuffer, lFileSize*60, #PB_PackerPlugin_Zip)
;       lJSON = CatchJSON(#PB_Any, *lJSONBuffer, lUncompressedSize)
;       FreeMemory(*lJSONBuffer)
;       FreeMemory(*lJSONBufferCompressed)
;       CloseFile(lFile)
;       ExtractJSONList(JSONValue(lJSON), Fix_List()) 
;     EndIf
;   Else
    ;MessageRequester("Error", "Select JSON Backup!", #PB_MessageRequester_Error|#PB_MessageRequester_Ok)   
    path+".json"
    If path<>""
      lfile=LoadJSON(#PB_Any, path, #PB_JSON_NoCase)
      ExtractJSONList(JSONValue(lfile), Fix_List())
    EndIf
;   EndIf  
  
  If ListSize(Fix_List())>0
    Process_DB()
  EndIf
  
  Check_Availability()
  
EndProcedure

Procedure Process_DB()
  ForEach Fix_List()
    AddElement(IG_Database())
    IG_Database()\IG_Folder=Fix_List()\F_Folder
    IG_Database()\IG_SubFolder=Fix_List()\F_SubFolder
    IG_Database()\IG_LHAFile=Fix_List()\F_LHAFile
    IG_Database()\IG_NTSC=Fix_List()\F_NTSC
    IG_Database()\IG_Language=Fix_List()\F_Language
    IG_Database()\IG_NoIntro=Fix_List()\F_NoIntro
    IG_Database()\IG_Arcadia=Fix_List()\F_Arcadia
    IG_Database()\IG_CD32=Fix_List()\F_CD32
    IG_Database()\IG_CDTV=Fix_List()\F_CDTV
    IG_Database()\IG_Path=Fix_List()\F_Path
    IG_Database()\IG_Slave=Fix_List()\F_Slave
    IG_Database()\IG_Slave_Date=Fix_List()\F_Slave_Date
    IG_Database()\IG_MT32=Fix_List()\F_MT32
    IG_Database()\IG_AGA=Fix_List()\F_AGA
    IG_Database()\IG_Coder=Fix_List()\F_DemoMaker
    IG_Database()\IG_Genre=Fix_List()\F_Genre
    IG_Database()\IG_Preview=Fix_List()\F_Preview
    IG_Database()\IG_Type=Fix_List()\F_Type
    IG_Database()\IG_Intro=Fix_List()\F_Intro
    IG_Database()\IG_CDROM=Fix_List()\F_CDROM
    IG_Database()\IG_Memory=Fix_List()\F_Memory
    IG_Database()\IG_Coverdisk=Fix_List()\F_Coverdisk
    IG_Database()\IG_Demo=Fix_List()\F_Demo
    IG_Database()\IG_Disks=Fix_List()\F_Disks
    IG_Database()\IG_Files=Fix_List()\F_Files
    IG_Database()\IG_Image=Fix_List()\F_Image
    IG_Database()\IG_Title=Fix_List()\F_Title
    IG_Database()\IG_Year=Fix_List()\F_Year
    IG_Database()\IG_Default_Icon=Fix_List()\F_Default_Icon
    ForEach Fix_List()\F_Icons()
      AddElement(IG_Database()\IG_Icons())
      IG_Database()\IG_Icons()=Fix_List()\F_Icons()
    Next
  Next
EndProcedure

Procedure Save_DB()
    
  ClearList(Fix_List())
  
  path="um_full"
  
  If path<>""
    
    ForEach IG_Database()
      AddElement(Fix_List())
      Fix_List()\F_Title=IG_Database()\IG_Title      
      Fix_List()\F_Genre=IG_Database()\IG_Genre
      If FindString(IG_Database()\IG_Folder,"/",0,#PB_String_NoCase): IG_Database()\IG_Folder=RTrim(IG_Database()\IG_Folder,"/") : EndIf
      Fix_List()\F_Folder=IG_Database()\IG_Folder
      Fix_List()\F_SubFolder=IG_Database()\IG_Subfolder
      Fix_List()\F_Path=IG_Database()\IG_Path
      Fix_List()\F_Slave=IG_Database()\IG_Slave
      Fix_List()\F_Slave_Date=IG_Database()\IG_Slave_Date
      Fix_List()\F_LHAFile=IG_Database()\IG_LHAFile
      Fix_List()\F_Language=IG_Database()\IG_Language
      Fix_List()\F_Memory=IG_Database()\IG_Memory
      Fix_List()\F_AGA=IG_Database()\IG_AGA
      Fix_List()\F_NTSC=IG_Database()\IG_NTSC
      Fix_List()\F_CD32=IG_Database()\IG_CD32
      Fix_List()\F_CDTV=IG_Database()\IG_CDTV
      Fix_List()\F_CDROM=IG_Database()\IG_CDROM
      Fix_List()\F_MT32=IG_Database()\IG_MT32
      Fix_List()\F_Disks=IG_Database()\IG_Disks
      Fix_List()\F_Demo=IG_Database()\IG_Demo
      Fix_List()\F_Intro=IG_Database()\IG_Intro
      Fix_List()\F_NoIntro=IG_Database()\IG_NoIntro
      Fix_List()\F_Coverdisk=IG_Database()\IG_Coverdisk
      Fix_List()\F_Preview=IG_Database()\IG_Preview
      Fix_List()\F_Files=IG_Database()\IG_Files
      Fix_List()\F_Image=IG_Database()\IG_Image
      Fix_List()\F_Arcadia=IG_Database()\IG_Arcadia
      Fix_List()\F_DemoMaker=IG_Database()\IG_Coder
      Fix_List()\F_Type=IG_Database()\IG_Type
      Fix_List()\F_Year=IG_Database()\IG_Year
      ForEach IG_Database()\IG_Icons()
        AddElement(Fix_List()\F_Icons())
        Fix_List()\F_Icons()=IG_Database()\IG_Icons()
      Next
      Fix_List()\F_Default_Icon=IG_Database()\IG_Default_Icon
    Next
    
    Protected lFileSize, lFile, lJSONCompressedSize, lFileJSON, lJSON, lJSONSize, *lJSONBufferCompressed, *lJSONBuffer
    
    lJSON = CreateJSON(#PB_Any)
    
    If lJSON
      InsertJSONList(JSONValue(lJSON), Fix_List())
      lJSONSize = ExportJSONSize(lJSON)
      *lJSONBuffer = AllocateMemory(lJSONSize)
      *lJSONBufferCompressed = AllocateMemory(lJSONSize)
      ExportJSON(lJSON, *lJSONBuffer, lJSONSize)
      lJSONCompressedSize = CompressMemory(*lJSONBuffer, lJSONSize, *lJSONBufferCompressed, lJSONSize, #PB_PackerPlugin_Zip)
      lFileJSON = CreateFile(#PB_Any, home_path+path+".dat")
      WriteData(lFileJSON, *lJSONBufferCompressed, lJSONCompressedSize)
      CloseFile(lFileJSON)
      FreeJSON(lJSON)
      FreeMemory(*lJSONBuffer)
      FreeMemory(*lJSONBufferCompressed )
    EndIf 
    
    If JSON_Backup
      lJSON = CreateJSON(#PB_Any)
      InsertJSONList(JSONValue(lJSON), Fix_List())
      SaveJSON(lJSON,home_path+path+".json",#PB_JSON_PrettyPrint)
      FreeJSON(lJSON)
    EndIf
    
  EndIf
  
  ClearList(Fix_List())
  
EndProcedure

Procedure Load_GL()
  
  Protected o_path$
  
  o_path$=Select_Window()
  
  If o_path$<>"exit"
    
    path=OpenFileRequester("Open "+o_path$+" List","","*.*",0)
    
    List_Type=o_path$  
    
    ClearList(IG_Database())
    
    st_removed=0
    
    If path<>""
      
      SetWindowTitle(#MAIN_WINDOW, "Loading Gameslist...")
      
      Protected NewList removed_list.s()
      
      Protected igfile, count
      Protected instring.s, ipath.s, ifile.s
      
      If ReadFile(igfile,path)
        
        While Not Eof(igfile)
          
          Select GetExtensionPart(path)
              
            Case "csv"
              instring=ReadString(igfile)
              AddElement(IG_Database())
              IG_Database()\IG_Language=""
              IG_Database()\IG_AGA=0
              IG_Database()\IG_CD32=0
              IG_Database()\IG_NTSC=0
              IG_Database()\IG_CDTV=0
              IG_Database()\IG_LHAFile=""
              IG_Database()\IG_Genre="Unknown"            
              IG_Database()\IG_Title=Trim(StringField(instring,2,";"))
              IG_Database()\IG_Genre=StringField(instring,3,";")
              IG_Database()\IG_Path=GetPathPart(StringField(instring,4,";"))
              IG_Database()\IG_Slave=GetFilePart(StringField(instring,4,";"))
              count=CountString(IG_Database()\IG_Path,"/")
              IG_Database()\IG_Folder=StringField(IG_Database()\IG_Path,count,"/")
              IG_Database()\IG_Folder+"/"
              IG_Database()\IG_SubFolder=StringField(IG_Database()\IG_Path,count-1,"/")
              IG_Database()\IG_Subfolder+"/"
              If count-2>0
                Main_Path=StringField(IG_Database()\IG_Path,count-2,"/")+"/"
              EndIf
              
              IG_Database()\IG_Favourite=StringField(instring,5,";")
              IG_Database()\IG_TimesPlayed=StringField(instring,6,";")
              IG_Database()\IG_LastPlayed=StringField(instring,7,";")
              IG_Database()\IG_Hidden=StringField(instring,8,";")
              
            Case ""
              count=2
              instring=ReadString(igfile)
              If instring="" : Continue : EndIf
              If FindString(instring,"title=")
                AddElement(IG_Database())
                IG_Database()\IG_Language=""
                IG_Database()\IG_Coder=""
                IG_Database()\IG_AGA=0
                IG_Database()\IG_CD32=0
                IG_Database()\IG_NTSC=0
                IG_Database()\IG_CDTV=0
                IG_Database()\IG_Genre="Unknown"
                IG_Database()\IG_Title=Trim(Right(instring,Len(instring)-FindString(instring,"=")))
              EndIf
              
              If FindString(instring,"genre=")
                IG_Database()\IG_Genre=Right(instring,Len(instring)-FindString(instring,"="))
              EndIf
              
              If FindString(instring,"path=")
                IG_Database()\IG_Path=GetPathPart(Right(instring,Len(instring)-FindString(instring,"=")))
                count=CountString(IG_Database()\IG_Path,"/")
                IG_Database()\IG_Folder=StringField(IG_Database()\IG_Path,count,"/")+"/"
                Main_Path=StringField(IG_Database()\IG_Path,count-2,"/")+"/"
                IG_Database()\IG_Slave=GetFilePart(Right(instring,Len(instring)-FindString(instring,"=")))
              EndIf     
              
              If FindString(instring,"favorite=")
                IG_Database()\IG_Favourite=Right(instring,Len(instring)-FindString(instring,"="))
              EndIf
              If FindString(instring,"timesplayed=")
                IG_Database()\IG_TimesPlayed=Right(instring,Len(instring)-FindString(instring,"="))
              EndIf
              If FindString(instring,"lastplayed=")
                IG_Database()\IG_LastPlayed=Right(instring,Len(instring)-FindString(instring,"="))
              EndIf
              If FindString(instring,"hidden=")
                IG_Database()\IG_Hidden=Right(instring,Len(instring)-FindString(instring,"="))
              EndIf
              
            Case "db"
              instring=ReadString(igfile)
              count=CountString(instring,Chr(1))
              j=1
              For i=1 To count
                Select J
                  Case 1
                    text$=Trim(StringField(instring,i,Chr(1)))
                    AddElement(IG_Database())
                    IG_Database()\IG_Path=text$
                    k=CountString(IG_Database()\IG_Path,"/")
                    IG_Database()\IG_Folder=StringField(IG_Database()\IG_Path,k+1,"/")
                    IG_Database()\IG_Folder+"/"
                    IG_Database()\IG_SubFolder=StringField(IG_Database()\IG_Path,k,"/")
                    IG_Database()\IG_Subfolder+"/"
                    j+1
                  Case 2
                    text$=Trim(StringField(instring,i,Chr(1)))
                    IG_Database()\IG_Slave=text$
                    j+1
                  Case 3
                    text$=Trim(StringField(instring,i,Chr(1)))
                    IG_Database()\IG_Title=text$
                    j=1
                EndSelect

              Next
              
              
          EndSelect
          
        Wend
        
        ForEach IG_Database()
          If IG_Database()\IG_Path=""
            DeleteElement(IG_Database())
            Continue
          EndIf
          count=CountString(IG_Database()\IG_Path,"/")
          If StringField(IG_Database()\IG_Path,count,"/")="data" ; Clear dupe slaves in data folder
            st_removed+1
            DeleteElement(IG_Database())
          EndIf
        Next
        
        CloseFile(igfile) 
        
        If ListSize(IG_Database())>0            
          Fix_Gameslist()
          Message_RequesterEx("Results", "Processed: "+Str(st_processed)+#LF$+"Fixed: "+Str(st_fixed)+#LF$+"Removed: "+Str(st_removed),125)
          SetWindowTitle(#MAIN_WINDOW, W_Title+" (Showing "+Str(CountGadgetItems(Main_List))+" of "+Str(ListSize(IG_Database()))+" Games)")
          Set_Menu(#False)
          Draw_List()
          Draw_Info(0)
          SetActiveGadget(Main_List)
          SetGadgetState(Main_List,0)
        Else
          MessageRequester("Error","Error Loading Gameslist",#PB_MessageRequester_Ok|#PB_MessageRequester_Error)
          SetWindowTitle(#MAIN_WINDOW, W_Title)
        EndIf
      Else
        MessageRequester("Error","Error Reading File",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
      EndIf
      
    EndIf
    
  EndIf

EndProcedure

Procedure Merge_Lists()
  
  Protected NewList Merge_Files.s()
  
  Protected merge_file$, output$, merge_output.i, merge_input.i, merge_name$
  
  merge_file$=OpenFileRequester("Select Files","","*.csv",0,#PB_Requester_MultiSelection)
  
  If merge_file$<>""
       
    While merge_file$
      AddElement(Merge_Files())
      Merge_Files()=merge_file$
      merge_file$=NextSelectedFileName()
    Wend
    
    merge_name$=OpenFileRequester("Merged File Name","","*.csv",0)
    
    If GetExtensionPart(merge_name$)<>"csv" : merge_name$+".csv" : EndIf
    
    If merge_name$<>""
      If CreateFile(0,merge_name$,#PB_Ascii)  
        ForEach Merge_Files()
          If ReadFile(1,Merge_Files(),#PB_Ascii)
            While Not Eof(1)
              output$=ReadString(1)
              WriteStringN(0,output$)
            Wend
            CloseFile(1)
          Else
            MessageRequester("Error","Could Not Create File!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
          EndIf
        Next
        CloseFile(0)
        If FileSize(merge_name$)>0
          MessageRequester("Success",GetFilePart(merge_name$)+" created!",#PB_MessageRequester_Ok)
        EndIf
      EndIf
    EndIf
  EndIf
  
  FreeList(Merge_Files())
  
EndProcedure

Procedure Save_GL(path.s)
  
  If path<>""
    
    Protected igfile3
    
    If CreateFile(igfile3, path,#PB_Ascii)
      ForEach IG_Database()
        WriteString(igfile3,"index=0"+#LF$)
        WriteString(igfile3,"title="+IG_Database()\IG_Title+Title_Extras()+#LF$)
        WriteString(igfile3,"genre="+IG_Database()\IG_Genre+#LF$)
        WriteString(igfile3,"path="+IG_Database()\IG_Path+IG_Database()\IG_Slave+#LF$)
        WriteString(igfile3,"favorite="+IG_Database()\IG_Favourite+#LF$)
        WriteString(igfile3,"timesplayed="+IG_Database()\IG_TimesPlayed+#LF$)
        WriteString(igfile3,"lastplayed="+IG_Database()\IG_LastPlayed+#LF$)
        WriteString(igfile3,"hidden="+IG_Database()\IG_Hidden+#LF$)
        WriteString(igfile3,#LF$)
      Next
      
      CloseFile(igfile3)
      
    EndIf
    
  EndIf
  
EndProcedure

Procedure Save_GL_CSV(path.s)
  
  If path<>""
    
    If GetExtensionPart(path)<>"csv"  
      path+".csv"
    EndIf
    
    Protected igfile3, output$
    
    If CreateFile(igfile3, path,#PB_Ascii)
      ForEach IG_Database()
        output$="0;"
        output$+IG_Database()\IG_Title+Title_Extras()+";"
        output$+IG_Database()\IG_Genre+";"
        output$+"WHD-HDD:"+IG_Database()\IG_Type+"/"+IG_Database()\IG_Subfolder+IG_Database()\IG_Folder+"/"+IG_Database()\IG_Slave+";"
        output$+"0;0;0;0"
;         output$+IG_Database()\IG_Favourite+";"
;         output$+IG_Database()\IG_TimesPlayed+";"
;         output$+IG_Database()\IG_LastPlayed+";"
;         output$+IG_Database()\IG_Hidden
        WriteString(igfile3,output$+#LF$)
      Next
      
      CloseFile(igfile3)
      
    EndIf
    
  EndIf
  
EndProcedure

Procedure Save_GL_TinyLaunch(path.s)
  
  If path<>""
    
    SortStructuredList(IG_Database(),#PB_Sort_Ascending|#PB_Sort_NoCase,OffsetOf(IG_Data\IG_Slave),TypeOf(IG_Data\IG_Slave))
    
    If GetExtensionPart(path)<>"db"  
      path+".db"
    EndIf
      
    Protected igfile3, path$, slave$, title$, output$
    
    If CreateFile(igfile3, path,#PB_Ascii)
      ForEach IG_Database()
        path$=LSet(Trim(IG_Database()\IG_Path,"/")+Chr(1),128)
        slave$=LSet(IG_Database()\IG_Slave+Chr(1),42)
        If Len(IG_Database()\IG_Title)>48
          title$=Left(IG_Database()\IG_Title,46)+Chr(1)+" "
        Else
          title$=LSet(IG_Database()\IG_Title+Chr(1),48)
        EndIf
        output$+path$+slave$+title$
      Next
      
      WriteString(igfile3,output$)
      
      CloseFile(igfile3)
      
    EndIf
    
    SortStructuredList(IG_Database(),#PB_Sort_Ascending|#PB_Sort_NoCase,OffsetOf(IG_Data\IG_Title),TypeOf(IG_Data\IG_Title))
    
  EndIf
  
EndProcedure

Procedure Save_Prefs()
  CreatePreferences(home_path+"igtool.prefs")
  PreferenceGroup("Paths")
  WritePreferenceString("Game_Img_Path",Game_Img_Path)
;   WritePreferenceString("Demo_Img_Path",Demo_Img_Path)
;   WritePreferenceString("Beta_Img_Path",Beta_Img_Path)
  WritePreferenceString("LHA_Path",LHA_Path)
  WritePreferenceString("LZX_Path",LZX_Path)
  WritePreferenceString("Temp_Path",whdtemp_dir)
  WritePreferenceString("UAECFG_Path",whd_uae_config)
  WritePreferenceString("CD32CFG_Path",whd_cd32_config)
  WritePreferenceString("UpdateCFG_Path",whd_update_config)
  WritePreferenceString("WHD_LHA_Path",whd_lha_path)
  WritePreferenceString("IGame_Path",IGame_Path)
  WritePreferenceString("WinUAE_Path",WinUAE_Path)
  WritePreferenceString("Genres_Path",Genres_Path)
  WritePreferenceString("Database_Path",DB_Path)
  WritePreferenceLong("IFF_Smooth",IFF_Smooth)
  WritePreferenceLong("JSON_Backup",JSON_Backup)
  ClosePreferences()
EndProcedure

Procedure Load_Prefs()
  OpenPreferences(home_path+"igtool.prefs")
  PreferenceGroup("Paths")
  Game_Img_Path=ReadPreferenceString("Game_Img_Path",Game_Img_Path)
;   Demo_Img_Path=ReadPreferenceString("Demo_Img_Path",Demo_Img_Path)
;   Beta_Img_Path=ReadPreferenceString("Beta_Img_Path",Beta_Img_Path)
  LHA_Path=ReadPreferenceString("LHA_Path",LHA_Path)
  LZX_Path=ReadPreferenceString("LZX_Path",LZX_Path)
  whdtemp_dir=ReadPreferenceString("Temp_Path",whdtemp_dir)
  whd_uae_config=ReadPreferenceString("UAECFG_Path",whd_uae_config)
  whd_update_config=ReadPreferenceString("UpdateCFG_Path",whd_update_config)
  whd_cd32_config=ReadPreferenceString("CD32CFG_Path",whd_cd32_config)
  whd_lha_path=ReadPreferenceString("WHD_LHA_Path",whd_lha_path)
  IGame_Path=ReadPreferenceString("IGame_Path",IGame_Path)
  WinUAE_Path=ReadPreferenceString("WinUAE_Path",WinUAE_Path)
  Genres_Path=ReadPreferenceString("Genres_Path",Genres_Path)
  DB_Path=ReadPreferenceString("Database_Path",DB_Path)
  IFF_Smooth=ReadPreferenceLong("IFF_Smooth",#PB_Image_Raw)
  JSON_Backup=ReadPreferenceLong("JSON_Backup",JSON_Backup)
  ClosePreferences()
EndProcedure

Procedure Choose_Icon()
  
  Protected NewList Icon_List.s()
  
  Protected IG_Program.i
  Protected ReadO$, oldpath.s
  
  path=whd_lha_path+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")
  
  OpenConsole("Scanning : "+IG_Database()\IG_LHAFile)
  IG_Program=RunProgram(LHA_Path,"l "+path+IG_Database()\IG_LHAFile,GetCurrentDirectory(),#PB_Program_Open|#PB_Program_Read)
  If IG_Program     
    While ProgramRunning(IG_Program)          
      If AvailableProgramOutput(IG_Program)            
        ReadO$=ReadProgramString(IG_Program)           
        ReadO$=RemoveString(ReadO$,#DOUBLEQUOTE$)           
        ReadO$=ReplaceString(ReadO$,"\", "/")                      
        If FindString(ReadO$,".info",0,#PB_String_NoCase)
          If CountString(ReadO$,"/")<>1 : Continue : EndIf
          If GetExtensionPart(IG_Database()\IG_LHAFile)="lha" : i=54 : EndIf
          If GetExtensionPart(IG_Database()\IG_LHAFile)="lzx" : i=49 : EndIf
          path=LCase(Mid(ReadO$,i,Len(ReadO$)))
          path=StringField(path,1,"/")
          AddElement(Icon_List())
          Icon_List()=GetFilePart(ReadO$)
        EndIf 
      EndIf               
    Wend 
  EndIf  
    
  PrintN("Please select a default icon...")
  PrintN("")
  
  ClearList(IG_Database()\IG_Icons())
  
  CopyList(Icon_List(),IG_Database()\IG_Icons())
  
  count=1
  
  ForEach Icon_List()
    PrintN(Str(count)+": "+Icon_List())
    count+1
  Next
  PrintN("C: Cancel")
  PrintN("")
  Print("Select a number: ")
  
  path=Input()
  
  If Val(path)>0 And Val(path)<ListSize(Icon_List())+1 And LCase(path)<>"c"
    
    i=Val(path)
    
    If i<ListSize(Icon_List())+1
      oldpath=IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
      SelectElement(Icon_List(),i-1)
      IG_Database()\IG_Default_Icon=Icon_List()
      path=IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
      RenameFile(Game_Img_Path+"Screenshots\"+oldpath,Game_Img_Path+"Screenshots\"+path)
      RenameFile(Game_Img_Path+"Covers\"+oldpath,Game_Img_Path+"Covers\"+path)
      RenameFile(oldpath,path)
    Else
      ConsoleColor(4,0)
      PrintN("")
      PrintN("Error! Invalid Number")    
      Delay(2000)
    EndIf
  Else
    If LCase(path)<>"c"
      ConsoleColor(4,0)
      PrintN("")
      PrintN("Error! Invalid Entry") 
      Delay(2000)
    EndIf    
  EndIf
  
  CloseConsole()
  
  FreeList(Icon_List())
  
EndProcedure

Procedure Edit_GL(number) 
  
  SelectElement(IG_Database(),number)
  
  ClearList(Genre_List.s())
  
  Protected change.b=#False, oldindex.s, star.s
  Protected old_gadget_list, old_pos, title_string, language_string, path_string, Frame_0, AGA_Check, CD32_Check,  Preview_Check, Files_Check, Image_Check, NoIntro_Check, Date_String, icon_string, icon_button
  Protected CDTV_Check, MT32_Check, Memory_String, Genre_Combo, CDROM_Check, Arcadia_Check, Demo_Check, Intro_Check, Cover_Check, NTSC_Check, Disk_String, Coder_String, Type_Combo, File_Button, Update_Button
  Protected Year_String
  
  old_pos=GetGadgetState(Main_List)
  
  DisableWindow(#MAIN_WINDOW,#True)
  
  If OpenWindow(#EDIT_WINDOW, 0, 0, 430, 316, "Edit Database", #PB_Window_SystemMenu | #PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
    
    old_gadget_list=UseGadgetList(WindowID(#EDIT_WINDOW))
    
    TextGadget(#PB_Any, 8, 8, 64, 24, "Title", #PB_Text_Center)
    TextGadget(#PB_Any, 8, 40, 64, 24, "Genre", #PB_Text_Center)
    TextGadget(#PB_Any, 8, 72, 64, 24, "Language", #PB_Text_Center) 
    FrameGadget(#PB_Any, 8, 96, 416, 124, "")
    title_string = StringGadget(#PB_Any, 80, 8, 344, 24, "")
    Genre_Combo = ComboBoxGadget(#PB_Any, 80, 40, 344, 24)
    language_string = StringGadget(#PB_Any, 80, 72, 344, 24, "")
    AGA_Check = CheckBoxGadget(#PB_Any, 16, 112, 56, 24, "AGA")
    CD32_Check = CheckBoxGadget(#PB_Any, 88, 112, 56, 24, "CD32")
    CDTV_Check = CheckBoxGadget(#PB_Any, 152, 112, 64, 24, "CDTV")
    MT32_Check = CheckBoxGadget(#PB_Any, 216, 112, 56, 24, "MT32")
    CDROM_Check = CheckBoxGadget(#PB_Any, 288, 112, 64, 24, "CD-ROM")
    NTSC_Check = CheckBoxGadget(#PB_Any, 368, 112, 48, 24, "NTSC")
    Arcadia_Check = CheckBoxGadget(#PB_Any, 16, 136, 56, 24, "Arcadia")
    Demo_Check = CheckBoxGadget(#PB_Any, 88, 136, 56, 24, "Demo")
    Intro_Check = CheckBoxGadget(#PB_Any, 152, 136, 64, 24, "Intro")
    NoIntro_Check = CheckBoxGadget(#PB_Any, 216, 136, 72, 24, "No Intro")
    Memory_String = StringGadget(#PB_Any, 352, 138, 64, 19, "")
    Preview_Check = CheckBoxGadget(#PB_Any, 16, 160, 64, 24, "Preview")
    Files_Check = CheckBoxGadget(#PB_Any, 88, 160, 56, 24, "Files")
    Image_Check = CheckBoxGadget(#PB_Any, 152, 160, 56, 24, "Image")
    Cover_Check = CheckBoxGadget(#PB_Any, 216, 160, 72, 24, "Coverdisk")
    Disk_String = StringGadget(#PB_Any, 352, 163, 64, 19, "")
    Coder_String = StringGadget(#PB_Any, 220, 188, 196, 19, "")
    Type_Combo = ComboBoxGadget(#PB_Any, 60, 190, 100, 20)
    path_string = StringGadget(#PB_Any, 10, 230, 290, 24, "")
    date_string = StringGadget(#PB_Any, 310, 230, 110, 24, IG_Database()\IG_Slave_Date)
    icon_string = StringGadget(#PB_Any, 10, 262,290,24,IG_Database()\IG_Default_Icon)

    icon_button = ButtonGadget(#PB_Any, 310,262,110,24,"Choose")
    Coder_String = StringGadget(#PB_Any, 10, 290, 290,24,IG_Database()\IG_Coder)
    year_string = StringGadget(#PB_Any, 310, 290, 110, 24, IG_Database()\IG_Year)

    TextGadget(#PB_Any, 288, 139, 56, 24, "Memory", #PB_Text_Right)
    TextGadget(#PB_Any, 288, 165, 56, 24, "Disks", #PB_Text_Right)
    TextGadget(#PB_Any, 148, 191, 56, 24, "Coder", #PB_Text_Right)
    TextGadget(#PB_Any, 18, 191, 32, 24, "Type", #PB_Text_Center)
    
    AddGadgetItem(Type_Combo,-1,"Unknown")
    AddGadgetItem(Type_Combo,-1,"Game")
    AddGadgetItem(Type_Combo,-1,"Demo")
    AddGadgetItem(Type_Combo,-1,"Beta")
    
    If ReadFile(g_file,"genres")
      
      While Not Eof(g_file)
        AddElement(Genre_List())
        Genre_List()=ReadString(g_file)
      Wend
      
      CloseFile(g_file)
      
      ForEach Genre_List()
        AddGadgetItem(Genre_Combo,-1,Genre_List())
      Next
      
      SetGadgetState(Genre_Combo,0)
      
      ForEach Genre_List()
        If Genre_List()=IG_Database()\IG_Genre
          SetGadgetState(Genre_Combo,ListIndex(Genre_List()))
          Break     
        EndIf
      Next  
      
    Else
      
      MessageRequester("Error","Cannot find genres file!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
      
    EndIf
    
    SetGadgetText(path_string,IG_Database()\IG_LHAFile)
    SetGadgetText(title_string,IG_Database()\IG_Title)
    SetGadgetText(language_string,IG_Database()\IG_Language)
    SetGadgetText(Memory_String,IG_Database()\IG_Memory)
    SetGadgetText(Disk_String,IG_Database()\IG_Disks)
    SetGadgetText(Coder_String,IG_Database()\IG_Coder)
    SetGadgetState(AGA_Check,IG_Database()\IG_AGA)
    SetGadgetState(CD32_Check,IG_Database()\IG_CD32)
    SetGadgetState(CDTV_Check,IG_Database()\IG_CDTV)
    SetGadgetState(MT32_Check,IG_Database()\IG_MT32)
    SetGadgetState(Cover_Check,IG_Database()\IG_Coverdisk)
    SetGadgetState(CDROM_Check,IG_Database()\IG_CDROM)
    SetGadgetState(Arcadia_Check,IG_Database()\IG_Arcadia)
    SetGadgetState(Demo_Check,IG_Database()\IG_Demo)
    SetGadgetState(Intro_Check,IG_Database()\IG_Intro)
    SetGadgetState(NoIntro_Check,IG_Database()\IG_NoIntro)
    SetGadgetState(NTSC_Check,IG_Database()\IG_NTSC)
    SetGadgetState(Preview_Check,IG_Database()\IG_Preview)
    SetGadgetState(Files_Check,IG_Database()\IG_Files)
    SetGadgetState(Image_Check,IG_Database()\IG_Image)
    SetGadgetState(NoIntro_Check,IG_Database()\IG_NoIntro)
    
    Select IG_Database()\IG_Type
      Case ""
        SetGadgetState(Type_Combo,0)
      Case "Game"
        SetGadgetState(Type_Combo,1)
      Case "Demo"
        SetGadgetState(Type_Combo,2)
      Case "Beta"
        SetGadgetState(Type_Combo,3)
    EndSelect
    
    SetActiveGadget(title_string)
    
    oldindex=IG_Database()\IG_Title
    
    Repeat
      event=WaitWindowEvent()
      
      Select event
          
        Case #WM_KEYDOWN
          If EventwParam() = #VK_ESCAPE
            Break
          EndIf
          
        Case #PB_Event_Menu
          Select EventMenu()
          EndSelect
          
        Case #PB_Event_Gadget
          Select EventGadget()
            Case title_string
              If EventType()=#PB_EventType_Change
                IG_Database()\IG_Title=GetGadgetText(title_string)
                change=#True
              EndIf
            Case Coder_String
              If EventType()=#PB_EventType_Change
                IG_Database()\IG_Coder=GetGadgetText(Coder_String)
                change=#True
              EndIf
            Case path_String
              If EventType()=#PB_EventType_Change
                IG_Database()\IG_Coder=GetGadgetText(path_String)
                change=#True
              EndIf
            Case Date_String
              If EventType()=#PB_EventType_Change
                IG_Database()\IG_Slave_Date=GetGadgetText(Date_String)
                change=#True
              EndIf
            Case Genre_Combo
              IG_Database()\IG_Genre=GetGadgetText(Genre_Combo)
              change=#True
            Case Type_Combo
              IG_Database()\IG_Type=GetGadgetText(Type_Combo)
              change=#True
            Case language_string
              If EventType()=#PB_EventType_Change
                IG_Database()\IG_Language=GetGadgetText(language_string)
                change=#True
              EndIf
            Case AGA_Check
              IG_Database()\IG_AGA=GetGadgetState(AGA_Check)
              change=#True
            Case CD32_Check
              IG_Database()\IG_CD32=GetGadgetState(CD32_Check)
              change=#True
            Case CDTV_Check
              IG_Database()\IG_CDTV=GetGadgetState(CDTV_Check)
              change=#True
            Case CDROM_Check
              IG_Database()\IG_CDROM=GetGadgetState(CDROM_Check)
              change=#True
            Case Arcadia_Check
              IG_Database()\IG_Arcadia=GetGadgetState(Arcadia_Check)
              change=#True
            Case MT32_Check
              IG_Database()\IG_MT32=GetGadgetState(MT32_Check)
              change=#True
            Case NTSC_Check
              IG_Database()\IG_NTSC=GetGadgetState(NTSC_Check)
              change=#True
            Case Cover_Check
              IG_Database()\IG_Coverdisk=GetGadgetState(Cover_Check)
              change=#True
            Case Demo_Check
              IG_Database()\IG_Demo=GetGadgetState(Demo_Check)
              change=#True
            Case Intro_Check
              IG_Database()\IG_Intro=GetGadgetState(Intro_Check)
              change=#True
            Case NoIntro_Check
              IG_Database()\IG_NoIntro=GetGadgetState(NoIntro_Check)
              change=#True
            Case Image_Check
              IG_Database()\IG_Image=GetGadgetState(Image_Check)
              change=#True
            Case Files_Check
              IG_Database()\IG_Files=GetGadgetState(Files_Check)
              change=#True
            Case Memory_String
              If EventType()=#PB_EventType_Change
                IG_Database()\IG_Memory=GetGadgetText(Memory_String)
                change=#True
              EndIf
            Case Disk_String
              If EventType()=#PB_EventType_Change
                IG_Database()\IG_Disks=GetGadgetText(Disk_String)
                change=#True
              EndIf
            Case Coder_String
              If EventType()=#PB_EventType_Change
                IG_Database()\IG_Coder=GetGadgetText(Coder_String)
                change=#True
              EndIf
              Case Year_String
              If EventType()=#PB_EventType_Change
                IG_Database()\IG_Year=GetGadgetText(Year_String)
                change=#True
              EndIf
            Case icon_string
              If EventType()=#PB_EventType_Change
                IG_Database()\IG_Default_Icon=GetGadgetText(icon_string)
                change=#True
              EndIf
            Case icon_button
              Choose_Icon()
              SetGadgetText(icon_string,IG_Database()\IG_Default_Icon)
              change=#True
            Case File_Button
              path=OpenFileRequester("Select File", "", "*.*",0)
              If path<>""
                IG_Database()\IG_LHAFile=GetFilePart(path)
                SetGadgetText(path_string,GetFilePart(path))
              EndIf
            Case Update_Button
              text$=InputRequester("Set Path", "Update Folder & Slave Path",IG_Database()\IG_Folder+"/"+IG_Database()\IG_Slave)
              IG_Database()\IG_Folder=GetPathPart(text$)
              IG_Database()\IG_Folder=RTrim(IG_Database()\IG_Folder,"/")
              IG_Database()\IG_Slave=GetFilePart(text$)
              count=CountString(IG_Database()\IG_Path,"/")
              IG_Database()\IG_Path=RemoveString(IG_Database()\IG_Path,IG_Database()\IG_Folder)
              IG_Database()\IG_Path=RTrim(IG_Database()\IG_Path,"/")
              IG_Database()\IG_Path+"/"+IG_Database()\IG_Folder+"/"
          EndSelect
          
        Case #PB_Event_CloseWindow  
          Break
          
      EndSelect
      
    ForEver
    
    UseGadgetList(old_gadget_list) 
    
    CloseWindow(#EDIT_WINDOW)  
    
    DisableWindow(#MAIN_WINDOW,#False)
    
    If change 
      If IG_Database()\IG_Genre="Unknown" : star="*" : Else : star="" : EndIf
      SetGadgetItemText(Main_List,old_pos,star+IG_Database()\IG_Title+Title_Extras())
      Update_StatusBar()
      Save_DB()
    EndIf
        
    SetActiveGadget(Main_List)
    
    SetGadgetState(Main_List,old_pos)
    
  EndIf
  
EndProcedure

Procedure Draw_Main_Window()
   
  Protected g_file.i
  
  OpenWindow(#MAIN_WINDOW, 0, 0, 836, 790, W_Title , #PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_MinimizeGadget|#PB_Window_Invisible)
  
  CreateStatusBar(#MAIN_STATUS,WindowID(#MAIN_WINDOW))
  AddStatusBarField(350)
  AddStatusBarField(300)
  AddStatusBarField(186)
  
  CreateMenu(Main_Menu, WindowID(#MAIN_WINDOW))
  MenuTitle("File")
  MenuItem(#MenuItem_29, "Run Game")
  MenuBar()
  MenuItem(#MenuItem_4, "Save Gameslist (Old)")
  MenuItem(#MenuItem_5, "Save Gameslist (CSV)")
  MenuItem(#MenuItem_35, "Save Gameslist (DB)")
  MenuBar()
  MenuItem(#MenuItem_7, "Save Database")
  MenuBar()
  MenuItem(#MenuItem_8, "Quit")
  MenuTitle("Create")
  MenuItem(#MenuItem_32, "Make IFF Folders")
  MenuItem(#MenuItem_33, "Make IFF Archive")
  MenuTitle("Database")
  OpenSubMenu("Update")
  MenuItem(#MenuItem_16, "Update FTP")
  MenuItem(#MenuItem_39, "Update Amiga")
  CloseSubMenu()
  MenuItem(#MenuItem_11, "Check Availability")
  MenuItem(#MenuItem_1, "Check Images")
  MenuItem(#MenuItem_27, "Update Icons")
  MenuBar() 
  MenuItem(#MenuItem_28, "Delete Entry")
  MenuItem(#MenuItem_12, "Edit Entry")
  MenuBar()
  MenuItem(#MenuItem_13, "Set Amiga Path")
  MenuTitle("Settings")
  MenuItem(#MenuItem_14, "Set Paths")
  MenuBar()
  MenuItem(#MenuItem_34, "Close WinUAE On Exit")
  SetMenuItemState(Main_Menu,#MenuItem_34,Close_UAE)
  MenuItem(#MenuItem_20, "Smooth Images")
  MenuItem(#MenuItem_21, "Show Titles")
  SetMenuItemState(Main_Menu,#MenuItem_21,TitleScreen)
  MenuItem(#MenuItem_37, "Back-Up DB (JSON)")
  SetMenuItemState(Main_Menu,#MenuItem_37,JSON_Backup)
  MenuBar()
  MenuItem(#MenuItem_15, "Reload Genres")
  MenuItem(#MenuItem_17, "Refresh")

  TextGadget(#PB_Any, 0, 722, 40, 20, "Type", #PB_Text_Center)  
  Main_Type_Combo = ComboBoxGadget(#PB_Any, 45, 717, 100, 22)

  TextGadget(#PB_Any, 146, 722, 40, 20, "Genre", #PB_Text_Center)  
  Main_Genre_Combo = ComboBoxGadget(#PB_Any, 190, 717, 190, 22)

  TextGadget(#PB_Any, 380, 722, 40, 24, "Filter", #PB_Text_Center)  
  Main_Filter_Combo = ComboBoxGadget(#PB_Any, 425, 717, 100, 22)
  
  Main_List = ListIconGadget(#PB_Any, 8, 8, 488, 704, "Column 1", 100, #PB_ListIcon_GridLines | #LVS_NOCOLUMNHEADER | #PB_ListIcon_FullRowSelect)
  
  Play_Button = ButtonGadget(#PB_Any, 545, 716, 90, 24, "Run Program")
  GadgetToolTip(Play_Button, "Run Program")
  SaveDB_Button = ButtonGadget(#PB_Any, 640, 716, 90, 24, "Save Database")
  GadgetToolTip(SaveDB_Button, "Save Database")
  Edit_Button = ButtonGadget(#PB_Any, 735, 716, 90, 24, "Edit Entry")
  GadgetToolTip(Edit_Button, "Edit Entry")
    
  Main_Image = CanvasGadget(#PB_Any, 506, 24, 320, 256,#PB_Canvas_Border)
  main_image_title=TextGadget(#PB_Any, 506, 8, 88, 16, "Screenshot")
  EnableGadgetDrop(Main_Image,#PB_Drop_Files,#PB_Drag_Copy)
  
  Cover_Image = CanvasGadget(#PB_Any, 506, 300, 320, 412,#PB_Canvas_Border)
  TextGadget(#PB_Any, 506, 284, 88, 16, "Cover") 
  EnableGadgetDrop(Cover_Image,#PB_Drop_Files,#PB_Drag_Copy)


  SetGadgetItemAttribute(Main_List,0,#PB_ListIcon_ColumnWidth,GadgetWidth(Main_List)-4)

  AddGadgetItem(Main_Type_Combo,-1,"All")
  AddGadgetItem(Main_Type_Combo,-1,"Games")
  AddGadgetItem(Main_Type_Combo,-1,"Demos")
  AddGadgetItem(Main_Type_Combo,-1,"Beta / Unreleased")
  SetGadgetState(Main_Type_Combo,0)
  
  AddGadgetItem(Main_Filter_Combo,-1,"All")
  AddGadgetItem(Main_Filter_Combo,-1,"No Image")
  AddGadgetItem(Main_Filter_Combo,-1,"No Title")
  AddGadgetItem(Main_Filter_Combo,-1,"No Cover")
  AddGadgetItem(Main_Filter_Combo,-1,"Invalid Genre")
  AddGadgetItem(Main_Filter_Combo,-1,"Missing Type")
  AddGadgetItem(Main_Filter_Combo,-1,"Invalid Icon")
  AddGadgetItem(Main_Filter_Combo,-1,"No Icon")
  SetGadgetState(Main_Filter_Combo,0)
  
  AddGadgetItem(Main_Genre_Combo,-1,"All")
  
  If ReadFile(g_file,"genres")
    While Not Eof(g_file)
      AddElement(Genre_List())
      Genre_List()=ReadString(g_file)
      Genre_Map(Genre_List())=Genre_List()
    Wend
    CloseFile(g_file)
    SortList(Genre_List(),#PB_Sort_Ascending|#PB_Sort_NoCase)
    ForEach Genre_List()
      AddGadgetItem(Main_Genre_Combo,-1,Genre_List())
    Next
    SetGadgetState(Main_Genre_Combo,0)    
  EndIf
  
  If IFF_Smooth=#PB_Image_Raw
    SetMenuItemState(Main_Menu,#MenuItem_20,#False)
  Else
    SetMenuItemState(Main_Menu,#MenuItem_20,#True)
  EndIf
  
  CreateImage(#IFF_BLANK,DpiX(320), DpiY(256),32,#Black)
  StartDrawing(ImageOutput(#IFF_BLANK))
  FrontColor(#Red)
  DrawText(0,0,"No Image")
  StopDrawing()
  StartDrawing(CanvasOutput(Main_Image))
  DrawImage(ImageID(#IFF_BLANK),0,0)
  StopDrawing()
  
EndProcedure

UsePNGImageDecoder()
UseZipPacker()
InitNetwork()

home_path=GetCurrentDirectory()

Load_Prefs()

Draw_Main_Window()

Window_Update()

Load_DB()

Draw_List()
Draw_Info(0)

HideWindow(#MAIN_WINDOW,#False)

SmartWindowRefresh(#MAIN_WINDOW,#True)

Repeat
  
  event=WaitWindowEvent()
  
  Select event
      
    Case #WM_KEYDOWN
      If GetActiveGadget() = Main_List
        If CountGadgetItems(Main_List)>0
          If EventwParam() = #VK_RETURN
            If CountGadgetItems(Main_List)>0
              SelectElement(List_Numbers(),GetGadgetState(Main_List))
              Run_Game(List_Numbers())
            EndIf 
          EndIf
          If EventwParam() = #VK_SPACE
            If CountGadgetItems(Main_List)>0
              SelectElement(List_Numbers(),GetGadgetState(Main_List))
              Edit_GL(List_Numbers())
            EndIf 
          EndIf
          If EventwParam() = #VK_F1
            Image_Popup(1)
          EndIf
          If EventwParam() = #VK_F2
            Image_Popup(2)
          EndIf
        EndIf
      EndIf
      
    Case #PB_Event_Menu
      Select EventMenu()
        Case #MenuItem_1 ;{- Make Gameslist

          Audit_Images()
          ;}          
        Case #MenuItem_2 ;{- Open Gameslist
           Load_GL();}
        Case #MenuItem_3 ;{- Append Games List)
          Merge_Lists() ;}
        Case #MenuItem_4 ;{- Save Gameslist (Old)
          If ListSize(IG_Database())>0
            path=SaveFileRequester("Save List (Old)","gameslist","*.*",0)
            If path<>""
              Save_GL(path)
            EndIf
          EndIf ;}
        Case #MenuItem_5 ;{- Save Gameslist (CSV)
          If ListSize(IG_Database())>0
            path=SaveFileRequester("Save List (CSV)","gameslist.csv","*.csv",0)
            If path<>""
              Save_GL_CSV(path)
            EndIf
          EndIf ;}
        Case #MenuItem_6 ;{- Clear Gameslist
          If MessageRequester("Warning", "Clear Gameslist?",#PB_MessageRequester_YesNo|#PB_MessageRequester_Warning)=#PB_MessageRequester_Yes        
            If ListSize(IG_Database())>0
              ClearList(IG_Database())
              Set_Menu(#True)
              Window_Pause(#MAIN_WINDOW)
              ClearGadgetItems(Main_List)
              SetGadgetItemAttribute(Main_List,0,#PB_ListIcon_ColumnWidth,GadgetWidth(Main_List)-4)
              SetWindowTitle(#MAIN_WINDOW, W_Title)
              SetGadgetState(Main_Genre_Combo,0)
              Draw_Info(-1)
            EndIf
          EndIf   ;}
        Case #MenuItem_7 ;{- Save Database
          If ListSize(IG_Database())>0
            If MessageRequester("File Overwrite", "Save Database?", #PB_MessageRequester_YesNo|#PB_MessageRequester_Warning)=#PB_MessageRequester_Yes
              CopyFile("igdata.dat","igdata.bak")
              Save_DB()
            EndIf
          EndIf ;}
        Case #MenuItem_8 ;{- Quit
          If MessageRequester("Exit IGTool", "Do you want to quit?",#PB_MessageRequester_YesNo|#PB_MessageRequester_Warning)=#PB_MessageRequester_Yes
            Break
          EndIf ;}
        Case #MenuItem_11 ;{- Check Availability
          Check_Availability();}
        Case #MenuItem_12 ;{- Edit Entry
          If CountGadgetItems(Main_List)>0
            SelectElement(List_Numbers(),GetGadgetState(Main_List))
            Edit_GL(List_Numbers())
          EndIf ;}
        Case #MenuItem_13 ;{- Set Path
          text$=Select_Window()
          If text$<>"exit"
            temp$=InputRequester("Select Game Path",Main_Path,Main_Path)
            If MessageRequester("WHDLoad Game Path","Change All Game Paths",#PB_MessageRequester_YesNo|#PB_MessageRequester_Warning)=#PB_MessageRequester_Yes
              Main_Path=temp$
              ForEach IG_Database()
                If IG_Database()\IG_Type=text$
                  If Right(Main_Path,1)<>"/" : Main_Path+"/" : EndIf
                  path=Main_Path+IG_Database()\IG_Subfolder+IG_Database()\IG_Folder
                  path=ReplaceString(path,"\","/")
                  IG_Database()\IG_Path=path
                EndIf
              Next
              Draw_List() 
            EndIf           
          EndIf ;}
        Case #MenuItem_14 ;{- Set Paths
          Path_Window();}
        Case #MenuItem_15 ;{- Reload Genres
          If ReadFile(g_file,"genres")
            Window_Pause(#MAIN_WINDOW)
            ClearList(Genre_List())
            ClearGadgetItems(Main_Genre_Combo)
            
            While Not Eof(g_file)
              AddElement(Genre_List())
              Genre_List()=ReadString(g_file)
            Wend
            
            CloseFile(g_file)
            
            AddGadgetItem(Main_Genre_Combo,-1,"All")
            AddGadgetItem(Main_Genre_Combo,-1,"No Image")
            AddGadgetItem(Main_Genre_Combo,-1,"No Archive")
            AddGadgetItem(Main_Genre_Combo,-1,"Invalid Genre")
            
            ClearMap(Genre_Map())
            
            ForEach Genre_List()
              AddGadgetItem(Main_Genre_Combo,-1,Genre_List())
              Genre_Map(Genre_List())=Genre_List()
            Next
            
            SetGadgetState(Main_Genre_Combo,0)
            
            If ListSize(IG_Database())>0
              ForEach IG_Database()
                IG_Database()\IG_Filtered=#False
              Next
              Draw_List()
              SetGadgetState(Main_List,0)
              SelectElement(List_Numbers(),GetGadgetState(Main_List))
              Draw_Info(List_Numbers())
            EndIf
          Else
            MessageRequester("Error","Cannot find genres file!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
          EndIf                ;} 
        Case #MenuItem_16 ;{- Update Gameslist
          Update_FTP()
          ;}
        Case #MenuItem_17 ;{- Update Gameslist
          Draw_List()
          SelectElement(List_Numbers(),0)
          Draw_Info(List_Numbers())
          ;}
        Case #MenuItem_20 ;{- Smooth Popup
          If IFF_Smooth=#PB_Image_Raw
            SetMenuItemState(Main_Menu,#MenuItem_20,#True)
            IFF_Smooth=#PB_Image_Smooth
          Else
            SetMenuItemState(Main_Menu,#MenuItem_20,#False)
            IFF_Smooth=#PB_Image_Raw
          EndIf
          ;}
        Case #MenuItem_21 ;{- Show Titles
          If TitleScreen=#True
            SetMenuItemText(Main_Menu,#MenuItem_21,"Show Titles")
            SetGadgetText(main_image_title,"Screenshot")
            TitleScreen=#False
          Else
            SetMenuItemText(Main_Menu,#MenuItem_21,"Show Screenshots")
            TitleScreen=#True
            SetGadgetText(main_image_title,"Title")
          EndIf
          Draw_Info(List_Numbers())
          ;}
        Case #MenuItem_27 ;{- Update Icons
          Update_Icons()
          ;}
        Case #MenuItem_28 ;{- Delete Entry
          If CountGadgetItems(Main_List)>0
            If MessageRequester("Delete Entry","Delete Current Entry?", #PB_MessageRequester_YesNo|#PB_MessageRequester_Warning)=#PB_MessageRequester_Yes
              SelectElement(List_Numbers(),GetGadgetState(Main_List))
              DeleteElement(IG_Database())
              Draw_List()
            EndIf
          EndIf ;}
        Case #MenuItem_29 ;{- Run Game
          If CountGadgetItems(Main_List)>0
            SelectElement(List_Numbers(),GetGadgetState(Main_List))
            Run_Game(List_Numbers())
          EndIf ;}
        Case #MenuItem_30 ;{- Check Missing
          If ListSize(IG_Database())>0
            count=0
            path=PathRequester("WHDLoad LHA Path","")
            List_Files_Recursive(path,File_List(),"") ; Create Archive List
            ClearMap(Duplicates())
            ForEach File_List()
              Duplicates(GetFilePart(File_List()))=0
            Next
            ForEach IG_Database()
              If Not FindMapElement(Duplicates(),IG_Database()\IG_LHAFile)
                IG_Database()\IG_LHAFile=""
                count+1
              EndIf
            Next
            Message_RequesterEx("Results", "Missing: "+Str(count), 125)
          EndIf ;}
        Case #MenuItem_31 ;{- Create Game Folder
          Create_Game_Folder()
          ;}
        Case #MenuItem_32 ;{- Extract IFF Archive
          Create_IFF_Folders()
          ;}
        Case #MenuItem_33 ;{- Create IFF Archive
          Create_IFF_Archive()
          ;}
        Case #MenuItem_34 ;{- Close UAE
          If Close_UAE=#False
            SetMenuItemState(Main_Menu,#MenuItem_34,#True)
            Close_UAE=#True
          Else
            SetMenuItemState(Main_Menu,#MenuItem_34,#False)
            Close_UAE=#False
          EndIf
          ;}
        Case #MenuItem_35 ;{- Save Gameslist (db)
          If ListSize(IG_Database())>0
            path=SaveFileRequester("Save List (db)","","*.db",0)
            If path<>""
              Save_GL_TinyLaunch(path)
            EndIf
          EndIf ;}
        Case #MenuItem_37 ;{- JSON Backup
          If JSON_Backup=#True
            SetMenuItemState(Main_Menu,#MenuItem_37,#False)
            JSON_Backup=#False
          Else
            SetMenuItemState(Main_Menu,#MenuItem_37,#True)
            JSON_Backup=#True
          EndIf
          ;}    
        Case #MenuItem_38 ;{- Update Folders
          ;Check_Miggy()
          ;}  
        Case #MenuItem_39 ;{- FTP Update
          Update_PC()
         ;}    
      EndSelect
      
    Case #PB_Event_GadgetDrop
      
      Select EventGadget()
          
        Case Cover_Image
          If EventDropFiles()>""
            If GetGadgetState(Main_List)<>-1
              If GetExtensionPart(EventDropFiles())="iff"
                path=Game_Img_Path+"Covers\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
                If FileSize(GetPathPart(path))=-1
                  CreateDirectory(GetPathPart(path))
                EndIf
                i=CopyFile(EventDropFiles(), path)
                Draw_Info(List_Numbers())
              Else
                MessageRequester("Error","Not An IFF image!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
              EndIf
            EndIf
          EndIf
        
        Case Main_Image
          If EventDropFiles()>""
            If GetGadgetState(Main_List)<>-1
              If GetExtensionPart(EventDropFiles())="iff"
                If TitleScreen
                  path=Game_Img_Path+"Titles\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
                Else
                  path=Game_Img_Path+"Screenshots\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
                EndIf
                If FileSize(GetPathPart(path))=-1
                  CreateDirectory(GetPathPart(path))
                EndIf
                i=CopyFile(EventDropFiles(), path)
                Draw_Info(List_Numbers())
              Else
                MessageRequester("Error","Not An IFF image!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
              EndIf
            EndIf
          EndIf
        
      EndSelect

    Case #PB_Event_Gadget
      
      Select EventGadget()
          
        Case Main_List
          If CountGadgetItems(Main_List)>0 And GetGadgetState(Main_List)>-1
            If EventType()= #PB_EventType_Change
              SelectElement(List_Numbers(),GetGadgetState(Main_List))
              Draw_Info(List_Numbers())
              SelectElement(IG_Database(),List_Numbers())
            EndIf
            If EventType() = #PB_EventType_LeftDoubleClick
              PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_29)
            EndIf
          EndIf
          
        Case Main_Image
          If ListSize(IG_Database())>0
            If EventType()= #PB_EventType_LeftDoubleClick
              Image_Popup(1)
            EndIf
          EndIf
          
        Case Cover_Image
          If ListSize(IG_Database())>0
            If EventType()= #PB_EventType_LeftDoubleClick
              If IG_Database()\IG_Type<>"Demo"
                Image_Popup(2)
              EndIf
            EndIf
          EndIf
          
        Case Main_Type_Combo
          If EventType()=#PB_EventType_Change
            Draw_List() 
            If ListSize(List_Numbers())>0
              SelectElement(List_Numbers(),GetGadgetState(Main_List))
              Draw_Info(List_Numbers())
            Else
              Draw_Info(-1)
            EndIf 
          EndIf
          
        Case Main_Genre_Combo
          If EventType()=#PB_EventType_Change           
            Draw_List()  
            If ListSize(List_Numbers())>0
              SelectElement(List_Numbers(),GetGadgetState(Main_List))
              Draw_Info(List_Numbers())
            Else
              Draw_Info(-1)
            EndIf            
          EndIf
          
        Case Main_Filter_Combo
          If EventType()=#PB_EventType_Change           
            Draw_List()  
            If ListSize(List_Numbers())>0
              SelectElement(List_Numbers(),GetGadgetState(Main_List))
              Draw_Info(List_Numbers())
            Else
              Draw_Info(-1)
            EndIf            
          EndIf
          
        Case Play_Button
          PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_29) 
          
        Case SaveDB_Button
          PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_7)
          
        Case Edit_Button
          PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_12)
 
      EndSelect
      
    Case #PB_Event_CloseWindow
      Break
      
  EndSelect
  
ForEver

Save_Prefs()

; If ListSize(IG_Database())>0
;   If MessageRequester("File Overwrite", "Save Database?", #PB_MessageRequester_YesNo|#PB_MessageRequester_Warning)=#PB_MessageRequester_Yes
; ;     If MessageRequester("File Overwrite", "Backup Database?", #PB_MessageRequester_YesNo|#PB_MessageRequester_Warning)=#PB_MessageRequester_Yes
; ;       CopyFile("igdata.dat","igdata.bak")
; ;     EndIf
;     Save_DB("ig_"+List_Type+".json")
;   EndIf
; EndIf ;}

End
; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 1536
; FirstLine = 271
; Folding = AAAAACAAAAAAAAg
; EnableThread
; EnableXP
; EnableUser
; DPIAware
; UseIcon = joystick.ico
; Executable = igtool.exe
; Compiler = PureBasic 5.73 LTS (Windows - x64)
; Debugger = Standalone