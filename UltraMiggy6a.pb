; UltraMiggy
;
; Version 0.6
;
; © 2021 Paul Vince (MrV2k)
;
; https://easymame.mameworld.info
;
; [ PB V5.7x / 64Bit / Windows / DPI ]
;
; A launcher and database manager for Commodore Amiga WHDLoad Software
;
;============================================
; VERSION INFO v0.6
;============================================
;
; Restructured database
;   Split Launcher DB functions from DB
;   Renamed to UM_Database (from UM_Database)
;
; Unified code with UMlauncher
;   Kept Game_Settings_DB a UMLauncher exclusive as not needed in main program
;
; Threaded image loading in Draw_Info procedure.
; Threaded info loading procedure and split from Draw_Info.
;
; Switched back to xadunfile for lzx archives to preserve file date.
;
; Added loading window
;
; Fixed image drag and drop creation.
;
; Added Re-Install Game Menu
; Removed Extract Game texts
;
;============================================

EnableExplicit

;- __________ Declares

Declare List_Files_Recursive(Dir.s, List Files.s(), Extension.s)
Declare Message_RequesterEx(Title$ , Message$ , width.i)
Declare.s Title_Extras()
Declare Draw_Info(number)
Declare Draw_List()
Declare Draw_CD32_List()
Declare.s Split_On_Capital(split_string.s)
Declare Fix_Gameslist(names_only.b=#False)
Declare Update_FTP()
Declare Update_PC()
Declare Create_Gameslist()
Declare Image_Popup(type)
Declare Process_DB()
Declare Load_Main_DB()
Declare Save_Main_DB()
Declare Save_DB()
Declare Load_GL()
Declare Save_GL_CSV(path.s)
Declare Save_Prefs()
Declare Load_Prefs()
Declare Edit_GL(number)
Declare Draw_Main_Window()
Declare Check_Missing_Images(type.i)
Declare Choose_Icon()

;- __________ Enumerations

Enumeration
  
  #MAIN_WINDOW
  #MAIN_STATUS
  #MAIN_LIST
  #RUN_WINDOW
  #POPUP_WINDOW
  #PATH_WINDOW
  #EDIT_WINDOW
  #FILTER_WINDOW
  #PREVIEW_WINDOW
  #PROGRESS_WINDOW
  #SCREEN_IMAGE
  #TITLE_IMAGE
  #COVER_IMAGE
  #CONVERT_IMAGE
  #SCREEN_BLANK
  #COVER_BLANK
  #IFF_POPUP
  #PREVIEW_IMAGE
  #TEMP_IMAGE
  #BACK_IMAGE
  #POPUP_MENU
  #IMAGE_POPUP_MENU
  #ALPHA_MASK
  #MAIN_PANEL
  #EXTRA_PANEL
  #FILTER_PANEL
  #EDITOR_MENU
  #PREVIEW_FONT
  #HEADER_FONT
  #SMALL_FONT
  #INFO_FONT
  #FTP
  #DAT_XML
  #PDF_IMAGE
  #TEXT_IMAGE
  #PLAY_ICON
  #OPTIONS_ICON
  
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
  #MenuItem_2a
  #MenuItem_2b
  #MenuItem_3
  #MenuItem_4
  #MenuItem_5
  #MenuItem_6
  #MenuItem_7
  #MenuItem_8
  #MenuItem_9
  #MenuItem_10
  #MenuItem_10a
  #MenuItem_10b
  #MenuItem_10c
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
  #MenuItem_40
  #MenuItem_41
  #MenuItem_42
  #MenuItem_43
  #MenuItem_44
  #MenuItem_45
  #MenuItem_46
  #MenuItem_47
  #MenuItem_48
  #MenuItem_49
  #MenuItem_50
  #MenuItem_95
  #MenuItem_96
  #MenuItem_97
  #MenuItem_98
  #MenuItem_99
EndEnumeration

;- __________ Structures

Structure UM_Data
  UM_Title.s
  UM_Short.s
  UM_Genre.s
  UM_Path.s
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
  UM_Preview.b
  UM_Files.b
  UM_Image.b
  UM_Arcadia.b
  UM_Publisher.s
  UM_Developer.s
  UM_Type.s
  UM_Year.s
  UM_Players.s
  UM_Default_Icon.s
  List UM_Icons.s()
  UM_Filtered.b
  UM_Config.i
  UM_Available.b
  UM_Image_Avail.b
  UM_Cover_Avail.b
  UM_Title_Avail.b 
EndStructure

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
  CD_Players.s
  CD_Ram.s
  CD_Config.i
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

Structure Dat_Names
  Arc_Type.s
  Arc_Folder.s
  List Arc_Names.s()
EndStructure

Structure System_Data
  Sys_Name.s
  Sys_File.s
EndStructure

Structure thrds
  t_image.l
  t_path.s
EndStructure

Structure Filter_Data
  Category.i
  Category_Text.s
  Filter.i  
  Filter_Text.s
  Publisher.i  
  Publisher_Text.s
  Year.i  
  Year_Text.s
  Language.i  
  Language_Text.s
  Memory.i  
  Memory_Text.s
  Disks.i  
  Disks_Text.s
  Chipset.i  
  Chipset_Text.s
  DiskType.i  
  DiskType_Text.s
  HardWare.i  
  HardWare_Text.s
  Sound.i   
  Sound_Text.s 
  Coder.i  
  Coder_Text.s
  DataType.i  
  DataType_Text.s
  Players.i  
  Players_Text.s
  Genre.i  
  Genre_Text.s
  Developer.i  
  Developer_Text.s
  Search.s
EndStructure

;- __________ Lists

Global NewList UM_Database.UM_Data()
Global NewList CD32_Database.CD_Data()
Global NewList Systems_Database.System_Data()
Global NewList Fix_List.f_data()

Global NewList List_Numbers.i()
Global NewList CD32_Numbers.i()

Global NewList Files.s()
Global NewList File_List.s()

Global NewList Genre_List.s()
Global NewMap  Genre_Map.s()
Global NewMap  Duplicates.i()
Global NewList Dupe_List.i()

Global NewList Dat_Archives.Dat_Names()

Global Dim Filter.Filter_Data(1)

;- __________ Global Variables

Global W_Title.s="UltraMiggy v0.6"
Global Build.s=FormatDate("%dd%mm%yy", #PB_Compiler_Date)

Global Main_Path.s, path.s, path2.s

Global event.i, listnum.i, count.i, i.i, list_pos.i

Global Main_Menu.i, Title_Image, Cover_Image, Screen_Image, IFF_Image, Info_Gadget, Mutex

Global CD32_List.i, System_List.i, Title_Image_Title.i, paste_gadget.i

Global Language_Gadget, Memory_Gadget, Year_Gadget, Publisher_Gadget, Disks_Gadget, Developer_Gadget
Global Chipset_Gadget, Hardware_Gadget, DiskCategory_Gadget, Sound_Gadget, DataType_Gadget, Players_Gadget
Global Search_Gadget, Coder_Gadget, Category_Gadget, Filter_Gadget, Genre_Gadget, Reset_Button, Filter_Button, Exit_Button, Clear_Button

Global t_image.i, t_path.s ; For Threads

Global Home_Path.s=GetCurrentDirectory()
Global Data_Path.s=Home_Path+"UM_Data\"

Global LHA_Path.s=Home_Path+"Archivers\7z.exe"
Global IZARC_Path.s=Home_Path+"Archivers\izarcc.exe"
Global LZX_Path.s=Home_Path+"Archivers\unlzx.exe"

Global WHD_TempDir.s=GetTemporaryDirectory()+"WHDTemp"
Global DB_Path.s=Home_Path
Global Game_Img_Path.s=Home_Path+"Images\"
Global Game_Info_Path.s=Home_Path+"Game_Info\"
Global Backup_Path.s=Home_Path+"Backup\"
Global CD32_Path.s=Home_Path+"CD32\"
Global WHD_Folder.s=Home_Path+"WHD\"
Global WinUAE_Path.s=Home_Path+"WinUAE\winuae64.exe"
Global ConfUM_Path.s=Home_Path+"Configurations\" 
Global NConvert_Path.s=Home_Path+"NConvert\nconvert.exe"

Global Close_UAE.b=#True
Global JSON_Backup=#True
Global Filter_Panel=#False
Global IFF_Smooth.l=#True
Global Short_Names.b=#False
Global Good_Scaler.b=#False
Global Scaler.l=#PB_Image_Raw

;- __________ Macros

Macro Window_Update() ; <---------------------------------------------> Waits For Window Update
  While WindowEvent() : Wend
EndMacro

Macro Set_Menu (s_bool)
  
  DisableGadget(Genre_Gadget,s_bool)
  
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

Macro Update_StatusBar()
  
  If GetGadgetState(#MAIN_PANEL)=0
    If UM_Database()\UM_Type="Demo"
      StatusBarText(#MAIN_STATUS,1,"Group: "+Chr(10)+UM_Database()\UM_Publisher,#PB_StatusBar_Center)
    Else
      StatusBarText(#MAIN_STATUS,1,"Publisher: "+Chr(10)+UM_Database()\UM_Publisher,#PB_StatusBar_Center)
    EndIf
    StatusBarText(#MAIN_STATUS,0,"Genre: "+Chr(10)+UM_Database()\UM_Genre,#PB_StatusBar_Center)  
    StatusBarText(#MAIN_STATUS,2,"Year: "+Chr(10)+UM_Database()\UM_Year,#PB_StatusBar_Center)
    If UM_Database()\UM_AGA=#True : StatusBarText(#MAIN_STATUS,3,"Chipset: AGA",#PB_StatusBar_Center) : EndIf
    If UM_Database()\UM_CD32=#True : StatusBarText(#MAIN_STATUS,3,"Chipset: AGA",#PB_StatusBar_Center) : EndIf
    If UM_Database()\UM_AGA<>#True And UM_Database()\UM_CD32<>#True : StatusBarText(#MAIN_STATUS,3,"Chipset: OCS / ECS",#PB_StatusBar_Center) : EndIf
  EndIf
  
  If GetGadgetState(#MAIN_PANEL)=1
    StatusBarText(#MAIN_STATUS,1,"Publisher: "+Chr(10)+CD32_Database()\CD_Publisher,#PB_StatusBar_Center)    
    StatusBarText(#MAIN_STATUS,0,"Genre: "+Chr(10)+CD32_Database()\CD_Genre,#PB_StatusBar_Center)  
    StatusBarText(#MAIN_STATUS,2,"Year: "+Chr(10)+CD32_Database()\CD_Year,#PB_StatusBar_Center)
  EndIf
  
EndMacro

Macro PrintS()
  PrintN("")
EndMacro

Macro Draw_Image(image,gadget,blank,width,height)
  
    If IsImage(image)
    imgw=ImageWidth(image)
    imgh=ImageHeight(image)
    ResizeImage(image,DpiX(width),DpiY(height),Smooth)
    StartDrawing(CanvasOutput(gadget))
    DrawImage(ImageID(image),0,0)
    DrawingMode(#PB_2DDrawing_AlphaBlend)
    DrawText(1,1,Str(imgw)+"x"+Str(imgh),RGBA(0,0,0,255),RGBA(0,0,0,128))
    DrawText(0,0,Str(imgw)+"x"+Str(imgh),RGBA(255,0,255,255),RGBA(0,0,0,0))
    StopDrawing()
  Else
    StartDrawing(CanvasOutput(gadget))
    DrawImage(ImageID(blank),0,0)
    StopDrawing()
  EndIf
  
EndMacro

;- __________ Procedures

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

Procedure.s Title_Extras_Short()
  
  Protected extras.s=" ("
  
  If UM_Database()\UM_Memory<>""
    Select UM_Database()\UM_Memory
      Case "512KB" : extras+Chr(189)+"MB"
      Case "1MB" : extras+"1MB"
      Case "1MB Chip" : extras+"1MBChp"
      Case "1.5MB" : extras+"1"+Chr(189)+"MB"
      Case "2MB" : extras+"2MB"
      Case "8MB" : extras+"8MB"
      Case "Chip Mem" : extras+"Chip"
      Case "Fast Mem" : extras+"Fast"
      Case "Low Mem" : extras+"Low"
    EndSelect
    
  EndIf   
  
  If UM_Database()\UM_Language<>"" And UM_Database()\UM_Language<>"English"
    Select UM_Database()\UM_Language
      Case "Czech" : extras+"Cz"
      Case "Danish" : extras+"Dk"
      Case "Dutch" : extras+"Du"
      Case "Finnish" : extras+"Fi"
      Case "French" : extras+"Fr"
      Case "German" : extras+"De"
      Case "Greek" : extras+"Gr"
      Case "Italian" : extras+"It"
      Case "Polish" : extras+"Pl"
      Case "Spanish" : extras+"Es"
      Case "Swedish" : extras+"Sk"
    EndSelect
  EndIf
  
  If UM_Database()\UM_Files<>0
    extras+"Files"
  EndIf
  
  If UM_Database()\UM_Image<>0
    extras+"Image"
  EndIf
  
  If UM_Database()\UM_Disks<>""
    Select UM_Database()\UM_Disks
      Case "One Disk" : extras+"1Dsk"
      Case "Two Disk" : extras+"2Dsk"
      Case "Three Disk" : extras+"3Dsk"
      Case "Four Disk" : extras+"4Dsk"
    EndSelect
  EndIf
  
  If UM_Database()\UM_NTSC<>0
    extras+"US"
  EndIf
  
  If UM_Database()\UM_Demo<>0
    extras+"Demo"
  EndIf
  
  If UM_Database()\UM_Intro<>0
    extras+"Int"
  EndIf
  
  If UM_Database()\UM_NoIntro<>0
    extras+"NoInt"
  EndIf
  
  If UM_Database()\UM_Preview<>0
    extras+"Prev'w'"
  EndIf
  
  If UM_Database()\UM_Coverdisk<>0
    extras+"Cov"
  EndIf
  
  If UM_Database()\UM_Arcadia<>0
    extras+"Arc"
  EndIf
  
  If UM_Database()\UM_MT32<>0
    extras+"MT"
  EndIf
  
  If UM_Database()\UM_CDROM<>0
    extras+"CD"
  EndIf
  
  If UM_Database()\UM_CD32<>0
    extras+"CD32"
  EndIf
  
  If UM_Database()\UM_CDTV<>0
    extras+"CDTV"
  EndIf
  
  If UM_Database()\UM_AGA<>0 And UM_Database()\UM_CD32=0
    extras+"AGA"
  EndIf
  
  
  If UM_Database()\UM_Type="Beta"
    extras+"Beta"
  EndIf
  
  extras+")"
  
  If extras=" ()" : extras="" : EndIf
  
  ProcedureReturn extras
  
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
    extras+ " (♥)"
  EndIf
  
  ProcedureReturn extras
  
EndProcedure

Procedure Set_Filter(bool.b)
  If Filter_Gadget
    DisableGadget(Language_Gadget,bool)
    DisableGadget(Memory_Gadget,bool)
    DisableGadget(Year_Gadget,bool) 
    DisableGadget(Publisher_Gadget,bool) 
    DisableGadget(Developer_Gadget,bool) 
    DisableGadget(Disks_Gadget,bool)
    DisableGadget(Chipset_Gadget,bool) 
    DisableGadget(Hardware_Gadget,bool) 
    DisableGadget(DiskCategory_Gadget,bool) 
    DisableGadget(Sound_Gadget,bool) 
    DisableGadget(DataType_Gadget,bool)
    DisableGadget(Coder_Gadget,bool) 
    DisableGadget(Category_Gadget,bool) 
    DisableGadget(Filter_Gadget,bool) 
    DisableGadget(Players_Gadget,bool)
  EndIf
EndProcedure

Procedure Reset_Filter()
  
  Filter(0)\Category=0
  Filter(0)\Category_Text="All"
  Filter(0)\Filter=0
  Filter(0)\Filter_Text="All"
  Filter(0)\Genre=0  
  Filter(0)\Genre_Text="All"
  Filter(0)\Year=0
  Filter(0)\Year_Text="All"
  Filter(0)\Language=0
  Filter(0)\Language_Text="All"
  Filter(0)\Memory=0  
  Filter(0)\Memory_Text="All"
  Filter(0)\Disks=0  
  Filter(0)\Disks_Text="All"  
  Filter(0)\Publisher=0  
  Filter(0)\Publisher_Text="All"
  Filter(0)\Developer=0  
  Filter(0)\Developer_Text="All"
  Filter(0)\Chipset=0
  Filter(0)\Chipset_Text="All"
  Filter(0)\DiskType=0  
  Filter(0)\DiskType_Text="All"
  Filter(0)\HardWare=0  
  Filter(0)\HardWare_Text="All"
  Filter(0)\Sound=0  
  Filter(0)\Sound_Text="All"
  Filter(0)\Coder=0  
  Filter(0)\Coder_Text="All"
  Filter(0)\DataType=0  
  Filter(0)\DataType_Text="All"
  Filter(0)\Players=0  
  Filter(0)\Players_Text="All"

  Filter(0)\Search=""  
  
  If IsWindow(#FILTER_WINDOW)
    SetGadgetState(Category_Gadget,Filter(0)\Category)
    SetGadgetState(Filter_Gadget,0) 
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
    SetGadgetState(Genre_Gadget,0)
    SetGadgetState(Players_Gadget,0)
  EndIf 


EndProcedure

Procedure Center_List(old_pos.s)
  
  Protected itemheight, hotitem
  
  itemheight = SendMessage_(GadgetID(#MAIN_LIST), #LVM_GETITEMSPACING, #True, 0) >> 16 ; only need to do this once
  ForEach List_Numbers()
    SelectElement(UM_Database(),List_Numbers())
    If UM_Database()\UM_Type+"_"+UM_Database()\UM_Slave=old_pos
      hotitem = List_Numbers()
      SetGadgetState(#MAIN_LIST, hotitem)
      SendMessage_(GadgetID(#MAIN_LIST), #LVM_SCROLL, 0, 0-(CountGadgetItems(#MAIN_LIST) * itemheight)) ; scroll to top
      SendMessage_(GadgetID(#MAIN_LIST), #LVM_SCROLL, 0, (hotitem-14) * itemheight)                     ; scroll to center hot item in listicon
      Window_Update()
      Break
    EndIf
  Next
  
EndProcedure
    
Procedure Filter_List()
  
  If Filter(0)\Filter_Text="No Image"
    Check_Missing_Images(1)  
  EndIf
  
  If Filter(0)\Filter_Text="No Cover"
    Check_Missing_Images(2)  
  EndIf
  
  If Filter(0)\Filter_Text="No Title"
    Check_Missing_Images(3)  
  EndIf
  
  ForEach UM_Database()
    
    UM_Database()\UM_Filtered=#False
    
    If Filter(0)\Search<>""
      If Not FindString(LCase(UM_Database()\UM_Title),LCase(Filter(0)\Search),#PB_String_NoCase)
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    
    If Filter(0)\Category_Text<>"All" And Filter(0)\Category_Text<>"Game/Beta"
      If UM_Database()\UM_Type<>Filter(0)\Category_Text
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    
    If Filter(0)\Category_Text="Game/Beta"
      If UM_Database()\UM_Type="Demo"
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    
    If Filter(0)\Players_Text="No Players"
      If UM_Database()\UM_Players<>"0" And UM_Database()\UM_Players<>""
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    If Filter(0)\Players_Text="1 Player"
      If UM_Database()\UM_Players<>"1"
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    If Filter(0)\Players_Text="2 Players"
      If UM_Database()\UM_Players<>"2"
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    If Filter(0)\Players_Text="3 Players"
      If UM_Database()\UM_Players<>"3"
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    If Filter(0)\Players_Text="4 Players"
      If UM_Database()\UM_Players<>"4"
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    If Filter(0)\Players_Text="5+ Players"
      If Val(UM_Database()\UM_Players)<5
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    
    If Filter(0)\Genre_Text<>"All" 
      If UM_Database()\UM_Genre<>Filter(0)\Genre_Text
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf  
    
    If Filter(0)\Publisher_Text<>"All"
      If UM_Database()\UM_Publisher<>Filter(0)\Publisher_Text
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    
    If Filter(0)\Developer_Text<>"All"
      If UM_Database()\UM_Developer<>Filter(0)\Developer_Text
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    
    If Filter(0)\Coder_Text<>"All"
      If UM_Database()\UM_Publisher<>Filter(0)\Coder_Text
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    
    If Filter(0)\Year_Text<>"All"
      If UM_Database()\UM_Year<>Filter(0)\Year_Text
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf 
    
    Select Filter(0)\DiskType_Text
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
    
    Select Filter(0)\DataType_Text
      Case "Image"
        If UM_Database()\UM_Image<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
      Case "Files"
        If UM_Database()\UM_Files<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
    EndSelect
    
    Select Filter(0)\HardWare_Text
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
    
    Select Filter(0)\Chipset_Text
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
    
    Select Filter(0)\Sound_Text
      Case "MT32"
        If UM_Database()\UM_MT32<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
      Case "No Sound"
        If UM_Database()\UM_NoSound<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
    EndSelect
    
    If Filter(0)\Language_Text<>"All"
      If UM_Database()\UM_Language<>Filter(0)\Language_Text
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf 
    
    If Filter(0)\Memory_Text<>"All"
      If UM_Database()\UM_Memory<>Filter(0)\Memory_Text
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf 
    
    If Filter(0)\Disks_Text<>"All"
      If UM_Database()\UM_Disks<>Filter(0)\Disks_Text
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    
    Select Filter(0)\Filter_Text
        
      Case "No Image"        
        If UM_Database()\UM_Image_Avail=#True
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "Favourite"
        If UM_Database()\UM_Favourite<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "No Chipset"
        If UM_Database()\UM_ECSOCS=#True
          UM_Database()\UM_Filtered=#True
        EndIf
        If UM_Database()\UM_AGA=#True
          UM_Database()\UM_Filtered=#True
        EndIf
        If UM_Database()\UM_CD32=#True
         UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "Too Long"        
        If Len(UM_Database()\UM_Short+Title_Extras_Short())<29
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "No Cover"        
        If UM_Database()\UM_Cover_Avail=#True
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "No Title"        
        If UM_Database()\UM_Title_Avail=#True
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "No Year"        
        If UM_Database()\UM_Year<>"(Unknown)"
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "No Publisher"        
        If UM_Database()\UM_Publisher<>""
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "No Developer"        
        If UM_Database()\UM_Developer<>""
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "Invalid Genre"
        If FindMapElement(Genre_Map(),UM_Database()\UM_Genre)
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "Missing Type"
        If UM_Database()\UM_Type<>""
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "Invalid Icon"
        ForEach UM_Database()\UM_Icons()
          If UM_Database()\UM_Default_Icon=UM_Database()\UM_Icons() : UM_Database()\UM_Filtered=#True : Break : EndIf
        Next
        
      Case "No Icon"
        ForEach UM_Database()\UM_Icons()
          If UM_Database()\UM_Default_Icon<>"" : UM_Database()\UM_Filtered=#True : Break : EndIf
        Next
        
    EndSelect
    
  Next
  
EndProcedure

Procedure Load_Image(*val.thrds)
  
  Shared Mutex
  
  LockMutex(Mutex)
  
  If FileSize(*val\t_path)>0
    LoadImage(*val\t_image, *val\t_path)
  EndIf

  UnlockMutex(Mutex)
  
EndProcedure

Procedure Draw_Game_Info(*nul)
  
  Protected output$, input$, myfile
  
  Pause_Gadget(Info_Gadget)
  
  SetGadgetText(Info_Gadget,"")
  
  If GetGadgetState(#MAIN_LIST)<>-1
    
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
    output$+LSet("Short Name",11," ")+": "+UM_Database()\UM_Short+Title_Extras_Short()+#CRLF$
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
    
    If FileSize(Game_Info_Path+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\game_info.txt")>0 And UM_Database()\UM_Type<>"Demo"
      output$+#CRLF$
      output$+"Description"+#CRLF$
      output$+"-----------"+#CRLF$
      myfile=ReadFile(#PB_Any,Game_Info_Path+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\game_info.txt")
      If IsFile(myfile)
        While Not Eof(myfile)
          input$=ReadString(myfile)
          output$+input$+#CRLF$
        Wend
        CloseFile(myfile)
      EndIf
    EndIf
    
    SetGadgetText(Info_Gadget,output$)
    
  EndIf
  
  Resume_Gadget(Info_Gadget)
  
EndProcedure

Procedure Draw_Systems_List()
  
  ExamineDirectory(0,Home_Path+"Configurations\","*.uae")
  While NextDirectoryEntry(0)
    AddElement(Systems_Database())
    Systems_Database()\Sys_File=GetFilePart(DirectoryEntryName(0))
    Systems_Database()\Sys_Name=GetFilePart(DirectoryEntryName(0),#PB_FileSystem_NoExtension)
  Wend
  
  ForEach Systems_Database()
    AddGadgetItem(System_List,-1,Systems_Database()\Sys_Name)
  Next
  
  If GetWindowLongPtr_(GadgetID(System_List), #GWL_STYLE) & #WS_VSCROLL
    SetGadgetItemAttribute(System_List,0,#PB_ListIcon_ColumnWidth,GadgetWidth(System_List)-20)
  Else
    SetGadgetItemAttribute(System_List,0,#PB_ListIcon_ColumnWidth,GadgetWidth(System_List)-5)
  EndIf
  
  For count=0 To CountGadgetItems(System_List) Step 2
    SetGadgetItemColor(System_List,count,#PB_Gadget_BackColor,$eeeeee)
  Next
  
EndProcedure

Procedure Draw_CD32_Info(number)
  
  Protected output$, Smooth, imgw, imgh, input$
  
  Mutex=CreateMutex()
  
  If IFF_Smooth : Smooth=#PB_Image_Smooth : Else : Smooth=#PB_Image_Raw : EndIf
  
  If number>-1
    
    SelectElement(CD32_Database(),number)
    
    Protected thr.i
    
    Dim mythread.thrds(3)
    
    mythread(0)\t_image=#TITLE_IMAGE
    mythread(0)\t_path=Game_Img_Path+"CD32\Titles\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".png"
    mythread(1)\t_image=#SCREEN_IMAGE
    mythread(1)\t_path=Game_Img_Path+"CD32\Screenshots\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".png"
    mythread(2)\t_image=#COVER_IMAGE
    mythread(2)\t_path=Game_Img_Path+"CD32\Covers\"+CD32_Database()\CD_Title+".png"
    
    For i=0 To 2
      thr=CreateThread(@Load_Image(),@mythread(i))
      Delay(10)
    Next
    
    WaitThread(thr)
    
    FreeArray(mythread())
    
    If IsImage(#TITLE_IMAGE)
      ResizeImage(#TITLE_IMAGE,DpiX(316),DpiY(252),Smooth)
      StartDrawing(CanvasOutput(Title_Image))
      DrawImage(ImageID(#TITLE_IMAGE),0,0)
      StopDrawing() 
    EndIf
    
    If IsImage(#SCREEN_IMAGE)
      ResizeImage(#SCREEN_IMAGE,DpiX(316),DpiY(252),Smooth)
      StartDrawing(CanvasOutput(Screen_Image))
      DrawImage(ImageID(#SCREEN_IMAGE),0,0)
      StopDrawing()
    EndIf
    
    If IsImage(#COVER_IMAGE)
      imgw=ImageWidth(#COVER_IMAGE) : imgh=ImageHeight(#COVER_IMAGE)
      ResizeImage(#COVER_IMAGE,DpiX(316),DpiY(408),Smooth)
      StartDrawing(CanvasOutput(Cover_Image))
      DrawImage(ImageID(#COVER_IMAGE),0,0)
      StopDrawing()
    EndIf
    
    output$=""
    output$+"Genre: "+CD32_Database()\CD_Genre+#CRLF$
    output$+"Language: "+CD32_Database()\CD_Language+#CRLF$
    output$+"Publisher: "+CD32_Database()\CD_Publisher+#CRLF$
    output$+"Year: "+CD32_Database()\CD_Year+#CRLF$
    If UM_Database()\UM_Players<>""
      output$+"Players: "+CD32_Database()\CD_Players+#CRLF$
    EndIf
    
    SetGadgetText(Info_Gadget,output$)
    
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
  
  If IsImage(#COVER_IMAGE) : FreeImage(#COVER_IMAGE) : EndIf
  If IsImage(#TITLE_IMAGE) : FreeImage(#TITLE_IMAGE) : EndIf
  If IsImage(#SCREEN_IMAGE) : FreeImage(#SCREEN_IMAGE) : EndIf
  
EndProcedure

Procedure Draw_Info(number)
  
  
  Protected output$, Smooth, imgw, imgh, input$, id
    
  Mutex=CreateMutex()
      
  If IFF_Smooth : Smooth=#PB_Image_Smooth : Else : Smooth=#PB_Image_Raw : EndIf
  
  If number<>-1
    
    SelectElement(UM_Database(),number)
    
    If IsMenu(#POPUP_MENU) : FreeMenu(#POPUP_MENU) : EndIf
    CreatePopupImageMenu(#POPUP_MENU)
    MenuItem(#Menuitem_1,"Play",ImageID(#PLAY_ICON))
    MenuItem(#Menuitem_27,"Game Options",ImageID(#OPTIONS_ICON))
    MenuBar()
    count=0    
    ExamineDirectory(0, Game_Info_Path+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\","*.*")
    count=0
    While NextDirectoryEntry(0)
      If DirectoryEntryName(0)<>"game_info.txt" And DirectoryEntryName(0)<>"." And DirectoryEntryName(0)<>".."
        If GetExtensionPart(DirectoryEntryName(0))="txt" : id=#TEXT_IMAGE : EndIf
        If GetExtensionPart(DirectoryEntryName(0))="pdf" : id=#PDF_IMAGE : EndIf
        If GetExtensionPart(DirectoryEntryName(0))="jpg" : id=#IMAGE_ICON : EndIf
        If GetExtensionPart(DirectoryEntryName(0))="png" : id=#IMAGE_ICON : EndIf
        MenuItem(900+count,DirectoryEntryName(0),ImageID(id))
        count+1
      EndIf
    Wend
    
    Protected thr.i
    
    Dim mythread.thrds(3)
    
    mythread(0)\t_image=#TITLE_IMAGE
    mythread(0)\t_path=Game_Img_Path+"Titles\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
    mythread(1)\t_image=#SCREEN_IMAGE
    mythread(1)\t_path=Game_Img_Path+"Screenshots\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
    mythread(2)\t_image=#COVER_IMAGE
    mythread(2)\t_path=Game_Img_Path+"Covers\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
    
    For i=0 To 2
      thr=CreateThread(@Load_Image(),@mythread(i))
      Delay(10)
    Next
    
    WaitThread(thr)
    
    FreeArray(mythread())
    
  EndIf
  
  Draw_Image(#TITLE_IMAGE,Title_Image,#SCREEN_BLANK,316,252)
  Draw_Image(#SCREEN_IMAGE,Screen_Image,#SCREEN_BLANK,316,252)
  Draw_Image(#COVER_IMAGE,Cover_Image,#COVER_BLANK,316,408)
  
  thr=CreateThread(@Draw_Game_Info(),#Null)
    
  If IsImage(#COVER_IMAGE) : FreeImage(#COVER_IMAGE) : EndIf
  If IsImage(#TITLE_IMAGE) : FreeImage(#TITLE_IMAGE) : EndIf
  If IsImage(#SCREEN_IMAGE) : FreeImage(#SCREEN_IMAGE) : EndIf 
  
EndProcedure

Procedure Draw_CD32_List()
  
  Protected star.s, game.i, demo.i, beta.i
  
  SortStructuredList(CD32_Database(),#PB_Sort_Ascending|#PB_Sort_NoCase,OffsetOf(CD_Data\CD_Title),TypeOf(CD_Data\CD_Title))
  
  UseGadgetList(WindowID(#MAIN_WINDOW))
  
  Pause_Gadget(CD32_List)
  
  ClearList(CD32_Numbers())
  ClearGadgetItems(CD32_List)
  
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
  
  Resume_Gadget(CD32_List)  
  
  If ListSize(CD32_Numbers())>0
    SelectElement(CD32_Numbers(),0)
  EndIf
  
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
    If Short_Names
      AddGadgetItem(#MAIN_LIST,-1,UM_Database()\UM_Short+Title_Extras_Short())
    Else
      AddGadgetItem(#MAIN_LIST,-1,UM_Database()\UM_Title+Title_Extras())
    EndIf  
  Next
      
  If GetWindowLongPtr_(GadgetID(#MAIN_LIST), #GWL_STYLE) & #WS_VSCROLL
    SetGadgetItemAttribute(#MAIN_LIST,1,#PB_ListIcon_ColumnWidth,GadgetWidth(#MAIN_LIST)-1)
  Else
    SetGadgetItemAttribute(#MAIN_LIST,1,#PB_ListIcon_ColumnWidth,GadgetWidth(#MAIN_LIST)-18)
  EndIf
  
  For count=0 To CountGadgetItems(#MAIN_LIST) Step 2
    SetGadgetItemColor(#MAIN_LIST,count,#PB_Gadget_BackColor,$eeeeee)
  Next
  
  SetGadgetState(#MAIN_LIST,0)
  
  Resume_Gadget(#MAIN_LIST)
  
  SetActiveGadget(#MAIN_LIST)
  
  Select Filter(0)\Category_Text
    Case "All" : count=ListSize(UM_Database())
    Case "Game" : count=game
    Case "Game/Beta" : count=game+beta
    Case "Demo" : count=demo
    Case "Beta" : count=beta
  EndSelect
  
  SetWindowTitle(#MAIN_WINDOW, W_Title+" (Build "+Build+")"+" (Showing "+Str(CountGadgetItems(#MAIN_LIST))+" of "+Str(count)+" Games)")
  
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
      WriteString(startup_file,"cd "+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+UM_Database()\UM_Folder+"/"+#LF$)
      WriteString(startup_file,"kgiconload "+UM_Database()\UM_Default_Icon+#LF$)
      If Close_UAE : WriteString(startup_file,"c:uaequit") : EndIf
      FlushFileBuffers(startup_file)
      CloseFile(startup_file)      
    EndIf
    
    config=""
    
    Select UM_Database()\UM_Config
      Case 0 : config=ConfUM_Path+"A1200_WHD.uae"
      Case 1 : config=ConfUM_Path+"A1200_WHD_030.uae"
      Case 2 : config=ConfUM_Path+"A1200_WHD_040.uae"
      Case 3 : config=ConfUM_Path+"A1200_WHD_CD32.uae"
    EndSelect
    
    OpenWindow(#RUN_WINDOW,0,0,360,60,"Starting WinUAE. Please Wait...",#PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
    TextGadget(#PB_Any,10,15,340,50,"Loading: "+UM_Database()\UM_Title+Title_Extras(),#PB_Text_Center)
    
    startup_prog=RunProgram(WinUAE_Path, "-f "+config+" -s filesystem2=rw,DH1:WHDTemp:"+WHD_TempDir+",0","",#PB_Program_Wait)
    
    CloseWindow(#RUN_WINDOW)
    
    SetCurrentDirectory(home_path)
    
    DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
    
  EndIf
  
  DisableWindow(#MAIN_WINDOW,#False)
  
  SetGadgetState(#MAIN_LIST,old_pos)
  SetActiveGadget(#MAIN_LIST)
  
EndProcedure

Procedure Run_Icon(gamenumber.i, icon_name.s)
  
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
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"Opening "+icon_name+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"wait 2 secs"+#LF$)
      WriteString(startup_file,"cd WHD-HDD:"+#LF$)
      WriteString(startup_file,"cd "+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+UM_Database()\UM_Folder+"/"+#LF$)
      WriteString(startup_file,"kgiconload "+icon_name+#LF$)
      If Close_UAE : WriteString(startup_file,"c:uaequit") : EndIf
      FlushFileBuffers(startup_file)
      CloseFile(startup_file)      
    EndIf
    
    config=""
    
    Select UM_Database()\UM_Config
      Case 0 : config=ConfUM_Path+"A1200_WHD.uae"
      Case 1 : config=ConfUM_Path+"A1200_WHD_030.uae"
      Case 2 : config=ConfUM_Path+"A1200_WHD_040.uae"
      Case 3 : config=ConfUM_Path+"A1200_WHD_CD32.uae"
    EndSelect
    
    startup_prog=RunProgram(WinUAE_Path, "-f "+config+" -s filesystem2=rw,DH1:WHDTemp:"+WHD_TempDir+",0","",#PB_Program_Wait)
    
    SetCurrentDirectory(home_path)
    
    DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
    
  EndIf
  
  DisableWindow(#MAIN_WINDOW,#False)
  
  SetGadgetState(#MAIN_LIST,old_pos)
  
EndProcedure

Procedure Run_CD32(gamenumber.i)
  
  Protected output$, startup_prog.i, old_pos.i
  
  old_pos=GetGadgetState(CD32_List)
  
  DisableWindow(#MAIN_WINDOW,#True)
  
  SelectElement(CD32_Database(),gamenumber)
  
  If CD32_Database()\CD_Config=0
    output$=" -f "+ConfUM_Path+"CD32.uae -cfgparam cdimage0="+#DOUBLEQUOTE$+CD32_Path+CD32_Database()\CD_File+#DOUBLEQUOTE$+","
  EndIf
  If CD32_Database()\CD_Config=1
    output$=" -f "+ConfUM_Path+"CD32-4MB.uae -cfgparam cdimage0="+#DOUBLEQUOTE$+CD32_Path+CD32_Database()\CD_File+#DOUBLEQUOTE$+","
  EndIf
  If CD32_Database()\CD_Config=2
    output$=" -f "+ConfUM_Path+"CD32-8MB.uae -cfgparam cdimage0="+#DOUBLEQUOTE$+CD32_Path+CD32_Database()\CD_File+#DOUBLEQUOTE$+","
  EndIf
  
  startup_prog=RunProgram(WinUAE_Path,output$,"",#PB_Program_Wait)
  
  DisableWindow(#MAIN_WINDOW,#False)
  
  SetActiveGadget(CD32_List)
  SetGadgetState(CD32_List,old_pos)
  
EndProcedure

Procedure Run_System(gamenumber.i)
  
  Protected output$, startup_prog.i, old_pos.i
  
  ;old_pos=GetGadgetState(CD32_List)
  
  DisableWindow(#MAIN_WINDOW,#True)
  
  SelectElement(Systems_Database(),gamenumber)
  
  output$=" -f "+#DOUBLEQUOTE$+ConfUM_Path+Systems_Database()\Sys_File+#DOUBLEQUOTE$+" -cfgparam use_gui=no"
  
  startup_prog=RunProgram(WinUAE_Path,output$,"",#PB_Program_Wait)
  
  DisableWindow(#MAIN_WINDOW,#False)
  
  ;SetActiveGadget(CD32_List)
  ;SetGadgetState(CD32_List,old_pos)
  
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

Procedure ReInstall_Game(gamenum)
  
  SelectElement(UM_Database(),gamenum)
  
  Protected exit.b, output.s, startup_file, startup_prog
  
  OpenConsole("Re-Install Game...")
  ConsoleCursor(0)
  
  PrintNCol("**************************",6,0)
  PrintNCol("*                        *",6,0)
  PrintNCol("*       Re-Install...    *",6,0)
  PrintNCol("*                        *",6,0)
  PrintNCol("**************************",6,0)
  PrintS() 
  
  PrintNCol("Reinstalling: "+UM_Database()\UM_Title+Title_Extras(),10,0)
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
  
  ; If a valid entry is made check that it's OK to continue
  
  If Not exit
    
    PrintNCol(#LF$+"WARNING!WARNING!WARNING!"+#LF$,4,0)
    PrintNCol("You are about to make changes to the Amiga drive! Continue (Y/N)?",15,0)
    Repeat : path=Inkey() :  Until path="Y" Or path="y" Or path="N" Or path="n"
    PrintS()
    
    If path="y" Or path="Y"
      
      ; If the answer is yes, continue.
      
      PrintNCol("Starting WinUAE...",14,0)
      PrintS()
      
      ; Create the batch file that the Amiga will use to update it's drive
      
      If path2="F" Or path2="f" ; If full selected, delete old folder
        
        output+"echo "+#DOUBLEQUOTE$+"Deleting Old Directories..."+#DOUBLEQUOTE$+#LF$
        output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
        output+"delete WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+UM_Database()\UM_Folder+" ALL"+#LF$
        output+"delete WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+UM_Database()\UM_Folder+".info"+#LF$
        
      EndIf
      
      output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
      output+"echo "+#DOUBLEQUOTE$+"Extracting New Archives..."+#DOUBLEQUOTE$+#LF$
      output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
      
      ; Wait For Disk To Finish before starting archive extraction.
      
      output+"wait 2 SECS"+#LF$
      
      ; Add unarchive commands based on the Copy List.
      
      output+"cd WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+#LF$
      If GetExtensionPart(UM_Database()\UM_LHAFile)="lha"
        output+"lha -m x DH1:"+"0.lha"+#LF$
      EndIf
      If GetExtensionPart(UM_Database()\UM_LHAFile)="lzx"
        output+"xadunfile FROM DH1:"+"0.lzx"+" DEST WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+" OW VERBOSE"+#LF$
      EndIf
      
      output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
      output+"ask "+#DOUBLEQUOTE$+"Press A Key to Close WinUAE..."+#DOUBLEQUOTE$+#LF$
      
      ; Quit WinUAE
      
      output+"c:uaequit"+#LF$
      
      ; Check if temporary folder exists and delete if necessary.
      
      If FileSize(WHD_TempDir)=-2 : DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force) : EndIf
      
      Protected result.i        
      
      ; Create a new temporary directory for DH1:
      
      If CreateDirectory(WHD_TempDir)
        SetCurrentDirectory(WHD_TempDir)
        
        ; Create the startup script
        
        startup_file=CreateFile(#PB_Any,"whd-startup")
        
        If startup_file ; Write the output script to the batch file
          
          WriteString(startup_file,output)
          FlushFileBuffers(startup_file)          
          CloseFile(startup_file)
          
        EndIf
        
        ; copy the required archive into the temporary folder and name as 1.lha,2.lha... to remove extraction name problems
        
        path=ReplaceString(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+UM_Database()\UM_LHAFile,"/","\")
        
        If GetExtensionPart(UM_Database()\UM_LHAFile)="lha"
          result=CopyFile(path,"0.lha")
        EndIf
        If GetExtensionPart(UM_Database()\UM_LHAFile)="lzx"
          result=CopyFile(path,"0.lzx")
        EndIf   
        
        Delay(100) ; Make sure that all copy / file creation processes have finished.
        
        ; Run WinUAE with the temporary folder as DH1: and wait until it finishes
        
        startup_prog=RunProgram(WinUAE_Path, "-f "+ConfUM_Path+"Update.uae -s filesystem2=rw,DH1:WHDTemp:"+WHD_TempDir+",0","",#PB_Program_Wait) 
        
        SetCurrentDirectory(home_path)
        
        ; Delete the temporary folder
        
        DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
        
      EndIf
    EndIf
  EndIf 
  
  ; On error go to here!
  
  CleanUp:
  
  CloseConsole()
  
EndProcedure

Procedure Extract_Text_Files_Single(archive_path.s)
  
  Protected result.i, length.i, UM_Program.i, ReadO$, output$
  
  Protected NewList Text_Files.s()
  
  PrintS()
  PrintN("Extracting Text Files...")
  PrintS()
  
  UM_Program=RunProgram(LHA_Path,"l -ba -slt "+#DOUBLEQUOTE$+archive_path+#DOUBLEQUOTE$,GetCurrentDirectory(),#PB_Program_Open|#PB_Program_Read)
  
  While ProgramRunning(UM_Program) 
    If AvailableProgramOutput(UM_Program)   
      ReadO$=ReadProgramString(UM_Program)
      If FindString(ReadO$,"Path = ")
        ReadO$=RemoveString(ReadO$,"Path = ")
        If CountString(ReadO$,"\")=1
          If GetExtensionPart(ReadO$)=""
            AddElement(Text_Files())
            Text_Files()=ReadO$
          EndIf
        EndIf
      EndIf
    EndIf
  Wend
  
  CloseProgram(UM_Program)
  
  output$=""
  
  ForEach Text_Files()
    output$+Text_Files()+" "
  Next
  
  UM_Program=RunProgram(LHA_Path,"e "+#DOUBLEQUOTE$+archive_path+#DOUBLEQUOTE$+" "+output$,GetCurrentDirectory(),#PB_Program_Wait)
  
  CreateDirectory("Game_Data\"+UM_Database()\UM_Type)
  CreateDirectory("Game_Data\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\"))
  CreateDirectory("Game_Data\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder)
  
  path="Game_Data\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"
  
  ForEach Text_Files()
    CopyFile(Home_Path+StringField(Text_Files(),2,"\"),path+StringField(Text_Files(),2,"\")+".txt")
    DeleteFile(Home_Path+StringField(Text_Files(),2,"\"))
  Next
  
  FreeList(Text_Files())  
  
EndProcedure

;- ############### UPDATE

Procedure Update_FTP()
  
  ; 1. Download dat files
  ; 2. Process XML into list
  ; 3. Compare lists to PC
  ; 4. Remove/Backup Un-Needed archives
  ; 5. Download new archives, scan and update DB (Flag As unprocessed)
  ; 6. Scan PC WHD archives and update database
  ; 7. Scan Miggy Update WHD Drive
  ; 8. Clean up the PC Drive.
  
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
  Protected UM_Program.i, time.i
  
  tempfolder=GetTemporaryDirectory()+"um_temp\"
  main_ftp="Retroplay WHDLoad Packs"
  ftp_server="grandis.nu"
  ftp_user="mrv2k"
  ftp_pass="Amiga123"
  ftp_passive=#True
  ftp_port=21
  
 ;{ 1. Download dat files #####################################################################################################################################################################  
  
  CreateDirectory(tempfolder)
  
  OpenConsole("FTP Download...")
  
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
            CreateDirectory(WHD_Folder+path)
            CreateDirectory(WHD_Folder+path+StringField(Down_List(),2,"\"))
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
    
  ;1. create a temporary list with the game db structure
  ;2. copy game db settings to list
  ;3. create a map of the temp list
  ;4. delete the game db list
  ;5. populate the new game db list from the updated database
  ;6. if the name is found copy back the data
  ;7. if the name is not found add new data
  ;8. free the new list and the map
    
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
    c_olddate.s
    c_newdate.s
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
  Protected UM_Program.i, time.i
  Protected ReadO$, Output$, SubFolder$, Date$, Year$, Month$, Day$, length.i
  Protected oldpath.s
  
  OpenConsole("Update...")
  ConsoleCursor(0)
  
  ;{ 6. Scan PC WHD archives and update database ###########################################################################################################################################################  
  
  PrintNCol("**************************",6,0)
  PrintNCol("*                        *",6,0)
  PrintNCol("*  Updating Database...  *",6,0)
  PrintNCol("*                        *",6,0)
  PrintNCol("**************************",6,0)
  PrintS()  
  
  ClearList(File_List())
  
  ; Create List of WHD Archives On PC
  
  List_Files_Recursive(WHD_Folder,File_List(),"") 
  
  If ListSize(File_List())>0 
    
    ; Add Existing Database WHD Archives to Map
    
    ForEach UM_Database() 
      Folder_Check(LCase(UM_Database()\UM_Type+"_"+UM_Database()\UM_Folder))=ListIndex(UM_Database()) ; Map to check if folder exists.
      Check_Archives(LCase(UM_Database()\UM_Type+"_"+UM_Database()\UM_LHAFile))                       ; Map to check if WHD archive exists
    Next     
    
    ; Scan through file list and if the file is not in the database, add it to a list to be checked. 
    
    ForEach File_List() 
      path2=LCase(StringField(File_List(),4,"\"))
      If Not FindMapElement(Check_Archives(),LCase(path2+"_"+GetFilePart(File_List())))
        If GetFilePart(File_List())<>"EmeraldMines_v1.0_CD.lzx" And GetFilePart(File_List())<>"DangerFreak_v1.0_0975.lha"
          AddElement(Check_List())
          Check_List()=File_List()
        EndIf
      EndIf
    Next
    
    ; Scan though list of new files and either add to database if it's new or update existing database entries of it's found.
    
    ForEach Check_List() 
      
      count=CountString(Check_List(),"\")
      SubFolder$=StringField(Check_List(),count,"\")  
      
      ; Set variable for archive check based on extension and run archiver
      
      If GetExtensionPart(Check_List())="lha"
        length=54
        i=1
        UM_Program=RunProgram(LHA_Path,"l "+#DOUBLEQUOTE$+Check_List()+#DOUBLEQUOTE$,GetCurrentDirectory(),#PB_Program_Open|#PB_Program_Read)
      EndIf
      
      If GetExtensionPart(Check_List())="lzx"
        length=49
        i=2
        UM_Program=RunProgram(LZX_Path,"-v "+#DOUBLEQUOTE$+Check_List()+#DOUBLEQUOTE$,GetCurrentDirectory(),#PB_Program_Open|#PB_Program_Read)
      EndIf
      
      ; If the archiver is running start adding data to the Add List
      
      If UM_Program
        
        AddElement(Add_List())
        
        ; Add subfolder to Add List
        
        Add_List()\add_sub=SubFolder$
        
        ; Add archive type to Add List
        
        Add_List()\add_type=StringField(Check_List(),4,"\")
        
        ; Add WHD archive name to Add List
        
        Add_List()\add_arc=GetFilePart(Check_List())
        
        ; Add full WHD archive path to Add List
        
        Add_List()\add_full_arc=Check_List() 
        
        ; Display which archive is being processed
        
        PrintN("Processing "+GetFilePart(Check_List())+" ("+ListIndex(Check_List())+" of "+ListSize(Check_List())+")")    
        
        ; Whilst the archiver is running, capture the output and process data
        
        While ProgramRunning(UM_Program) 
          
          If AvailableProgramOutput(UM_Program)  
            
            ReadO$=ReadProgramString(UM_Program)           
            ReadO$=RemoveString(ReadO$,#DOUBLEQUOTE$)           
            ReadO$=ReplaceString(ReadO$,"\", "/")
            
            ; If the output is a slave or an icon file, process the information.
            
            If FindString(ReadO$,".slave",0,#PB_String_NoCase) Or FindString(ReadO$,".info",0,#PB_String_NoCase)
              
              path=Mid(ReadO$,length,Len(ReadO$)) ; Cut Out Slave Path
              
              If CountString(path,"/")=1 ; Only process slave files in the main directory
                
                If FindString(ReadO$,".slave",0,#PB_String_NoCase) ; If the output is a slave file add the following data.
                  
                  Add_List()\add_file=path ; Add the slave name to the Add List entry
                  
                  ; Get Slave Date For DB based on the WHD archive extension
                  
                  If GetExtensionPart(Check_List())="lha" 
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
              
              ; Process the entry if the entry is an icon file
              
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
      
      ; Compare to list of folders in the existing database and if it exists, update the database entry, choose a default icon and rename the existing images to match.
      
      If FindMapElement(Folder_Check(),LCase(Add_List()\add_type+"_"+RemoveString(GetPathPart(Add_List()\add_file),"/"))) 
        
        ;Select the database entry to change
        
        SelectElement(UM_Database(),Folder_Check())
        
        ; Update WHD archive name
        
        UM_Database()\UM_LHAFile=Add_List()\add_arc
        
        ; Update the slave date to the new one.
        
        UM_Database()\UM_Slave_Date=Add_List()\add_date
        
        ; Store the existing image name for the file rename later
        
        oldpath=UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
        
        ; Clear the existing list of icons
        
        ClearList(UM_Database()\UM_Icons())
        
        ; Copy the new list of icons into the existing database entry
        
        CopyList(Add_List()\Icons2(), UM_Database()\UM_Icons())
        
        Protected NewMap icon_map.s()
        
        ; Copy the new scanned icons into a map for comparison against the existing default icon
        
        ForEach UM_Database()\UM_Icons()
          icon_map(UM_Database()\UM_Icons())=UM_Database()\UM_Icons()
        Next
        
        ; If the default icon isn't in the map, ask for a new one.
        
        If Not FindMapElement(icon_map(),UM_Database()\UM_Default_Icon)
          
          ; Generate the test for selecting a new default icon
          
          PrintS()
          PrintN("Choose Default Icon for "+UM_Database()\UM_Title)
          PrintS()
          count=1
          ForEach UM_Database()\UM_Icons()
            PrintN(Str(count)+": "+UM_Database()\UM_Icons())
            count+1
          Next
          PrintN("C: Cancel")
          PrintS()
          Print("Select a number: ")
          path=Input() ; Wait for input
          
          If LCase(path)="c" : Goto CleanUp : EndIf
          
          i=Val(path)
          
          ; Select the icon list entry based on the input.
          
          SelectElement(UM_Database()\UM_Icons(),i-1)
          
          ; Copy the entry into the database default icon entry
          
          UM_Database()\UM_Default_Icon=UM_Database()\UM_Icons()
          
          ; Rename the old images to the new default icon name
          
          path=UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".iff"
          RenameFile(Game_Img_Path+"Screenshots\"+oldpath,Game_Img_Path+"Screenshots\"+path)
          RenameFile(Game_Img_Path+"Covers\"+oldpath,Game_Img_Path+"Covers\"+path)
          RenameFile(Game_Img_Path+"Titles\"+oldpath,Game_Img_Path+"Titles\"+path)
          RenameFile(oldpath,path)
        EndIf
        
        FreeMap(icon_map())
        
      EndIf
    Next
    
    ; Go back through Add List and add / remove entries
    
    ForEach Add_List()
      
      ; If the folder is not found in the database
      
      If Not FindMapElement(Folder_Check(),LCase(Add_List()\add_type+"_"+RemoveString(GetPathPart(Add_List()\add_file),"/"))) 
        
        ; Add a new entry to the main database
        
        AddElement(UM_Database())
        
        ; Add database entries based on previously extracted data and default settings
        
        UM_Database()\UM_Title=Split_On_Capital(RemoveString(GetPathPart(Add_List()\add_file),"/"))
        UM_Database()\UM_Folder=GetPathPart(Add_List()\add_file)
        UM_Database()\UM_Subfolder=Add_List()\add_sub+"/"
        UM_Database()\UM_Path=Main_Path+Add_List()\add_sub+"/"+GetPathPart(Add_List()\add_file)
        UM_Database()\UM_Slave=GetFilePart(Add_List()\add_file)
        UM_Database()\UM_LHAFile=Add_List()\add_arc
        UM_Database()\UM_Genre="Unknown"
        UM_Database()\UM_Favourite=#False
        UM_Database()\UM_Type=Add_List()\add_type
        If UM_Database()\UM_Type="Demo" : UM_Database()\UM_Players="0" : EndIf
        If FindString(Add_List()\add_file,"AGA") : UM_Database()\UM_AGA=#True : EndIf
        If FindString(Add_List()\add_file,"CD32") : UM_Database()\UM_CD32=#True : EndIf
        If UM_Database()\UM_AGA<>#True And UM_Database()\UM_CD32<>#True : UM_Database()\UM_ECSOCS=#True : EndIf
        If FindString(Add_List()\add_file,"NTSC") : UM_Database()\UM_NTSC=#True : EndIf
        If FindString(Add_List()\add_file,"MT32") : UM_Database()\UM_MT32=#True : EndIf
        UM_Database()\UM_Slave_Date=Add_List()\add_date
        CopyList(Add_List()\Icons2(), UM_Database()\UM_Icons())
        
        ; Set default icon for database entry
        
        PrintS()
        PrintN("Choose Default Icon for "+UM_Database()\UM_Title)
        PrintS()
        count=1
        ForEach UM_Database()\UM_Icons()
          PrintN(Str(count)+": "+UM_Database()\UM_Icons())
          count+1
        Next
        PrintN("C: Cancel")
        PrintS()
        Print("Select a number: ")
        path=Input()
        i=Val(path)
        If LCase(path)="c" : Goto CleanUp : EndIf
        
        ; Add default icon based on input
        
        SelectElement(UM_Database()\UM_Icons(),i-1)
        UM_Database()\UM_Default_Icon=UM_Database()\UM_Icons()
      EndIf
      
      Extract_Text_Files_Single(WHD_Folder+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_LHAFile)
      
    Next
  EndIf 
  
  ; Database is now updated!
  
  ;}  
  ;{ 7. Scan Miggy And Update WHD Drive#####################################################################################################################################################################  
  
  EnableGraphicalConsole(1)
  ClearConsole()
  EnableGraphicalConsole(0)
  
  PrintNCol("***************************",6,0)
  PrintNCol("*                         *",6,0)
  PrintNCol("*  Update Amiga Drive...  *",6,0)
  PrintNCol("*                         *",6,0)
  PrintNCol("***************************",6,0)
  PrintS() 
  PrintS()
  PrintNCol("Starting WinUAE...",14,0)
  PrintS()
  
  ; Remove temporary directory if it already exists
  
  If FileSize(WHD_TempDir)=-2 : DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force) : EndIf
  
  ; Create a new temporary directory for DH1:
  
  If CreateDirectory(WHD_TempDir)
    SetCurrentDirectory(WHD_TempDir)
    
    ; Create a text file for WB startup to run
    
    startup_file=CreateFile(#PB_Any,"whd-startup")
    If startup_file
      WriteString(startup_file,"cd WHD-HDD:"+#LF$)
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+"Creating Folders List... Please Wait!"+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+"This could take a few minutes..."+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+"Executing Command: list DIRS ALL LFORMAT %P%N"+#DOUBLEQUOTE$+#LF$)
      
      ; Create a file of directories in the temp folder
      
      WriteString(startup_file,"list dirs all lformat %p%n >DH1:dirs.txt"+#LF$)
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+"Executing Command: list P=#?.slave DATES ALL LFORMAT %P%N¬%D"+#DOUBLEQUOTE$+#LF$)
      
      ; Create a file of slaves and dates in the temp folder
      
      WriteString(startup_file,"list P=#?.slave DATES ALL LFORMAT %P%N¬%D >DH1:slaves.txt"+#LF$)
      
      ; Create a file if the batch file completes
      
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+"Complete"+#DOUBLEQUOTE$+" TO DH1:complete.txt"+#LF$)
      WriteString(startup_file,"c:uaequit")
      FlushFileBuffers(startup_file)
      CloseFile(startup_file)      
    EndIf
    
    ; Run WinUAE with the batch file and wait
    
    startup_prog=RunProgram(WinUAE_Path, "-f "+ConfUM_Path+"Update.uae -s filesystem2=rw,DH1:WHDTemp:"+WHD_TempDir+",0","",#PB_Program_Wait)
    
    ; If the complete.txt file doesn't exist, go to exit.
    
    If FileSize("complete.txt")<=0 
      DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
      PrintNCol("WinUAE Error!",4,0)
      PrintS()
      Delay(2000)
      Goto CleanUp
    EndIf
    
    ; Remove dirs.txt and slaves.txt if they exist in the home folder
    
    If FileSize(home_path+"dirs.txt")>0 : DeleteFile(home_path+"dirs.txt") : EndIf
    If FileSize(home_path+"slaves.txt")>0 : DeleteFile(home_path+"slaves.txt") : EndIf
    
    ; Copy the new files into the home folder
    
    CopyFile("dirs.txt",home_path+"dirs.txt")
    CopyFile("slaves.txt",home_path+"slaves.txt")
    SetCurrentDirectory(home_path)
    
    ; Remove the temporary folder
    
    DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
  EndIf
  
  ; Copy path details and database element number on pc to map for comparison
  
  ForEach UM_Database() 
    path=LCase(UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+UM_Database()\UM_Folder)
    PC_Map(path)=ListIndex(UM_Database())
  Next
  
  ; Copy the path details into PC List for processing and sort
  
  ForEach PC_Map()
    AddElement(PC_List())
    PC_List()=MapKey(PC_Map())
  Next
  
  SortList(PC_List(),#PB_Sort_Ascending)
  
  ; Read the directories extracted from the Amiga drive into Miggy List.
  
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
    
    ; Remove the dirs.txt file as it is no longer needed
    
    DeleteFile(Home_Path+"dirs.txt")
    
    SortList(Miggy_List(),#PB_Sort_Ascending)
    
    ; Copy the Amiga directories into a new map for comparison.
    
    ForEach Miggy_List()
      Miggy_Map(Miggy_List())=Miggy_List()  
    Next
    
  EndIf 
  
  ; Create list on not needed directories on the Amiga drive called Delete List.
  
  ForEach Miggy_Map()
    If Not FindMapElement(PC_Map(),MapKey(Miggy_Map())) ; If the entry isn't in the map, add it to Delete List
      AddElement(Delete_List())
      Delete_List()="WHD-HDD:"+MapKey(Miggy_Map()) ; Directory on Amiga drive to be removed
    EndIf
  Next 
  
  ; Open slaves.txt file and extract it's name and date for comparison
  
  cd_file=ReadFile(#PB_Any,Home_Path+"slaves.txt")
  
  If cd_file
    While Not Eof(cd_file)
      output=ReadString(cd_file)
      Miggy_Comp_Map(LCase(StringField(output,1,"¬")))=StringField(output,2,"¬")   
    Wend
  EndIf
  
  CloseFile(cd_file)
  
  ; Remove slaves.txt as it is no longer needed
  
  DeleteFile(Home_Path+"slaves.txt")
  
  ; Remove data from Copy List, ready for new data
  
  ClearList(Copy_List())
  
  ; Scan through database to find new entries to copy
  
  ForEach UM_Database()      
    path2=UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+UM_Database()\UM_Folder+"/"+UM_Database()\UM_Slave
    If FindMapElement(Miggy_Comp_Map(),LCase(path2)) ; Check if the entry is found in the Amiga drive comparison map.
      If Miggy_Comp_Map()<>UM_Database()\UM_Slave_Date ; If the date of the Amiga slave is different to the database, add the archive to the copy list.
        AddElement(Copy_List())
        Copy_List()\c_number=ListIndex(UM_Database())      ; Index of main database
        Copy_List()\c_olddate=Miggy_Comp_Map()             ; old slave date
        Copy_List()\c_newdate=UM_Database()\UM_Slave_Date  ; new slave date
      EndIf
    EndIf
    If Not FindMapElement(Miggy_Comp_Map(),LCase(path2))   ; Check if the entry is not found in the Amiga drive comparison map.
        AddElement(Copy_List())
        Copy_List()\c_number=ListIndex(UM_Database())      ; Index of main database
        Copy_List()\c_olddate=""           ; old slave date
        Copy_List()\c_newdate=""  ; new slave date
      EndIf
  Next
  
  If ListSize(Copy_List())>0  
    
    ; Scan through Copy List and output the changes that will be made.
    
    ForEach Copy_List()        
      SelectElement(UM_Database(),Copy_List()\c_number)             
      PrintS()
      If Copy_List()\c_olddate<>""
        Print("Update Available: "+UM_Database()\UM_Title+Title_Extras())
        ConsoleColor(4,0)
        Print(" Old Slave Date: "+Copy_List()\c_olddate)
        PrintNCol(" New Slave Date: "+Copy_List()\c_newdate,2,0)
      Else
        PrintNCol("New Software: "+UM_Database()\UM_Title+Title_Extras(),2,0)
      EndIf
    Next   
    
    ; Select which type of update is to be processed.
    
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
  Else
    PrintS()
    PrintN("Nothing To Copy...")
    PrintS()
    Delay(2000)
    If ListSize(Delete_List())=0 : Goto CleanUp : EndIf
    exit=#False
  EndIf
  
  ; If a valid entry is made check that it's OK to continue
  
  If Not exit
    PrintNCol(#LF$+"WARNING!WARNING!WARNING!"+#LF$,4,0)
    PrintNCol("You are about to make changes to the Amiga drive! Continue (Y/N)?",15,0)
    Repeat : path=Inkey() :  Until path="Y" Or path="y" Or path="N" Or path="n"
    PrintS()
    
    If path="y" Or path="Y"
      
      ; If the answer is yes, continue.
      
      PrintNCol("Starting WinUAE...",14,0)
      PrintS()
      
      ; Create the batch file that the Amiga will use to update it's drive
      
      If ListSize(Copy_List())>0
        
        output=""
        
        output+"echo "+#DOUBLEQUOTE$+"Copying IGame Data Files..."+#DOUBLEQUOTE$+#LF$
        output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
        
        ; Copy IGame data from temp folder to WHD Drive.
        
        output+"copy DH1:gameslist.csv TO WHD-HDD:"+#LF$
        output+"copy DH1:genres TO WHD-HDD:"+#LF$
        
      EndIf
      
      If ListSize(Delete_List())>0
        
        output+"echo "+#DOUBLEQUOTE$+"Deleting Unneeded Directories..."+#DOUBLEQUOTE$+#LF$
        output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
        
        ; Create list of files to be deleted based on the Delete List.
        
        ForEach Delete_List()
          output+"delete "+Delete_List()+" ALL"+#LF$
        Next
        
      EndIf
      
      If ListSize(Copy_List())>0
        
        If path2="F" Or path2="f"
          
          output+"echo "+#DOUBLEQUOTE$+"Deleting Old Directories..."+#DOUBLEQUOTE$+#LF$
          output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
          
          ; If the Full option is selected, add list of directories to be deleted to script based on the Copy List.
          
          ForEach Copy_List()
            SelectElement(UM_Database(),Copy_List()\c_number)
            output+"delete WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+UM_Database()\UM_Folder+" ALL"+#LF$
            output+"delete WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+UM_Database()\UM_Folder+".info"+#LF$
          Next
          
        EndIf
        
        output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
        output+"echo "+#DOUBLEQUOTE$+"Extracting New Archives..."+#DOUBLEQUOTE$+#LF$
        output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
        
        ; Wait For Disk To Finish before starting archive extraction.
        
        output+"wait 2 SECS"+#LF$
        
        ; Add unarchive commands based on the Copy List.
        
        ForEach Copy_List()
          SelectElement(UM_Database(),Copy_List()\c_number)
          output+"cd WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+#LF$
          If GetExtensionPart(UM_Database()\UM_LHAFile)="lha"
            output+"lha -m x DH1:"+Str(ListIndex(Copy_List()))+".lha"+#LF$
          EndIf
          If GetExtensionPart(UM_Database()\UM_LHAFile)="lzx"
            output+"xadunfile FROM DH1:"+Str(ListIndex(Copy_List()))+".lzx DEST WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+" OW VERBOSE"+#LF$
          EndIf
        Next
      EndIf
      output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
      output+"ask "+#DOUBLEQUOTE$+"Press A Key to Close WinUAE..."+#DOUBLEQUOTE$+#LF$
      
      ; Quit WinUAE
      
      output+"c:uaequit"+#LF$
      
      ; Check if temporary folder exists and delete if necessary.
      
      If FileSize(WHD_TempDir)=-2 : DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force) : EndIf
      
      Protected result.i        
      
      ; Create a new temporary directory for DH1:
      
      If CreateDirectory(WHD_TempDir)
        SetCurrentDirectory(WHD_TempDir)
        
        ; Create a new IGame games list based on the current database.
        
        Save_GL_CSV(WHD_TempDir+"\gameslist.csv")            
        Delay(50)
        
        ; Copy genres data to temp folder
        
        CopyFile(Data_Path+"um_genres.dat",WHD_TempDir+"\genres")
        Delay(50)
        
        ; Create the startup script
        
        startup_file=CreateFile(#PB_Any,"whd-startup")
        
        If startup_file
          
          ; Write the output script to the batch file
          
          WriteString(startup_file,output)
          
          ; copy the required archive into the temporary folder and name as 1.lha,2.lha... to remove extraction name problems
          
          ForEach Copy_List()
            SelectElement(UM_Database(),Copy_List()\c_number)
            path=ReplaceString(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+UM_Database()\UM_LHAFile,"/","\")
            If GetExtensionPart(UM_Database()\UM_LHAFile)="lha"
              result=CopyFile(path,Str(ListIndex(Copy_List()))+".lha")
              Delay(100)
              Continue
            EndIf
            If GetExtensionPart(UM_Database()\UM_LHAFile)="lzx"
              result=CopyFile(path,Str(ListIndex(Copy_List()))+".lzx")
              Delay(100)
              Continue
            EndIf                
          Next
          
          ; Make sure that all copy / file creation processes have finished.
          
          FlushFileBuffers(startup_file)
          
          CloseFile(startup_file) 
          
          ; Run WinUAE with the temporary folder as DH1: and wait until it finishes
          
          startup_prog=RunProgram(WinUAE_Path, "-f "+ConfUM_Path+"Update.uae -s filesystem2=rw,DH1:WHDTemp:"+WHD_TempDir+",0","",#PB_Program_Wait) 
          
        EndIf
        
        SetCurrentDirectory(home_path)
        
        ; Delete the temporary folder
        
        DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
      EndIf
    EndIf
  EndIf;}  
  ;{ 8. Clean up the PC Drive ##############################################################################################################################################################################
  
  PrintS()
  PrintNCol("Cleaning Up Database...",9,0)
  
  ForEach UM_Database()
    
    ; Remove any folders that are no longer needed after update.
    
    If FileSize(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+UM_Database()\UM_LHAFile)=-1
      PrintN(UM_Database()\UM_Title+" is no longer required. Delete (Y/N/C)?")
      Repeat : path2=Inkey() :  Until path2="Y" Or path2="y" Or path2="N" Or path2="n" Or path2="C" Or path2="c"
      If path2="y" Or path2="Y"
        ConsoleColor(4,0)
        PrintN("Deleting Database Entry For "+UM_Database()\UM_Title)
        
        ; Delete selected database entry
        
        DeleteElement(UM_Database())
        
        ; Delete associated images
        
        If MessageRequester("Warning!", "Remove Associated Images?",#PB_MessageRequester_YesNo)=#PB_MessageRequester_Yes
          DeleteDirectory(Game_Img_Path+"Screenshots\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\","*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
          DeleteDirectory(Game_Img_Path+"Covers\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\","*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
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
  Next;}
  
  ; Save the new database and update the games list
   
  Save_DB()

  Reset_Filter()
  Draw_List()  
  Draw_Info(List_Numbers())
  
  ; On error go to here!
  
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

;- ######################

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

Procedure Round_Image(imagenum.i)
    
  Protected w=ImageWidth(imagenum)
  Protected h=ImageHeight(imagenum)
  
  If CreateImage(#ALPHA_MASK, w, h, 32, #PB_Image_Transparent)
    If StartDrawing(ImageOutput(#ALPHA_MASK))
      DrawingMode(#PB_2DDrawing_AlphaChannel)
      RoundBox(0, 0, w, h,8,8, RGBA(0, 0, 0, 255))
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
  
EndProcedure

Procedure Make_PD_Disk(out_path.s="")
  
  ;253x178
  
  Protected text_x.i, aga.s
  
  If UM_Database()\UM_Type="Demo"
    
    If out_path=""
      path=Game_Img_Path+"Covers\Demo\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"   
      CreateDirectory(Game_Img_Path+"Covers\Demo\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\"))
      CreateDirectory(Game_Img_Path+"Covers\Demo\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder)
      SetCurrentDirectory(path)
    Else
      path=out_path+"Covers\Demo\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\" 
      CreateDirectory(out_path+"Covers\")
      CreateDirectory(out_path+"Covers\Demo\")
      CreateDirectory(out_path+"Covers\Demo\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\"))
      CreateDirectory(out_path+"Covers\Demo\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder)
      SetCurrentDirectory(path)
    EndIf
    
    LoadImage(#BACK_IMAGE,Game_Img_Path+"Titles\Demo\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png")      
    ResizeImage(#BACK_IMAGE,505,354)
    Round_Image(#BACK_IMAGE)
    
    LoadImage(#PREVIEW_IMAGE,Game_Img_Path+"floppydisk.png")
    CreateImage(#TEMP_IMAGE,640,824,32)
    CopyImage(#PREVIEW_IMAGE,#TEMP_IMAGE)
    
    StartDrawing(ImageOutput(#TEMP_IMAGE))
    DrawingMode(#PB_2DDrawing_AlphaBlend)
    DrawAlphaImage(ImageID(#BACK_IMAGE),65,348,72)
    DrawingFont(FontID(#HEADER_FONT))
    text_x=(ImageWidth(#TEMP_IMAGE)-TextWidth("Public Domain Disk"))/2
    DrawText(text_x,360,"Public Domain Disk",RGBA(0,0,0,255),RGBA(0,0,0,0))
    DrawingFont(FontID(#PREVIEW_FONT))
    If UM_Database()\UM_AGA=#True : aga=" (AGA)" : Else : aga="" : EndIf
    text_x=(ImageWidth(#TEMP_IMAGE)-TextWidth(UM_Database()\UM_Title+aga))/2
    DrawText(text_x,470,UM_Database()\UM_Title+aga,RGBA(0,0,0,255),RGBA(0,0,0,0))
    text_x=(ImageWidth(#TEMP_IMAGE)-TextWidth("By"))/2
    DrawText(text_x,530,"By",RGBA(0,0,0,255),RGBA(0,0,0,0))
    If TextWidth(UM_Database()\UM_Publisher)>177
      DrawingFont(FontID(#SMALL_FONT))
    EndIf
    text_x=(ImageWidth(#TEMP_IMAGE)-TextWidth(UM_Database()\UM_Publisher))/2
    DrawText(text_x,590,UM_Database()\UM_Publisher,RGBA(0,0,0,255),RGBA(0,0,0,0))
    StopDrawing()

    SaveImage(#TEMP_IMAGE,GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png",#PB_ImagePlugin_PNG)
    
    FreeImage(#PREVIEW_IMAGE)
    FreeImage(#TEMP_IMAGE)
    FreeImage(#BACK_IMAGE)
    
    If out_path=""
      Draw_Info(List_Numbers())
    EndIf
    
  EndIf
  
EndProcedure

Procedure Make_PD_Disk_Set()
  
  Protected oldgadgetlist.i, text_x.i, result.i, path2.s, old_pos.i, aga.s, pd_path.s
  
  pd_path=PathRequester("Test","")
  
  If pd_path<>""
    
    old_pos=GetGadgetState(#MAIN_LIST) 
      
    OpenConsole("Create PD Images")
    
    ForEach UM_Database()
      If UM_Database()\UM_Type="Demo" : PrintN("Processing: "+UM_Database()\UM_Title) : EndIf
      Make_PD_Disk(pd_path)
    Next
    
    SetCurrentDirectory(Home_Path)
    
    CloseConsole()
    
    SetGadgetState(#MAIN_LIST,old_pos)
    SelectElement(List_Numbers(),old_pos)
    SelectElement(UM_Database(),List_Numbers())
    Draw_Info(List_Numbers())
    
  EndIf
  
EndProcedure

Procedure Make_CLRMame_Dats(clr_path.s,clr_title.s, clr_sub.b)
  
  UseCRC32Fingerprint()
  
  Protected NewList CLR_List.s()
  Protected NewList CLR_Beta.s()
  Protected NewList CLR_Game.s()
  Protected NewList CLR_Demo.s()
  Protected mainNode, item, mainitem, response.s, old_title.s, subfolder.s, text_info, progress_bar, old_gadget_list
  
  List_Files_Recursive(clr_path,CLR_List(),"*.*")
  
  old_title=GetWindowTitle(#MAIN_WINDOW)
  SetWindowTitle(#MAIN_WINDOW,"Creating DAT's")
  
  If CreateXML(#DAT_XML)
    
    mainnode=CreateXMLNode(RootXMLNode(#DAT_XML),"datafile")
    
    mainitem=CreateXMLNode(mainNode,"header")
    item=CreateXMLNode(mainitem,"name")
    SetXMLNodeText(item,clr_title)
    item=CreateXMLNode(mainitem,"description")
    SetXMLNodeText(item,"WHDLoad Images")
    item=CreateXMLNode(mainitem,"category")
    SetXMLNodeText(item,"Standard DatFile")
    item=CreateXMLNode(mainitem,"version")
    SetXMLNodeText(item,"0.5")
    item=CreateXMLNode(mainitem,"date")
    SetXMLNodeText(item,FormatDate("%mm/%dd/%yyyy", Date()))
    item=CreateXMLNode(mainitem,"author")
    SetXMLNodeText(item,"MrV2k")
    item=CreateXMLNode(mainitem,"email")
    SetXMLNodeText(item,"-none-")
    item=CreateXMLNode(mainitem,"homepage")
    SetXMLNodeText(item,"EasyEmu")
    item=CreateXMLNode(mainitem,"url")
    SetXMLNodeText(item,"https://easyemu.mameworld.info")
    item=CreateXMLNode(mainitem,"comment")
    SetXMLNodeText(item,"Created By UltraMiggy")
    item=CreateXMLNode(mainitem,"clrmamepro")
    
    ForEach CLR_List()
      If FindString(CLR_List(),"\Beta\")
        AddElement(CLR_Beta())
        CLR_Beta()=CLR_List()
      EndIf
      If FindString(CLR_List(),"\Demo\")
        AddElement(CLR_Demo())
        CLR_Demo()=CLR_List()
      EndIf
      If FindString(CLR_List(),"\Game\")
        AddElement(CLR_Game())
        CLR_Game()=CLR_List()
      EndIf
    Next
    
    OpenWindow(#PROGRESS_WINDOW,0,0,302,62,"Creating Dat Files...",#PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
    StickyWindow(#PROGRESS_WINDOW,#True)
    old_gadget_list=UseGadgetList(WindowID(#PROGRESS_WINDOW))
    text_info=TextGadget(#PB_Any, 4,8,200,20,"Processing config files...") 
    progress_bar=ProgressBarGadget(#PB_Any,4,30,294,26,0,ListSize(CLR_Beta())+ListSize(CLR_Demo())+ListSize(CLR_Game()))
    
    count=0
    
    mainitem=CreateXMLNode(mainNode,"machine")
    SetXMLAttribute(mainitem,"name","Beta")
    item=CreateXMLNode(mainitem,"description")
    SetXMLNodeText(item,"Beta")
    ForEach CLR_Beta()
      SetGadgetState(progress_bar,count)
      SetGadgetText(text_info,"Processing: "+GetFilePart(CLR_Beta()))
      Window_Update()
      i=CountString(CLR_Beta(),"\")
      item=CreateXMLNode(mainitem,"rom")
      If clr_sub : subfolder=StringField(CLR_Beta(),i-1,"\")+"\"+StringField(CLR_Beta(),i,"\")+"\" : Else : subfolder="" : EndIf
      SetXMLAttribute(item,"name",subfolder+StringField(CLR_Beta(),i+1,"\"))
      path=CLR_Beta()
      SetXMLAttribute(item,"size",Str(FileSize(path)))
      SetXMLAttribute(item,"crc",FileFingerprint(path,#PB_Cipher_CRC32))
      count+1
    Next
    
    mainitem=CreateXMLNode(mainNode,"machine")
    SetXMLAttribute(mainitem,"name","Demo")
    item=CreateXMLNode(mainitem,"description")
    SetXMLNodeText(item,"Demo")
    ForEach CLR_Demo()
      SetGadgetState(progress_bar,count)
      SetGadgetText(text_info,"Processing: "+GetFilePart(CLR_Demo()))
      Window_Update()
      i=CountString(CLR_Demo(),"\")
      item=CreateXMLNode(mainitem,"rom")
      If clr_sub : subfolder=StringField(CLR_Demo(),i-1,"\")+"\"+StringField(CLR_Demo(),i,"\")+"\" : Else : subfolder="" : EndIf
      SetXMLAttribute(item,"name",subfolder+StringField(CLR_Demo(),i+1,"\"))
      path=CLR_Demo()
      SetXMLAttribute(item,"size",Str(FileSize(path)))
      SetXMLAttribute(item,"crc",FileFingerprint(path,#PB_Cipher_CRC32))
      count+1
    Next
    
    mainitem=CreateXMLNode(mainNode,"machine")
    SetXMLAttribute(mainitem,"name","Game")
    item=CreateXMLNode(mainitem,"description")
    SetXMLNodeText(item,"Game")
    ForEach CLR_Game()
      SetGadgetState(progress_bar,count)
      SetGadgetText(text_info,"Processing: "+GetFilePart(CLR_Game()))
      Window_Update()
      i=CountString(CLR_Game(),"\")
      item=CreateXMLNode(mainitem,"rom")
      If clr_sub : subfolder=StringField(CLR_Game(),i-1,"\")+"\"+StringField(CLR_Game(),i,"\")+"\" : Else : subfolder="" : EndIf
      SetXMLAttribute(item,"name",subfolder+StringField(CLR_Game(),i+1,"\"))
      path=CLR_Game()
      SetXMLAttribute(item,"size",Str(FileSize(path)))
      SetXMLAttribute(item,"crc",FileFingerprint(path,#PB_Cipher_CRC32))
      count+1
    Next
    
    FormatXML(#DAT_XML,#PB_XML_WindowsNewline|#PB_XML_ReFormat,4)
    
    SaveXML(#DAT_XML,Main_Path+"test.xml")
    
    FreeList(CLR_Beta())
    FreeList(CLR_Game())
    FreeList(CLR_Demo())
    FreeList(CLR_List())
    
  EndIf  
  
  CloseWindow(#PROGRESS_WINDOW)
  
  SetWindowTitle(#MAIN_WINDOW,old_title)
  
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
  List_Files_Recursive(Game_Img_Path+"Titles\",File_List(),"")      ; Create Archive List
  List_Files_Recursive(Game_Img_Path+"Covers\",File_List(),"")      ; Create Archive List
  
  ForEach UM_Database()
    path=Game_Img_Path+"Screenshots\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
    DB_Map(LCase(path))=path
    path=Game_Img_Path+"Covers\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
    DB_Map(LCase(path))=path
    path=Game_Img_Path+"Titles\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
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

Procedure Backup_Images()
  
  Protected path2.s, result.i
  
  path=PathRequester("Output Path",Game_Img_Path)
  
  CreateDirectory(path+"Covers\")
  CreateDirectory(path+"Covers\"+UM_Database()\UM_Type)
  CreateDirectory(path+"Covers\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\"))
  CreateDirectory(path+"Covers\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder)
  path2=path+"Covers\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder
  result=CopyFile(Game_Img_Path+"Covers\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png",path2+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png")
  
  CreateDirectory(path+"Screenshots\")
  CreateDirectory(path+"Screenshots\"+UM_Database()\UM_Type)
  CreateDirectory(path+"Screenshots\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\"))
  CreateDirectory(path+"Screenshots\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder)
  path2=path+"Screenshots\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder
  result=CopyFile(Game_Img_Path+"Screenshots\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png",path2+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png")
  
  CreateDirectory(path+"Titles\")
  CreateDirectory(path+"Titles\"+UM_Database()\UM_Type)
  CreateDirectory(path+"Titles\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\"))
  CreateDirectory(path+"Titles\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder)
  path2=path+"Titles\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder
  result=CopyFile(Game_Img_Path+"Titles\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png",path2+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png")
  
EndProcedure

Procedure Batch_Archive_Folders(folder.s)
  
  Protected NewList folders.s()
  
  ExamineDirectory(0,folder,"")
  While NextDirectoryEntry(0)
    If DirectoryEntryType(0)=#PB_DirectoryEntry_Directory
      Select DirectoryEntryName(0)
        Case ".",".."
          Continue
        Default
          AddElement(folders())
          folders()=DirectoryEntryName(0)
      EndSelect
    EndIf
  Wend
  
  OpenConsole()
  
  CopyFile(IZARC_Path,folder+"izarcc.exe")
  
  ForEach folders()
    path=" -a -r -p "+StringField(folders(),1,"\")+".lha "+folders()
    RunProgram("izarcc",path,folder,#PB_Program_Wait)
  Next
  
  Pause_Console()
  
  DeleteFile(folder+"izarcc.exe")
  
  CloseConsole()
  
  FreeList(folders())
  
EndProcedure

Procedure Archive_Folder(folder.s)
  
  Protected file_name.s, parent.s
  
  parent=folder
  parent=Left(parent,Len(parent) - 1)
  parent=GetPathPart(parent)
  
  CopyFile(IZARC_Path,parent+"izarcc.exe")
  
  file_name=StringField(folder,CountString(folder,"\"),"\")
  
  path=" -a -r -p "+file_name+".lha "+file_name
  
  RunProgram("izarcc",path,parent,#PB_Program_Wait)
  
  DeleteFile(parent+"izarcc.exe")
  
EndProcedure

Procedure Create_IFF_Folders()
  
  Protected source_folder$, dest_folder$, source_file$, new_file$, title$, result.i, response.s, text_info.i, progress_bar.i, progress_window.i, old_gadget_list.i
  Protected Thread1,Thread2,Thread3,Thread4,Thread5,Thread6,Thread7,Thread8
  
  Protected Delay_Time=20
  
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
      PrintS()
      If LCase(response)<>"c"
        ForEach UM_Database() 
          ;Mutex=CreateMutex()
          PrintN("Processing: "+UM_Database()\UM_Title+Title_Extras()+" ("+Str(ListIndex(UM_Database())+1)+" of "+Str(ListSize(UM_Database()))+")")
          If response="1" Or response="5"
            source_file$=#DOUBLEQUOTE$+source_folder$+"Covers\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Covers_ECS_Laced\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -resize 160 206 -rtype mitchell -floyd -colours 16 "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread1=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)         
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Covers_AGA_Laced\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -resize 160 206 -rtype mitchell -floyd -colours 216 "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread2=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Covers_ECS_LoRes\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -resize 160 104 -rtype mitchell -floyd -colours 16 "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread3=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)  
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Covers_AGA_LoRes\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -resize 160 104 -rtype mitchell -floyd -colours 216 "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread4=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Covers_RTG\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -resize 320 412 -rtype mitchell -floyd -colours 256 "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread5=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
            EndIf
            source_file$=#DOUBLEQUOTE$+source_folder$+"Screenshots\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Screens_ECS_Laced\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -resize 160 128 -rtype quick -floyd -colours 16 "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread1=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)         
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Screens_AGA_Laced\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -resize 160 128 -rtype quick -floyd -colours 216 "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread2=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)              
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Screens_ECS_LoRes\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -resize 160 64 -rtype quick -floyd -colours 16 "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread3=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)                
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Screens_AGA_LoRes\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -resize 160 64 -rtype quick -floyd -colours 216 "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread4=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)              
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Screens_RTG\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -colours 256 "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread5=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
            EndIf
            source_file$=#DOUBLEQUOTE$+source_folder$+"Titles\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Titles_ECS_Laced\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -resize 160 128 -rtype quick -floyd -colours 16 "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread5=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)       
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Titles_AGA_Laced\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -resize 160 128 -rtype quick -floyd -colours 216 "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread2=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Titles_ECS_LoRes\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -resize 160 64 -rtype quick -floyd -colours 16 "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread3=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)  
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Titles_AGA_LoRes\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -resize 160 64 -rtype quick -floyd -colours 216 "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread4=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Titles_RTG\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -colours 256 "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread5=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
            EndIf
          EndIf
          
          If response="2" Or response="5"
            source_file$=#DOUBLEQUOTE$+source_folder$+"Covers\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Covers_ECS_LoRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -resize 320 128 -rtype mitchell -colors 16 -floyd "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread1=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Covers_AGA_LoRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -resize 320 128 -rtype mitchell -colors 216 -floyd "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread2=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Covers_ECS_HiRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -ratio -resize 640 400 -rtype mitchell -canvas 640 400 center -colors 16 -floyd "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread3=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Covers_AGA_HiRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -ratio -resize 640 400 -rtype mitchell -canvas 640 400 center -colors 216 -floyd "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread4=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
            EndIf
            source_file$=#DOUBLEQUOTE$+source_folder$+"Screenshots\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Screens_ECS_LoRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -resize 320 128 -rtype quick -colors 16 -floyd "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread1=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Screens_AGA_LoRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -resize 320 128 -rtype quick -colors 216 -floyd "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread2=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Screens_ECS_HiRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -ratio -resize 640 400 -rtype quick -canvas 640 400 center -colors 16 -floyd "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread3=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Screens_AGA_HiRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -ratio -resize 640 400 -rtype quick -canvas 640 400 center -colors 216 -floyd "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread4=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
            EndIf
            source_file$=#DOUBLEQUOTE$+source_folder$+"Titles\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Titles_ECS_LoRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -resize 320 128 -rtype quick -colors 16 -floyd "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread1=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Titles_AGA_LoRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -resize 320 128 -rtype quick -colors 216 -floyd "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread2=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Titles_ECS_HiRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -ratio -resize 640 400 -rtype quick -canvas 640 400 center -colors 16 -floyd "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread3=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
              new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Titles_AGA_HiRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -ratio -resize 640 400 -rtype quick -canvas 640 400 center -colors 216 -floyd "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread4=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
            EndIf
          EndIf
          
          If response="3" Or response="5"
            source_file$=#DOUBLEQUOTE$+source_folder$+"Covers\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"TinyLauncher\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+"_SCR1.iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -ratio -resize 640 400 -rtype mitchell -canvas 640 400 center -colors 16 -floyd "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread1=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
            EndIf
            source_file$=#DOUBLEQUOTE$+source_folder$+"Screenshots\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"TinyLauncher\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+"_SCR0.iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -colors 32 -floyd "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread2=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
            EndIf
            source_file$=#DOUBLEQUOTE$+source_folder$+"Titles\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"TinyLauncher\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+"_SCR2.iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 -colors 32 -floyd "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread3=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
            EndIf
          EndIf
          
          If response="4"  Or response="5"
            source_file$=#DOUBLEQUOTE$+source_folder$+"Covers\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"PNG_Images\Covers\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
              path="-quiet -out png -o "+new_file$+" "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread1=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
            EndIf
            source_file$=#DOUBLEQUOTE$+source_folder$+"Screenshots\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"PNG_Images\Screens\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
              path="-quiet -out png -o "+new_file$+" "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread2=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
            EndIf
            source_file$=#DOUBLEQUOTE$+source_folder$+"Titles\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"PNG_Images\Titles\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
              path="-quiet -out png -o "+new_file$+" "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread3=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
            EndIf 
          EndIf 
          
          If response="6"
            source_file$=#DOUBLEQUOTE$+source_folder$+"Covers\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IFF_Covers\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread1=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
            EndIf
            source_file$=#DOUBLEQUOTE$+source_folder$+"Screenshots\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IFF_Screens\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread2=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
            EndIf
            source_file$=#DOUBLEQUOTE$+source_folder$+"Titles\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
            If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
              new_file$=#DOUBLEQUOTE$+dest_folder$+"IFF_Titles\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
              path="-quiet -out iff -o "+new_file$+" -c 1 "+source_file$
              RunProgram(nconvert_path,path,"",#PB_Program_Wait)
              ;Thread3=CreateThread(@Run_Thread(),@path)
              ;Delay(Delay_Time)
            EndIf 
          EndIf
;           WaitThread(1)
;           WaitThread(2)
;           WaitThread(3)
;           WaitThread(4)
;           WaitThread(5)
        Next
      EndIf
      CloseConsole()
    EndIf
  EndIf
  
  SetCurrentDirectory(Home_Path)
  
EndProcedure

Procedure Check_Missing_Images(type.i)
  
  Protected path2.s
  
  ForEach UM_Database()  
    UM_Database()\UM_Image_Avail=#False
    UM_Database()\UM_Cover_Avail=#False
    
    If type=1
      path=Game_Img_Path+"Screenshots\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
      If FileSize(path)>0
        UM_Database()\UM_Image_Avail=#True
      Else
        UM_Database()\UM_Image_Avail=#False
      EndIf
    EndIf
    
    If type=2
      path2=Game_Img_Path+"Covers\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
      If FileSize(path2)>0
        UM_Database()\UM_Cover_Avail=#True
      Else
        UM_Database()\UM_Cover_Avail=#False
      EndIf
    EndIf
    
    If type=3
      path=Game_Img_Path+"Titles\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
      If FileSize(path)>0
        UM_Database()\UM_Title_Avail=#True
      Else
        UM_Database()\UM_Title_Avail=#False
      EndIf
    EndIf
    
  Next
  
EndProcedure

Procedure Image_Popup(type.i)
  
  Protected popup_imagegadget, pevent, popup_image, ww.i, wh.i, Smooth, old_gadget_list
  
  If GetGadgetState(#MAIN_LIST)>-1
    
    If IFF_Smooth : Smooth=#PB_Image_Smooth : Else : Smooth=#PB_Image_Raw : EndIf
    
    SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
    SelectElement(UM_Database(),List_Numbers())
    
    DisableWindow(#MAIN_WINDOW,#True)
    
    If GetGadgetState(#MAIN_PANEL)=0
      If type=1
        path=Game_Img_Path+"Titles\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
        ww=640 : wh=512
      EndIf
      
      If type=2
        path=Game_Img_Path+"Screenshots\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
        ww=640 : wh=512
      EndIf
      
      If type=3
        path=Game_Img_Path+"Covers\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
        ww=640 : wh=824
      EndIf
    EndIf
    
    If GetGadgetState(#MAIN_PANEL)=1
      If type=1
        path=Game_Img_Path+"CD32\Titles\"+CD32_Database()\CD_Title+".png"
        ww=640 : wh=512
      EndIf
      
      If type=2
        path=Game_Img_Path+"CD32\Screenshots\"+CD32_Database()\CD_Title+".png"
        ww=640 : wh=512
      EndIf
      
      If type=3
        path=Game_Img_Path+"CD32\Covers\"+CD32_Database()\CD_Title+".png"
        ww=640 : wh=824
      EndIf
      
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
      
      If GetGadgetState(#MAIN_PANEL)=0 : SetActiveGadget(#MAIN_LIST) : EndIf
      If GetGadgetState(#MAIN_PANEL)=1 : SetActiveGadget(CD32_List) : EndIf
      If GetGadgetState(#MAIN_PANEL)=2 : SetActiveGadget(System_List) : EndIf
      
    EndIf
  EndIf

EndProcedure

Procedure Path_Window()
  
  Protected Path_Game_String, Path_Demo_String, Path_Beta_String, Path_LHA_String, Path_LZX_String, Path_Temp_String, Path_UAE_String, Path_Game_Button, Path_Demo_Button
  Protected Path_Beta_Button, Path_LHA_Button, Path_LZX_Button, Path_Temp_Button, Path_UAE_Button, Path_WinUAE_String, Path_WinUAE_Button
  Protected Path_Genres_Button, Path_Genres_String, Path_Database_Button, Path_Database_String, Path_CD32_Button, Path_CD32_String, Path_NConvert_String, Path_NConvert_Button
  Protected Path_Amiga_String, Path_Amiga_Button, Path_IGame_String, Path_IGame_Button, Path_Game_LHA_String, Path_Demo_LHA_String, Path_Beta_LHA_String, Path_Game_LHA_Button, Path_Demo_LHA_Button, Path_Beta_LHA_Button
  Protected old_pos, old_gadget_list, Path_Update_String, Path_Update_Button, Path_IZARC_String, Path_IZARC_Button, Path_Info_String, Path_Info_Button
  Protected change.b=#False
  
  old_pos=GetGadgetState(#MAIN_LIST)
  
  If OpenWindow(#PATH_WINDOW, 0, 0, 490, 340, "UltraMiggy Paths", #PB_Window_SystemMenu|#PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
    
    old_gadget_list=UseGadgetList(WindowID(#PATH_WINDOW))
    
    Path_Game_String = StringGadget(#PB_Any, 130, 10, 300, 20, Game_Img_Path, #PB_String_ReadOnly)
    Path_Game_Button = ButtonGadget(#PB_Any, 440, 10, 40, 20, "Set")
    Path_LHA_String = StringGadget(#PB_Any, 130, 40, 300, 20, LHA_Path, #PB_String_ReadOnly)
    Path_LHA_Button = ButtonGadget(#PB_Any, 440, 40, 40, 20, "Set")
    Path_LZX_String = StringGadget(#PB_Any, 130, 70, 300, 20, LZX_Path, #PB_String_ReadOnly)
    Path_LZX_Button = ButtonGadget(#PB_Any, 440, 70, 40, 20, "Set")
    Path_Temp_String = StringGadget(#PB_Any, 130, 100, 300, 20, WHD_TempDir, #PB_String_ReadOnly)
    Path_Temp_Button = ButtonGadget(#PB_Any, 440, 100, 40, 20, "Set")
    Path_UAE_String = StringGadget(#PB_Any, 130, 130, 300, 20, ConfUM_Path, #PB_String_ReadOnly)
    Path_UAE_Button = ButtonGadget(#PB_Any, 440, 130, 40, 20, "Set")
    Path_WinUAE_String = StringGadget(#PB_Any, 130, 160, 300, 20, WinUAE_Path, #PB_String_ReadOnly)
    Path_WinUAE_Button = ButtonGadget(#PB_Any, 440, 160, 40, 20, "Set")
    Path_Game_LHA_String = StringGadget(#PB_Any, 130, 190, 300, 20, WHD_Folder, #PB_String_ReadOnly)
    Path_Game_LHA_Button = ButtonGadget(#PB_Any, 440, 190, 40, 20, "Set")
    Path_Genres_String = StringGadget(#PB_Any, 130, 220, 300, 20, Data_Path, #PB_String_ReadOnly)
    Path_Genres_Button = ButtonGadget(#PB_Any, 440, 220, 40, 20, "Set")
    Path_NConvert_String = StringGadget(#PB_Any, 130, 250, 300, 20, NConvert_Path, #PB_String_ReadOnly)
    Path_NConvert_Button = ButtonGadget(#PB_Any, 440, 250, 40, 20, "Set")
    Path_IZARC_String = StringGadget(#PB_Any, 130, 280, 300, 20, IZARC_Path, #PB_String_ReadOnly)
    Path_IZARC_Button = ButtonGadget(#PB_Any, 440, 280, 40, 20, "Set")
    Path_Info_String = StringGadget(#PB_Any, 130, 310, 300, 20, Game_Info_Path, #PB_String_ReadOnly)
    Path_Info_Button = ButtonGadget(#PB_Any, 440, 310, 40, 20, "Set")
    
    TextGadget(#PB_Any, 10,  12, 110, 20, "Game Image Folder", #PB_Text_Right)
    TextGadget(#PB_Any, 10,  42, 110, 30, "LHA Archiver", #PB_Text_Right)
    TextGadget(#PB_Any, 10,  72, 110, 20, "LZX Archiver", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 102, 110, 20, "Temp Folder", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 132, 110, 20, "Config Path", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 162, 110, 20, "WinUAE Path", #PB_Text_Right) 
    TextGadget(#PB_Any, 10, 192, 110, 20, "WHD Archive Path", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 222, 110, 20, "Data Path", #PB_Text_Right) 
    TextGadget(#PB_Any, 10, 252, 110, 20, "NConvert Path", #PB_Text_Right) 
    TextGadget(#PB_Any, 10, 282, 110, 20, "IZARCC Path", #PB_Text_Right) 
    TextGadget(#PB_Any, 10, 312, 110, 20, "Game Info Path", #PB_Text_Right) 
    
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
              path=PathRequester("Game Info Path",Game_Info_Path)
              If path<>"" : Game_Info_Path=path : SetGadgetText(Path_Info_String,Game_Info_Path) : change=#True : EndIf
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
      UM_Database()\UM_Path=Fix_List()\F_Path
      UM_Database()\UM_Slave=Fix_List()\F_Slave
      UM_Database()\UM_Slave_Date=Fix_List()\F_Slave_Date
      UM_Database()\UM_MT32=Fix_List()\F_MT32
      UM_Database()\UM_NoSound=Fix_List()\F_NoSound
      UM_Database()\UM_AGA=Fix_List()\F_AGA
      UM_Database()\UM_ECSOCS=Fix_List()\F_ECSOCS
      UM_Database()\UM_Publisher=Fix_List()\F_Publisher
      UM_Database()\UM_Developer=Fix_List()\F_Developer
      UM_Database()\UM_Favourite=Fix_List()\F_Favourite
      UM_Database()\UM_Genre=Fix_List()\F_Genre
      UM_Database()\UM_Preview=Fix_List()\F_Preview
      UM_Database()\UM_Type=Fix_List()\F_Type
      UM_Database()\UM_Intro=Fix_List()\F_Intro
      UM_Database()\UM_CDROM=Fix_List()\F_CDROM
      UM_Database()\UM_Memory=Fix_List()\F_Memory
      UM_Database()\UM_Coverdisk=Fix_List()\F_Coverdisk
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
      ForEach Fix_List()\F_Icons()
        AddElement(UM_Database()\UM_Icons())
        UM_Database()\UM_Icons()=Fix_List()\F_Icons()
      Next
    Next
  EndIf
  
  ClearList(Fix_List())
  
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
    Fix_List()\F_Path=UM_Database()\UM_Path
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
    Fix_List()\F_Preview=UM_Database()\UM_Preview
    Fix_List()\F_Files=UM_Database()\UM_Files
    Fix_List()\F_Image=UM_Database()\UM_Image
    Fix_List()\F_Arcadia=UM_Database()\UM_Arcadia
    Fix_List()\F_Publisher=UM_Database()\UM_Publisher
    Fix_List()\F_Developer=UM_Database()\UM_Developer
    Fix_List()\F_Type=UM_Database()\UM_Type
    Fix_List()\F_Year=UM_Database()\UM_Year
    Fix_List()\F_Players=UM_Database()\UM_Players
    Fix_List()\F_Config=UM_Database()\UM_Config
    ForEach UM_Database()\UM_Icons()
      AddElement(Fix_List()\F_Icons())
      Fix_List()\F_Icons()=UM_Database()\UM_Icons()
    Next
    Fix_List()\F_Default_Icon=UM_Database()\UM_Default_Icon
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

Procedure Load_DB()
  
  Load_Main_DB()
  
EndProcedure

Procedure Save_DB()
  
  Save_Main_DB()
  
EndProcedure

Procedure Save_GL_CSV(path.s)
  
  If path<>""
    
    If GetExtensionPart(path)<>"csv"  
      path+".csv"
    EndIf
    
    Protected igfile3, output$
    
    If CreateFile(igfile3, path,#PB_Ascii)
      ForEach UM_Database()
        output$="0;"
        output$+UM_Database()\UM_Title+Title_Extras()+";"
        output$+UM_Database()\UM_Genre+";"
        output$+"WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+UM_Database()\UM_Folder+"/"+UM_Database()\UM_Slave+";"
        output$+"0;0;0;0"
        WriteString(igfile3,output$+#LF$)
      Next
      
      CloseFile(igfile3)
      
    EndIf
    
  EndIf
  
EndProcedure

Procedure Save_Prefs()
  CreatePreferences(Data_Path+"um.prefs")
  PreferenceGroup("Paths")
  WritePreferenceString("Game_Img_Path",Game_Img_Path)
  WritePreferenceString("Game_Info_Path",Game_Info_Path)
  WritePreferenceString("LHA_Path",LHA_Path)
  WritePreferenceString("IZARC_Path",IZARC_Path)
  WritePreferenceString("LZX_Path",LZX_Path)
  WritePreferenceString("NConvert_Path",NConvert_Path)
  WritePreferenceString("Temp_Path",WHD_TempDir)
  WritePreferenceString("UAECFG_Path",ConfUM_Path)
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
    Game_Info_Path=ReadPreferenceString("Game_Info_Path",Game_Info_Path)
    LHA_Path=ReadPreferenceString("LHA_Path",LHA_Path)
    IZARC_Path=ReadPreferenceString("IZARC_Path",IZARC_Path)
    LZX_Path=ReadPreferenceString("LZX_Path",LZX_Path)
    NConvert_Path=ReadPreferenceString("NConvert_Path",NConvert_Path)
    WHD_TempDir=ReadPreferenceString("Temp_Path",WHD_TempDir)
    ConfUM_Path=ReadPreferenceString("UAECFG_Path",ConfUM_Path)
    WHD_Folder=ReadPreferenceString("WHD_Path",WHD_Folder)
    WinUAE_Path=ReadPreferenceString("WinUAE_Path",WinUAE_Path)
    Data_Path=ReadPreferenceString("Data_Path",Data_Path)
    IFF_Smooth=ReadPreferenceLong("IFF_Smooth",IFF_Smooth)
    JSON_Backup=ReadPreferenceLong("JSON_Backup",JSON_Backup)
    ClosePreferences()
  EndIf
  
EndProcedure

Procedure Choose_Icon()
  
  Protected NewList Icon_List.s()
  
  Protected UM_Program.i, zeros.i
  Protected ReadO$, oldpath.s
  
  path=WHD_Folder+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_LHAFile

  OpenConsole("Scanning : "+UM_Database()\UM_LHAFile)
  If GetExtensionPart(UM_Database()\UM_LHAFile)="lha"
    UM_Program=RunProgram(LHA_Path,"l "+path,GetCurrentDirectory(),#PB_Program_Open|#PB_Program_Read)
  EndIf
  If GetExtensionPart(UM_Database()\UM_LHAFile)="lzx"
    UM_Program=RunProgram(LZX_Path,"-v "+path,GetCurrentDirectory(),#PB_Program_Open|#PB_Program_Read)
  EndIf
  If UM_Program     
    While ProgramRunning(UM_Program)
      If AvailableProgramOutput(UM_Program)            
        ReadO$=ReadProgramString(UM_Program)           
        ReadO$=RemoveString(ReadO$,#DOUBLEQUOTE$)           
        ReadO$=ReplaceString(ReadO$,"\", "/")
        ReadO$=RemoveString(ReadO$,"n/a")
        If FindString(ReadO$,".info",0,#PB_String_NoCase)
          If CountString(ReadO$,"/")<>1 : Continue : EndIf
          zeros=CountString(ReadO$," ")
          path=StringField(ReadO$,zeros+1," ")
          path=StringField(path,2,"/")
          AddElement(Icon_List())
          Icon_List()=path
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
      oldpath=UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
      SelectElement(Icon_List(),i-1)
      UM_Database()\UM_Default_Icon=Icon_List()
      path=UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
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

Procedure Edit_CD32(number) 
  
  SelectElement(CD32_Database(),number)
  
  ClearList(Genre_List.s())
  
  Protected change.b=#False, oldindex.s, star.s, g_file.i
  Protected old_gadget_list, old_pos
  Protected Title_String, Language_String, Archive_String, Coder_String, Genre_Combo, Year_String
  Protected Mouse_Check, Keyboard_Check, ConfUM_Combo, Close_Button, Memory_String, Compilation_Check
  
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
    ConfUM_Combo = ComboBoxGadget(#PB_Any, 224, 232, 88, 24)
    Close_Button = ButtonGadget(#PB_Any, 320, 168, 96, 88, "Close")
    Memory_String = StringGadget(#PB_Any, 224, 200, 88, 24, CD32_Database()\CD_Ram)
    TextGadget(#PB_Any, 168, 202, 50, 20, "Memory", #PB_Text_Right)
    Compilation_Check = CheckBoxGadget(#PB_Any, 24, 232, 96, 20, "Compilation")
    
    AddGadgetItem(ConfUM_Combo,-1,"CD32")
    AddGadgetItem(ConfUM_Combo,-1,"CD32-4MB")
    AddGadgetItem(ConfUM_Combo,-1,"CD32-8MB")
    SetGadgetState(ConfUM_Combo,CD32_Database()\CD_Config)
    
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
            Case ConfUM_Combo
              CD32_Database()\CD_Config=GetGadgetState(ConfUM_Combo)
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
  
  SelectElement(UM_Database(),number)
  
  ClearList(Genre_List.s())
  
  Protected NewList Backup_List.UM_Data()
  
  CopyList(UM_Database(),Backup_List())
  
  Protected change.b=#False, change3.b=#False, oldindex.s, star.s, g_file.i, text$, old_num
  Protected old_gadget_list, old_pos.s, title_string, language_string, path_string, Frame_0, AGA_Check, CD32_Check,  Preview_Check, Files_Check, Image_Check, NoIntro_Check, Date_String, icon_string, icon_button, Close_Button
  Protected CDTV_Check, MT32_Check, Memory_String, Genre_Combo, CDROM_Check, Arcadia_Check, Demo_Check, Intro_Check, Cover_Check, NTSC_Check, Disk_String, Coder_String, Type_Combo, File_Button, Update_Button, ConfUM_Combo
  Protected Year_String, Cancel_Button, Short_String, ECSOCS_Check, Short_Title, Players_String, NoSound_Check, developer_string
  
  old_pos=UM_Database()\UM_Type+"_"+UM_Database()\UM_Slave
  old_num=GetGadgetState(#MAIN_LIST)
  
  DisableWindow(#MAIN_WINDOW,#True)
  
  If OpenWindow(#EDIT_WINDOW, 0, 0, 424, 440, "Edit Database", #PB_Window_SystemMenu | #PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
    
    Pause_Window(#EDIT_WINDOW)
    
    old_gadget_list=UseGadgetList(WindowID(#EDIT_WINDOW))
    
    TextGadget(#PB_Any, 8, 10, 60, 20, "Title", #PB_Text_Center)    
    title_string = StringGadget(#PB_Any, 80, 8, 336, 24, UM_Database()\UM_Title)
    Short_Title=TextGadget(#PB_Any, 8, 42, 60, 20, "Short ("+Str(Len(UM_Database()\UM_Short))+")", #PB_Text_Center)    
    Short_String = StringGadget(#PB_Any, 80, 40, 336, 24, UM_Database()\UM_Short)
    TextGadget(#PB_Any, 8, 74, 60, 20, "Language", #PB_Text_Center)
    language_string = StringGadget(#PB_Any, 80, 72, 336, 24, UM_Database()\UM_Language)
    TextGadget(#PB_Any, 8, 106, 60, 20, "Archive", #PB_Text_Center) 
    path_string = StringGadget(#PB_Any, 80, 104, 336, 24, UM_Database()\UM_LHAFile)
    TextGadget(#PB_Any, 0, 136, 80, 20, "Default Icon", #PB_Text_Center)
    icon_string = StringGadget(#PB_Any, 80, 136, 250, 24, UM_Database()\UM_Default_Icon)
    icon_button = ButtonGadget(#PB_Any, 340, 136, 76, 24, "Choose") 
    TextGadget(#PB_Any, 220, 172, 60, 20, "Developer", #PB_Text_Center)
    developer_string = StringGadget(#PB_Any, 290, 170, 124, 24, UM_Database()\UM_Developer)
    If UM_Database()\UM_Type="Demo"
      TextGadget(#PB_Any, 8, 172, 60, 20, "Group", #PB_Text_Center)
      DisableGadget(developer_string,#True)
    Else
      TextGadget(#PB_Any, 8, 172, 60, 20, "Publisher", #PB_Text_Center)
    EndIf
    coder_string = StringGadget(#PB_Any, 80, 170, 120, 24, UM_Database()\UM_Publisher)

    TextGadget(#PB_Any, 8, 206, 60, 20, "Slave Date", #PB_Text_Center)
    date_string = StringGadget(#PB_Any, 80, 202, 120, 24, UM_Database()\UM_Slave_Date)
    TextGadget(#PB_Any, 220, 206, 70, 20, "Year", #PB_Text_Center)
    year_string = StringGadget(#PB_Any, 290, 202, 126, 24, UM_Database()\UM_Year)
    Frame_0 = FrameGadget(#PB_Any, 8, 224, 408, 148, "")
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
    Memory_String = StringGadget(#PB_Any, 336, 272, 72, 24, UM_Database()\UM_Memory)
    Preview_Check = CheckBoxGadget(#PB_Any, 16, 304, 60, 20, "Preview", #PB_CheckBox_Center)
    ECSOCS_Check = CheckBoxGadget(#PB_Any, 16, 336, 60, 20, "OCSECS", #PB_CheckBox_Center)
    NoSound_Check = CheckBoxGadget(#PB_Any, 88, 336, 60, 20, "No Snd", #PB_CheckBox_Center)
    Files_Check = CheckBoxGadget(#PB_Any, 88, 304, 60, 20, "Files")
    Image_Check = CheckBoxGadget(#PB_Any, 152, 304, 54, 20, "Image")
    Cover_Check = CheckBoxGadget(#PB_Any, 210, 304, 80, 20, "Cover Disk")
    TextGadget(#PB_Any, 296, 306, 36, 20, "Disks", #PB_Text_Right)
    Disk_String = StringGadget(#PB_Any, 336, 304, 72, 24, UM_Database()\UM_Disks)
    TextGadget(#PB_Any, 296, 338, 36, 20, "Players", #PB_Text_Right)
    Players_String = StringGadget(#PB_Any, 336, 336, 72, 24, UM_Database()\UM_Players,#PB_String_Numeric)
    TextGadget(#PB_Any, 10, 378, 46, 20, "Type", #PB_Text_Center)
    Type_Combo = ComboBoxGadget(#PB_Any, 64, 376, 88, 24)
    TextGadget(#PB_Any, 158, 378, 50, 20, "Config", #PB_Text_Center)  
    ConfUM_Combo = ComboBoxGadget(#PB_Any, 212, 376, 124, 24)
    TextGadget(#PB_Any, 8, 410, 60, 20, "Genre", #PB_Text_Center)
    Genre_Combo = ComboBoxGadget(#PB_Any, 80, 408, 256, 24) 
    Cancel_Button = ButtonGadget(#PB_Any, 344, 376, 72, 24, "Cancel")
    Close_Button = ButtonGadget(#PB_Any, 344, 408, 72, 24, "Close")
    
    AddGadgetItem(Type_Combo,-1,"Unknown")
    AddGadgetItem(Type_Combo,-1,"Game")
    AddGadgetItem(Type_Combo,-1,"Demo")
    AddGadgetItem(Type_Combo,-1,"Beta")
    
    AddGadgetItem(ConfUM_Combo,-1,"A1200")
    AddGadgetItem(ConfUM_Combo,-1,"A1200-030")
    AddGadgetItem(ConfUM_Combo,-1,"A1200-040")
    AddGadgetItem(ConfUM_Combo,-1,"A1200-CD32")
    SetGadgetState(ConfUM_Combo,UM_Database()\UM_Config)
    
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
        If Genre_List()=UM_Database()\UM_Genre
          SetGadgetState(Genre_Combo,ListIndex(Genre_List()))
          Break     
        EndIf
      Next  
      
    Else
      
      MessageRequester("Error","Cannot find genres file!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
      
    EndIf
    
    SetGadgetState(AGA_Check,UM_Database()\UM_AGA)
    SetGadgetState(CD32_Check,UM_Database()\UM_CD32)
    SetGadgetState(CDTV_Check,UM_Database()\UM_CDTV)
    SetGadgetState(MT32_Check,UM_Database()\UM_MT32)
    SetGadgetState(Cover_Check,UM_Database()\UM_Coverdisk)
    SetGadgetState(CDROM_Check,UM_Database()\UM_CDROM)
    SetGadgetState(Arcadia_Check,UM_Database()\UM_Arcadia)
    SetGadgetState(Demo_Check,UM_Database()\UM_Demo)
    SetGadgetState(Intro_Check,UM_Database()\UM_Intro)
    SetGadgetState(NoIntro_Check,UM_Database()\UM_NoIntro)
    SetGadgetState(NTSC_Check,UM_Database()\UM_NTSC)
    SetGadgetState(Preview_Check,UM_Database()\UM_Preview)
    SetGadgetState(Files_Check,UM_Database()\UM_Files)
    SetGadgetState(Image_Check,UM_Database()\UM_Image)
    SetGadgetState(NoIntro_Check,UM_Database()\UM_NoIntro)
    SetGadgetState(ECSOCS_Check,UM_Database()\UM_ECSOCS)
    SetGadgetState(NoSound_Check,UM_Database()\UM_NoSound)
    
    Select UM_Database()\UM_Type
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
            Case title_string
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Title=GetGadgetText(title_string)
                text$=UM_Database()\UM_Title+Title_Extras()
                change=#True
                change3=#True
              EndIf
              
            Case Short_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Short=GetGadgetText(Short_String)
                SetGadgetText(Short_Title,"Short ("+Str(Len(UM_Database()\UM_Short))+")")
                change=#True
                change3=#True
              EndIf
              
            Case Coder_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Publisher=GetGadgetText(Coder_String)
                change=#True
              EndIf
              
            Case Developer_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Developer=GetGadgetText(developer_string)
                change=#True
              EndIf
              
            Case path_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_LHAFile=GetGadgetText(path_String)
                change=#True
              EndIf
            Case Date_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Slave_Date=GetGadgetText(Date_String)
                change=#True
              EndIf
            Case Genre_Combo
              UM_Database()\UM_Genre=GetGadgetText(Genre_Combo)
              change=#True
            Case ConfUM_Combo
              UM_Database()\UM_Config=GetGadgetState(ConfUM_Combo)
              change=#True
            Case Type_Combo
              UM_Database()\UM_Type=GetGadgetText(Type_Combo)
              change=#True
            Case language_string
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Language=GetGadgetText(language_string)
                change=#True
              EndIf
            Case Players_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Players=GetGadgetText(Players_String)
                change=#True
              EndIf
            Case AGA_Check
              UM_Database()\UM_AGA=GetGadgetState(AGA_Check)
              change=#True
            Case ECSOCS_Check
              UM_Database()\UM_ECSOCS=GetGadgetState(ECSOCS_Check)
              change=#True
            Case CD32_Check
              UM_Database()\UM_CD32=GetGadgetState(CD32_Check)
              change=#True
            Case CDTV_Check
              UM_Database()\UM_CDTV=GetGadgetState(CDTV_Check)
              change=#True
            Case CDROM_Check
              UM_Database()\UM_CDROM=GetGadgetState(CDROM_Check)
              change=#True
            Case Arcadia_Check
              UM_Database()\UM_Arcadia=GetGadgetState(Arcadia_Check)
              change=#True
            Case MT32_Check
              UM_Database()\UM_MT32=GetGadgetState(MT32_Check)
              change=#True
            Case NTSC_Check
              UM_Database()\UM_NTSC=GetGadgetState(NTSC_Check)
              change=#True
            Case Cover_Check
              UM_Database()\UM_Coverdisk=GetGadgetState(Cover_Check)
              change=#True
            Case Demo_Check
              UM_Database()\UM_Demo=GetGadgetState(Demo_Check)
              change=#True
            Case Intro_Check
              UM_Database()\UM_Intro=GetGadgetState(Intro_Check)
              change=#True
            Case NoIntro_Check
              UM_Database()\UM_NoIntro=GetGadgetState(NoIntro_Check)
              change=#True
            Case Image_Check
              UM_Database()\UM_Image=GetGadgetState(Image_Check)
              change=#True
            Case Files_Check
              UM_Database()\UM_Files=GetGadgetState(Files_Check)
              change=#True
            Case NoSound_Check
              UM_Database()\UM_NoSound=GetGadgetState(NoSound_Check)
              change=#True
            Case Memory_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Memory=GetGadgetText(Memory_String)
                change=#True
              EndIf
            Case Disk_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Disks=GetGadgetText(Disk_String)
                change=#True
              EndIf
            Case Coder_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Publisher=GetGadgetText(Coder_String)
                change=#True
              EndIf
            Case Year_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Year=GetGadgetText(Year_String)
                change=#True
              EndIf
            Case icon_string
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Default_Icon=GetGadgetText(icon_string)
                change=#True
              EndIf
            Case icon_button
              Choose_Icon()
              SetGadgetText(icon_string,UM_Database()\UM_Default_Icon)
              change=#True
            Case File_Button
              path=OpenFileRequester("Select File", "", "*.*",0)
              If path<>""
                UM_Database()\UM_LHAFile=GetFilePart(path)
                SetGadgetText(path_string,GetFilePart(path))
              EndIf
            Case Update_Button
              text$=InputRequester("Set Path", "Update Folder & Slave Path",UM_Database()\UM_Folder+"/"+UM_Database()\UM_Slave)
              UM_Database()\UM_Folder=GetPathPart(text$)
              UM_Database()\UM_Folder=RTrim(UM_Database()\UM_Folder,"/")
              UM_Database()\UM_Slave=GetFilePart(text$)
              count=CountString(UM_Database()\UM_Path,"/")
              UM_Database()\UM_Path=RemoveString(UM_Database()\UM_Path,UM_Database()\UM_Folder)
              UM_Database()\UM_Path=RTrim(UM_Database()\UM_Path,"/")
              UM_Database()\UM_Path+"/"+UM_Database()\UM_Folder+"/"
            Case Close_Button
              Break
            Case Cancel_Button
              If change=#True
                If MessageRequester("Warning","Cancel Changes?",#PB_MessageRequester_Warning|#PB_MessageRequester_YesNo)=#PB_MessageRequester_Yes
                  CopyList(Backup_List(),UM_Database())
                  change=#False
                  Break
                EndIf
              Else
                Break
              EndIf
              
          EndSelect
          
        Case #PB_Event_CloseWindow  
          Break
          
      EndSelect
      
    ForEver
    
    UseGadgetList(old_gadget_list) 
    
    CloseWindow(#EDIT_WINDOW)  
    
    DisableWindow(#MAIN_WINDOW,#False)
       
    SortStructuredList(UM_Database(),#PB_Sort_Ascending|#PB_Sort_NoCase,OffsetOf(UM_Data\UM_Title),TypeOf(UM_Data\UM_Title))
    
    If change 
      If Short_Names
        SetGadgetItemText(#MAIN_LIST,old_num,UM_Database()\UM_Short+Title_Extras_Short())
      Else
        SetGadgetItemText(#MAIN_LIST,old_num,UM_Database()\UM_Title+Title_Extras())
      EndIf
      Save_DB()
    EndIf
        
    Protected itemheight, hotitem
    
    If change3
      Draw_List() 
      Center_List(old_pos)
    Else  
      SetActiveGadget(#MAIN_LIST)
    EndIf 
    
    Draw_Info(List_Numbers())
    
    FreeList(Backup_List())
    
  EndIf
  
EndProcedure

Procedure Create_Menus()
  
  CreateMenu(Main_Menu, WindowID(#MAIN_WINDOW))
  MenuTitle("File")
  MenuItem(#MenuItem_1,  "Run Game")
  MenuItem(#MenuItem_2,  "Run CD32")
  MenuItem(#MenuItem_2a, "Run System")
  MenuBar()
  MenuItem(#MenuItem_2b, "Favourite"+Chr(9)+"F8")  
  MenuBar()
  MenuItem(#MenuItem_3,  "Save Gameslist (CSV)")
  MenuBar()
  MenuItem(#MenuItem_4,  "Save Database")
  MenuBar()
  MenuItem(#MenuItem_5,  "Quit")
  MenuTitle("Create")
  MenuItem(#MenuItem_10, "Make Image Folders")
  MenuItem(#MenuItem_10a, "Make CLRMame Dats")
  MenuBar()
  MenuItem(#MenuItem_10c, "Archive Folder")
  MenuItem(#MenuItem_10b, "Batch Archive Folders")
  MenuBar()
  MenuItem(#MenuItem_11, "Backup Images")
  MenuBar()
  MenuItem(#MenuItem_12, "Make PD Image Set")
  MenuItem(#MenuItem_13, "Make PD Image")
  MenuBar()
  MenuItem(#MenuItem_14, "Delete Folder")
  MenuBar()
  MenuItem(#MenuItem_15, "Re-Install Game")
  MenuTitle("Database")
  OpenSubMenu("Update")
  MenuItem(#MenuItem_21, "Update FTP")
  MenuItem(#MenuItem_22, "Update Amiga")
  MenuBar()
  MenuItem(#MenuItem_23,  "Update Full")
  CloseSubMenu()
  MenuItem(#MenuItem_24,  "Check Images")
  MenuBar() 
  MenuItem(#MenuItem_25, "Add CD32 Entry")
  MenuItem(#MenuItem_26, "Delete Entry")
  MenuItem(#MenuItem_27, "Edit Entry")
  MenuTitle("Settings")
  MenuItem(#MenuItem_31, "Set Paths")
  MenuBar()
  MenuItem(#MenuItem_32, "Short Names")
  MenuItem(#MenuItem_33, "Close WinUAE On Exit")
  MenuBar()
  MenuItem(#MenuItem_34, "Smooth Images"+Chr(9)+"F7")
  MenuItem(#MenuItem_35, "Good Resize") 
  MenuBar()
  MenuItem(#MenuItem_44, "Back-Up DB (JSON)")
  MenuItem(#MenuItem_45, "Reload Genres")
  MenuItem(#MenuItem_46, "Refresh"+Chr(9)+"F5")
  
  SetMenuItemState(Main_Menu,#MenuItem_32,Short_Names)  
  SetMenuItemState(Main_Menu,#MenuItem_34,IFF_Smooth)
  SetMenuItemState(Main_Menu,#MenuItem_35,Good_Scaler)
  SetMenuItemState(Main_Menu,#MenuItem_33,Close_UAE)    
  SetMenuItemState(Main_Menu,#MenuItem_44,JSON_Backup)  
  DisableMenuItem(Main_Menu,#MenuItem_25,1)
  DisableMenuItem(Main_Menu,#MenuItem_2,1)
  DisableMenuItem(Main_Menu,#MenuItem_2a,1)
  
  If IFF_Smooth=#PB_Image_Raw
    SetMenuItemState(Main_Menu,#MenuItem_20,#False)
  Else
    SetMenuItemState(Main_Menu,#MenuItem_20,#True)
  EndIf
  
  If CreatePopupMenu(#EDITOR_MENU)
    MenuItem(#MenuItem_96, "Copy")
    MenuItem(#MenuItem_97, "Paste")
    MenuItem(#MenuItem_98, "Clear")
    MenuItem(#MenuItem_99, "Edit")
  EndIf
  
  CreatePopupImageMenu(#IMAGE_POPUP_MENU)
  MenuItem(#MenuItem_95,"Paste Image",ImageID(#IMAGE_ICON))

EndProcedure

Procedure Draw_Filter_Panel()
  
  Protected g_file.i
  
  UseGadgetList(WindowID(#MAIN_WINDOW))
  
  ContainerGadget(#FILTER_PANEL,0,0,320,WindowHeight(#MAIN_WINDOW)-MenuHeight())
  
  FrameGadget(#PB_Any,4,4,316,118,"Game List")
  
    TextGadget(#PB_Any, 12, 28, 50, 20, "Category")  
    Category_Gadget = ComboBoxGadget(#PB_Any, 106, 24 , 206, 22)
    TextGadget(#PB_Any, 12, 58, 50, 20, "Filter")  
    Filter_Gadget = ComboBoxGadget(#PB_Any, 106, 54, 206, 22)
    TextGadget(#PB_Any, 12, 90, 186, 20, "Game Genre")  
    Genre_Gadget = ComboBoxGadget(#PB_Any, 106, 86, 206, 22)
    
    FrameGadget(#PB_Any,4,130,316,114,"Hardware")
    
    Hardware_Gadget=ComboBoxGadget(#PB_Any,106,150,206,22)
    TextGadget(#PB_Any,12,154,86,24,"System")
    AddGadgetItem(Hardware_Gadget,-1,"All")
    AddGadgetItem(Hardware_Gadget,-1,"Amiga")
    AddGadgetItem(Hardware_Gadget,-1,"CD32")
    AddGadgetItem(Hardware_Gadget,-1,"CDTV")
    AddGadgetItem(Hardware_Gadget,-1,"AmigaCD")
    AddGadgetItem(Hardware_Gadget,-1,"Arcadia")
    SetGadgetState(Hardware_Gadget,Filter(0)\HardWare)
    
    Chipset_Gadget=ComboBoxGadget(#PB_Any,106,180,206,22)
    TextGadget(#PB_Any,12,184,86,24,"Graphics")
    AddGadgetItem(Chipset_Gadget,-1,"All")
    AddGadgetItem(Chipset_Gadget,-1,"OCS/ECS")
    AddGadgetItem(Chipset_Gadget,-1,"AGA")
    AddGadgetItem(Chipset_Gadget,-1,"PAL")
    AddGadgetItem(Chipset_Gadget,-1,"NTSC")
    SetGadgetState(Chipset_Gadget,Filter(0)\Chipset)
    
    Sound_Gadget=ComboBoxGadget(#PB_Any,106,210,206,22)
    TextGadget(#PB_Any,12,214,86,24,"Sound")
    AddGadgetItem(Sound_Gadget,-1,"All")
    AddGadgetItem(Sound_Gadget,-1,"No Sound")
    AddGadgetItem(Sound_Gadget,-1,"MT32")  
    SetGadgetState(Sound_Gadget,Filter(0)\Sound)
    
    FrameGadget(#PB_Any,4,250,316,264,"Game Info")
    
    TextGadget(#PB_Any,12,274,186,24,"Publisher")
    Publisher_Gadget=ComboBoxGadget(#PB_Any,106,270,206,22)
    TextGadget(#PB_Any,12,304,186,24,"Developer")
    Developer_Gadget=ComboBoxGadget(#PB_Any,106,300,206,22)
    TextGadget(#PB_Any,12,334,186,24,"Demo Coder")
    Coder_Gadget=ComboBoxGadget(#PB_Any,106,330,206,22)
    TextGadget(#PB_Any,12,364,186,24,"Year")
    Year_Gadget=ComboBoxGadget(#PB_Any,106,360,206,22)
    TextGadget(#PB_Any,12,394,186,24,"Language")
    Language_Gadget=ComboBoxGadget(#PB_Any,106,390,206,22)
    TextGadget(#PB_Any,12,424,186,24,"Memory")
    Memory_Gadget=ComboBoxGadget(#PB_Any,106,420,206,22)
    TextGadget(#PB_Any,12,454,186,24,"Number Of Disks")
    Disks_Gadget=ComboBoxGadget(#PB_Any,106,450,206,22)
    TextGadget(#PB_Any,12,484,186,24,"Disk Type")
    DiskCategory_Gadget=ComboBoxGadget(#PB_Any,106,480,206,22)
    AddGadgetItem(DiskCategory_Gadget,-1,"All")
    AddGadgetItem(DiskCategory_Gadget,-1,"Game Demo")
    AddGadgetItem(DiskCategory_Gadget,-1,"Preview")
    AddGadgetItem(DiskCategory_Gadget,-1,"Intro Disk")
    AddGadgetItem(DiskCategory_Gadget,-1,"No Intro")
    AddGadgetItem(DiskCategory_Gadget,-1,"Coverdisk")
    SetGadgetState(DiskCategory_Gadget,Filter(0)\DiskType)  
    
    FrameGadget(#PB_Any,4,520,316,82,"Miscellaneous")
    TextGadget(#PB_Any,12,544,186,24,"Data Type")
    DataType_Gadget=ComboBoxGadget(#PB_Any,106,540,206,20)
    AddGadgetItem(DataType_Gadget,-1,"All")
    AddGadgetItem(DataType_Gadget,-1,"Files")
    AddGadgetItem(DataType_Gadget,-1,"Image")
    SetGadgetState(DataType_Gadget,Filter(0)\DataType)
    
    TextGadget(#PB_Any,12,574,186,24,"Players")
    Players_Gadget=ComboBoxGadget(#PB_Any,106,570,206,20)
    AddGadgetItem(Players_Gadget,-1,"All")
    AddGadgetItem(Players_Gadget,-1,"No Players")
    AddGadgetItem(Players_Gadget,-1,"1 Player")
    AddGadgetItem(Players_Gadget,-1,"2 Players")
    AddGadgetItem(Players_Gadget,-1,"3 Players")
    AddGadgetItem(Players_Gadget,-1,"4 Players")
    AddGadgetItem(Players_Gadget,-1,"5+ Players")
    SetGadgetState(Players_Gadget,Filter(0)\Players)
    
    FrameGadget(#PB_Any,4,606,316,52,"Search")
    Search_Gadget=StringGadget(#PB_Any,12,626,300,24,Filter(0)\Search)
    Protected combomem = AllocateMemory(40)
    PokeS(combomem, "Search...", -1, #PB_Unicode)
    SendMessage_(GadgetID(Search_Gadget), #EM_SETCUEBANNER, 0, combomem)
    
    Reset_Button=ButtonGadget(#PB_Any,GadgetWidth(#FILTER_PANEL)-150,GadgetHeight(#FILTER_PANEL)-40,140,30,"Reset Filter")
    
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
    SetGadgetState(Publisher_Gadget,Filter(0)\Publisher)
    
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
    SetGadgetState(Developer_Gadget,Filter(0)\Developer)
    
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
    SetGadgetState(Coder_Gadget,Filter(0)\Coder)
    
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
    SetGadgetState(Year_Gadget,Filter(0)\Year)
    
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
    SetGadgetState(Language_Gadget,Filter(0)\Language)
    
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
    SetGadgetState(Memory_Gadget,Filter(0)\Memory)
    
    AddGadgetItem(Disks_Gadget,-1,"All")
    AddGadgetItem(Disks_Gadget,-1,"One Disk")
    AddGadgetItem(Disks_Gadget,-1,"Two Disk")
    AddGadgetItem(Disks_Gadget,-1,"Three Disk")
    AddGadgetItem(Disks_Gadget,-1,"Four Disk")
    SetGadgetState(Disks_Gadget,Filter(0)\Disks)
    
    AddGadgetItem(Category_Gadget,-1,"All")
    AddGadgetItem(Category_Gadget,-1,"Games")
    AddGadgetItem(Category_Gadget,-1,"Games/Beta")
    AddGadgetItem(Category_Gadget,-1,"Demos")
    AddGadgetItem(Category_Gadget,-1,"Beta")
    SetGadgetState(Category_Gadget,Filter(0)\Category)
    
    AddGadgetItem(Filter_Gadget,-1,"All")
    AddGadgetItem(Filter_Gadget,-1,"Favourite")
    AddGadgetItem(Filter_Gadget,-1,"Too Long")
    AddGadgetItem(Filter_Gadget,-1,"No Chipset")
    AddGadgetItem(Filter_Gadget,-1,"No Developer")
    AddGadgetItem(Filter_Gadget,-1,"No Publisher")
    AddGadgetItem(Filter_Gadget,-1,"No Image")
    AddGadgetItem(Filter_Gadget,-1,"No Title")
    AddGadgetItem(Filter_Gadget,-1,"No Cover")   
    AddGadgetItem(Filter_Gadget,-1,"No Year")
    AddGadgetItem(Filter_Gadget,-1,"Invalid Genre")
    AddGadgetItem(Filter_Gadget,-1,"Missing Type")
    AddGadgetItem(Filter_Gadget,-1,"Invalid Icon")
    AddGadgetItem(Filter_Gadget,-1,"No Icon")
    SetGadgetState(Filter_Gadget,Filter(0)\Filter)
    
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
      SetGadgetState(Genre_Gadget,Filter(0)\Genre)    
    EndIf
    
    FreeMap(FPub.s())
    FreeMap(FCoder.s())
    FreeMap(FYear.s())
    FreeMap(FLang.s())
    FreeMap(FDisks.s())
    FreeMap(FMem.s())
    FreeList(Sort.s())
    
    CloseGadgetList()
    
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
    TextGadgetCol(12, 58, 50, 20, "Filter", #White)  
    Filter_Gadget = ComboBoxGadget(#PB_Any, 106, 54, 206, 22)
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
    SetGadgetState(Hardware_Gadget,Filter(0)\HardWare)
    
    Chipset_Gadget=ComboBoxGadget(#PB_Any,106,180,206,22)
    TextGadgetCol(12,184,86,24,"Graphics",#White)
    AddGadgetItem(Chipset_Gadget,-1,"All")
    AddGadgetItem(Chipset_Gadget,-1,"OCS/ECS")
    AddGadgetItem(Chipset_Gadget,-1,"AGA")
    AddGadgetItem(Chipset_Gadget,-1,"PAL")
    AddGadgetItem(Chipset_Gadget,-1,"NTSC")
    SetGadgetState(Chipset_Gadget,Filter(0)\Chipset)
    
    Sound_Gadget=ComboBoxGadget(#PB_Any,106,210,206,22)
    TextGadgetCol(12,214,86,24,"Sound",#White)
    AddGadgetItem(Sound_Gadget,-1,"All")
    AddGadgetItem(Sound_Gadget,-1,"No Sound")
    AddGadgetItem(Sound_Gadget,-1,"MT32")  
    SetGadgetState(Sound_Gadget,Filter(0)\Sound)
    
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
    SetGadgetState(DiskCategory_Gadget,Filter(0)\DiskType)  
    
    FrameGadgetCustom(#PB_Any,4,520,316,82,"Other")
    
    TextGadgetCol(12,544,186,24,"Data Type",#White)
    DataType_Gadget=ComboBoxGadget(#PB_Any,106,540,206,20)
    AddGadgetItem(DataType_Gadget,-1,"All")
    AddGadgetItem(DataType_Gadget,-1,"Files")
    AddGadgetItem(DataType_Gadget,-1,"Image")
    SetGadgetState(DataType_Gadget,Filter(0)\DataType)
    
    TextGadgetCol(12,574,186,24,"Players",#White)
    Players_Gadget=ComboBoxGadget(#PB_Any,106,570,206,20)
    AddGadgetItem(Players_Gadget,-1,"All")
    AddGadgetItem(Players_Gadget,-1,"No Players")
    AddGadgetItem(Players_Gadget,-1,"1 Player")
    AddGadgetItem(Players_Gadget,-1,"2 Players")
    AddGadgetItem(Players_Gadget,-1,"3 Players")
    AddGadgetItem(Players_Gadget,-1,"4 Players")
    AddGadgetItem(Players_Gadget,-1,"5+ Players")
    SetGadgetState(Players_Gadget,Filter(0)\Players)
    
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
    SetGadgetState(Publisher_Gadget,Filter(0)\Publisher)
    
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
    SetGadgetState(Developer_Gadget,Filter(0)\Developer)
    
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
    SetGadgetState(Coder_Gadget,Filter(0)\Coder)
    
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
    SetGadgetState(Year_Gadget,Filter(0)\Year)
    
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
    SetGadgetState(Language_Gadget,Filter(0)\Language)
    
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
    SetGadgetState(Memory_Gadget,Filter(0)\Memory)
    
    AddGadgetItem(Disks_Gadget,-1,"All")
    AddGadgetItem(Disks_Gadget,-1,"One Disk")
    AddGadgetItem(Disks_Gadget,-1,"Two Disk")
    AddGadgetItem(Disks_Gadget,-1,"Three Disk")
    AddGadgetItem(Disks_Gadget,-1,"Four Disk")
    SetGadgetState(Disks_Gadget,Filter(0)\Disks)
    
    AddGadgetItem(Category_Gadget,-1,"All")
    AddGadgetItem(Category_Gadget,-1,"Games")
    AddGadgetItem(Category_Gadget,-1,"Games/Beta")
    AddGadgetItem(Category_Gadget,-1,"Demos")
    AddGadgetItem(Category_Gadget,-1,"Beta")
    SetGadgetState(Category_Gadget,Filter(0)\Category)
    
    AddGadgetItem(Filter_Gadget,-1,"All")
    AddGadgetItem(Filter_Gadget,-1,"Favourite")
    AddGadgetItem(Filter_Gadget,-1,"Too Long")
    AddGadgetItem(Filter_Gadget,-1,"No Chipset")
    AddGadgetItem(Filter_Gadget,-1,"No Developer")
    AddGadgetItem(Filter_Gadget,-1,"No Publisher")
    AddGadgetItem(Filter_Gadget,-1,"No Image")
    AddGadgetItem(Filter_Gadget,-1,"No Title")
    AddGadgetItem(Filter_Gadget,-1,"No Cover")   
    AddGadgetItem(Filter_Gadget,-1,"No Year")
    AddGadgetItem(Filter_Gadget,-1,"Invalid Genre")
    AddGadgetItem(Filter_Gadget,-1,"Missing Type")
    AddGadgetItem(Filter_Gadget,-1,"Invalid Icon")
    AddGadgetItem(Filter_Gadget,-1,"No Icon")
    SetGadgetState(Filter_Gadget,Filter(0)\Filter)
    
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
      SetGadgetState(Genre_Gadget,Filter(0)\Genre)    
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

Procedure Draw_Main_Panel(offset.i)

  PanelGadget(#MAIN_PANEL,10,0,482,655)
  AddGadgetItem(#MAIN_PANEL,1,"WHDLoad")
  ListIconGadget(#MAIN_LIST, 0, 0, DpiX(GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemWidth)), DpiY(GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight)), "Number", 40, #PB_ListIcon_GridLines | #LVS_NOCOLUMNHEADER | #PB_ListIcon_FullRowSelect)
  SetWindowLongPtr_(GadgetID(#MAIN_LIST),#GWL_EXSTYLE,0)
  SetWindowPos_(GadgetID(#MAIN_LIST),0,0,0,DpiX(GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemWidth)),DpiY(GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight)),#SWP_FRAMECHANGED)
  
  AddGadgetItem(#MAIN_PANEL,1,"CD32") 
  CD32_List = ListIconGadget(#PB_Any, 0, 0,GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemWidth), GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight), "Column 1", 100, #PB_ListIcon_GridLines | #LVS_NOCOLUMNHEADER | #PB_ListIcon_FullRowSelect)
  SetWindowPos_(GadgetID(CD32_List),0,0,0,DpiX(GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemWidth)),DpiY(GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight)),#SWP_FRAMECHANGED)
  
  AddGadgetItem(#MAIN_PANEL,2,"Systems") 
  System_List = ListIconGadget(#PB_Any, 0, 0, GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemWidth), GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight), "Column 1", 100, #PB_ListIcon_GridLines | #LVS_NOCOLUMNHEADER | #PB_ListIcon_FullRowSelect)
  SetWindowPos_(GadgetID(System_List),0,0,0,DpiX(GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemWidth)),DpiY(GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight)),#SWP_FRAMECHANGED)
  CloseGadgetList()
  
EndProcedure

Procedure Draw_Media_Panel(offset)
  
  ContainerGadget(#EXTRA_PANEL,495,0,658,742)
  Title_Image = CanvasGadget(#PB_Any, 4, 10, 320, 256,#PB_Canvas_Border)
  Screen_Image = CanvasGadget(#PB_Any, 328, 10, 320, 256,#PB_Canvas_Border)
  Cover_Image = CanvasGadget(#PB_Any, 4, 270, 320, 412,#PB_Canvas_Border)
  Info_Gadget=EditorGadget(#PB_Any,328,270,320,412,#PB_Editor_ReadOnly|#PB_Editor_WordWrap)
  
  DestroyCaret_()
  
  LoadFont(#INFO_FONT,"Consolas",9)
  SetGadgetFont(Info_Gadget,FontID(#INFO_FONT))
  
  EnableGadgetDrop(Title_Image,#PB_Drop_Files,#PB_Drag_Copy)
  EnableGadgetDrop(Screen_Image,#PB_Drop_Files,#PB_Drag_Copy)
  EnableGadgetDrop(Cover_Image,#PB_Drop_Files,#PB_Drag_Copy)
  
  CloseGadgetList()
  
EndProcedure

Procedure Draw_Main_Window()
    
  Create_Menus()
  Draw_Main_Panel(0)
  Draw_Media_Panel(0) 
  
  Filter_Button=ButtonGadget(#PB_Any,10,660,60,22,"Filter") 
  
  Search_Gadget=StringGadget(#PB_Any,80,661,340,20,"")
  Protected combomem = AllocateMemory(40)
  PokeS(combomem, "Search...", -1, #PB_Unicode)
  SendMessage_(GadgetID(Search_Gadget), #EM_SETCUEBANNER, 0, combomem)
  
  Clear_Button=ButtonGadget(#PB_Any,430,660,60,22,"Clear") 
  
  GadgetToolTip(Filter_Button,"Filter")
  
EndProcedure

Procedure Resize_Image(img_path.s, out_path.s)
  
  If LoadImage(#CONVERT_IMAGE,img_path)
    ResizeImage(#CONVERT_IMAGE,640,512,Scaler)
    SaveImage(#CONVERT_IMAGE,out_path,#PB_ImagePlugin_PNG)
    FreeImage(#CONVERT_IMAGE)
  EndIf

EndProcedure

Procedure Resize_Cover(img_path.s, out_path.s)
  
  If LoadImage(#CONVERT_IMAGE,img_path)
    ResizeImage(#CONVERT_IMAGE,640,824,#PB_Image_Smooth)
    SaveImage(#CONVERT_IMAGE,out_path,#PB_ImagePlugin_PNG)
    FreeImage(#CONVERT_IMAGE)
  EndIf

EndProcedure

Procedure WinCallback(hWnd, uMsg, WParam, LParam) 
   
   If WParam = #WM_RBUTTONDOWN
      If GetActiveGadget() = Info_Gadget
         PostEvent(#PB_Event_Gadget, #MAIN_WINDOW, Info_Gadget, #PB_EventType_RightClick)
      EndIf
   EndIf
   
   ProcedureReturn #PB_ProcessPureBasicEvents 
EndProcedure

Procedure Init_Program()
      
  Protected tw.i, th.i
  
  UsePNGImageDecoder()
  UseJPEGImageDecoder()
  UsePNGImageEncoder()
  UseLZMAPacker()
  UseZipPacker()
  InitNetwork() 
  
  CatchImage(#PDF_IMAGE,?PDF_Image)
  CatchImage(#TEXT_IMAGE,?Text_Image)
  CatchImage(#PLAY_ICON,?Play_Image)
  CatchImage(#IMAGE_ICON,?Image_Image)
  CatchImage(#OPTIONS_ICON,?Options_Image)
  
  Load_Prefs() 
  Load_DB()  
  Load_CD32_DB()  
  
  OpenWindow(#MAIN_WINDOW, 0, 0, 1153, 710, W_Title+"("+Build+")" , #PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_MinimizeGadget|#PB_Window_Invisible)
  
  SetWindowCallback(@WinCallback())
  
  CreateImage(#SCREEN_BLANK,320,256,32,#Black)
  StartDrawing(ImageOutput(#SCREEN_BLANK))
  Box(0,0,320,256,#White)
  RoundBox(40,40,240,176,20,20,$DDDDDDDD)
  FrontColor(#White)
  BackColor($DDDDDDDD)
  tw=TextWidth("No Image")
  th=TextHeight("No Image")
  DrawText(160-(tw/2),128-(th/2),"No Image")
  StopDrawing()
  ResizeImage(#SCREEN_BLANK,DpiX(316),DpiY(252))
  
  CreateImage(#COVER_BLANK,320,412,32,#Black)
  StartDrawing(ImageOutput(#COVER_BLANK))
  Box(0,0,320,412,#White)
  RoundBox(40,40,240,332,20,20,$DDDDDDDD)
  FrontColor(#White)
  BackColor($DDDDDDDD)
  tw=TextWidth("No Image")
  th=TextHeight("No Image")
  DrawText(160-(tw/2),206-(th/2),"No Image")
  StopDrawing()
  ResizeImage(#COVER_BLANK,DpiX(316),DpiY(408))
  
  Reset_Filter()
  Draw_Main_Window()
  Draw_List()
  Draw_CD32_List()
  Draw_Systems_List()
  
  Draw_Info(0)
  
  HideWindow(#MAIN_WINDOW,#False)
  
  SmartWindowRefresh(#MAIN_WINDOW,#True)
  
EndProcedure

Init_Program()

;- __________ Main Loop

Repeat
  
  event=WaitWindowEvent()
  
  Select event
      
    Case #WM_KEYDOWN
      
      If GetGadgetState(#MAIN_PANEL)=0
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
              PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_2b)
            EndIf
            If EventwParam() = #VK_F5
              PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_46)
            EndIf
            If EventwParam() = #VK_F7
              PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_34)
            EndIf
            If EventwParam() = #VK_DELETE
              PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_26)
            EndIf
          EndIf
        EndIf
      EndIf
      
      If GetGadgetState(#MAIN_PANEL)=1
        If CountGadgetItems(CD32_List)>0
          If GetActiveGadget()<>Search_Gadget
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
              Image_Popup(3)
            EndIf
            If EventwParam() = #VK_F5
              PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_46)
            EndIf
            If EventwParam() = #VK_DELETE
              PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_26)
            EndIf
          EndIf
        EndIf
      EndIf
      
      If GetGadgetState(#MAIN_PANEL)=2
        If CountGadgetItems(System_List)>0
          ;If GetActiveGadget()<>Search_Gadget
          If EventwParam() = #VK_RETURN
            If CountGadgetItems(CD32_List)>0
              ;SelectElement(CD32_Numbers(),GetGadgetState(CD32_List))
              Run_System(GetGadgetState(System_List))
            EndIf 
          EndIf
          ;             If EventwParam() = #VK_SPACE
          ;               If CountGadgetItems(CD32_List)>0
          ;                 SelectElement(CD32_Numbers(),GetGadgetState(CD32_List))
          ;                 Edit_CD32(CD32_Numbers())
          ;               EndIf
          ;             EndIf
          ;             If EventwParam() = #VK_F1
          ;               Image_Popup(1)
          ;             EndIf
          ;             If EventwParam() = #VK_F2
          ;               Image_Popup(2)
          ;             EndIf
          ;             If EventwParam() = #VK_F3
          ;               PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_35)
          ;             EndIf
          ;             If EventwParam() = #VK_F5
          ;               PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_36)
          ;             EndIf
          ;             If EventwParam() = #VK_DELETE
          ;               PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_26)
          ;             EndIf
          ;           EndIf
        EndIf
      EndIf
      
    Case #PB_Event_Menu
          
      Select EventMenu()
          
        Case 900 To 1100
          If GetExtensionPart(GetMenuItemText(#POPUP_MENU,EventMenu()))="txt"
            RunProgram("notepad.exe",Game_Info_Path+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetMenuItemText(#POPUP_MENU,EventMenu()),"")
          EndIf
          
          If GetExtensionPart(GetMenuItemText(#POPUP_MENU,EventMenu()))="pdf"
            RunProgram(Game_Info_Path+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetMenuItemText(#POPUP_MENU,EventMenu()),"","")
          EndIf
          
          If GetExtensionPart(GetMenuItemText(#POPUP_MENU,EventMenu()))="jpg"
            RunProgram(Game_Info_Path+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetMenuItemText(#POPUP_MENU,EventMenu()),"","")
          EndIf
          
          If GetExtensionPart(GetMenuItemText(#POPUP_MENU,EventMenu()))="png"
            RunProgram(Game_Info_Path+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetMenuItemText(#POPUP_MENU,EventMenu()),"","")
          EndIf
          
          SetActiveGadget(#MAIN_LIST)
          
        Case #MenuItem_95 
          If GetGadgetState(#MAIN_PANEL)=0
            If paste_gadget=1
              If Good_Scaler : i=#PB_Image_Smooth : Else : i=#PB_Image_Raw  : EndIf
              If GetClipboardImage(#TITLE_IMAGE)
                CreateDirectory(Game_Img_Path+"Titles\"+UM_Database()\UM_Type+"\")
                CreateDirectory(Game_Img_Path+"Titles\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\"))
                CreateDirectory(Game_Img_Path+"Titles\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder)
                path=Game_Img_Path+"Titles\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
                ResizeImage(#TITLE_IMAGE,640,512,i)
                SaveImage(#TITLE_IMAGE,path,#PB_ImagePlugin_PNG)
                Draw_Info(List_Numbers())
              EndIf
            EndIf
            If paste_gadget=2
              If Good_Scaler : i=#PB_Image_Smooth : Else : i=#PB_Image_Raw  : EndIf
              If GetClipboardImage(#SCREEN_IMAGE)
                CreateDirectory(Game_Img_Path+"Screenshots\"+UM_Database()\UM_Type+"\")
                CreateDirectory(Game_Img_Path+"Screenshots\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\"))
                CreateDirectory(Game_Img_Path+"Screenshots\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder)
                path=Game_Img_Path+"Screenshots\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
                ResizeImage(#SCREEN_IMAGE,640,512,i)
                SaveImage(#SCREEN_IMAGE,path,#PB_ImagePlugin_PNG)
                Draw_Info(List_Numbers())
              EndIf
            EndIf
            If paste_gadget=3
              If GetClipboardImage(#COVER_IMAGE)
                If GetGadgetState(#MAIN_PANEL)=0
                  CreateDirectory(Game_Img_Path+"Covers\"+UM_Database()\UM_Type+"\")
                  CreateDirectory(Game_Img_Path+"Covers\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\"))
                  CreateDirectory(Game_Img_Path+"Covers\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder)
                  path=Game_Img_Path+"Covers\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
                  ResizeImage(#COVER_IMAGE,640,824,#PB_Image_Smooth)
                  SaveImage(#COVER_IMAGE,path,#PB_ImagePlugin_PNG)
                  Draw_Info(List_Numbers())
                EndIf
              EndIf
            EndIf
          EndIf
;               If GetGadgetState(#MAIN_PANEL)=1
;                 path=Game_Img_Path+"CD32\Titles\"+CD32_Database()\CD_Title+".png"
;                 Resize_Image(EventDropFiles(), path)
;                 Draw_CD32_Info(CD32_Numbers())
;               EndIf 


        Case #MenuItem_96
          If FileSize(Game_Info_Path+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\game_info.txt")>0
            path=""
            path2=""
            ReadFile(0,Game_Info_Path+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\game_info.txt")
            While Not Eof(0)
              path=ReadString(0)
              path2+path+#CRLF$
            Wend
            CloseFile(0)
            SetClipboardText(path2)
          EndIf
          SetActiveGadget(#MAIN_LIST)
        Case #MenuItem_97
          If GetClipboardText()<>"" And UM_Database()\UM_Type<>"Demo"
            CreateDirectory(Game_Info_Path+UM_Database()\UM_Type+"\")
            CreateDirectory(Game_Info_Path+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\"))
            CreateDirectory(Game_Info_Path+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder)
            SetCurrentDirectory(Game_Info_Path+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder)
            If FileSize("game_info.txt")>0 : DeleteFile("game_info.txt") : EndIf
            CreateFile(0,"game_info.txt")
            WriteStringN(0,GetClipboardText())
            FlushFileBuffers(0)
            CloseFile(0)
            Draw_Game_Info(0)
            DestroyCaret_()
            SetCurrentDirectory(Home_Path)
          EndIf
          SetActiveGadget(#MAIN_LIST)
        Case #MenuItem_98
          If UM_Database()\UM_Type<>"Demo"
            If MessageRequester("Delete","Clear Info?",#PB_MessageRequester_Warning|#PB_MessageRequester_YesNo)=#PB_MessageRequester_Yes
              DeleteDirectory(Game_Info_Path+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder,"*.txt")
              Draw_Game_Info(0)
            EndIf
            DestroyCaret_()
          EndIf
          SetActiveGadget(#MAIN_LIST)
        Case #MenuItem_99
          If UM_Database()\UM_Type<>"Demo"
            RunProgram("notepad.exe",Game_Info_Path+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\game_info.txt","",#PB_Program_Wait)
            Draw_Game_Info(0)
            DestroyCaret_()
          EndIf
          SetActiveGadget(#MAIN_LIST)
          
        Case #MenuItem_1   ;{- Run Game  
          If CountGadgetItems(#MAIN_LIST)>0
            SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
            Run_Game(List_Numbers())
          EndIf ;} 
        Case #MenuItem_2   ;{- Run CD32
          Run_CD32(CD32_Numbers());}
        Case #MenuItem_2a  ;{- Run System
          Run_System(GetGadgetState(System_List));}   
        Case #Menuitem_2b  ;{- Favourite
          If ListSize(List_Numbers())>0 And GetGadgetState(#MAIN_PANEL)=0
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
        Case #MenuItem_3   ;{- Save Gameslist (CSV)
          If ListSize(UM_Database())>0
            path=SaveFileRequester("Save List (CSV)","gameslist.csv","*.csv",0)
            If path<>""
              Save_GL_CSV(path)
            EndIf
          EndIf ;}
        Case #MenuItem_4   ;{- Save Database
          If ListSize(UM_Database())>0
            If MessageRequester("File Overwrite", "Save Database?", #PB_MessageRequester_YesNo|#PB_MessageRequester_Warning)=#PB_MessageRequester_Yes
              If GetGadgetState(#MAIN_PANEL)=0
                Save_DB()
              EndIf
              If GetGadgetState(#MAIN_PANEL)=1
                Save_CD32_DB()
              EndIf
            EndIf
          EndIf ;}
        Case #MenuItem_5   ;{- Quit
          If MessageRequester("Exit UltraMiggy", "Do you want to quit?",#PB_MessageRequester_YesNo|#PB_MessageRequester_Warning)=#PB_MessageRequester_Yes
            Break
          EndIf ;}
        Case #MenuItem_10  ;{- Create IFF Folders
          Create_IFF_Folders()
          ;} 
        Case #MenuItem_10a ;{- Make CLRMame Dats
          If MessageRequester("Sub Folder", "Include Sub Folder",#PB_MessageRequester_Info|#PB_MessageRequester_YesNo)=#PB_MessageRequester_Yes
            Make_CLRMame_Dats(PathRequester("Set Path",""),"TinyLauncher",#True)
          Else
            Make_CLRMame_Dats(PathRequester("Set Path",""),"TinyLauncher",#False)
          EndIf          
          ;} 
        Case #MenuItem_10b ;{- Batch Archive Folder
          Batch_Archive_Folders(PathRequester("Main Folder",""))
          ;} 
        Case #MenuItem_10c ;{- Archive Folder
          Archive_Folder(PathRequester("Main Folder",""))
          ;} 
        Case #MenuItem_11  ;{- Backup Images
          Backup_Images() ;}
        Case #MenuItem_12  ;{- Make PD Image Set
          Make_PD_Disk_Set() ;}
        Case #MenuItem_13  ;{- Make PD Image
          If UM_Database()\UM_Type="Demo"
            If MessageRequester("Warning","Replace Existing Image?",#PB_MessageRequester_Warning|#PB_MessageRequester_YesNo)=#PB_MessageRequester_Yes
              Make_PD_Disk()
            EndIf
          Else
            MessageRequester("Error","Not A Demo!",#PB_MessageRequester_Error)
          EndIf
          ;} 
        Case #MenuItem_14 ;{- Delete Folder
          path=PathRequester("Delete Folder","")
          If path<>""
            If MessageRequester("Warning","Delete "+path,#PB_MessageRequester_Warning|#PB_MessageRequester_YesNo)=#PB_MessageRequester_Yes
              DeleteDirectory(path,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
            EndIf
          EndIf
          ;}
        Case #MenuItem_15 ;{- Re-install game
          ReInstall_Game(List_Numbers())
          ;}
        Case #MenuItem_21 ;{- Update FTP
          Update_FTP()
          ;}
        Case #MenuItem_22 ;{- PC Update
          Update_PC()
          ;} 
        Case #MenuItem_23 ;{- Full Update
          Update_FTP()
          Update_PC();} 
        Case #MenuItem_24 ;{- Check Images
          Audit_Images()
          ;}            
        Case #MenuItem_25 ;{- Add CD32 Entry
          path=OpenFileRequester("Select CD32 Archive",CD32_Path,"*.zip",0)
          If path<>""
            AddElement(CD32_Database())
            CD32_Database()\CD_Title=GetFilePart(path)
            CD32_Database()\CD_File=GetFilePart(path)
            CD32_Database()\CD_Genre="Unknown"
            CD32_Database()\CD_Config=0
            SortStructuredList(CD32_Database(),#PB_Sort_Ascending|#PB_Sort_NoCase,OffsetOf(UM_Data\UM_Title),TypeOf(UM_Data\UM_Title))
            Draw_CD32_List()
            Draw_CD32_Info(0)              
          EndIf
          
          ;}  
        Case #MenuItem_26 ;{- Delete Entry
          If CountGadgetItems(#MAIN_LIST)>0
            If MessageRequester("Delete Entry","Delete Current Entry?", #PB_MessageRequester_YesNo|#PB_MessageRequester_Warning)=#PB_MessageRequester_Yes              
              If GetGadgetState(#MAIN_PANEL)=0
                SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
                If GetGadgetState(#MAIN_LIST)>0
                  list_pos=GetGadgetState(#MAIN_LIST)-1
                Else
                  list_pos=0
                EndIf
                DeleteElement(UM_Database())
                Draw_List()
                SelectElement(List_Numbers(),list_pos)
                SetGadgetState(#MAIN_LIST,list_pos)
                Draw_Info(List_Numbers())
              EndIf
              
              If GetGadgetState(#MAIN_PANEL)=1             
                If FileSize(CD32_Path+CD32_Database()\CD_File)>-1
                  CopyFile(CD32_Path+CD32_Database()\CD_File,Backup_Path+"Archives\"+GetFilePart(CD32_Database()\CD_File))
                  DeleteFile(CD32_Path+CD32_Database()\CD_File,#PB_FileSystem_Force)
                EndIf
                
                If FileSize(Game_Img_Path+"CD32\Covers\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".png")>-1
                  CopyFile(Game_Img_Path+"CD32\Covers\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".png",Backup_Path+"Covers\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".png")
                  DeleteFile(Game_Img_Path+"CD32\Covers\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".png",#PB_FileSystem_Force)
                EndIf
                
                If FileSize(Game_Img_Path+"CD32\Titles\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".png")>-1
                  CopyFile(Game_Img_Path+"CD32\Titles\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".png",Backup_Path+"Titles\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".png")
                  DeleteFile(Game_Img_Path+"CD32\Titles\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".png",#PB_FileSystem_Force)
                EndIf
                
                If FileSize(Game_Img_Path+"CD32\Screenshots\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".png")>-1
                  CopyFile(Game_Img_Path+"CD32\Screenshots\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".png",Backup_Path+"Screenshots\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".png")
                  DeleteFile(Game_Img_Path+"CD32\Screenshots\"+GetFilePart(CD32_Database()\CD_Title,#PB_FileSystem_NoExtension)+".png",#PB_FileSystem_Force)
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
        Case #MenuItem_27 ;{- Edit Entry
          If CountGadgetItems(#MAIN_LIST)>0
            SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
            Edit_GL(List_Numbers())
          EndIf ;}  
        Case #MenuItem_31 ;{- Set Paths
          Path_Window()   ;}
        Case #MenuItem_32 ;{- Short Names
          If Short_Names=#True
            SetMenuItemState(Main_Menu,#MenuItem_32,#False)
            Short_Names=#False
          Else
            SetMenuItemState(Main_Menu,#MenuItem_32,#True)
            Short_Names=#True
          EndIf
          Draw_List()
          If ListSize(List_Numbers())>0
            Draw_Info(List_Numbers())
          Else
            Draw_Info(-1)
          EndIf
          
          ;}  
        Case #MenuItem_33 ;{- Close UAE
          If Close_UAE=#False
            SetMenuItemState(Main_Menu,#MenuItem_33,#True)
            Close_UAE=#True
          Else
            SetMenuItemState(Main_Menu,#MenuItem_33,#False)
            Close_UAE=#False
          EndIf
          ;}
        Case #MenuItem_34 ;{- Smooth Image
          If IFF_Smooth=#False
            SetMenuItemState(Main_Menu,#MenuItem_34,#True)
            IFF_Smooth=#True
          Else
            SetMenuItemState(Main_Menu,#MenuItem_34,#False)
            IFF_Smooth=#False
          EndIf
          If ListSize(List_Numbers())>0 And GetGadgetState(#MAIN_PANEL)=0
            Draw_Info(List_Numbers())
          EndIf
          If ListSize(CD32_Numbers())>0 And GetGadgetState(#MAIN_PANEL)=1
            Draw_CD32_Info(CD32_Numbers())
          EndIf
          ;}  
        Case #MenuItem_35 ;{- Scaler
          If Good_Scaler=#False
            SetMenuItemState(Main_Menu,#MenuItem_35,#True)
            Good_Scaler=#True
            ;Scaler="mitchell"
            Scaler=#PB_Image_Smooth
          Else
            SetMenuItemState(Main_Menu,#MenuItem_35,#False)
            Good_Scaler=#False
            ;Scaler="quick"
            Scaler=#PB_Image_Raw
          EndIf
          ;} 
        Case #MenuItem_37 ;{- JSON Backup
          If JSON_Backup=#True
            SetMenuItemState(Main_Menu,#MenuItem_37,#False)
            JSON_Backup=#False
          Else
            SetMenuItemState(Main_Menu,#MenuItem_37,#True)
            JSON_Backup=#True
          EndIf
          ;}    
        Case #MenuItem_45 ;{- Reload Genres
          If ReadFile(0,Data_Path+"um_genres.dat")
            Pause_Window(#MAIN_WINDOW)
            ClearList(Genre_List())
            ClearGadgetItems(Genre_Gadget)
            
            While Not Eof(0)
              AddElement(Genre_List())
              Genre_List()=ReadString(0)
            Wend
            
            CloseFile(0)
            
            AddGadgetItem(Genre_Gadget,-1,"All")
            AddGadgetItem(Genre_Gadget,-1,"No Image")
            AddGadgetItem(Genre_Gadget,-1,"No Archive")
            AddGadgetItem(Genre_Gadget,-1,"Invalid Genre")
            
            ClearMap(Genre_Map())
            
            ForEach Genre_List()
              AddGadgetItem(Genre_Gadget,-1,Genre_List())
              Genre_Map(Genre_List())=Genre_List()
            Next
            
            SetGadgetState(Genre_Gadget,0)
            
            If ListSize(UM_Database())>0
              Reset_Filter()
              Draw_List()
              SetGadgetState(#MAIN_LIST,0)
              SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
              Draw_Info(List_Numbers())
            EndIf
          Else
            MessageRequester("Error","Cannot find genres file!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
          EndIf                
          ;}           
        Case #MenuItem_46 ;{- Refresh List
          Draw_List()
          If ListSize(List_Numbers())>0
            SelectElement(List_Numbers(),0)
            Draw_Info(List_Numbers())
          Else
            Draw_Info(-1)
          EndIf
          ;}
      EndSelect
      
    Case #PB_Event_GadgetDrop
      
      Select EventGadget()
                    
        Case Cover_Image
          If EventDropFiles()>""
            If GetGadgetState(#MAIN_LIST)<>-1              
              If GetExtensionPart(EventDropFiles())="png" Or GetExtensionPart(EventDropFiles())="jpg" Or GetExtensionPart(EventDropFiles())="iff"
                If GetGadgetState(#MAIN_PANEL)=0
                  CreateDirectory(Game_Img_Path+"Covers\"+UM_Database()\UM_Type+"\")
                  CreateDirectory(Game_Img_Path+"Covers\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\"))
                  CreateDirectory(Game_Img_Path+"Covers\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder)
                  path=Game_Img_Path+"Covers\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
                  Resize_Cover(EventDropFiles(), path)
                  Draw_Info(List_Numbers())
                EndIf
                If GetGadgetState(#MAIN_PANEL)=1
                  path=Game_Img_Path+"CD32\Covers\"+CD32_Database()\CD_Title+".png"
                  Resize_Cover(EventDropFiles(), path)
                  Draw_CD32_Info(CD32_Numbers())
                EndIf  
              Else
                MessageRequester("Error","Not An Image File!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
              EndIf
            EndIf
          EndIf
          
        Case Title_Image
          If EventDropFiles()>""
            If GetGadgetState(#MAIN_LIST)<>-1
              If GetExtensionPart(EventDropFiles())="png" Or GetExtensionPart(EventDropFiles())="jpg" Or GetExtensionPart(EventDropFiles())="iff"
                If GetGadgetState(#MAIN_PANEL)=0
                  CreateDirectory(Game_Img_Path+"Titles\"+UM_Database()\UM_Type+"\")
                  CreateDirectory(Game_Img_Path+"Titles\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\"))
                  CreateDirectory(Game_Img_Path+"Titles\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder)
                  path=Game_Img_Path+"Titles\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
                  Resize_Image(EventDropFiles(), path)
                  Draw_Info(List_Numbers())
                EndIf
                If GetGadgetState(#MAIN_PANEL)=1
                  path=Game_Img_Path+"CD32\Titles\"+CD32_Database()\CD_Title+".png"
                  Resize_Image(EventDropFiles(), path)
                  Draw_CD32_Info(CD32_Numbers())
                EndIf 
              Else
                MessageRequester("Error","Not An Image File!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
              EndIf
            EndIf
          EndIf
          
        Case Screen_Image
          If EventDropFiles()>""
            If GetGadgetState(#MAIN_LIST)<>-1
              If GetExtensionPart(EventDropFiles())="png" Or GetExtensionPart(EventDropFiles())="jpg" Or GetExtensionPart(EventDropFiles())="iff"
                If GetGadgetState(#MAIN_PANEL)=0
                  CreateDirectory(Game_Img_Path+"Screenshots\"+UM_Database()\UM_Type+"\")
                  CreateDirectory(Game_Img_Path+"Screenshots\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\"))
                  CreateDirectory(Game_Img_Path+"Screenshots\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder)
                  path=Game_Img_Path+"Screenshots\"+UM_Database()\UM_Type+"\"+ReplaceString(UM_Database()\UM_Subfolder,"/","\")+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Default_Icon,#PB_FileSystem_NoExtension)+".png"
                  Resize_Image(EventDropFiles(), path)
                  Draw_Info(List_Numbers())
                EndIf
                If GetGadgetState(#MAIN_PANEL)=1
                  path=Game_Img_Path+"CD32\Screenshots\"+CD32_Database()\CD_Title+".png"
                  Resize_Image(EventDropFiles(), path)
                  Draw_CD32_Info(CD32_Numbers())
                EndIf 
              Else
                MessageRequester("Error","Not An Image File!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
              EndIf
            EndIf
          EndIf            
          
      EndSelect
      
    Case #PB_Event_Gadget
      
      Select EventGadget()

        Case Exit_Button
          CloseWindow(#FILTER_WINDOW)
          
        Case Clear_Button
          If EventType() = #PB_EventType_LeftClick
            SetGadgetText(Search_Gadget,"")
            Filter(0)\Search=""
            Draw_List()
            Draw_Info(List_Numbers())
          EndIf 
          
        Case Filter_Button
          Filter_Window()
          
        Case #MAIN_PANEL
          If EventType()=#PB_EventType_Change
            Pause_Window(#MAIN_WINDOW)
            If GetGadgetState(#MAIN_PANEL)=0
              Pause_Window(#MAIN_WINDOW)
              SetWindowTitle(#MAIN_WINDOW, W_Title+" (Showing "+Str(CountGadgetItems(#MAIN_LIST))+" of "+Str(ListSize(UM_Database()))+" Games)")
              DisableGadget(#MAIN_LIST,#False)
              DisableGadget(CD32_List,#True)
              DisableGadget(System_List,#True)
              SetActiveGadget(#MAIN_LIST)
              SetGadgetState(#MAIN_LIST,0)
              DisableMenuItem(Main_Menu,#MenuItem_25,1)
              DisableMenuItem(Main_Menu,#MenuItem_2,1)
              DisableMenuItem(Main_Menu,#MenuItem_2a,1)
              DisableMenuItem(Main_Menu,#MenuItem_1,0)
              If ListSize(List_Numbers())>0
                SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
                Draw_Info(List_Numbers())
              Else
                Draw_Info(-1)
              EndIf
              DisableGadget(Filter_Button,#False)
              DisableGadget(Search_Gadget,#False)
              DisableGadget(Clear_Button,#False)
            EndIf
            If GetGadgetState(#MAIN_PANEL)=1
              SetWindowTitle(#MAIN_WINDOW, W_Title+" (Showing "+Str(CountGadgetItems(CD32_List))+" of "+Str(ListSize(CD32_Database()))+" CD32 Games)")
              DisableGadget(#MAIN_LIST,#True)
              DisableGadget(CD32_List,#False)    
              DisableGadget(System_List,#True)
              SetActiveGadget(CD32_List)
              SetGadgetState(CD32_List,0)
              DisableMenuItem(Main_Menu,#MenuItem_25,0)
              DisableMenuItem(Main_Menu,#MenuItem_2,0)
              DisableMenuItem(Main_Menu,#MenuItem_1,1)
              DisableMenuItem(Main_Menu,#MenuItem_2a,1)
              Draw_CD32_Info(0)
              DisableGadget(Filter_Button,#True)
              DisableGadget(Search_Gadget,#True)
              DisableGadget(Clear_Button,#True)
            EndIf
            If GetGadgetState(#MAIN_PANEL)=2
              SetWindowTitle(#MAIN_WINDOW, W_Title+" (Showing "+Str(CountGadgetItems(CD32_List))+" of "+Str(ListSize(CD32_Database()))+" CD32 Games)")
              DisableGadget(#MAIN_LIST,#True)
              DisableGadget(CD32_List,#True) 
              DisableGadget(System_List,#False)
              SetActiveGadget(System_List)
              SetGadgetState(System_List,0)
              DisableMenuItem(Main_Menu,#MenuItem_25,1)
              DisableMenuItem(Main_Menu,#MenuItem_2,1)
              DisableMenuItem(Main_Menu,#MenuItem_1,1)
              DisableMenuItem(Main_Menu,#MenuItem_2a,0)
              Draw_CD32_Info(0)
              DisableGadget(Filter_Button,#True)
              DisableGadget(Search_Gadget,#True)
              DisableGadget(Clear_Button,#True)
            EndIf
            Resume_Window(#MAIN_WINDOW)
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
          
        Case #MAIN_LIST
          If CountGadgetItems(#MAIN_LIST)>0 And GetGadgetState(#MAIN_LIST)>-1
            If EventType()= #PB_EventType_Change
              SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
              SelectElement(UM_Database(),List_Numbers())
              Draw_Info(List_Numbers())
            EndIf
            If EventType() = #PB_EventType_LeftDoubleClick
              PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_1)
            EndIf
            If EventType() = #PB_EventType_RightClick
              SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
              SelectElement(UM_Database(),List_Numbers())
              Draw_Info(List_Numbers())
              If GetActiveGadget()=#MAIN_LIST
                DisplayPopupMenu(#POPUP_MENU, WindowID(#MAIN_WINDOW))
              EndIf
            EndIf
          EndIf
          
          
        Case Info_Gadget
          If EventType() = #PB_EventType_RightClick
            SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
            SelectElement(UM_Database(),List_Numbers())
            If GetActiveGadget()=Info_Gadget
              If UM_Database()\UM_Type<>"Demo"
                DisplayPopupMenu(#EDITOR_MENU, WindowID(#MAIN_WINDOW))
                SetActiveGadget(#MAIN_LIST)
              EndIf
            EndIf
          EndIf    
          
        Case System_List
          If CountGadgetItems(System_List)>0 And GetGadgetState(System_List)>-1
            If EventType() = #PB_EventType_LeftDoubleClick
              PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_2a)
            EndIf
          EndIf
          
        Case Title_Image    
          If ListSize(UM_Database())>0
;             If EventType()=#PB_EventType_RightClick 
;               paste_gadget=1
;               If GetClipboardImage(#PB_Any)=0 
;                 DisableMenuItem(#IMAGE_POPUP_MENU,#MenuItem_95,#True)
;               Else
;                 DisableMenuItem(#IMAGE_POPUP_MENU,#MenuItem_95,#False)
;               EndIf 
;               DisplayPopupMenu(#IMAGE_POPUP_MENU,WindowID(#MAIN_WINDOW))
;             EndIf
            If EventType()= #PB_EventType_LeftDoubleClick
              Image_Popup(1)
            EndIf
          EndIf
          
        Case Screen_Image
          If ListSize(UM_Database())>0
;             If EventType()=#PB_EventType_RightClick 
;               paste_gadget=2
;               If GetClipboardImage(#PB_Any)=0 
;                 DisableMenuItem(#IMAGE_POPUP_MENU,#MenuItem_95,#True)
;               Else
;                 DisableMenuItem(#IMAGE_POPUP_MENU,#MenuItem_95,#False)
;               EndIf
;               DisplayPopupMenu(#IMAGE_POPUP_MENU,WindowID(#MAIN_WINDOW))
;             EndIf
            If EventType()= #PB_EventType_LeftDoubleClick
              Image_Popup(2)
            EndIf
          EndIf  
          
        Case Cover_Image
          If ListSize(UM_Database())>0
;             If EventType()=#PB_EventType_RightClick 
;               paste_gadget=3
;               If GetClipboardImage(#PB_Any)=0 
;                 DisableMenuItem(#IMAGE_POPUP_MENU,#MenuItem_95,#True)
;               Else
;                 DisableMenuItem(#IMAGE_POPUP_MENU,#MenuItem_95,#False)
;               EndIf
;               DisplayPopupMenu(#IMAGE_POPUP_MENU,WindowID(#MAIN_WINDOW))
;             EndIf
            If EventType()= #PB_EventType_LeftDoubleClick
              Image_Popup(3)
            EndIf
          EndIf
          
        Case Reset_Button
          Reset_Filter()
          Draw_List()
          Draw_Info(List_Numbers())
          ;- __________ Filters 
          
        Case Chipset_Gadget, Year_Gadget, Language_Gadget, Memory_Gadget, Disks_Gadget, Hardware_Gadget, Sound_Gadget, DiskCategory_Gadget, DataType_Gadget, Category_Gadget, Genre_Gadget, Filter_Gadget, Players_Gadget
          If EventType()=#PB_EventType_Change 
            
            Select GetGadgetState(Category_Gadget)
              Case 0 : Filter(0)\Category_Text="All" 
              Case 1 : Filter(0)\Category_Text="Game"
              Case 2 : Filter(0)\Category_Text="Game/Beta"
              Case 3 : Filter(0)\Category_Text="Demo"
              Case 4 : Filter(0)\Category_Text="Beta"
            EndSelect
            Filter(0)\Category=GetGadgetState(Category_Gadget)
            
            Filter(0)\Filter_Text=GetGadgetText(Filter_Gadget)
            Filter(0)\Filter=GetGadgetState(Filter_Gadget)
            
            Filter(0)\Genre_Text=GetGadgetText(Genre_Gadget)
            Filter(0)\Genre=GetGadgetState(Genre_Gadget)
            
            Filter(0)\Year_Text=GetGadgetText(Year_Gadget)
            Filter(0)\Year=GetGadgetState(Year_Gadget)
            
            Filter(0)\Language_Text=GetGadgetText(Language_Gadget)
            Filter(0)\Language=GetGadgetState(Language_Gadget)
            
            Filter(0)\Memory_Text=GetGadgetText(Memory_Gadget)
            Filter(0)\Memory=GetGadgetState(Memory_Gadget)
            
            Filter(0)\Disks_Text=GetGadgetText(Disks_Gadget)
            Filter(0)\Disks=GetGadgetState(Disks_Gadget)
            
            Filter(0)\HardWare_Text=GetGadgetText(Hardware_Gadget)
            Filter(0)\HardWare=GetGadgetState(Hardware_Gadget)
            Filter(0)\Chipset_Text=GetGadgetText(Chipset_Gadget)
            Filter(0)\Chipset=GetGadgetState(Chipset_Gadget)
            Filter(0)\Sound_Text=GetGadgetText(Sound_Gadget)
            Filter(0)\Sound=GetGadgetState(Sound_Gadget)
            Filter(0)\DiskType_Text=GetGadgetText(DiskCategory_Gadget)
            Filter(0)\DiskType=GetGadgetState(DiskCategory_Gadget)
            Filter(0)\DataType_Text=GetGadgetText(DataType_Gadget)
            Filter(0)\DataType=GetGadgetState(DataType_Gadget)
            Filter(0)\Players_Text=GetGadgetText(Players_Gadget)
            Filter(0)\Players=GetGadgetState(Players_Gadget)
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
            Filter(0)\Search=GetGadgetText(Search_Gadget)
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
            Filter(0)\Publisher_Text=GetGadgetText(Publisher_Gadget)
            Filter(0)\Publisher=GetGadgetState(Publisher_Gadget)
            SetGadgetState(Coder_Gadget,0)
            Filter(0)\Coder=0
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
            Filter(0)\Developer_Text=GetGadgetText(Developer_Gadget)
            Filter(0)\Developer=GetGadgetState(Developer_Gadget)
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
            Filter(0)\Coder_Text=GetGadgetText(Coder_Gadget)
            Filter(0)\Coder=GetGadgetState(Coder_Gadget)
            SetGadgetState(Publisher_Gadget,0)
            Filter(0)\Publisher=0
            Draw_List() 
            If ListSize(List_Numbers())>0
              SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
              Draw_Info(List_Numbers())
            Else
              Draw_Info(-1)
            EndIf 
          EndIf         
          
      EndSelect
      
    Case #PB_Event_CloseWindow
      PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_5)
      
  EndSelect
  
ForEver

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

EndDataSection
; IDE Options = PureBasic 6.00 Alpha 3 (Windows - x64)
; CursorPosition = 4537
; FirstLine = 1019
; Folding = AAAKUAAAAAAAZ3EAAAA5
; Optimizer
; EnableThread
; EnableXP
; EnableUser
; DPIAware
; UseIcon = Images\joystick.ico
; Executable = I:\UltraMiggy\UltraMiggy.exe
; CurrentDirectory = I:\UltraMiggy\
; Compiler = PureBasic 6.00 Alpha 2 (Windows - x64)
; Debugger = Standalone