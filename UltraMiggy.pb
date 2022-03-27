; UltraMiggy
;
; Version 0.1
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
Declare Scrape_Demos()
Declare Scrape_Beta()
Declare Scrape_Games()
Declare Fix_Gameslist(names_only.b=#False)
Declare Update_Database()
Declare Create_Gameslist()
Declare Image_Popup()
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

Enumeration
  
  #MAIN_WINDOW
  #POPUP_WINDOW
  #PATH_WINDOW
  #EDIT_WINDOW
  #IFF_IMAGE
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
  List IG_Icons.s()
  IG_Filtered.b
  IG_Installed.b
  IG_Available.b
  
EndStructure

Global NewList IG_Database.IG_Data()
Global NewList T_List.IG_data()

Structure f_data
  F_Title.s
  F_Genre.s
  F_Folder.s
  F_SubFolder.s
  F_Slave.s
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
  F_Publisher.s
  F_Installed.b
  List F_Icons.s()
EndStructure

Global NewList Fix_List.f_data()

Global NewList List_Numbers.i()

Global NewList Files.s()
Global NewList File_List.s()

Global NewList Genre_List.s()
Global NewMap Genre_Map.s()
Global NewMap Duplicates.i()
Global NewList Dupe_List.i()

Global W_Title.s="UltraMiggy v0.1"
Global Main_Path.s, path.s, home_path.s, List_Type.s, List_Path.s
Global event.i, Main_Menu.i, Main_Image, IFF_Image, listnum.i, temp$, count.i, i.i, j.i, k.i
Global Main_List, Info_List, LoadGL_Button, SaveDB_Button, New_Button, GamePath_Button, Fix_Button, Genres_Button, Prefs_Button, Clear_Button, CSV_Button
Global SaveGL_Button, Audit_Button, Edit_Button, Delete_Button, WHD_Path, WHDPath_Button, Path_Button, Make_Button, Main_Genre_Combo, Main_Type_Combo
Global st_processed, st_removed, st_fixed, g_file, text$
Global merge_path_1.s,merge_path_2.s,merge_path_3.s

Global LHA_Path.s=GetCurrentDirectory()+"7z.exe"
Global LZX_Path.s=GetCurrentDirectory()+"unlzx.exe"
Global IFF_Smooth.l=#PB_Image_Raw
Global whdtemp_dir.s=GetTemporaryDirectory()+"WHDTemp"
Global Genres_Path.s=GetCurrentDirectory()
Global DB_Path.s=GetCurrentDirectory()
Global Game_Img_Path.s=GetCurrentDirectory()
Global Demo_Img_Path.s=GetCurrentDirectory()
Global Beta_Img_Path.s=GetCurrentDirectory()
Global whd_uae_config.s=""
Global whd_update_config.s=""
Global whd_cd32_config.s=""
Global whd_lha_game.s=""
Global whd_lha_demo.s=""
Global whd_lha_beta.s=""
Global IGame_Path.s=""
Global WinUAE_Path.s=""
Global Close_UAE.b=#True
Global JSON_Backup=#False

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

Procedure List_FTP_Recursive(Dir.s, List Files.s()) ; <------> Adds All Files In A Folder Into The Supplied List
  
  Protected NewList Directories.s()
  
  If Right(Dir, 1) <> "\"
    Dir + "\"
  EndIf
  
  SetFTPDirectory(#FTP,Dir)
  
  If ExamineFTPDirectory(#FTP)
    While NextFTPDirectoryEntry(#FTP)
      Select FTPDirectoryEntryType(#FTP)
        Case #PB_FTP_File
          AddElement(Files())
          Files() = Dir + FTPDirectoryEntryName(#FTP)
          Window_Update()
        Case #PB_FTP_Directory
          Select FTPDirectoryEntryName(#FTP)
            Case ".", ".."
              Continue
            Default
              AddElement(Directories())
              Directories() = Dir + FTPDirectoryEntryName(#FTP)
              Debug Directories()
          EndSelect
      EndSelect
    Wend
    FinishFTPDirectory(#FTP)
    ForEach Directories()
      List_FTP_Recursive(Directories(), Files())
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

Procedure Load_IFF(path.s,imagename.s,imagenum.l)
    
  Protected my_image.l, IFF_Archive.l
  
  If IsImage(my_image) : FreeImage(my_image) : EndIf
  IFF_Archive=OpenPack(#PB_Any,path,#PB_PackerPlugin_Zip)
  If IFF_Archive
    If CreateDirectory(whdtemp_dir)
      SetCurrentDirectory(whdtemp_dir)
      UncompressPackFile(IFF_Archive,imagename,imagename)
      SetCurrentDirectory(home_path)
    EndIf
  EndIf
  ClosePack(IFF_Archive)
  my_image=TinyIFF::Load(#PB_Any ,whdtemp_dir+imagename)
  DeleteDirectory(whdtemp_dir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
  
  If IsImage(my_image)
    CopyImage(my_image,imagenum)    
    FreeImage(my_image)
  EndIf 
  
EndProcedure

Procedure Draw_Info(number)
  
  Window_Pause(#MAIN_WINDOW)  
  
  If IsImage(#IFF_IMAGE) : FreeImage(#IFF_IMAGE) : EndIf
  
  ClearGadgetItems(Info_List)  
  
  If number<>-1
    
    Protected D_Path.s=""
    
    SelectElement(IG_Database(),number)
    
    If IG_Database()\IG_Type="Demo"
      AddGadgetItem(Info_List,-1,"Publisher: "+Chr(10)+IG_Database()\IG_Coder)
    Else
      AddGadgetItem(Info_List,-1,"Publisher: "+Chr(10)+IG_Database()\IG_Publisher)
    EndIf

    AddGadgetItem(Info_List,-1,"Year: "+Chr(10)+IG_Database()\IG_Year)
    AddGadgetItem(Info_List,-1,"Genre: "+Chr(10)+IG_Database()\IG_Genre)
    ForEach IG_Database()\IG_Icons()
      AddGadgetItem(Info_List,-1,"Icon: "+Chr(10)+IG_Database()\IG_Icons())
    Next
    AddGadgetItem(Info_List,-1,"Slave: "+Chr(10)+IG_Database()\IG_Slave)
    AddGadgetItem(Info_List,-1,"Archive: "+Chr(10)+IG_Database()\IG_LHAFile)
    If IG_Database()\IG_Available=#True
      AddGadgetItem(Info_List,-1,"Available: "+Chr(10)+"Yes")
    Else
      AddGadgetItem(Info_List,-1,"Available: "+Chr(10)+"No")
    EndIf
        
    For count=0 To CountGadgetItems(Info_List) Step 2
      SetGadgetItemColor(Info_List,count,#PB_Gadget_BackColor,$eeeeee)
    Next
    
    If IG_Database()\IG_Type="Game" : D_Path=Game_Img_Path : EndIf
    If IG_Database()\IG_Type="Demo" : D_Path=Demo_Img_Path : EndIf
    If IG_Database()\IG_Type="Beta" : D_Path=Beta_Img_Path : EndIf
        
    If D_Path<>""
      Load_IFF(D_Path,RemoveString(IG_Database()\IG_Folder,"/")+".iff",#IFF_IMAGE)      
    EndIf
    
  Else
    
    CopyImage(#IFF_BLANK,#IFF_IMAGE)
    
  EndIf
  
  If IsImage(#IFF_IMAGE)
    ResizeImage(#IFF_IMAGE,176, 136,IFF_Smooth)
    StartDrawing(CanvasOutput(Main_Image))
    DrawImage(ImageID(#IFF_IMAGE),0,0,176,136)
    StopDrawing()
  EndIf
  
  Window_Resume(#MAIN_WINDOW)
  
EndProcedure
  
Procedure Draw_List()
  
  Protected star.s

  SortStructuredList(IG_Database(),#PB_Sort_Ascending|#PB_Sort_NoCase,OffsetOf(IG_Data\IG_Title),TypeOf(IG_Data\IG_Title))
  
  UseGadgetList(WindowID(#MAIN_WINDOW))
  
  Window_Pause(#MAIN_WINDOW)

  ClearList(List_Numbers())
  ClearGadgetItems(Main_List)
  
  ForEach IG_Database()
    star=""
    If IG_Database()\IG_Genre="Unknown" : star="*" : EndIf
    If IG_Database()\IG_Title<>"" And IG_Database()\IG_Filtered=#False
      AddGadgetItem(Main_List,-1,star+IG_Database()\IG_Title+Title_Extras())
      AddElement(List_Numbers())
      List_Numbers()=ListIndex(IG_Database())
    EndIf
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
  
  SetWindowTitle(#MAIN_WINDOW, W_Title+" (Showing "+Str(CountGadgetItems(Main_List))+" of "+Str(ListSize(IG_Database()))+" Games)")
  
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

Procedure Scrape_Demos()
  
  ForEach IG_Database()
      
      If FindString(IG_Database()\IG_Title,"AGA",0,#PB_String_CaseSensitive)
        IG_Database()\IG_AGA=1
        IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"AGA")
      EndIf
    
  Next
  
  ForEach IG_Database()

    IG_Database()\IG_Title=Split_On_Capital(IG_Database()\IG_Title)
    
    count=CountString(IG_Database()\IG_LHAFile,"_")
    If FindString(IG_Database()\IG_LHAFile,"AGA")
      IG_Database()\IG_Coder=Split_On_Capital(RemoveString(StringField(IG_Database()\IG_LHAFile,count,"_"),".lha"))
    Else
      IG_Database()\IG_Coder=Split_On_Capital(RemoveString(StringField(IG_Database()\IG_LHAFile,count+1,"_"),".lha"))
    EndIf
    IG_Database()\IG_Genre="Demo Disk"

  Next
  
EndProcedure

Procedure Scrape_Beta()
  
  ForEach IG_Database()
    
    IG_Database()\IG_Title=Split_On_Capital(IG_Database()\IG_Title)
    IG_Database()\IG_Genre="Beta / Unreleased"

  Next
  
EndProcedure

Procedure Run_Game(gamenumber.i)
  
  Protected output$, gameselect$, num.i
  
  SelectElement(IG_Database(), gamenumber)
  
  If ListSize(IG_Database()\IG_Icons())>1
    ForEach IG_Database()\IG_Icons()
      output$+IG_Database()\IG_Icons()+Chr(10)
    Next
    
    gameselect$=InputRequester("Select An Icon",output$,"")
    
    SelectElement(IG_Database()\IG_Icons(),Val(gameselect$))
  EndIf

  Protected startup_file.i, whd_lha_path.s, startup_prog.i, old_pos.i, prog_path.s, config.s
  
  old_pos=GetGadgetState(Main_List)
  
  StickyWindow(#MAIN_WINDOW,#False)
  
  Select IG_Database()\IG_Type
    Case "Game"
      whd_lha_path=whd_lha_game
      prog_path="Games"
    Case "Demo"
      whd_lha_path=whd_lha_demo
      prog_path="Demos"
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
      WriteString(startup_file,"kgiconload "+IG_Database()\IG_Icons()+#LF$)
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
  
  StickyWindow(#MAIN_WINDOW,#True)
  
  SetGadgetState(Main_List,old_pos)
  
EndProcedure

Procedure Scrape_Games()
  
  ForEach IG_Database()
    
    If FindString(IG_Database()\IG_Folder,"CUAmiga",0,#PB_String_CaseSensitive)
      IG_Database()\IG_Coverdisk=1
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"AmigaPower",0,#PB_String_CaseSensitive)
      IG_Database()\IG_Coverdisk=1
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"TheOne",0,#PB_String_CaseSensitive)
      IG_Database()\IG_Coverdisk=1
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"AmigaAction",0,#PB_String_CaseSensitive)
      IG_Database()\IG_Coverdisk=1
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"AmigaFormat",0,#PB_String_CaseSensitive)
      IG_Database()\IG_Coverdisk=1
    EndIf

    If FindString(IG_Database()\IG_Folder,"MT32",0,#PB_String_CaseSensitive)
      IG_Database()\IG_MT32=1
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"MT32")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"AGA",0,#PB_String_CaseSensitive)
      IG_Database()\IG_AGA=1
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"AGA")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"NTSC",0,#PB_String_CaseSensitive)
      IG_Database()\IG_NTSC=1
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"NTSC")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"CD32",0,#PB_String_CaseSensitive)
      IG_Database()\IG_CD32=1
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"CD32")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"CDTV",0,#PB_String_CaseSensitive)
      IG_Database()\IG_CDTV=1
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"CDTV")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"CD",0,#PB_String_CaseSensitive)
      If FindString(IG_Database()\IG_Folder,"CD32",0,#PB_String_CaseSensitive)=0 And FindString(IG_Database()\IG_Folder,"CDTV",0,#PB_String_CaseSensitive)=0
        IG_Database()\IG_CDROM=1
        IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"CD")
      EndIf
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"Fast",Len(IG_Database()\IG_Title)-8,#PB_String_CaseSensitive)>1
      IG_Database()\IG_Memory="Fast Mem"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"Fast")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"LowMem",Len(IG_Database()\IG_Title)-8,#PB_String_CaseSensitive)>1
      IG_Database()\IG_Memory="Low Mem"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"LowMem")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"Slow",Len(IG_Database()\IG_Title)-8,#PB_String_CaseSensitive)
      IG_Database()\IG_Memory="Slow Mem"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"Slow")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"Chip",Len(IG_Database()\IG_Title)-8,#PB_String_CaseSensitive)>1
      IG_Database()\IG_Memory="Chip Mem"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"Chip")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"Demo",Len(IG_Database()\IG_Title)-8,#PB_String_CaseSensitive)
      IG_Database()\IG_Demo=1
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"Demo")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"Files",Len(IG_Database()\IG_Title)-8,#PB_String_CaseSensitive)
      IG_Database()\IG_Files=1
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"Files")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"Preview",Len(IG_Database()\IG_Title)-8,#PB_String_CaseSensitive)
      IG_Database()\IG_Preview=1
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"Preview")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"Image",Len(IG_Database()\IG_Title)-8,#PB_String_CaseSensitive)
      IG_Database()\IG_Image=1
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"Image")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"1Disk",Len(IG_Database()\IG_Title)-8,#PB_String_CaseSensitive)
      IG_Database()\IG_Disks="One Disk"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"1Disk")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"2Disk",Len(IG_Database()\IG_Title)-8,#PB_String_CaseSensitive)
      IG_Database()\IG_Disks="Two Disk"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"2Disk")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"3Disk",Len(IG_Database()\IG_Title)-8,#PB_String_CaseSensitive)
      IG_Database()\IG_Disks="Three Disk"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"3Disk")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"4Disk",Len(IG_Database()\IG_Title)-8,#PB_String_CaseSensitive)
      IG_Database()\IG_Disks="Four Disk"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"4Disk")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"5Disk",Len(IG_Database()\IG_Title)-8,#PB_String_CaseSensitive)
      IG_Database()\IG_Disks="Five Disk"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"5Disk")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"6Disk",Len(IG_Database()\IG_Title)-8,#PB_String_CaseSensitive)
      IG_Database()\IG_Disks="Six Disk"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"6Disk")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"NoIntro",Len(IG_Database()\IG_Title)-8,#PB_String_CaseSensitive)
      IG_Database()\IG_NoIntro=1
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"NoIntro")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"Intro",Len(IG_Database()\IG_Title)-8,#PB_String_CaseSensitive)
      If FindString(IG_Database()\IG_Folder,"NoIntro",0,#PB_String_CaseSensitive)=0
        IG_Database()\IG_Intro=1
        IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"Intro")
      EndIf
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"Arcadia",Len(IG_Database()\IG_Title)-8,#PB_String_CaseSensitive)
      IG_Database()\IG_Arcadia=1
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"Arcadia")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"512kb",Len(IG_Database()\IG_Title)-8,#PB_String_NoCase)
      IG_Database()\IG_Memory="512KB"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"512kb")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"512k",Len(IG_Database()\IG_Title)-8,#PB_String_NoCase)
      IG_Database()\IG_Memory="512KB"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"512k")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"12MB",Len(IG_Database()\IG_Title)-8,#PB_String_NoCase)
      IG_Database()\IG_Memory="12MB"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"12MB")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"1MB",Len(IG_Database()\IG_Title)-8,#PB_String_NoCase)
      IG_Database()\IG_Memory="1MB"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"1MB")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"2MB",Len(IG_Database()\IG_Title)-8,#PB_String_NoCase)
      IG_Database()\IG_Memory="2MB"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"2MB")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"8MB",Len(IG_Database()\IG_Title)-8,#PB_String_NoCase)
      IG_Database()\IG_Memory="8MB"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"8MB")
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"15MB",Len(IG_Database()\IG_Title)-8,#PB_String_NoCase)
      IG_Database()\IG_Memory="1.5MB"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"15MB")
    EndIf
   
  Next
  
  ForEach IG_Database()
    
    IG_Database()\IG_Title=Split_On_Capital(IG_Database()\IG_Title)
    
    If FindString(IG_Database()\IG_Folder,"Fr",Len(IG_Database()\IG_Folder)-2,#PB_String_CaseSensitive)
      IG_Database()\IG_Language="French"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"Fr",0,Len(IG_Database()\IG_Title)-2)
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"It",Len(IG_Database()\IG_Folder)-2,#PB_String_CaseSensitive)
      If IG_Database()\IG_Title<>"XIt"
        IG_Database()\IG_Language="Italian"
        IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"It",0,Len(IG_Database()\IG_Title)-2)
      EndIf
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"Gr",Len(IG_Database()\IG_Folder)-2,#PB_String_CaseSensitive)
      IG_Database()\IG_Language="Greek"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"Gr",0,Len(IG_Database()\IG_Title)-2)
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"Fi",Len(IG_Database()\IG_Folder)-2,#PB_String_CaseSensitive)
      IG_Database()\IG_Language="Finnish"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"Fi",0,Len(IG_Database()\IG_Title)-2)
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"Es",Len(IG_Database()\IG_Folder)-2,#PB_String_CaseSensitive)
      IG_Database()\IG_Language="Spanish"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"Es",0,Len(IG_Database()\IG_Title)-2)
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"Se",Len(IG_Database()\IG_Folder)-2,#PB_String_CaseSensitive)
        IG_Database()\IG_Language="Swedish"
        IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"Se",0,Len(IG_Database()\IG_Title)-2)
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"Sl",Len(IG_Database()\IG_Folder)-2,#PB_String_CaseSensitive)   
      IG_Database()\IG_Language="Slovak"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"Sl",0,Len(IG_Database()\IG_Title)-2)
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"Dk",Len(IG_Database()\IG_Folder)-2,#PB_String_CaseSensitive)
      IG_Database()\IG_Language="Danish"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"Dk",0,Len(IG_Database()\IG_Title)-2)
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"En",Len(IG_Database()\IG_Folder)-2,#PB_String_CaseSensitive)
      IG_Database()\IG_Language=""
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"ES",Len(IG_Database()\IG_Folder)-2,#PB_String_CaseSensitive)
      IG_Database()\IG_Language="Spanish"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"ES",0,Len(IG_Database()\IG_Title)-2)
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"Pl",Len(IG_Database()\IG_Folder)-2,#PB_String_CaseSensitive)
      IG_Database()\IG_Language="Polish"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"Pl",0,Len(IG_Database()\IG_Title)-2)
    EndIf
      
    If FindString(IG_Database()\IG_Folder,"De",Len(IG_Database()\IG_Folder)-2,#PB_String_CaseSensitive)
      IG_Database()\IG_Language="German"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"De",0,Len(IG_Database()\IG_Title)-2)
    EndIf
    
    If FindString(IG_Database()\IG_Folder,"Cz",Len(IG_Database()\IG_Folder)-2,#PB_String_CaseSensitive)
      IG_Database()\IG_Language="Czech"
      IG_Database()\IG_Title=RemoveString(IG_Database()\IG_Title,"Cz",0,Len(IG_Database()\IG_Title)-2)
    EndIf
    
  Next
  
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

Procedure Update_Icons()
  
  Protected NewMap Folder_Check.i()
  
  Protected newentry.i, IG_Program.i
  Protected Title$, Folder$, Slave$ , ReadO$
  
  Title$=GetWindowTitle(#MAIN_WINDOW)
  
  newentry=0
  
  path=PathRequester("WHDLoad Path",Main_Path)
  
  ClearList(File_List())
  
  SetWindowTitle(#MAIN_WINDOW,"Scanning Folders")
  
  List_Files_Recursive(path,File_List(),"") ; Create Archive List
  
  ForEach IG_Database() ; Add archive list to map
    Folder_Check(IG_Database()\IG_LHAFile)=ListIndex(IG_Database())
    ClearList(IG_Database()\IG_Icons())
  Next    

  SetWindowTitle(#MAIN_WINDOW,"Updating Slaves")
  
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
            If FindMapElement(Folder_Check(),GetFilePart(File_List()))
              SelectElement(IG_Database(),Folder_Check())
              AddElement(IG_Database()\IG_Icons())
              IG_Database()\IG_Icons()=GetFilePart(ReadO$)
              Debug IG_Database()\IG_Icons()
            EndIf 
          EndIf               
          
        EndIf
        
      Wend
      
    EndIf
    
  Next
  
  Delay(2000)
  
  CloseConsole()
  
  Message_RequesterEx("Update Slaves","Updated : "+#LF$+Str(newentry),150)
  
  SetWindowTitle(#MAIN_WINDOW,Title$)
  
  FreeMap(Folder_Check())
  
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

Procedure Update_Database()
  
  Protected startup_file.i, whd_lha_path.s, startup_prog.i, old_pos.i, prog_path.s
  
  Structure add_entry
    add_file.s
    add_sub.s
    add_arc.s
    add_full_arc.s
  EndStructure
  
  Protected NewMap Check_Archives.i() ; LHA Lookup Map
  Protected NewMap Folder_Check.i() ; Folder & Slave Lookup Map 
  Protected NewList Check_List.s() ; Not Found List Of Main DB Element Numbers
  Protected NewList Add_List.add_entry() ; New Additions
  Protected NewList Extra_List.add_entry() ; Updated Entries
  Protected IG_Program.i, time.i, dupes.i, newentry.i, ignored.i, missing.i
  Protected ReadO$, Output$, SubFolder$ 
  
  dupes=0
  newentry=0
  ignored=0
  missing=0
  
  path=PathRequester("WHDLoad Path",Main_Path)
  
  If path<>""

    SetWindowTitle(#MAIN_WINDOW,"Scanning Folders")
    
    ClearList(File_List())
    
    List_Files_Recursive(path,File_List(),"") ; Create Archive List
    
    ForEach IG_Database() ; Add archive list to map
      Folder_Check(LCase(IG_Database()\IG_Folder+"/"+IG_Database()\IG_Slave))=ListIndex(IG_Database())
      Check_Archives(LCase(IG_Database()\IG_LHAFile))
    Next     
    
    ForEach File_List() ; Delete found archives
      If Not FindMapElement(Check_Archives(),LCase(GetFilePart(File_List())))
        AddElement(Check_List())
        Check_List()=File_List()
      EndIf
    Next
    
    If ListSize(File_List())>0
      
      time=ElapsedMilliseconds()
      
      OpenConsole("Scanning Archives...")
      
      ForEach Check_List()
        
        OpenConsole()
       
        count=CountString(Check_List(),"\")
        SubFolder$=StringField(Check_List(),count,"\")
                
        If GetExtensionPart(Check_List())="lha"
          IG_Program=RunProgram(LHA_Path,"l "+#DOUBLEQUOTE$+Check_List()+#DOUBLEQUOTE$,"",#PB_Program_Read|#PB_Program_Open)
        EndIf
        
        If GetExtensionPart(Check_List())="lzx"
          IG_Program=RunProgram(LZX_Path,"-v "+#DOUBLEQUOTE$+Check_List()+#DOUBLEQUOTE$,"",#PB_Program_Read|#PB_Program_Open)
        EndIf
        
        If IG_Program
          
          While ProgramRunning(IG_Program)
            
            If AvailableProgramOutput(IG_Program)
              
              ReadO$=ReadProgramString(IG_Program)
              ReadO$=RemoveString(ReadO$,#DOUBLEQUOTE$) 
              ReadO$=ReplaceString(ReadO$,"\", "/")              
              
              If FindString(ReadO$,".slave",0,#PB_String_NoCase)
                count=CountString(ReadO$," ")
                Output$=StringField(ReadO$,count+1," ")
                If Output$<>""
                  PrintN("Processing "+GetFilePart(Check_List())+" ("+ListIndex(Check_List())+" of "+ListSize(Check_List())+")")
                  If FindMapElement(Folder_Check(),LCase(Output$))  
                    path=ReplaceString(path+IG_Database()\IG_Subfolder+IG_Database()\IG_LHAFile,"/","\")
                    SelectElement(IG_Database(),Folder_Check())
                    IG_Database()\IG_LHAFile=GetFilePart(Check_List())
                    AddElement(Extra_List())
                    Extra_List()\add_file=Output$
                    Extra_List()\add_sub=SubFolder$
                    Extra_List()\add_arc=GetFilePart(Check_List())
                    Extra_List()\add_full_arc=Check_List()
                    dupes+1
                  Else
                    AddElement(Add_List())
                    Add_List()\add_file=Output$
                    Add_List()\add_sub=SubFolder$
                    Add_List()\add_arc=GetFilePart(Check_List())
                    Add_List()\add_full_arc=Check_List()
                  EndIf
                EndIf
              EndIf
            EndIf
          Wend
        EndIf
      Next
      
      ForEach Add_List()
        AddElement(IG_Database())
        IG_Database()\IG_Title=Split_On_Capital(RemoveString(GetPathPart(Add_List()\add_file),"/"))
        IG_Database()\IG_Folder=GetPathPart(Add_List()\add_file)
        IG_Database()\IG_Subfolder=Add_List()\add_sub+"/"
        IG_Database()\IG_Path=Main_Path+Add_List()\add_sub+"/"+GetPathPart(Add_List()\add_file)
        IG_Database()\IG_Slave=GetFilePart(Add_List()\add_file)
        IG_Database()\IG_LHAFile=Add_List()\add_arc
        IG_Database()\IG_Genre="Unknown"
        IG_Database()\IG_Favourite="0"
        IG_Database()\IG_TimesPlayed="0"
        IG_Database()\IG_LastPlayed="0"
        IG_Database()\IG_Hidden="0"
        IG_Database()\IG_Type=List_Type
        newentry+1
      Next

      PrintN("")
      PrintN("Processed "+Str(ListSize(Check_List()))+" slave files in "+Str((ElapsedMilliseconds()-time)/1000)+" Seconds.")
      PrintN("")
      PrintN("Scan Complete...")
      
      Delay(2000)
      
      CloseConsole()
      
      MergeLists(Add_List(),Extra_List(),#PB_List_After)
      
      If MessageRequester("Create Folders", "Copy & Extract To Amiga?",#PB_MessageRequester_YesNo|#PB_MessageRequester_Info)=#PB_MessageRequester_Yes
        If FileSize(whdtemp_dir)=-2 : DeleteDirectory(whdtemp_dir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force) : EndIf
        If CreateDirectory(whdtemp_dir)
          SetCurrentDirectory(whdtemp_dir)
          startup_file=CreateFile(#PB_Any,"whd-startup")
          If startup_file
            WriteString(startup_file,"cd DH1:"+#LF$)
            ForEach Extra_List()
              CopyFile(Extra_List()\add_full_arc,GetCurrentDirectory()+Extra_List()\add_arc)
              WriteString(startup_file,"LHA040 -m1 x "+Extra_List()\add_arc+" DH2:Games/"+Extra_List()\add_sub+"/"+#LF$)
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
  EndIf
  
  Message_RequesterEx("Update Database",Str(Dupes)+ " Entries Updated"+#LF$+Str(newentry)+ " Entries Added"+#LF$+Str(ignored)+ " Entries Ignored",150)
  
  FreeMap(Check_Archives())
  FreeMap(Folder_Check())
  FreeList(Check_List())
  FreeList(Add_List())
  
EndProcedure

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

Procedure Check_Dirs()
  
  ;**** Create Dirs.txt Here! ****
  
  Protected cd_file.i, output.s
  
  cd_file=ReadFile(#PB_Any,home_path+"dirs.txt")
  
  If cd_file
    While Not Eof(cd_file)
      output=ReadString(cd_file)
      If output="Directory is empty" : Continue : EndIf
      If CountString(output,"/")<>2 : Continue : Endif
      Debug output
    Wend
  EndIf

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

Procedure Create_Game_Folder()
  
  Protected f_path$, f_archive$, f_subfolder$, f_program.i
  
  StickyWindow(#MAIN_WINDOW,#False)
    
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
  
  StickyWindow(#MAIN_WINDOW,#True)
  
EndProcedure  

Procedure Create_Gameslist_Folder()

  Protected NewList Unknown.s()
  Protected IG_Program.i, LHA_File.s, LZX_File.s, time.i
  Protected Found.b
  Protected ReadO$, Output$, SubFolder$, c_path$
  
  StickyWindow(#MAIN_WINDOW,#False)
  
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
  
  StickyWindow(#MAIN_WINDOW,#False)
  
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

Procedure Check_Missing_Images()
  
  Protected NewMap IFF_Files.s()
  
  Protected IFF_Archive.l, D_Path.s
  
  ForEach IG_Database()  
    IG_Database()\IG_Filtered=#False     
  Next
  
  D_Path=Game_Img_Path

  IFF_Archive=OpenPack(#PB_Any,D_Path,#PB_PackerPlugin_Zip)
  
  If IFF_Archive
    While NextPackEntry(IFF_Archive)
      If PackEntryType(IFF_Archive) = #PB_Packer_File
        IFF_Files(PackEntryName(IFF_Archive))=PackEntryName(IFF_Archive)
      EndIf
    Wend
  EndIf
  
  ClosePack(IFF_Archive)
  
  ForEach IG_Database()     
    If FindMapElement(IFF_Files(),IG_Database()\IG_Folder+".iff")
      IG_Database()\IG_Filtered=#True  
    EndIf  
  Next
  
  ClearMap(IFF_Files())
  
  D_Path=Demo_Img_Path
  
  IFF_Archive=OpenPack(#PB_Any,D_Path,#PB_PackerPlugin_Zip)
  
  If IFF_Archive
    While NextPackEntry(IFF_Archive)
      If PackEntryType(IFF_Archive) = #PB_Packer_File
        IFF_Files(PackEntryName(IFF_Archive))=PackEntryName(IFF_Archive)
      EndIf
    Wend
  EndIf
  
  ClosePack(IFF_Archive)
  
  ForEach IG_Database()     
    If FindMapElement(IFF_Files(),IG_Database()\IG_Folder+".iff")
      IG_Database()\IG_Filtered=#True  
    EndIf  
  Next
  
  ClearMap(IFF_Files())
  
  D_Path=Beta_Img_Path
  
  IFF_Archive=OpenPack(#PB_Any,D_Path,#PB_PackerPlugin_Zip)
  
  If IFF_Archive
    While NextPackEntry(IFF_Archive)
      If PackEntryType(IFF_Archive) = #PB_Packer_File
        IFF_Files(PackEntryName(IFF_Archive))=PackEntryName(IFF_Archive)
      EndIf
    Wend
  EndIf
  
  ClosePack(IFF_Archive)
  
  ForEach IG_Database()     
    If FindMapElement(IFF_Files(),IG_Database()\IG_Folder+".iff")
      IG_Database()\IG_Filtered=#True  
    EndIf  
  Next
  
  FreeMap(IFF_Files())
  
EndProcedure

Procedure Image_Popup()
  
  Protected popup_imagegadget, pevent, popup_image, D_Path.s
  
  SelectElement(List_Numbers(),GetGadgetState(Main_List))
  SelectElement(IG_Database(),List_Numbers())
  
  DisableWindow(#MAIN_WINDOW,#True)
  
    If IG_Database()\IG_Type="Game" : D_Path=Game_Img_Path : EndIf
    If IG_Database()\IG_Type="Demo" : D_Path=Demo_Img_Path : EndIf
    If IG_Database()\IG_Type="Beta" : D_Path=Beta_Img_Path : EndIf
    
    If D_Path<>""
      Load_IFF(D_Path,IG_Database()\IG_Folder+".iff",#IFF_POPUP)
    If IsImage(#IFF_POPUP)
      ResizeImage(#IFF_POPUP,DpiX(480), DpiY(384),IFF_Smooth)
      StartDrawing(ImageOutput(#IFF_POPUP))
      DrawingMode(#PB_2DDrawing_Outlined)
      Box(0,0,479,384,#Black)
      StopDrawing()
      SetGadgetState(Main_Image,ImageID(#IFF_POPUP))
    EndIf
  EndIf
  
  If OpenWindow(#POPUP_WINDOW,0,0,480,384,"",#PB_Window_BorderLess|#PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
    StickyWindow(#POPUP_WINDOW,#True)
    StickyWindow(#MAIN_WINDOW,#False)
    SetClassLongPtr_(WindowID(#POPUP_WINDOW),#GCL_STYLE,$00020000) ; Add Drop Shadow
    ImageGadget(popup_imagegadget,0,0,480,384,ImageID(#IFF_POPUP))

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
    StickyWindow(#MAIN_WINDOW,#True)
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
    Path_Demo_String = StringGadget(#PB_Any, 130, 40, 300, 20, Demo_Img_Path, #PB_String_ReadOnly)
    Path_Demo_Button = ButtonGadget(#PB_Any, 440, 40, 40, 20, "Set")
    Path_Beta_String = StringGadget(#PB_Any, 130, 70, 300, 20, Beta_Img_Path, #PB_String_ReadOnly)
    Path_Beta_Button = ButtonGadget(#PB_Any, 440, 70, 40, 20, "Set")
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
    Path_Game_LHA_String = StringGadget(#PB_Any, 130, 280, 300, 20, whd_lha_game, #PB_String_ReadOnly)
    Path_Game_LHA_Button = ButtonGadget(#PB_Any, 440, 280, 40, 20, "Set")
    Path_Demo_LHA_String = StringGadget(#PB_Any, 130, 310, 300, 20, whd_lha_demo, #PB_String_ReadOnly)
    Path_Demo_LHA_Button = ButtonGadget(#PB_Any, 440, 310, 40, 20, "Set")
    Path_Beta_LHA_String = StringGadget(#PB_Any, 130, 340, 300, 20, whd_lha_beta, #PB_String_ReadOnly)
    Path_Beta_LHA_Button = ButtonGadget(#PB_Any, 440, 340, 40, 20, "Set")
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
    TextGadget(#PB_Any, 10, 280, 110, 20, "Game LHA Path", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 310, 110, 20, "Demo LHA Path", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 340, 110, 20, "Beta LHA Path", #PB_Text_Right)    
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
              path=OpenFileRequester("Game Image Path",Game_Img_Path,"*.zip",0)
              If path<>"" : Game_Img_Path=path : SetGadgetText(Path_Game_String,Game_Img_Path) : change=#True : EndIf
            Case Path_Demo_Button
              path=OpenFileRequester("Demo Image Path",Demo_Img_Path,"*.zip",0)
              If path<>"" : Demo_Img_Path=path : SetGadgetText(Path_Demo_String,Demo_Img_Path) : change=#True : EndIf
            Case Path_Beta_Button
              path=OpenFileRequester("Beta Image Path",Beta_Img_Path,"*.zip",0)
              If path<>"" : Beta_Img_Path=path : SetGadgetText(Path_Beta_String,Beta_Img_Path) : change=#True : EndIf
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
              path=PathRequester("Game LHA Folder Path",whd_lha_game)
              If path<>"" : whd_lha_game=path : SetGadgetText(Path_Game_LHA_String,whd_lha_game) : change=#True : EndIf    
            Case Path_Demo_LHA_Button
              path=PathRequester("Demo LHA Folder Path",whd_lha_demo)
              If path<>"" : whd_lha_demo=path : SetGadgetText(Path_Demo_LHA_String,whd_lha_demo) : change=#True : EndIf
            Case Path_Beta_LHA_Button
              path=PathRequester("Beta LHA Folder Path",whd_lha_beta)
              If path<>"" : whd_lha_beta=path : SetGadgetText(Path_Beta_LHA_String,whd_lha_beta) : change=#True : EndIf
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
  
  ForEach IG_Database()
    count=CountString(IG_Database()\IG_Path,"/")
    If ListSize(IG_Database()\IG_Icons())=0
      AddElement(IG_Database()\IG_Icons())
      IG_Database()\IG_Icons()=IG_Database()\IG_Folder+".info"
    EndIf
  Next
  
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
    IG_Database()\IG_Title=Fix_List()\F_Title
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
    Next
    
    Protected count
    
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
        output$+IG_Database()\IG_Path+IG_Database()\IG_Slave+";"
        output$+IG_Database()\IG_Favourite+";"
        output$+IG_Database()\IG_TimesPlayed+";"
        output$+IG_Database()\IG_LastPlayed+";"
        output$+IG_Database()\IG_Hidden
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
  WritePreferenceString("Demo_Img_Path",Demo_Img_Path)
  WritePreferenceString("Beta_Img_Path",Beta_Img_Path)
  WritePreferenceString("LHA_Path",LHA_Path)
  WritePreferenceString("LZX_Path",LZX_Path)
  WritePreferenceString("Temp_Path",whdtemp_dir)
  WritePreferenceString("UAECFG_Path",whd_uae_config)
  WritePreferenceString("CD32CFG_Path",whd_cd32_config)
  WritePreferenceString("UpdateCFG_Path",whd_update_config)
  WritePreferenceString("Game_LHA_Path",whd_lha_game)
  WritePreferenceString("Demo_LHA_Path",whd_lha_demo)
  WritePreferenceString("Beta_LHA_Path",whd_lha_beta)
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
  Demo_Img_Path=ReadPreferenceString("Demo_Img_Path",Demo_Img_Path)
  Beta_Img_Path=ReadPreferenceString("Beta_Img_Path",Beta_Img_Path)
  LHA_Path=ReadPreferenceString("LHA_Path",LHA_Path)
  LZX_Path=ReadPreferenceString("LZX_Path",LZX_Path)
  whdtemp_dir=ReadPreferenceString("Temp_Path",whdtemp_dir)
  whd_uae_config=ReadPreferenceString("UAECFG_Path",whd_uae_config)
  whd_update_config=ReadPreferenceString("UpdateCFG_Path",whd_update_config)
  whd_cd32_config=ReadPreferenceString("CD32CFG_Path",whd_cd32_config)
  whd_lha_game=ReadPreferenceString("Game_LHA_Path",whd_lha_game)
  whd_lha_demo=ReadPreferenceString("Demo_LHA_Path",whd_lha_demo)
  whd_lha_beta=ReadPreferenceString("Beta_LHA_Path",whd_lha_beta)
  IGame_Path=ReadPreferenceString("IGame_Path",IGame_Path)
  WinUAE_Path=ReadPreferenceString("WinUAE_Path",WinUAE_Path)
  Genres_Path=ReadPreferenceString("Genres_Path",Genres_Path)
  DB_Path=ReadPreferenceString("Database_Path",DB_Path)
  IFF_Smooth=ReadPreferenceLong("IFF_Smooth",#PB_Image_Raw)
  JSON_Backup=ReadPreferenceLong("JSON_Backup",JSON_Backup)
  ClosePreferences()
EndProcedure

Procedure Edit_GL(number) 
  
  SelectElement(IG_Database(),number)
  
  ClearList(Genre_List.s())
  
  Protected change.b=#False, oldindex.s, star.s
  Protected old_gadget_list, old_pos, title_string, language_string, path_string, Frame_0, AGA_Check, CD32_Check,  Preview_Check, Files_Check, Image_Check, NoIntro_Check
  Protected CDTV_Check, MT32_Check, Memory_String, Genre_Combo, CDROM_Check, Arcadia_Check, Demo_Check, Intro_Check, Cover_Check, NTSC_Check, Disk_String, Coder_String, Type_Combo, File_Button, Update_Button
  
  old_pos=GetGadgetState(Main_List)
  
  If OpenWindow(#EDIT_WINDOW, 0, 0, 430, 266, "Edit Database", #PB_Window_SystemMenu | #PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))

    StickyWindow(#EDIT_WINDOW,#True)
    
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
    File_Button = ButtonGadget(#PB_Any, 310, 230, 40, 24, "Find")
    Update_Button = ButtonGadget(#PB_Any, 370, 230, 50, 24, "Update")
    FrameGadget(#PB_Any, 358, 230, 1, 24, "", #PB_Frame_Flat)
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
    
    If change 
      If IG_Database()\IG_Genre="Unknown" : star="*" : Else : star="" : EndIf
      SetGadgetItemText(Main_List,old_pos,star+IG_Database()\IG_Title+Title_Extras())
      SetGadgetItemText(Info_List,0,IG_Database()\IG_Genre,1)
    EndIf
    
    SetActiveGadget(Main_List)
    
    SetGadgetState(Main_List,old_pos)
    
  EndIf

EndProcedure

Procedure FTP_Update()
  
  Protected NewList ftp_list.s()
  Protected NewList ftp_folder.s()
  Protected NewList ftp_subfolder.s()
  Protected NewMap compare_map.i()
  
  Protected gamepath.s,demopath.s,betapath.s, game_ftp.s, beta_ftp.s, demo_ftp.s, main_ftp.s
  Protected ftp_server.s, ftp_user.s, ftp_pass.s, ftp_port.i, ftp_passive.b
  Protected ftp1.i, ftp2.i, ftp3.i
  
  main_ftp="Retroplay WHDLoad Packs"
  ftp_server="grandis.nu"
  ftp_user="ftp"
  ftp_pass="amiga"
  ftp_passive=#True
  ftp_port=21
  
  ForEach IG_Database()
    compare_map(IG_Database()\IG_LHAFile)=ListIndex(IG_Database())
  Next
    
  AddElement(ftp_folder())
  ftp_folder()="Commodore_Amiga_-_WHDLoad_-_Games"
  AddElement(ftp_folder())
  ftp_folder()="Commodore_Amiga_-_WHDLoad_-_Demos"
  AddElement(ftp_folder())
  ftp_folder()="Commodore_Amiga_-_WHDLoad_-_Games_-_Beta_&_Unreleased"
  
  InitNetwork()       
  
  AddElement(ftp_subfolder())
  ftp_subfolder()="0"
  For i=0 To 25
    AddElement(ftp_subfolder())
    ftp_subfolder()=Chr(97+i)
  Next
  OpenConsole("FTP Download")
  PrintN("Connecting To EAB FTP Server...")
  PrintN("")
  If OpenFTP(#FTP,ftp_server,ftp_user,ftp_pass,ftp_passive,ftp_port)
    PrintN("Connected to "+ftp_server+" on port:"+Str(ftp_port))
    PrintN("")
    For ftp1=0 To 2
      SelectElement(ftp_folder(),ftp1)
      For ftp2=0 To 26
        SelectElement(ftp_subfolder(),ftp2)
        PrintN("Scanning "+main_ftp+"/"+ftp_folder()+"/"+ftp_subfolder()+" folder...")
        If SetFTPDirectory(#FTP,main_ftp+"/"+ftp_folder()+"/"+ftp_subfolder())    
          If ExamineFTPDirectory(#FTP)
            While NextFTPDirectoryEntry(#FTP)
              If FTPDirectoryEntryType(#FTP)=#PB_FTP_File And FTPDirectoryEntrySize(#FTP)>0
                If Not FindMapElement(compare_map(),FTPDirectoryEntryName(#FTP))
                  PrintN("Downloading: "+FTPDirectoryEntryName(#FTP)+" ("+FTPDirectoryEntrySize(#FTP)+")")
                  Select ftp1
                    Case 0 : path="games\"
                    Case 1 : path="demos\"
                    Case 2 : path="beta\"
                  EndSelect
                  ReceiveFTPFile(#FTP,FTPDirectoryEntryName(#FTP), "I:\Temp\"+path+FTPDirectoryEntryName(#FTP))
                EndIf
              EndIf
            Wend
            FinishFTPDirectory(#FTP)
            SetFTPDirectory(#FTP,"/") 
          EndIf
        EndIf
      Next
    Next
    CloseConsole()
  Else
    PrintN("Error: Can't Connect To FTP.")
    Delay(2000)
  EndIf
  CloseFTP(#FTP)
  
  FreeMap(compare_map())
  FreeList(ftp_folder())
  FreeList(ftp_subfolder())
  FreeList(ftp_list())
  
EndProcedure 

Procedure Draw_Main_Window()
   
  Protected g_file.i
  
  OpenWindow(#MAIN_WINDOW, 0, 0, 608, 616, W_Title , #PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_MinimizeGadget)
  StickyWindow(#MAIN_WINDOW,#True)
  SmartWindowRefresh(#MAIN_WINDOW,#True)
    
  CreateMenu(Main_Menu, WindowID(#MAIN_WINDOW))
  MenuTitle("File")
  MenuItem(#MenuItem_29, "Run Game")
  MenuBar()
  MenuItem(#MenuItem_2, "Open List")
  MenuBar()
  MenuItem(#MenuItem_4, "Save Gameslist (Old)")
  MenuItem(#MenuItem_5, "Save Gameslist (CSV)")
  MenuItem(#MenuItem_35, "Save Gameslist (DB)")
  MenuBar()
  MenuItem(#MenuItem_7, "Save Database")
  MenuBar()
  MenuItem(#MenuItem_8, "Quit")
  MenuTitle("Create")
  MenuItem(#MenuItem_1, "Make Game List")
  MenuBar()
  MenuItem(#MenuItem_3, "Merge Game Lists")
  MenuBar()
  MenuItem(#MenuItem_31, "Make Game Folder")
  MenuBar()
  MenuItem(#MenuItem_32, "Extract IFF Archive")
  MenuItem(#MenuItem_33, "Make IFF Archive")
  MenuTitle("Database")
  MenuItem(#MenuItem_6, "Clear Gamelist")
  MenuBar()
  MenuItem(#MenuItem_9, "Fix Gameslist")
  MenuItem(#MenuItem_10, "Fix Names Only")
  MenuBar()
  OpenSubMenu("Update")
  MenuItem(#MenuItem_16, "Update Database")
  MenuItem(#MenuItem_39, "Update FTP")
  MenuItem(#MenuItem_36, "Update Icons")
  MenuItem(#MenuItem_38, "Update Folders")
  CloseSubMenu()
  MenuItem(#MenuItem_11, "Check Availability")
  OpenSubMenu("Set List Type")
  MenuItem(#MenuItem_23, "Set To Game")
  MenuItem(#MenuItem_24, "Set To Beta")
  MenuItem(#MenuItem_25, "Set To Demo")
  CloseSubMenu()
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
  MenuItem(#MenuItem_37, "Back-Up DB (JSON)")
  SetMenuItemState(Main_Menu,#MenuItem_37,JSON_Backup)
  MenuBar()
  MenuItem(#MenuItem_15, "Reload Genres")
  ;TextGadget(#PB_Any, 8, 411, 72, 24, "List Filter",#PB_Text_Center)
  ;Main_Genre_Combo = ComboBoxGadget(#PB_Any, 80, 408, 416, 24)
  Main_Genre_Combo = ComboBoxGadget(#PB_Any, 260, 408, 236, 24)
  TextGadget(#PB_Any, 178, 413, 72, 24, "Genre Filter", #PB_Text_Center)
  Main_Type_Combo = ComboBoxGadget(#PB_Any, 60, 410, 110, 25)
  TextGadget(#PB_Any, 8, 413, 42, 24, "Type", #PB_Text_Center)
  Main_List = ListIconGadget(#PB_Any, 8, 8, 488, 392, "Column 1", 100, #PB_ListIcon_GridLines | #LVS_NOCOLUMNHEADER | #PB_ListIcon_FullRowSelect)
  Make_Button = ButtonGadget(#PB_Any, 504, 8, 96, 40, "Make List")
  GadgetToolTip(Make_Button, "Make Gameslist")
  LoadGL_Button = ButtonGadget(#PB_Any, 504, 56, 96, 40, "Open List")
  GadgetToolTip(LoadGL_Button, "Open Gameslist")
  SaveGL_Button = ButtonGadget(#PB_Any, 504, 104, 96, 40, "Run Program")
  GadgetToolTip(SaveGL_Button, "Save Gameslist")
  CSV_Button = ButtonGadget(#PB_Any, 504, 152, 96, 40, "Save List (CSV)")
  GadgetToolTip(CSV_Button, "Save Gameslist as CSV")
  Clear_Button = ButtonGadget(#PB_Any, 504, 200, 96, 40, "Clear List")
  GadgetToolTip(Clear_Button, "Clear Gameslist")
  SaveDB_Button = ButtonGadget(#PB_Any, 504, 248, 96, 40, "Save Database")
  GadgetToolTip(SaveDB_Button, "Save Database")
  Fix_Button = ButtonGadget(#PB_Any, 504, 296, 96, 40, "Fix List")
  GadgetToolTip(Fix_Button, "Fix Gameslist")
  Edit_Button = ButtonGadget(#PB_Any, 504, 344, 96, 40, "Edit Entry")
  GadgetToolTip(Edit_Button, "Edit Entry")
  Path_Button = ButtonGadget(#PB_Any, 504, 392, 96, 40, "Delete Entry")
  GadgetToolTip(Path_Button, "Set Path")
  Info_List = ListIconGadget(#PB_Any, 8, 456, 408, 136, "Column 1", 100, #PB_ListIcon_GridLines | #LVS_NOCOLUMNHEADER | #PB_ListIcon_FullRowSelect)
  TextGadget(#PB_Any, 8, 440, 104, 16, "Game Information")
  Main_Image = CanvasGadget(#PB_Any, 424, 456, 176, 136)
  TextGadget(#PB_Any, 424, 440, 88, 16, "IFF Screenshot")
  
  SetGadgetItemAttribute(Main_List,0,#PB_ListIcon_ColumnWidth,GadgetWidth(Main_List)-4)
  SetGadgetItemAttribute(Info_List,0,#PB_ListIcon_ColumnWidth,90)
  AddGadgetColumn(Info_List,1,"",492)
  
  AddGadgetItem(Main_Type_Combo,-1,"All")
  AddGadgetItem(Main_Type_Combo,-1,"Games")
  AddGadgetItem(Main_Type_Combo,-1,"Demos")
  AddGadgetItem(Main_Type_Combo,-1,"Beta / Unreleased")
  SetGadgetState(Main_Type_Combo,0)
  
  If ReadFile(g_file,"genres")
    
    While Not Eof(g_file)
      AddElement(Genre_List())
      Genre_List()=ReadString(g_file)
      Genre_Map(Genre_List())=Genre_List()
    Wend
    
    CloseFile(g_file)
    
    AddGadgetItem(Main_Genre_Combo,-1,"All")
    AddGadgetItem(Main_Genre_Combo,-1,"No Image")
    AddGadgetItem(Main_Genre_Combo,-1,"Available")
    AddGadgetItem(Main_Genre_Combo,-1,"Missing")
    AddGadgetItem(Main_Genre_Combo,-1,"Invalid Genre")
    ForEach Genre_List()
      AddGadgetItem(Main_Genre_Combo,-1,Genre_List())
    Next

    SetGadgetState(Main_Genre_Combo,0)

  Else
    
    MessageRequester("Error","Cannot find genres file!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
    
  EndIf
  
  If IFF_Smooth=#PB_Image_Raw
    SetMenuItemState(Main_Menu,#MenuItem_20,#False)
  Else
    SetMenuItemState(Main_Menu,#MenuItem_20,#True)
  EndIf
  
  CreateImage(#IFF_BLANK,DpiX(176), DpiY(136),32,#Black)
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

home_path=GetCurrentDirectory()

Load_Prefs()

Draw_Main_Window()

Window_Update()

Load_DB()

Draw_List()
Draw_Info(0)

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
            Image_Popup()
          EndIf
        EndIf
      EndIf
      
    Case #PB_Event_Menu
      Select EventMenu()
        Case #MenuItem_1 ;{- Make Gameslist
          StickyWindow(#MAIN_WINDOW,#False)
          path=Select_Window_Make()
          If path<>"exit"
            Select path
                Case "Folder"
                  Create_Gameslist_Folder()
                Case "Archive"
                  Create_Gameslist()    
                EndSelect
          EndIf
          StickyWindow(#MAIN_WINDOW,#True) ;}          
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
        Case #MenuItem_9 ;{- Fix Gameslist
          If ListSize(IG_Database())>0
            Fix_Gameslist(#False)
            Draw_List()
            Message_RequesterEx("Results", "Processed: "+Str(st_processed)+#LF$+"Fixed: "+Str(st_fixed), 125)
          EndIf
          SetWindowTitle(#MAIN_WINDOW, W_Title+" ("+Str(ListSize(IG_Database()))+" Games)") ;}
        Case #MenuItem_10 ;{- Fix Names Only
          If ListSize(IG_Database())>0
            Fix_Gameslist(#True)
            Draw_List()
            Message_RequesterEx("Results", "Processed: "+Str(st_processed)+#LF$+"Fixed: "+Str(st_fixed), 125)
          EndIf
          SetWindowTitle(#MAIN_WINDOW, W_Title+" ("+Str(ListSize(IG_Database()))+" Games)") ;}
        Case #MenuItem_11 ;{- Check Availability
          Check_Availability();}
        Case #MenuItem_21 ;{- Scrape Demos
          If ListSize(IG_Database())>0
            StickyWindow(#MAIN_WINDOW,#False)
            Scrape_Demos()
            Draw_List()
            StickyWindow(#MAIN_WINDOW,#True)
          EndIf ;}
        Case #MenuItem_22 ;{- Scrape Beta
          If ListSize(IG_Database())>0
            StickyWindow(#MAIN_WINDOW,#False)
            Scrape_Beta()
            Draw_List()
            StickyWindow(#MAIN_WINDOW,#True)
          EndIf ;}
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
          Check_Dirs()
          ;Update_Database()
          ;If ListSize(IG_Database())>0
          ;  Draw_List()
          ;EndIf;}
        Case #MenuItem_17 ;{- Set LHA Path
          path=OpenFileRequester("7-Zip Path","7z.exe","*.exe",0)
          If path<>""
            LHA_Path=path
          EndIf;}
        Case #MenuItem_18 ;{- Set LZX Path
          path=OpenFileRequester("UnLZX Path","unlzx.exe","*.exe",0)
          If path<>""
            LZX_Path=path
          EndIf;} 
        Case #MenuItem_20 ;{- Smooth Popup
          If IFF_Smooth=#PB_Image_Raw
            SetMenuItemState(Main_Menu,#MenuItem_20,#True)
            IFF_Smooth=#PB_Image_Smooth
          Else
            SetMenuItemState(Main_Menu,#MenuItem_20,#False)
            IFF_Smooth=#PB_Image_Raw
          EndIf
          ;}
        Case #MenuItem_23 ;{- Set To Game
          ForEach IG_Database()
            IG_Database()\IG_Type="Game"
          Next;}
        Case #MenuItem_24 ;{- Set To Beta
          ForEach IG_Database()
            IG_Database()\IG_Type="Beta"
          Next
          Draw_List();}
        Case #MenuItem_25 ;{- Set To Demo
          ForEach IG_Database()
            IG_Database()\IG_Type="Demo"
          Next;}
        Case #MenuItem_26 ;{- Set Demo Image Path
          path=PathRequester("Demo Path",Demo_Img_Path)
          If path<>""
            Demo_Img_Path=path
          EndIf;}
        Case #MenuItem_27 ;{- Set Beta Image Path
          path=PathRequester("Beta Path",Beta_Img_Path)
          If path<>""
            Beta_Img_Path=path
          EndIf;}
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
          Extract_IFF_Archive()
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
        Case #MenuItem_36 ;{- Update Slaves
          Update_Icons()
          If ListSize(IG_Database())>0
            Draw_List()
          EndIf;}
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
          ForEach IG_Database()
            count=CountString(IG_Database()\IG_Path,"/")
            IG_Database()\IG_Folder=StringField(IG_Database()\IG_Path,count,"/")
          Next
          
          If ListSize(IG_Database())>0
            SelectElement(List_Numbers(),GetGadgetState(Main_List))
              Draw_Info(List_Numbers())
          EndIf;}  
        Case #MenuItem_39 ;{- FTP Update
          FTP_Update()
         ;}    
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
              PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_12)
            EndIf
          EndIf
          
        Case Main_Image
          If ListSize(IG_Database())>0
            If EventType()= #PB_EventType_LeftDoubleClick
              Image_Popup()
            EndIf
          EndIf
          
        Case Main_Type_Combo
          If EventType()=#PB_EventType_Change
            ForEach IG_Database()
              Select GetGadgetState(Main_Type_Combo)
                Case 0
                  IG_Database()\IG_Filtered=#False
                Case 1
                  If IG_Database()\IG_Type="Game"
                    IG_Database()\IG_Filtered=#False
                  Else
                    IG_Database()\IG_Filtered=#True
                  EndIf
                Case 2
                  If IG_Database()\IG_Type="Demo"
                    IG_Database()\IG_Filtered=#False
                  Else
                    IG_Database()\IG_Filtered=#True
                  EndIf
                Case 3
                  If IG_Database()\IG_Type="Beta"
                    IG_Database()\IG_Filtered=#False
                  Else
                    IG_Database()\IG_Filtered=#True
                  EndIf
              EndSelect
            Next
            Draw_List() 
          EndIf
          
        Case Main_Genre_Combo
          If EventType()=#PB_EventType_Change
            
            ForEach IG_Database()
              IG_Database()\IG_Filtered=#True
            Next
            
            path=GetGadgetText(Main_Genre_Combo)
            
            If ListSize(IG_Database())>0
              
              ForEach IG_Database()
                If path=IG_Database()\IG_Genre
                  IG_Database()\IG_Filtered=#False
                EndIf
              Next
              
              Select path
                  
                Case "No Image"
                  Check_Missing_Images()  
                  
                Case "Invalid Genre"
                  ForEach IG_Database()
                    If Not FindMapElement(Genre_Map(),IG_Database()\IG_Genre)
                      IG_Database()\IG_Filtered=#False
                    Else
                      IG_Database()\IG_Filtered=#True
                    EndIf
                  Next
                  
                Case "All"
                  ForEach IG_Database()
                    IG_Database()\IG_Filtered=#False
                  Next
                                                      
                Case "Available"
                  ForEach IG_Database()
                    If IG_Database()\IG_Available=#True
                      IG_Database()\IG_Filtered=#False
                    Else
                      IG_Database()\IG_Filtered=#True
                    EndIf    
                  Next
                Case "Missing"
                  ForEach IG_Database()
                    If IG_Database()\IG_Available=#False
                      IG_Database()\IG_Filtered=#False
                    Else
                      IG_Database()\IG_Filtered=#True
                    EndIf    
                  Next
                  
              EndSelect
              Draw_List()
              If ListSize(List_Numbers())>0
                SelectElement(List_Numbers(),GetGadgetState(Main_List))
                Draw_Info(List_Numbers())
              Else
                Draw_Info(-1)
              EndIf
            EndIf
          EndIf
        
          
        Case Make_Button
          PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_1)

        Case LoadGL_Button
          PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_2)

        Case SaveGL_Button
          PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_29)
          
        Case CSV_Button
          PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_5)
          
        Case Clear_Button
          PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_6)   
          
        Case SaveDB_Button
          PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_7)
 
        Case Fix_Button
          PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_9) 
          
        Case Edit_Button
          PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_12)
          
        Case Path_Button
          PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_28)  
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
; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 1514
; FirstLine = 263
; Folding = AAAAIAAABAABAA5
; EnableXP
; EnableAdmin
; DPIAware
; UseIcon = joystick.ico
; Executable = igtool.exe
; Compiler = PureBasic 5.71 LTS (Windows - x86)
; Debugger = Standalone