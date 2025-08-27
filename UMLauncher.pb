; UltraMiggy Launcher
;
; Version 0.6
;
; © 2021 Paul Vince (MrV2k)
;
; https://easymame.mameworld.info
;
; [ PB V5.7x / 64Bit / Windows / DPI ]
;
; A launcher for Commodore Amiga Software
;
;============================================
; VERSION INFO v0.6
;============================================
; Restructured database
;   Split Launcher DB functions from DB
;   Renamed to UM_Database (from UM_Database)
;
; Unified code with Ultramiggy
;   Kept Game_Settings_DB a UMLauncher exclusive as not needed in main program
;
; Threaded image loading in Draw_Info procedure.
; Threaded info loading procedure and split from Draw_Info.
;
; Switched back to xadunfile for lzx archives to preserve file date.
;
; Added basic joystick support
;
;============================================

EnableExplicit

;- __________ Declares

Declare Save_Prefs()

;- __________ Enumerations

Enumeration
  
  #MAIN_WINDOW
  #RUN_WINDOW
  #MAIN_STATUS
  #MAIN_CANVAS
  #MAIN_LIST
  #MAIN_LOGO
  #MAIN_HEADER
  #MAIN_HEADER_IMAGE
  #CLOSE_BUTTON
  #CLOSE_BUTTON_IMAGE
  #MINIMIZE_BUTTON
  #MINIMIZE_BUTTON_IMAGE
  #PLAY_BUTTON
  #PLAY_BUTTON_IMAGE
  #PLAY_ICON
  #OPTIONS_ICON
  ;#IMAGE_ICON
  #FILTER_BUTTON
  #FILTER_IMAGE
  #SETTINGS_BUTTON
  #SETTINGS_IMAGE
  #CLEAR_BUTTON
  #CLEAR_IMAGE
  #POPUP_WINDOW
  #EDIT_WINDOW
  #SETTINGS_WINDOW
  #FILTER_WINDOW
  #PATH_CONTAINER
  #OPTIONS_CONTAINER
  #PNG_IMAGE
  #COVER_IMAGE
  #TITLE_IMAGE
  #SCREEN_IMAGE
  #CONVERT_IMAGE
  #SCREEN_BLANK
  #COVER_BLANK
  #IFF_POPUP
  #PREVIEW_IMAGE
  #PDF_IMAGE
  #TEXT_IMAGE
  #TEMP_IMAGE
  #BACK_IMAGE
  #POPUP_MENU
  #ALPHA_MASK
  #FILTER_PANEL
  #EDITOR_MENU
  #HEADER_FONT
  #BUTTON_FONT
  #INFO_FONT
  
EndEnumeration

Enumeration PopupMenu
  
  #Popup_1=900
  #Popup_2
  #Popup_3
  #Popup_4
  #Popup_5
  #Popup_6
  #Popup_7
  #Popup_8
  #Popup_9
  #Popup_10
  #Popup_11
  #Popup_12
  #Popup_13
  #Popup_14
  #Popup_15
  #Popup_16
  #Popup_17
  #Popup_18
  #Popup_19
  #Popup_20
  
EndEnumeration

Enumeration FormMenu
  #MenuItem_1
  #MenuItem_2
  #MenuItem_3
  #Menuitem_4
  #Menuitem_5
  #Menuitem_6
  #MenuItem_7
  #MenuItem_8
  #MenuItem_9
  #MenuItem_10
EndEnumeration

;- __________ Structures

Structure UM_Data
  UM_Title.s
  UM_Short.s
  UM_Genre.s
  UM_Folder.s
  UM_Subfolder.s
  UM_Slave.s
  UM_Slave_Date.s
  UM_LHAFile.s
  UM_Favourite.b
  UM_Language.s
  UM_Memory.s
  UM_AGA.b
  UM_ECSOCS.b
  UM_NTSC.b
  UM_CD32.b
  UM_CDTV.b
  UM_CDROM.b
  UM_MT32.b
  UM_NoSound.b
  UM_Disks.s
  UM_Demo.b
  UM_Intro.b
  UM_NoIntro.b
  UM_Coverdisk.b
  UM_PD.b
  UM_Preview.b
  UM_Files.b
  UM_Image.b
  UM_Arcadia.b
  UM_Publisher.s
  UM_Developer.s
  UM_Party.s
  UM_Type.s
  UM_Year.s
  UM_Players.s
  UM_Default_Icon.s
  UM_HOL_Entry.s
  UM_Lemon_Entry.s
  UM_WHD_Entry.s
  UM_Janeway.s
  UM_Pouet.s
  UM_Filtered.b
  UM_Config.i
  UM_Available.b
  UM_Image_Avail.b
  UM_Cover_Avail.b
  UM_Title_Avail.b
  UM_Beta.b
  UM_InstallSize.i
  UM_Version.s
EndStructure

Structure f_data
  F_Title.s
  F_Short.s
  F_Genre.s
  F_Favourite.b
  F_Folder.s
  F_SubFolder.s
  F_Slave.s
  F_Slave_Date.s
  F_Path.s
  F_LHAFile.s
  F_Language.s
  F_Memory.s
  F_AGA.b
  F_ECSOCS.b
  F_NTSC.b
  F_CD32.b
  F_CDTV.b
  F_Arcadia.b
  F_CDROM.b
  F_MT32.b
  F_NoSound.b
  F_Disks.s
  F_Demo.b
  F_Intro.b
  F_NoIntro.b
  F_Coverdisk.b
  F_Preview.b
  F_Files.b
  F_Image.b
  F_Players.s
  F_Publisher.s
  F_Developer.s
  F_Type.s
  F_Year.s
  F_Config.i
  List F_Icons.s()
  F_Default_Icon.s
EndStructure

Structure Game_Data
  GS_Title.s
  GS_Name.s
  GS_Config.i
  GS_Default_Icon.s
  GS_Favourite.b
  GS_Times_Played.i
  GS_Last_Played.s
  GS_Bezel.i
  GS_Screen_Type.i
EndStructure

Structure thrds
  t_image.l
  t_path.s
EndStructure

;- __________ Lists

Global NewList UM_Database.UM_Data()
Global NewList Game_Settings_DB.Game_Data()

Global NewList Fix_List.f_data()

Global NewList List_Numbers.i()

Global NewList Files.s()
Global NewList File_List.s()

Global NewList Genre_List.s()
Global NewMap Genre_Map.s()

;- __________ Global Variables

Global W_Title.s="UltraMiggy"


Global Main_Path.s, path.s, path2.s, List_Type.s, List_Path.s

Global Event.i, listnum.i, count.i, i.i, list_pos.i, quit

Global Main_Menu.i, Title_Image, Cover_Image, Screen_Image, Info_Gadget, Mutex

;Global #MAIN_LIST

Global Language_Gadget, Memory_Gadget, Year_Gadget, Publisher_Gadget, Disks_Gadget, Developer_Gadget
Global Chipset_Gadget, Hardware_Gadget, DiskCategory_Gadget, Sound_Gadget, DataType_Gadget, Players_Gadget
Global Search_Gadget, Coder_Gadget, Category_Gadget, Favourite_Gadget, Genre_Gadget, Reset_Button, Filter_Button, Exit_Button

Global Fl_Category.s="All", Fl_Fave.s="All", Fl_Publisher.s="All", Fl_Year.s="All", Fl_Language.s="All", Fl_Memory.s="All", Fl_Disks.s="All", Fl_Chipset.s="All", Fl_DiskType.s="All"
Global Fl_HWare.s="All", Fl_Sound.s="All", Fl_Coder.s="All", Fl_DataType.s="All", Fl_Search.s="", Fl_Players.s="All", Fl_Genre.s="All", Fl_Developer.s="All"

Global Fl_Category_Num=0, Fl_Fave_Num=0, Fl_Publisher_Num=0, Fl_Year_Num=0, Fl_Language_Num=0, Fl_Memory_Num=0, Fl_Disks_Num=0, Fl_Chipset_Num=0, Fl_DiskType_Num=0
Global Fl_HWare_Num=0, Fl_Sound_Num=0, Fl_Coder_Num=0, Fl_DataType_Num=0, Fl_Players_Num=0, Fl_Genre_Num=0, Fl_Developer_Num=0

Global Home_Path.s=GetCurrentDirectory()
Global Data_Path.s=Home_Path+"UM_Data\"

Global LHA_Path.s=Home_Path+"Archivers\7z.exe"
Global IZARC_Path.s=Home_Path+"Archivers\izarcc.exe"
Global LZX_Path.s=Home_Path+"Archivers\unlzx.exe"

Global WHD_TempDir.s=GetTemporaryDirectory()+"WHDTemp"
Global DB_Path.s=Home_Path
Global Game_Img_Path.s=Home_Path+"Images\"
Global Game_Data_Path.s=Home_Path+"Game_Info\"
Global Backup_Path.s=Home_Path+"Backup\"
Global CD32_Path.s=Home_Path+"CD32\"
Global WHD_Folder.s=Home_Path+"WHD\"
Global WinUAE_Path.s=Home_Path+"WinUAE\winuae64.exe"
Global ConfUM_Path.s=Home_Path+"Configurations\" 
Global NConvert_Path.s=Home_Path+"NConvert\nconvert.exe"

Global Close_UAE.b=#True
Global JSON_Backup=#True
Global PNG_Filter.l=#True
Global Short_Names.b=#False
Global Scaler.l=#PB_Image_Raw

;- __________ Macros

Macro Window_Update() ; <---------------------------------------------> Waits For Window Update
  While WindowEvent() : Wend
EndMacro

Macro Set_Menu (s_bool)
  
  DisableGadget(Genre_Gadget,s_bool)
  
  DisableMenuItem(Main_Menu,#Menuitem_5,s_bool)
  DisableMenuItem(Main_Menu,#Menuitem_3,s_bool)
  DisableMenuItem(Main_Menu,#Menuitem_4,s_bool)
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

Macro Pause_Console()
  PrintN("Press A Key To Continue...")
  Repeat : Until Inkey()<>""
EndMacro

Macro Pause_Gadget(gadget)
  SendMessage_(GadgetID(gadget),#WM_SETREDRAW,#False,0)
EndMacro

Macro Resume_Gadget(gadget)
  SendMessage_(GadgetID(gadget),#WM_SETREDRAW,#True,0)
  RedrawWindow_(GadgetID(gadget),#Null,#Null,#RDW_INVALIDATE)
EndMacro

Macro Pause_Window(window)
  SendMessage_(WindowID(window),#WM_SETREDRAW,#False,0)
EndMacro

Macro Resume_Window(window)
  SendMessage_(WindowID(window),#WM_SETREDRAW,#True,0)
  RedrawWindow_(WindowID(window),#Null,#Null,#RDW_INVALIDATE)
EndMacro

Macro PrintNCol(PText,PFCol,PBCol)
  ConsoleColor(PFCol,PBCol)
  PrintN(PText)
  ConsoleColor(7,0)
EndMacro

Macro PrintS()
  PrintN("")
EndMacro

;- __________ Procedures

Procedure Round_Image(imagenum.i, amount.i)
  
  If IsImage(imagenum)
  
  Protected w=ImageWidth(imagenum)
  Protected h=ImageHeight(imagenum)
  
  If CreateImage(#ALPHA_MASK, w, h, 32, #PB_Image_Transparent)
    If StartDrawing(ImageOutput(#ALPHA_MASK))
      DrawingMode(#PB_2DDrawing_AlphaChannel)
      RoundBox(0, 0, w, h, amount, amount, RGBA(0, 0, 0, 255))
      StopDrawing()
    EndIf
  EndIf
  
  If StartDrawing(ImageOutput(#ALPHA_MASK))
    DrawingMode(#PB_2DDrawing_Default)
    DrawImage(ImageID(imagenum), 0, 0)      
    StopDrawing()
  EndIf
  
  CopyImage(#ALPHA_MASK,imagenum)
  
  FreeImage (#ALPHA_MASK)
  
  EndIf
  
EndProcedure

Procedure Create_Button(imagenum.i, title.s)
  
  Protected tempimage.i
  
  CreateImage(tempimage,DpiX(100),DpiY(50),32,RGB(240, 235, 233))
  StartDrawing(ImageOutput(tempimage))
  DrawingMode(#PB_2DDrawing_AlphaBlend)
  RoundBox(2,2,DpiX(98),DpiY(48),8,8,RGBA(0,0,0,48))
  DrawingMode(#PB_2DDrawing_Default)
  RoundBox(0,0,DpiX(98),DpiY(48),8,8,RGB(180, 159, 133))
  DrawingMode(#PB_2DDrawing_AlphaBlend)
  DrawingFont(FontID(#BUTTON_FONT))
  DrawText(10,4,title,RGBA(0,0,0,128),RGBA(180,159,133,0))
  StopDrawing()
  
  CopyImage(tempimage,imagenum)
  
  FreeImage(tempimage)
  
EndProcedure

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

Procedure.s Title_Extras()
  
  Protected extras.s=""
  
  If UM_Database()\UM_Type="Demo"
    extras+" ("+UM_Database()\UM_Publisher+")"
  EndIf
  
  If UM_Database()\UM_Memory<>""
    extras+" ("+UM_Database()\UM_Memory+")"
  EndIf   
  
  If UM_Database()\UM_Language<>"" And UM_Database()\UM_Language<>"English"
    extras+" ("+UM_Database()\UM_Language+")"
  EndIf
  
  If UM_Database()\UM_Files<>0
    extras+" (Files)"
  EndIf
  
  If UM_Database()\UM_Image<>0
    extras+" (Image)"
  EndIf
  
  If UM_Database()\UM_Disks<>""
    extras+" ("+UM_Database()\UM_Disks+")"
  EndIf
  
  If UM_Database()\UM_NTSC<>0
    extras+" (NTSC)"
  EndIf
  
  If UM_Database()\UM_Demo<>0
    extras+" (Game Demo)"
  EndIf
  
  If UM_Database()\UM_Intro<>0
    extras+" (Intro)"
  EndIf
  
  If UM_Database()\UM_NoIntro<>0
    extras+" (No Intro)"
  EndIf
  
  If UM_Database()\UM_Preview<>0
    extras+" (Preview)"
  EndIf
  
  If UM_Database()\UM_Coverdisk<>0
    extras+" (Coverdisk)"
  EndIf
  
  If UM_Database()\UM_Arcadia<>0
    extras+" (Arcadia)"
  EndIf
  
  If UM_Database()\UM_MT32<>0
    extras+" (MT32)"
  EndIf
  
  If UM_Database()\UM_CDROM<>0
    extras+" (CD-ROM)"
  EndIf
  
  If UM_Database()\UM_CD32<>0
    extras+" (CD32)"
  EndIf
  
  If UM_Database()\UM_CDTV<>0
    extras+" (CDTV)"
  EndIf
  
  If UM_Database()\UM_AGA<>0 And UM_Database()\UM_CD32=0
    extras+" (AGA)"
  EndIf
  
  If UM_Database()\UM_Type="Beta"
    extras+" ("+UM_Database()\UM_Type+")"
  EndIf
  
  If UM_Database()\UM_Favourite=#True
    extras+ "  ♥"
  EndIf
  
  ProcedureReturn extras
  
EndProcedure

Procedure Reset_Filter()
  If IsWindow(#FILTER_WINDOW)
    SetGadgetState(Language_Gadget,0)
    SetGadgetState(Memory_Gadget, 0)
    SetGadgetState(Year_Gadget,0) 
    SetGadgetState(Publisher_Gadget,0) 
    SetGadgetState(Developer_Gadget,0) 
    SetGadgetState(Disks_Gadget,0)
    SetGadgetState(Chipset_Gadget,0) 
    SetGadgetState(Hardware_Gadget,0) 
    SetGadgetState(DiskCategory_Gadget,0) 
    SetGadgetState(Sound_Gadget,0) 
    SetGadgetState(DataType_Gadget,0)
    SetGadgetState(Coder_Gadget,0) 
    SetGadgetState(Category_Gadget,0) 
    SetGadgetState(Favourite_Gadget,0) 
    SetGadgetState(Genre_Gadget,0)
    SetGadgetState(Players_Gadget,0)
  EndIf
  SetGadgetText(Search_Gadget,"") 
  Fl_Category="All"
  Fl_Fave="All"
  Fl_Publisher="All"
  Fl_Developer="All"
  Fl_Year="All"
  Fl_Language="All"
  Fl_Memory="All"
  Fl_Disks="All"
  Fl_Chipset="All"
  Fl_DiskType="All"
  Fl_HWare="All"
  Fl_Sound="All"
  Fl_Coder="All"
  Fl_DataType="All"
  Fl_Players="All"
  Fl_Genre="All"
  Fl_Search=""
  Fl_Category_Num=0
  Fl_Fave_Num=0
  Fl_Publisher_Num=0
  Fl_Developer_Num=0
  Fl_Year_Num=0
  Fl_Language_Num=0
  Fl_Memory_Num=0
  Fl_Disks_Num=0
  Fl_Chipset_Num=0
  Fl_DiskType_Num=0
  Fl_HWare_Num=0
  Fl_Sound_Num=0
  Fl_Coder_Num=0
  Fl_DataType_Num=0
  Fl_Players_Num=0
  Fl_Genre_Num=0
EndProcedure

Procedure Center_List(old_pos.s)
  
  Pause_Gadget(#MAIN_LIST)
  
  Protected itemheight, hotitem
  
  itemheight = SendMessage_(GadgetID(#MAIN_LIST), #LVM_GETITEMSPACING, #True, 0) >> 16 ; only need to do this once
  ForEach List_Numbers()
    SelectElement(UM_Database(),List_Numbers())
    If UM_Database()\UM_Type+"_"+UM_Database()\UM_Slave=old_pos
      hotitem = List_Numbers()
      SetGadgetState(#MAIN_LIST, hotitem)
      SendMessage_(GadgetID(#MAIN_LIST), #LVM_SCROLL, 0, 0-(CountGadgetItems(#MAIN_LIST) * itemheight)) ; scroll to top
      SendMessage_(GadgetID(#MAIN_LIST), #LVM_SCROLL, 0, (hotitem-17) * itemheight)                     ; scroll to center hot item in listicon
      Window_Update()
      Break
    EndIf
  Next
  
  Resume_Gadget(#MAIN_LIST)
  
EndProcedure

Procedure Filter_List()
  
  ForEach UM_Database()
    
    UM_Database()\UM_Filtered=#False
    
    If Fl_Search<>""
      If Not FindString(LCase(UM_Database()\UM_Title),LCase(Fl_Search),#PB_String_NoCase)
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    
    If Fl_Category<>"All" And Fl_Category<>"Game/Beta"
      If UM_Database()\UM_Type<>Fl_Category
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    
    If Fl_Category="Game/Beta"
      If UM_Database()\UM_Type="Demo"
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    
    If Fl_Players="No Players"
      If UM_Database()\UM_Players<>"0" And UM_Database()\UM_Players<>""
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    If Fl_Players="1 Player"
      If UM_Database()\UM_Players<>"1"
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    If Fl_Players="2 Players"
      If UM_Database()\UM_Players<>"2"
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    If Fl_Players="3 Players"
      If UM_Database()\UM_Players<>"3"
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    If Fl_Players="4 Players"
      If UM_Database()\UM_Players<>"4"
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    If Fl_Players="5+ Players"
      If Val(UM_Database()\UM_Players)<5
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    
    If Fl_Genre<>"All" 
      If UM_Database()\UM_Genre<>Fl_Genre
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf  
    
    If Fl_Publisher<>"All"
      If UM_Database()\UM_Publisher<>Fl_Publisher
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    
    If Fl_Developer<>"All"
      If UM_Database()\UM_Developer<>Fl_Developer
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    
    If Fl_Coder<>"All"
      If UM_Database()\UM_Publisher<>Fl_Coder
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    
    If Fl_Year<>"All"
      If UM_Database()\UM_Year<>Fl_Year
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf 
    
    Select Fl_DiskType
      Case "Game Demo"
        If UM_Database()\UM_Demo<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
      Case "Intro Disk"
        If UM_Database()\UM_Intro<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
      Case "No Intro"
        If UM_Database()\UM_NoIntro<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
      Case "Preview"
        If UM_Database()\UM_Preview<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
      Case "Coverdisk"
        If UM_Database()\UM_Coverdisk<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
    EndSelect
    
    Select Fl_DataType
      Case "Image"
        If UM_Database()\UM_Image<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
      Case "Files"
        If UM_Database()\UM_Files<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
    EndSelect
    
    Select Fl_HWare
      Case "CD32"
        If UM_Database()\UM_CD32<>#True
          UM_Database()\UM_Filtered=#True
        EndIf        
      Case "CDTV"
        If UM_Database()\UM_CDTV<>#True
          UM_Database()\UM_Filtered=#True
        EndIf        
      Case "AmigaCD"
        If UM_Database()\UM_CDROM<>#True
          UM_Database()\UM_Filtered=#True
        EndIf        
      Case "Arcadia"
        If UM_Database()\UM_Arcadia<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
      Case "Amiga"
        If UM_Database()\UM_CD32=#True And UM_Database()\UM_CDTV=#True And UM_Database()\UM_Arcadia=#True And UM_Database()\UM_CDROM=#True
          UM_Database()\UM_Filtered=#True
        EndIf 
    EndSelect
    
    Select Fl_Chipset
      Case "ECS/OCS"
        If UM_Database()\UM_ECSOCS<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
      Case "AGA"
        If UM_Database()\UM_AGA<>#True And UM_Database()\UM_CD32<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
      Case "PAL"
        If UM_Database()\UM_NTSC=#True
          UM_Database()\UM_Filtered=#True
        EndIf
      Case "NTSC"
        If UM_Database()\UM_NTSC<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
    EndSelect
    
    Select Fl_Sound
      Case "MT32"
        If UM_Database()\UM_MT32<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
      Case "No Sound"
        If UM_Database()\UM_NoSound<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
    EndSelect
    
    If Fl_Language<>"All"
      If UM_Database()\UM_Language<>Fl_Language
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf 
    
    If Fl_Memory<>"All"
      If UM_Database()\UM_Memory<>Fl_Memory
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf 
    
    If Fl_Disks<>"All"
      If UM_Database()\UM_Disks<>Fl_Disks
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    
    Select Fl_Fave
        
      Case "Show"        
        If UM_Database()\UM_Favourite<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "Hide"
        If UM_Database()\UM_Favourite=#True
          UM_Database()\UM_Filtered=#True
        EndIf
        
    EndSelect
    
  Next
  
EndProcedure

Procedure Load_Image(*val.thrds)
  
  Shared Mutex
  
  LockMutex(Mutex)
  
  LoadImage(*val\t_image, *val\t_path)
  
  UnlockMutex(Mutex)
  
EndProcedure

Procedure Draw_Game_Info(*nul)
  
  Protected output$, input$, myfile
  
  Pause_Gadget(Info_Gadget)
  
  SetGadgetText(Info_Gadget,"")
  
  output$=""
  output$+LSet("Genre",11," ")+": "+UM_Database()\UM_Genre+#CRLF$
  output$+LSet("Language",11," ")+": "+UM_Database()\UM_Language+#CRLF$
  If UM_Database()\UM_Type<>"Demo"
    output$+LSet("Publisher",11," ")+": "+UM_Database()\UM_Publisher+#CRLF$
    output$+LSet("Developer",11," ")+": "+UM_Database()\UM_Developer+#CRLF$
  Else
    output$+LSet("Group",11," ")+": "+UM_Database()\UM_Publisher+#CRLF$
  EndIf
  output$+LSet("Year",11," ")+": "+UM_Database()\UM_Year+#CRLF$
  If UM_Database()\UM_Players<>"0"
    output$+LSet("Players",11," ")+": "+UM_Database()\UM_Players+#CRLF$
  EndIf
  output$+LSet("Def. Icon",11," ")+": "+Game_Settings_DB()\GS_Default_Icon+#CRLF$
  output$+LSet("Slave",11," ")+": "+UM_Database()\UM_Slave+#CRLF$
  output$+LSet("Slave Date",11," ")+": "+UM_Database()\UM_Slave_Date+#CRLF$
  If UM_Database()\UM_ECSOCS=#True
    output$+LSet("Chipset",11," ")+": "+"OCS / ECS"+#CRLF$
  EndIf
  If UM_Database()\UM_AGA=#True
    output$+LSet("Chipset",11," ")+": "+"AGA"+#CRLF$
  EndIf
  If UM_Database()\UM_CD32=#True
    output$+LSet("Chipset",11," ")+": "+"AGA/CD32"+#CRLF$
  EndIf
  If UM_Database()\UM_AGA<>#True And UM_Database()\UM_ECSOCS<>#True And UM_Database()\UM_CD32<>#True
    output$+LSet("Chipset",11," ")+": "+"Unknown"+#CRLF$
  EndIf
  
  If FileSize(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\game_info.txt")>0 And UM_Database()\UM_Type<>"Demo"
    output$+#CRLF$
    output$+"Description"+#CRLF$
    output$+"-----------"+#CRLF$
    myfile=ReadFile(#PB_Any,Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\game_info.txt")
    If IsFile(myfile)
    While Not Eof(myfile)
      input$=ReadString(myfile)
      output$+input$+#CRLF$
    Wend
    CloseFile(myfile)
    EndIf
  EndIf
  
  SetGadgetText(Info_Gadget,output$)
  
  Resume_Gadget(Info_Gadget)
  
EndProcedure

Procedure Draw_Info(number)
  
  Protected output$, Smooth, imgw, imgh, input$, id
  
  Mutex=CreateMutex()
  
  If IsImage(#PNG_IMAGE) : FreeImage(#PNG_IMAGE) : EndIf
  
  If PNG_Filter : Smooth=#PB_Image_Smooth : Else : Smooth=#PB_Image_Raw : EndIf
  
  If number>-1
    
    SelectElement(UM_Database(),number)
    SelectElement(Game_Settings_DB(),number)
    
    If IsMenu(#POPUP_MENU) : FreeMenu(#POPUP_MENU) : EndIf
    CreatePopupImageMenu(#POPUP_MENU)
    MenuItem(#Menuitem_1,"Play",ImageID(#PLAY_ICON))
    MenuItem(#Menuitem_5,"Game Options",ImageID(#OPTIONS_ICON))
    MenuBar()
    count=0    
    Debug Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"
    ExamineDirectory(0, Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\","*.*")
    count=0
    If ExamineDirectory(0, Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\","*.*")
      count=0
      While NextDirectoryEntry(0)
        If DirectoryEntryName(0)<>"game_info.txt" And DirectoryEntryName(0)<>"." And DirectoryEntryName(0)<>".." And DirectoryEntryName(0)<>"Music"
          If GetExtensionPart(DirectoryEntryName(0))="txt" : id=#TEXT_IMAGE : EndIf
          If GetExtensionPart(DirectoryEntryName(0))="pdf" : id=#PDF_IMAGE : EndIf
          If GetExtensionPart(DirectoryEntryName(0))="jpg" : id=#IMAGE_ICON : EndIf
          If GetExtensionPart(DirectoryEntryName(0))="png" : id=#IMAGE_ICON : EndIf
          If Not FindString(DirectoryEntryName(0),"_")
            MenuItem(900+count,DirectoryEntryName(0),ImageID(id))
            count+1
          EndIf
        EndIf
      Wend
    EndIf
    
    Protected thr.i
    
    Dim mythread.thrds(3)
    
    mythread(0)\t_image=#TITLE_IMAGE
    mythread(0)\t_path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+"_Title.png"
    mythread(1)\t_image=#SCREEN_IMAGE
    mythread(1)\t_path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+"_Screen.png"
    mythread(2)\t_image=#COVER_IMAGE
    mythread(2)\t_path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+"_Cover.png"
    
    For i=0 To 2
      thr=CreateThread(@Load_Image(),@mythread(i))
      Delay(10)
    Next
    
    WaitThread(thr)
    
    FreeArray(mythread())
    
    Round_Image(#TITLE_IMAGE,24)
    ResizeImage(#TITLE_IMAGE,DpiX(317),DpiY(253),Smooth)
    StartDrawing(CanvasOutput(Title_Image))
    DrawingMode(#PB_2DDrawing_AlphaBlend)
    Box(0,0,DpiX(GadgetWidth(Title_Image)),DpiY(GadgetHeight(Title_Image)),RGBA(240,235,233,255))
    RoundBox(3,3,DpiX(317),DpiY(253),16,16,RGBA(0,0,0,48))
    DrawImage(ImageID(#TITLE_IMAGE),0,0)
    StopDrawing()      
    
    Round_Image(#SCREEN_IMAGE,24)
    ResizeImage(#SCREEN_IMAGE,DpiX(317),DpiY(253),Smooth)
    StartDrawing(CanvasOutput(Screen_Image))
    DrawingMode(#PB_2DDrawing_AlphaBlend)
    Box(0,0,DpiX(GadgetWidth(Screen_Image)),DpiY(GadgetHeight(Screen_Image)),RGBA(240,235,233,255))
    RoundBox(3,3,DpiX(317),DpiY(253),16,16,RGBA(0,0,0,48))
    DrawImage(ImageID(#SCREEN_IMAGE),0,0)
    StopDrawing() 
    
    Round_Image(#COVER_IMAGE,20)
    ResizeImage(#COVER_IMAGE,DpiX(317),DpiY(409),Smooth)
    StartDrawing(CanvasOutput(Cover_Image))
    DrawingMode(#PB_2DDrawing_AlphaBlend)
    Box(0,0,DpiX(GadgetWidth(Cover_Image)),DpiY(GadgetHeight(Cover_Image)),RGBA(240,235,233,255))
    RoundBox(3,3,DpiX(317),DpiY(409),14,14,RGBA(0,0,0,48))
    DrawImage(ImageID(#COVER_IMAGE),0,0)
    StopDrawing() 
    
    thr=CreateThread(@Draw_Game_Info(),#Null)
    
  Else  
    
    SetGadgetText(Info_Gadget,"")
    ResizeImage(#SCREEN_BLANK,DpiX(316),DpiY(252),Smooth)
    StartDrawing(CanvasOutput(Title_Image))
    DrawImage(ImageID(#SCREEN_BLANK),0,0)
    StopDrawing()
    StartDrawing(CanvasOutput(Screen_Image))
    DrawImage(ImageID(#SCREEN_BLANK),0,0)
    StopDrawing()
    ResizeImage(#COVER_BLANK,DpiX(316),DpiY(408),Smooth)
    StartDrawing(CanvasOutput(Cover_Image))
    DrawImage(ImageID(#COVER_BLANK),0,0)
    StopDrawing()
    
  EndIf
  
  FreeImage(#TITLE_IMAGE)
  FreeImage(#SCREEN_IMAGE)
  FreeImage(#COVER_IMAGE)
  
EndProcedure

Procedure Draw_List()
  
  Protected game.i, demo.i, beta.i
  
  SortStructuredList(UM_Database(),#PB_Sort_Ascending|#PB_Sort_NoCase,OffsetOf(UM_Data\UM_Title),TypeOf(UM_Data\UM_Title))
  
  UseGadgetList(WindowID(#MAIN_WINDOW))
  
  Pause_Gadget(#MAIN_LIST)
  
  ClearList(List_Numbers())
  ClearGadgetItems(#MAIN_LIST)
  
  Filter_List()
  
  game=0 : demo=0 : beta=0
  
  ForEach UM_Database()
    If UM_Database()\UM_Title<>"" And UM_Database()\UM_Filtered=#False
      AddElement(List_Numbers())
      List_Numbers()=ListIndex(UM_Database()) 
    EndIf
    If UM_Database()\UM_Type="Game" : game+1 : EndIf
    If UM_Database()\UM_Type="Demo" : demo+1 : EndIf
    If UM_Database()\UM_Type="Beta" : beta+1 : EndIf
  Next
  
  ForEach List_Numbers()
    SelectElement(UM_Database(),List_Numbers())
    AddGadgetItem(#MAIN_LIST,-1,UM_Database()\UM_Title+Title_Extras())
  Next
  
  ;   If GetWindowLongPtr_(GadgetID(#MAIN_LIST), #GWL_STYLE) & #WS_VSCROLL
  ;     SetGadgetItemAttribute(#MAIN_LIST,1,#PB_ListIcon_ColumnWidth,GadgetWidth(#MAIN_LIST)-1)
  ;   Else
  ;     SetGadgetItemAttribute(#MAIN_LIST,1,#PB_ListIcon_ColumnWidth,GadgetWidth(#MAIN_LIST)-18)
  ;   EndIf
  ;   
  ;   For count=0 To CountGadgetItems(#MAIN_LIST) Step 2
  ;     SetGadgetItemColor(#MAIN_LIST,count,#PB_Gadget_BackColor,$eeeeee)
  ;   Next
  
  SetGadgetState(#MAIN_LIST,0)
  
  Resume_Gadget(#MAIN_LIST)
  
  SetActiveGadget(#MAIN_LIST)
  
  Select Fl_Category
    Case "All" : count=ListSize(UM_Database())
    Case "Game" : count=game
    Case "Game/Beta" : count=game+beta
    Case "Demo" : count=demo
    Case "Beta" : count=beta
  EndSelect
   
  If ListSize(List_Numbers())>0
    SelectElement(List_Numbers(),0)
  EndIf
  
EndProcedure

Procedure Run_Game(gamenumber.i)
  
  Protected startup_file.i, startup_prog.i, old_pos.i, config.s, old_dir.s 
  
  DisableWindow(#MAIN_WINDOW,#True)
  
  SelectElement(UM_Database(), gamenumber)  
  
  old_pos=GetGadgetState(#MAIN_LIST)
  
  If FileSize(WHD_TempDir)=-2 : DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force) : EndIf
  
  If CreateDirectory(WHD_TempDir)
    
    SetCurrentDirectory(WHD_TempDir)
    
    startup_file=CreateFile(#PB_Any,"whd-startup")
    
    If startup_file
      WriteString(startup_file,"cls"+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+W_Title+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+""+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"T ================================================= |T "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"| ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|[L"+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"| __________________________________________________[| "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"|I __==___________  ___________     ^  ^. _ ^   __  T| "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"||[_j  L_I_I_I_I_j  L_I_I_I_I_j    /|/V||(+/|   ==  l| "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"lI _______________________________  _____  _________I] "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+" |[__I_I_I_I_I_I_I_I_I_I_I_I_I_I_] [__I__] [_I_I_I_]|  "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+" |[___I_I_I_I_I_I_I_I_I_I_I_I_L  I   ___   [_I_I_I_]|  "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+" |[__I_I_I_I_I_I_I_I_I_I_I_I_I_L_I __I_]_  [_I_I_T ||  "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+" |[___I_I_I_I_I_I_I_I_I_I_I_I____] [_I_I_] [___I_I_j|  "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+" | [__I__I_________________I__L_]                   |  "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+" |                                                  |  "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+" l__________________________________________________j  "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+""+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"Starting..."+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+""+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+UM_Database()\UM_Title+Title_Extras()+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"By "+UM_Database()\UM_Publisher+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"Copyright "+UM_Database()\UM_Year+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"wait 2 secs"+#LF$)
      WriteString(startup_file,"cd WHD-HDD:"+#LF$)
      WriteString(startup_file,"cd "+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+"/"+#LF$)
      WriteString(startup_file,"kgiconload "+Game_Settings_DB()\GS_Default_Icon+#LF$)
      If Close_UAE : WriteString(startup_file,"c:uaequit") : EndIf
      FlushFileBuffers(startup_file)
      CloseFile(startup_file)      
    EndIf
    
    config=""
    
    Select Game_Settings_DB()\GS_Config
      Case 0 : config=ConfUM_Path+"A1200_WHD.uae"
      Case 1 : config=ConfUM_Path+"A1200_WHD_030.uae"
      Case 2 : config=ConfUM_Path+"A1200_WHD_040.uae"
      Case 3 : config=ConfUM_Path+"A1200_WHD_CD32.uae"
    EndSelect
    
    OpenWindow(#RUN_WINDOW,0,0,360,70,"Run Program",#PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
    TextGadget(#PB_Any,10,10,340,24,"Starting WinUAE. Please Wait...",#PB_Text_Center)
    TextGadget(#PB_Any,10,35,340,50,"Loading: "+UM_Database()\UM_Title+Title_Extras(),#PB_Text_Center)
    
    startup_prog=RunProgram(WinUAE_Path, "-f "+config+" -s filesystem2=rw,DH1:WHDTemp:"+WHD_TempDir+",0","", #PB_Program_Open| #PB_Program_Read)
    
    If startup_prog
      
      While ProgramRunning(startup_prog) : Delay(10) : Window_Update() : Wend
      
    EndIf
    
    SetCurrentDirectory(home_path)
    
    DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
    
    CloseWindow(#RUN_WINDOW)
    
  EndIf
  
  DisableWindow(#MAIN_WINDOW,#False)
  
  SetGadgetState(#MAIN_LIST,old_pos)
  SetActiveGadget(#MAIN_LIST)
  
EndProcedure

Procedure Image_Popup(type.i)
  
  Protected popup_imagegadget, pevent, popup_image, ww.i, wh.i, Smooth, old_gadget_list
  
  If GetGadgetState(#MAIN_LIST)>-1
    
    If PNG_Filter : Smooth=#PB_Image_Smooth : Else : Smooth=#PB_Image_Raw : EndIf
    
    SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
    SelectElement(UM_Database(),List_Numbers())
    
    DisableWindow(#MAIN_WINDOW,#True)
    
    If type=1
      path=Game_Img_Path+"Titles\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
      ww=640 : wh=512
    EndIf
    
    If type=2
      path=Game_Img_Path+"Screenshots\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
      ww=640 : wh=512
    EndIf
    
    If type=3
      path=Game_Img_Path+"Covers\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
      ww=640 : wh=824
    EndIf
    
    
    If LoadImage(#IFF_POPUP,path)
      ResizeImage(#IFF_POPUP,DpiX(ww), DpiY(wh),Smooth)
      StartDrawing(ImageOutput(#IFF_POPUP))
      DrawingMode(#PB_2DDrawing_Outlined)
      Box(0,0,DpiX(ww),DpiY(wh),#Black)
      StopDrawing()
      
      If OpenWindow(#POPUP_WINDOW,0,0,ww,wh,"",#PB_Window_BorderLess|#PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
        
        old_gadget_list=UseGadgetList(WindowID(#POPUP_WINDOW))
        
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
        
        UseGadgetList(old_gadget_list)
        
        CloseWindow(#POPUP_WINDOW)
        
      EndIf 
      
      FreeImage(#IFF_POPUP)
      DisableWindow(#MAIN_WINDOW,#False)
      
      SetActiveGadget(#MAIN_LIST)
      
    EndIf
  EndIf
  
EndProcedure

Procedure Settings_Window()
  
  Protected Path_Game_String, Path_Demo_String, Path_Beta_String, Path_LHA_String, Path_LZX_String, Path_Temp_String, Path_UAE_String, Path_Game_Button, Path_Demo_Button
  Protected Path_Beta_Button, Path_LHA_Button, Path_LZX_Button, Path_Temp_Button, Path_UAE_Button, Path_WinUAE_String, Path_WinUAE_Button
  Protected Path_Genres_Button, Path_Genres_String, Path_Database_Button, Path_Database_String, Path_CD32_Button, Path_CD32_String, Path_NConvert_String, Path_NConvert_Button
  Protected Path_Amiga_String, Path_Amiga_Button, Path_IGame_String, Path_IGame_Button, Path_Game_LHA_String, Path_Demo_LHA_String, Path_Beta_LHA_String, Path_Game_LHA_Button, Path_Demo_LHA_Button, Path_Beta_LHA_Button
  Protected old_pos, old_gadget_list, Path_Update_String, Path_Update_Button, Path_IZARC_String, Path_IZARC_Button, Path_Info_String, Path_Info_Button
  Protected change.b=#False
  Protected g_file.i
  
  Protected Option_Smooth_Checkbox, Option_Close_Checkbox
  
  old_pos=GetGadgetState(#MAIN_LIST)
  
  If OpenWindow(#SETTINGS_WINDOW, 0, 0, 490, 400, "Settings", #PB_Window_SystemMenu|#PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
    
    Pause_Window(#SETTINGS_WINDOW)
    
    old_gadget_list=UseGadgetList(WindowID(#SETTINGS_WINDOW))
    
    ContainerGadget(#OPTIONS_CONTAINER,0,0,490,60)
    FrameGadget(#PB_Any,5,5,GadgetWidth(#OPTIONS_CONTAINER)-10,GadgetHeight(#OPTIONS_CONTAINER)-10,"Options")
    Option_Smooth_Checkbox=CheckBoxGadget(#PB_Any,20,25,200,20,"Filter Game Images")
    Option_Close_Checkbox=CheckBoxGadget(#PB_Any,240,25,200,20,"Close WinUAE On Exit")
    CloseGadgetList()
    
    SetGadgetState(Option_Close_Checkbox,Close_UAE)
    SetGadgetState(Option_Smooth_Checkbox,PNG_Filter)
    
    ContainerGadget(#PATH_CONTAINER,0,60,490,340)
    FrameGadget(#PB_Any,5,5,GadgetWidth(#PATH_CONTAINER)-10,GadgetHeight(#PATH_CONTAINER)-10,"Paths")
    Path_Game_String = StringGadget(#PB_Any, 130, 30, 300, 20, Game_Img_Path, #PB_String_ReadOnly)
    Path_Game_Button = ButtonGadget(#PB_Any, 440, 30, 40, 20, "Set")
    Path_LHA_String = StringGadget(#PB_Any, 130, 60, 300, 20, LHA_Path, #PB_String_ReadOnly)
    Path_LHA_Button = ButtonGadget(#PB_Any, 440, 60, 40, 20, "Set")
    Path_LZX_String = StringGadget(#PB_Any, 130, 90, 300, 20, LZX_Path, #PB_String_ReadOnly)
    Path_LZX_Button = ButtonGadget(#PB_Any, 440, 90, 40, 20, "Set")
    Path_Temp_String = StringGadget(#PB_Any, 130, 120, 300, 20, WHD_TempDir, #PB_String_ReadOnly)
    Path_Temp_Button = ButtonGadget(#PB_Any, 440, 120, 40, 20, "Set")
    Path_UAE_String = StringGadget(#PB_Any, 130, 150, 300, 20, ConfUM_Path, #PB_String_ReadOnly)
    Path_UAE_Button = ButtonGadget(#PB_Any, 440, 150, 40, 20, "Set")
    Path_WinUAE_String = StringGadget(#PB_Any, 130, 180, 300, 20, WinUAE_Path, #PB_String_ReadOnly)
    Path_WinUAE_Button = ButtonGadget(#PB_Any, 440, 180, 40, 20, "Set")
    Path_Game_LHA_String = StringGadget(#PB_Any, 130, 210, 300, 20, WHD_Folder, #PB_String_ReadOnly)
    Path_Game_LHA_Button = ButtonGadget(#PB_Any, 440, 210, 40, 20, "Set")
    Path_Genres_String = StringGadget(#PB_Any, 130, 240, 300, 20, Data_Path, #PB_String_ReadOnly)
    Path_Genres_Button = ButtonGadget(#PB_Any, 440, 240, 40, 20, "Set")
    Path_IZARC_String = StringGadget(#PB_Any, 130, 270, 300, 20, IZARC_Path, #PB_String_ReadOnly)
    Path_IZARC_Button = ButtonGadget(#PB_Any, 440, 270, 40, 20, "Set")
    Path_Info_String = StringGadget(#PB_Any, 130, 300, 300, 20, Game_Data_Path, #PB_String_ReadOnly)
    Path_Info_Button = ButtonGadget(#PB_Any, 440, 300, 40, 20, "Set")
    
    TextGadget(#PB_Any, 10,  32, 110, 20, "Game Image Folder", #PB_Text_Right)
    TextGadget(#PB_Any, 10,  62, 110, 30, "LHA Archiver", #PB_Text_Right)
    TextGadget(#PB_Any, 10,  92, 110, 20, "LZX Archiver", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 122, 110, 20, "Temp Folder", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 152, 110, 20, "Config Path", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 182, 110, 20, "WinUAE Path", #PB_Text_Right) 
    TextGadget(#PB_Any, 10, 212, 110, 20, "WHD Archive Path", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 242, 110, 20, "Data Path", #PB_Text_Right)  
    TextGadget(#PB_Any, 10, 272, 110, 20, "IZARCC Path", #PB_Text_Right) 
    TextGadget(#PB_Any, 10, 302, 110, 20, "Game Info Path", #PB_Text_Right) 
    
    CloseGadgetList()
    
    Resume_Window(#SETTINGS_WINDOW)
    
    Repeat
      
      event=WaitWindowEvent()
      
      Select event
          
        Case #PB_Event_Gadget
          Select EventGadget()
            Case Option_Close_Checkbox : Close_UAE=GetGadgetState(Option_Close_Checkbox) : change=#True
            Case Option_Smooth_Checkbox : PNG_Filter=GetGadgetState(Option_Smooth_Checkbox) : Draw_Info(List_Numbers()) : change=#True
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
              path=PathRequester("Config Path",ConfUM_Path)
              If path<>"" : ConfUM_Path=path : SetGadgetText(Path_UAE_String,ConfUM_Path) : change=#True : EndIf
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
            Case Path_IZARC_Button
              path=PathRequester("IZARCC Path",IZARC_Path)
              If path<>"" : IZARC_Path=path : SetGadgetText(Path_IZARC_String,IZARC_Path) : change=#True : EndIf
            Case Path_Info_Button
              path=PathRequester("Game Info Path",Game_Data_Path)
              If path<>"" : Game_Data_Path=path : SetGadgetText(Path_Info_String,Game_Data_Path) : change=#True : EndIf
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
    
    CloseWindow(#SETTINGS_WINDOW)
    
  EndIf
  
EndProcedure

Procedure FrameGadgetCustom(gad,x,y,w,h,ftext$)
  
  Protected tmp,tmpw,tmph,gadnum
  
  tmp=TextGadget(#PB_Any,0,0,0,0,ftext$)
  tmpw=GadgetWidth(tmp,#PB_Gadget_RequiredSize)
  tmph=GadgetHeight(tmp,#PB_Gadget_RequiredSize)
  FreeGadget(tmp)
  FrameGadget(gad,x,y,w,h,"")
  gadnum=TextGadget(#PB_Any,x+10,y,tmpw+10,tmph,ftext$,#PB_Text_Center)
  SetGadgetColor(gadnum,#PB_Gadget_BackColor,#White)
  
  ProcedureReturn gadnum
  
EndProcedure

Procedure.l TextGadgetCol(tx,ty,tw,th,ttext.s,tcol)
  
  Protected text
  
  text=TextGadget(#PB_Any, tx, ty, tw, th, ttext) 
  SetGadgetColor(text,#PB_Gadget_BackColor,tcol)
  
  ProcedureReturn text
  
EndProcedure

Procedure Filter_Window()
  
  Protected g_file.i, old_pos.i, text.i
  
  old_pos=GetGadgetState(#MAIN_LIST)
  
  If OpenWindow(#FILTER_WINDOW, 0, 0, 325, 650, "Filter", #PB_Window_Invisible|#PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
    Pause_Window(#FILTER_WINDOW)
    
    ContainerGadget(#FILTER_PANEL,0,0,325,WindowHeight(#FILTER_WINDOW),#PB_Container_BorderLess)
    SetGadgetColor(#FILTER_PANEL,#PB_Gadget_BackColor,#White)
    FrameGadgetCustom(#PB_Any,4,4,315,115,"Game List")
    
    TextGadgetCol(12, 28, 50, 20, "List Type",#White) 
    Category_Gadget = ComboBoxGadget(#PB_Any, 106, 24 , 206, 22)
    TextGadgetCol(12, 58, 50, 20, "Favourite",#White)  
    Favourite_Gadget = ComboBoxGadget(#PB_Any, 106, 54, 206, 22)
    TextGadgetCol(12, 90, 186, 20, "Game Genre",#White)  
    Genre_Gadget = ComboBoxGadget(#PB_Any, 106, 86, 206, 22)
    
    FrameGadgetCustom(#PB_Any,4,130,316,114,"Hardware")
    
    Hardware_Gadget=ComboBoxGadget(#PB_Any,106,150,206,22)
    TextGadgetCol(12,154,86,24,"System",#White)
    AddGadgetItem(Hardware_Gadget,-1,"All")
    AddGadgetItem(Hardware_Gadget,-1,"Amiga")
    AddGadgetItem(Hardware_Gadget,-1,"CD32")
    AddGadgetItem(Hardware_Gadget,-1,"CDTV")
    AddGadgetItem(Hardware_Gadget,-1,"AmigaCD")
    AddGadgetItem(Hardware_Gadget,-1,"Arcadia")
    SetGadgetState(Hardware_Gadget,Fl_HWare_Num)
    
    Chipset_Gadget=ComboBoxGadget(#PB_Any,106,180,206,22)
    TextGadgetCol(12,184,86,24,"Graphics",#White)
    AddGadgetItem(Chipset_Gadget,-1,"All")
    AddGadgetItem(Chipset_Gadget,-1,"OCS/ECS")
    AddGadgetItem(Chipset_Gadget,-1,"AGA")
    AddGadgetItem(Chipset_Gadget,-1,"PAL")
    AddGadgetItem(Chipset_Gadget,-1,"NTSC")
    SetGadgetState(Chipset_Gadget,Fl_Chipset_Num)
    
    Sound_Gadget=ComboBoxGadget(#PB_Any,106,210,206,22)
    TextGadgetCol(12,214,86,24,"Sound",#White)
    AddGadgetItem(Sound_Gadget,-1,"All")
    AddGadgetItem(Sound_Gadget,-1,"No Sound")
    AddGadgetItem(Sound_Gadget,-1,"MT32")  
    SetGadgetState(Sound_Gadget,Fl_Sound_Num)
    
    FrameGadgetCustom(#PB_Any,4,250,316,264,"Game Info")
    
    TextGadgetCol(12,274,86,24,"Publisher",#White)
    Publisher_Gadget=ComboBoxGadget(#PB_Any,106,270,206,22)
    TextGadgetCol(12,304,86,24,"Developer",#White)
    Developer_Gadget=ComboBoxGadget(#PB_Any,106,300,206,22)
    TextGadgetCol(12,334,86,24,"Demo Coder",#White)
    Coder_Gadget=ComboBoxGadget(#PB_Any,106,330,206,22)
    TextGadgetCol(12,364,86,24,"Year",#White)
    Year_Gadget=ComboBoxGadget(#PB_Any,106,360,206,22)
    TextGadgetCol(12,394,86,24,"Language",#White)
    Language_Gadget=ComboBoxGadget(#PB_Any,106,390,206,22)
    TextGadgetCol(12,424,86,24,"Memory",#White)
    Memory_Gadget=ComboBoxGadget(#PB_Any,106,420,206,22)
    TextGadgetCol(12,454,94,24,"Number Of Disks",#White)
    Disks_Gadget=ComboBoxGadget(#PB_Any,106,450,206,22)
    TextGadgetCol(12,484,86,24,"Disk Type",#White)
    DiskCategory_Gadget=ComboBoxGadget(#PB_Any,106,480,206,22)
    AddGadgetItem(DiskCategory_Gadget,-1,"All")
    AddGadgetItem(DiskCategory_Gadget,-1,"Game Demo")
    AddGadgetItem(DiskCategory_Gadget,-1,"Preview")
    AddGadgetItem(DiskCategory_Gadget,-1,"Intro Disk")
    AddGadgetItem(DiskCategory_Gadget,-1,"No Intro")
    AddGadgetItem(DiskCategory_Gadget,-1,"Coverdisk")
    SetGadgetState(DiskCategory_Gadget,Fl_DiskType_Num)  
    
    FrameGadgetCustom(#PB_Any,4,520,316,82,"Other")
    
    TextGadgetCol(12,544,186,24,"Data Type",#White)
    DataType_Gadget=ComboBoxGadget(#PB_Any,106,540,206,20)
    AddGadgetItem(DataType_Gadget,-1,"All")
    AddGadgetItem(DataType_Gadget,-1,"Files")
    AddGadgetItem(DataType_Gadget,-1,"Image")
    SetGadgetState(DataType_Gadget,Fl_DataType_Num)
    
    TextGadgetCol(12,574,186,24,"Players",#White)
    Players_Gadget=ComboBoxGadget(#PB_Any,106,570,206,20)
    AddGadgetItem(Players_Gadget,-1,"All")
    AddGadgetItem(Players_Gadget,-1,"No Players")
    AddGadgetItem(Players_Gadget,-1,"1 Player")
    AddGadgetItem(Players_Gadget,-1,"2 Players")
    AddGadgetItem(Players_Gadget,-1,"3 Players")
    AddGadgetItem(Players_Gadget,-1,"4 Players")
    AddGadgetItem(Players_Gadget,-1,"5+ Players")
    SetGadgetState(Players_Gadget,Fl_Players_Num)
    
    Reset_Button=ButtonGadget(#PB_Any,GadgetWidth(#FILTER_PANEL)-220,GadgetHeight(#FILTER_PANEL)-40,100,30,"Reset")
    Exit_Button=ButtonGadget(#PB_Any,GadgetWidth(#FILTER_PANEL)-110,GadgetHeight(#FILTER_PANEL)-40,100,30,"Exit")  
    
    Protected NewMap FPub.s()
    Protected NewMap FDev.s()
    Protected NewMap FCoder.s()
    Protected NewMap FYear.s()
    Protected NewMap FLang.s()
    Protected NewMap FDisks.s()
    Protected NewMap FMem.s()
    Protected NewList Sort.s()
    
    ForEach UM_Database()
      If UM_Database()\UM_Type="Demo"
        FCoder(UM_Database()\UM_Publisher)=UM_Database()\UM_Publisher
        FDev(UM_Database()\UM_Developer)="None"
      Else
        FPub(UM_Database()\UM_Publisher)=UM_Database()\UM_Publisher
        FDev(UM_Database()\UM_Developer)=UM_Database()\UM_Developer
      EndIf
      
      FYear(UM_Database()\UM_Year)=UM_Database()\UM_Year
      FLang(UM_Database()\UM_Language)=UM_Database()\UM_Language
      FDisks(UM_Database()\UM_Disks)=UM_Database()\UM_Disks
      If UM_Database()\UM_Memory<>"" : FMem(UM_Database()\UM_Memory)=UM_Database()\UM_Memory : EndIf
    Next
    
    ForEach FPub()
      AddElement(Sort())
      Sort()=FPub()
    Next
    SortList(Sort(),#PB_Sort_Ascending)
    AddGadgetItem(Publisher_Gadget,-1,"All")
    ForEach Sort()
      AddGadgetItem(Publisher_Gadget,-1,Sort())
    Next
    SetGadgetState(Publisher_Gadget,Fl_Publisher_Num)
    
    ClearList(Sort())
    
    ForEach FDev()
      AddElement(Sort())
      Sort()=FDev()
    Next
    SortList(Sort(),#PB_Sort_Ascending)
    AddGadgetItem(Developer_Gadget,-1,"All")
    ForEach Sort()
      AddGadgetItem(Developer_Gadget,-1,Sort())
    Next
    SetGadgetState(Developer_Gadget,Fl_Developer_Num)
    
    ClearList(Sort())
    
    ForEach FCoder()
      AddElement(Sort())
      Sort()=FCoder()
    Next
    SortList(Sort(),#PB_Sort_Ascending)
    AddGadgetItem(Coder_Gadget,-1,"All")
    ForEach Sort()
      AddGadgetItem(Coder_Gadget,-1,Sort())
    Next
    SetGadgetState(Coder_Gadget,Fl_Coder_Num)
    
    ClearList(Sort())
    
    ForEach FYear()
      AddElement(Sort())
      Sort()=FYear()
    Next
    SortList(Sort(),#PB_Sort_Ascending)
    AddGadgetItem(Year_Gadget,-1,"All")
    ForEach Sort()
      AddGadgetItem(Year_Gadget,-1,Sort())
    Next
    SetGadgetState(Year_Gadget,Fl_Year_Num)
    
    ClearList(Sort())
    
    ForEach FLang()
      AddElement(Sort())
      Sort()=FLang()
    Next
    SortList(Sort(),#PB_Sort_Ascending)
    AddGadgetItem(Language_Gadget,-1,"All")
    ForEach Sort()
      AddGadgetItem(Language_Gadget,-1,Sort())
    Next
    SetGadgetState(Language_Gadget,Fl_Language_Num)
    
    ClearList(Sort())
    
    ForEach FMem()
      AddElement(Sort())
      Sort()=FMem()
    Next
    SortList(Sort(),#PB_Sort_Ascending)
    AddGadgetItem(Memory_Gadget,-1,"All")
    ForEach Sort()
      AddGadgetItem(Memory_Gadget,-1,Sort())
    Next
    SetGadgetState(Memory_Gadget,Fl_Memory_Num)
    
    AddGadgetItem(Disks_Gadget,-1,"All")
    AddGadgetItem(Disks_Gadget,-1,"One Disk")
    AddGadgetItem(Disks_Gadget,-1,"Two Disk")
    AddGadgetItem(Disks_Gadget,-1,"Three Disk")
    AddGadgetItem(Disks_Gadget,-1,"Four Disk")
    SetGadgetState(Disks_Gadget,Fl_Disks_Num)
    
    AddGadgetItem(Category_Gadget,-1,"All")
    AddGadgetItem(Category_Gadget,-1,"Games")
    AddGadgetItem(Category_Gadget,-1,"Games/Beta")
    AddGadgetItem(Category_Gadget,-1,"Demos")
    AddGadgetItem(Category_Gadget,-1,"Beta")
    SetGadgetState(Category_Gadget,Fl_Category_Num)
    
    AddGadgetItem(Favourite_Gadget,-1,"All")
    AddGadgetItem(Favourite_Gadget,-1,"Show")
    AddGadgetItem(Favourite_Gadget,-1,"Hide")
    SetGadgetState(Favourite_Gadget,Fl_Fave_Num)
    
    AddGadgetItem(Genre_Gadget,-1,"All")
    
    If ReadFile(g_file,Data_Path+"um_genres.dat")
      ClearList(Genre_List())
      ClearMap(Genre_Map())
      While Not Eof(g_file)
        AddElement(Genre_List())
        Genre_List()=ReadString(g_file)
        Genre_Map(Genre_List())=Genre_List()
      Wend
      CloseFile(g_file)
      SortList(Genre_List(),#PB_Sort_Ascending|#PB_Sort_NoCase)
      ForEach Genre_List()
        AddGadgetItem(Genre_Gadget,-1,Genre_List())
      Next
      SetGadgetState(Genre_Gadget,Fl_Genre_Num)    
    EndIf
    
    FreeMap(FPub.s())
    FreeMap(FCoder.s())
    FreeMap(FYear.s())
    FreeMap(FLang.s())
    FreeMap(FDisks.s())
    FreeMap(FMem.s())
    FreeList(Sort.s())
    
    CloseGadgetList()
    
    HideWindow(#FILTER_WINDOW,#False)
  EndIf
  
EndProcedure

Procedure Update_Game_Settings_DB()
    
  Protected NewMap Settings_Map.i()
  Protected NewList Temp_Game_List.Game_Data()
  
  CopyList(Game_Settings_DB(),Temp_Game_List())
  
  ForEach Temp_Game_List()
    Settings_Map(Temp_Game_List()\GS_Name)=ListIndex(Temp_Game_List())
  Next
  
  ClearList(Game_Settings_DB())
  
  ForEach UM_Database()   
    If FindMapElement(Settings_Map(),UM_Database()\UM_Title+Title_Extras())
      SelectElement(Temp_Game_List(),Settings_Map())
      AddElement(Game_Settings_DB())
      Game_Settings_DB()\GS_Title=Temp_Game_List()\GS_Title
      Game_Settings_DB()\GS_Name=Temp_Game_List()\GS_Name
      Game_Settings_DB()\GS_Default_Icon=Temp_Game_List()\GS_Default_Icon
      Game_Settings_DB()\GS_Config=Temp_Game_List()\GS_Config
      Game_Settings_DB()\GS_Bezel=Temp_Game_List()\GS_Bezel
      Game_Settings_DB()\GS_Favourite=Temp_Game_List()\GS_Favourite
      Game_Settings_DB()\GS_Times_Played=Temp_Game_List()\GS_Times_Played
      Game_Settings_DB()\GS_Last_Played=Temp_Game_List()\GS_Last_Played
      Game_Settings_DB()\GS_Screen_Type=Temp_Game_List()\GS_Screen_Type
    Else
      AddElement(Game_Settings_DB())
      Game_Settings_DB()\GS_Title=UM_Database()\UM_Title
      Game_Settings_DB()\GS_Name=UM_Database()\UM_Title+Title_Extras()
      Game_Settings_DB()\GS_Default_Icon=UM_Database()\UM_Default_Icon
      Game_Settings_DB()\GS_Config=UM_Database()\UM_Config
      Game_Settings_DB()\GS_Bezel=0
      Game_Settings_DB()\GS_Favourite=#False
      Game_Settings_DB()\GS_Times_Played=0
      Game_Settings_DB()\GS_Last_Played="Never"
      Game_Settings_DB()\GS_Screen_Type=0
    EndIf    
  Next
  
  FreeList(Temp_Game_List())
  FreeMap(Settings_Map())
  
EndProcedure

Procedure Load_Main_DB()
  
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
      AddElement(UM_Database())
      UM_Database()\UM_Folder=Fix_List()\F_Folder
      UM_Database()\UM_Subfolder=Fix_List()\F_SubFolder
      UM_Database()\UM_LHAFile=Fix_List()\F_LHAFile
      UM_Database()\UM_NTSC=Fix_List()\F_NTSC
      UM_Database()\UM_Language=Fix_List()\F_Language
      UM_Database()\UM_NoIntro=Fix_List()\F_NoIntro
      UM_Database()\UM_Arcadia=Fix_List()\F_Arcadia
      UM_Database()\UM_CD32=Fix_List()\F_CD32
      UM_Database()\UM_CDTV=Fix_List()\F_CDTV
      UM_Database()\UM_Slave=Fix_List()\F_Slave
      UM_Database()\UM_Slave_Date=Fix_List()\F_Slave_Date
      UM_Database()\UM_MT32=Fix_List()\F_MT32
      UM_Database()\UM_NoSound=Fix_List()\F_NoSound
      UM_Database()\UM_AGA=Fix_List()\F_AGA
      UM_Database()\UM_ECSOCS=Fix_List()\F_ECSOCS
      UM_Database()\UM_Publisher=Fix_List()\F_Publisher
      UM_Database()\UM_Developer=Fix_List()\F_Developer
      UM_Database()\UM_Party=Fix_List()\F_Party
      UM_Database()\UM_Favourite=Fix_List()\F_Favourite
      UM_Database()\UM_Genre=Fix_List()\F_Genre
      UM_Database()\UM_Preview=Fix_List()\F_Preview
      UM_Database()\UM_Type=Fix_List()\F_Type
      UM_Database()\UM_Intro=Fix_List()\F_Intro
      UM_Database()\UM_CDROM=Fix_List()\F_CDROM
      UM_Database()\UM_Memory=Fix_List()\F_Memory
      UM_Database()\UM_Coverdisk=Fix_List()\F_Coverdisk
      UM_Database()\UM_PD=Fix_List()\F_PD
      UM_Database()\UM_Demo=Fix_List()\F_Demo
      UM_Database()\UM_Disks=Fix_List()\F_Disks
      UM_Database()\UM_Files=Fix_List()\F_Files
      UM_Database()\UM_Image=Fix_List()\F_Image
      UM_Database()\UM_Title=Fix_List()\F_Title
      UM_Database()\UM_Short=Fix_List()\F_Short
      UM_Database()\UM_Year=Fix_List()\F_Year
      UM_Database()\UM_Players=Fix_List()\F_Players
      UM_Database()\UM_Config=Fix_List()\F_Config
      UM_Database()\UM_Default_Icon=Fix_List()\F_Default_Icon
      UM_Database()\UM_HOL_Entry=Fix_List()\F_HOL
      UM_Database()\UM_Lemon_Entry=Fix_List()\F_Lemon
      UM_Database()\UM_WHD_Entry=Fix_List()\F_WHD
      UM_Database()\UM_Janeway=Fix_List()\F_Janeway
      UM_Database()\UM_Pouet=Fix_List()\F_Pouet
      UM_Database()\UM_Beta=Fix_List()\F_Beta
      UM_Database()\UM_InstallSize=Fix_List()\F_InstallSize
      UM_Database()\UM_Version=Fix_List()\F_Version
    Next
  EndIf
  
  ClearList(Fix_List())
  
EndProcedure

Procedure Save_Main_DB()
  
  ClearList(Fix_List())
  
  ForEach UM_Database()
    AddElement(Fix_List())
    Fix_List()\F_Title=UM_Database()\UM_Title 
    Fix_List()\F_Short=UM_Database()\UM_Short
    Fix_List()\F_Genre=UM_Database()\UM_Genre
    If FindString(UM_Database()\UM_Folder,"/",0,#PB_String_NoCase): UM_Database()\UM_Folder=RTrim(UM_Database()\UM_Folder,"/") : EndIf
    Fix_List()\F_Folder=UM_Database()\UM_Folder
    Fix_List()\F_Favourite=UM_Database()\UM_Favourite
    Fix_List()\F_SubFolder=UM_Database()\UM_Subfolder
    Fix_List()\F_Slave=UM_Database()\UM_Slave
    Fix_List()\F_Slave_Date=UM_Database()\UM_Slave_Date
    Fix_List()\F_LHAFile=UM_Database()\UM_LHAFile
    Fix_List()\F_Language=UM_Database()\UM_Language
    Fix_List()\F_Memory=UM_Database()\UM_Memory
    Fix_List()\F_AGA=UM_Database()\UM_AGA
    Fix_List()\F_ECSOCS=UM_Database()\UM_ECSOCS
    Fix_List()\F_NTSC=UM_Database()\UM_NTSC
    Fix_List()\F_CD32=UM_Database()\UM_CD32
    Fix_List()\F_CDTV=UM_Database()\UM_CDTV
    Fix_List()\F_CDROM=UM_Database()\UM_CDROM
    Fix_List()\F_MT32=UM_Database()\UM_MT32
    Fix_List()\F_NoSound=UM_Database()\UM_NoSound
    Fix_List()\F_Disks=UM_Database()\UM_Disks
    Fix_List()\F_Demo=UM_Database()\UM_Demo
    Fix_List()\F_Intro=UM_Database()\UM_Intro
    Fix_List()\F_NoIntro=UM_Database()\UM_NoIntro
    Fix_List()\F_Coverdisk=UM_Database()\UM_Coverdisk
    Fix_List()\F_PD=UM_Database()\UM_PD
    Fix_List()\F_Preview=UM_Database()\UM_Preview
    Fix_List()\F_Files=UM_Database()\UM_Files
    Fix_List()\F_Image=UM_Database()\UM_Image
    Fix_List()\F_Arcadia=UM_Database()\UM_Arcadia
    Fix_List()\F_Publisher=UM_Database()\UM_Publisher
    Fix_List()\F_Developer=UM_Database()\UM_Developer
    Fix_List()\F_Party=UM_Database()\UM_Party
    Fix_List()\F_Type=UM_Database()\UM_Type
    Fix_List()\F_Year=UM_Database()\UM_Year
    Fix_List()\F_Players=UM_Database()\UM_Players
    Fix_List()\F_Config=UM_Database()\UM_Config
    Fix_List()\F_HOL=UM_Database()\UM_HOL_Entry
    Fix_List()\F_Lemon=UM_Database()\UM_Lemon_Entry
    Fix_List()\F_WHD=UM_Database()\UM_WHD_Entry
    Fix_List()\F_Janeway=UM_Database()\UM_Janeway
    Fix_List()\F_Pouet=UM_Database()\UM_Pouet
    Fix_List()\F_Beta=UM_Database()\UM_Beta
    Fix_List()\F_Default_Icon=UM_Database()\UM_Default_Icon
    Fix_List()\F_InstallSize=UM_Database()\UM_InstallSize
    Fix_List()\F_Version=UM_Database()\UM_Version
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

Procedure Load_Game_DB()
  
  Protected lFileSize, lFile, lUncompressedSize, lJSON, *lJSONBufferCompressed, *lJSONBuffer
  
  path=Data_Path+"um_gamedata"
  
  ClearList(Fix_List())
  
  lFileSize = FileSize(path+".dat")
  If lFileSize>0
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
      ExtractJSONList(JSONValue(lJSON), Game_Settings_DB()) 
    EndIf
  Else
    ForEach UM_Database()   
      AddElement(Game_Settings_DB())
      Game_Settings_DB()\GS_Title=UM_Database()\UM_Title
      Game_Settings_DB()\GS_Name=UM_Database()\UM_Title+Title_Extras()
      Game_Settings_DB()\GS_Default_Icon=UM_Database()\UM_Default_Icon
      Game_Settings_DB()\GS_Config=UM_Database()\UM_Config
      Game_Settings_DB()\GS_Bezel=0
      Game_Settings_DB()\GS_Favourite=#False
      Game_Settings_DB()\GS_Times_Played=0
      Game_Settings_DB()\GS_Last_Played="Never"
      Game_Settings_DB()\GS_Screen_Type=0   
    Next
    Save_Game_DB()
    ;   Else
    ;MessageRequester("Error", "Select JSON Backup!", #PB_MessageRequester_Error|#PB_MessageRequester_Ok)   
    ;   path+".json"
    ;   If path<>""
    ;     lfile=LoadJSON(#PB_Any, path, #PB_JSON_NoCase)
    ;     ExtractJSONList(JSONValue(lfile), Fix_List())
    ;   EndIf
  EndIf  
  
EndProcedure

Procedure Load_DB()
  
  Load_Main_DB()
  Load_Game_DB()
  
EndProcedure

Procedure Save_Prefs()
  CreatePreferences(Data_Path+"um.prefs")
  PreferenceGroup("Paths")
  WritePreferenceString("Game_Img_Path",Game_Img_Path)
  WritePreferenceString("Game_Data_Path",Game_Data_Path)
  WritePreferenceString("LHA_Path",LHA_Path)
  WritePreferenceString("IZARC_Path",IZARC_Path)
  WritePreferenceString("LZX_Path",LZX_Path)
  WritePreferenceString("NConvert_Path",NConvert_Path)
  WritePreferenceString("Temp_Path",WHD_TempDir)
  WritePreferenceString("UAECFG_Path",ConfUM_Path)
  WritePreferenceString("WHD_Path",WHD_Folder)
  WritePreferenceString("WinUAE_Path",WinUAE_Path)
  WritePreferenceString("Data_Path",Data_Path)
  WritePreferenceLong("PNG_Filter",PNG_Filter)
  WritePreferenceLong("JSON_Backup",JSON_Backup)
  ClosePreferences()
EndProcedure

Procedure Load_Prefs()
  
  If OpenPreferences(Data_Path+"um.prefs")
    PreferenceGroup("Paths")
    Game_Img_Path=ReadPreferenceString("Game_Img_Path",Game_Img_Path)
    Game_Data_Path=ReadPreferenceString("Game_Data_Path",Game_Data_Path)
    LHA_Path=ReadPreferenceString("LHA_Path",LHA_Path)
    IZARC_Path=ReadPreferenceString("IZARC_Path",IZARC_Path)
    LZX_Path=ReadPreferenceString("LZX_Path",LZX_Path)
    NConvert_Path=ReadPreferenceString("NConvert_Path",NConvert_Path)
    WHD_TempDir=ReadPreferenceString("Temp_Path",WHD_TempDir)
    ConfUM_Path=ReadPreferenceString("UAECFG_Path",ConfUM_Path)
    WHD_Folder=ReadPreferenceString("WHD_Path",WHD_Folder)
    WinUAE_Path=ReadPreferenceString("WinUAE_Path",WinUAE_Path)
    Data_Path=ReadPreferenceString("Data_Path",Data_Path)
    PNG_Filter=ReadPreferenceLong("PNG_Filter",PNG_Filter)
    JSON_Backup=ReadPreferenceLong("JSON_Backup",JSON_Backup)
    ClosePreferences()
  EndIf
  
EndProcedure

Procedure Choose_Icon()
  
  Protected NewList Icon_List.s()
  
  Protected UM_Program.i
  Protected ReadO$, oldpath.s
  
  path=WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"
  
  OpenConsole("Scanning : "+UM_Database()\UM_LHAFile)
  UM_Program=RunProgram(LHA_Path,"l "+path+UM_Database()\UM_LHAFile,GetCurrentDirectory(),#PB_Program_Open|#PB_Program_Read)
  If UM_Program     
    While ProgramRunning(UM_Program)          
      If AvailableProgramOutput(UM_Program)            
        ReadO$=ReadProgramString(UM_Program)           
        ReadO$=RemoveString(ReadO$,#DOUBLEQUOTE$)           
        ReadO$=ReplaceString(ReadO$,"\", "/")                      
        If FindString(ReadO$,".info",0,#PB_String_NoCase)
          If CountString(ReadO$,"/")<>1 : Continue : EndIf
          If GetExtensionPart(UM_Database()\UM_LHAFile)="lha" : i=54 : EndIf
          If GetExtensionPart(UM_Database()\UM_LHAFile)="lzx" : i=49 : EndIf
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
  
  ClearList(UM_Database()\UM_Icons())
  
  CopyList(Icon_List(),UM_Database()\UM_Icons())
  
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
      oldpath=UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(Game_Settings_DB()\GS_Default_Icon,#PB_FileSystem_NoExtension)+".png"
      SelectElement(Icon_List(),i-1)
      Game_Settings_DB()\GS_Default_Icon=Icon_List()
      path=UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(Game_Settings_DB()\GS_Default_Icon,#PB_FileSystem_NoExtension)+".png"
      RenameFile(Game_Img_Path+"Screenshots\"+oldpath,Game_Img_Path+"Screenshots\"+path)
      RenameFile(Game_Img_Path+"Titles\"+oldpath,Game_Img_Path+"Titles\"+path)
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

Procedure Edit_GL(number) 
  
  SelectElement(UM_Database(),number)
  
  ClearList(Genre_List.s())
    
  Protected change.b=#False, oldindex.s, star.s, g_file.i, text$
  Protected old_gadget_list, old_pos, icon_string, icon_button, ConfUM_Combo
  
  old_pos=GetGadgetState(#MAIN_LIST)
  
  DisableWindow(#MAIN_WINDOW,#True)
  
  If OpenWindow(#EDIT_WINDOW, 0, 0, 424, 140, "Game Settings ("+UM_Database()\UM_Title+")", #PB_Window_SystemMenu | #PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
    
    Pause_Window(#EDIT_WINDOW)
    
    old_gadget_list=UseGadgetList(WindowID(#EDIT_WINDOW))

    TextGadget(#PB_Any, 0, 12, 80, 20, "Default Icon", #PB_Text_Center)
    icon_string = StringGadget(#PB_Any, 80, 10, 250, 24, Game_Settings_DB()\GS_Default_Icon)
    icon_button = ButtonGadget(#PB_Any, 340, 10, 76, 24, "Choose") 
    
    TextGadget(#PB_Any, 0, 42, 80, 20, "Game Config", #PB_Text_Center)  
    ConfUM_Combo = ComboBoxGadget(#PB_Any, 80, 40, 335, 24)
    
    AddGadgetItem(ConfUM_Combo,-1,"A1200")
    AddGadgetItem(ConfUM_Combo,-1,"A1200-030")
    AddGadgetItem(ConfUM_Combo,-1,"A1200-040")
    AddGadgetItem(ConfUM_Combo,-1,"A1200-CD32")
    SetGadgetState(ConfUM_Combo,Game_Settings_DB()\GS_Config)
    
    Resume_Window(#EDIT_WINDOW)
    
    SetActiveGadget(ConfUM_Combo)
    
    oldindex=UM_Database()\UM_Title
    
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
            Case ConfUM_Combo
              Game_Settings_DB()\GS_Config=GetGadgetState(ConfUM_Combo)
              change=#True
            Case icon_string
              If EventType()=#PB_EventType_Change
                Game_Settings_DB()\GS_Default_Icon=GetGadgetText(icon_string)
                change=#True
              EndIf
            Case icon_button
              Choose_Icon()
              SetGadgetText(icon_string,Game_Settings_DB()\GS_Default_Icon)
              change=#True
              
          EndSelect
          
        Case #PB_Event_CloseWindow  
          Break
          
      EndSelect
      
    ForEver
    
    UseGadgetList(old_gadget_list) 
    
    CloseWindow(#EDIT_WINDOW)  
    
    DisableWindow(#MAIN_WINDOW,#False)
    
    If change
      Save_Game_DB()
    EndIf
    
    SetActiveGadget(#MAIN_LIST)
    
    SetGadgetState(#MAIN_LIST,old_pos)
    
  EndIf
  
EndProcedure

Procedure Create_Menus()
  

  
EndProcedure

Procedure Draw_Main_Window()
  
  Protected offset.i, tw.i, th.i
  Protected  null.w
  
  LoadFont(#HEADER_FONT,"Arial Black",13)
  LoadFont(#BUTTON_FONT,"Arial Black",9)
  LoadFont(#INFO_FONT,"Consolas",9)
  
  ResizeImage(#MAIN_LOGO,DpiX(24),DpiY(24))
  
  CreateImage(#CLOSE_BUTTON_IMAGE,60,60,32,$E9EBF0)
  StartDrawing(ImageOutput(#CLOSE_BUTTON_IMAGE))
  DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)
  BackColor(RGBA(255,64,64,255))
  FrontColor(RGBA(200,0,0,255))
  CircularGradient(25,20,40)
  Circle(28,28,28)
  StopDrawing()
  ResizeImage(#CLOSE_BUTTON_IMAGE,DpiX(20),DpiY(20),#PB_Image_Smooth)
  
  CreateImage(#MINIMIZE_BUTTON_IMAGE,60,60,32,$E9EBF0)
  StartDrawing(ImageOutput(#MINIMIZE_BUTTON_IMAGE))
  DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)
  FrontColor(RGBA(64,128,64,255))
  BackColor(RGBA(0,196,0,255))
  CircularGradient(25,20,40)
  Circle(28,28,28)
  StopDrawing()
  ResizeImage(#MINIMIZE_BUTTON_IMAGE,DpiX(20),DpiY(20),#PB_Image_Smooth)
  
  CreateImage(#FILTER_IMAGE,120,60,32,RGB(240, 235, 233))
  StartDrawing(ImageOutput(#FILTER_IMAGE))
  DrawingMode(#PB_2DDrawing_AlphaBlend)
  RoundBox(4,4,116,56,12,12,RGBA(0,0,0,48))
  RoundBox(0,0,117,57,12,12,RGBA(180, 159, 133,255))
  StopDrawing()
  ResizeImage(#FILTER_IMAGE,DpiX(60),DpiY(30),#PB_Image_Smooth)
  StartDrawing(ImageOutput(#FILTER_IMAGE))
  DrawingFont(FontID(#BUTTON_FONT))
  DrawingMode(#PB_2DDrawing_AlphaBlend)
  DrawText((ImageWidth(#FILTER_IMAGE)/2)-((TextWidth("Filter"))/2),(ImageHeight(#FILTER_IMAGE)/2)-((TextHeight("Filtery"))/2),"Filter",RGBA(0,0,0,128),RGBA(255,255,255,0))
  StopDrawing()
  
  CreateImage(#CLEAR_IMAGE,120,60,32,RGB(240, 235, 233))
  StartDrawing(ImageOutput(#CLEAR_IMAGE))
  DrawingMode(#PB_2DDrawing_AlphaBlend)
  RoundBox(4,4,116,56,12,12,RGBA(0,0,0,48))
  RoundBox(0,0,117,57,12,12,RGBA(255, 255, 255,255))
  StopDrawing()
  ResizeImage(#CLEAR_IMAGE,DpiX(60),DpiY(30),#PB_Image_Smooth)
  StartDrawing(ImageOutput(#CLEAR_IMAGE))
  DrawingFont(FontID(#BUTTON_FONT))
  DrawingMode(#PB_2DDrawing_AlphaBlend)
  DrawText((ImageWidth(#CLEAR_IMAGE)/2)-((TextWidth("Clear"))/2),(ImageHeight(#CLEAR_IMAGE)/2)-((TextHeight("Cleary"))/2),"Clear",RGBA(0,0,0,128),RGBA(255,255,255,0))
  StopDrawing()
  
  OpenWindow(#MAIN_WINDOW, 0, 0, 1158, 800, "" , #PB_Window_BorderLess|#PB_Window_ScreenCentered|#PB_Window_Invisible)
  SetWindowRgn_(WindowID(#MAIN_WINDOW), CreateRoundRectRgn_(0, 0, DpiX(1158), DpiY(790), 12, 12), 0)
  SetClassLongPtr_(WindowID(#MAIN_WINDOW),#GCL_STYLE,$00020000)

  CanvasGadget(#MAIN_CANVAS,0,0,WindowWidth(#MAIN_WINDOW),WindowHeight(#MAIN_WINDOW),#PB_Canvas_Container)
  
  StartDrawing(CanvasOutput(#MAIN_CANVAS))
  
  Box(0,0,DpiX(GadgetWidth(#MAIN_CANVAS)),DpiY(GadgetHeight(#MAIN_CANVAS)),RGB(240, 235, 233))
  
  StopDrawing()

  CanvasGadget(#MAIN_HEADER,15,0,WindowWidth(#MAIN_WINDOW)-80,32)
  
  CreateImage(#MAIN_HEADER_IMAGE,DpiX(GadgetWidth(#MAIN_HEADER)),DpiY(GadgetHeight(#MAIN_HEADER)),32,RGB(240, 235, 233));RGB(240, 235, 233));$E9EBF0
  StartDrawing(ImageOutput(#MAIN_HEADER_IMAGE))
  DrawingMode(#PB_2DDrawing_AlphaBlend)
  DrawingFont(FontID(#HEADER_FONT))
  DrawImage(ImageID(#MAIN_LOGO),0,(ImageHeight(#MAIN_HEADER_IMAGE)-ImageHeight(#MAIN_LOGO))/2) 
  DrawText(ImageWidth(#MAIN_LOGO)+5,(ImageHeight(#MAIN_HEADER_IMAGE)-TextHeight(W_Title))/2,W_Title,RGBA(0,0,0,64),RGBA(0,0,0,0))
  Box(ImageWidth(#MAIN_LOGO)+TextWidth(W_Title)+15,DpiY(4),ImageWidth(#MAIN_HEADER_IMAGE)-(ImageWidth(#MAIN_LOGO)+TextWidth(W_Title)+15),DpiY(4),RGBA(0,0,0,32))
  Box(ImageWidth(#MAIN_LOGO)+TextWidth(W_Title)+15,DpiY(11),ImageWidth(#MAIN_HEADER_IMAGE)-(ImageWidth(#MAIN_LOGO)+TextWidth(W_Title)+15),DpiY(4),RGBA(0,0,0,32))
  Box(ImageWidth(#MAIN_LOGO)+TextWidth(W_Title)+15,DpiY(18),ImageWidth(#MAIN_HEADER_IMAGE)-(ImageWidth(#MAIN_LOGO)+TextWidth(W_Title)+15),DpiY(4),RGBA(0,0,0,32))
  Box(ImageWidth(#MAIN_LOGO)+TextWidth(W_Title)+15,DpiY(25),ImageWidth(#MAIN_HEADER_IMAGE)-(ImageWidth(#MAIN_LOGO)+TextWidth(W_Title)+15),DpiY(4),RGBA(0,0,0,32))
  StopDrawing()
  
  StartDrawing(CanvasOutput(#MAIN_CANVAS)) 
  
  DrawingMode(#PB_2DDrawing_AlphaBlend)
  
  RoundBox(DpiX(12),DpiY(37),DpiX(480),DpiY(WindowHeight(#MAIN_WINDOW)-85),12,12,RGBA(0,0,0,32))
  RoundBox(DpiX(833),DpiY(313),DpiX(317),DpiY(409),12,12,RGBA(0,0,0,32))
  RoundBox(DpiX(77),DpiY(WindowHeight(#MAIN_WINDOW)-43),DpiX(355),DpiY(30),6,6,RGBA(0,0,0,32))
  
  DrawingMode(#PB_2DDrawing_Default)
  
  RoundBox(DpiX(10),DpiY(35),DpiX(480),DpiY(WindowHeight(#MAIN_WINDOW)-85),12,12,#White)
  RoundBox(DpiX(830),DpiY(310),DpiX(317),DpiY(409),12,12,#White)
  RoundBox(DpiX(75),DpiY(WindowHeight(#MAIN_WINDOW)-45),DpiX(355),DpiY(30),6,6,#White)
  
  StopDrawing()
  
  StartDrawing(CanvasOutput(#MAIN_HEADER))
  Box(0,0,DpiX(GadgetWidth(#MAIN_HEADER)),DpiY(GadgetHeight(#MAIN_HEADER)),RGB(0, 255, 255))
  DrawImage(ImageID(#MAIN_HEADER_IMAGE),0,0)
  StopDrawing()
  
  ImageGadget(#CLOSE_BUTTON,WindowWidth(#MAIN_WINDOW)-27,DpiY(6),DpiX(20),DpiY(20),ImageID(#CLOSE_BUTTON_IMAGE))
  GadgetToolTip(#CLOSE_BUTTON,"Close")
  ImageGadget(#MINIMIZE_BUTTON,WindowWidth(#MAIN_WINDOW)-55,DpiY(6),DpiX(20),DpiY(20),ImageID(#MINIMIZE_BUTTON_IMAGE))
  GadgetToolTip(#MINIMIZE_BUTTON,"Minimize")
  
  ListIconGadget(#MAIN_LIST, 16, 45, 464,WindowHeight(#MAIN_WINDOW)-105, "Number", 440, #LVS_NOCOLUMNHEADER | #PB_ListIcon_FullRowSelect)
  SetWindowLongPtr_(GadgetID(#MAIN_LIST),#GWL_EXSTYLE,0)
  
  Title_Image = CanvasGadget(#PB_Any, 500, 44, 320, 256)
  Screen_Image = CanvasGadget(#PB_Any, 830, 44, 320, 256)
  Cover_Image = CanvasGadget(#PB_Any, 500, 310, 320, 412)
  
  Info_Gadget = EditorGadget(#PB_Any, 840, 316, 300, 396,#PB_Editor_ReadOnly|#PB_Editor_WordWrap)
  SetGadgetFont(Info_Gadget,FontID(#INFO_FONT))
  SetWindowTheme_(GadgetID(Info_Gadget), @null, @null)
  SetWindowLongPtr_(GadgetID(Info_Gadget), #GWL_EXSTYLE, GetWindowLongPtr_(GadgetID(Info_Gadget), #GWL_EXSTYLE) & (~#WS_EX_CLIENTEDGE))
  SetWindowPos_(GadgetID(Info_Gadget), 0, 0, 0, 0, 0, #SWP_SHOWWINDOW | #SWP_NOSIZE | #SWP_NOMOVE | #SWP_FRAMECHANGED)
  DestroyCaret_()

  Create_Button(#PLAY_BUTTON_IMAGE,"Play")
  ImageGadget(#PLAY_BUTTON,WindowWidth(#MAIN_WINDOW)-110, WindowHeight(#MAIN_WINDOW)-70,DpiX(100),DpiY(50),ImageID(#PLAY_BUTTON_IMAGE))
  Create_Button(#SETTINGS_IMAGE,"Settings")
  ImageGadget(#SETTINGS_BUTTON,WindowWidth(#MAIN_WINDOW)-220, WindowHeight(#MAIN_WINDOW)-70,DpiX(100),DpiY(50),ImageID(#SETTINGS_IMAGE))
  
  ImageGadget(#FILTER_BUTTON,10,WindowHeight(#MAIN_WINDOW)-45,DpiX(60),DpiY(30),ImageID(#FILTER_IMAGE))
  ImageGadget(#CLEAR_BUTTON,435,WindowHeight(#MAIN_WINDOW)-45,DpiX(60),DpiX(30),ImageID(#CLEAR_IMAGE))
  
  Search_Gadget=StringGadget(#PB_Any,80,WindowHeight(#MAIN_WINDOW)-38,340,21,"",#PB_String_BorderLess)
  Protected combomem = AllocateMemory(40)
  PokeS(combomem, "Search...", -1, #PB_Unicode)
  SendMessage_(GadgetID(Search_Gadget), #EM_SETCUEBANNER, 0, combomem)
  
  CloseGadgetList()
  
  ;Create_Menus()
  
EndProcedure

Procedure Init_Program()
  
  Protected tw.i, th.i
  
  UsePNGImageDecoder()
  UsePNGImageEncoder()
  UseLZMAPacker()
  UseZipPacker()
  InitNetwork()
  InitJoystick()
  
  Load_Prefs() 
  Load_DB()
 
  Update_Game_Settings_DB()
  
  CatchImage(#PDF_IMAGE,?PDF_Image)
  CatchImage(#TEXT_IMAGE,?Text_Image)
  CatchImage(#PLAY_ICON,?Play_Image)
  CatchImage(#IMAGE_ICON,?Image_Image)
  CatchImage(#OPTIONS_ICON,?Options_Image)
  CatchImage(#MAIN_LOGO,?Lightning_Image)
  
  CreateImage(#SCREEN_BLANK,320, 256,32,#Black)
  StartDrawing(ImageOutput(#SCREEN_BLANK))
  Box(0,0,320,256,#White)
  RoundBox(40,40,240,176,20,20,$DDDDDDDD)
  FrontColor(#White)
  BackColor($DDDDDDDD)
  tw=TextWidth("No Image")
  th=TextHeight("No Image")
  DrawText(160-(tw/2),128-(th/2),"No Image")
  StopDrawing()
  
  CreateImage(#COVER_BLANK,320, 412,32,#Black)
  StartDrawing(ImageOutput(#COVER_BLANK))
  Box(0,0,320,412,#White)
  RoundBox(40,40,240,332,20,20,$DDDDDDDD)
  FrontColor(#White)
  BackColor($DDDDDDDD)
  tw=TextWidth("No Image")
  th=TextHeight("No Image")
  DrawText(160-(tw/2),206-(th/2),"No Image")
  StopDrawing()
  
  Draw_Main_Window()
  Draw_List()  
  Draw_Info(0)
  
  HideWindow(#MAIN_WINDOW,#False)
  
  SmartWindowRefresh(#MAIN_WINDOW,#True)
  
EndProcedure

Init_Program()

;- __________ Main Loop

Repeat
  
  Repeat
    
    Event=WaitWindowEvent(10)
    
    Select Event
        
      Case #WM_KEYDOWN
        
        If CountGadgetItems(#MAIN_LIST)>0
          If GetActiveGadget()<>Search_Gadget
            If EventwParam() = #VK_RETURN
              If CountGadgetItems(#MAIN_LIST)>0
                SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
                Run_Game(List_Numbers())
              EndIf 
            EndIf
            If EventwParam() = #VK_SPACE
              If CountGadgetItems(#MAIN_LIST)>0
                SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
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
              Image_Popup(3)
            EndIf
            If EventwParam() = #VK_F8
              PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#Menuitem_2)
            EndIf
          EndIf
        EndIf
        
      Case #PB_Event_Menu
        
        Select EventMenu()
            
          Case 900 To 1100
            If GetExtensionPart(GetMenuItemText(#POPUP_MENU,EventMenu()))="txt"
              RunProgram("notepad.exe",Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetMenuItemText(#POPUP_MENU,EventMenu()),"")
            EndIf
            
            If GetExtensionPart(GetMenuItemText(#POPUP_MENU,EventMenu()))="pdf"
              RunProgram(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetMenuItemText(#POPUP_MENU,EventMenu()),"","")
            EndIf
            
            If GetExtensionPart(GetMenuItemText(#POPUP_MENU,EventMenu()))="jpg"
              RunProgram(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetMenuItemText(#POPUP_MENU,EventMenu()),"","")
            EndIf
            
            If GetExtensionPart(GetMenuItemText(#POPUP_MENU,EventMenu()))="png"
              RunProgram(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetMenuItemText(#POPUP_MENU,EventMenu()),"","")
            EndIf
            
            SetActiveGadget(#MAIN_LIST)
            
          Case #MenuItem_1   ;{- Run Game  
            If CountGadgetItems(#MAIN_LIST)>0
              SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
              Run_Game(List_Numbers())
            EndIf ;} 
          Case #Menuitem_2  ;{- Favourite
            If ListSize(List_Numbers())>0
              SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
              SelectElement(UM_Database(),List_Numbers())
              If UM_Database()\UM_Favourite=#False
                UM_Database()\UM_Favourite=#True
                SetGadgetItemText(#MAIN_LIST,GetGadgetState(#MAIN_LIST),UM_Database()\UM_Title+Title_Extras())
              Else
                UM_Database()\UM_Favourite=#False
                SetGadgetItemText(#MAIN_LIST,GetGadgetState(#MAIN_LIST),UM_Database()\UM_Title+Title_Extras())
              EndIf
            EndIf
            ;}
          Case #Menuitem_3   ;{- Quit
            If MessageRequester("Exit UltraMiggy", "Do you want to quit?",#PB_MessageRequester_YesNo|#PB_MessageRequester_Warning)=#PB_MessageRequester_Yes
              quit=1
            EndIf ;}    
          Case #Menuitem_4   ;{- Filter Window
            If IsWindow(#FILTER_WINDOW)<>#True
              Filter_Window()
            EndIf
            ;}
          Case #Menuitem_5 ;{- Edit Entry
            If CountGadgetItems(#MAIN_LIST)>0
              SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
              Edit_GL(List_Numbers())
            EndIf ;}  
          Case #Menuitem_6 ;{- Short Names
            If Short_Names=#True
              SetMenuItemState(Main_Menu,#Menuitem_6,#False)
              Short_Names=#False
            Else
              SetMenuItemState(Main_Menu,#Menuitem_6,#True)
              Short_Names=#True
            EndIf
            Draw_List()
            If ListSize(List_Numbers())>0
              Draw_Info(List_Numbers())
            Else
              Draw_Info(-1)
            EndIf
            
            ;}  
          Case #Menuitem_7 ;{- Close UAE
            If Close_UAE=#False
              SetMenuItemState(Main_Menu,#Menuitem_7,#True)
              Close_UAE=#True
            Else
              SetMenuItemState(Main_Menu,#Menuitem_7,#False)
              Close_UAE=#False
            EndIf
            ;}
          Case #Menuitem_8 ;{- Smooth Image
            
            If PNG_Filter=#False
              SetMenuItemState(Main_Menu,#Menuitem_8,#True)
              PNG_Filter=#True
            Else
              SetMenuItemState(Main_Menu,#Menuitem_8,#False)
              PNG_Filter=#False
            EndIf
            If ListSize(List_Numbers())>0
              Draw_Info(List_Numbers())
            EndIf
            ;}    
            
        EndSelect
        
      Case #PB_Event_Gadget
        
        Select EventGadget()
            
          Case Exit_Button
            CloseWindow(#FILTER_WINDOW)
            
          Case #PLAY_BUTTON
            If EventType() = #PB_EventType_LeftClick
              PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_1)
            EndIf 
            
          Case #CLEAR_BUTTON
            If EventType() = #PB_EventType_LeftClick
              SetGadgetText(Search_Gadget,"")
              Fl_Search=""
              Draw_List()
              Draw_Info(List_Numbers())
            EndIf 
            
          Case #SETTINGS_BUTTON
            If EventType() = #PB_EventType_LeftClick
              Settings_Window()
            EndIf
            
          Case #FILTER_BUTTON
            If EventType() = #PB_EventType_LeftClick
              PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#Menuitem_4)
            EndIf
            
          Case #CLOSE_BUTTON
            If EventType() = #PB_EventType_LeftClick
              PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#Menuitem_3)
            EndIf
            
          Case #MINIMIZE_BUTTON
            If EventType() = #PB_EventType_LeftClick
              SetWindowState(#MAIN_WINDOW,#PB_Window_Minimize)
            EndIf
            
          Case #MAIN_HEADER
            Select EventType()
              Case #PB_EventType_LeftButtonDown
                DisableGadget(#MAIN_HEADER, 1)
                SendMessage_(WindowID(#MAIN_WINDOW), #WM_NCLBUTTONDOWN, #HTCAPTION, 0)
                DisableGadget(#MAIN_HEADER, 0)
            EndSelect
            
          Case #MAIN_LIST
            If CountGadgetItems(#MAIN_LIST)>0 And GetGadgetState(#MAIN_LIST)>-1
              If EventType()= #PB_EventType_Change
                SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
                SelectElement(UM_Database(),List_Numbers())
                SelectElement(Game_Settings_DB(),List_Numbers())
                Draw_Info(List_Numbers())
              EndIf
              If EventType() = #PB_EventType_LeftDoubleClick
                PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_1)
              EndIf
              If EventType() = #PB_EventType_RightClick
                Draw_Info(List_Numbers())
                If GetActiveGadget()=#MAIN_LIST
                  DisplayPopupMenu(#POPUP_MENU, WindowID(#MAIN_WINDOW))
                EndIf
              EndIf
            EndIf
            
          Case Title_Image
            If ListSize(UM_Database())>0
              If EventType()= #PB_EventType_LeftDoubleClick
                Image_Popup(1)
              EndIf
            EndIf
            
          Case Screen_Image
            If ListSize(UM_Database())>0
              If EventType()= #PB_EventType_LeftDoubleClick
                Image_Popup(2)
              EndIf
            EndIf  
            
          Case Cover_Image
            If ListSize(UM_Database())>0
              If EventType()= #PB_EventType_LeftDoubleClick
                Image_Popup(3)
              EndIf
            EndIf
            
          Case Reset_Button
            Reset_Filter()
            Draw_List()
            Draw_Info(List_Numbers())
            
          Case Chipset_Gadget, Year_Gadget, Language_Gadget, Memory_Gadget, Disks_Gadget, Hardware_Gadget, Sound_Gadget, DiskCategory_Gadget, DataType_Gadget, Category_Gadget, Genre_Gadget, Favourite_Gadget, Players_Gadget
            If EventType()=#PB_EventType_Change 
              
              Select GetGadgetState(Category_Gadget)
                Case 0 : Fl_Category="All"
                Case 1 : Fl_Category="Game"
                Case 2 : Fl_Category="Game/Beta"
                Case 3 : Fl_Category="Demo"
                Case 4 : Fl_Category="Beta"
              EndSelect
              Fl_Category_Num=GetGadgetState(Category_Gadget)
              
              Fl_Fave=GetGadgetText(Favourite_Gadget)
              Fl_Fave_Num=GetGadgetState(Favourite_Gadget)
              Fl_Genre=GetGadgetText(Genre_Gadget)
              Fl_Genre_Num=GetGadgetState(Genre_Gadget)
              Fl_Year=GetGadgetText(Year_Gadget)
              Fl_Year_Num=GetGadgetState(Year_Gadget)
              Fl_Language=GetGadgetText(Language_Gadget)
              Fl_Language_Num=GetGadgetState(Language_Gadget)
              Fl_Memory=GetGadgetText(Memory_Gadget)
              Fl_Memory_Num=GetGadgetState(Memory_Gadget)
              Fl_Disks=GetGadgetText(Disks_Gadget)
              Fl_Disks_Num=GetGadgetState(Disks_Gadget)
              Fl_HWare=GetGadgetText(Hardware_Gadget)
              Fl_HWare_Num=GetGadgetState(Hardware_Gadget)
              Fl_Chipset=GetGadgetText(Chipset_Gadget)
              Fl_Chipset_Num=GetGadgetState(Chipset_Gadget)
              Fl_Sound=GetGadgetText(Sound_Gadget)
              Fl_Sound_Num=GetGadgetState(Sound_Gadget)
              Fl_DiskType=GetGadgetText(DiskCategory_Gadget)
              Fl_DiskType_Num=GetGadgetState(DiskCategory_Gadget)
              Fl_DataType=GetGadgetText(DataType_Gadget)
              Fl_DataType_Num=GetGadgetState(DataType_Gadget)
              Fl_Players=GetGadgetText(Players_Gadget)
              Fl_Players_Num=GetGadgetState(Players_Gadget)
              
              Draw_List() 
              If ListSize(List_Numbers())>0
                SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
                Draw_Info(List_Numbers())
              Else
                Draw_Info(-1)
              EndIf 
            EndIf 
            
          Case Search_Gadget
            If EventType()=#PB_EventType_Change
              Fl_Search=GetGadgetText(Search_Gadget)
              Draw_List() 
              If ListSize(List_Numbers())>0
                SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
                Draw_Info(List_Numbers())
              Else
                Draw_Info(-1)
              EndIf
              SetActiveGadget(Search_Gadget)
            EndIf
            
          Case Publisher_Gadget
            If EventType()=#PB_EventType_Change
              Fl_Publisher=GetGadgetText(Publisher_Gadget)
              Fl_Publisher_Num=GetGadgetState(Publisher_Gadget)
              SetGadgetState(Coder_Gadget,0)
              Fl_Coder_Num=0
              Draw_List() 
              If ListSize(List_Numbers())>0
                SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
                Draw_Info(List_Numbers())
              Else
                Draw_Info(-1)
              EndIf 
            EndIf 
            
          Case Developer_Gadget
            If EventType()=#PB_EventType_Change
              Fl_Developer=GetGadgetText(Developer_Gadget)
              Fl_Developer_Num=GetGadgetState(Developer_Gadget)
              Draw_List() 
              If ListSize(List_Numbers())>0
                SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
                Draw_Info(List_Numbers())
              Else
                Draw_Info(-1)
              EndIf 
            EndIf
            
          Case Coder_Gadget
            If EventType()=#PB_EventType_Change
              Fl_Coder=GetGadgetText(Coder_Gadget)
              Fl_Coder_Num=GetGadgetState(Coder_Gadget)
              SetGadgetState(Publisher_Gadget,0)
              Fl_Publisher_Num=0
              Draw_List() 
              If ListSize(List_Numbers())>0
                SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
                Draw_Info(List_Numbers())
              Else
                Draw_Info(-1)
              EndIf 
            EndIf      
            
        EndSelect
    EndSelect
    
  Until event=0
  
  If ExamineJoystick(0)
    If JoystickAxisY(0)=-1 And GetGadgetState(#MAIN_LIST)>0
      SetGadgetState(#MAIN_LIST,GetGadgetState(#MAIN_LIST)-1)
      PostEvent(#PB_Event_Gadget,#MAIN_WINDOW,#MAIN_LIST,#PB_EventType_Change)
    EndIf
    If JoystickAxisY(0)=1 And GetGadgetState(#MAIN_LIST)<=CountGadgetItems(#MAIN_LIST)
      SetGadgetState(#MAIN_LIST,GetGadgetState(#MAIN_LIST)+1)
      PostEvent(#PB_Event_Gadget,#MAIN_WINDOW,#MAIN_LIST,#PB_EventType_Change)
    EndIf
    If JoystickAxisY(0,2)=1 And GetGadgetState(#MAIN_LIST)>0
      SetGadgetState(#MAIN_LIST,GetGadgetState(#MAIN_LIST)-1)
      PostEvent(#PB_Event_Gadget,#MAIN_WINDOW,#MAIN_LIST,#PB_EventType_Change)
    EndIf
    If JoystickAxisY(0,2)=-1 And GetGadgetState(#MAIN_LIST)<=CountGadgetItems(#MAIN_LIST)
      SetGadgetState(#MAIN_LIST,GetGadgetState(#MAIN_LIST)+1)
      PostEvent(#PB_Event_Gadget,#MAIN_WINDOW,#MAIN_LIST,#PB_EventType_Change)
    EndIf
    If JoystickButton(0,1)
      SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
      SelectElement(UM_Database(),List_Numbers())
      SelectElement(Game_Settings_DB(),List_Numbers())
      PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_1)
    EndIf
    If JoystickButton(0,3)
      count=GetGadgetState(#MAIN_LIST)-35
      If count>-1 : SetGadgetState(#MAIN_LIST,count) : Else : SetGadgetState(#MAIN_LIST,0) : EndIf
      SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
      SelectElement(UM_Database(),List_Numbers())
      SelectElement(Game_Settings_DB(),List_Numbers())      
      
      Center_List(UM_Database()\UM_Type+"_"+UM_Database()\UM_Slave)
      PostEvent(#PB_Event_Gadget,#MAIN_WINDOW,#MAIN_LIST,#PB_EventType_Change)
    EndIf
    If JoystickButton(0,4)
      count=GetGadgetState(#MAIN_LIST)+35
      If count<=CountGadgetItems(#MAIN_LIST) : SetGadgetState(#MAIN_LIST,count) : Else : SetGadgetState(#MAIN_LIST,CountGadgetItems(#MAIN_LIST)) : EndIf
      SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
      SelectElement(UM_Database(),List_Numbers())
      SelectElement(Game_Settings_DB(),List_Numbers())
      
      Center_List(UM_Database()\UM_Type+"_"+UM_Database()\UM_Slave)
      PostEvent(#PB_Event_Gadget,#MAIN_WINDOW,#MAIN_LIST,#PB_EventType_Change)
    EndIf
    Delay(40)
    
  EndIf
  
Until quit=1

Save_Prefs()

End

DataSection
  
  PDF_Image:
  IncludeBinary "images\pdf.png"
  
  Text_Image:
  IncludeBinary "images\text.png"
  
  Options_Image:
  IncludeBinary "images\options.png"
  
  Play_Image:
  IncludeBinary "images\play.png"
  
  Image_Image:
  IncludeBinary "images\image.png"
  
  Lightning_Image:
  IncludeBinary "images\lightning.png"
  
EndDataSection
; IDE Options = PureBasic 6.00 Beta 2 (Windows - x64)
; CursorPosition = 184
; FirstLine = 119
; Folding = AAAAggAA-
; Optimizer
; EnableThread
; EnableXP
; EnableUser
; DPIAware
; UseIcon = Images\joystick.ico
; Executable = I:\UltraMiggy\UltraMiggy.exe
; CurrentDirectory = G:\UltraMiggy\
; Compiler = PureBasic 6.00 Beta 2 (Windows - x64)
; Debugger = Standalone