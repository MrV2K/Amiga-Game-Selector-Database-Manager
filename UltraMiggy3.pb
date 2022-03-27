; UltraMiggy
;
; Version 0.3
;
; © 2021 Paul Vince (MrV2k)
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

Declare List_Files_Recursive(Dir.s, List Files.s(), Extension.s)
Declare Message_RequesterEx(Title$ , Message$ , width.i)
Declare.s Title_Extras()
Declare Draw_Info(number)
Declare Draw_List()
Declare.s Split_On_Capital(split_string.s)
Declare Fix_Gameslist(names_only.b=#False)
Declare Update_FTP()
Declare Update_PC()
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
  #CONVERT_IMAGE
  #IFF_BLANK
  #IFF_POPUP
  #MAIN_PANEL
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
  IG_Short.s
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
  IG_Publisher.s
  IG_Type.s
  IG_Year.s
  IG_Default_Icon.s
  List IG_Icons.s()
  IG_Filtered.b
  IG_Config.i
  IG_Available.b
  IG_Image_Avail.b
  IG_Cover_Avail.b
  IG_Title_Avail.b 
EndStructure

Global NewList IG_Database.IG_Data()

Structure CD_Data
  CD_Title.s
  CD_Genre.s
  CD_Language.s
  CD_File.s
  CD_Publisher.s
  CD_Type.s
  CD_Year.s
  CD_Filtered.b
  CD_Image_Avail.b
  CD_Cover_Avail.b
  CD_Title_Avail.b
  CD_Keyboard.b
  CD_Mouse.b
  CD_Compilation.b
  CD_Ram.s
  CD_Config.i
EndStructure

Global NewList CD32_Database.CD_Data()

Structure f_data
  F_Title.s
  F_Short.s
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
  F_Publisher.s
  F_Type.s
  F_Year.s
  F_Config.i
  List F_Icons.s()
  F_Default_Icon.s
EndStructure

Global NewList Fix_List.f_data()

Global NewList List_Numbers.i()
Global NewList CD32_Numbers.i()

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

Global W_Title.s="UltraMiggy v0.3"
Global Main_Path.s, path.s, List_Type.s, List_Path.s, CD32_Path.s
Global event.i, Main_Menu.i, Main_Image, Cover_Image, Main_Search, IFF_Image, listnum.i, temp$, count.i, i.i, j.i, k.i, list_pos.i
Global Main_List, Info_List, LoadGL_Button, SaveDB_Button, New_Button, GamePath_Button, Fix_Button, Genres_Button, Prefs_Button, Clear_Button, CSV_Button, Play_Button
Global SaveGL_Button, Audit_Button, Edit_Button, Delete_Button, WHDPath_Button, Path_Button, Make_Button, Main_Genre_Combo, Main_Type_Combo, Main_Filter_Combo, CD32_List.i
Global st_processed, st_removed, st_fixed, g_file, text$
Global merge_path_1.s,merge_path_2.s,merge_path_3.s, TitleScreen.b, main_image_title.i

Global Home_Path.s=GetCurrentDirectory()
Global Data_Path.s=Home_Path+"UM_Data\"

Global LHA_Path.s=Home_Path+"Archivers\7z.exe"
Global LZX_Path.s=Home_Path+"Archivers\unlzx.exe"

Global WHD_TempDir.s=GetTemporaryDirectory()+"WHDTemp"
Global DB_Path.s=Home_Path
Global Game_Img_Path.s=Home_Path+"Images\"
Global Backup_Path.s=Home_Path+"Backup\"
Global CD32_Path.s=Home_Path+"CD32\"
Global WHD_Folder.s=Home_Path+"WHD\"
Global WinUAE_Path.s=Home_Path+"WinUAE\winuae64.exe"
Global Config_Path.s=Home_Path+"Configurations\" 
Global NConvert_Path.s=Home_Path+"NConvert\nconvert.exe"

Global Close_UAE.b=#True
Global JSON_Backup=#True
Global TitleScreen=#False
Global IFF_Smooth.l=#PB_Image_Raw

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

Macro Pause_Window(window)
  SendMessage_(WindowID(window),#WM_SETREDRAW,0,0)
EndMacro

Macro Resume_Window(window)
  SendMessage_(WindowID(window),#WM_SETREDRAW,1,0)
  InvalidateRect_(WindowID(window),0,1)
  UpdateWindow_(WindowID(window))
EndMacro

Macro PrintNCol(PText,PFCol,PBCol)
  ConsoleColor(PFCol,PBCol)
  PrintN(PText)
  ConsoleColor(7,0)
EndMacro

Macro Update_StatusBar()
  
  If GetGadgetState(#MAIN_PANEL)=0
    If IG_Database()\IG_Type="Demo"
      StatusBarText(#MAIN_STATUS,1,"Coder: "+Chr(10)+IG_Database()\IG_Publisher)
    Else
      StatusBarText(#MAIN_STATUS,1,"Publisher: "+Chr(10)+IG_Database()\IG_Publisher)
    EndIf
    
    StatusBarText(#MAIN_STATUS,0,"Genre: "+Chr(10)+IG_Database()\IG_Genre)  
    StatusBarText(#MAIN_STATUS,2,"Year: "+Chr(10)+IG_Database()\IG_Year)
  EndIf
  
  If GetGadgetState(#MAIN_PANEL)=1
    StatusBarText(#MAIN_STATUS,1,"Publisher: "+Chr(10)+CD32_Database()\CD_Publisher)    
    StatusBarText(#MAIN_STATUS,0,"Genre: "+Chr(10)+CD32_Database()\CD_Genre)  
    StatusBarText(#MAIN_STATUS,2,"Year: "+Chr(10)+CD32_Database()\CD_Year)
  EndIf
  
EndMacro

Macro PrintS()
  PrintN("")
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

Procedure.s CD32_Title_Extras()
  
  Protected extras.s=""
  
  If CD32_Database()\CD_Ram<>""
    extras+" ("+CD32_Database()\CD_Ram+")"
  EndIf   
  
  If CD32_Database()\CD_Language<>""
    extras+" ("+CD32_Database()\CD_Language+")"
  EndIf
  
  If CD32_Database()\CD_Keyboard<>0
    extras+" (Keyboard)"
  EndIf
  
  If CD32_Database()\CD_Mouse<>0
    extras+" (Mouse)"
  EndIf
  
  If CD32_Database()\CD_Compilation<>0
    extras+" (Compilation)"
  EndIf
    
  ProcedureReturn extras
  
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
        
      Case "No Year"        
        If IG_Database()\IG_Year<>""
          IG_Database()\IG_Filtered=#True
        EndIf
        
      Case "No Publisher"        
        If IG_Database()\IG_Publisher<>""
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

Procedure Draw_CD32_Info(number)
  
  Pause_Window(#MAIN_WINDOW)  
  
  If IsImage(#IFF_IMAGE) : FreeImage(#IFF_IMAGE) : EndIf
  
  If number>-1
    
    SelectElement(CD32_Database(),number)
    
    Update_StatusBar()
       
    If TitleScreen
      path=Game_Img_Path+"CD32\Titles\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".png"
    Else
      path=Game_Img_Path+"CD32\Screenshots\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".png"
    EndIf
  
    If FileSize(path)>0
      LoadImage(#IFF_IMAGE,path)      
    Else
      CopyImage(#IFF_BLANK,#IFF_IMAGE)
    EndIf
    
    If IsImage(#IFF_IMAGE)
      ResizeImage(#IFF_IMAGE,316, 252,IFF_Smooth)
      StartDrawing(CanvasOutput(Main_Image))
      DrawImage(ImageID(#IFF_IMAGE),0,0,316,252)
      StopDrawing()
    EndIf
    
    path=Game_Img_Path+"CD32\Covers\"+CD32_Database()\CD_Title+".png"
    
    If FileSize(path)>0
      LoadImage(#IFF_IMAGE,path)      
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

  Resume_Window(#MAIN_WINDOW)
  
EndProcedure

Procedure Draw_Info(number)
  
  Pause_Window(#MAIN_WINDOW)  
  
  If IsImage(#IFF_IMAGE) : FreeImage(#IFF_IMAGE) : EndIf
  
  If number>-1
    
    SelectElement(IG_Database(),number)
    
    Update_StatusBar()
    
    If TitleScreen
      path=Game_Img_Path+"Titles\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"
    Else
      path=Game_Img_Path+"Screenshots\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"
    EndIf
    
    If FileSize(path)>0
      LoadImage(#IFF_IMAGE,path)      
    Else
      CopyImage(#IFF_BLANK,#IFF_IMAGE)
    EndIf
    
    If IsImage(#IFF_IMAGE)
      ResizeImage(#IFF_IMAGE,316, 252,IFF_Smooth)
      StartDrawing(CanvasOutput(Main_Image))
      DrawImage(ImageID(#IFF_IMAGE),0,0,316,252)
      StopDrawing()
    EndIf
    
    path=Game_Img_Path+"Covers\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"

    If FileSize(path)>0
      LoadImage(#IFF_IMAGE,path)      
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

  Resume_Window(#MAIN_WINDOW)
  
EndProcedure

Procedure Draw_CD32_List()
  
  Protected star.s, game.i, demo.i, beta.i

  SortStructuredList(CD32_Database(),#PB_Sort_Ascending|#PB_Sort_NoCase,OffsetOf(CD_Data\CD_Title),TypeOf(CD_Data\CD_Title))
  
  UseGadgetList(WindowID(#MAIN_WINDOW))
  
  Pause_Window(#MAIN_WINDOW)

  ClearList(CD32_Numbers())
  ClearGadgetItems(CD32_List)
  
  ;Filter_List()
  
  ForEach CD32_Database()
    star=""
    If CD32_Database()\CD_Genre="Unknown" : star="*" : EndIf
    If CD32_Database()\CD_Title<>"" ;And CD32_Database()\CD_Filtered=#False
      AddGadgetItem(CD32_List,-1,star+CD32_Database()\CD_Title+CD32_Title_Extras())
      AddElement(CD32_Numbers())
      CD32_Numbers()=ListIndex(CD32_Database())
    EndIf
  Next
  
  If GetWindowLongPtr_(GadgetID(CD32_List), #GWL_STYLE) & #WS_VSCROLL
    SetGadgetItemAttribute(CD32_List,0,#PB_ListIcon_ColumnWidth,GadgetWidth(CD32_List)-20)
  Else
    SetGadgetItemAttribute(CD32_List,0,#PB_ListIcon_ColumnWidth,GadgetWidth(CD32_List)-5)
  EndIf
  
  For count=0 To CountGadgetItems(CD32_List) Step 2
    SetGadgetItemColor(CD32_List,count,#PB_Gadget_BackColor,$eeeeee)
  Next
  
  SetGadgetState(CD32_List,0)
  
  Resume_Window(#MAIN_WINDOW)  

  If ListSize(CD32_Numbers())>0
    SelectElement(CD32_Numbers(),0)
  EndIf
    
EndProcedure

Procedure Draw_List()
  
  Protected star.s, game.i, demo.i, beta.i

  SortStructuredList(IG_Database(),#PB_Sort_Ascending|#PB_Sort_NoCase,OffsetOf(IG_Data\IG_Title),TypeOf(IG_Data\IG_Title))
  
  UseGadgetList(WindowID(#MAIN_WINDOW))
  
  Pause_Window(#MAIN_WINDOW)

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
  
  Resume_Window(#MAIN_WINDOW)
  
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
  
  Protected startup_file.i, startup_prog.i, old_pos.i, config.s, old_dir.s 
  
  DisableWindow(#MAIN_WINDOW,#True)
  
  SelectElement(IG_Database(), gamenumber)  

  old_pos=GetGadgetState(Main_List)
  
  If FileSize(WHD_TempDir)=-2 : DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force) : EndIf
  
  If CreateDirectory(WHD_TempDir)
    
    SetCurrentDirectory(WHD_TempDir)
    
    startup_file=CreateFile(#PB_Any,"whd-startup")
    
    If startup_file
      WriteString(startup_file,"cd WHD-HDD:"+#LF$)
      WriteString(startup_file,"cd "+IG_Database()\IG_Type+"/"+IG_Database()\IG_Subfolder+IG_Database()\IG_Folder+"/"+#LF$)
      WriteString(startup_file,"kgiconload "+IG_Database()\IG_Default_Icon+#LF$)
      If Close_UAE : WriteString(startup_file,"c:uaequit") : EndIf
      FlushFileBuffers(startup_file)
      CloseFile(startup_file)      
    EndIf
    
    config=""
    
    If IG_Database()\IG_CD32 : config=Config_Path+"A1200_WHD_CD32.uae" : Else : config=Config_Path+"A1200_WHD.uae" : EndIf
    
    startup_prog=RunProgram(WinUAE_Path, "-f "+config+" -s filesystem2=rw,DH1:WHDTemp:"+WHD_TempDir+",0","",#PB_Program_Wait)
        
    SetCurrentDirectory(home_path)
    
    DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
    
  EndIf
  
  DisableWindow(#MAIN_WINDOW,#False)
  
  SetGadgetState(Main_List,old_pos)
  
EndProcedure

Procedure Run_CD32(gamenumber.i)
  
  Protected output$, startup_prog.i, old_pos.i
  
  old_pos=GetGadgetState(CD32_List)
  
  DisableWindow(#MAIN_WINDOW,#True)
  
  SelectElement(CD32_Database(),gamenumber)
  
  If CD32_Database()\CD_Config=0
    output$=" -f "+Config_Path+"CD32.uae -cfgparam cdimage0="+#DOUBLEQUOTE$+CD32_Path+CD32_Database()\CD_File+#DOUBLEQUOTE$+","
  EndIf
  If CD32_Database()\CD_Config=1
    output$=" -f "+Config_Path+"CD32-4MB.uae -cfgparam cdimage0="+#DOUBLEQUOTE$+CD32_Path+CD32_Database()\CD_File+#DOUBLEQUOTE$+","
  EndIf
  If CD32_Database()\CD_Config=2
    output$=" -f "+Config_Path+"CD32-8MB.uae -cfgparam cdimage0="+#DOUBLEQUOTE$+CD32_Path+CD32_Database()\CD_File+#DOUBLEQUOTE$+","
  EndIf
  
  startup_prog=RunProgram(WinUAE_Path,output$,"",#PB_Program_Wait)
  
  DisableWindow(#MAIN_WINDOW,#False)
  
  SetActiveGadget(CD32_List)
  SetGadgetState(CD32_List,old_pos)
  
EndProcedure

Procedure Fix_Gameslist(names_only.b=#False)
  
  If MessageRequester("Load Gameslist", "Fix Gameslist?", #PB_MessageRequester_YesNo|#PB_MessageRequester_Info)=#PB_MessageRequester_Yes
    
    SetWindowTitle(#MAIN_WINDOW, "Fixing Gameslist...")
    
    Protected NewMap sortmap.i()
    Protected NewMap genremap.s()
    
    Protected igfile2, istring.s, extras.s, folder.s, g_file.i, g_string.s
    
    st_fixed=0
    st_processed=0
    
    If ReadFile(g_file,Data_Path+"um_genres.dat")
      
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
          IG_Database()\IG_Publisher=Fix_List()\F_Publisher
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
        
    If FileSize(ReplaceString(WHD_Folder+IG_Database()\IG_Type+"\"+IG_Database()\IG_Subfolder+IG_Database()\IG_LHAFile,"/","\"))>-1
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
  
  path=WHD_Folder
  
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
   Protected NewList Comp_List.s()
  
  Protected old_pos.i, prog_path.s
  Protected main_ftp.s, tempfolder.s, ftp_server.s, ftp_user.s, ftp_pass.s, ftp_port.i, ftp_passive.b
  Protected dat_archive.i, xml_file.i    
  Protected cd_file.i, output.s, path2.s 
  Protected IG_Program.i, time.i

  tempfolder=GetCurrentDirectory()+"um_temp\"
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
  PrintS()
  PrintNCol("Downloading Dat Files...",3,0)
  PrintS()
  PrintNCol("Connecting To EAB FTP Server...",14,0)
  PrintS()
  If OpenFTP(#FTP,ftp_server,ftp_user,ftp_pass,ftp_passive,ftp_port)
    PrintNCol("Connected to "+ftp_server+" on port:"+Str(ftp_port),4,0)
    PrintS()
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
    
    PrintS()
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
        ClosePack(dat_archive)
      Else
        MessageRequester("Error","Cannot Open Archive",#PB_MessageRequester_Ok)
        DeleteDirectory(tempfolder,"",#PB_FileSystem_Force)
        Goto Proc_Exit
      EndIf
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
    
    SetCurrentDirectory(Home_Path)
    
    DeleteDirectory(tempfolder,"",#PB_FileSystem_Force)
    
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
    
    path=WHD_Folder
    
    If path<>"" 
      PrintS()  
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
      
      PrintS()
      PrintNCol("Delete/Backup/Keep old archives? (D/B/K)",4,0)
      PrintS()
      Protected answer$
      
      Repeat : answer$=Inkey() : Until answer$="D" Or answer$="d" Or answer$="K" Or answer$="k" Or answer$="B" Or answer$="b" 
      
      SetCurrentDirectory(path)
      
      If answer$="d" Or answer$="D"
        ForEach Delete_List()
          PrintNCol("Deleting : "+GetCurrentDirectory()+Delete_List(),4,0)
          DeleteFile(GetCurrentDirectory()+Delete_List(),#PB_FileSystem_Force)
        Next
        PrintS()
      EndIf
      
      If answer$="K" Or answer$="k"
        PrintS()
        PrintN("Files left in place...")
      EndIf
      
      If answer$="b" Or answer$="B"
        PrintS()
        PrintN("Backing Up Old Files...")
        If FileSize(Home_Path+"Backup")<0 : CreateDirectory(Home_Path+"Backup") : EndIf
        ForEach Delete_List()
          PrintN("Backing Up To : "+Home_Path+"Backup\"+GetFilePart(Delete_List()))
          CopyFile(Delete_List(),Home_Path+"Backup\"+GetFilePart(Delete_List()))
          DeleteFile(Delete_List())
        Next
      EndIf
      
      FreeList(Delete_List())
      
    Else
      
      PrintS()
      PrintNCol("Nothing To Delete!",2,0)
      
    EndIf
    
    ;}  
  ;{ 5. Download new archives, scan and update DB ##############################################################################################################################################
    
    If ListSize(Down_List())>0
      
      PrintS()      
      PrintNCol("Downloading New Archives...",9,0)
      PrintS()
      
      If OpenFTP(#FTP,ftp_server,ftp_user,ftp_pass,ftp_passive,ftp_port)
        PrintN("Connected to "+ftp_server+" on port:"+Str(ftp_port))
        PrintS()
        
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
            ReceiveFTPFile(#FTP,StringField(Down_List(),3,"\"), WHD_Folder+path+StringField(Down_List(),2,"\")+"\"+StringField(Down_List(),3,"\"))
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
      
      PrintS()
      PrintNCol("Archives Up To Date!",2,0)
      
    EndIf
    
    ;}
    
  Else
    PrintS()
    PrintNCol("Error: Can't Connect To FTP.",3,0)
  EndIf
  
  Save_DB()  
  
  Proc_Exit:
  
  FreeList(Dat_List())
  FreeList(XML_List())
  FreeList(Delete_List())
  FreeList(Down_List())
  FreeMap(Arc_Map())
  FreeList(Comp_List())
  
  CloseConsole()  

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
  
  Structure copy
    c_number.i
    c_date.s
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
  Protected NewList Copy_List.copy()        ; Updated Entries
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
  PrintNCol("*  Updating...  *",6,0)
  PrintNCol("*               *",6,0)
  PrintNCol("*****************",6,0)
  PrintS()
  PrintNCol("Scanning Amiga HDD...",9,0)
  PrintS()
  PrintNCol("Starting WinUAE...",14,0)
  PrintS()

  If FileSize(WHD_TempDir)=-2 : DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force) : EndIf
  
  If CreateDirectory(WHD_TempDir)
    SetCurrentDirectory(WHD_TempDir)
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
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+"Complete"+#DOUBLEQUOTE$+" TO DH1:complete.txt"+#LF$)
      WriteString(startup_file,"c:uaequit")
      FlushFileBuffers(startup_file)
      CloseFile(startup_file)      
    EndIf
    startup_prog=RunProgram(WinUAE_Path, "-f "+Config_Path+"Update.uae -s filesystem2=rw,DH1:WHDTemp:"+WHD_TempDir+",0","",#PB_Program_Wait)
    If FileSize("complete.txt")<=0 
      DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
      PrintNCol("WinUAE Error!",4,0)
      PrintS()
      Delay(2000)
      Goto CleanUp
    EndIf
    If FileSize(home_path+"dirs.txt")>0 : DeleteFile(home_path+"dirs.txt") : EndIf
    If FileSize(home_path+"slaves.txt")>0 : DeleteFile(home_path+"slaves.txt") : EndIf
    CopyFile("dirs.txt",home_path+"dirs.txt")
    CopyFile("slaves.txt",home_path+"slaves.txt")
    SetCurrentDirectory(home_path)
    DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
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
    
    CloseFile(cd_file)
    
    DeleteFile(Home_Path+"dirs.txt")
    
    SortList(Miggy_List(),#PB_Sort_Ascending)
    
    ForEach Miggy_List()
      Miggy_Map(Miggy_List())=Miggy_List()  
    Next
    
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
  PrintS()
  
  path=WHD_Folder

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
      
      ; Must Scan Twice As AddElement Messes Up Picture Rename!!!!!
      
      ForEach Add_List()
        If FindMapElement(Folder_Check(),LCase(Add_List()\add_type+"_"+RemoveString(GetPathPart(Add_List()\add_file),"/")))
          SelectElement(IG_Database(),Folder_Check())
          IG_Database()\IG_LHAFile=Add_List()\add_arc
          IG_Database()\IG_Slave_Date=Add_List()\add_date
          oldpath=IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
          ClearList(IG_Database()\IG_Icons())
          CopyList(Add_List()\Icons2(), IG_Database()\IG_Icons())
          PrintS()
          PrintN("Choose Default Icon for "+IG_Database()\IG_Title)
          PrintS()
          count=1
          ForEach IG_Database()\IG_Icons()
            PrintN(Str(count)+": "+IG_Database()\IG_Icons())
            count+1
          Next
          PrintN("C: Cancel")
          PrintS()
          Print("Select a number: ")
          path=Input()
          i=Val(path)
          SelectElement(IG_Database()\IG_Icons(),i-1)
          IG_Database()\IG_Default_Icon=IG_Database()\IG_Icons()
          path=IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
          RenameFile(Game_Img_Path+"Screenshots\"+oldpath,Game_Img_Path+"Screenshots\"+path)
          RenameFile(Game_Img_Path+"Covers\"+oldpath,Game_Img_Path+"Covers\"+path)
          RenameFile(Game_Img_Path+"Titles\"+oldpath,Game_Img_Path+"Titles\"+path)
          RenameFile(oldpath,path)
        EndIf
      Next
      
      ForEach Add_List()
        If Not FindMapElement(Folder_Check(),LCase(Add_List()\add_type+"_"+RemoveString(GetPathPart(Add_List()\add_file),"/")))
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
          PrintS()
          PrintN("Choose Default Icon for "+IG_Database()\IG_Title)
          PrintS()
          count=1
          ForEach IG_Database()\IG_Icons()
            PrintN(Str(count)+": "+IG_Database()\IG_Icons())
            count+1
          Next
          PrintN("C: Cancel")
          PrintS()
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
              PrintS()
              PrintNCol("Error! Invalid Number",4,0)    
              Delay(2000)
            EndIf
          Else
            If LCase(path)<>"c"
              PrintS()
              PrintNCol("Error! Invalid Entry",4,0) 
              Delay(2000)
            EndIf    
          EndIf
        EndIf
      Next 
      
      cd_file=ReadFile(#PB_Any,Home_Path+"slaves.txt")
      
      If cd_file
        While Not Eof(cd_file)
          output=ReadString(cd_file)
          Miggy_Comp_Map(LCase(output))=StringField(output,2,"_")
        Wend
      EndIf
      
      CloseFile(cd_file)
      
      DeleteFile(Home_Path+"slaves.txt")
      
      ClearList(Copy_List())
      
      ForEach IG_Database()      
        path2=IG_Database()\IG_Type+"/"+IG_Database()\IG_Subfolder+IG_Database()\IG_Folder+"/"+IG_Database()\IG_Slave+"_"+IG_Database()\IG_Slave_Date
        If Not FindMapElement(Miggy_Comp_Map(),LCase(path2))
          AddElement(Copy_List())
          Copy_List()\c_number=ListIndex(IG_Database())
          Copy_List()\c_date=Miggy_Comp_Map()
        EndIf
      Next
      
      ForEach Copy_List()
        SelectElement(IG_Database(),Copy_List()\c_number)             
        PrintS()
        Print("Update Available: "+IG_Database()\IG_Title+Title_Extras())
        ConsoleColor(4,0)
        Print(" Old Slave Date: "+Copy_List()\c_date)
        PrintNCol(" New Slave Date: "+IG_Database()\IG_Slave_Date,2,0)
      Next   
      
      If ListSize(Copy_List())>0
        
        PrintS()
        PrintN("Select Full to delete drawer and create a new one.")
        PrintN("Select Overwrite to keep drawer and overwrite files.") 
        PrintS()
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
          PrintS()

          If path="y" Or path="Y"
            
            PrintNCol("Starting WinUAE...",14,0)
            PrintS()
            
            output=""
            
            output+"echo "+#DOUBLEQUOTE$+"Copying IGame Data Files..."+#DOUBLEQUOTE$+#LF$
            output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
            
            output+"copy DH1:gameslist.csv TO WHD-HDD:"+#LF$
            output+"copy DH1:genres TO WHD-HDD:"+#LF$
            
            output+"echo "+#DOUBLEQUOTE$+"Deleting Unneeded Directories..."+#DOUBLEQUOTE$+#LF$
            output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
            
            ForEach Delete_List()
              output+"delete "+Delete_List()+" ALL"+#LF$
            Next
            
            If path2="F" Or path2="f"
              
              output+"echo "+#DOUBLEQUOTE$+"Deleting Old Directories..."+#DOUBLEQUOTE$+#LF$
              output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
              
              ForEach Copy_List()
                SelectElement(IG_Database(),Copy_List()\c_number)
                output+"delete WHD-HDD:"+IG_Database()\IG_Type+"/"+IG_Database()\IG_Subfolder+IG_Database()\IG_Folder+" ALL"+#LF$
                output+"delete WHD-HDD:"+IG_Database()\IG_Type+"/"+IG_Database()\IG_Subfolder+IG_Database()\IG_Folder+".info"+#LF$
              Next
              
            EndIf
            
            output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
            output+"echo "+#DOUBLEQUOTE$+"Extracting New Archives..."+#DOUBLEQUOTE$+#LF$
            output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
            
            output+"wait 2 SECS"+#LF$ ; Wait For Disk To Finish... Hopefully
                        
            ForEach Copy_List()
              SelectElement(IG_Database(),Copy_List()\c_number)
              output+"xadunfile FROM DH1:"+Str(ListIndex(Copy_List()))+"."+GetExtensionPart(IG_Database()\IG_LHAFile)+" DEST WHD-HDD:"+IG_Database()\IG_Type+"/"+IG_Database()\IG_Subfolder+" OW VERBOSE"+#LF$
            Next
            
            output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
            output+"ask "+#DOUBLEQUOTE$+"Press A Key to Close WinUAE..."+#DOUBLEQUOTE$+#LF$
            
            output+"c:uaequit"+#LF$
                       
            If FileSize(WHD_TempDir)=-2 : DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force) : EndIf
            
            Protected result.i        
            
            If CreateDirectory(WHD_TempDir)
              SetCurrentDirectory(WHD_TempDir)
              Save_GL_CSV(WHD_TempDir+"\gameslist.csv")
              Delay(50)
              CopyFile(Data_Path+"um_genres.dat",WHD_TempDir+"\genres")
              Delay(50)
              startup_file=CreateFile(#PB_Any,"whd-startup")
              If startup_file
                WriteString(startup_file,output)
                ForEach Copy_List()
                  SelectElement(IG_Database(),Copy_List()\c_number)
                  path=ReplaceString(WHD_Folder+IG_Database()\IG_Type+"\"+IG_Database()\IG_Subfolder+IG_Database()\IG_LHAFile,"/","\")
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
                startup_prog=RunProgram(WinUAE_Path, "-f "+Config_Path+"Update.uae -s filesystem2=rw,DH1:WHDTemp:"+WHD_TempDir+",0","",#PB_Program_Wait) 
              EndIf
              SetCurrentDirectory(home_path)
              DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
            EndIf
          EndIf
        EndIf  
        
      Else
        PrintNCol("Nothing to update!",2,0)
      EndIf
    EndIf
    
  EndIf
  
  PrintS()
  PrintNCol("Cleaning Up Database...",9,0)
  
  ForEach IG_Database()
    If FileSize(WHD_Folder+IG_Database()\IG_Type+"\"+IG_Database()\IG_Subfolder+IG_Database()\IG_LHAFile)=-1
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
  
  Save_DB()
  
  Draw_List()  
  
  CleanUp:
  
  CloseConsole()
  
  ; Clear Resources
  
  FreeList(Miggy_List())
  FreeMap(Miggy_Map())
  FreeMap(PC_Map())
  FreeList(PC_List())
  FreeMap(Folder_Check())
  FreeList(Check_List())
  FreeMap(Check_Archives())
  FreeList(Add_List())
  FreeMap(Miggy_Comp_Map())
  FreeList(Copy_List())
  FreeList(Delete_List())
  FreeList(Icon_List())

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

Procedure.b AskYN(message.s)
  
  PrintNCol(message,2,0)
  Protected answer.s, bool.b
  Repeat 
   answer=Inkey()
  Until answer="y" Or answer="n"
  If answer="y" : bool=#True : EndIf
  If answer="n" : bool=#False : EndIf
  ProcedureReturn bool
  
EndProcedure

Procedure DeleteDirectorySafely(Path.s)
  Protected PathID
  Protected Result
  Protected EntryName.s
  Protected PathNotEmpty
  Protected i
 
  If Not FileSize(Path.s)=-2
    ProcedureReturn #False
  EndIf
 
  PathID=ExamineDirectory(#PB_Any,Path.s,"")
  If PathID
    For i=1 To 3
      Result=NextDirectoryEntry(PathID)
      EntryName.s=DirectoryEntryName(PathID)
      If Result And EntryName.s<>"." And EntryName.s<>".."
        PathNotEmpty=#True
      EndIf
    Next i
   
    If Not PathNotEmpty
      FinishDirectory(PathID)
      Result=DeleteDirectory(Path.s,"")
      ProcedureReturn Result
    EndIf
   
    FinishDirectory(PathID)
  EndIf
 
  ProcedureReturn #False
EndProcedure

Procedure Audit_Images()

  Protected NewMap DB_Map.s()
  Protected NewList Delete_List.s()
    
  OpenConsole("Check Images")  
  ConsoleCursor(0)
  ClearList(File_List())
  
  PrintNCol("Checking Images...",9,0)
  PrintS()
  PrintNCol("Scanning Folders. Please Wait...",7,0)  
  
  List_Files_Recursive(Game_Img_Path+"Screenshots\",File_List(),"") ; Create Archive List
  List_Files_Recursive(Game_Img_Path+"Titles\",File_List(),"") ; Create Archive List
  List_Files_Recursive(Game_Img_Path+"Covers\",File_List(),"") ; Create Archive List
  
  ForEach IG_Database()
    path=Game_Img_Path+"Screenshots\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
    DB_Map(LCase(path))=path
    path=Game_Img_Path+"Covers\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
    DB_Map(LCase(path))=path
    path=Game_Img_Path+"Titles\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
    DB_Map(LCase(path))=path
  Next
  
  ForEach File_List()
    If Not FindMapElement(DB_Map(),LCase(File_List()))
      AddElement(Delete_List())
      Delete_List()=File_List()
    EndIf
  Next
  
  PrintS()
  
  ForEach Delete_List()
    PrintNCol("Not Needed: "+Delete_List(),4,0)
  Next

  If ListSize(Delete_List())>0  
    PrintS()
    If AskYN("Delete Unneeded Images (Y/N)?")
      PrintS()
      ForEach Delete_List()
        PrintNCol("Deleting "+GetFilePart(Delete_List()),7,0)
        DeleteFile(Delete_List(),#PB_FileSystem_Force)
        DeleteDirectorySafely(Delete_List())
      Next
    EndIf
  Else
    PrintNCol("Nothing To Delete!",2,0)
    Delay(2000)
  EndIf

  CloseConsole()
  
  FreeMap(DB_Map())
  FreeList(Delete_List())
  
  ClearList(File_List())
  
EndProcedure

Procedure Create_IFF_Folders()
  
  Protected source_folder$, dest_folder$, source_file$, new_file$, title$, result.i, response.s, text_info.i, progress_bar.i, progress_window.i, old_gadget_list.i
  
  source_folder$=PathRequester("Select Source Folder",Game_Img_Path)  
  If source_folder$<>""
    dest_folder$=PathRequester("Select Output Folder","")  
    If dest_folder$<>""
      OpenConsole("Create Image Folders")
      ConsoleCursor(0)
      PrintNCol("Select Image Type.",9,0)
      PrintS()
      PrintN("1. IGame")
      PrintN("2. AGS")
      PrintN("3. TinyLauncher")
      PrintN("4. PNG")
      PrintN("5. All")
      PrintN("6. FTP Set")
      PrintN("C. Cancel")
      PrintS()
      Print("Please select a number: ")
      response=Input()            
      If LCase(response)<>"c"
        ForEach IG_Database()       
          ConsoleTitle("Processing: "+IG_Database()\IG_Title+Title_Extras()+" ("+Str(ListIndex(IG_Database())+1)+" of "+Str(ListSize(IG_Database()))+")")
          If response="1" Or response="5"
            source_file$=#DOUBLEQUOTE$+source_folder$+"Covers\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Covers_ECS_Laced\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\igame.iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -resize 160 206 -rtype mitchell -floyd -colours 16 "+source_file$,"",#PB_Program_Wait) ; IGame ECS Laced           
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Covers_AGA_Laced\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\igame.iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -resize 160 206 -rtype mitchell -floyd "+source_file$,"",#PB_Program_Wait)             ; IGame AGA Laced
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Covers_ECS_LoRes\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\igame.iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -resize 160 104 -rtype mitchell -floyd -colours 16 "+source_file$,"",#PB_Program_Wait) ; IGame ECS LoRes      
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Covers_AGA_LoRes\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\igame.iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -resize 160 104 -rtype mitchell -floyd "+source_file$,"",#PB_Program_Wait)             ; IGame AGA LoRes
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Covers_RTG\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\igame.iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 "+source_file$,"",#PB_Program_Wait)                                                      ; IGame RTG
            EndIf
            source_file$=#DOUBLEQUOTE$+source_folder$+"Screenshots\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Screens_ECS_Laced\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\igame.iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -resize 160 128 -rtype quick -floyd -colours 16 "+source_file$,"",#PB_Program_Wait) ; IGame ECS Laced           
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Screens_AGA_Laced\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\igame.iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -resize 160 128 -rtype quick -floyd "+source_file$,"",#PB_Program_Wait)             ; IGame AGA Laced
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Screens_ECS_LoRes\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\igame.iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -resize 160 64 -rtype quick -floyd -colours 16 "+source_file$,"",#PB_Program_Wait) ; IGame ECS LoRes      
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Screens_AGA_LoRes\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\igame.iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -resize 160 64 -rtype quick -floyd "+source_file$,"",#PB_Program_Wait)             ; IGame AGA LoRes
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Screens_RTG\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\igame.iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 "+source_file$,"",#PB_Program_Wait)                                                      ; IGame RTG
            EndIf
            source_file$=#DOUBLEQUOTE$+source_folder$+"Titles\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Titles_ECS_Laced\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\igame.iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -resize 160 128 -rtype quick -floyd -colours 16 "+source_file$,"",#PB_Program_Wait) ; IGame ECS Laced           
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Titles_AGA_Laced\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\igame.iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -resize 160 128 -rtype quick -floyd "+source_file$,"",#PB_Program_Wait)             ; IGame AGA Laced
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Titles_ECS_LoRes\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\igame.iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -resize 160 64 -rtype quick -floyd -colours 16 "+source_file$,"",#PB_Program_Wait) ; IGame ECS LoRes      
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Titles_AGA_LoRes\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\igame.iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -resize 160 64 -rtype quick -floyd "+source_file$,"",#PB_Program_Wait)             ; IGame AGA LoRes
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Titles_RTG\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\igame.iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 "+source_file$,"",#PB_Program_Wait)                                                      ; IGame RTG
            EndIf
          EndIf
          
          If response="2" Or response="5"
            source_file$=#DOUBLEQUOTE$+source_folder$+"Covers\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Covers_ECS_LoRes\"+IG_Database()\IG_Type+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -resize 320 128 -rtype mitchell -colors 16 -floyd "+source_file$,"",#PB_Program_Wait)                                       ; AGS ECS LoRes
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Covers_AGA_LoRes\"+IG_Database()\IG_Type+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -resize 320 128 -rtype mitchell -colors 216 -floyd "+source_file$,"",#PB_Program_Wait)                                                    ; AGS AGA LoRes
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Covers_ECS_HiRes\"+IG_Database()\IG_Type+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -ratio -resize 640 400 -rtype mitchell -canvas 640 400 center -colors 16 -floyd "+source_file$,"",#PB_Program_Wait)               ; AGS ECS HiRes
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Covers_AGA_HiRes\"+IG_Database()\IG_Type+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -ratio -resize 640 400 -rtype mitchell -canvas 640 400 center -colors 216 -floyd "+source_file$,"",#PB_Program_Wait)                           ; AGS AGA HiRes
            EndIf
            source_file$=#DOUBLEQUOTE$+source_folder$+"Screenshots\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Screens_ECS_LoRes\"+IG_Database()\IG_Type+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -resize 320 128 -rtype quick -colors 16 -floyd "+source_file$,"",#PB_Program_Wait)                                       ; AGS ECS LoRes
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Screens_AGA_LoRes\"+IG_Database()\IG_Type+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -resize 320 128 -rtype quick -colors 216 -floyd "+source_file$,"",#PB_Program_Wait)                                                    ; AGS AGA LoRes
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Screens_ECS_HiRes\"+IG_Database()\IG_Type+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -ratio -resize 640 400 -rtype quick -canvas 640 400 center -colors 16 -floyd "+source_file$,"",#PB_Program_Wait)               ; AGS ECS HiRes
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Screens_AGA_HiRes\"+IG_Database()\IG_Type+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -ratio -resize 640 400 -rtype quick -canvas 640 400 center -colors 216 -floyd "+source_file$,"",#PB_Program_Wait)                           ; AGS AGA HiRes
            EndIf
            source_file$=#DOUBLEQUOTE$+source_folder$+"Titles\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Titles_ECS_LoRes\"+IG_Database()\IG_Type+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -resize 320 128 -rtype quick -colors 16 -floyd "+source_file$,"",#PB_Program_Wait)                                       ; AGS ECS LoRes
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Titles_AGA_LoRes\"+IG_Database()\IG_Type+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -resize 320 128 -rtype quick -colors 216 -floyd "+source_file$,"",#PB_Program_Wait)                                                    ; AGS AGA LoRes
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Titles_ECS_HiRes\"+IG_Database()\IG_Type+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -ratio -resize 640 400 -rtype quick -canvas 640 400 center -colors 16 -floyd "+source_file$,"",#PB_Program_Wait)               ; AGS ECS HiRes
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Titles_AGA_HiRes\"+IG_Database()\IG_Type+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -ratio -resize 640 400 -rtype quick -canvas 640 400 center -colors 216 -floyd "+source_file$,"",#PB_Program_Wait)                           ; AGS AGA HiRes
            EndIf
          EndIf
          
          If response="3" Or response="5"
            source_file$=#DOUBLEQUOTE$+source_folder$+"Covers\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"TinyLauncher\"+IG_Database()\IG_Type+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+"_SCR1.iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -ratio -resize 640 400 -rtype mitchell -canvas 640 400 center -colors 16 -floyd "+source_file$,"",#PB_Program_Wait)
            EndIf
            source_file$=#DOUBLEQUOTE$+source_folder$+"Screenshots\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"TinyLauncher\"+IG_Database()\IG_Type+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+"_SCR0.iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -colors 32 -floyd "+source_file$,"",#PB_Program_Wait)
            EndIf
            If IG_Database()\IG_Type<>"Demo"
              source_file$=#DOUBLEQUOTE$+source_folder$+"Titles\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
              If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
                new_file$=#DOUBLEQUOTE$+dest_folder$+"TinyLauncher\"+IG_Database()\IG_Type+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+"_SCR2.iff"+#DOUBLEQUOTE$
                RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 -colors 32 -floyd "+source_file$,"",#PB_Program_Wait)
              EndIf
            EndIf
          EndIf

          If response="4"  Or response="5"
            source_file$=#DOUBLEQUOTE$+source_folder$+"Covers\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"PNG_Covers\"+IG_Database()\IG_Type+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out png -o "+new_file$+" "+source_file$,"",#PB_Program_Wait)
            EndIf
            source_file$=#DOUBLEQUOTE$+source_folder$+"Screenshots\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"PNG_Screens\"+IG_Database()\IG_Type+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out png -o "+new_file$+" "+source_file$,"",#PB_Program_Wait)
            EndIf
            source_file$=#DOUBLEQUOTE$+source_folder$+"Titles\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"PNG_Titles\"+IG_Database()\IG_Type+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out png -o "+new_file$+" "+source_file$,"",#PB_Program_Wait)
            EndIf 
          EndIf 
          
;           If response="6"  Or response="5"
;             source_file$=#DOUBLEQUOTE$+source_folder$+"Covers\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
;             If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
;               new_file$=#DOUBLEQUOTE$+dest_folder$+"PNG_Covers\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
;               RunProgram(nconvert_path,"-quiet -out png -o "+new_file$+" "+source_file$,"",#PB_Program_Wait)
;             EndIf
;             source_file$=#DOUBLEQUOTE$+source_folder$+"Screenshots\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
;             If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
;               new_file$=#DOUBLEQUOTE$+dest_folder$+"PNG_Screens\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
;               RunProgram(nconvert_path,"-quiet -out png -o "+new_file$+" "+source_file$,"",#PB_Program_Wait)
;             EndIf
;             source_file$=#DOUBLEQUOTE$+source_folder$+"Titles\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
;             If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
;               new_file$=#DOUBLEQUOTE$+dest_folder$+"PNG_Titles\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
;               RunProgram(nconvert_path,"-quiet -out png -o "+new_file$+" "+source_file$,"",#PB_Program_Wait)
;             EndIf 
;           EndIf 
          
          If response="6"
            source_file$=#DOUBLEQUOTE$+source_folder$+"Covers\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IFF_Covers\"+IG_Database()\IG_Type+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 "+source_file$,"",#PB_Program_Wait)
            EndIf
            source_file$=#DOUBLEQUOTE$+source_folder$+"Screenshots\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IFF_Screens\"+IG_Database()\IG_Type+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 "+source_file$,"",#PB_Program_Wait)
            EndIf
            source_file$=#DOUBLEQUOTE$+source_folder$+"Titles\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IFF_Titles\"+IG_Database()\IG_Type+"\"+GetFilePart(IG_Database()\IG_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              RunProgram(nconvert_path,"-quiet -out iff -o "+new_file$+" -c 1 "+source_file$,"",#PB_Program_Wait)
            EndIf 
          EndIf
        Next
      EndIf
      CloseConsole()
    EndIf
  EndIf

  SetCurrentDirectory(Home_Path)
  
EndProcedure

Procedure Check_Missing_Images(type.i)
  
  Protected path2.s
  
  ForEach IG_Database()  
    IG_Database()\IG_Image_Avail=#False
    IG_Database()\IG_Cover_Avail=#False

    If type=1
      path=Game_Img_Path+"Screenshots\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"
      If FileSize(path)>0
        IG_Database()\IG_Image_Avail=#True
      Else
        IG_Database()\IG_Image_Avail=#False
      EndIf
    EndIf
    
    If type=2
      path2=Game_Img_Path+"Covers\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"
      If FileSize(path2)>0
        IG_Database()\IG_Cover_Avail=#True
      Else
        IG_Database()\IG_Cover_Avail=#False
      EndIf
    EndIf
    
    If type=3
      path=Game_Img_Path+"Titles\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"
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
  
  If GetGadgetState(#MAIN_PANEL)=0
    If type=1
      If TitleScreen
        path=Game_Img_Path+"Titles\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"
      Else
        path=Game_Img_Path+"Screenshots\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"
      EndIf
      ww=480 : wh=384
    EndIf
    
    If type=2
      path=Game_Img_Path+"Covers\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"
      ww=480 : wh=620
    EndIf
  EndIf
  
  If GetGadgetState(#MAIN_PANEL)=1
    If type=1
      If TitleScreen
        path=Game_Img_Path+"CD32\Titles\"+CD32_Database()\CD_Title+".png"
      Else
        path=Game_Img_Path+"CD32\Screenshots\"+CD32_Database()\CD_Title+".png"
      EndIf
      ww=480 : wh=384
    EndIf
    
    If type=2
      path=Game_Img_Path+"CD32\Covers\"+CD32_Database()\CD_Title+".png"
      ww=480 : wh=620
    EndIf
  EndIf

  If LoadImage(#IFF_POPUP,path)
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
        
        If pevent=#WM_KEYUP
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
    EndIf 
    FreeImage(#IFF_POPUP)
    DisableWindow(#MAIN_WINDOW,#False)
    
    If GetGadgetState(#MAIN_PANEL)=0 : SetActiveGadget(Main_List) : EndIf
    If GetGadgetState(#MAIN_PANEL)=1 : SetActiveGadget(CD32_List) : EndIf
    
  EndIf


EndProcedure

Procedure Path_Window()
  
  Protected Path_Game_String, Path_Demo_String, Path_Beta_String, Path_LHA_String, Path_LZX_String, Path_Temp_String, Path_UAE_String, Path_Game_Button, Path_Demo_Button
  Protected Path_Beta_Button, Path_LHA_Button, Path_LZX_Button, Path_Temp_Button, Path_UAE_Button, Path_WinUAE_String, Path_WinUAE_Button
  Protected Path_Genres_Button, Path_Genres_String, Path_Database_Button, Path_Database_String, Path_CD32_Button, Path_CD32_String, Path_NConvert_String, Path_NConvert_Button
  Protected Path_Amiga_String, Path_Amiga_Button, Path_IGame_String, Path_IGame_Button, Path_Game_LHA_String, Path_Demo_LHA_String, Path_Beta_LHA_String, Path_Game_LHA_Button, Path_Demo_LHA_Button, Path_Beta_LHA_Button
  Protected old_pos, old_gadget_list, Path_Update_String, Path_Update_Button
  Protected change.b=#False

  old_pos=GetGadgetState(Main_List)
  
  If OpenWindow(#PATH_WINDOW, 0, 0, 490, 280, "IG_Tool Paths", #PB_Window_SystemMenu|#PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
    
    old_gadget_list=UseGadgetList(WindowID(#PATH_WINDOW))
    
    Path_Game_String = StringGadget(#PB_Any, 130, 10, 300, 20, Game_Img_Path, #PB_String_ReadOnly)
    Path_Game_Button = ButtonGadget(#PB_Any, 440, 10, 40, 20, "Set")
    Path_LHA_String = StringGadget(#PB_Any, 130, 40, 300, 20, LHA_Path, #PB_String_ReadOnly)
    Path_LHA_Button = ButtonGadget(#PB_Any, 440, 40, 40, 20, "Set")
    Path_LZX_String = StringGadget(#PB_Any, 130, 70, 300, 20, LZX_Path, #PB_String_ReadOnly)
    Path_LZX_Button = ButtonGadget(#PB_Any, 440, 70, 40, 20, "Set")
    Path_Temp_String = StringGadget(#PB_Any, 130, 100, 300, 20, WHD_TempDir, #PB_String_ReadOnly)
    Path_Temp_Button = ButtonGadget(#PB_Any, 440, 100, 40, 20, "Set")
    Path_UAE_String = StringGadget(#PB_Any, 130, 130, 300, 20, Config_Path, #PB_String_ReadOnly)
    Path_UAE_Button = ButtonGadget(#PB_Any, 440, 130, 40, 20, "Set")
    Path_WinUAE_String = StringGadget(#PB_Any, 130, 160, 300, 20, WinUAE_Path, #PB_String_ReadOnly)
    Path_WinUAE_Button = ButtonGadget(#PB_Any, 440, 160, 40, 20, "Set")
    Path_Game_LHA_String = StringGadget(#PB_Any, 130, 190, 300, 20, WHD_Folder, #PB_String_ReadOnly)
    Path_Game_LHA_Button = ButtonGadget(#PB_Any, 440, 190, 40, 20, "Set")
    Path_Genres_String = StringGadget(#PB_Any, 130, 220, 300, 20, Data_Path, #PB_String_ReadOnly)
    Path_Genres_Button = ButtonGadget(#PB_Any, 440, 220, 40, 20, "Set")
    Path_NConvert_String = StringGadget(#PB_Any, 130, 250, 300, 20, NConvert_Path, #PB_String_ReadOnly)
    Path_NConvert_Button = ButtonGadget(#PB_Any, 440, 250, 40, 20, "Set")

    TextGadget(#PB_Any, 10,  12, 110, 20, "Game Image Folder", #PB_Text_Right)
    TextGadget(#PB_Any, 10,  42, 110, 30, "LHA Archiver", #PB_Text_Right)
    TextGadget(#PB_Any, 10,  72, 110, 20, "LZX Archiver", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 102, 110, 20, "Temp Folder", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 132, 110, 20, "Config Path", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 162, 110, 20, "WinUAE Path", #PB_Text_Right) 
    TextGadget(#PB_Any, 10, 192, 110, 20, "WHD Archive Path", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 222, 110, 20, "Data Path", #PB_Text_Right) 
    TextGadget(#PB_Any, 10, 252, 110, 20, "NConvert Path", #PB_Text_Right) 

    Repeat
      
      event=WaitWindowEvent()
      
      Select event
          
        Case #PB_Event_Gadget
          Select EventGadget()
              
            Case Path_Game_Button
              path=PathRequester("Game Image Path",Game_Img_Path)
              If path<>"" : Game_Img_Path=path : SetGadgetText(Path_Game_String,Game_Img_Path) : change=#True : EndIf
            Case Path_LHA_Button
              path=OpenFileRequester("LHA Path",LHA_Path,"*.exe",0)
              If path<>"" : LHA_Path=path : SetGadgetText(Path_LHA_String,LHA_Path) : change=#True : EndIf
            Case Path_LZX_Button
              path=OpenFileRequester("LZX Path",LZX_Path,"*.exe",0)
              If path<>"" : LZX_Path=path : SetGadgetText(Path_LZX_String,LZX_Path) : change=#True : EndIf
            Case Path_Temp_Button
              path=PathRequester("Temp Path",WHD_TempDir)
              If path<>"" : WHD_TempDir=path : SetGadgetText(Path_Temp_String,WHD_TempDir) : change=#True : EndIf
            Case Path_UAE_Button
              path=PathRequester("Config Path",Config_Path)
              If path<>"" : Config_Path=path : SetGadgetText(Path_UAE_String,Config_Path) : change=#True : EndIf
            Case Path_WinUAE_Button
              path=OpenFileRequester("WinUAE Path",WinUAE_Path,"*.exe",0)
              If path<>"" : WinUAE_Path=path : SetGadgetText(Path_WinUAE_String,WinUAE_Path) : change=#True : EndIf
            Case Path_Game_LHA_Button
              path=PathRequester("WHD Archive Path",WHD_Folder)
              If path<>"" : WHD_Folder=path : SetGadgetText(Path_Game_LHA_String,WHD_Folder) : change=#True : EndIf    
            Case Path_Genres_Button
              path=PathRequester("Genres Path",Data_Path)
              If path<>"" : Data_Path=path : SetGadgetText(Path_Genres_String,Data_Path) : change=#True : EndIf
            Case Path_Database_Button
              path=PathRequester("Database Path",DB_Path)
              If path<>"" : DB_Path=path : SetGadgetText(Path_Database_String,DB_Path) : change=#True : EndIf
            Case Path_NConvert_Button
              path=PathRequester("Nconvert Path",NConvert_Path)
              If path<>"" : NConvert_Path=path : SetGadgetText(Path_NConvert_String,NConvert_Path) : change=#True : EndIf
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

Procedure Load_CD32_DB()
  
  Protected lFileSize, lFile, lUncompressedSize, lJSON, *lJSONBufferCompressed, *lJSONBuffer
  
  path=Data_Path+"um_cd32"
  
  lFileSize = FileSize(path+".dat")
  If lFileSize
    lFile = ReadFile(#PB_Any, path+".dat")
    If lFile
      *lJSONBufferCompressed = AllocateMemory(lFileSize)
      *lJSONBuffer = AllocateMemory(lFileSize*60)       
      ReadData(lFile, *lJSONBufferCompressed, lFileSize)
      lUncompressedSize = UncompressMemory(*lJSONBufferCompressed, lFileSize, *lJSONBuffer, lFileSize*60, #PB_PackerPlugin_Lzma)
      lJSON = CatchJSON(#PB_Any, *lJSONBuffer, lUncompressedSize)
      FreeMemory(*lJSONBuffer)
      FreeMemory(*lJSONBufferCompressed)
      CloseFile(lFile)
      ExtractJSONList(JSONValue(lJSON), CD32_Database()) 
    EndIf
  EndIf
  
;   Else
    ;MessageRequester("Error", "Select JSON Backup!", #PB_MessageRequester_Error|#PB_MessageRequester_Ok)   
;     path+".json"
;     If path<>""
;       lfile=LoadJSON(#PB_Any, path, #PB_JSON_NoCase)
;       ExtractJSONList(JSONValue(lfile), CD32_Database())
;     EndIf
;   EndIf   
    
    ForEach CD32_Database()
      CD32_Database()\CD_Filtered=#False  
    Next
        
EndProcedure

Procedure Load_DB()
  
  Protected lFileSize, lFile, lUncompressedSize, lJSON, *lJSONBufferCompressed, *lJSONBuffer
  
  path=Data_Path+"um_whd"
  
  ClearList(Fix_List())

  lFileSize = FileSize(path+".dat")
  If lFileSize
    lFile = ReadFile(#PB_Any, path+".dat")
    If lFile
      *lJSONBufferCompressed = AllocateMemory(lFileSize)
      *lJSONBuffer = AllocateMemory(lFileSize*60)       
      ReadData(lFile, *lJSONBufferCompressed, lFileSize)
      lUncompressedSize = UncompressMemory(*lJSONBufferCompressed, lFileSize, *lJSONBuffer, lFileSize*60, #PB_PackerPlugin_Lzma)
      lJSON = CatchJSON(#PB_Any, *lJSONBuffer, lUncompressedSize)
      FreeMemory(*lJSONBuffer)
      FreeMemory(*lJSONBufferCompressed)
      CloseFile(lFile)
      ExtractJSONList(JSONValue(lJSON), Fix_List()) 
    EndIf
;   Else
;MessageRequester("Error", "Select JSON Backup!", #PB_MessageRequester_Error|#PB_MessageRequester_Ok)   
;   path+".json"
;   If path<>""
;     lfile=LoadJSON(#PB_Any, path, #PB_JSON_NoCase)
;     ExtractJSONList(JSONValue(lfile), Fix_List())
;   EndIf
  EndIf  
;     
    If ListSize(Fix_List())>0
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
        IG_Database()\IG_Publisher=Fix_List()\F_Publisher
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
        IG_Database()\IG_Short=Fix_List()\F_Short
        IG_Database()\IG_Year=Fix_List()\F_Year
        IG_Database()\IG_Config=Fix_List()\F_Config
        IG_Database()\IG_Default_Icon=Fix_List()\F_Default_Icon
        ForEach Fix_List()\F_Icons()
          AddElement(IG_Database()\IG_Icons())
          IG_Database()\IG_Icons()=Fix_List()\F_Icons()
        Next
      Next
    EndIf
  
    Check_Availability()
    
EndProcedure
  
Procedure Save_CD32_DB()
    
  ClearList(Fix_List())
  
  Protected lFileSize, lFile, lJSONCompressedSize, lFileJSON, lJSON, lJSONSize, *lJSONBufferCompressed, *lJSONBuffer
  
  lJSON = CreateJSON(#PB_Any)
  
  If lJSON
    InsertJSONList(JSONValue(lJSON), CD32_Database())
    lJSONSize = ExportJSONSize(lJSON)
    *lJSONBuffer = AllocateMemory(lJSONSize)
    *lJSONBufferCompressed = AllocateMemory(lJSONSize)
    ExportJSON(lJSON, *lJSONBuffer, lJSONSize)
    lJSONCompressedSize = CompressMemory(*lJSONBuffer, lJSONSize, *lJSONBufferCompressed, lJSONSize, #PB_PackerPlugin_Lzma)
    lFileJSON = CreateFile(#PB_Any, Data_Path+"um_cd32.dat")
    WriteData(lFileJSON, *lJSONBufferCompressed, lJSONCompressedSize)
    CloseFile(lFileJSON)
    FreeJSON(lJSON)
    FreeMemory(*lJSONBuffer)
    FreeMemory(*lJSONBufferCompressed )
  EndIf 
  
  If JSON_Backup
    lJSON = CreateJSON(#PB_Any)
    InsertJSONList(JSONValue(lJSON), CD32_Database())
    SaveJSON(lJSON,Data_Path+"um_cd32.json",#PB_JSON_PrettyPrint)
    FreeJSON(lJSON)
  EndIf
  
  ClearList(Fix_List())
  
EndProcedure
  
Procedure Save_DB()
  
  ClearList(Fix_List())
  
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
    Fix_List()\F_Publisher=IG_Database()\IG_Publisher
    Fix_List()\F_Type=IG_Database()\IG_Type
    Fix_List()\F_Year=IG_Database()\IG_Year
    Fix_List()\F_Config=IG_Database()\IG_Config
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
    lJSONCompressedSize = CompressMemory(*lJSONBuffer, lJSONSize, *lJSONBufferCompressed, lJSONSize, #PB_PackerPlugin_Lzma)
    lFileJSON = CreateFile(#PB_Any,Data_Path+"um_whd.dat")
    WriteData(lFileJSON, *lJSONBufferCompressed, lJSONCompressedSize)
    CloseFile(lFileJSON)
    FreeJSON(lJSON)
    FreeMemory(*lJSONBuffer)
    FreeMemory(*lJSONBufferCompressed )
  EndIf 
  
  If JSON_Backup
    lJSON = CreateJSON(#PB_Any)
    InsertJSONList(JSONValue(lJSON), Fix_List())
    SaveJSON(lJSON,Data_Path+"um_whd.json",#PB_JSON_PrettyPrint)
    FreeJSON(lJSON)
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
                IG_Database()\IG_Publisher=""
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
  
  Debug path
  
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
  CreatePreferences(Data_Path+"um.prefs")
  PreferenceGroup("Paths")
  WritePreferenceString("Game_Img_Path",Game_Img_Path)
  WritePreferenceString("LHA_Path",LHA_Path)
  WritePreferenceString("LZX_Path",LZX_Path)
  WritePreferenceString("Temp_Path",WHD_TempDir)
  WritePreferenceString("UAECFG_Path",Config_Path)
  WritePreferenceString("WHD_Path",WHD_Folder)
  WritePreferenceString("WinUAE_Path",WinUAE_Path)
  WritePreferenceString("Data_Path",Data_Path)
  WritePreferenceLong("IFF_Smooth",IFF_Smooth)
  WritePreferenceLong("JSON_Backup",JSON_Backup)
  ClosePreferences()
EndProcedure

Procedure Load_Prefs()
  
    If OpenPreferences(Data_Path+"um.prefs")
      PreferenceGroup("Paths")
      Game_Img_Path=ReadPreferenceString("Game_Img_Path",Game_Img_Path)
      LHA_Path=ReadPreferenceString("LHA_Path",LHA_Path)
      LZX_Path=ReadPreferenceString("LZX_Path",LZX_Path)
      WHD_TempDir=ReadPreferenceString("Temp_Path",WHD_TempDir)
      Config_Path=ReadPreferenceString("UAECFG_Path",Config_Path)
      WHD_Folder=ReadPreferenceString("WHD_Path",WHD_Folder)
      WinUAE_Path=ReadPreferenceString("WinUAE_Path",WinUAE_Path)
      Data_Path=ReadPreferenceString("Data_Path",Data_Path)
      IFF_Smooth=ReadPreferenceLong("IFF_Smooth",#PB_Image_Raw)
      JSON_Backup=ReadPreferenceLong("JSON_Backup",JSON_Backup)
      ClosePreferences()
    EndIf

EndProcedure

Procedure Choose_Icon()
  
  Protected NewList Icon_List.s()
  
  Protected IG_Program.i
  Protected ReadO$, oldpath.s
  
  path=WHD_Folder+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")
  
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
  PrintS()
  
  ClearList(IG_Database()\IG_Icons())
  
  CopyList(Icon_List(),IG_Database()\IG_Icons())
  
  count=1
  
  ForEach Icon_List()
    PrintN(Str(count)+": "+Icon_List())
    count+1
  Next
  PrintN("C: Cancel")
  PrintS()
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
      PrintS()
      PrintN("Error! Invalid Number")    
      Delay(2000)
    EndIf
  Else
    If LCase(path)<>"c"
      ConsoleColor(4,0)
      PrintS()
      PrintN("Error! Invalid Entry") 
      Delay(2000)
    EndIf    
  EndIf
  
  CloseConsole()
  
  FreeList(Icon_List())
  
EndProcedure

Procedure Edit_CD32(number) 
  
  SelectElement(CD32_Database(),number)
  
  ClearList(Genre_List.s())
  
  Protected change.b=#False, oldindex.s, star.s
  Protected old_gadget_list, old_pos
  Protected Title_String, Language_String, Archive_String, Coder_String, Genre_Combo, Year_String
  Protected Mouse_Check, Keyboard_Check, Config_Combo, Close_Button, Memory_String, Compilation_Check

  old_pos=GetGadgetState(CD32_List)
  
  DisableWindow(#MAIN_WINDOW,#True)
  
  If OpenWindow(#EDIT_WINDOW, 0, 0, 424, 264, "Edit Database", #PB_Window_SystemMenu | #PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
    
    Pause_Window(#EDIT_WINDOW)
    
    old_gadget_list=UseGadgetList(WindowID(#EDIT_WINDOW))
    
    TextGadget(#PB_Any, 8, 10, 60, 20, "Title", #PB_Text_Center)    
    Title_String = StringGadget(#PB_Any, 80, 8, 336, 24, CD32_Database()\CD_Title)
    TextGadget(#PB_Any, 8, 74, 60, 20, "Language", #PB_Text_Center) 
    Language_String = StringGadget(#PB_Any, 80, 72, 336, 24, CD32_Database()\CD_Language)
    TextGadget(#PB_Any, 8, 106, 60, 20, "File", #PB_Text_Center)   
    Archive_String = StringGadget(#PB_Any, 80, 104, 336, 24, CD32_Database()\CD_File)
    TextGadget(#PB_Any, 8, 138, 60, 20, "Publisher", #PB_Text_Center)  
    Coder_String = StringGadget(#PB_Any, 80, 136, 336, 24, CD32_Database()\CD_Publisher)
    TextGadget(#PB_Any, 8, 42, 60, 20, "Genre", #PB_Text_Center)
    Genre_Combo = ComboBoxGadget(#PB_Any, 80, 40, 336, 24)
    TextGadget(#PB_Any, 184, 170, 30, 20, "Year", #PB_Text_Right)
    Year_String = StringGadget(#PB_Any, 224, 168, 88, 24, CD32_Database()\CD_Year)
    Mouse_Check = CheckBoxGadget(#PB_Any, 24, 168, 112, 20, "Requires Mouse")
    Keyboard_Check = CheckBoxGadget(#PB_Any, 24, 200, 128, 20, "Requires Keyboard")
    TextGadget(#PB_Any, 166, 234, 50, 20, "Config", #PB_Text_Center)
    Config_Combo = ComboBoxGadget(#PB_Any, 224, 232, 88, 24)
    Close_Button = ButtonGadget(#PB_Any, 320, 168, 96, 88, "Close")
    Memory_String = StringGadget(#PB_Any, 224, 200, 88, 24, CD32_Database()\CD_Ram)
    TextGadget(#PB_Any, 168, 202, 50, 20, "Memory", #PB_Text_Right)
    Compilation_Check = CheckBoxGadget(#PB_Any, 24, 232, 96, 20, "Compilation")
    
    AddGadgetItem(Config_Combo,-1,"CD32")
    AddGadgetItem(Config_Combo,-1,"CD32-4MB")
    AddGadgetItem(Config_Combo,-1,"CD32-8MB")
    SetGadgetState(Config_Combo,CD32_Database()\CD_Config)
    
    If ReadFile(g_file,Data_Path+"um_genres.dat")
      
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
        If Genre_List()=CD32_Database()\CD_Genre
          SetGadgetState(Genre_Combo,ListIndex(Genre_List()))
          Break     
        EndIf
      Next  
      
    Else
      
      MessageRequester("Error","Cannot find genres file!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
      
    EndIf

    SetGadgetState(Mouse_Check,CD32_Database()\CD_Mouse)
    SetGadgetState(Keyboard_Check,CD32_Database()\CD_Keyboard)
    SetGadgetState(Compilation_Check,CD32_Database()\CD_Compilation)
    
    Resume_Window(#EDIT_WINDOW)
    
    SetActiveGadget(Title_String)
    
    oldindex=CD32_Database()\CD_Title
    
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
            Case Title_String
              If EventType()=#PB_EventType_Change
                CD32_Database()\CD_Title=GetGadgetText(Title_String)
                change=#True
              EndIf
            Case Language_String
              If EventType()=#PB_EventType_Change
                CD32_Database()\CD_Language=GetGadgetText(Language_String)
                change=#True
              EndIf
            Case Archive_String
              If EventType()=#PB_EventType_Change
                CD32_Database()\CD_File=GetGadgetText(Archive_String)
                change=#True
              EndIf
            Case Coder_String
              If EventType()=#PB_EventType_Change
                CD32_Database()\CD_Publisher=GetGadgetText(Coder_String)
                change=#True
              EndIf
            Case Genre_Combo
              CD32_Database()\CD_Genre=GetGadgetText(Genre_Combo)
              change=#True
            Case Year_String
              If EventType()=#PB_EventType_Change
                CD32_Database()\CD_Year=GetGadgetText(Year_String)
                change=#True
              EndIf  
            Case Memory_String
              If EventType()=#PB_EventType_Change
                CD32_Database()\CD_Ram=GetGadgetText(Memory_String)
                change=#True
              EndIf            
            Case Mouse_Check
              CD32_Database()\CD_Mouse=GetGadgetState(Mouse_Check)
              change=#True
            Case Keyboard_Check
              CD32_Database()\CD_Keyboard=GetGadgetState(Keyboard_Check)
              change=#True
            Case Compilation_Check
              CD32_Database()\CD_Compilation=GetGadgetState(Compilation_Check)
              change=#True     
            Case Config_Combo
              CD32_Database()\CD_Config=GetGadgetState(Config_Combo)
              change=#True
            Case Close_Button
              Break
              
          EndSelect
          
        Case #PB_Event_CloseWindow  
          Break
          
      EndSelect
      
    ForEver
    
    UseGadgetList(old_gadget_list) 
    
    CloseWindow(#EDIT_WINDOW)  
    
    DisableWindow(#MAIN_WINDOW,#False)
    
    If change 
      If CD32_Database()\CD_Genre="Unknown" : star="*" : Else : star="" : EndIf
      SetGadgetItemText(CD32_List,old_pos,star+CD32_Database()\CD_Title+CD32_Title_Extras())
      Update_StatusBar()
      Save_CD32_DB()
    EndIf
        
    SetActiveGadget(CD32_List)
    
    SetGadgetState(CD32_List,old_pos)
    
  EndIf
  
EndProcedure

Procedure Edit_GL(number) 
  
  SelectElement(IG_Database(),number)
  
  ClearList(Genre_List.s())
  
  Protected change.b=#False, oldindex.s, star.s
  Protected old_gadget_list, old_pos, title_string, language_string, path_string, Frame_0, AGA_Check, CD32_Check,  Preview_Check, Files_Check, Image_Check, NoIntro_Check, Date_String, icon_string, icon_button, Close_Button
  Protected CDTV_Check, MT32_Check, Memory_String, Genre_Combo, CDROM_Check, Arcadia_Check, Demo_Check, Intro_Check, Cover_Check, NTSC_Check, Disk_String, Coder_String, Type_Combo, File_Button, Update_Button, Config_Combo
  Protected Year_String, Cancel_Button, Short_String
  
  old_pos=GetGadgetState(Main_List)
  
  DisableWindow(#MAIN_WINDOW,#True)
  
  If OpenWindow(#EDIT_WINDOW, 0, 0, 424, 408, "Edit Database", #PB_Window_SystemMenu | #PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
    
    Pause_Window(#EDIT_WINDOW)
    
    old_gadget_list=UseGadgetList(WindowID(#EDIT_WINDOW))
    
    TextGadget(#PB_Any, 8, 10, 60, 20, "Title", #PB_Text_Center)    
    title_string = StringGadget(#PB_Any, 80, 8, 336, 24, IG_Database()\IG_Title)
    TextGadget(#PB_Any, 8, 42, 60, 20, "Short Title", #PB_Text_Center)    
    title_string = StringGadget(#PB_Any, 80, 40, 336, 24, IG_Database()\IG_Short)
    TextGadget(#PB_Any, 8, 74, 60, 20, "Language", #PB_Text_Center)
    language_string = StringGadget(#PB_Any, 80, 72, 336, 24, IG_Database()\IG_Language)
    TextGadget(#PB_Any, 8, 106, 60, 20, "Archive", #PB_Text_Center) 
    path_string = StringGadget(#PB_Any, 80, 104, 336, 24, IG_Database()\IG_LHAFile)
    TextGadget(#PB_Any, 0, 136, 80, 20, "Default Icon", #PB_Text_Center)
    icon_string = StringGadget(#PB_Any, 80, 136, 250, 24, IG_Database()\IG_Default_Icon)
    icon_button = ButtonGadget(#PB_Any, 340, 136, 76, 24, "Choose")
    TextGadget(#PB_Any, 8, 170, 60, 20, "Publisher", #PB_Text_Center)
    coder_string = StringGadget(#PB_Any, 80, 170, 336, 24, IG_Database()\IG_Publisher)
    TextGadget(#PB_Any, 8, 206, 60, 20, "Slave Date", #PB_Text_Center)
    date_string = StringGadget(#PB_Any, 80, 202, 120, 24, IG_Database()\IG_Slave_Date)
    TextGadget(#PB_Any, 220, 206, 70, 20, "Year", #PB_Text_Center)
    year_string = StringGadget(#PB_Any, 290, 202, 126, 24, IG_Database()\IG_Year)
    Frame_0 = FrameGadget(#PB_Any, 8, 224, 408, 112, "")
    AGA_Check = CheckBoxGadget(#PB_Any, 16, 240, 60, 20, "AGA")
    CD32_Check = CheckBoxGadget(#PB_Any, 88, 240, 60, 20, "CD32")
    CDTV_Check = CheckBoxGadget(#PB_Any, 152, 240, 60, 20, "CDTV")
    MT32_Check = CheckBoxGadget(#PB_Any, 212, 240, 60, 20, "MT32")
    CDROM_Check = CheckBoxGadget(#PB_Any, 272, 240, 70, 20, "CD-ROM")
    NTSC_Check = CheckBoxGadget(#PB_Any, 352, 240, 60, 20, "NTSC")
    Arcadia_Check = CheckBoxGadget(#PB_Any, 16, 272, 60, 20, "Arcadia")
    Demo_Check = CheckBoxGadget(#PB_Any, 88, 272, 60, 20, "Demo")
    Intro_Check = CheckBoxGadget(#PB_Any, 152, 272, 56, 20, "Intro")
    NoIntro_Check = CheckBoxGadget(#PB_Any, 210, 272, 60, 20, "No Intro")
    TextGadget(#PB_Any, 280, 274, 50, 20, "Memory", #PB_Text_Right)  
    Memory_String = StringGadget(#PB_Any, 336, 272, 72, 24, IG_Database()\IG_Memory)
    Preview_Check = CheckBoxGadget(#PB_Any, 16, 304, 60, 20, "Preview", #PB_CheckBox_Center)
    Files_Check = CheckBoxGadget(#PB_Any, 88, 304, 60, 20, "Files")
    Image_Check = CheckBoxGadget(#PB_Any, 152, 304, 54, 20, "Image")
    Cover_Check = CheckBoxGadget(#PB_Any, 210, 304, 80, 20, "Cover Disk")
    TextGadget(#PB_Any, 296, 306, 36, 20, "Disks", #PB_Text_Right)
    Disk_String = StringGadget(#PB_Any, 336, 304, 72, 24, IG_Database()\IG_Disks)
    TextGadget(#PB_Any, 10, 346, 46, 20, "Type", #PB_Text_Center)
    Type_Combo = ComboBoxGadget(#PB_Any, 64, 344, 88, 24)
    TextGadget(#PB_Any, 158, 346, 50, 20, "Config", #PB_Text_Center)  
    Config_Combo = ComboBoxGadget(#PB_Any, 212, 344, 124, 24)
    TextGadget(#PB_Any, 8, 378, 60, 20, "Genre", #PB_Text_Center)
    Genre_Combo = ComboBoxGadget(#PB_Any, 80, 376, 336, 24) 
    Close_Button = ButtonGadget(#PB_Any, 344, 344, 72, 24, "Close")
    
    AddGadgetItem(Type_Combo,-1,"Unknown")
    AddGadgetItem(Type_Combo,-1,"Game")
    AddGadgetItem(Type_Combo,-1,"Demo")
    AddGadgetItem(Type_Combo,-1,"Beta")
    
    AddGadgetItem(Config_Combo,-1,"A1200")
    AddGadgetItem(Config_Combo,-1,"A1200-030")
    AddGadgetItem(Config_Combo,-1,"A1200-CD32")
    SetGadgetState(Config_Combo,IG_Database()\IG_Config)

    If ReadFile(g_file,Data_Path+"um_genres.dat")
      
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
    
    Resume_Window(#EDIT_WINDOW)
    
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
                IG_Database()\IG_Publisher=GetGadgetText(Coder_String)
                change=#True
              EndIf
            Case path_String
              If EventType()=#PB_EventType_Change
                IG_Database()\IG_LHAFile=GetGadgetText(path_String)
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
            Case Config_Combo
              IG_Database()\IG_Config=GetGadgetState(Config_Combo)
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
                IG_Database()\IG_Publisher=GetGadgetText(Coder_String)
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
            Case Close_Button
              Break
              
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
  MenuItem(#MenuItem_2,  "Run CD32")
  MenuBar()
  MenuItem(#MenuItem_4,  "Save Gameslist (Old)")
  MenuItem(#MenuItem_5,  "Save Gameslist (CSV)")
  MenuItem(#MenuItem_35, "Save Gameslist (DB)")
  MenuBar()
  MenuItem(#MenuItem_7,  "Save Database")
  MenuBar()
  MenuItem(#MenuItem_8,  "Quit")
  MenuTitle("Create")
  MenuItem(#MenuItem_32, "Make Image Folders")
  MenuTitle("Database")
  OpenSubMenu("Update")
  MenuItem(#MenuItem_16, "Update FTP")
  MenuItem(#MenuItem_39, "Update Amiga")
  MenuBar()
  MenuItem(#MenuItem_3,  "Update Full")
  CloseSubMenu()
  MenuItem(#MenuItem_11, "Check Availability")
  MenuItem(#MenuItem_1,  "Check Images")
  MenuItem(#MenuItem_27, "Update Icons")
  MenuBar() 
  MenuItem(#MenuItem_26, "Add CD32 Entry")
  MenuItem(#MenuItem_28, "Delete Entry")
  MenuItem(#MenuItem_12, "Edit Entry")
  MenuTitle("Settings")
  MenuItem(#MenuItem_14, "Set Paths")
  MenuBar()
  MenuItem(#MenuItem_34, "Close WinUAE On Exit")
  MenuItem(#MenuItem_20, "Smooth Images")
  MenuItem(#MenuItem_21, "Show Titles"+Chr(9)+"F3")
  MenuItem(#MenuItem_37, "Back-Up DB (JSON)")
  MenuBar()
  MenuItem(#MenuItem_15, "Reload Genres")
  MenuItem(#MenuItem_17, "Refresh"+Chr(9)+"F5")
  
  SetMenuItemState(Main_Menu,#MenuItem_34,Close_UAE)  
  SetMenuItemState(Main_Menu,#MenuItem_21,TitleScreen)  
  SetMenuItemState(Main_Menu,#MenuItem_37,JSON_Backup)  
  DisableMenuItem(Main_Menu,#MenuItem_26,1)

  PanelGadget(#MAIN_PANEL,0,0,496,742)
  AddGadgetItem(#MAIN_PANEL,1,"WHDLoad")
  Main_List = ListIconGadget(#PB_Any, 0, 0, 0, 0, "Column 1", 100, #PB_ListIcon_GridLines | #LVS_NOCOLUMNHEADER | #PB_ListIcon_FullRowSelect)
  SetWindowLongPtr_(GadgetID(Main_List),#GWL_EXSTYLE,0)
  SetWindowPos_(GadgetID(Main_List),0,0,0,GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemWidth),GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight)-30,#SWP_FRAMECHANGED)
  EnableGadgetDrop(Main_List,#PB_Drop_Files,#PB_Drag_Copy)
  TextGadget(#PB_Any, 0, GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight)-21, 30, 20, "Type", #PB_Text_Center)  
  Main_Type_Combo = ComboBoxGadget(#PB_Any, 40, GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight)-24, 60, 22)
  TextGadget(#PB_Any, 108, GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight)-21, 30, 20, "Genre", #PB_Text_Center)  
  Main_Genre_Combo = ComboBoxGadget(#PB_Any, 148, GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight)-24, 212, 22)
  TextGadget(#PB_Any, 364, GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight)-21, 30, 24, "Filter", #PB_Text_Center)  
  Main_Filter_Combo = ComboBoxGadget(#PB_Any, 402, GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight)-24, 80, 22)
  AddGadgetItem(#MAIN_PANEL,1,"CD32") 
  CD32_List = ListIconGadget(#PB_Any, 0, 0, GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemWidth), GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight), "Column 1", 100, #PB_ListIcon_GridLines | #LVS_NOCOLUMNHEADER | #PB_ListIcon_FullRowSelect)
  SetWindowPos_(GadgetID(CD32_List),0,0,0,GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemWidth),GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight),#SWP_FRAMECHANGED)
  CloseGadgetList()
  
  Play_Button = ButtonGadget(#PB_Any, 545, 716, 90, 24, "Run Program")
  GadgetToolTip(Play_Button, "Run Program")
  SaveDB_Button = ButtonGadget(#PB_Any, 640, 716, 90, 24, "Save Database")
  GadgetToolTip(SaveDB_Button, "Save Database")
  Edit_Button = ButtonGadget(#PB_Any, 735, 716, 90, 24, "Edit Entry")
  GadgetToolTip(Edit_Button, "Edit Entry")
    
  Main_Image = CanvasGadget(#PB_Any, 506, 24, 320, 256,#PB_Canvas_Border)
  main_image_title=TextGadget(#PB_Any, 506, 8, 88, 16, "Screenshot (F3)")
  EnableGadgetDrop(Main_Image,#PB_Drop_Files,#PB_Drag_Copy)
  
  Cover_Image = CanvasGadget(#PB_Any, 506, 300, 320, 412,#PB_Canvas_Border)
  TextGadget(#PB_Any, 506, 284, 88, 16, "Cover") 
  EnableGadgetDrop(Cover_Image,#PB_Drop_Files,#PB_Drag_Copy)


  SetGadgetItemAttribute(Main_List,0,#PB_ListIcon_ColumnWidth,GadgetWidth(Main_List)-4)

  AddGadgetItem(Main_Type_Combo,-1,"All")
  AddGadgetItem(Main_Type_Combo,-1,"Games")
  AddGadgetItem(Main_Type_Combo,-1,"Demos")
  AddGadgetItem(Main_Type_Combo,-1,"Beta")
  SetGadgetState(Main_Type_Combo,0)
  
  AddGadgetItem(Main_Filter_Combo,-1,"All")
  AddGadgetItem(Main_Filter_Combo,-1,"No Image")
  AddGadgetItem(Main_Filter_Combo,-1,"No Title")
  AddGadgetItem(Main_Filter_Combo,-1,"No Cover")
  AddGadgetItem(Main_Filter_Combo,-1,"No Publisher")
  AddGadgetItem(Main_Filter_Combo,-1,"No Year")
  AddGadgetItem(Main_Filter_Combo,-1,"Invalid Genre")
  AddGadgetItem(Main_Filter_Combo,-1,"Missing Type")
  AddGadgetItem(Main_Filter_Combo,-1,"Invalid Icon")
  AddGadgetItem(Main_Filter_Combo,-1,"No Icon")
  SetGadgetState(Main_Filter_Combo,0)
  
  AddGadgetItem(Main_Genre_Combo,-1,"All")
  
  If ReadFile(g_file,Data_Path+"um_genres.dat")
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

Procedure Init_Program()
  
  UsePNGImageDecoder()
  UseLZMAPacker()
  UseZipPacker()
  InitNetwork() 
  
  Load_Prefs()
  
  Draw_Main_Window()
  
  Window_Update()
  
  Load_DB()
  Load_CD32_DB()
  
  Draw_List()
  Draw_CD32_List()
  
  Draw_Info(0)
  
  SetGadgetState(#MAIN_PANEL,0)
  SetActiveGadget(Main_List)
  
  HideWindow(#MAIN_WINDOW,#False)
  
  SmartWindowRefresh(#MAIN_WINDOW,#True)
  
EndProcedure

Init_Program()

Repeat
  
  event=WaitWindowEvent()
  
  Select event
      
    Case #WM_KEYDOWN
      
      If GetGadgetState(#MAIN_PANEL)=0
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
          If EventwParam() = #VK_F3
            PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_21)
          EndIf
          If EventwParam() = #VK_F5
            PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_17)
          EndIf
          If EventwParam() = #VK_DELETE
            PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_28)
          EndIf
        EndIf
      EndIf
      
      If GetGadgetState(#MAIN_PANEL)=1
        If CountGadgetItems(CD32_List)>0
          If EventwParam() = #VK_RETURN
            If CountGadgetItems(CD32_List)>0
              SelectElement(CD32_Numbers(),GetGadgetState(CD32_List))
              Run_CD32(CD32_Numbers())
            EndIf 
          EndIf
          If EventwParam() = #VK_SPACE
            If CountGadgetItems(CD32_List)>0
              SelectElement(CD32_Numbers(),GetGadgetState(CD32_List))
              Edit_CD32(CD32_Numbers())
            EndIf
          EndIf
          If EventwParam() = #VK_F1
            Image_Popup(1)
          EndIf
          If EventwParam() = #VK_F2
            Image_Popup(2)
          EndIf
          If EventwParam() = #VK_F3
            PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_21)
          EndIf
          If EventwParam() = #VK_F5
            PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_17)
          EndIf
          If EventwParam() = #VK_DELETE
            PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_28)
          EndIf
        EndIf
      EndIf
      
    Case #PB_Event_Menu
      Select EventMenu()
        Case #MenuItem_1 ;{- Check Images
          Audit_Images()
          ;}          
        Case #MenuItem_2 ;{- Run CD32
           Run_CD32(CD32_Numbers());}
        Case #MenuItem_3 ;{- Append Games List)
          Update_FTP()
          Update_PC();}
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
              Pause_Window(#MAIN_WINDOW)
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
              If GetGadgetState(#MAIN_PANEL)=0
                Save_DB()
              EndIf
              If GetGadgetState(#MAIN_PANEL)=1
                Save_CD32_DB()
              EndIf
            EndIf
          EndIf ;}
        Case #MenuItem_8 ;{- Quit
          If MessageRequester("Exit UltraMiggy", "Do you want to quit?",#PB_MessageRequester_YesNo|#PB_MessageRequester_Warning)=#PB_MessageRequester_Yes
            Break
          EndIf ;}
        Case #MenuItem_11 ;{- Check Availability
          Check_Availability();}
        Case #MenuItem_12 ;{- Edit Entry
          If CountGadgetItems(Main_List)>0
            SelectElement(List_Numbers(),GetGadgetState(Main_List))
            Edit_GL(List_Numbers())
          EndIf ;}          
        Case #MenuItem_14 ;{- Set Paths
          Path_Window();}
        Case #MenuItem_15 ;{- Reload Genres
          If ReadFile(g_file,Data_Path+"um_genres.dat")
            Pause_Window(#MAIN_WINDOW)
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
            SetMenuItemText(Main_Menu,#MenuItem_21,"Show Titles"+Chr(9)+"F3")
            SetGadgetText(main_image_title,"Screenshot (F3)")
            TitleScreen=#False
          Else
            SetMenuItemText(Main_Menu,#MenuItem_21,"Show Screenshots"+Chr(9)+"F3")
            TitleScreen=#True
            SetGadgetText(main_image_title,"Title (F3)")
          EndIf
          
          If GetGadgetState(#MAIN_PANEL)=0 : Draw_Info(List_Numbers()) : EndIf
          If GetGadgetState(#MAIN_PANEL)=1 : Draw_CD32_Info(CD32_Numbers()) : EndIf
          
          ;}
        Case #MenuItem_26 ;{- Add CD32 Entry
          path=OpenFileRequester("Select CD32 Archive",CD32_Path,"*.zip",0)
          If path<>""
            AddElement(CD32_Database())
            CD32_Database()\CD_Title=GetFilePart(path)
            CD32_Database()\CD_File=GetFilePart(path)
            CD32_Database()\CD_Genre="Unknown"
            CD32_Database()\CD_Config=0
            SortStructuredList(CD32_Database(),#PB_Sort_Ascending|#PB_Sort_NoCase,OffsetOf(IG_Data\IG_Title),TypeOf(IG_Data\IG_Title))
            Draw_CD32_List()
            Draw_CD32_Info(0)              
          EndIf
          
          ;}  
        Case #MenuItem_27 ;{- Update Icons
          Update_Icons()
          ;}
        Case #MenuItem_28 ;{- Delete Entry
          If CountGadgetItems(Main_List)>0
            If MessageRequester("Delete Entry","Delete Current Entry?", #PB_MessageRequester_YesNo|#PB_MessageRequester_Warning)=#PB_MessageRequester_Yes
              
              If GetGadgetState(#MAIN_PANEL)=0
                SelectElement(List_Numbers(),GetGadgetState(Main_List))
                If GetGadgetState(Main_List)>0
                  list_pos=GetGadgetState(Main_List)-1
                Else
                  list_pos=0
                EndIf
                DeleteElement(IG_Database())
                Draw_List()
                SelectElement(List_Numbers(),list_pos)
                SetGadgetState(main_List,list_pos)
                Draw_Info(List_Numbers())
              EndIf
              
              If GetGadgetState(#MAIN_PANEL)=1
                
                If FileSize(CD32_Path+CD32_Database()\CD_File)>-1
                  CopyFile(CD32_Path+CD32_Database()\CD_File,Backup_Path+"Archives\"+GetFilePart(CD32_Database()\CD_File))
                  DeleteFile(CD32_Path+CD32_Database()\CD_File,#PB_FileSystem_Force)
                EndIf
                
                If FileSize(Game_Img_Path+"CD32\Covers\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".iff")>-1
                  CopyFile(Game_Img_Path+"CD32\Covers\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".iff",Backup_Path+"Covers\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".iff")
                  DeleteFile(Game_Img_Path+"CD32\Covers\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".iff",#PB_FileSystem_Force)
                EndIf
                
                If FileSize(Game_Img_Path+"CD32\Titles\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".iff")>-1
                  CopyFile(Game_Img_Path+"CD32\Titles\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".iff",Backup_Path+"Titles\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".iff")
                  DeleteFile(Game_Img_Path+"CD32\Titles\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".iff",#PB_FileSystem_Force)
                EndIf
                
                If FileSize(Game_Img_Path+"CD32\Screenshots\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".iff")>-1
                  CopyFile(Game_Img_Path+"CD32\Screenshots\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".iff",Backup_Path+"Screenshots\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".iff")
                  DeleteFile(Game_Img_Path+"CD32\Screenshots\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".iff",#PB_FileSystem_Force)
                EndIf
                
                If GetGadgetState(CD32_List)>0
                  list_pos=GetGadgetState(CD32_List)-1
                Else
                  list_pos=0
                EndIf
                DeleteElement(CD32_Database())
                Draw_CD32_List()
                SelectElement(CD32_Numbers(),list_pos)
                SetGadgetState(CD32_List,list_pos)
                Draw_CD32_Info(CD32_Numbers())
              EndIf
              
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
        Case #MenuItem_32 ;{- Extract IFF Archive
          Create_IFF_Folders()
          ;}
        Case #MenuItem_33 ;{- Create IFF Archive
          ;Create_IFF_Archive()
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
               If GetExtensionPart(EventDropFiles())="png" Or GetExtensionPart(EventDropFiles())="jpg" Or GetExtensionPart(EventDropFiles())="iff"
                If GetGadgetState(#MAIN_PANEL)=0
                  path=Game_Img_Path+"Covers\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"
                  RunProgram(nconvert_path,"-quiet -overwrite -out png -o "+#DOUBLEQUOTE$+path+#DOUBLEQUOTE$+" -resize 320 412 -rtype mitchell -colors 256 -floyd "+#DOUBLEQUOTE$+EventDropFiles()+#DOUBLEQUOTE$,"",#PB_Program_Wait)
                  Draw_Info(List_Numbers())
                EndIf
                If GetGadgetState(#MAIN_PANEL)=1
                  path=Game_Img_Path+"CD32\Covers\"+CD32_Database()\CD_Title+".png"
                  RunProgram(nconvert_path,"-quiet -overwrite -out png -o "+#DOUBLEQUOTE$+path+#DOUBLEQUOTE$+" -resize 320 412 -rtype mitchell -colors 256 -floyd "+#DOUBLEQUOTE$+EventDropFiles()+#DOUBLEQUOTE$,"",#PB_Program_Wait)
                  Draw_CD32_Info(CD32_Numbers())
                EndIf  
              Else
                MessageRequester("Error","Not An Image File!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
              EndIf
            EndIf
          EndIf
        
        Case Main_Image
          If EventDropFiles()>""
            If GetGadgetState(Main_List)<>-1
              If GetExtensionPart(EventDropFiles())="png" Or GetExtensionPart(EventDropFiles())="jpg" Or GetExtensionPart(EventDropFiles())="iff"
                If GetGadgetState(#MAIN_PANEL)=0
                  If TitleScreen
                    path=Game_Img_Path+"Titles\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"
                  Else
                    path=Game_Img_Path+"Screenshots\"+IG_Database()\IG_Type+"\"+ReplaceString(IG_Database()\IG_Subfolder,"/","\")+IG_Database()\IG_Folder+"\"+GetFilePart(IG_Database()\IG_Default_Icon,#PB_FileSystem_NoExtension)+".png"
                  EndIf
                  RunProgram(nconvert_path,"-quiet -overwrite -out png -o "+#DOUBLEQUOTE$+path+#DOUBLEQUOTE$+" -resize 320 256 -rtype quick -colors 256 -floyd "+#DOUBLEQUOTE$+EventDropFiles()+#DOUBLEQUOTE$,"",#PB_Program_Wait)
                  Draw_Info(List_Numbers())
                EndIf
                If GetGadgetState(#MAIN_PANEL)=1
                  If TitleScreen
                    path=Game_Img_Path+"CD32\Titles\"+CD32_Database()\CD_Title+".png"
                  Else
                    path=Game_Img_Path+"CD32\Screenshots\"+CD32_Database()\CD_Title+".png"
                  EndIf
                  RunProgram(nconvert_path,"-quiet -overwrite -out png -o "+#DOUBLEQUOTE$+path+#DOUBLEQUOTE$+" -resize 320 256 -rtype quick -colors 256 -floyd "+#DOUBLEQUOTE$+EventDropFiles()+#DOUBLEQUOTE$,"",#PB_Program_Wait)
                  Draw_CD32_Info(CD32_Numbers())
                EndIf 
              Else
                MessageRequester("Error","Not An Image File!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
              EndIf
            EndIf
          EndIf
          
        Case Main_List
          If EventDropFiles()>""
            If GetExtensionPart(EventDropFiles())="txt"
              SelectElement(List_Numbers(),GetGadgetState(Main_List))
              SelectElement(IG_Database(),List_Numbers())
              i=ReadFile(#PB_Any,EventDropFiles())
              While Not Eof(i)
                text$=ReadString(i)
                If FindString(text$,"Publisher") : path=StringField(text$,2,":") : path=Trim(path) : IG_Database()\IG_Publisher=path : EndIf
                If FindString(text$,"Year") : path=StringField(text$,2,":") : path=Trim(path) : IG_Database()\IG_Year=path : EndIf
              Wend
              CloseFile(i)
              Save_DB()
              Draw_Info(List_Numbers())
            EndIf
          EndIf

      EndSelect

    Case #PB_Event_Gadget
      
      Select EventGadget()
          
        Case #MAIN_PANEL
          If EventType()=#PB_EventType_Change
            If GetGadgetState(#MAIN_PANEL)=0
              Pause_Window(#MAIN_WINDOW)
              SetWindowTitle(#MAIN_WINDOW, W_Title+" (Showing "+Str(CountGadgetItems(Main_List))+" of "+Str(ListSize(IG_Database()))+" Games)")
              DisableGadget(Main_List,#False)
              DisableGadget(CD32_List,#True)
              SetActiveGadget(Main_List)
              SetGadgetState(Main_List,0)
              DisableMenuItem(Main_Menu,#MenuItem_26,1)
              SelectElement(List_Numbers(),GetGadgetState(Main_List))
              Draw_Info(List_Numbers())
            EndIf
            If GetGadgetState(#MAIN_PANEL)=1
              Pause_Window(#MAIN_WINDOW)
              SetWindowTitle(#MAIN_WINDOW, W_Title+" (Showing "+Str(CountGadgetItems(CD32_List))+" of "+Str(ListSize(CD32_Database()))+" CD32 Games)")
              DisableGadget(Main_List,#True)
              DisableGadget(CD32_List,#False)              
              SetActiveGadget(CD32_List)
              SetGadgetState(CD32_List,0)
              DisableMenuItem(Main_Menu,#MenuItem_26,0)
              Draw_CD32_Info(0)
            EndIf
          EndIf
          
        Case CD32_List
          If CountGadgetItems(CD32_List)>0 And GetGadgetState(CD32_List)>-1
            If EventType()= #PB_EventType_Change
              SelectElement(CD32_Numbers(),GetGadgetState(CD32_List))
              Draw_CD32_Info(CD32_Numbers())
              SelectElement(CD32_Database(),CD32_Numbers())
            EndIf
            If EventType() = #PB_EventType_LeftDoubleClick
              PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_2)
            EndIf
          EndIf  
          
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
                Image_Popup(2)
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

End
; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 3665
; FirstLine = 433
; Folding = AAAAAAAAEAAAAAA9
; EnableThread
; EnableXP
; EnableUser
; DPIAware
; UseIcon = joystick.ico
; Executable = I:\UltraMiggy\UltraMiggy.exe
; CurrentDirectory = I:\UltraMiggy\
; Compiler = PureBasic 5.73 LTS (Windows - x64)
; Debugger = Standalone