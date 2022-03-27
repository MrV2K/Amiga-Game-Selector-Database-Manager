;- ############### UltraCD32 Info
;
; Version 0.7a
;
; © 2022 Paul Vince (MrV2k)
;
; https://easyemu.mameworld.info
;
; [ PB V5.7x/V6.x / 32Bit / 64Bit / Windows / DPI ]
;
; A launcher and database manager for Commodore Amiga CD32 software
;
;- ############### Version Info
;
;============================================
; VERSION INFO v0.6
;============================================
;
; Restructured database
;   Split Launcher DB functions from DB
;   Renamed to UM_Database (from UM_Database)
; Unified code with UMlauncher
;   Kept Game_Settings_DB a UMLauncher exclusive as not needed in main program
; Threaded image loading in Draw_Info procedure.
; Threaded info loading procedure and split from Draw_Info.
; Switched back to xadunfile for LZX archives to preserve file date.
; Added loading window to run game procedure.
; Fixed image drag and drop creation.
; Added Re-Install Game Menu.
; Removed Extract Game texts.
; Changed filter to structured array.
; Fixed "choose icon" for LZX files.
; Changed Draw_Info load image to a macro.
; Added Amiga MOD Playback.
; Added Internal Text Viewer Window.
;
;============================================
; VERSION INFO v0.7
;============================================
;
; Fixed path bug that was preventing portability.
; Restructured images into Game Info folder.
; Improved Update_PC procedure.
; Fixed bug which prevented adding multiple database entries on multiple slave archives.
; Default icon is automatically set if the an icon name matches the slave name.
; Added Compress Folder procedure.
; Added folder box to the database editor.
; The filter window now opens to the left of the main window.
; Added internal PDF viewer. Needs a web based PDF viewer to work properly.
; Back-up in the Update_PC folder compresses the old data folder and stores it in the backup folder.
; Added the ability to open the Data & WHD folders from the main and popup menus.
; Removed trailing "/" from UM_Database()\UM_Subfolder.
; Removed UM_Database()\UM_Path as it was never used.
; Removed Game_Img_Path
; Favourite added to popup menu.
; Moved archivers and nconvert to Binaries folder and updated paths.
; Changed CD32 structure to include file and folder entries.
; Added HOL and Lemon Amiga entries to UM_Database & CD32 Database.
; Split the update database procedure.  Added Update_Database procedure and changed Update_PC to Update_HDF.
; Added Create_Bezel procedure which draws a bezel for the launched game on WinUAE on the fly.
; Removed Settings Menu and added options to path window. Changed path window name to Settings Window.
; Added Short Names to prefs
; Added AGS2 HDD and WinUAE config. Menu option to create AGS2 configurations and IFF images.
; Fixed AGS2 cover image aspect ratio.
; Added scan icon option to get icons that are linked to the main slave.
; Added option to switch tags on or off (renamed extras to tags)
; Changed choose icon to only add a single default icon and entry in icon list.
;
;============================================
; VERSION INFO v0.7a
;============================================
;
; 1. Added full icon support by scanning .info files for slaves and adding to DB.
; 2. Update fixed for icon based support and procedures split further to...
;     a. Update FTP
;     b. Update Database
;     c. Update HDF
; 3. Fixed TinyLauncher image creation. All now 320x256x32.
; 4. Split cleanup from update HDF and add menu item for readme.txt extraction
; 5. Added PDF Magazine support
; 6. Restructure code to make it easier to find procedures
; 7. Removed redundant procedures.
; 8. Added magazine snapshot and info support.
; 9. Tweaked IG_Tool DB export to include LHA data for LaunchBox Tool.
; 10. Added overwrite to image creation due to multiple entries per slave.
; 11. Fixed bug in text viewer for displaying weird characters.
; 12. Changed Run_Game to open a program and generate a thread for the close process.
; 13. Added check to stop WinUAE being run again if already running.
; 14. Main window is no longer disabled when running a game. Stops WinUAE getting stuck behind the main window.
; 15. Moved ReadMe text file to end of docs list and added separator.
; 16. Added support for Janeway demo database
; 17. Added support for Pouet demo database
; 18. Added zoom and rotate to image popup window
; 19. Added PD category to database and tags
; 20. If there isn't enough room for the filter window to the left of the main window, it opens on the right.
; 21. *** Genres now loaded from main database in filter window. *** REMOVED
; 22. Added copy and paste Web info to editor menu
; 23. Removed frame from image canvas gadgets. Own frame drawn in Draw_Image macro.
; 24. Fixed update procedure again... I think...
; 25. Added lha version numbers to database
; 26. Really fixed the update procedure this time... hopefully.
; 27. Added regex type x.x.x to version procedure.
; 28. Added demo release party info to database.
; 29. Added descriptions to demos based on year, genre, group and release party.
; 30. Added quit to IFF create procedure.
; 31. Added F6 keyboard shortcut to reset filter
; 32. Added delay to Run Game procedure to wait for disk activity to finish before quitting.
; 33. Tweaked the Amiga Ascii art.
; 34. Tweaked Update_HDF procedure console messages to reflect if archive is just an update or addition.
; 35. Added delay to end of Update_HDF Amiga script wait for disk activity to end.
; 36. Added previous and next buttons to the Edit_GL window
; 37. Added a macro to populate the Edit_GL window gadgets
; 38. Re-added close UAE to prefs file ??????
; 39. Amiga startup script adjusts to Close_UAE variable
; 40. Tweaked sort to take into account tags
; 41. Genres list and map are only loaded once and shared between procedures
; 42. Improved genre selection in Edit_GL window.
; 43. Create IFF images removes editors and intros that share the same slave as the main game/demo for AGS slave scans.
; 44. *** Added AGS info and slaves to images *** Removed - Unnecessary
; 45. Included launchbox into 'All Sets' creation in Create_IFF procedure
; 46. Added 320x256 resize to IGame RTG IFF image creation as source is now 640x512
; 47. Fixed magazine image size
; 48. Removed Base Set from IFF creation as it's pointless
; 49. Split CD32 source code into separate program UltraCD32
;
;============================================
;
; To Do List
;
;============================================
;
; 1. Simplify & Finish CD32 database and renaming
; 2. Add Tinylauncher folder support
; 3. Add OCS (A500) (A2000 - 030) config
;
;============================================

EnableExplicit

;- ############### Declares

Declare List_Files_Recursive(Dir.s, List Files.s(), Extension.s)
Declare Message_RequesterEx(Title$ , Message$ , width.i)
Declare.s Tags()
Declare.s Tags_Short()
Declare Draw_Info(number)
Declare Draw_List()
Declare Draw_CD32_List()
Declare.s Split_On_Capital(split_string.s)
Declare Fix_Gameslist(names_only.b=#False)
Declare Update_FTP()
Declare Update_HDF()
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
Declare.b AskYN(message.s)
Declare File_Viewer(file.s)
Declare Create_Bezel(type.i)
Declare.s Check_Icon_File(file.s)

;- ############### Enumerations

Enumeration
  
  #FILE
  #REGEX
  #MAIN_WINDOW
  #MAIN_STATUS
  #MAIN_LIST
  #SYSTEM_LIST
  #CD32_LIST
  #MAGAZINE_TREE
  #RUN_WINDOW
  #POPUP_WINDOW
  #PATH_WINDOW
  #EDIT_WINDOW
  #FILTER_WINDOW
  #PREVIEW_WINDOW
  #PROGRESS_WINDOW
  #WHD_WINDOW
  #FILE_WINDOW_01
  #FILE_WINDOW_02
  #FILE_WINDOW_03
  #FILE_WINDOW_04
  #FILE_WINDOW_05
  #FILE_WINDOW_06
  #FILE_WINDOW_07
  #FILE_WINDOW_08
  #FILE_WINDOW_09
  #FILE_WINDOW_10
  #FILE_WEBGADGET_01
  #FILE_WEBGADGET_02
  #FILE_WEBGADGET_03
  #FILE_WEBGADGET_04
  #FILE_WEBGADGET_05
  #FILE_WEBGADGET_06
  #FILE_WEBGADGET_07
  #FILE_WEBGADGET_08
  #FILE_WEBGADGET_09
  #FILE_WEBGADGET_10
  #SCREEN_IMAGE
  #TITLE_IMAGE
  #COVER_IMAGE
  #CONVERT_IMAGE
  #SCREEN_BLANK
  #COVER_BLANK
  #IFF_POPUP
  #OUTPUT_POPUP
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
  #FAVOURITE_ICON
  #FOLDER_ICON
  #HOL_ICON
  #LEMON_ICON
  #WHD_ICON
  #JANEWAY_ICON
  #POUET_ICON
  
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
  #Popup_a ; Popup Window
  #Popup_b
  #Popup_c
  #Popup_d
  #Popup_e
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
  #MenuItem_8a
  #MenuItem_9
  #MenuItem_9a
  #MenuItem_9b
  #MenuItem_9c
  #MenuItem_9d
  #MenuItem_10
  #MenuItem_10a
  #MenuItem_10b
  #MenuItem_10c
  #MenuItem_10d
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
  #MenuItem_22a
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
  #MenuItem_99a
  #MenuItem_99b
EndEnumeration

;- ############### Structures

Structure UM_Icon
  Icon_File.s
  Icon_Title.s
  Icon_Short.s
  Icon_Default.b
EndStructure

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
  UM_Icon.s
  UM_Sort.s
  UM_Alt_Name.s
  UM_Alt_Name_Short.s
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

Structure CD_Data
  CD_Title.s
  CD_Genre.s
  CD_Language.s
  CD_File.s
  CD_Folder.s
  CD_Publisher.s
  CD_Developer.s
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
  F_PD.b
  F_Preview.b
  F_Files.b
  F_Image.b
  F_Players.s
  F_Publisher.s
  F_Developer.s
  F_Party.s
  F_Type.s
  F_Year.s
  F_Config.i
  F_HOL.s
  F_Lemon.s
  F_WHD.s
  F_Janeway.s
  F_Pouet.s
  F_Beta.b
  F_Default_Icon.s
  F_Default_Index.i
  F_Alt_Name.s
  F_Alt_Name_Short.s
  F_InstallSize.i
  F_Version.s
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

Structure Icon_Data
  Icon_Name.s
  Icon_File.s
  Icon_Slave_Date.s
  Icon_Slave.s
EndStructure

Structure Copy_Struct
  Copy_File.s
  Copy_Slave.s
  Copy_Slave_Date.s
  Copy_Folder.s
EndStructure

Structure Mag_Data
  Mag_Name.s
  Mag_Path.s
EndStructure

Structure Mag_Root
  Mag_Title.s
  List Mag_Files.Mag_Data()
EndStructure

Structure WHD_Data
  WHD_Name.s
  WHD_Size.i
  WHD_Index.i
  WHD_Archive.s
  WHD_Filtered.b
EndStructure

Structure Web_Data
  WEB_WHDLoad.s
  WEB_HOL.s
  WEB_Lemon.s
  WEB_Developer.s
  WEB_Players.s
EndStructure

;- ############### Lists

Global NewList UM_Database.UM_Data()
Global NewList CD32_Database.CD_Data()
Global NewList Systems_Database.System_Data()
Global NewList Fix_List.f_data()

Global NewList List_Numbers.i()
Global NewList CD32_Numbers.i()

Global NewList Files.s()
Global NewList File_List.s()

Global NewList WHD_List.WHD_Data()

Global NewList Genre_List.s()
Global NewMap  Genre_Map.i()
Global NewMap  Duplicates.i()
Global NewList Dupe_List.i()
Global NewList Music_List.s()
Global NewList Mag_List.Mag_Root()
Global NewList WEB_List.Web_Data()

;########### TEMP ############

Global NewList Menu_List.s()

;#############################

Global NewList Dat_Archives.Dat_Names()

Global Dim Filter.Filter_Data(1)

;- ############### Global Variables

Global Version.s="0.7a"
Global W_Title.s="UltraMiggy "+Version
Global Build.s=FormatDate("%dd%mm%yy", #PB_Compiler_Date)

Global Main_Path.s, path.s, path2.s, path3.s

Global event.i, listnum.i, count.i, i.i, list_pos.i 

Global Main_Menu.i, Title_Image, Cover_Image, Screen_Image, IFF_Image, Info_Gadget, Mutex
Global Play_Button, Stop_Button, Volume_Slider, Track_Combo

Global Title_Image_Title.i, paste_gadget.i

Global w_list, w_tree

Global Language_Gadget, Memory_Gadget, Year_Gadget, Publisher_Gadget, Disks_Gadget, Developer_Gadget
Global Chipset_Gadget, Hardware_Gadget, DiskCategory_Gadget, Sound_Gadget, DataType_Gadget, Players_Gadget
Global Search_Gadget, Coder_Gadget, Category_Gadget, Filter_Gadget, Genre_Gadget, Reset_Button, Filter_Button, Exit_Button, Clear_Button

Global t_image.i, t_path.s, startup_prog.i ; For Threads

Global Home_Path.s=GetCurrentDirectory()
Global Data_Path.s=Home_Path+"UM_Data\"
Global Dats_Path.s=Data_Path+"Dats\"
Global DB_Path.s=Home_Path
Global Game_Data_Path.s=Home_Path+"Game_Data\"
Global Backup_Path.s=Home_Path+"Backup\"
Global CD32_Path.s=Home_Path+"CD32\"
Global WHD_Folder.s=Home_Path+"WHD\"
Global Magazine_Folder.s=Home_Path+"Magazines\"
Global Magazine_Data.s=Home_Path+"Magazine_Data\"
Global IG_Path.s=Home_Path+"Configurations\" 
Global WHD_TempDir.s=GetTemporaryDirectory()+"WHDTemp"
Global AGS_Path.s=Home_Path+"HDF\Workbench\AGS\AGS2\"

Global LHA_Path.s=Home_Path+"Binaries\7z.exe"
Global IZARC_Path.s=Home_Path+"Binaries\izarcc.exe"
Global IZARCE_Path.s=Home_Path+"Binaries\izarce.exe"
Global LZX_Path.s=Home_Path+"Binaries\unlzx.exe"
Global NConvert_Path.s=Home_Path+"Binaries\nconvert.exe"
Global WinUAE_Path.s=Home_Path+"WinUAE\winuae64.exe"

Global Close_UAE.b=#True
Global JSON_Backup=#True
Global Filter_Panel=#False
Global IFF_Smooth.l=#True
Global Short_Names.b=#False
Global Good_Scaler.b=#False
Global Scaler.l=#PB_Image_Raw
Global Track_Volume.i=50
Global Use_Bezels.b=#True
Global Show_Tags.b=#True
Global Bezel_Path.s=Data_Path+"Bezels\"
Global Bezel_Source.i=0 ; 0=Internal 1=External
Global Bezel_Type.i=3   ; 1=Screen 2=Title 3=Cover
Global Bezel_Background.s=Bezel_Path+"default.png"

;- ############### Macros

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
  InvalidateRect_(GadgetID(gadget), 0, 0)             ; invalidate control area
  UpdateWindow_(GadgetID(gadget))                     ; redraw invalidated area
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

Macro Clear_Console()
  EnableGraphicalConsole(#True)
  ClearConsole()
  EnableGraphicalConsole(#False)
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
    DrawText(2,2,Str(imgw)+"x"+Str(imgh),RGBA(0,0,0,255),RGBA(0,0,0,128))
    DrawText(1,1,Str(imgw)+"x"+Str(imgh),RGBA(255,0,255,255),RGBA(0,0,0,0))
    DrawingMode(#PB_2DDrawing_Outlined)
    Box(0,0,ImageWidth(image),ImageHeight(image),$aaaaaaaa)
    StopDrawing()
  Else
    StartDrawing(CanvasOutput(gadget))
    DrawImage(ImageID(blank),0,0)
    StopDrawing()
  EndIf
  
EndMacro

Macro Set_Database()
  SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
  SelectElement(UM_Database(),List_Numbers())  
EndMacro

Macro Language(exp,lang)
  CreateRegularExpression(#REGEX,"_("+exp+")(\.|_)")
  If MatchRegularExpression(#REGEX, UM_Database()\UM_LHAFile) : UM_Database()\UM_Language=lang : EndIf
  FreeRegularExpression(#REGEX)
EndMacro

Macro Populate_Edit_Gadgets()
  
  Pause_Window(#EDIT_WINDOW)
  
    SetGadgetText(Title_String,UM_Database()\UM_Title)
    SetGadgetText(Short_Title,"Short Name ("+Str(Len(UM_Database()\UM_Short))+")")    
    SetGadgetText(Short_String,UM_Database()\UM_Short)
    SetGadgetText(Language_String,UM_Database()\UM_Language)
    SetGadgetText(Path_String,UM_Database()\UM_LHAFile)
    SetGadgetText(Alt_Name_String,UM_Database()\UM_Alt_Name)
    SetGadgetText(Alt_Name_Short_String,UM_Database()\UM_Alt_Name_Short)
    If UM_Database()\UM_Type="Demo"
      SetGadgetText(Publisher_Text,"Group")
    Else
      SetGadgetText(Publisher_Text,"Publisher")
    EndIf
    SetGadgetText(Coder_String,UM_Database()\UM_Publisher)
    SetGadgetText(Developer_String,UM_Database()\UM_Developer)
    SetGadgetText(Date_String,UM_Database()\UM_Slave_Date)
    SetGadgetText(Year_String,UM_Database()\UM_Year)
    SetGadgetText(Memory_String,UM_Database()\UM_Memory)
    SetGadgetText(Disk_String,UM_Database()\UM_Disks) 
    SetGadgetText(Players_String,UM_Database()\UM_Players)
    SetGadgetText(Folder_String,UM_Database()\UM_Folder)
    SetGadgetText(HOL_String,UM_Database()\UM_HOL_Entry)  
    SetGadgetText(Lemon_String,UM_Database()\UM_Lemon_Entry) 
    SetGadgetText(WHD_String,UM_Database()\UM_WHD_Entry) 
    SetGadgetText(Janeway_String,UM_Database()\UM_Janeway)
    SetGadgetText(Pouet_String,UM_Database()\UM_Pouet)
    SetGadgetText(Party_String,UM_Database()\UM_Party)
    
    If UM_Database()\UM_Type="Demo"
      DisableGadget(HOL_String,#True)
      DisableGadget(Lemon_String,#True)
      DisableGadget(Janeway_String,#False)
      DisableGadget(Pouet_String,#False)
      DisableGadget(Party_String,#False)
    Else    
      DisableGadget(Janeway_String,#True)
      DisableGadget(Pouet_String,#True)
      DisableGadget(Party_String,#True)
      DisableGadget(HOL_String,#False)
      DisableGadget(Lemon_String,#False)
    EndIf
    
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
    
    SetGadgetState(Config_Combo,UM_Database()\UM_Config)
           
    If FindMapElement(Genre_Map(),UM_Database()\UM_Genre)
      SetGadgetState(Genre_Combo,Genre_Map()-1)   
    Else
      SetGadgetState(Genre_Combo, CountGadgetItems(Genre_Combo)-1)
    EndIf
    
    SetGadgetState(AGA_Check,UM_Database()\UM_AGA)
    SetGadgetState(CD32_Check,UM_Database()\UM_CD32)
    SetGadgetState(CDTV_Check,UM_Database()\UM_CDTV)    
    SetGadgetState(MT32_Check,UM_Database()\UM_MT32)
    SetGadgetState(CDROM_Check,UM_Database()\UM_CDROM)
    SetGadgetState(NTSC_Check,UM_Database()\UM_NTSC)
    SetGadgetState(Arcadia_Check,UM_Database()\UM_Arcadia)
    SetGadgetState(Demo_Check,UM_Database()\UM_Demo)
    SetGadgetState(Intro_Check,UM_Database()\UM_Intro)
    SetGadgetState(NoIntro_Check,UM_Database()\UM_NoIntro)   
    SetGadgetState(Preview_Check,UM_Database()\UM_Preview)
    SetGadgetState(Files_Check,UM_Database()\UM_Files)
    SetGadgetState(Image_Check,UM_Database()\UM_Image) 
    SetGadgetState(Cover_Check,UM_Database()\UM_Coverdisk)
    SetGadgetState(ECSOCS_Check,UM_Database()\UM_ECSOCS)
    SetGadgetState(NoSound_Check,UM_Database()\UM_NoSound)
    SetGadgetState(PD_Check,UM_Database()\UM_PD)

    Resume_Window(#EDIT_WINDOW)
    
EndMacro

Macro Generate_Images()
  
  If response="1" Or response="6" ; IGame
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Covers_ECS_Laced\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 160 206 -rtype mitchell -floyd -colours 16 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)  
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Covers_AGA_Laced\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 160 206 -rtype mitchell -floyd -colours 216 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Covers_ECS_LoRes\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 160 104 -rtype mitchell -floyd -colours 16 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait) 
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Covers_AGA_LoRes\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 160 104 -rtype mitchell -floyd -colours 216 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Covers_RTG\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 320 412 -rtype mitchell -floyd -colours 256 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Screens_ECS_Laced\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 160 128 -rtype quick -floyd -colours 16 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)       
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Screens_AGA_Laced\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 160 128 -rtype quick -floyd -colours 216 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)            
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Screens_ECS_LoRes\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 160 64 -rtype quick -floyd -colours 16 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)               
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Screens_AGA_LoRes\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 160 64 -rtype quick -floyd -colours 216 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)             
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Screens_RTG\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 320 256 -rtype quick -floyd -colours 256 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Titles_ECS_Laced\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 160 128 -rtype quick -floyd -colours 16 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)    
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Titles_AGA_Laced\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 160 128 -rtype quick -floyd -colours 216 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Titles_ECS_LoRes\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 160 64 -rtype quick -floyd -colours 16 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait) 
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Titles_AGA_LoRes\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 160 64 -rtype quick -floyd -colours 216 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame_Titles_RTG\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 320 256 -rtype quick -floyd -colours 256 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
  EndIf
  
  If response="2" Or response="6" ; Arcade Game Selector Slaves
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Covers_ECS_LoRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -ratio -resize 320 256 -rtype lanczos -canvas 320 256 center -bgcolor 0 0 0 -resize 320 128 -colors 16 -floyd "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Covers_AGA_LoRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -ratio -resize 320 256 -rtype lanczos -canvas 320 256 center -bgcolor 0 0 0 -resize 320 128 -colors 216 -floyd "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Covers_ECS_HiRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -ratio -resize 640 400 -rtype lanczos -canvas 640 400 center -bgcolor 0 0 0 -resize 640 400 -colors 16 -floyd "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Covers_AGA_HiRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -ratio -resize 640 400 -rtype lanczos -canvas 640 400 center -bgcolor 0 0 0 -resize 640 400 -colors 216 -floyd "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Screens_ECS_LoRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 320 128 -rtype quick -colors 16 -floyd "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Screens_AGA_LoRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 320 128 -rtype quick -colors 216 -floyd "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Screens_ECS_HiRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -ratio -resize 640 400 -rtype quick -canvas 640 400 center -colors 16 -floyd "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Screens_AGA_HiRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -ratio -resize 640 400 -rtype quick -canvas 640 400 center -colors 216 -floyd "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Titles_ECS_LoRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 320 128 -rtype quick -colors 16 -floyd "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Titles_AGA_LoRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 320 128 -rtype quick -colors 216 -floyd "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Titles_ECS_HiRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -ratio -resize 640 400 -rtype quick -canvas 640 400 center -colors 16 -floyd "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Titles_AGA_HiRes\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -ratio -resize 640 400 -rtype quick -canvas 640 400 center -colors 216 -floyd "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
  EndIf
    
  If response="3" Or response="6" ; Tinylauncher
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"TinyLauncher\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+"_SCR1.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -ratio -resize 320 256 -rtype mitchell -canvas 320 256 center -colors 32 -floyd "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"TinyLauncher\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+"_SCR0.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -ratio -resize 320 256 -rtype quick -colors 32 -floyd "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"TinyLauncher\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+"_SCR2.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -ratio -resize 320 256 -rtype quick -colors 32 -floyd "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
  EndIf
  
  If response="4" Or response="6" ; PC
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"PC_Images\Covers\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".jpg"+#DOUBLEQUOTE$
      path="-quiet -overwrite -q 80 -out jpeg -o "+new_file$+" "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"PC_Images\Screens\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
      path="-quiet -overwrite -clevel 9 -out png -o "+new_file$+" "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"PC_Images\Titles\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
      path="-quiet -overwrite -clevel 9 -out png -o "+new_file$+" "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf 
  EndIf 
  
  If response="5" Or response="6" ; Launchbox
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"LaunchBox\Covers\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_LHAFile,#PB_FileSystem_NoExtension)+".jpg"+#DOUBLEQUOTE$
      path="-quiet -overwrite -q 80 -out jpeg -o "+new_file$+" "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"LaunchBox\Screens\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_LHAFile,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
      path="-quiet -overwrite -clevel 9 -resize 640 512 -rtype quick -out png -o "+new_file$+" "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"LaunchBox\Titles\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_LHAFile,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
      path="-quiet -overwrite -clevel 9 -resize 640 512 -rtype quick -out png -o "+new_file$+" "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"LaunchBox_UM\Covers\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Title+Tags()+".jpg"+#DOUBLEQUOTE$
      path="-quiet -overwrite -q 80 -out jpeg -o "+new_file$+" "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"LaunchBox_UM\Screens\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Title+Tags()+".png"+#DOUBLEQUOTE$
      path="-quiet -overwrite -clevel 9 -resize 640 512 -rtype quick -out png -o "+new_file$+" "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"LaunchBox_UM\Titles\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Title+Tags()+".png"+#DOUBLEQUOTE$
      path="-quiet -overwrite -clevel 9 -resize 640 512 -rtype quick -out png -o "+new_file$+" "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
  EndIf   
EndMacro
  
Macro W_Scale()
  
  CopyImage(#IFF_POPUP,#OUTPUT_POPUP)
  
  Select rotate  
    Case 90
      Rotate_Image(#OUTPUT_POPUP,0)
    Case 180
      Rotate_Image(#OUTPUT_POPUP,0)
      Rotate_Image(#OUTPUT_POPUP,0)
    Case 270
      Rotate_Image(#OUTPUT_POPUP,1)
  EndSelect
  
  ww=Int(ImageWidth(#OUTPUT_POPUP)*zoom)
  wh=Int(ImageHeight(#OUTPUT_POPUP)*zoom)
  wx=(WindowX(#MAIN_WINDOW)+(WindowWidth(#MAIN_WINDOW))/2)-(ww/2)   ; Centered Image X
  wy=(WindowY(#MAIN_WINDOW)+(WindowHeight(#MAIN_WINDOW))/2)-(wh/2)  ; Centered Image Y  
  iw=DpiX(ww)
  ih=DpiY(wh)
  
  ResizeImage(#OUTPUT_POPUP,iw, ih,Smooth)
  ResizeWindow(#POPUP_WINDOW,wx,wy,ww,wh)
  ResizeGadget(popup_imagegadget,0,0,ww,wh)
  StartDrawing(CanvasOutput(popup_imagegadget))
  DrawImage(ImageID(#OUTPUT_POPUP),0,0)
  StopDrawing()
EndMacro

;- ############### Utility Procedures

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

Procedure.i Get_Install_Size(path.s)
  
  Protected text$, output$, install_prog, size$, proc_return
  
  text$="" : output$="" : size$="" : count=0 : proc_return=0
  
  If GetExtensionPart(path)="lha" : install_prog=RunProgram(LHA_Path,"t "+path,"",#PB_Program_Open|#PB_Program_Read) : EndIf  
  If GetExtensionPart(path)="lzx" : install_prog=RunProgram(LZX_Path,"-v "+path,"",#PB_Program_Open|#PB_Program_Read) : EndIf  
  
  While ProgramRunning(install_prog)  
    If AvailableProgramOutput(install_prog)
      text$=ReadProgramString(install_prog)
      output$+text$+#CRLF$
      count+1
    EndIf
  Wend
  
  If GetExtensionPart(path)="lha" : size$=StringField(output$,count-1,#CRLF$) : proc_return=Val(Trim(Mid(size$,13))) : EndIf  
  
  If GetExtensionPart(path)="lzx" : size$=StringField(output$,count,#CRLF$) : proc_return=Val(Left(size$,8)) : EndIf  
  
  CloseProgram(install_prog)
  
  ProcedureReturn proc_return
  
EndProcedure

;- ############### Compression Procedures

Procedure Zip_Folder(c_path.s, c_file.s)
  
  Protected old_dir.s=GetCurrentDirectory()
  
  ClearList(File_List())
  
  List_Files_Recursive(c_path,File_List(),"*.*")
  
  If GetExtensionPart(c_file)<>"zip" : c_file+".zip" : EndIf
  
  If FileSize(c_path)=-2
    SetCurrentDirectory(c_path)
    If CreatePack(0,c_file,#PB_PackerPlugin_Zip)
      ForEach File_List()
        AddPackFile(0,File_List(),RemoveString(File_List(),GetCurrentDirectory()))
      Next
      ClosePack(0)
    EndIf  
    SetCurrentDirectory(old_dir)
  EndIf
  
EndProcedure

Procedure Batch_LHA_Folders(folder.s)
  
  If folder<>""
    
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
    
  EndIf
  
EndProcedure

Procedure LHA_Folder(folder.s)
  
  Protected file_name.s, parent.s
  
  If folder<>""
    
    parent=folder
    parent=Left(parent,Len(parent) - 1)
    parent=GetPathPart(parent)
    
    CopyFile(IZARC_Path,parent+"izarcc.exe")
    
    file_name=StringField(folder,CountString(folder,"\"),"\")
    
    path=" -a -r -p "+file_name+".lha "+file_name
    
    RunProgram("izarcc",path,parent,#PB_Program_Wait)
    
    DeleteFile(parent+"izarcc.exe")
    
  EndIf
  
EndProcedure

;- ############### Filter Procedures

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
      Case "PD Disk"
        If UM_Database()\UM_PD<>#True
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
        If Len(UM_Database()\UM_Short+Tags_Short())<27
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "No InstallSize"        
        If UM_Database()\UM_InstallSize<>0
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
        If UM_Database()\UM_Year<>"" And UM_Database()\UM_Year<>"(Unknown)"
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
        
      Case "No HOL"        
        If UM_Database()\UM_HOL_Entry<>""
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "No Lemon"        
        If UM_Database()\UM_Lemon_Entry<>""
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "No WHDLoad"        
        If UM_Database()\UM_WHD_Entry<>""
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "No BitWorld"        
        If UM_Database()\UM_Janeway<>""
          UM_Database()\UM_Filtered=#True
        EndIf

      Case "No Pouet"        
        If UM_Database()\UM_Pouet<>""
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "Dupe Name"
        If UM_Database()\UM_Alt_Name=""
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
        
    EndSelect
    
  Next
  
EndProcedure

;- ############### Image Procedures

Procedure Load_Image(*val.thrds)
  
  Shared Mutex
  
  LockMutex(Mutex)
  
  If FileSize(*val\t_path)>0
    LoadImage(*val\t_image, *val\t_path)
  EndIf
  
  UnlockMutex(Mutex)
  
EndProcedure

Procedure Create_Bezel(type.i)
  
  Protected output_path.s, output_type.s, bezel_name.s, screen_png.i, graphics_png.i, output_image.i, left_image.i ,y.i, right_image.i, default_image.s
  
  default_image=Bezel_Path+"default.png"
  
  Select type
    Case 1 : output_type=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png"
    Case 2 : output_type=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png"
    Case 3 : output_type=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png"
  EndSelect
  
  If Bezel_Source=1
    output_type=Bezel_Background
  EndIf
  
  screen_png=LoadImage(#PB_Any,Bezel_Path+"Bezel_Screen.png",#PB_ImagePlugin_PNG)
  
  If FileSize(output_type)<>-1
    graphics_png=LoadImage(#PB_Any,output_type,#PB_ImagePlugin_PNG)
  Else
    graphics_png=LoadImage(#PB_Any,default_image,#PB_ImagePlugin_PNG)
  EndIf
  
  y=ImageHeight(graphics_png)
  
  output_image=CreateImage(#PB_Any,2560,1440,32)
  
  left_image=GrabImage(graphics_png,#PB_Any,0,0,200,y)
  ResizeImage(left_image,330,1440,#PB_Image_Smooth)  
  StartDrawing(ImageOutput(left_image))
  DrawingMode(#PB_2DDrawing_Gradient|#PB_2DDrawing_AlphaBlend)
  BackColor(RGBA(0,0,0,128))
  GradientColor(0.1,RGBA(0,0,0,0))
  FrontColor(RGBA(0,0,0,0))
  LinearGradient(330,0,0,0)
  Box(0,0,330,1440)  
  StopDrawing()
  
  right_image=GrabImage(graphics_png,#PB_Any,ImageWidth(graphics_png)-200,0,200,y)
  ResizeImage(right_image,330,1440,#PB_Image_Smooth)
  StartDrawing(ImageOutput(right_image))
  DrawingMode(#PB_2DDrawing_Gradient|#PB_2DDrawing_AlphaBlend)
  BackColor(RGBA(0,0,0,128))
  GradientColor(0.1,RGBA(0,0,0,0))
  FrontColor(RGBA(0,0,0,0))
  LinearGradient(0,0,330,0)
  Box(0,0,330,1440)
  StopDrawing()
  
  StartDrawing(ImageOutput(output_image))
  DrawingMode(#PB_2DDrawing_AllChannels)
  DrawImage(ImageID(screen_png),330,0) 
  DrawImage(ImageID(left_image),0,0)
  DrawImage(ImageID(right_image),2230,0)
  StopDrawing()
  
  SaveImage(output_image,GetPathPart(WinUAE_Path)+"plugins/overlays/test.png",#PB_ImagePlugin_PNG)
  
  FreeImage(screen_png)
  FreeImage(graphics_png)
  FreeImage(output_image)
  
EndProcedure

Procedure Round_Image(imagenum.i) ; For Make PD Disk
  
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

Procedure Create_Blanks()
  
  Protected tw, th
  
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
  ResizeImage(#SCREEN_BLANK,DpiX(320),DpiY(256))
  
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
  ResizeImage(#COVER_BLANK,DpiX(320),DpiY(412))
  
EndProcedure

Procedure Rotate_Image(image, flag)
   ;if flag <> 0 image rotates left else image rotates right
   
   Protected A, B, result, padding, imgTemp, format
   Protected *SBuf  ; pointer to first memory byte of source buffer
   Protected *DBuf  ; pointer to first memory byte of destination buffer
   Protected *FPix  ; points to where first pixel is peeked in source buffer
   Protected *S,*D  ; source and destination pointers
   Protected Iw     ; image width
   Protected Ih     ; image height
   Protected Depth  ; image color depth, 24 or 32
   Protected SBpp   ; SourceBytesPerPixel
   Protected DBpp   ; DestinationBytesPerPixel
   Protected SPitch ; source image number of bytes per row (x)
   Protected DPitch ; destination image number of bytes per row (x)
   
   Macro Copy3Bytes(Source, Destination)
      PokeA(Destination, PeekA(Source))
      PokeW(Destination+1, PeekW(Source+1))
   EndMacro
   
   Macro Copy4Bytes(Source, Destination)
      PokeL(Destination, PeekL(Source))
   EndMacro
   
   If IsImage(image) = 0 : ProcedureReturn result : EndIf
   
   StartDrawing(ImageOutput(image))
      ; Get information for source image
      Iw = OutputWidth() : Ih = OutputHeight() ; Get image size
      *SBuf  = DrawingBuffer()
      SPitch = DrawingBufferPitch()
      format = DrawingBufferPixelFormat()
      
      Select  format & $7FFF
         Case #PB_PixelFormat_24Bits_RGB : SBpp = 3 : Depth = 24 ; 3 Bytes per pixel (RRGGBB)
         Case #PB_PixelFormat_24Bits_BGR : SBpp = 3 : Depth = 24 ; 3 Bytes per pixel (BBGGRR)
         Case #PB_PixelFormat_32Bits_RGB : SBpp = 4 : Depth = 32 ; 4 Bytes per pixel (RRGGBB)
         Case #PB_PixelFormat_32Bits_BGR : SBpp = 4 : Depth = 32 ; 4 Bytes per pixel (BBGGRR)
         Default
            MessageRequester("Sorry...","24 and 32 bit depths only")
            StopDrawing()
            ProcedureReturn result
      EndSelect
      
      If format & #PB_PixelFormat_ReversedY = 0 ; this is for Linux
         flag = flag ! 1 & 1
      EndIf
   StopDrawing()
   
   ; Create temporary image with axis swapped
   Swap Ih,Iw
   imgTemp = CreateImage(#PB_Any, Iw, Ih, 8*SBpp)
   
   ; perform the rotation
   If imgTemp
      StartDrawing(ImageOutput(imgTemp))
         *DBuf = DrawingBuffer()
         DPitch = DrawingBufferPitch()
         DBpp = SBpp
         
         If flag = 0 ; configure to rotate right
            *FPix = *SBuf + (Ih-1) * SBpp ; point to last pixel in first row
            SBpp = -SBpp ; reverse X iteration direction
         Else ; configure to rotate left
            *FPix = *SBuf + (Iw-1) * SPitch ; point to first pixel in last row
            SPitch = -SPitch ; reverse Y iteration direction
         EndIf
         
         ; time to fly
         If Depth = 24
            A = 0 : While A < Ih
               *S = *FPix + (A * SBpp)   ; set source pointer X position
               *D = *DBuf + (A * DPitch) ; set destination pointer Y position
               B = 0 : While B < Iw
                  Copy3Bytes(*S, *D)
                  *S + SPitch ; increment source pointer Y position
                  *D + DBpp   ; increment destination pointer X position
               B + 1 : Wend
            A + 1 : Wend
         ElseIf Depth = 32
            A = 0 : While A < Ih
               *S = *FPix + (A * SBpp)   ; set source pointer X position
               *D = *DBuf + (A * DPitch) ; set destination pointer Y position
               B = 0 : While B < Iw
                  Copy4Bytes(*S, *D)
                  *S + SPitch ; increment source pointer Y position
                  *D + DBpp   ; increment destination pointer X position
               B + 1 : Wend
            A + 1 : Wend
         EndIf
      
      StopDrawing()
      
      CopyImage(imgTemp,image)
      FreeImage(imgTemp)
      result = 1
   EndIf
   
   ProcedureReturn result
EndProcedure

;- ############### Gadget Drawing Procedures

Procedure.l TextGadgetCol(tx,ty,tw,th,ttext.s,tcol)
  
  Protected text
  
  text=TextGadget(#PB_Any, tx, ty, tw, th, ttext) 
  SetGadgetColor(text,#PB_Gadget_BackColor,tcol)
  
  ProcedureReturn text
  
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

Procedure.s CD32_Tags()
  
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

Procedure.s Tags_Short()
  
  Protected extras.s=" "
  
  If UM_Database()\UM_Memory<>""
    Select UM_Database()\UM_Memory
      Case "512KB" : extras+Chr(189)+"MB"
      Case "1MB" : extras+"1MB"
      Case "1MB Chip" : extras+"1MBChp"
      Case "1.5MB" : extras+"1"+Chr(189)+"MB"
      Case "2MB" : extras+"2MB"
      Case "8MB" : extras+"8MB"
      Case "Chip Mem" : extras+"Chp"
      Case "Fast Mem" : extras+"Fst"
      Case "Low Mem" : extras+"Low"
    EndSelect
    
  EndIf   
    
  If UM_Database()\UM_Files<>0
    extras+"Files"
  EndIf
  
  If UM_Database()\UM_Image<>0
    extras+"Image"
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
  
  If UM_Database()\UM_MT32<>0
    extras+"MT"
  EndIf
  
  If UM_Database()\UM_CD32<>0
    extras+"CD32"
  EndIf
  
  If UM_Database()\UM_CDTV<>0
    extras+"CDTV"
  EndIf
  
  If UM_Database()\UM_AGA<>0 And UM_Database()\UM_CD32=0
    extras+"AA"
  EndIf
  
  
  If UM_Database()\UM_Type="Beta"
    extras+"Beta"
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
  If extras=" " : extras="" : EndIf
  
  ProcedureReturn extras
  
EndProcedure

Procedure.s Tags()
  
  Protected extras.s=""
  
  If UM_Database()\UM_Type="Demo"
    extras+" ("+UM_Database()\UM_Publisher+")"
  EndIf
  
  If UM_Database()\UM_Memory<>""
    extras+" ("+UM_Database()\UM_Memory+")"
  EndIf   
  
  If UM_Database()\UM_Beta<>0
    extras+" (Beta)"
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
  
  If UM_Database()\UM_PD<>0
    extras+" (PD)"
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
  
  If UM_Database()\UM_Language<>"" And UM_Database()\UM_Language<>"English"
    extras+" ("+UM_Database()\UM_Language+")"
  EndIf
    
  If UM_Database()\UM_Favourite=#True
    extras+ " (♥)"
  EndIf
  
  ProcedureReturn extras
  
EndProcedure

Procedure Center_List(old_pos.s)
  
  Protected itemheight, hotitem, visible
  
  itemheight = SendMessage_(GadgetID(#MAIN_LIST), #LVM_GETITEMSPACING, #True, 0) >> 16 ; only need to do this once
  visible = SendMessage_(GadgetID(#MAIN_LIST),#LVM_GETCOUNTPERPAGE,0,0)
  
  For count=1 To CountGadgetItems(#MAIN_LIST)
    SelectElement(List_Numbers(),count)
    
    If GetGadgetItemText(#MAIN_LIST,count)=old_pos
      hotitem = count
      SetGadgetState(#MAIN_LIST, hotitem)
      SendMessage_(GadgetID(#MAIN_LIST), #LVM_SCROLL, 0, 0-(CountGadgetItems(#MAIN_LIST) * itemheight)) ; scroll to top
      SendMessage_(GadgetID(#MAIN_LIST), #LVM_SCROLL, 0, (hotitem-(visible/2)) * itemheight)                     ; scroll to center hot item in listicon
      Window_Update()
      Break
    EndIf
  Next
  
EndProcedure

Procedure Draw_Magazine_Info()
  
  Protected output$, input$, myfile, imgw, imgh, smooth
  
  If GetGadgetItemAttribute(#MAGAZINE_TREE,GetGadgetState(#MAGAZINE_TREE),#PB_Tree_SubLevel)>0
    If LoadImage(#COVER_IMAGE,Magazine_Data+Mag_List()\Mag_Title+"\"+GetFilePart(GetGadgetText(#MAGAZINE_TREE),#PB_FileSystem_NoExtension)+".jpg",#PB_ImagePlugin_JPEG)
      Draw_Image(#COVER_IMAGE,Cover_Image,#COVER_BLANK,320,412)
    EndIf
    If LoadImage(#TITLE_IMAGE, Magazine_Data+Mag_List()\Mag_Title+"\"+"logo.jpg",#PB_ImagePlugin_JPEG)
      Draw_Image(#TITLE_IMAGE,Title_Image,#SCREEN_BLANK,320,256)
    EndIf
    If LoadImage(#SCREEN_IMAGE,Magazine_Data+Mag_List()\Mag_Title+"\"+"logo2.jpg",#PB_ImagePlugin_JPEG)
      Draw_Image(#SCREEN_IMAGE,Screen_Image,#SCREEN_BLANK,320,256)
    EndIf
  EndIf
  
  If GetGadgetItemAttribute(#MAGAZINE_TREE,GetGadgetState(#MAGAZINE_TREE),#PB_Tree_SubLevel)=0
    If LoadImage(#COVER_IMAGE,Magazine_Data+GetGadgetText(#MAGAZINE_TREE)+"\"+GetFilePart(GetGadgetText(#MAGAZINE_TREE),#PB_FileSystem_NoExtension)+".jpg",#PB_ImagePlugin_JPEG)
      Draw_Image(#COVER_IMAGE,Cover_Image,#COVER_BLANK,320,412)
    EndIf
    If LoadImage(#TITLE_IMAGE,Magazine_Data+GetGadgetText(#MAGAZINE_TREE)+"\logo.jpg",#PB_ImagePlugin_JPEG)
      Draw_Image(#TITLE_IMAGE,Title_Image,#SCREEN_BLANK,320,256)
    EndIf
    If LoadImage(#SCREEN_IMAGE,Magazine_Data+GetGadgetText(#MAGAZINE_TREE)+"\logo2.jpg",#PB_ImagePlugin_JPEG)
      Draw_Image(#SCREEN_IMAGE,Screen_Image,#SCREEN_BLANK,320,256)
    EndIf
  EndIf
  
  If GetGadgetItemAttribute(#MAGAZINE_TREE,GetGadgetState(#MAGAZINE_TREE),#PB_Tree_SubLevel)=0
    myfile=ReadFile(#PB_Any,Magazine_Data+GetGadgetText(#MAGAZINE_TREE)+"\game_info.txt")
  Else
    myfile=ReadFile(#PB_Any,Magazine_Data+Mag_List()\Mag_Title+"\game_info.txt")
  EndIf
  
  If IsFile(myfile)
    While Not Eof(myfile)
      input$=ReadString(myfile)
      output$+input$+#CRLF$
    Wend
    CloseFile(myfile)
  EndIf
  
  SetGadgetText(Info_Gadget,output$)
  
EndProcedure

Procedure Draw_Game_Info(*nul)
  
  Protected output$, input$, myfile, extra$
  
  Pause_Gadget(Info_Gadget)
  
  SetGadgetText(Info_Gadget,"")
  
  If GetGadgetState(#MAIN_LIST)<>-1
    
    output$=""
    output$+LSet("Version",11," ")+": "+UM_Database()\UM_Version+#CRLF$
    output$+LSet("Game #",11," ")+": "+Str(ListIndex(UM_Database()))+#CRLF$
    output$+LSet("List #",11," ")+": "+Str(GetGadgetState(#MAIN_LIST)+1)+#CRLF$
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
    output$+LSet("Short Name",11," ")+": "+UM_Database()\UM_Short+Tags_Short()+#CRLF$
    output$+LSet("Slave",11," ")+": "+UM_Database()\UM_Slave+#CRLF$
    output$+LSet("Slave Date",11," ")+": "+UM_Database()\UM_Slave_Date+#CRLF$
    output$+LSet("Icon",11," ")+": "+UM_Database()\UM_Icon+#CRLF$
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
    If UM_Database()\UM_HOL_Entry<>"" : output$+LSet("HOL",11," ")+": "+UM_Database()\UM_HOL_Entry+#CRLF$ : EndIf
    If UM_Database()\UM_Lemon_Entry<>"" : output$+LSet("Lemon",11," ")+": "+UM_Database()\UM_Lemon_Entry+#CRLF$ : EndIf
    If UM_Database()\UM_Janeway<>"" : output$+LSet("BitWorld",11," ")+": "+UM_Database()\UM_Janeway+#CRLF$ : EndIf
    If UM_Database()\UM_Pouet<>"" : output$+LSet("Pouët",11," ")+": "+UM_Database()\UM_Pouet+#CRLF$ : EndIf
    If UM_Database()\UM_WHD_Entry<>"" : output$+LSet("WHD",11," ")+": "+UM_Database()\UM_WHD_Entry+#CRLF$ : EndIf
    output$+#CRLF$
    
    ForEach Menu_List()
      output$+LSet("Files",11," ")+": "+Menu_List()+#CRLF$
    Next
    
    Protected NewList Text_File.s()
    
    If FileSize(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\game_info.txt")>0 And UM_Database()\UM_Type<>"Demo"  
      myfile=ReadFile(#PB_Any,Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\game_info.txt")
      If IsFile(myfile)
        AddElement(Text_File())
        Text_File()=""
        AddElement(Text_File())
        Text_File()="Description"
        AddElement(Text_File())
        Text_File()="-----------"
        While Not Eof(myfile)
          AddElement(Text_File())
          Text_File()=ReadString(myfile)
        Wend
        CloseFile(myfile)
      EndIf
      ForEach Text_File()
        output$+Text_File()+#CRLF$
      Next
    EndIf
    
    If UM_Database()\UM_Type="Demo"
      output$+#CRLF$
      output$+"Description"+#CRLF$
      output$+"-----------"+#CRLF$
      If UM_Database()\UM_Party<>"" : extra$=" at '"+UM_Database()\UM_Party+"'" : Else : extra$="" : EndIf
      output$+UM_Database()\UM_Title+" is a "+LCase(UM_Database()\UM_Genre)+" released in "+UM_Database()\UM_Year+" by "+UM_Database()\UM_Developer+extra$+"."+#CRLF$
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
    AddGadgetItem(#SYSTEM_LIST,-1,Systems_Database()\Sys_Name)
  Next
  
  If GetWindowLongPtr_(GadgetID(#SYSTEM_LIST), #GWL_STYLE) & #WS_VSCROLL
    SetGadgetItemAttribute(#SYSTEM_LIST,0,#PB_ListIcon_ColumnWidth,GadgetWidth(#SYSTEM_LIST)-20)
  Else
    SetGadgetItemAttribute(#SYSTEM_LIST,0,#PB_ListIcon_ColumnWidth,GadgetWidth(#SYSTEM_LIST)-5)
  EndIf
  
  For count=0 To CountGadgetItems(#SYSTEM_LIST) Step 2
    SetGadgetItemColor(#SYSTEM_LIST,count,#PB_Gadget_BackColor,$eeeeee)
  Next
  
EndProcedure

Procedure Draw_Magazines()
  
  Protected NewList Magazine_List.s()
  
  Protected old_folder.s
  
  List_Files_Recursive(Magazine_Folder,Magazine_List(),"*.*")
  
  old_folder=""
  
  ForEach Magazine_List()
    count=CountString(Magazine_List(),"\")
    If old_folder<>StringField(Magazine_List(),count,"\") : AddElement(Mag_List()) : Mag_List()\Mag_Title=StringField(Magazine_List(),count,"\") : EndIf
    AddElement(Mag_List()\Mag_Files())
    If GetExtensionPart(StringField(Magazine_List(),count+1,"\"))="pdf"
      Mag_List()\Mag_Files()\Mag_Name=StringField(Magazine_List(),count+1,"\")
      Mag_List()\Mag_Files()\Mag_Path=Magazine_List()
      EndIf
    old_folder=StringField(Magazine_List(),count,"\")
  Next
  
  ForEach Mag_List()
    AddGadgetItem(#MAGAZINE_TREE,-1,Mag_List()\Mag_Title,0,0)
    ForEach Mag_List()\Mag_Files()
      AddGadgetItem(#MAGAZINE_TREE,-1,Mag_List()\Mag_Files()\Mag_Name,0,1)
    Next
  Next
  
EndProcedure

Procedure Draw_CD32_Info(number)
  
  Protected output$, Smooth, imgw, imgh, input$, myfile
  
  Mutex=CreateMutex()
  
  If IFF_Smooth : Smooth=#PB_Image_Smooth : Else : Smooth=#PB_Image_Raw : EndIf
  
  If number>-1
    
    SelectElement(CD32_Database(),number)
    
    Protected thr.i
    
    Dim mythread.thrds(3)
    
    mythread(0)\t_image=#TITLE_IMAGE
    mythread(0)\t_path=CD32_Path+CD32_Database()\CD_Folder+"\"+GetFilePart(CD32_Database()\CD_File,#PB_FileSystem_NoExtension)+"_Title.png"
    mythread(1)\t_image=#SCREEN_IMAGE
    mythread(1)\t_path=CD32_Path+CD32_Database()\CD_Folder+"\"+GetFilePart(CD32_Database()\CD_File,#PB_FileSystem_NoExtension)+"_Screen.png"
    mythread(2)\t_image=#COVER_IMAGE
    mythread(2)\t_path=CD32_Path+CD32_Database()\CD_Folder+"\"+GetFilePart(CD32_Database()\CD_File,#PB_FileSystem_NoExtension)+"_Cover.png"
    
    For i=0 To 2
      thr=CreateThread(@Load_Image(),@mythread(i))
      Delay(10)
    Next
    
    WaitThread(thr)
    
    FreeArray(mythread())
    
    Draw_Image(#TITLE_IMAGE,Title_Image,#SCREEN_BLANK,320,256)
    Draw_Image(#SCREEN_IMAGE,Screen_Image,#SCREEN_BLANK,320,256)
    Draw_Image(#COVER_IMAGE,Cover_Image,#COVER_BLANK,320,412)
    
    output$=""
    output$+LSet("Genre",11," ")+": "+CD32_Database()\CD_Genre+#CRLF$
    output$+LSet("Language",11," ")+": "+CD32_Database()\CD_Language+#CRLF$
    output$+LSet("Year",11," ")+": "+CD32_Database()\CD_Year+#CRLF$
    output$+LSet("Players",11," ")+": "+CD32_Database()\CD_Players+#CRLF$
    output$+LSet("CUE File",11," ")+": "+CD32_Database()\CD_File+#CRLF$
    
    If FileSize(CD32_Path+CD32_Database()\CD_Folder+"\game_info.txt")>0
      output$+#CRLF$
      output$+"Description"+#CRLF$
      output$+"-----------"+#CRLF$
      myfile=ReadFile(#PB_Any,CD32_Path+CD32_Database()\CD_Folder+"\game_info.txt")
      If IsFile(myfile)
        While Not Eof(myfile)
          input$=ReadString(myfile)
          output$+input$+#CRLF$
        Wend
        CloseFile(myfile)
      EndIf
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
    MenuItem(#Menuitem_2b,"Favourite",ImageID(#FAVOURITE_ICON))
    MenuBar()
    MenuItem(#MenuItem_7,"Open Data Folder",ImageID(#FOLDER_ICON))
    MenuItem(#MenuItem_8,"Open WHD Folder",ImageID(#FOLDER_ICON))
    MenuItem(#MenuItem_8a,"Open Screenshots",ImageID(#FOLDER_ICON))
    MenuBar()
    If UM_Database()\UM_Type<>"Demo"
      If UM_Database()\UM_HOL_Entry<>""
        MenuItem(#MenuItem_9,"Hall Of Light",ImageID(#HOL_ICON))
      EndIf
      If UM_Database()\UM_Lemon_Entry<>""
        MenuItem(#MenuItem_9a,"Lemon Amiga",ImageID(#LEMON_ICON))
      EndIf
      If UM_Database()\UM_WHD_Entry<>""
        MenuItem(#MenuItem_9b,"WHDload",ImageID(#WHD_ICON))
      EndIf      
      If UM_Database()\UM_HOL_Entry<>"" Or UM_Database()\UM_Lemon_Entry<>"" Or UM_Database()\UM_WHD_Entry<>"" : MenuBar() : EndIf
    EndIf 
    If UM_Database()\UM_Type="Demo"
      If UM_Database()\UM_Janeway<>""
        MenuItem(#MenuItem_9c,"BitWorld",ImageID(#JANEWAY_ICON))
      EndIf
      If UM_Database()\UM_Pouet<>""
        MenuItem(#MenuItem_9d,"Pouët",ImageID(#POUET_ICON))
      EndIf
      If UM_Database()\UM_WHD_Entry<>""
        MenuItem(#MenuItem_9b,"WHDload",ImageID(#WHD_ICON))
      EndIf      
      If UM_Database()\UM_Janeway<>"" Or UM_Database()\UM_WHD_Entry<>"" : MenuBar() : EndIf
    EndIf 
    ClearList(Menu_List())
    
    count=0    
    If ExamineDirectory(0, Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\","*.*")
      count=0
      While NextDirectoryEntry(0)
        If DirectoryEntryName(0)<>"game_info.txt" And DirectoryEntryName(0)<>"." And DirectoryEntryName(0)<>".." And DirectoryEntryName(0)<>"Music"
          If Not FindString(DirectoryEntryName(0),"_")
            AddElement(Menu_List())
            Menu_List()=DirectoryEntryName(0)
          EndIf
        EndIf
      Wend
    EndIf
    
    ForEach Menu_List()
      If LCase(Menu_List())="readme.txt"
        MoveElement(Menu_List(),#PB_List_Last)
        Break
      EndIf
    Next

    ForEach Menu_List()
      If GetExtensionPart(Menu_List())="txt" : id=#TEXT_IMAGE : EndIf
      If GetExtensionPart(Menu_List())="pdf" : id=#PDF_IMAGE : EndIf
      If GetExtensionPart(Menu_List())="jpg" : id=#IMAGE_ICON : EndIf
      If GetExtensionPart(Menu_List())="png" : id=#IMAGE_ICON : EndIf
      If ListSize(Menu_List())>1 And ListIndex(Menu_List())=ListSize(Menu_List())-1 : MenuBar() : EndIf
      MenuItem(900+count,Menu_List(),ImageID(id))
      count+1
    Next
              
    ClearGadgetItems(Track_Combo)   
    ClearList(Music_List())
    If IsMusic(0)
      StopMusic(0)
      FreeMusic(0)
    EndIf
    If IsSound(0)
      StopSound(0)
      FreeSound(0)
    EndIf
    path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\Music"
    
    If FileSize(path)=-2
      DisableGadget(Play_Button,#False)
      DisableGadget(Stop_Button,#False)
      DisableGadget(Volume_Slider,#False)
      DisableGadget(Track_Combo,#False)
      List_Files_Recursive(path,Music_List(),"*.*")
      ForEach Music_List()
        path=RemoveString(GetFilePart(Music_List()),"mod.",#PB_String_NoCase)
        If FindString(path,".ogg") : path=RemoveString(path,".ogg") : EndIf
        If FindString(path,".mod") : path=RemoveString(path,".mod") : EndIf
        If FindString(path,"med.") : path=RemoveString(path,"med.") : EndIf
        AddGadgetItem(Track_Combo,-1,path)
      Next
      SetGadgetState(Track_Combo,0)
      SelectElement(Music_List(),0)
      GadgetToolTip(Track_Combo,GetGadgetText(Track_Combo))
    Else
      DisableGadget(Play_Button,#True)
      DisableGadget(Stop_Button,#True)
      DisableGadget(Volume_Slider,#True)
      DisableGadget(Track_Combo,#True)
    EndIf
    
    Protected thr.i
    
    Dim mythread.thrds(3)
    
    mythread(0)\t_image=#TITLE_IMAGE
    mythread(0)\t_path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png"
    mythread(1)\t_image=#SCREEN_IMAGE
    mythread(1)\t_path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png"
    mythread(2)\t_image=#COVER_IMAGE
    mythread(2)\t_path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png"
    
    For i=0 To 2
      thr=CreateThread(@Load_Image(),@mythread(i))
      Delay(10)
    Next
    
    WaitThread(thr)
    
    FreeArray(mythread())
    
  EndIf
  
  Draw_Image(#TITLE_IMAGE,Title_Image,#SCREEN_BLANK,320,256)
  Draw_Image(#SCREEN_IMAGE,Screen_Image,#SCREEN_BLANK,320,256)
  Draw_Image(#COVER_IMAGE,Cover_Image,#COVER_BLANK,320,412)
  
  thr=CreateThread(@Draw_Game_Info(),#Null)
  
  If IsImage(#COVER_IMAGE) : FreeImage(#COVER_IMAGE) : EndIf
  If IsImage(#TITLE_IMAGE) : FreeImage(#TITLE_IMAGE) : EndIf
  If IsImage(#SCREEN_IMAGE) : FreeImage(#SCREEN_IMAGE) : EndIf 
  
EndProcedure

Procedure Draw_CD32_List()
  
  Protected star.s, game.i, demo.i, beta.i
  
  SortStructuredList(CD32_Database(),#PB_Sort_Ascending|#PB_Sort_NoCase,OffsetOf(CD_Data\CD_Title),TypeOf(CD_Data\CD_Title))
  
  UseGadgetList(WindowID(#MAIN_WINDOW))
  
  Pause_Gadget(#CD32_LIST)
  
  ClearList(CD32_Numbers())
  ClearGadgetItems(#CD32_LIST)
  
  ForEach CD32_Database()
    star=""
    If CD32_Database()\CD_Genre="Unknown" : star="*" : EndIf
    If CD32_Database()\CD_Title<>"" ;And CD32_Database()\CD_Filtered=#False
      AddGadgetItem(#CD32_LIST,-1,star+CD32_Database()\CD_Title+CD32_Tags())
      AddElement(CD32_Numbers())
      CD32_Numbers()=ListIndex(CD32_Database())
    EndIf
  Next
  
  If GetWindowLongPtr_(GadgetID(#CD32_LIST), #GWL_STYLE) & #WS_VSCROLL
    SetGadgetItemAttribute(#CD32_LIST,0,#PB_ListIcon_ColumnWidth,GadgetWidth(#CD32_LIST)-20)
  Else
    SetGadgetItemAttribute(#CD32_LIST,0,#PB_ListIcon_ColumnWidth,GadgetWidth(#CD32_LIST)-5)
  EndIf
  
  For count=0 To CountGadgetItems(#CD32_LIST) Step 2
    SetGadgetItemColor(#CD32_LIST,count,#PB_Gadget_BackColor,$eeeeee)
  Next
  
  SetGadgetState(#CD32_LIST,0)
  
  Resume_Gadget(#CD32_LIST)  
  
  If ListSize(CD32_Numbers())>0
    SelectElement(CD32_Numbers(),0)
  EndIf
  
EndProcedure

Procedure Draw_List()
  
  Protected game.i, demo.i, beta.i, icon.i, extras.s
  
  SortStructuredList(UM_Database(),#PB_Sort_Ascending|#PB_Sort_NoCase,OffsetOf(UM_Data\UM_Sort),TypeOf(UM_Data\UM_Sort))
  
  UseGadgetList(WindowID(#MAIN_WINDOW))
  
  Pause_Gadget(#MAIN_LIST)
  
  ClearList(List_Numbers())
  ClearGadgetItems(#MAIN_LIST)
  
  Filter_List()
  
  game=0 : demo=0 : beta=0
  
  ForEach UM_Database()
    If UM_Database()\UM_Filtered=#False
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
      If Show_Tags : extras=Tags_Short() : Else : extras="" : EndIf
      AddGadgetItem(#MAIN_LIST,-1,UM_Database()\UM_Short+extras)
    Else
      If Show_Tags : extras=Tags() : Else : extras="" : EndIf
      AddGadgetItem(#MAIN_LIST,-1,UM_Database()\UM_Title+extras)
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

Procedure Create_Menus()
  
  CreateImageMenu(Main_Menu, WindowID(#MAIN_WINDOW))
  MenuTitle("File")
  MenuItem(#MenuItem_1,  "Run Game",ImageID(#PLAY_ICON))
  MenuItem(#MenuItem_2,  "Run CD32",ImageID(#PLAY_ICON))
  MenuItem(#MenuItem_2a, "Run System",ImageID(#PLAY_ICON))
  MenuBar()
  MenuItem(#MenuItem_2b, "Favourite"+Chr(9)+"F8",ImageID(#FAVOURITE_ICON))  
  MenuBar()
  MenuItem(#MenuItem_3,  "Save Gameslist (CSV)")
  MenuBar()
  MenuItem(#MenuItem_4,  "Save Database")
  MenuBar()
  MenuItem(#MenuItem_7,  "Open Data Folder",ImageID(#FOLDER_ICON))
  MenuItem(#MenuItem_8,  "Open WHD Folder",ImageID(#FOLDER_ICON))
  MenuBar()
  MenuItem(#MenuItem_31, "Settings",ImageID(#OPTIONS_ICON))
  MenuBar()
  MenuItem(#MenuItem_5,  "Quit")
  MenuTitle("Create")
  MenuItem(#MenuItem_10,  "Make Image Folders")
  MenuItem(#MenuItem_10d, "Make Single Image")
  MenuBar()
  MenuItem(#MenuItem_12,  "Make PD Image Set")
  MenuItem(#MenuItem_13,  "Make PD Image")
  MenuBar()
  MenuItem(#MenuItem_10c, "Archive Folder")
  MenuItem(#MenuItem_10b, "Batch Archive Folders")
  MenuItem(#MenuItem_16,  "Quick Delete Folder")
  MenuBar()
  MenuItem(#MenuItem_10a, "Make CLRMame Dats")
  MenuItem(#MenuItem_18,  "Make AGS Folder")
  MenuBar()
  MenuItem(#MenuItem_11,  "Backup Images")
  MenuBar()
  MenuItem(#MenuItem_14,  "Create IG Database")
  MenuBar()
  MenuItem(#MenuItem_15,  "Re-Install Game")
  MenuItem(#MenuItem_17,  "Create WHD Drive")
  MenuBar()
  MenuItem(#MenuItem_19,  "Get All Install Sizes")
  MenuItem(#MenuItem_20,  "Get Install Size")
  MenuTitle("Database")
  MenuItem(#MenuItem_21, "Update FTP")
  MenuItem(#MenuItem_22, "Update Database")
  MenuItem(#MenuItem_22a, "Update HDF")
  MenuItem(#MenuItem_23,  "Update Full")
  MenuBar() 
  MenuItem(#MenuItem_28,  "Get ReadMe")
; 
;   MenuItem(#MenuItem_6,  "Audit Games")
  MenuBar()
  MenuItem(#MenuItem_25, "Add CD32 Entry")
  MenuItem(#MenuItem_26, "Delete Entry")
  MenuItem(#MenuItem_27, "Edit Entry")
  MenuBar()
  MenuItem(#MenuItem_45, "Reload Genres")
  MenuItem(#MenuItem_46, "Refresh"+Chr(9)+"F5")
  MenuTitle("Web")
  MenuItem(#MenuItem_9,  "Hall Of Light",ImageID(#HOL_ICON))
  MenuItem(#MenuItem_9a,  "Lemon Amiga",ImageID(#LEMON_ICON))
  MenuItem(#MenuItem_9b,  "WHDLoad",ImageID(#WHD_ICON))
  DisableMenuItem(Main_Menu,#MenuItem_25,1)
  DisableMenuItem(Main_Menu,#MenuItem_2,1)
  DisableMenuItem(Main_Menu,#MenuItem_2a,1)
  
  If IFF_Smooth=#PB_Image_Raw
    SetMenuItemState(Main_Menu,#MenuItem_20,#False)
  Else
    SetMenuItemState(Main_Menu,#MenuItem_20,#True)
  EndIf
  
  If CreatePopupMenu(#EDITOR_MENU)
    MenuItem(#MenuItem_96, "Copy Info")
    MenuItem(#MenuItem_97, "Paste Info")
    MenuItem(#MenuItem_98, "Clear Info")
    MenuItem(#MenuItem_99, "Edit Info")
    MenuBar()
    MenuItem(#MenuItem_99a, "Copy Data")
    MenuItem(#MenuItem_99b, "Paste Data")
  EndIf
  
EndProcedure

Procedure Draw_Main_Panel(offset.i)
  
  PanelGadget(#MAIN_PANEL,10,0,482,655)
  AddGadgetItem(#MAIN_PANEL,1,"WHDLoad")
  ListIconGadget(#MAIN_LIST, 0, 0, DpiX(GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemWidth)), DpiY(GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight)), "Number", 40, #PB_ListIcon_GridLines | #LVS_NOCOLUMNHEADER | #PB_ListIcon_FullRowSelect)
  SetWindowLongPtr_(GadgetID(#MAIN_LIST),#GWL_EXSTYLE,0)
  SetWindowPos_(GadgetID(#MAIN_LIST),0,0,0,DpiX(GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemWidth)),DpiY(GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight)),#SWP_FRAMECHANGED)
  
  AddGadgetItem(#MAIN_PANEL,1,"CD32") 
  ListIconGadget(#CD32_LIST, 0, 0,GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemWidth), GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight), "Column 1", 100, #PB_ListIcon_GridLines | #LVS_NOCOLUMNHEADER | #PB_ListIcon_FullRowSelect)
  SetWindowPos_(GadgetID(#CD32_LIST),0,0,0,DpiX(GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemWidth)),DpiY(GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight)),#SWP_FRAMECHANGED)
  
  AddGadgetItem(#MAIN_PANEL,2,"Systems") 
  ListIconGadget(#SYSTEM_LIST, 0, 0, GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemWidth), GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight), "Column 1", 100, #PB_ListIcon_GridLines | #LVS_NOCOLUMNHEADER | #PB_ListIcon_FullRowSelect)
  SetWindowPos_(GadgetID(#SYSTEM_LIST),0,0,0,DpiX(GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemWidth)),DpiY(GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight)),#SWP_FRAMECHANGED)
  
  AddGadgetItem(#MAIN_PANEL,3,"Magazines") 
  TreeGadget(#MAGAZINE_TREE, 0, 0, GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemWidth), GetGadgetAttribute(#MAIN_PANEL,#PB_Panel_ItemHeight))
  CloseGadgetList()
  
EndProcedure

Procedure Draw_Media_Panel(offset)
  
  Protected Null.l
  
  ContainerGadget(#EXTRA_PANEL,495,0,658,742)
  Title_Image = CanvasGadget(#PB_Any, 4, 10, 320, 256)
  Screen_Image = CanvasGadget(#PB_Any, 328, 10, 320, 256)
  Cover_Image = CanvasGadget(#PB_Any, 4, 270, 320, 412)
  Info_Gadget=EditorGadget(#PB_Any,328,270,320,382,#PB_Editor_ReadOnly|#PB_Editor_WordWrap)
  
  Play_Button=ButtonGadget(#PB_Any,328,660,40,22,"Play")
  Stop_Button=ButtonGadget(#PB_Any,372,660,40,22,"Stop")
  Volume_Slider=TrackBarGadget(#PB_Any,412,660,100,22,0,100,#PB_TrackBar_Ticks)
  Track_Combo=ComboBoxGadget(#PB_Any,516,660,130,22)
  
  SetGadgetState(Volume_Slider,Track_Volume)
  
  DestroyCaret_()
  
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
  
  Filter_Button=ButtonGadget(#PB_Any,10,660,70,22,"Filter (F4)") 
  
  Search_Gadget=StringGadget(#PB_Any,90,661,400,20,"",#PB_String_BorderLess)
  
  Protected combomem = AllocateMemory(40)
  PokeS(combomem, "Search...", -1, #PB_Unicode)
  SendMessage_(GadgetID(Search_Gadget), #EM_SETCUEBANNER, 0, combomem)
  SetWindowLongPtr_(GadgetID(Search_Gadget), #GWL_EXSTYLE, GetWindowLongPtr_(GadgetID(Search_Gadget), #GWL_EXSTYLE) | #WS_EX_STATICEDGE &~ #WS_EX_CLIENTEDGE)
  SetWindowPos_(GadgetID(Search_Gadget), 0, 0, 0, 0, 0, #SWP_NOZORDER | #SWP_NOMOVE | #SWP_NOSIZE | #SWP_FRAMECHANGED)
  
EndProcedure

;- ############### Run Procedures

Procedure Cleanup(nul)
  
  While ProgramRunning(startup_prog)
  Wend
  
  DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
  DeleteFile(GetPathPart(WinUAE_Path)+"plugins/overlays/test.png")
  
  If IsWindow(#RUN_WINDOW) : CloseWindow(#RUN_WINDOW) : EndIf
  
  If IsProgram(startup_prog) : CloseProgram(startup_prog) : EndIf
  
EndProcedure

Procedure Run_Game(gamenumber.i)
  
  Protected startup_file.i, old_pos.i, config.s, old_dir.s 
  
  SelectElement(UM_Database(), gamenumber)  
  
  old_pos=GetGadgetState(#MAIN_LIST)
  
  If FileSize(WHD_TempDir)=-2 : DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force) : EndIf
  
  If CreateDirectory(WHD_TempDir)
    
    SetCurrentDirectory(WHD_TempDir)
    
    startup_file=CreateFile(#PB_Any,"whd-startup",#PB_Ascii)
    
    If startup_file
      WriteString(startup_file,"cls"+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+""+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"T ================================================= |T "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"| ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|[L"+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"| __________________________________________________[| "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"|I __==___________  ___________     . ,,. _ .   __  T| "+#DOUBLEQUOTE$+#LF$)
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
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"            ____ "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"           / / / "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"          / / /  UltraMiggy "+Version+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"         / / /   "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"        / / /    "+UM_Database()\UM_Title+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"       / / /     "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"____  / / /      By "+UM_Database()\UM_Publisher+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"\ \ \/ / /       "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+" \ \ \/ /        © "+UM_Database()\UM_Year+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"  \_\_\/         "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+""+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+""+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"wait 2 SECS"+#LF$)
      WriteString(startup_file,"cd WHD-HDD:"+#LF$)
      WriteString(startup_file,"cd "+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+"/"+#LF$)
      WriteString(startup_file,"kgiconload "+UM_Database()\UM_Icon+#LF$)
      If Close_UAE  
        WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"Waiting for disk activity to finish..."+#DOUBLEQUOTE$+#LF$)
        WriteString(startup_file,"wait 4 SECS"+#LF$)
        WriteString(startup_file,"uaequit")
      EndIf
      FlushFileBuffers(startup_file)
      CloseFile(startup_file)      
    EndIf
    
    config=""
    
    Select UM_Database()\UM_Config
      Case 0 : If Use_Bezels : config=IG_Path+"A1200_WHD_TEST.uae" : Else : config=IG_Path+"A1200_WHD.uae" : EndIf
      Case 1 : config=IG_Path+"A1200_WHD_COMPAT.uae"
      Case 2 : config=IG_Path+"A1200_WHD_030.uae"
      Case 3 : config=IG_Path+"A1200_WHD_040.uae"
      Case 4 : config=IG_Path+"A1200_WHD_CD32.uae"
      Case 5 : config=IG_Path+"A600_WHD.uae"
    EndSelect
    
    OpenWindow(#RUN_WINDOW,0,0,360,60,"Starting WinUAE. Please Wait...",#PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
    TextGadget(#PB_Any,10,15,340,50,"Loading: "+UM_Database()\UM_Title+Tags(),#PB_Text_Center)
    
    If Use_Bezels : Create_Bezel(Bezel_Type) : EndIf
    
    startup_prog=RunProgram(WinUAE_Path, "-f "+config+" -s filesystem2=rw,DH1:WHDTemp:"+WHD_TempDir+",0","",#PB_Program_Open)
    
    CreateThread(@Cleanup(),0)
    
    Delay(2000)
    
    HideWindow(#RUN_WINDOW,#True)
    
    SetCurrentDirectory(home_path)
    
  EndIf
    
EndProcedure

Procedure Run_CD32(gamenumber.i)
  
  Protected output$, old_pos.i
  
  old_pos=GetGadgetState(#CD32_LIST)
  
  DisableWindow(#MAIN_WINDOW,#True)
  
  SelectElement(CD32_Database(),gamenumber)
  
  If CD32_Database()\CD_Config=0
    output$=" -f "+IG_Path+"CD32.uae -cfgparam cdimage0="+#DOUBLEQUOTE$+CD32_Path+CD32_Database()\CD_Folder+"\"+CD32_Database()\CD_File+#DOUBLEQUOTE$+","
  EndIf
  If CD32_Database()\CD_Config=1
    output$=" -f "+IG_Path+"CD32-4MB.uae -cfgparam cdimage0="+#DOUBLEQUOTE$+CD32_Path+CD32_Database()\CD_Folder+"\"+CD32_Database()\CD_File+#DOUBLEQUOTE$+","
  EndIf
  If CD32_Database()\CD_Config=2
    output$=" -f "+IG_Path+"CD32-8MB.uae -cfgparam cdimage0="+#DOUBLEQUOTE$+CD32_Path+CD32_Database()\CD_Folder+"\"+CD32_Database()\CD_File+#DOUBLEQUOTE$+","
  EndIf
  
  OpenWindow(#RUN_WINDOW,0,0,360,60,"Starting WinUAE. Please Wait...",#PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
  TextGadget(#PB_Any,10,15,340,50,"Loading: "+CD32_Database()\CD_Title+CD32_Tags(),#PB_Text_Center)
  
  ;If Use_Bezels : Create_Bezel(Bezel_Type) : EndIf
  
  Debug output$
  
  startup_prog=RunProgram(WinUAE_Path,output$,"",#PB_Program_Open)
  
  CreateThread(@Cleanup(),0)
  
  Delay(2000)
  
  CloseWindow(#RUN_WINDOW)
  
  DisableWindow(#MAIN_WINDOW,#False)
  
  SetActiveGadget(#CD32_LIST)
  SetGadgetState(#CD32_LIST,old_pos)
  
EndProcedure

Procedure Run_System(gamenumber.i)
  
  Protected output$, startup_prog.i, old_pos.i
  
  ;old_pos=GetGadgetState(#CD32_LIST)
  
  DisableWindow(#MAIN_WINDOW,#True)
  
  SelectElement(Systems_Database(),gamenumber)
  
  output$=" -f "+#DOUBLEQUOTE$+IG_Path+Systems_Database()\Sys_File+#DOUBLEQUOTE$+" -cfgparam use_gui=no"
  
  startup_prog=RunProgram(WinUAE_Path,output$,"",#PB_Program_Wait)
  
  DisableWindow(#MAIN_WINDOW,#False)
  
  ;SetActiveGadget(#CD32_LIST)
  ;SetGadgetState(#CD32_LIST,old_pos)
  
EndProcedure

;- ############### File I/O Procedures

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
      UM_Database()\UM_Icon=Fix_List()\F_Default_Icon
      UM_Database()\UM_Alt_Name=Fix_List()\F_Alt_Name
      UM_Database()\UM_Alt_Name_Short=Fix_List()\F_Alt_Name_Short
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
  
  ForEach UM_Database()
    UM_Database()\UM_Sort=UM_Database()\UM_Title+Tags()
  Next
    
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
    Fix_List()\F_Default_Icon=UM_Database()\UM_Icon
    Fix_List()\F_Alt_Name=UM_Database()\UM_Alt_Name
    Fix_List()\F_Alt_Name_Short=UM_Database()\UM_Alt_Name_Short
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

Procedure Save_IG_DB()
  
  Protected IG_File, IG_Name.s, IG_Name_Short.s
  
  IG_File=CreateFile(#PB_Any,Home_Path+"IG_Data",#PB_Ascii)
  
  If IG_File
    ForEach UM_Database()
      If UM_Database()\UM_Alt_Name<>""
        IG_Name=UM_Database()\UM_Alt_Name
      Else
        IG_Name=UM_Database()\UM_Title
      EndIf
      If UM_Database()\UM_Alt_Name_Short<>""
        IG_Name_Short=UM_Database()\UM_Alt_Name_Short
      Else
        IG_Name_Short=UM_Database()\UM_Short
      EndIf
      WriteStringN(IG_File,UM_Database()\UM_Slave+";"+UM_Database()\UM_Folder+";"+UM_Database()\UM_Genre+";"+IG_Name+Tags()+";"+IG_Name_Short+Tags_Short()+";"+UM_Database()\UM_Icon+";"+UM_Database()\UM_LHAFile)
    Next
  EndIf
  
  FlushFileBuffers(IG_File)
  
  CloseFile(IG_File)
  
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
        output$+UM_Database()\UM_Title+Tags()+";"   
        output$+UM_Database()\UM_Genre+";"
        output$+"WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+"/"+UM_Database()\UM_Slave+";"
        output$+"0;0;0;0"
        WriteString(igfile3,output$+#LF$)
      Next
      
      CloseFile(igfile3)
      
    EndIf
    
  EndIf
  
EndProcedure

Procedure Save_Prefs()
  If CreatePreferences(Data_Path+"um.prefs")
    PreferenceGroup("Paths")
    WritePreferenceString("Game_Data_Path",Game_Data_Path)
    WritePreferenceString("LHA_Path",LHA_Path)
    WritePreferenceString("IZARC_Path",IZARC_Path)
    WritePreferenceString("LZX_Path",LZX_Path)
    WritePreferenceString("NConvert_Path",NConvert_Path)
    WritePreferenceString("Temp_Path",WHD_TempDir)
    WritePreferenceString("UAECFG_Path",IG_Path)
    WritePreferenceString("WHD_Path",WHD_Folder)
    WritePreferenceString("WinUAE_Path",WinUAE_Path)
    WritePreferenceString("Data_Path",Data_Path)
    WritePreferenceLong("IFF_Smooth",IFF_Smooth)
    WritePreferenceLong("Short_Names",Short_Names)
    WritePreferenceLong("JSON_Backup",JSON_Backup)
    WritePreferenceLong("Show_Tags",Show_Tags)
    WritePreferenceLong("Use_Bezels",Use_Bezels)
    WritePreferenceLong("Bezel_Source",Bezel_Source)
    WritePreferenceLong("Bezel_Type",Bezel_Type)
    WritePreferenceLong("Close_UAE",Close_UAE)
    WritePreferenceString("Bezel_Background",Bezel_Background)
    ClosePreferences()
  Else
    MessageRequester("Error","Cannot create prefs file.",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
  EndIf
EndProcedure

Procedure Load_Prefs()
  
  If OpenPreferences(Data_Path+"um.prefs")
    PreferenceGroup("Paths")
    Game_Data_Path=ReadPreferenceString("Game_Data_Path",Game_Data_Path)
    LHA_Path=ReadPreferenceString("LHA_Path",LHA_Path)
    IZARC_Path=ReadPreferenceString("IZARC_Path",IZARC_Path)
    LZX_Path=ReadPreferenceString("LZX_Path",LZX_Path)
    NConvert_Path=ReadPreferenceString("NConvert_Path",NConvert_Path)
    WHD_TempDir=ReadPreferenceString("Temp_Path",WHD_TempDir)
    IG_Path=ReadPreferenceString("UAECFG_Path",IG_Path)
    WHD_Folder=ReadPreferenceString("WHD_Path",WHD_Folder)
    WinUAE_Path=ReadPreferenceString("WinUAE_Path",WinUAE_Path)
    Data_Path=ReadPreferenceString("Data_Path",Data_Path)
    IFF_Smooth=ReadPreferenceLong("IFF_Smooth",IFF_Smooth)
    Short_Names=ReadPreferenceLong("Short_Names",Short_Names)
    JSON_Backup=ReadPreferenceLong("JSON_Backup",JSON_Backup)
    Show_Tags=ReadPreferenceLong("Show_Tags",Show_Tags)
    Use_Bezels=ReadPreferenceLong("Use_Bezels",Use_Bezels)
    Bezel_Source=ReadPreferenceLong("Bezel_Source",Bezel_Source)
    Bezel_Type=ReadPreferenceLong("Bezel_Type",Bezel_Type)
    Close_UAE=ReadPreferenceLong("Close_UAE",Close_UAE)
    Bezel_Background=ReadPreferenceString("Bezel_Background",Bezel_Background)
    ClosePreferences()
  Else
    MessageRequester("Error","Cannot read prefs file.",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
  EndIf
  
EndProcedure

;- ############### Database Procedures

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

Procedure Audit_Images()
  
  Protected NewMap DB_Map.s()
  Protected NewList Delete_List.s()
  
  OpenConsole("Check Images")  
  ConsoleCursor(0)
  ClearList(File_List())
  
  PrintNCol("Checking Images...",9,0)
  PrintS()
  PrintNCol("Scanning Folders. Please Wait...",7,0)  
  
  List_Files_Recursive(Game_Data_Path,File_List(),"*.png") ; Create Archive List
  
  ForEach UM_Database()
    path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png"
    DB_Map(LCase(path))=path
    path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png"
    DB_Map(LCase(path))=path
    path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png"
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

Procedure Check_Missing_Images(type.i)
  
  Protected path2.s
  
  ForEach UM_Database()  
    UM_Database()\UM_Image_Avail=#False
    UM_Database()\UM_Cover_Avail=#False
    
    If type=1
      path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png"
      If FileSize(path)>0
        UM_Database()\UM_Image_Avail=#True
      Else
        UM_Database()\UM_Image_Avail=#False
      EndIf
    EndIf
    
    If type=2
      path2=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png"
      If FileSize(path2)>0
        UM_Database()\UM_Cover_Avail=#True
      Else
        UM_Database()\UM_Cover_Avail=#False
      EndIf
    EndIf
    
    If type=3
      path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png"
      If FileSize(path)>0
        UM_Database()\UM_Title_Avail=#True
      Else
        UM_Database()\UM_Title_Avail=#False
      EndIf
    EndIf
    
  Next
  
EndProcedure

;- ############### Update Procedures

Procedure.s Process_Date(type.s,string.s) ; Returns the date in the right format for slave comparison on the Amiga
  
  Protected Date$, Year$, Month$, Day$
  
  If type="lha" 
    Date$=StringField(string,1," ")
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
  EndIf
  
  If type="lzx"
    Date$=Mid(string,27,12)
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
  EndIf
  
  ProcedureReturn Day$+"-"+Month$+"-"+Year$
  
EndProcedure

Procedure.s Check_Icon_File(file.s) ; Gets slave name from info file
  
  Protected response.s, output$, Icon_file.i, count.i, cut.i
  
  response=""
  Icon_file=ReadFile(#PB_Any,file)
  If Icon_file
    While Not Eof(Icon_file)
      output$=ReadString(Icon_file,#PB_Ascii)
      output$=LCase(output$)
      If FindString(output$,"slave=")
        count=FindString(output$,"=")
        cut=Len(output$)-count
        output$=Right(output$,cut)
        response=output$
        Break
      EndIf
    Wend 
    CloseFile(Icon_file)
  Else
    MessageRequester("Error","Cannot open "+file, #PB_MessageRequester_Error|#PB_MessageRequester_Ok)
  EndIf
  
  ProcedureReturn response
  
EndProcedure

Procedure Extract_Text_Files_Single(archive_path.s)
  
  Protected result.i, length.i, UM_Program.i, ReadO$, output$
  
  Protected NewList Text_Files.s()
   
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
  CreateDirectory("Game_Data\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\")
  CreateDirectory("Game_Data\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder)
  
  path="Game_Data\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"
  
  ForEach Text_Files()
    CopyFile(Home_Path+StringField(Text_Files(),2,"\"),path+StringField(Text_Files(),2,"\")+".txt")
    DeleteFile(Home_Path+StringField(Text_Files(),2,"\"))
  Next
  
  FreeList(Text_Files())  
  
  path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"
  RunProgram("file://"+path)
  
EndProcedure

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
  Protected UM_Program.i, time.i, name$
  
  ;tempfolder=GetTemporaryDirectory()+"um_temp\"
  main_ftp="Retroplay WHDLoad Packs"
  ftp_server="grandis.nu"
  ftp_user="ftp"
  ftp_pass="amiga"
  ftp_passive=#True
  ftp_port=21
  
  ;{ 1. Download dat files #####################################################################################################################################################################  
  
  ;CreateDirectory(tempfolder)
  
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
                If FTPDirectoryEntrySize(#FTP)>0
                  If FileSize(Dats_Path+FTPDirectoryEntryName(#FTP))=-1 ; If the dat file doesn't exist, download it  
                    PrintN("Downloading : "+FTPDirectoryEntryName(#FTP))
                    ReceiveFTPFile(#FTP,FTPDirectoryEntryName(#FTP),Dats_Path+FTPDirectoryEntryName(#FTP))
                  EndIf
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
  Else
    PrintNCol("Error: Can't Connect To FTP.",3,0)
    Delay(1000)
    Goto Proc_Exit
  EndIf
  
  PrintS()
  PrintNCol("Processing Dat Files...",9,0)
  
  SetCurrentDirectory(Dats_Path)  
  
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
      Goto Proc_Exit
    EndIf
  Next
    
  Protected NewMap File_Map.s()
  Protected NewList New_List.s()
  
  List_Files_Recursive(Dats_Path,New_List(),"*.zip") ; Scan all the files in the dat folder
  
  ForEach Dat_List() ; Load the datfiles into a map
    File_Map(Dats_Path+Dat_List())=""
  Next
  
  ForEach New_List() ; compare the file list to the dat folder map and delete anythin not needed
    If Not FindMapElement(File_Map(),New_List()) : DeleteFile(New_List(),#PB_FileSystem_Force) : EndIf
  Next
  
  FreeMap(File_Map())
  FreeList(New_List())
  
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
  
  ;DeleteDirectory(tempfolder,"",#PB_FileSystem_Force)
  
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
  ;{ 5. Download new archives ##############################################################################################################################################
  
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
      CloseFTP(#FTP)
    Else
      PrintN("Error: Can't Connect To FTP.")
      Delay(2000)
      Goto Proc_Exit
    EndIf
    
  Else
    
    PrintS()
    PrintNCol("Archives Up To Date!",2,0)
    Delay(1000)
    
  EndIf
  
  ;}
  
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

Procedure.s Version(v_file.s)
  
  Protected output$
  
  CreateRegularExpression(#REGEX,"(?i)_v[0-9].[0-9][0-9](\.|_)")
  ExamineRegularExpression(#REGEX,v_file)
  While NextRegularExpressionMatch(#REGEX)
    Path=RemoveString(RegularExpressionMatchString(#REGEX),"_")
    output$=path
  Wend
  FreeRegularExpression(#REGEX)
  
  CreateRegularExpression(#REGEX,"(?i)_v[0-9].[0-9](\.|_)")
  ExamineRegularExpression(#REGEX,v_file)
  While NextRegularExpressionMatch(#REGEX)
    Path=RemoveString(RegularExpressionMatchString(#REGEX),"_")
    output$=path
  Wend
  FreeRegularExpression(#REGEX)
  
  CreateRegularExpression(#REGEX,"(?i)_v[0-9].[0-9][a-z](\.|_)")
  ExamineRegularExpression(#REGEX,v_file)
  While NextRegularExpressionMatch(#REGEX)
    Path=RemoveString(RegularExpressionMatchString(#REGEX),"_")
    output$=path
  Wend
  FreeRegularExpression(#REGEX)
  
  CreateRegularExpression(#REGEX,"(?i)_v[0-9].[0-9][a-z][0-9](\.|_)")
  ExamineRegularExpression(#REGEX,v_file)
  While NextRegularExpressionMatch(#REGEX)
    Path=RemoveString(RegularExpressionMatchString(#REGEX),"_")
    output$=path
  Wend
  FreeRegularExpression(#REGEX)
  
  CreateRegularExpression(#REGEX,"(?i)_v[0-9].[0-9]-[a-z](\.|_)")
  ExamineRegularExpression(#REGEX,v_file)
  While NextRegularExpressionMatch(#REGEX)
    Path=RemoveString(RegularExpressionMatchString(#REGEX),"_")
    output$=path
  Wend
  FreeRegularExpression(#REGEX)
  
  CreateRegularExpression(#REGEX,"(?i)_v[0-9].[0-9][0-9][a-z](\.|_)")
  ExamineRegularExpression(#REGEX,v_file)
  While NextRegularExpressionMatch(#REGEX)
    Path=RemoveString(RegularExpressionMatchString(#REGEX),"_")
    output$=path
  Wend
  FreeRegularExpression(#REGEX)
  
  CreateRegularExpression(#REGEX,"(?i)_v[0-9].[0-9].[0-9](\.|_)")
  ExamineRegularExpression(#REGEX,v_file)
  While NextRegularExpressionMatch(#REGEX)
    Path=RemoveString(RegularExpressionMatchString(#REGEX),"_")
    output$=path
  Wend
  FreeRegularExpression(#REGEX)
  
  CreateRegularExpression(#REGEX,"(?i)_v[0-9].[0-9].[0-9][a-z](\.|_)")
  ExamineRegularExpression(#REGEX,v_file)
  While NextRegularExpressionMatch(#REGEX)
    Path=RemoveString(RegularExpressionMatchString(#REGEX),"_")
    output$=path
  Wend
  FreeRegularExpression(#REGEX)
  
  If Right(output$,1)="." : output$=RTrim(output$,".") : EndIf
  
  ProcedureReturn output$
  
EndProcedure

Procedure.i Compare_Versions(lha_file.s)
  
  Protected response.i, old_file.s, new_file.s
  
  response=-1
  
  ForEach UM_Database()
    old_file=LCase(RemoveString(UM_Database()\UM_LHAFile,Version(UM_Database()\UM_LHAFile)))
    new_file=LCase(RemoveString(lha_file,Version(lha_file)))
    Debug old_file
    Debug new_file
    If old_file=new_file
      response=ListIndex(UM_Database())
      Break
    EndIf
  Next
  
  ProcedureReturn response
  
EndProcedure

Procedure Add_Database_Entry(add_archive.s)
  
  Protected ReadO$, Output$, SubFolder$, length.i, UM_Program.i, zeros.i
  Protected old_path.s, command.s, response.s, date$
  
  Protected NewList Icon_List.Icon_Data()      ; List for icons in archive.
  Protected NewList Copy_List.Copy_Struct()
  
  ClearList(Icon_List())
  
  PrintN("Processing "+GetFilePart(add_archive)) ; Display which archive is being processed
  
  CreateDirectory(WHD_TempDir)
  
  ; Create Icon List
  
  path=add_archive
  
  ; Extracts the archive info and populates the Icon_List
  
  If GetExtensionPart(add_archive)="lha"
    UM_Program=RunProgram(LHA_Path,"l "+path,GetCurrentDirectory(),#PB_Program_Open|#PB_Program_Read)
  EndIf
  
  If GetExtensionPart(add_archive)="lzx"
    UM_Program=RunProgram(LZX_Path,"-v "+path,GetCurrentDirectory(),#PB_Program_Open|#PB_Program_Read)
  EndIf
  
  Output$="" ; String for program output
  
  If UM_Program   
    
    While ProgramRunning(UM_Program)
      If AvailableProgramOutput(UM_Program) ; Read output into memory
        Output$+ReadProgramString(UM_Program,#PB_Ascii)+#CRLF$
      EndIf
    Wend      
    
    Output$=ReplaceString(Output$,"\", "/")
    
    count=CountString(Output$,#CRLF$)
    
    For i=1 To count
      ReadO$=StringField(Output$,i,#CRLF$)
      
      If FindString(ReadO$,".info",0,#PB_String_NoCase) Or FindString(ReadO$,".slave",0,#PB_String_NoCase)    ; Read only info and slave files from output          
        If GetExtensionPart(add_archive)="lha"
          zeros=53 ; Set 53 characters for lha files
        EndIf
        If GetExtensionPart(add_archive)="lzx"
          zeros=49 ; Set 49 characters for lzx files
        EndIf
        path=Right(ReadO$,Len(ReadO$)-zeros) ; remove irrelevent info from text line
        path=RemoveString(path,#DOUBLEQUOTE$); remove quotes
        If CountString(path,"/")=1           ; only process files from the root folder
          AddElement(Icon_List())
          Icon_List()\Icon_File=path ; Archive name
          path=StringField(path,2,"/")
          Icon_List()\Icon_Name=path ; File Name
          If FindString(path,".slave",0,#PB_String_NoCase)  
            date$=Process_Date(GetExtensionPart(add_archive),ReadO$) ; Get Slave Date
          EndIf
        Else
          Continue
        EndIf
      EndIf 
      
    Next
    
  EndIf               
  
  path=add_archive
  
  ; Extract Info Files To Temp Folder
  
  SetCurrentDirectory(WHD_TempDir)
  
  ForEach Icon_List() ; Extract all the icon files
    PrintN("Extracting: "+Icon_List()\Icon_Name+" - "+#DOUBLEQUOTE$+Icon_List()\Icon_File+#DOUBLEQUOTE$)
    If GetExtensionPart(UM_Database()\UM_LHAFile)="lha"
      command="x "+path+" -o"+WHD_TempDir+" "+#DOUBLEQUOTE$+Icon_List()\Icon_File+#DOUBLEQUOTE$
      UM_Program=RunProgram(LHA_Path,command,GetCurrentDirectory(),#PB_Program_Wait)
    EndIf
    If GetExtensionPart(UM_Database()\UM_LHAFile)="lzx"
      command="-x "+path+" -o "+WHD_TempDir+" -p "+Icon_List()\Icon_File
      UM_Program=RunProgram(LZX_Path,command,GetCurrentDirectory(),#PB_Program_Wait)
    EndIf
  Next
  
  ForEach Icon_List() ; Check all the icon files for a slave entry and add to a list
    path=WHD_TempDir+"\"+ReplaceString(Icon_List()\Icon_File,"/","\")
    response=Check_Icon_File(path)
    If response<>""
      AddElement(Copy_List())
      count=CountString(path,"\")
      Copy_List()\Copy_Folder=StringField(path,count,"\")
      Copy_List()\Copy_File=StringField(path,count+1,"\")
      Copy_List()\Copy_Slave=response
    EndIf
  Next
  
  ForEach Copy_List() ; Process copy List and add data to database
    count=CountString(add_archive,"\")
    AddElement(UM_Database())
    UM_Database()\UM_Subfolder=StringField(add_archive,count,"\")
    UM_Database()\UM_LHAFile=StringField(add_archive,count+1,"\")
    UM_Database()\UM_Type=StringField(add_archive,count-1,"\")
    If UM_Database()\UM_Type="Beta" : UM_Database()\UM_Beta=#True : EndIf
    UM_Database()\UM_Icon=Copy_List()\Copy_File
    UM_Database()\UM_Slave=Copy_List()\Copy_Slave
    UM_Database()\UM_Slave_Date=date$
    UM_Database()\UM_Genre="Unknown"
    If UM_Database()\UM_Type="Demo" : UM_Database()\UM_Genre="Demo" : EndIf
    UM_Database()\UM_Players="1"
    Language("Cz","Czech")
    Language("De","German")
    Language("Dk","Danish")
    Language("Es","Spanish")
    Language("Fi","Finnish")
    Language("Fr","French")
    Language("Gr","Greek")
    Language("It","Italian")
    Language("Nl","Dutch")
    Language("Pl","Polish")
    Language("Se","Swedish")
    Language("DeFrIt","Multi")
    Language("DeEsFrIt","Multi")
    If UM_Database()\UM_Language="" : UM_Database()\UM_Language="English" : EndIf
    If FindString(UM_Database()\UM_LHAFile,"AGA")
      UM_Database()\UM_AGA=#True
    Else
      UM_Database()\UM_ECSOCS=#True
    EndIf
    If FindString(UM_Database()\UM_LHAFile,"CD32")
      UM_Database()\UM_CD32=#True
      UM_Database()\UM_AGA=#True
      UM_Database()\UM_ECSOCS=#False
    EndIf
    If FindString(UM_Database()\UM_LHAFile,"NTSC")
      UM_Database()\UM_NTSC=#True
    EndIf
    UM_Database()\UM_Folder=Copy_List()\Copy_Folder
    UM_Database()\UM_Title=Split_On_Capital(GetFilePart(add_archive,#PB_FileSystem_NoExtension))
    UM_Database()\UM_Short=UM_Database()\UM_Title
    UM_Database()\UM_WHD_Entry=GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)
    UM_Database()\UM_Version=Version(add_archive)
    UM_Database()\UM_InstallSize=Get_Install_Size(add_archive)
  Next
  
  ClearList(Copy_List())
  ClearList(Icon_List())
  
  DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Force|#PB_FileSystem_Recursive) 
  
  SetCurrentDirectory(Home_Path)
  
  FreeList(Icon_List())
  FreeList(Copy_List())
  
  SelectElement(UM_Database(),List_Numbers())

EndProcedure

Procedure Update_Database_Entry(add_archive.s,add_index.i)
  
  Protected ReadO$, Output$, SubFolder$, length.i, UM_Program.i, zeros.i
  Protected old_path.s, command.s, response.s, date$
  
  Protected NewList Icon_List.Icon_Data()      ; List for icons in archive.
  Protected NewList Copy_List.Copy_Struct()
  
  ClearList(Icon_List())
  
  PrintN("Processing "+GetFilePart(add_archive)) ; Display which archive is being processed
  
  CreateDirectory(WHD_TempDir)
  
  ; Create Icon List
  
  path=add_archive ; new archive name
  
  ; Extracts the archive info and populates the Icon_List
  
  If GetExtensionPart(add_archive)="lha"
    UM_Program=RunProgram(LHA_Path,"l "+path,GetCurrentDirectory(),#PB_Program_Open|#PB_Program_Read)
  EndIf
  
  If GetExtensionPart(add_archive)="lzx"
    UM_Program=RunProgram(LZX_Path,"-v "+path,GetCurrentDirectory(),#PB_Program_Open|#PB_Program_Read)
  EndIf
  
  Output$="" ; String for program output
  
  If UM_Program   
    
    While ProgramRunning(UM_Program)
      If AvailableProgramOutput(UM_Program) ; Read output into memory
        Output$+ReadProgramString(UM_Program,#PB_Ascii)+#CRLF$
      EndIf
    Wend      
    
    Output$=ReplaceString(Output$,"\", "/")
    
    count=CountString(Output$,#CRLF$)
    
    For i=1 To count
      ReadO$=StringField(Output$,i,#CRLF$)
      
      If FindString(ReadO$,".info",0,#PB_String_NoCase) Or FindString(ReadO$,".slave",0,#PB_String_NoCase)    ; Read only info and slave files from output          
        If GetExtensionPart(add_archive)="lha"
          zeros=53 ; Set 53 characters for lha files
        EndIf
        If GetExtensionPart(add_archive)="lzx"
          zeros=49 ; Set 49 characters for lzx files
        EndIf
        path=Right(ReadO$,Len(ReadO$)-zeros) ; remove irrelevent info from text line
        path=RemoveString(path,#DOUBLEQUOTE$); remove quotes
        If CountString(path,"/")=1           ; only process files from the root folder
          AddElement(Icon_List())
          Icon_List()\Icon_File=path ; Archive name
          path=StringField(path,2,"/")
          Icon_List()\Icon_Name=path ; File Name
          If FindString(path,".slave",0,#PB_String_NoCase)  
            date$=Process_Date(GetExtensionPart(add_archive),ReadO$) ; Get Slave Date
          EndIf
        Else
          Continue
        EndIf
      EndIf 
      
    Next
    
  EndIf               
  
  path=add_archive
  
  ; Extract Info Files To Temp Folder
  
  SetCurrentDirectory(WHD_TempDir)
  
  ForEach Icon_List() ; Extract all the icon files
    PrintN("Extracting: "+Icon_List()\Icon_Name+" - "+#DOUBLEQUOTE$+Icon_List()\Icon_File+#DOUBLEQUOTE$)
    If GetExtensionPart(UM_Database()\UM_LHAFile)="lha"
      command="x "+path+" -o"+WHD_TempDir+" "+#DOUBLEQUOTE$+Icon_List()\Icon_File+#DOUBLEQUOTE$
      UM_Program=RunProgram(LHA_Path,command,GetCurrentDirectory(),#PB_Program_Wait)
    EndIf
    If GetExtensionPart(UM_Database()\UM_LHAFile)="lzx"
      command="-x "+path+" -o "+WHD_TempDir+" -p "+Icon_List()\Icon_File
      UM_Program=RunProgram(LZX_Path,command,GetCurrentDirectory(),#PB_Program_Wait)
    EndIf
  Next
  
  ForEach Icon_List() ; Check all the icon files for a slave entry and add to a list
    path=WHD_TempDir+"\"+ReplaceString(Icon_List()\Icon_File,"/","\")
    response=Check_Icon_File(path)
    If response<>""
      AddElement(Copy_List())
      count=CountString(path,"\")
      Copy_List()\Copy_Folder=StringField(path,count,"\")
      Copy_List()\Copy_File=StringField(path,count+1,"\")
      Copy_List()\Copy_Slave=response
    EndIf
  Next
  
  count=CountString(add_archive,"\")
  SelectElement(UM_Database(),add_index)
  UM_Database()\UM_Icon=Copy_List()\Copy_File
  old_path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)
  path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)
  RenameFile(old_path+"_Screen.png",path+"_Screen.png")
  RenameFile(old_path+"_Title.png",path+"_Title.png")
  RenameFile(old_path+"_Cover.png",path+"_Cover.png")
  UM_Database()\UM_LHAFile=StringField(add_archive,count+1,"\")
  UM_Database()\UM_Slave=Copy_List()\Copy_Slave
  UM_Database()\UM_Slave_Date=date$
  UM_Database()\UM_Version=Version(add_archive)
  UM_Database()\UM_InstallSize=Get_Install_Size(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile)
  
  ClearList(Copy_List())
  ClearList(Icon_List())
  
  DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Force|#PB_FileSystem_Recursive) 
  
  SetCurrentDirectory(Home_Path)
  
  FreeList(Icon_List())
  FreeList(Copy_List())
  
  SelectElement(UM_Database(),List_Numbers())
  
EndProcedure

Procedure Update_Database()
    
  Structure Update_Info
    Update_Name.s
    Update_Index.i
  EndStructure
  
  Protected NewMap  Folder_Check.i()   ; Folder & Slave Lookup Map 
  Protected NewList Check_List.s()     ; Not Found List Of Main DB Element Numbers
  Protected NewList Update_List.Update_Info()       ; Not Found List Of Main DB Element Numbers
  Protected NewList New_List.s()                    ; Not Found List Of Main DB Element Numbers
  Protected NewMap  Check_Archives.i()              ; LHA Lookup Map
  
  
  Protected ReadO$, Output$, SubFolder$, length.i, UM_Program.i, zeros.i
  Protected old_path.s, command.s, response.s, date$
  
  OpenConsole("Update...")
  ConsoleCursor(0) 
  
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
      Check_Archives(UM_Database()\UM_LHAFile)=0  ; Map To check If WHD archive exists
    Next
    
    ; Scan through file list and if the file is not in the database, add it to a list to be checked. 
    
    ForEach File_List()
      If Not FindMapElement(Check_Archives(),GetFilePart(File_List()))
        If GetFilePart(File_List())<>"EmeraldMines_v1.0_CD.lzx" And GetFilePart(File_List())<>"DangerFreak_v1.0_0975.lha"
          AddElement(Check_List())
          Check_List()=File_List()
        EndIf
      EndIf
    Next
    
    Protected reply.i
    
    If ListSize(Check_List())>0    
      
      ForEach Check_List()
        reply=Compare_Versions(GetFilePart(Check_List()))
        If reply<>-1
          AddElement(Update_List())
          Update_List()\Update_Name=Check_List()
          Update_List()\Update_Index=reply
        Else
          AddElement(New_List())
          New_List()=Check_List()
        EndIf
      Next
      
      ; REMEMBER ALWAYS UPDATE BEFORE YOU ADD OR THE INDEXES GET MUCKED UP!
      
      If ListSize(Update_List())>0  
        PrintN("Updating existing files...")
        ForEach Update_List()
          Update_Database_Entry(Update_List()\Update_Name,Update_List()\Update_Index)
        Next
      EndIf
      
      If ListSize(New_List())>0
        PrintN("Adding new entries...")
        ForEach New_List()
          Add_Database_Entry(New_List())
        Next
      EndIf
      
    Else
      
      PrintN("Nothing to update...")
      
    EndIf
    
  EndIf
        
  ;{ 8. Clean up the PC Drive ##############################################################################################################################################################################
  
  PrintS()
  PrintNCol("Cleaning Up Database...",9,0)
  
  ForEach UM_Database()
    
    ; Remove any folders that are no longer needed after update.
    
    If FileSize(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile)=-1
      PrintN(UM_Database()\UM_Title+" is no longer required. Delete (Y/N/C)?")
      Repeat : path2=Inkey() :  Until path2="Y" Or path2="y" Or path2="N" Or path2="n" Or path2="C" Or path2="c"
      If path2="y" Or path2="Y"
        
        PrintNCol("Backing Up Game Info...",4,0)
        PrintS()
        
        ; Backup Game Info
        
        Protected olddir.s
        
        olddir=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"
        
        Zip_Folder(olddir,Backup_Path+UM_Database()\UM_Folder+".zip")
        
        ; Delete selected database entry 
        
        PrintNCol("Deleting Database Entry For "+UM_Database()\UM_Title,4,0)
        DeleteElement(UM_Database())
        
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
  
  ; On error go to here!
  
  CleanUp:
  
  Delay(1000)
  
  CloseConsole()
  
  ; Clear Resources
  
  FreeMap(Folder_Check())
  FreeList(Check_List())
  FreeMap(Check_Archives())
  FreeList(Check_List())
  
EndProcedure

Procedure Update_HDF()
  
  Structure copy
    c_number.i
    c_olddate.s
    c_newdate.s
  EndStructure
  
  Protected NewList Miggy_List.s()
  Protected NewMap  Miggy_Map.s()
  Protected NewMap  Miggy_Comp_Map.s()
  Protected NewMap  PC_Map.i()
  Protected NewList PC_List.s()  
  Protected NewList Copy_List.copy()        ; Updated Entries
  Protected NewList Delete_List.s()
  
  Protected ipath.s
  Protected cd_file.i, output.s, path2.s, startup_file.i, startup_prog.i, exit.b
  Protected UM_Program.i, time.i
  Protected ReadO$, Output$, SubFolder$, length.i
  
  OpenConsole("Update...")
  ConsoleCursor(0)
  
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
    
    startup_prog=RunProgram(WinUAE_Path, "-f "+IG_Path+"Update.uae -s filesystem2=rw,DH1:WHDTemp:"+WHD_TempDir+",0","",#PB_Program_Wait)
    
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
    path=LCase(UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder)
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
  
  Protected add_dir.b=#False
  Protected update_dir.b=#False
  
  ForEach UM_Database()      
    path2=UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+"/"+UM_Database()\UM_Slave
    If FindMapElement(Miggy_Comp_Map(),LCase(path2)) ; Check if the entry is found in the Amiga drive comparison map.
      If Miggy_Comp_Map()<>UM_Database()\UM_Slave_Date ; If the date of the Amiga slave is different to the database, add the archive to the copy list.
        update_dir=#True
        AddElement(Copy_List())
        Copy_List()\c_number=ListIndex(UM_Database())      ; Index of main database
        Copy_List()\c_olddate=Miggy_Comp_Map()             ; old slave date
        Copy_List()\c_newdate=UM_Database()\UM_Slave_Date  ; new slave date
      EndIf
    EndIf
    If Not FindMapElement(Miggy_Comp_Map(),LCase(path2))   ; Check if the entry is not found in the Amiga drive comparison map.
      add_dir=#True
      AddElement(Copy_List())
      Copy_List()\c_number=ListIndex(UM_Database())      ; Index of main database
      Copy_List()\c_olddate=""                           ; old slave date
      Copy_List()\c_newdate=""                           ; new slave date
    EndIf
  Next
  
  If ListSize(Copy_List())>0  
    
    ; Scan through Copy List and output the changes that will be made.
    
    ForEach Copy_List()        
      SelectElement(UM_Database(),Copy_List()\c_number)             
      PrintS()
      If Copy_List()\c_olddate<>""
        Print("Update Available: "+UM_Database()\UM_Title+Tags())
        ConsoleColor(4,0)
        Print(" Old Slave Date: "+Copy_List()\c_olddate)
        PrintNCol(" New Slave Date: "+Copy_List()\c_newdate,2,0)
      Else
        PrintNCol("New Software: "+UM_Database()\UM_Title+Tags(),2,0)
      EndIf
    Next   
    
    ; Select which type of update is to be processed.
    
    If update_dir
      PrintS()
      PrintN("Select Full to delete drawer and create a new one.")
      PrintN("Select Overwrite to keep drawer and overwrite files.") 
      PrintS()
      PrintN("Update Amiga (Full/Overwrite/Cancel) (F/O/C)?") 
      Repeat : path2=Inkey() :  Until path2="F" Or path2="f" Or path2="O" Or path2="o" Or path2="C" Or path2="c"
    EndIf
    
    If add_dir And Not update_dir
      PrintS()
      PrintN("Extract new archives (Yes/No)?.")
      Repeat : path2=Inkey() :  Until path2="Y" Or path2="y" Or path2="N" Or path2="n"
    EndIf
    
    exit=#False
    
    If path2="c" Or path2="C" Or path2="n" Or path2="N"
      exit=#True
    EndIf
    
  Else
    PrintS()
    PrintN("Nothing To Copy...")
    PrintS()
    Delay(2000)    
    If ListSize(Delete_List())=0 
      Goto CleanUp 
    Else
      PrintN("The following files are no longer required on your Amiga drive and will be deleted. This process will not remove any save games as they are stored separately.")
      PrintS()
      ForEach Delete_List()
        PrintNCol("Deleting: "+Delete_List(),4,0)
      Next
    EndIf
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
            output+"delete WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+" ALL"+#LF$
            output+"delete WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+".info"+#LF$
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
            output+"xadunfile FROM DH1:"+Str(ListIndex(Copy_List()))+".lzx"+" DEST WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+" OW VERBOSE"+#LF$
          EndIf
        Next
      EndIf
      output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
      output+"Waiting for disk activity to finish... "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
      output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
      output+"wait 4 SECS"+#LF$
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
            path=ReplaceString(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile,"/","\")
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
          
          startup_prog=RunProgram(WinUAE_Path, "-f "+IG_Path+"Update.uae -s filesystem2=rw,DH1:WHDTemp:"+WHD_TempDir+",0","",#PB_Program_Wait) 
          
        EndIf
        
        SetCurrentDirectory(home_path)
        
        ; Delete the temporary folder
        
        DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
      EndIf
    EndIf
  EndIf
  
  ; On error go to here!
  
  CleanUp:
  
  CloseConsole()
  
  ; Clear Resources
  
  FreeList(Miggy_List())
  FreeMap(Miggy_Map())
  FreeMap(PC_Map())
  FreeList(PC_List())
  FreeMap(Miggy_Comp_Map())
  FreeList(Copy_List())
  FreeList(Delete_List())
  
EndProcedure

Procedure ReInstall_Game(gamenum)
  
  If MessageRequester("Install","Re-install?",#PB_MessageRequester_Warning|#PB_MessageRequester_YesNo)=#PB_MessageRequester_Yes
    
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
    
    PrintNCol("Reinstalling: "+UM_Database()\UM_Title+Tags(),10,0)
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
          output+"delete WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+" ALL"+#LF$
          output+"delete WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+".info"+#LF$
          
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
        
        ;output+"c:uaequit"+#LF$
        
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
          
          path=ReplaceString(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile,"/","\")
          
          If GetExtensionPart(UM_Database()\UM_LHAFile)="lha"
            result=CopyFile(path,"0.lha")
          EndIf
          If GetExtensionPart(UM_Database()\UM_LHAFile)="lzx"
            result=CopyFile(path,"0.lzx")
          EndIf   
          
          Delay(100) ; Make sure that all copy / file creation processes have finished.
          
          ; Run WinUAE with the temporary folder as DH1: and wait until it finishes
          
          startup_prog=RunProgram(WinUAE_Path, "-f "+IG_Path+"Update.uae -s filesystem2=rw,DH1:WHDTemp:"+WHD_TempDir+",0","",#PB_Program_Wait) 
          
          SetCurrentDirectory(home_path)
          
          ; Delete the temporary folder
          
          DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
          
        EndIf
      EndIf
    EndIf 
    
    ; On error go to here!
    
    CleanUp:
    
    CloseConsole()
    
  EndIf
  
EndProcedure

;- ############### Creation Procedures

Procedure Make_PD_Disk(out_path.s="")
  
  ;253x178
  
  Protected text_x.i, aga.s
  
  If UM_Database()\UM_Type="Demo"
    
    If out_path=""
      path=Game_Data_Path+"Demo\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"   
      CreateDirectory(Game_Data_Path+"\Demo\"+UM_Database()\UM_Subfolder+"\")
      CreateDirectory(Game_Data_Path+"\Demo\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder)
      SetCurrentDirectory(path)
    Else
      path=out_path+"Demo\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\" 
      CreateDirectory(out_path+"Demo\")
      CreateDirectory(out_path+"Demo\"+UM_Database()\UM_Subfolder+"\")
      CreateDirectory(out_path+"Demo\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder)
      SetCurrentDirectory(path)
    EndIf
    
    LoadImage(#BACK_IMAGE,Game_Data_Path+"Demo\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png")      
    ResizeImage(#BACK_IMAGE,505,354)
    Round_Image(#BACK_IMAGE)
    
    LoadImage(#PREVIEW_IMAGE,Game_Data_Path+"floppydisk.png")
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
    
    SaveImage(#TEMP_IMAGE,GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png",#PB_ImagePlugin_PNG)
    
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
    SetXMLNodeText(item,"0.7")
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
    WriteStringFormat(#DAT_XML,#PB_UTF8)
    SaveXML(#DAT_XML,Main_Path+"test.xml")
    
    FreeList(CLR_Beta())
    FreeList(CLR_Game())
    FreeList(CLR_Demo())
    FreeList(CLR_List())
    
  EndIf  
  
  CloseWindow(#PROGRESS_WINDOW)
  
  SetWindowTitle(#MAIN_WINDOW,old_title)
  
EndProcedure

Procedure Backup_Images()
  
  Protected path2.s, result.i
  
  path=PathRequester("Output Path",Home_Path)
  
  CreateDirectory(path+UM_Database()\UM_Type)
  CreateDirectory(path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\")
  CreateDirectory(path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\")
  path2=path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"
  result=CopyFile(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png",path2+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png")
  result=CopyFile(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png",path2+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png")
  result=CopyFile(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png",path2+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png")
  
EndProcedure

Procedure Create_AGS_Files()
  
  Protected file, script.s, source_folder$, source_file$, new_file$, dest_folder$, old_pos.i, short_name.s
  
  old_pos=List_Numbers()
  
  OpenConsole("Creating AGS Files")
  
  ForEach UM_Database()
    short_name=UM_Database()\UM_Short
    PrintN("Processing: "+UM_Database()\UM_Title+Tags())
    CreateDirectory(AGS_Path+"\"+UM_Database()\UM_Type+".ags")
    CreateDirectory(AGS_Path+"\"+UM_Database()\UM_Type+".ags"+"\"+UM_Database()\UM_Subfolder+".ags")
    SetCurrentDirectory(AGS_Path+"\"+UM_Database()\UM_Type+".ags"+"\"+UM_Database()\UM_Subfolder+".ags")
    
    file=CreateFile(#PB_Any,UM_Database()\UM_Short+Tags_Short()+".run")
    script=""
    script+"cls"+#LF$
    script+"echo "+#DOUBLEQUOTE$+"Loading "+UM_Database()\UM_Short+#DOUBLEQUOTE$+#LF$
    script+"cd WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+#LF$
    script+"kgiconload "+UM_Database()\UM_Icon+#LF$
    script+"AGS:"+#LF$
    script+"cls"+#LF$
    script+"echo "+#DOUBLEQUOTE$+"Closing "+UM_Database()\UM_Short+#DOUBLEQUOTE$+#LF$
    WriteString(file,script)
    CloseFile(file)
    
    file=CreateFile(#PB_Any,UM_Database()\UM_Short+Tags_Short()+".txt",#PB_Ascii)
    script=""
    script+UM_Database()\UM_Title+#LF$
    If UM_Database()\UM_Intro
      script+"Intro Disk"+#LF$
    EndIf
    If UM_Database()\UM_Coverdisk
      script+"Cover Disk"+#LF$
    EndIf
    If UM_Database()\UM_Demo
      script+"Demo Disk"+#LF$
    EndIf
    script+#LF$
    If UM_Database()\UM_Type<>"Demo"
      script+"Developed by "+UM_Database()\UM_Developer+#LF$
    EndIf
    script+"© "+UM_Database()\UM_Year+" "+UM_Database()\UM_Publisher+#LF$
    script+#LF$
    If UM_Database()\UM_Type<>"Demo"
      script+"Genre: "+UM_Database()\UM_Genre+#LF$
      script+"Players: "+UM_Database()\UM_Players+#LF$
    EndIf
    If UM_Database()\UM_NTSC
      script+"Display Type: NTSC"+#LF$
    Else
      script+"Display Type: PAL"+#LF$
    EndIf
    script+"Language: "+UM_Database()\UM_Language+#LF$
    If UM_Database()\UM_AGA=#False And UM_Database()\UM_CD32=#False
      script+"Chipset: ECS/OCS"+#LF$
      If UM_Database()\UM_CDTV
        script+"Hardware: CDTV"+#LF$
      Else
        script+"Hardware: A500/600/1000/2000"+#LF$
      EndIf
    Else
      script+"Chipset: AGA"+#LF$
      If UM_Database()\UM_CD32
        script+"Hardware: CD32"+#LF$
      Else
        script+"Hardware: A1200/4000"+#LF$
      EndIf
    EndIf
    WriteString(file,script)
    CloseFile(file)
    
    source_folder$=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"
    dest_folder$=GetCurrentDirectory()
    source_file$=#DOUBLEQUOTE$+source_folder$+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png"+#DOUBLEQUOTE$
    new_file$=#DOUBLEQUOTE$+UM_Database()\UM_Short+Tags_Short()+"-1.iff"+#DOUBLEQUOTE$
    path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -ratio -resize 320 256 -rtype lanczos -canvas 320 256 center -bgcolor 0 0 0 -resize 320 128 -colors 216 -floyd "+source_file$
    RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    
    source_file$=#DOUBLEQUOTE$+source_folder$+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png"+#DOUBLEQUOTE$
    new_file$=#DOUBLEQUOTE$+UM_Database()\UM_Short+Tags_Short()+"-2.iff"+#DOUBLEQUOTE$
    path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 320 128 -rtype lanczos -colors 216 -floyd "+source_file$
    RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    
    source_file$=#DOUBLEQUOTE$+source_folder$+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png"+#DOUBLEQUOTE$
    new_file$=#DOUBLEQUOTE$+UM_Database()\UM_Short+Tags_Short()+"-3.iff"+#DOUBLEQUOTE$
    path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 320 128 -rtype lanczos -colors 216 -floyd "+source_file$
    RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    
  Next
  
  CloseConsole()
  
  SetCurrentDirectory(Home_Path)
  
  SelectElement(UM_Database(),old_pos)
  
EndProcedure

Procedure Create_IFF_Single()
  
  Protected source_folder$, dest_folder$, source_file$, new_file$, title$, result.i, response.s, text_info.i, Keypressed$
  
  response="7"
  source_folder$=Game_Data_Path
  dest_folder$=PathRequester("Select Output Folder","")  
  
  If dest_folder$<>""
    OpenConsole("Create Image Folder.")
    PrintN("Processing: "+UM_Database()\UM_Title+Tags()+" ("+Str(ListIndex(UM_Database())+1)+" of "+Str(ListSize(UM_Database()))+")")  
    Generate_Images()
    Delay(1000)
    CloseConsole()
  EndIf
  
  SetCurrentDirectory(Home_Path)
  
EndProcedure

Procedure Create_IFF_Folders()
  
  Protected source_folder$, dest_folder$, source_file$, new_file$, title$, result.i, response.s, text_info.i, Keypressed$
  
  Protected NewList Image_List.i()
    
  source_folder$=PathRequester("Select Source Folder",Game_Data_Path)  
  If source_folder$<>""
    dest_folder$=PathRequester("Select Output Folder","")  
    If dest_folder$<>""
      OpenConsole("Create Image Folders (Press ESC to quit)")
      ConsoleCursor(0)
      PrintNCol("Select Image Type.",9,0)
      PrintS()
      PrintN("1. IGame")
      PrintN("2. AGS2")
      PrintN("3. TinyLauncher")
      PrintN("4. PC PNG/JPG")
      PrintN("5. Launchbox Set") 
      PrintN("6. All Sets")
      PrintN("C. Cancel")
      PrintS()
      Print("Please select a number: ")
      response=Input() 
      PrintS()
      If LCase(response)<>"c"

        ForEach UM_Database()
          
          If UM_Database()\UM_Genre="Misc / Game Editor"
            If Not FindString(LCase(UM_Database()\UM_Slave),"editor")
              Continue
            EndIf
          EndIf
          
          If UM_Database()\UM_Genre="Misc / Intro Disk"
            If Not FindString(LCase(UM_Database()\UM_Slave),"intro") And Not FindString(LCase(UM_Database()\UM_Slave),"pictures")
              Continue
            EndIf
          EndIf
          
          If UM_Database()\UM_Genre="Misc / Utility Disk"
            If Not FindString(LCase(UM_Database()\UM_Slave),"utility")
              Continue
            EndIf
          EndIf
          
          AddElement(Image_List())
          Image_List()=ListIndex(UM_Database())
          
        Next

        ForEach Image_List()
          SelectElement(UM_Database(),Image_List())
          PrintN("Processing: "+UM_Database()\UM_Title+Tags()+" ("+Str(ListIndex(UM_Database())+1)+" of "+Str(ListSize(UM_Database()))+")")
          Generate_Images()
          Keypressed$=Inkey()
          If Keypressed$=Chr(27)
            PrintN("")
            PrintNCol("*** Process Cancelled ***",4,0)
            Delay(1000)
            Break
          EndIf
        Next
      EndIf
      CloseConsole()
    EndIf
  EndIf
  
  SetCurrentDirectory(Home_Path)
  
  FreeList(Image_List())
  
EndProcedure

Procedure Filter_WHD_List()
  
  ForEach WHD_List()
    If GetGadgetItemState(w_list,1)=#PB_Tree_Checked
      SelectElement(UM_Database(),WHD_List()\WHD_Index)
      If UM_Database()\UM_Type<>"Game" : WHD_List()\WHD_Filtered=#True : EndIf
    EndIf   
  Next
  
EndProcedure

Procedure Draw_WHD_List()
  
  Filter_WHD_List()
  
  ForEach WHD_List()
    If WHD_List()\WHD_Filtered=#False : AddGadgetItem(w_list,-1,WHD_List()\WHD_Archive) : EndIf
  Next
    
EndProcedure

Procedure Create_WHD_HDF()
  
  Protected w_event, w_gadget, w_type, old_gadget_list, i  
  Protected w_game_check, w_demo_check, w_beta_check
  
  ForEach UM_Database()
    AddElement(WHD_List())
    WHD_List()\WHD_Name=UM_Database()\UM_Title+tags()
    WHD_List()\WHD_Archive=UM_Database()\UM_LHAFile
    WHD_List()\WHD_Index=ListIndex(UM_Database())
    WHD_List()\WHD_Size=UM_Database()\UM_InstallSize
    WHD_List()\WHD_Filtered=#False
  Next
    
  If OpenWindow(#WHD_WINDOW,0,0,600,800,"Create WHD Drive",#PB_Window_SystemMenu|#PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
    
    Pause_Window(#WHD_WINDOW)
    
    old_gadget_list=UseGadgetList(WindowID(#WHD_WINDOW))
    
    TextGadget(#PB_Any,5,5,100,25,"Install List")
    
    w_list=ListIconGadget(#PB_Any,5,25,440,750,"Game",430,#LVS_NOCOLUMNHEADER)
    
    ForEach UM_Database()
      AddGadgetItem(w_list,-1,UM_Database()\UM_Title+Tags())
    Next
    
    TextGadget(#PB_Any,455,5,100,25,"Filter")
    
    w_tree=TreeGadget(#PB_Any,455,25,140,750,#PB_Tree_CheckBoxes|#PB_Tree_ThreeState)
    
    AddGadgetItem(w_tree,0,"Game Type",0,0)

    AddGadgetItem(w_tree,1,"Games",0,1)
    AddGadgetItem(w_tree,2,"Demos",0,1)
    AddGadgetItem(w_tree,3,"Betas",0,1)
    SetGadgetItemState(w_tree,0,#PB_Tree_Expanded)
    AddGadgetItem(w_tree,4,"Language",0,0)
    AddGadgetItem(w_tree,5,"Czech",0,1)
    AddGadgetItem(w_tree,6,"Danish",0,1)
    AddGadgetItem(w_tree,7,"Dutch",0,1)
    AddGadgetItem(w_tree,8,"English",0,1) 
    AddGadgetItem(w_tree,9,"Finnish",0,1)
    AddGadgetItem(w_tree,10,"French",0,1)
    AddGadgetItem(w_tree,11,"German",0,1) 
    AddGadgetItem(w_tree,12,"Greek",0,1) 
    AddGadgetItem(w_tree,13,"Italian",0,1)
    AddGadgetItem(w_tree,14,"Polish",0,1)
    AddGadgetItem(w_tree,15,"Spanish",0,1)
    AddGadgetItem(w_tree,16,"Swedish",0,1)
    SetGadgetItemState(w_tree,4,#PB_Tree_Expanded)
    
    AddGadgetItem(w_tree,17,"Graphics",0,0)
    AddGadgetItem(w_tree,18,"ECS/OCS",0,1)
    AddGadgetItem(w_tree,19,"AGA",0,1)
    AddGadgetItem(w_tree,20,"PAL",0,1)
    AddGadgetItem(w_tree,21,"NTSC",0,1)
    SetGadgetItemState(w_tree,17,#PB_Tree_Expanded)
    
    AddGadgetItem(w_tree,22,"Hardware",0,0)
    AddGadgetItem(w_tree,23,"Amiga",0,1)
    AddGadgetItem(w_tree,24,"AmigaCD",0,1)
    AddGadgetItem(w_tree,25,"CD32",0,1)
    AddGadgetItem(w_tree,26,"CDTV",0,1)
    AddGadgetItem(w_tree,27,"Arcadia",0,1)
    AddGadgetItem(w_tree,28,"MT32",0,1)
    SetGadgetItemState(w_tree,22,#PB_Tree_Expanded)
    
    For i=0 To 28
      SetGadgetItemState(w_tree,i,#PB_Tree_Checked)
    Next
    
    Draw_WHD_List()
    
    Resume_Window(#WHD_WINDOW)
    
  EndIf

  Repeat
    w_event=WaitWindowEvent()
    w_gadget=EventGadget()
    w_type=EventType()
    
    Select w_event
      Case #PB_Event_CloseWindow : Break  
    EndSelect
    
    Select w_gadget
      Case w_tree
        If w_type=#PB_EventType_LeftClick
        Draw_WHD_List()
        EndIf
    EndSelect
    
    
  ForEver
  
  UseGadgetList(old_gadget_list)
  
  CloseWindow(#WHD_WINDOW)
  
EndProcedure

;- ############### Icon Procedures


;- ############### Window Procedures

Procedure Image_Popup(type.i)
  
  Protected popup_imagegadget, pevent, popup_image, ww.i, wh.i, wx.i, wy.i, ih.i, iw.i, Smooth, old_gadget_list, zoom.f, rotate.i, oldpos.i, extension.s
  
  zoom=1.0
  rotate=0
  
  If GetGadgetState(#MAIN_LIST)>-1
    
    If IFF_Smooth : Smooth=#PB_Image_Smooth : Else : Smooth=#PB_Image_Raw : EndIf
    
    oldpos=GetGadgetState(#MAIN_LIST)
    
    SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
    SelectElement(UM_Database(),List_Numbers())
    
    DisableWindow(#MAIN_WINDOW,#True)
    
    Select type
      Case 1 : extension="_Title.png" :  wh=512
      Case 2 : extension="_Screen.png" :  wh=512
      Case 3 : extension="_Cover.png" :  wh=824    
    EndSelect   
    ww=640    
    
    Select GetGadgetState(#MAIN_PANEL)
        
      Case 0 : path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+extension     
      Case 1 : path=CD32_Path+CD32_Database()\CD_Folder+"\"+GetFilePart(CD32_Database()\CD_File,#PB_FileSystem_NoExtension)+extension
      Case 3
        Select type
          Case 1 
            If GetGadgetItemAttribute(#MAGAZINE_TREE,GetGadgetState(#MAGAZINE_TREE),#PB_Tree_SubLevel)=0
              path=Magazine_Data+GetGadgetText(#MAGAZINE_TREE)+"\logo.jpg"
            EndIf 
            If GetGadgetItemAttribute(#MAGAZINE_TREE,GetGadgetState(#MAGAZINE_TREE),#PB_Tree_SubLevel)>0
              path=Magazine_Data+Mag_List()\Mag_Title+"\"+"logo.jpg"
            EndIf 
            wh=512
            
          Case 2      
            If GetGadgetItemAttribute(#MAGAZINE_TREE,GetGadgetState(#MAGAZINE_TREE),#PB_Tree_SubLevel)=0
              path=Magazine_Data+GetGadgetText(#MAGAZINE_TREE)+"\logo2.jpg"
            EndIf
            If GetGadgetItemAttribute(#MAGAZINE_TREE,GetGadgetState(#MAGAZINE_TREE),#PB_Tree_SubLevel)>0
              path=Magazine_Data+Mag_List()\Mag_Title+"\"+"logo2.jpg"
            EndIf 
            wh=512
            
          Case 3
            If GetGadgetItemAttribute(#MAGAZINE_TREE,GetGadgetState(#MAGAZINE_TREE),#PB_Tree_SubLevel)=0
              path=Magazine_Data+GetGadgetText(#MAGAZINE_TREE)+"\"+GetFilePart(GetGadgetText(#MAGAZINE_TREE),#PB_FileSystem_NoExtension)+".jpg"
            EndIf
            If GetGadgetItemAttribute(#MAGAZINE_TREE,GetGadgetState(#MAGAZINE_TREE),#PB_Tree_SubLevel)>0
              path=Magazine_Data+Mag_List()\Mag_Title+"\"+GetFilePart(GetGadgetText(#MAGAZINE_TREE),#PB_FileSystem_NoExtension)+".jpg"
            EndIf
            wh=824
        EndSelect
    EndSelect

    If FileSize(path)>-1 
      LoadImage(#IFF_POPUP,path)
      If OpenWindow(#POPUP_WINDOW,0,0,ww,wh,"",#PB_Window_BorderLess|#PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
        
        old_gadget_list=UseGadgetList(WindowID(#POPUP_WINDOW))
        
        CreatePopupImageMenu(#IMAGE_POPUP_MENU)
        
        MenuItem(#Popup_a,"Rotate +90")
        AddKeyboardShortcut(#POPUP_WINDOW,#PB_Shortcut_Right,#Popup_a)
        MenuItem(#Popup_b,"Rotate -90")
        AddKeyboardShortcut(#POPUP_WINDOW,#PB_Shortcut_Left,#Popup_b)
        MenuBar()
        MenuItem(#Popup_c,"Zoom +")
        AddKeyboardShortcut(#POPUP_WINDOW,#PB_Shortcut_Up,#Popup_c)
        MenuItem(#Popup_d,"Zoom -")
        AddKeyboardShortcut(#POPUP_WINDOW,#PB_Shortcut_Down,#Popup_d)
        MenuBar()
        MenuItem(#Popup_e,"Close")
        AddKeyboardShortcut(#POPUP_WINDOW,#PB_Shortcut_Escape,#Popup_e)
        
        StickyWindow(#POPUP_WINDOW,#True)
        SetClassLongPtr_(WindowID(#POPUP_WINDOW),#GCL_STYLE,$00020000) ; Add Drop Shadow
        SetWindowColor(#POPUP_WINDOW,#Red)
        
        CanvasGadget(popup_imagegadget,0,0,ww,wh)
        
        W_Scale()        
                
        Repeat 
          pevent=WaitWindowEvent()
                   
          Select pevent
              
            Case #PB_Event_Gadget
              
              If EventGadget() = popup_imagegadget
                If EventType()=#PB_EventType_LeftDoubleClick
                  Break
                EndIf
                If EventType()=#PB_EventType_RightClick
                  DisplayPopupMenu(#IMAGE_POPUP_MENU,WindowID(#POPUP_WINDOW))
                EndIf
              EndIf
              
            Case #PB_Event_Menu
              
              Select EventMenu()
                  
                Case #Popup_a

                  rotate+90
                  If rotate=360: rotate=0 : EndIf   
                  W_Scale() 
                  
                Case #Popup_b
 
                  rotate-90
                  If rotate<0: rotate=270 : EndIf
                  W_Scale()

                Case #Popup_c
                  
                  If zoom<2.0
                    zoom+0.10
                  EndIf                                  
                  W_Scale()
                                   
                Case #Popup_d
                  
                  If zoom>0.5
                    zoom-0.10
                  EndIf
                  W_Scale()
                                    
                Case #Popup_e
                  Break
                  
              EndSelect
              
              
          EndSelect
        ForEver    
        UseGadgetList(old_gadget_list)
        
        CloseWindow(#POPUP_WINDOW)
        
      EndIf 
      
      FreeImage(#IFF_POPUP)
      FreeImage(#OUTPUT_POPUP)
      
      DisableWindow(#MAIN_WINDOW,#False)
      SetActiveWindow(#MAIN_WINDOW)
      
      If GetGadgetState(#MAIN_PANEL)=0 : SetActiveGadget(#MAIN_LIST) : EndIf
      If GetGadgetState(#MAIN_PANEL)=1 : SetActiveGadget(#CD32_LIST) : EndIf
      If GetGadgetState(#MAIN_PANEL)=2 : SetActiveGadget(#SYSTEM_LIST) : EndIf
      
    EndIf

  EndIf
  

  
EndProcedure

Procedure File_Viewer(file.s)
  
  Protected f_window, f_gadget
  
  If IsWindow(#FILE_WINDOW_01) And IsWindow(#FILE_WINDOW_02)  And IsWindow(#FILE_WINDOW_03)  And IsWindow(#FILE_WINDOW_04)  And IsWindow(#FILE_WINDOW_05)  And IsWindow(#FILE_WINDOW_06)  And IsWindow(#FILE_WINDOW_07)  And IsWindow(#FILE_WINDOW_08)  And IsWindow(#FILE_WINDOW_09)  And IsWindow(#FILE_WINDOW_10)
    MessageRequester("Error", "Too many windows open!"+#CRLF$+"Please close one and try again!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
    Goto proc_exit
  EndIf
      
  If IsWindow(#FILE_WINDOW_01)
    f_window=#FILE_WINDOW_02
    f_gadget=#FILE_WEBGADGET_02
  Else
    f_window=#FILE_WINDOW_01
    f_gadget=#FILE_WEBGADGET_01
  EndIf
  
  If IsWindow(#FILE_WINDOW_02)
    f_window=#FILE_WINDOW_03
    f_gadget=#FILE_WEBGADGET_03
  EndIf
  
  If IsWindow(#FILE_WINDOW_03)
    f_window=#FILE_WINDOW_04
    f_gadget=#FILE_WEBGADGET_04
  EndIf
  
  If IsWindow(#FILE_WINDOW_04)
    f_window=#FILE_WINDOW_05
    f_gadget=#FILE_WEBGADGET_05
  EndIf
  
  If IsWindow(#FILE_WINDOW_05)
    f_window=#FILE_WINDOW_06
    f_gadget=#FILE_WEBGADGET_06
  EndIf
  
  If IsWindow(#FILE_WINDOW_06)
    f_window=#FILE_WINDOW_07
    f_gadget=#FILE_WEBGADGET_07
  EndIf
  
  If IsWindow(#FILE_WINDOW_07)
    f_window=#FILE_WINDOW_08
    f_gadget=#FILE_WEBGADGET_08
  EndIf
  
  If IsWindow(#FILE_WINDOW_08)
    f_window=#FILE_WINDOW_09
    f_gadget=#FILE_WEBGADGET_09
  EndIf
  
  If IsWindow(#FILE_WINDOW_09)
    f_window=#FILE_WINDOW_10
    f_gadget=#FILE_WEBGADGET_10
  EndIf
  
  OpenWindow(f_window,0,0,700,600,"File Viewer ("+GetFilePart(file)+")",#PB_Window_SystemMenu|#PB_Window_SizeGadget|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
  Pause_Window(f_window)
  WebGadget(f_gadget,0,0,700,600,"file://"+file)
  SetActiveGadget(f_gadget)
  Resume_Window(f_window)
  
  proc_exit:
  
EndProcedure 

Procedure Settings_Window()
  
  Protected Path_Container, Options_Container
  Protected Path_Game_String, Path_Demo_String, Path_Beta_String, Path_LHA_String, Path_LZX_String, Path_Temp_String, Path_UAE_String, Path_Game_Button, Path_Demo_Button
  Protected Path_Beta_Button, Path_LHA_Button, Path_LZX_Button, Path_Temp_Button, Path_UAE_Button, Path_WinUAE_String, Path_WinUAE_Button
  Protected Path_Genres_Button, Path_Genres_String, Path_Database_Button, Path_Database_String, Path_CD32_Button, Path_CD32_String, Path_NConvert_String, Path_NConvert_Button
  Protected Path_Amiga_String, Path_Amiga_Button, Path_IGame_String, Path_IGame_Button, Path_Game_LHA_String, Path_Demo_LHA_String, Path_Beta_LHA_String, Path_Game_LHA_Button, Path_Demo_LHA_Button, Path_Beta_LHA_Button
  Protected old_pos, old_gadget_list, Path_Update_String, Path_Update_Button, Path_IZARC_String, Path_IZARC_Button, Path_Info_String, Path_Info_Button
  Protected change.b=#False
  
  Protected Options_Short_Check, Options_CloseUAE_Check, Options_Smooth_Check, Options_Quality_Check, Options_Backup_Check, Options_Tags_Check
  Protected Options_Bezel_Check, Options_BezelType_Combo, Options_BezelSource_Combo, Options_BezelName_String, Options_BezelSelect_Button
  
  old_pos=GetGadgetState(#MAIN_LIST)
  
  If OpenWindow(#PATH_WINDOW, 0, 0, 490, 580, "UltraMiggy Paths", #PB_Window_SystemMenu|#PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
    
    old_gadget_list=UseGadgetList(WindowID(#PATH_WINDOW))
    
    Options_Container=ContainerGadget(#PB_Any,0,0,490,300)
    FrameGadget(#PB_Any,10,0,230,300,"Options")
    Options_Short_Check=CheckBoxGadget(#PB_Any,20,20,200,24,"Use Short Names",#PB_CheckBox_Center)
    Options_CloseUAE_Check=CheckBoxGadget(#PB_Any,20,50,200,24,"Close WinUAE On Exit",#PB_CheckBox_Center)
    Options_Smooth_Check=CheckBoxGadget(#PB_Any,20,80,200,24,"Smooth Screen Shots",#PB_CheckBox_Center)
    Options_Quality_Check=CheckBoxGadget(#PB_Any,20,110,200,24,"Quality Resize",#PB_CheckBox_Center)
    Options_Backup_Check=CheckBoxGadget(#PB_Any,20,140,200,24,"Backup JSON Database",#PB_CheckBox_Center)
    Options_Tags_Check=CheckBoxGadget(#PB_Any,20,170,200,24,"Show Tags",#PB_CheckBox_Center)
    
    SetGadgetState(Options_Short_Check,Short_Names)
    SetGadgetState(Options_CloseUAE_Check,Close_UAE)
    SetGadgetState(Options_Smooth_Check,IFF_Smooth)
    SetGadgetState(Options_Quality_Check,Good_Scaler)
    SetGadgetState(Options_Backup_Check,JSON_Backup)
    SetGadgetState(Options_Tags_Check,Show_Tags)
    
    FrameGadget(#PB_Any,250,0,230,300,"Bezels")
    
    Options_Bezel_Check=CheckBoxGadget(#PB_Any,260,20,200,24,"Use Bezels")
    
    TextGadget(#PB_Any,255,53,110,24,"Bezel Image Source",#PB_Text_Center)
    Options_BezelSource_Combo=ComboBoxGadget(#PB_Any,370,50,100,24)
    AddGadgetItem(Options_BezelSource_Combo,-1,"Game Images")
    AddGadgetItem(Options_BezelSource_Combo,-1,"External Image")
    
    TextGadget(#PB_Any,255,83,100,24,"Bezel Image Type",#PB_Text_Center)
    Options_BezelType_Combo=ComboBoxGadget(#PB_Any,370,80,100,24)
    AddGadgetItem(Options_BezelType_Combo,-1,"In-Game")
    AddGadgetItem(Options_BezelType_Combo,-1,"Title")
    AddGadgetItem(Options_BezelType_Combo,-1,"Cover")
    
    Options_BezelName_String=StringGadget(#PB_Any,260,110,170,24,Bezel_Background,#PB_String_ReadOnly)
    Options_BezelSelect_Button=ButtonGadget(#PB_Any,435,110,35,24,"Set")
    
    SetGadgetState(Options_Bezel_Check,Use_Bezels)
    SetGadgetState(Options_BezelSource_Combo,Bezel_Source)
    SetGadgetState(Options_BezelType_Combo,Bezel_Type-1)
    
    If Bezel_Source=0
      DisableGadget(Options_BezelType_Combo,#False)
      DisableGadget(Options_BezelName_String,#True)
      DisableGadget(Options_BezelSelect_Button,#True)
    Else
      DisableGadget(Options_BezelType_Combo,#True)
      DisableGadget(Options_BezelName_String,#False)
      DisableGadget(Options_BezelSelect_Button,#False)
    EndIf
    
    CloseGadgetList()
    
    Path_Container=ContainerGadget(#PB_Any,0,300,490,280)
    
    Path_IZARC_String = StringGadget(#PB_Any, 130, 10, 300, 20, IZARC_Path, #PB_String_ReadOnly)
    Path_IZARC_Button = ButtonGadget(#PB_Any, 440, 10, 40, 20, "Set")
    Path_LHA_String = StringGadget(#PB_Any, 130, 40, 300, 20, LHA_Path, #PB_String_ReadOnly)
    Path_LHA_Button = ButtonGadget(#PB_Any, 440, 40, 40, 20, "Set")
    Path_LZX_String = StringGadget(#PB_Any, 130, 70, 300, 20, LZX_Path, #PB_String_ReadOnly)
    Path_LZX_Button = ButtonGadget(#PB_Any, 440, 70, 40, 20, "Set")
    Path_Temp_String = StringGadget(#PB_Any, 130, 100, 300, 20, WHD_TempDir, #PB_String_ReadOnly)
    Path_Temp_Button = ButtonGadget(#PB_Any, 440, 100, 40, 20, "Set")
    Path_UAE_String = StringGadget(#PB_Any, 130, 130, 300, 20, IG_Path, #PB_String_ReadOnly)
    Path_UAE_Button = ButtonGadget(#PB_Any, 440, 130, 40, 20, "Set")
    Path_WinUAE_String = StringGadget(#PB_Any, 130, 160, 300, 20, WinUAE_Path, #PB_String_ReadOnly)
    Path_WinUAE_Button = ButtonGadget(#PB_Any, 440, 160, 40, 20, "Set")
    Path_Game_LHA_String = StringGadget(#PB_Any, 130, 190, 300, 20, WHD_Folder, #PB_String_ReadOnly)
    Path_Game_LHA_Button = ButtonGadget(#PB_Any, 440, 190, 40, 20, "Set")
    Path_Genres_String = StringGadget(#PB_Any, 130, 220, 300, 20, Data_Path, #PB_String_ReadOnly)
    Path_Genres_Button = ButtonGadget(#PB_Any, 440, 220, 40, 20, "Set")
    Path_NConvert_String = StringGadget(#PB_Any, 130, 250, 300, 20, NConvert_Path, #PB_String_ReadOnly)
    Path_NConvert_Button = ButtonGadget(#PB_Any, 440, 250, 40, 20, "Set")
    
    Path_Info_String = StringGadget(#PB_Any, 130, 310, 300, 20, Game_Data_Path, #PB_String_ReadOnly)
    Path_Info_Button = ButtonGadget(#PB_Any, 440, 310, 40, 20, "Set")
    
    TextGadget(#PB_Any, 10,  12, 110, 20, "IZARCC Path", #PB_Text_Right)     
    TextGadget(#PB_Any, 10,  42, 110, 30, "LHA Archiver", #PB_Text_Right)
    TextGadget(#PB_Any, 10,  72, 110, 20, "LZX Archiver", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 102, 110, 20, "Temp Folder", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 132, 110, 20, "Config Path", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 162, 110, 20, "WinUAE Path", #PB_Text_Right) 
    TextGadget(#PB_Any, 10, 192, 110, 20, "WHD Archive Path", #PB_Text_Right)
    TextGadget(#PB_Any, 10, 222, 110, 20, "Data Path", #PB_Text_Right) 
    TextGadget(#PB_Any, 10, 252, 110, 20, "NConvert Path", #PB_Text_Right) 
    TextGadget(#PB_Any, 10, 312, 110, 20, "Game Info Path", #PB_Text_Right) 
    
    CloseGadgetList()
    
    Repeat
      
      event=WaitWindowEvent()
      
      Select event
          
        Case #PB_Event_Gadget
          Select EventGadget()
            Case Options_BezelSelect_Button
              path=OpenFileRequester("Select Image",Bezel_Path,"*.png",-1)
              If path<>"" : Bezel_Background=path : SetGadgetText(Options_BezelName_String,Bezel_Background) : change=#True : EndIf
            Case Options_BezelType_Combo
              If EventType()=#PB_EventType_Change
                Bezel_Type=GetGadgetState(Options_BezelType_Combo)+1
                change=#True
              EndIf
            Case Options_BezelSource_Combo
              If EventType()=#PB_EventType_Change
                Bezel_Source=GetGadgetState(Options_BezelSource_Combo)
                If Bezel_Source=0
                  DisableGadget(Options_BezelType_Combo,#False)
                  DisableGadget(Options_BezelName_String,#True)
                  DisableGadget(Options_BezelSelect_Button,#True)
                Else
                  DisableGadget(Options_BezelType_Combo,#True)
                  DisableGadget(Options_BezelName_String,#False)
                  DisableGadget(Options_BezelSelect_Button,#False)
                EndIf
                change=#True
              EndIf
            Case Options_Bezel_Check
              Use_Bezels=GetGadgetState(Options_Bezel_Check)
              change=#True
            Case Options_Short_Check
              Short_Names=GetGadgetState(Options_Short_Check)
              Draw_List()
              change=#True
            Case Options_CloseUAE_Check
              Close_UAE=GetGadgetState(Options_CloseUAE_Check)
              change=#True
            Case Options_Smooth_Check
              IFF_Smooth=GetGadgetState(Options_Smooth_Check)
              change=#True
            Case Options_Quality_Check
              Good_Scaler=GetGadgetState(Options_Quality_Check)
              change=#True
            Case Options_Backup_Check
              JSON_Backup=GetGadgetState(Options_Backup_Check)
              change=#True 
            Case Options_Tags_Check
              Show_Tags=GetGadgetState(Options_Tags_Check)
              Draw_List()
              change=#True 
            Case Path_IZARC_Button
              path=OpenFileRequester("IZARCC Path",LHA_Path,"*.exe",0)
              If path<>"" : IZARC_Path=path : SetGadgetText(Path_IZARC_String,IZARC_Path) : change=#True : EndIf  
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
              path=PathRequester("Config Path",IG_Path)
              If path<>"" : IG_Path=path : SetGadgetText(Path_UAE_String,IG_Path) : change=#True : EndIf
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
    
    CloseWindow(#PATH_WINDOW)
    
  EndIf
  
EndProcedure

Procedure Edit_CD32(number) 
  
  SelectElement(CD32_Database(),number)
  
  ClearList(Genre_List.s())
  
  Protected change.b=#False, oldindex.s, star.s, g_file.i
  Protected old_gadget_list, old_pos
  Protected Title_String, Language_String, ISO_String, ISO_Button,Coder_String, Genre_Combo, Year_String
  Protected Mouse_Check, Keyboard_Check, Config_Combo, Close_Button, Memory_String, Compilation_Check
  
  old_pos=GetGadgetState(#CD32_LIST)
  
  DisableWindow(#MAIN_WINDOW,#True)
  
  If OpenWindow(#EDIT_WINDOW, 0, 0, 424, 264, "Edit Database", #PB_Window_SystemMenu | #PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
    
    Pause_Window(#EDIT_WINDOW)
    
    old_gadget_list=UseGadgetList(WindowID(#EDIT_WINDOW))
    
    TextGadget(#PB_Any, 8, 10, 60, 20, "Title", #PB_Text_Center)    
    Title_String = StringGadget(#PB_Any, 80, 8, 336, 24, CD32_Database()\CD_Title)
    TextGadget(#PB_Any, 8, 74, 60, 20, "Language", #PB_Text_Center) 
    Language_String = StringGadget(#PB_Any, 80, 72, 336, 24, CD32_Database()\CD_Language)
    TextGadget(#PB_Any, 8, 106, 60, 20, "CUE File", #PB_Text_Center)   
    ISO_String = StringGadget(#PB_Any, 80, 104, 296, 24, CD32_Database()\CD_File,#PB_String_ReadOnly)
    ISO_Button = ButtonGadget(#PB_Any, 381, 104, 30,24,"Set")
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
            Case ISO_Button
              path=OpenFileRequester("Select CUE File","","*.cue",-1)
              If path<>""
                CD32_Database()\CD_Folder=StringField(path,CountString(path,"\"),"\")
                CD32_Database()\CD_File=GetFilePart(path)
                SetGadgetText(ISO_String,GetFilePart(path))
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
      SetGadgetItemText(#CD32_LIST,old_pos,star+CD32_Database()\CD_Title+CD32_Tags())
      Save_CD32_DB()
    EndIf
    
    SetActiveGadget(#CD32_LIST)
    
    SetGadgetState(#CD32_LIST,old_pos)
    
  EndIf
  
EndProcedure

Procedure Edit_GL(number) 
  
  SelectElement(UM_Database(),number)
  
  Protected NewList Backup_List.UM_Data()
  
  CopyList(UM_Database(),Backup_List())
  
  Protected change.b=#False, oldindex.s, star.s, g_file.i, text$, old_num, count, old_path.s
  Protected old_gadget_list, old_pos.s, Title_String, Language_String, Path_String, Frame_0, AGA_Check, CD32_Check, Icon_Button, Preview_Check
  Protected Files_Check, Image_Check, NoIntro_Check, Date_String, Icon_String, Close_Button, HOL_String, Lemon_String, WHD_String
  Protected CDTV_Check, MT32_Check, Memory_String, Genre_Combo, CDROM_Check, Arcadia_Check, Demo_Check, Intro_Check, PD_Check
  Protected Cover_Check, NTSC_Check, Disk_String, Coder_String, Type_Combo, File_Button, Config_Combo, Janeway_String, Pouet_String
  Protected Year_String, Cancel_Button, Short_String, ECSOCS_Check, Short_Title, Players_String, NoSound_Check, Developer_String, Folder_String, Party_String
  Protected Next_Button, Prev_Button, Publisher_Text, Alt_Name_String, Alt_Name_Short_String

  old_num=GetGadgetState(#MAIN_LIST)
  
  DisableWindow(#MAIN_WINDOW,#True)
  
  If OpenWindow(#EDIT_WINDOW, 0, 0, 424, 560, "Edit Database", #PB_Window_SystemMenu | #PB_Window_WindowCentered,WindowID(#MAIN_WINDOW))
    
    Pause_Window(#EDIT_WINDOW)
    
    old_gadget_list=UseGadgetList(WindowID(#EDIT_WINDOW))
    
    TextGadget(#PB_Any, 8, 10, 60, 20, "Name", #PB_Text_Center)    
    Title_String = StringGadget(#PB_Any, 80, 8, 336, 24, UM_Database()\UM_Title)
    Short_Title=TextGadget(#PB_Any, 5, 42, 60, 20, "Short ("+Str(Len(UM_Database()\UM_Short))+")", #PB_Text_Center)    
    Short_String = StringGadget(#PB_Any, 80, 40, 336, 24, UM_Database()\UM_Short)
    TextGadget(#PB_Any, 8, 74, 60, 20, "Language", #PB_Text_Center)
    Language_String = StringGadget(#PB_Any, 80, 72, 336, 24, UM_Database()\UM_Language)
    TextGadget(#PB_Any, 8, 106, 60, 20, "Archive", #PB_Text_Center) 
    Path_String = StringGadget(#PB_Any, 80, 104, 336, 24, UM_Database()\UM_LHAFile)
    TextGadget(#PB_Any, 8, 138, 60, 20, "Alt Name", #PB_Text_Center)
    Alt_Name_String = StringGadget(#PB_Any, 80, 136, 124, 24, UM_Database()\UM_Alt_Name)
    TextGadget(#PB_Any, 220, 138, 60, 20, "Alt Short", #PB_Text_Center)
    Alt_Name_Short_String = StringGadget(#PB_Any, 290, 136, 124, 24, UM_Database()\UM_Alt_Name_Short)
    If UM_Database()\UM_Type="Demo"
      Publisher_Text=TextGadget(#PB_Any, 8, 172, 60, 20, "Group", #PB_Text_Center)
    Else
      Publisher_Text=TextGadget(#PB_Any, 8, 172, 60, 20, "Publisher", #PB_Text_Center)
    EndIf
    Coder_String = StringGadget(#PB_Any, 80, 170, 120, 24, UM_Database()\UM_Publisher)
    TextGadget(#PB_Any, 220, 172, 60, 20, "Developer", #PB_Text_Center)
    Developer_String = StringGadget(#PB_Any, 290, 170, 124, 24, UM_Database()\UM_Developer)
    TextGadget(#PB_Any, 8, 206, 60, 20, "Slave Date", #PB_Text_Center)
    Date_String = StringGadget(#PB_Any, 80, 202, 120, 24, UM_Database()\UM_Slave_Date)
    TextGadget(#PB_Any, 220, 206, 60, 20, "Year", #PB_Text_Center)
    Year_String = StringGadget(#PB_Any, 290, 202, 126, 24, UM_Database()\UM_Year)
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
    Files_Check = CheckBoxGadget(#PB_Any, 88, 304, 60, 20, "Files")
    Image_Check = CheckBoxGadget(#PB_Any, 152, 304, 54, 20, "Image")
    Cover_Check = CheckBoxGadget(#PB_Any, 210, 304, 80, 20, "Cover Disk")
    TextGadget(#PB_Any, 296, 306, 36, 20, "Disks", #PB_Text_Right)
    Disk_String = StringGadget(#PB_Any, 336, 304, 72, 24, UM_Database()\UM_Disks) 
    ECSOCS_Check = CheckBoxGadget(#PB_Any, 16, 336, 60, 20, "OCSECS", #PB_CheckBox_Center)
    NoSound_Check = CheckBoxGadget(#PB_Any, 88, 336, 60, 20, "No Snd", #PB_CheckBox_Center)
    PD_Check = CheckBoxGadget(#PB_Any, 152, 336, 60, 20, "PD")
    TextGadget(#PB_Any, 296, 338, 36, 20, "Players", #PB_Text_Right)
    Players_String = StringGadget(#PB_Any, 336, 336, 72, 24, UM_Database()\UM_Players,#PB_String_Numeric)
    TextGadget(#PB_Any, 10, 378, 46, 20, "Type", #PB_Text_Center)
    Type_Combo = ComboBoxGadget(#PB_Any, 64, 376, 88, 24)
    TextGadget(#PB_Any, 158, 378, 50, 20, "Config", #PB_Text_Center)  
    Config_Combo = ComboBoxGadget(#PB_Any, 212, 376, 124, 24)
    TextGadget(#PB_Any, 8, 410, 60, 20, "Genre", #PB_Text_Center)
    Genre_Combo = ComboBoxGadget(#PB_Any, 80, 408, 216, 24) 
    Folder_String = StringGadget(#PB_Any,80,438,336,24,UM_Database()\UM_Folder)
    TextGadget(#PB_Any, 8, 440, 60, 20, "Folder", #PB_Text_Center)   
    HOL_String = StringGadget(#PB_Any,50,468,50,24,UM_Database()\UM_HOL_Entry)
    TextGadget(#PB_Any, 8, 470, 40, 20, "HOL #", #PB_Text_Center)   
    Lemon_String = StringGadget(#PB_Any,154,468,50,24,UM_Database()\UM_Lemon_Entry)
    TextGadget(#PB_Any, 110, 470, 40, 20, "Lemon #", #PB_Text_Center)   
    WHD_String = StringGadget(#PB_Any,276,468,140,24,UM_Database()\UM_WHD_Entry)
    TextGadget(#PB_Any, 212, 470, 60, 20, "WHDLoad", #PB_Text_Center)  
    Janeway_String = StringGadget(#PB_Any,50,498,50,24,UM_Database()\UM_Janeway)
    TextGadget(#PB_Any, 8, 500, 40, 20, "B'World", #PB_Text_Center) 
    Pouet_String = StringGadget(#PB_Any,154,498,50,24,UM_Database()\UM_Pouet)
    TextGadget(#PB_Any, 110, 500, 40, 20, "Pouët", #PB_Text_Center) 
    Party_String = StringGadget(#PB_Any,276,498,140,24,UM_Database()\UM_Party)
    TextGadget(#PB_Any, 212, 500, 60, 20, "Rel. Party", #PB_Text_Center) 
    Prev_Button = ButtonGadget(#PB_Any, 20, 528, 72, 24, "Previous")
    Next_Button = ButtonGadget(#PB_Any, 100, 528, 72, 24, "Next")
    Cancel_Button = ButtonGadget(#PB_Any, 270, 528, 72, 24, "Cancel")
    Close_Button = ButtonGadget(#PB_Any, 344, 528, 72, 24, "Close")
    
    If UM_Database()\UM_Type="Demo"
      DisableGadget(HOL_String,#True)
      DisableGadget(Lemon_String,#True)
    EndIf
    
    If UM_Database()\UM_Type<>"Demo"
      DisableGadget(Janeway_String,#True)
      DisableGadget(Pouet_String,#True)
      DisableGadget(Party_String,#True)
    EndIf
    
    AddGadgetItem(Type_Combo,-1,"Unknown")
    AddGadgetItem(Type_Combo,-1,"Game")
    AddGadgetItem(Type_Combo,-1,"Demo")
    AddGadgetItem(Type_Combo,-1,"Beta")
    
    AddGadgetItem(Config_Combo,-1,"A1200")
    AddGadgetItem(Config_Combo,-1,"A1200 (Compatible)")
    AddGadgetItem(Config_Combo,-1,"A1200-030")
    AddGadgetItem(Config_Combo,-1,"A1200-040")
    AddGadgetItem(Config_Combo,-1,"A1200-CD32")
    AddGadgetItem(Config_Combo,-1,"A600")
    SetGadgetState(Config_Combo,UM_Database()\UM_Config)
      
    ForEach Genre_List()
      AddGadgetItem(Genre_Combo,-1,Genre_List())
    Next
            
    If FindMapElement(Genre_Map(),UM_Database()\UM_Genre)
      SetGadgetState(Genre_Combo,Genre_Map()-1)   
    Else
      SetGadgetState(Genre_Combo, CountGadgetItems(Genre_Combo)-1)
    EndIf
        
    SetGadgetState(AGA_Check,UM_Database()\UM_AGA)
    SetGadgetState(CD32_Check,UM_Database()\UM_CD32)
    SetGadgetState(CDTV_Check,UM_Database()\UM_CDTV)    
    SetGadgetState(MT32_Check,UM_Database()\UM_MT32)
    SetGadgetState(CDROM_Check,UM_Database()\UM_CDROM)
    SetGadgetState(NTSC_Check,UM_Database()\UM_NTSC)
    SetGadgetState(Arcadia_Check,UM_Database()\UM_Arcadia)
    SetGadgetState(Demo_Check,UM_Database()\UM_Demo)
    SetGadgetState(Intro_Check,UM_Database()\UM_Intro)
    SetGadgetState(NoIntro_Check,UM_Database()\UM_NoIntro)   
    SetGadgetState(Preview_Check,UM_Database()\UM_Preview)
    SetGadgetState(Files_Check,UM_Database()\UM_Files)
    SetGadgetState(Image_Check,UM_Database()\UM_Image) 
    SetGadgetState(Cover_Check,UM_Database()\UM_Coverdisk)
    SetGadgetState(ECSOCS_Check,UM_Database()\UM_ECSOCS)
    SetGadgetState(NoSound_Check,UM_Database()\UM_NoSound)
    SetGadgetState(PD_Check,UM_Database()\UM_PD)
    
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
              
            Case Next_Button
              If ListIndex(List_Numbers())<ListSize(List_Numbers())
                NextElement(List_Numbers())
                SelectElement(UM_Database(),List_Numbers())
                Populate_Edit_Gadgets()
              EndIf
              
            Case Prev_Button
              If ListIndex(List_Numbers())>-1
                PreviousElement(List_Numbers())
                SelectElement(UM_Database(),List_Numbers())
                Populate_Edit_Gadgets()
              EndIf
                            
            Case title_string
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Title=GetGadgetText(title_string)
                text$=UM_Database()\UM_Title+Tags()
                change=#True
              EndIf
              
            Case Short_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Short=GetGadgetText(Short_String)
                SetGadgetText(Short_Title,"Short Name ("+Str(Len(UM_Database()\UM_Short))+")")
                change=#True
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
              
            Case Folder_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Folder=GetGadgetText(Folder_String)
                change=#True
              EndIf
              
            Case path_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_LHAFile=GetGadgetText(path_String)
                change=#True
              EndIf
              
            Case HOL_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_HOL_Entry=GetGadgetText(HOL_String)
                change=#True
              EndIf
              
            Case Lemon_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Lemon_Entry=GetGadgetText(Lemon_String)
                change=#True
              EndIf
            Case WHD_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_WHD_Entry=GetGadgetText(WHD_String)
                change=#True
              EndIf
              
            Case Janeway_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Janeway=GetGadgetText(Janeway_String)
                change=#True
              EndIf
              
            Case Party_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Party=GetGadgetText(Party_String)
                change=#True
              EndIf
              
            Case Pouet_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Pouet=GetGadgetText(Pouet_String)
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
              
            Case Config_Combo
              UM_Database()\UM_Config=GetGadgetState(Config_Combo)
              change=#True
              
            Case Type_Combo
              UM_Database()\UM_Type=GetGadgetText(Type_Combo)
              change=#True
              
            Case Language_String
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
              
            Case PD_Check
              UM_Database()\UM_PD=GetGadgetState(PD_Check)
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
              
            Case Alt_Name_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Alt_Name=GetGadgetText(Alt_Name_String)
                change=#True
              EndIf
              
            Case Alt_Name_Short_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Alt_Name_Short=GetGadgetText(Alt_Name_Short_String)
                change=#True
              EndIf
              
            Case File_Button
              path=OpenFileRequester("Select File", "", "*.*",0)
              If path<>""
                UM_Database()\UM_LHAFile=GetFilePart(path)
                SetGadgetText(path_string,GetFilePart(path))
              EndIf
              
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
    SetActiveWindow(#MAIN_WINDOW)
    SetActiveGadget(#MAIN_LIST)
    
    SortStructuredList(UM_Database(),#PB_Sort_Ascending|#PB_Sort_NoCase,OffsetOf(UM_Data\UM_Title),TypeOf(UM_Data\UM_Title))
    
    If Short_Names
      old_pos=UM_Database()\UM_Short+Tags_Short()
    Else
      old_pos=UM_Database()\UM_Title+Tags()
    EndIf
    
    Protected itemheight, hotitem
    
    If change
      Save_DB()
      Draw_List()     
    Else  
      SetActiveGadget(#MAIN_LIST)
    EndIf 
    
    Center_List(old_pos)
    
    If ListIndex(List_Numbers())=-1
      SelectElement(List_Numbers(),0)
      SetGadgetState(#MAIN_LIST,0)
    EndIf
        
    If ListSize(List_Numbers())>0
      Draw_Info(List_Numbers())
    Else
      Draw_Info(-1)
    EndIf    
    
    FreeList(Backup_List())
    
  EndIf
    
EndProcedure

Procedure Filter_Window()
  
  If Not IsWindow(#FILTER_WINDOW)
    
    Protected old_pos.i, text.i, x_pos.i
    
    old_pos=GetGadgetState(#MAIN_LIST)
    
    If WindowX(#MAIN_WINDOW)<330 
      x_pos=WindowX(#MAIN_WINDOW)+WindowWidth(#MAIN_WINDOW)+5
    Else
      x_pos=WindowX(#MAIN_WINDOW)-330
    EndIf
    
    If OpenWindow(#FILTER_WINDOW, x_pos, WindowY(#MAIN_WINDOW)+30, 325, 650, "Filter", #PB_Window_SystemMenu)
      
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
      
      Chipset_Gadget=ComboBoxGadget(#PB_Any,106,180,206,22)
      TextGadgetCol(12,184,86,24,"Graphics",#White)
      
      Sound_Gadget=ComboBoxGadget(#PB_Any,106,210,206,22)
      TextGadgetCol(12,214,86,24,"Sound",#White)
      
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
      
      FrameGadgetCustom(#PB_Any,4,520,316,82,"Other")
      
      TextGadgetCol(12,544,186,24,"Data Type",#White)
      DataType_Gadget=ComboBoxGadget(#PB_Any,106,540,206,20)
      
      TextGadgetCol(12,574,186,24,"Players",#White)
      Players_Gadget=ComboBoxGadget(#PB_Any,106,570,206,20)
      
      Reset_Button=ButtonGadget(#PB_Any,GadgetWidth(#FILTER_PANEL)-220,GadgetHeight(#FILTER_PANEL)-40,100,30,"Reset (F6)")
      Exit_Button=ButtonGadget(#PB_Any,GadgetWidth(#FILTER_PANEL)-110,GadgetHeight(#FILTER_PANEL)-40,100,30,"Exit")  
      
      Resume_Window(#FILTER_WINDOW)
      
      While WindowEvent() : Wend
      
      Pause_Window(#FILTER_WINDOW)
      
      Pause_Gadget(Hardware_Gadget)
      AddGadgetItem(Hardware_Gadget,-1,"All")
      AddGadgetItem(Hardware_Gadget,-1,"Amiga")
      AddGadgetItem(Hardware_Gadget,-1,"CD32")
      AddGadgetItem(Hardware_Gadget,-1,"CDTV")
      AddGadgetItem(Hardware_Gadget,-1,"AmigaCD")
      AddGadgetItem(Hardware_Gadget,-1,"Arcadia")
      SetGadgetState(Hardware_Gadget,Filter(0)\HardWare)
      Resume_Gadget(Hardware_Gadget)
      
      Pause_Gadget(Chipset_Gadget)
      AddGadgetItem(Chipset_Gadget,-1,"All")
      AddGadgetItem(Chipset_Gadget,-1,"OCS/ECS")
      AddGadgetItem(Chipset_Gadget,-1,"AGA")
      AddGadgetItem(Chipset_Gadget,-1,"PAL")
      AddGadgetItem(Chipset_Gadget,-1,"NTSC")
      SetGadgetState(Chipset_Gadget,Filter(0)\Chipset)
      Resume_Gadget(Chipset_Gadget)
      
      Pause_Gadget(Sound_Gadget)
      AddGadgetItem(Sound_Gadget,-1,"All")
      AddGadgetItem(Sound_Gadget,-1,"No Sound")
      AddGadgetItem(Sound_Gadget,-1,"MT32")  
      SetGadgetState(Sound_Gadget,Filter(0)\Sound)
      Resume_Gadget(Sound_Gadget)
      
      Pause_Gadget(DiskCategory_Gadget)
      AddGadgetItem(DiskCategory_Gadget,-1,"All")
      AddGadgetItem(DiskCategory_Gadget,-1,"Game Demo")
      AddGadgetItem(DiskCategory_Gadget,-1,"Preview")
      AddGadgetItem(DiskCategory_Gadget,-1,"Intro Disk")
      AddGadgetItem(DiskCategory_Gadget,-1,"No Intro")
      AddGadgetItem(DiskCategory_Gadget,-1,"Coverdisk")
      AddGadgetItem(DiskCategory_Gadget,-1,"PD Disk")
      SetGadgetState(DiskCategory_Gadget,Filter(0)\DiskType)  
      Resume_Gadget(DiskCategory_Gadget)
      
      Pause_Gadget(DataType_Gadget)
      AddGadgetItem(DataType_Gadget,-1,"All")
      AddGadgetItem(DataType_Gadget,-1,"Files")
      AddGadgetItem(DataType_Gadget,-1,"Image")
      SetGadgetState(DataType_Gadget,Filter(0)\DataType)
      Resume_Gadget(DataType_Gadget)
      
      Pause_Gadget(Players_Gadget)
      AddGadgetItem(Players_Gadget,-1,"All")
      AddGadgetItem(Players_Gadget,-1,"No Players")
      AddGadgetItem(Players_Gadget,-1,"1 Player")
      AddGadgetItem(Players_Gadget,-1,"2 Players")
      AddGadgetItem(Players_Gadget,-1,"3 Players")
      AddGadgetItem(Players_Gadget,-1,"4 Players")
      AddGadgetItem(Players_Gadget,-1,"5+ Players")
      SetGadgetState(Players_Gadget,Filter(0)\Players)
      Resume_Gadget(Players_Gadget)
      
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
        Else
          FPub(UM_Database()\UM_Publisher)=UM_Database()\UM_Publisher
          FDev(UM_Database()\UM_Developer)=UM_Database()\UM_Developer
        EndIf    
        FYear(UM_Database()\UM_Year)=UM_Database()\UM_Year
        FLang(UM_Database()\UM_Language)=UM_Database()\UM_Language
        FDisks(UM_Database()\UM_Disks)=UM_Database()\UM_Disks
        If UM_Database()\UM_Memory<>"" : FMem(UM_Database()\UM_Memory)=UM_Database()\UM_Memory : EndIf
      Next
      
      Pause_Gadget(Publisher_Gadget)
      ForEach FPub()
        AddElement(Sort())
        Sort()=FPub()
      Next
      SortList(Sort(),#PB_Sort_Ascending|#PB_Sort_NoCase)
      AddGadgetItem(Publisher_Gadget,-1,"All")
      ForEach Sort()
        AddGadgetItem(Publisher_Gadget,-1,Sort())
      Next
      SetGadgetState(Publisher_Gadget,Filter(0)\Publisher)
      Resume_Gadget(Publisher_Gadget)
      
      ClearList(Sort())
      
      Pause_Gadget(Developer_Gadget)
      ForEach FDev()
        AddElement(Sort())
        Sort()=FDev()
      Next
      SortList(Sort(),#PB_Sort_Ascending|#PB_Sort_NoCase)
      AddGadgetItem(Developer_Gadget,-1,"All")
      ForEach Sort()
        AddGadgetItem(Developer_Gadget,-1,Sort())
      Next
      SetGadgetState(Developer_Gadget,Filter(0)\Developer)
      Resume_Gadget(Developer_Gadget)
      
      ClearList(Sort())
      
      Pause_Gadget(Coder_Gadget)
      ForEach FCoder()
        AddElement(Sort())
        Sort()=FCoder()
      Next
      SortList(Sort(),#PB_Sort_Ascending|#PB_Sort_NoCase)
      AddGadgetItem(Coder_Gadget,-1,"All")
      ForEach Sort()
        AddGadgetItem(Coder_Gadget,-1,Sort())
      Next
      SetGadgetState(Coder_Gadget,Filter(0)\Coder)
      Resume_Gadget(Coder_Gadget)
      
      ClearList(Sort())
      
      Pause_Gadget(Year_Gadget)
      ForEach FYear()
        AddElement(Sort())
        Sort()=FYear()
      Next
      SortList(Sort(),#PB_Sort_Ascending|#PB_Sort_NoCase)
      AddGadgetItem(Year_Gadget,-1,"All")
      ForEach Sort()
        AddGadgetItem(Year_Gadget,-1,Sort())
      Next
      SetGadgetState(Year_Gadget,Filter(0)\Year)
      Resume_Gadget(Year_Gadget)
      
      ClearList(Sort())
      
      Pause_Gadget(Language_Gadget)
      ForEach FLang()
        AddElement(Sort())
        Sort()=FLang()
      Next
      SortList(Sort(),#PB_Sort_Ascending|#PB_Sort_NoCase)
      AddGadgetItem(Language_Gadget,-1,"All")
      ForEach Sort()
        AddGadgetItem(Language_Gadget,-1,Sort())
      Next
      SetGadgetState(Language_Gadget,Filter(0)\Language)
      Resume_Gadget(Language_Gadget)
      
      ClearList(Sort())
      
      Pause_Gadget(Memory_Gadget)
      ForEach FMem()
        AddElement(Sort())
        Sort()=FMem()
      Next
      SortList(Sort(),#PB_Sort_Ascending|#PB_Sort_NoCase)
      AddGadgetItem(Memory_Gadget,-1,"All")
      ForEach Sort()
        AddGadgetItem(Memory_Gadget,-1,Sort())
      Next
      SetGadgetState(Memory_Gadget,Filter(0)\Memory)
      Resume_Gadget(Memory_Gadget)
      
      Pause_Gadget(Disks_Gadget)
      AddGadgetItem(Disks_Gadget,-1,"All")
      AddGadgetItem(Disks_Gadget,-1,"One Disk")
      AddGadgetItem(Disks_Gadget,-1,"Two Disk")
      AddGadgetItem(Disks_Gadget,-1,"Three Disk")
      AddGadgetItem(Disks_Gadget,-1,"Four Disk")
      SetGadgetState(Disks_Gadget,Filter(0)\Disks)
      Resume_Gadget(Disks_Gadget)
      
      Pause_Gadget(Category_Gadget)    
      AddGadgetItem(Category_Gadget,-1,"All")
      AddGadgetItem(Category_Gadget,-1,"Games")
      AddGadgetItem(Category_Gadget,-1,"Games/Beta")
      AddGadgetItem(Category_Gadget,-1,"Demos")
      AddGadgetItem(Category_Gadget,-1,"Beta")
      SetGadgetState(Category_Gadget,Filter(0)\Category)
      Resume_Gadget(Category_Gadget)
      
      Pause_Gadget(Filter_Gadget)
      AddGadgetItem(Filter_Gadget,-1,"All")
      AddGadgetItem(Filter_Gadget,-1,"Favourite")
      AddGadgetItem(Filter_Gadget,-1,"Too Long")
      AddGadgetItem(Filter_Gadget,-1,"No Chipset")
      AddGadgetItem(Filter_Gadget,-1,"No Developer")
      AddGadgetItem(Filter_Gadget,-1,"No InstallSize")
      AddGadgetItem(Filter_Gadget,-1,"No Publisher")
      AddGadgetItem(Filter_Gadget,-1,"No Image")
      AddGadgetItem(Filter_Gadget,-1,"No Title")
      AddGadgetItem(Filter_Gadget,-1,"No Cover")   
      AddGadgetItem(Filter_Gadget,-1,"No Year")
      AddGadgetItem(Filter_Gadget,-1,"No HOL")
      AddGadgetItem(Filter_Gadget,-1,"No Lemon")
      AddGadgetItem(Filter_Gadget,-1,"No WHDLoad")
      AddGadgetItem(Filter_Gadget,-1,"No BitWorld")
      AddGadgetItem(Filter_Gadget,-1,"No Pouet")
      AddGadgetItem(Filter_Gadget,-1,"Invalid Genre")
      AddGadgetItem(Filter_Gadget,-1,"Dupe Slave")
      AddGadgetItem(Filter_Gadget,-1,"Missing Type")
      SetGadgetState(Filter_Gadget,Filter(0)\Filter)
      Resume_Gadget(Filter_Gadget)
      
      Pause_Gadget(Genre_Gadget)
      AddGadgetItem(Genre_Gadget,-1,"All")
      
      ForEach Genre_List()
        AddGadgetItem(Genre_Gadget,-1,Genre_List())
      Next
      SetGadgetState(Genre_Gadget,Filter(0)\Genre)    
      Resume_Gadget(Genre_Gadget)
      
      FreeMap(FPub())
      FreeMap(FCoder())
      FreeMap(FYear())
      FreeMap(FLang())
      FreeMap(FDisks())
      FreeMap(FMem())
      FreeList(Sort())
      
      CloseGadgetList()
      
      Resume_Window(#FILTER_WINDOW)
      
    EndIf
  EndIf

EndProcedure

;- ############### Startup Procedures

Procedure WinCallback(hWnd, uMsg, WParam, LParam) 
  
  If WParam = #WM_RBUTTONDOWN
    If GetActiveGadget() = Info_Gadget
      PostEvent(#PB_Event_Gadget, #MAIN_WINDOW, Info_Gadget, #PB_EventType_RightClick)
    EndIf
  EndIf
  
  ProcedureReturn #PB_ProcessPureBasicEvents 
EndProcedure

Procedure Create_Lists()
  
  Protected file.l, output$
  
  path=PathRequester("Output Path","")
  
  If path<>""
  
  Protected NewMap Genres.s()
  
  ForEach UM_Database()
    Genres(UM_Database()\UM_Genre)=""
  Next   
  
  ForEach Genres()
    output$=ReplaceString(MapKey(Genres()),"/","-")
    output$=ReplaceString(output$," ","-")
    output$=ReplaceString(output$,"---","-")
    file=CreateFile(#PB_Any,path+output$+".lst",#PB_Ascii)
    output$="; WHDLoad Download Tool List "+#CRLF$
    output$+";"+#CRLF$
    output$+"; "+MapKey(Genres())+#CRLF$
    output$+";"+#CRLF$    
    output$+"; Created With UltraMiggy "+Version+#CRLF$
    output$+";"+#CRLF$
    WriteString(file,output$)
    ForEach UM_Database()
      If MapKey(Genres())=UM_Database()\UM_Genre
        WriteStringN(file,UM_Database()\UM_LHAFile)
      EndIf
    Next
    FlushFileBuffers(file)
    CloseFile(file)
  Next
  
EndIf

EndProcedure
  
Procedure Init_Program()
    
  UsePNGImageDecoder()
  UsePNGImageEncoder()
  UseJPEGImageDecoder()
  UseJPEGImageEncoder()
  UseOGGSoundDecoder()
  UseLZMAPacker()
  UseZipPacker()
  InitNetwork()
  InitSound()
  
  CatchImage(#PDF_IMAGE,?PDF_Image)
  CatchImage(#TEXT_IMAGE,?Text_Image)
  CatchImage(#PLAY_ICON,?Play_Image)
  CatchImage(#IMAGE_ICON,?Image_Image)
  CatchImage(#OPTIONS_ICON,?Options_Image)
  CatchImage(#FAVOURITE_ICON,?Fave_Image)
  CatchImage(#FOLDER_ICON,?Folder_Image)
  CatchImage(#HOL_ICON,?Hol_Image)
  CatchImage(#LEMON_ICON,?Lemon_Image)
  CatchImage(#WHD_ICON,?WHD_Image)
  CatchImage(#JANEWAY_ICON,?Janeway_Image)
  CatchImage(#POUET_ICON,?Pouet_Image)
  
  Create_Blanks()
  
  ; PD Image Fonts
  
  LoadFont(#SMALL_FONT,"Segoe Print",14,#PB_Font_Bold)
  LoadFont(#PREVIEW_FONT,"Segoe Print",16,#PB_Font_Bold)
  LoadFont(#HEADER_FONT,"Segoe Print",28,#PB_Font_Bold)
  
  ; Game Info Font
  
  LoadFont(#INFO_FONT,"Consolas",9)
  
  Load_Prefs() 
  Load_DB()  
  Load_CD32_DB()  
  
  If ReadFile(#FILE,Data_Path+"um_genres.dat")
    While Not Eof(#FILE)
      AddElement(Genre_List())
      Genre_List()=ReadString(#FILE)
      Genre_Map(Genre_List())=ListIndex(Genre_List())
    Wend
    CloseFile(#FILE)  
  EndIf
  
  SortList(Genre_List(),#PB_Sort_Ascending)  
  
  ForEach Genre_List()
    Genre_Map(Genre_List())=ListIndex(Genre_List())
  Next
    
  path=""
  path2="" 
  
  OpenWindow(#MAIN_WINDOW, 0, 0, 1153, 710, W_Title+"("+Build+")" , #PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_MinimizeGadget|#PB_Window_Invisible)
  
  SetWindowCallback(@WinCallback())
  
  Reset_Filter()
  Draw_Main_Window()
  Draw_List()
  Draw_CD32_List()
  Draw_Systems_List()
  Draw_Magazines()
  
  Draw_Info(0)
  
  HideWindow(#MAIN_WINDOW,#False)
  
  SmartWindowRefresh(#MAIN_WINDOW,#True)
  
EndProcedure

Init_Program()

;- ############### Main Loop

Repeat
  
  event=WaitWindowEvent()
  
  Select event
      
;- ############### Input Events
      
    Case #WM_KEYDOWN
      
      If GetGadgetState(#MAIN_PANEL)=0
        If CountGadgetItems(#MAIN_LIST)>0
          If EventwParam() = #VK_F6
            Reset_Filter()
            SetGadgetText(Search_Gadget,"")
            Draw_List()
            Draw_Info(List_Numbers())
          EndIf
          If GetActiveGadget()<>Search_Gadget
            If EventwParam() = #VK_RETURN
              If CountGadgetItems(#MAIN_LIST)>0 And GetGadgetState(#MAIN_LIST)>-1
                Set_Database()
                Run_Game(List_Numbers())
              EndIf 
            EndIf
            If EventwParam() = #VK_SPACE
              If CountGadgetItems(#MAIN_LIST)>0 And GetGadgetState(#MAIN_LIST)>-1
                Set_Database()
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
            If EventwParam() = #VK_F4
              Filter_Window()
            EndIf
            If EventwParam() = #VK_F8
              PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_2b)
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
      
      If GetGadgetState(#MAIN_PANEL)=1
        If CountGadgetItems(#CD32_LIST)>0
          If GetActiveGadget()<>Search_Gadget
            If EventwParam() = #VK_RETURN
              If CountGadgetItems(#CD32_LIST)>0
                SelectElement(CD32_Numbers(),GetGadgetState(#CD32_LIST))
                Run_CD32(CD32_Numbers())
              EndIf 
            EndIf
            If EventwParam() = #VK_SPACE
              If CountGadgetItems(#CD32_LIST)>0
                SelectElement(CD32_Numbers(),GetGadgetState(#CD32_LIST))
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
        If CountGadgetItems(#SYSTEM_LIST)>0
          If EventwParam() = #VK_RETURN
            If CountGadgetItems(#CD32_LIST)>0
              Run_System(GetGadgetState(#SYSTEM_LIST))
            EndIf 
          EndIf
        EndIf
      EndIf
            
;- ############### Menu Events
      
    Case #PB_Event_Menu
      
      Select EventMenu()
          
        Case 900 To 920    ;{- Check Popup Menu
          File_Viewer(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetMenuItemText(#POPUP_MENU,EventMenu()))
          ;}
        Case #MenuItem_1   ;{- Run Game  
          If IsProgram(startup_prog)
            MessageRequester("Error","WinUAE is already running!"+#CRLF$+"Please close it and try again.",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
          Else
            If CountGadgetItems(#MAIN_LIST)>0
              SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
              Run_Game(List_Numbers())
            EndIf
          EndIf ;} 
        Case #MenuItem_2   ;{- Run CD32
          If IsProgram(startup_prog)
            MessageRequester("Error","WinUAE is already running!"+#CRLF$+"Please close it and try again.",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
          Else
            If CountGadgetItems(#MAIN_LIST)>0
              SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
              Run_CD32(CD32_Numbers())
            EndIf
          EndIf ;} 
        Case #MenuItem_2a  ;{- Run System
          Run_System(GetGadgetState(#SYSTEM_LIST));}   
        Case #Menuitem_2b  ;{- Favourite
          If ListSize(List_Numbers())>0 And GetGadgetState(#MAIN_PANEL)=0
            Set_Database()
            If UM_Database()\UM_Favourite=#False
              UM_Database()\UM_Favourite=#True
              SetGadgetItemText(#MAIN_LIST,GetGadgetState(#MAIN_LIST),UM_Database()\UM_Title+Tags())
            Else
              UM_Database()\UM_Favourite=#False
              SetGadgetItemText(#MAIN_LIST,GetGadgetState(#MAIN_LIST),UM_Database()\UM_Title+Tags())
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
        Case #MenuItem_7   ;{- Open Game Data Folder
          Set_Database()
          path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"
          RunProgram("file://"+path);}
        Case #MenuItem_8   ;{- Open WHD Folder
          Set_Database()
          path=WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"
          RunProgram("file://"+path);}
        Case #MenuItem_8a  ;{- Open screen shots
          Set_Database()
          path=Home_Path+"Screenshots\"
          RunProgram("file://"+path);}
        Case #MenuItem_9   ;{- Open HOL Page
          Set_Database()
          If UM_Database()\UM_HOL_Entry<>""
            RunProgram("http://hol.abime.net/"+UM_Database()\UM_HOL_Entry)
          EndIf;}
        Case #MenuItem_9a  ;{- Open Lemon Page
          Set_Database()
          If UM_Database()\UM_Lemon_Entry<>""
            RunProgram("https://www.lemonamiga.com/games/details.php?id="+UM_Database()\UM_Lemon_Entry)
          EndIf;}
        Case #MenuItem_9b  ;{- Open WHDLoad Page
          Set_Database()
          If UM_Database()\UM_WHD_Entry<>""
            If UM_Database()\UM_Type="Demo"
              RunProgram("http://www.whdload.de/demos/"+UM_Database()\UM_WHD_Entry+".html")
            Else  
              RunProgram("http://www.whdload.de/games/"+UM_Database()\UM_WHD_Entry+".html")
            EndIf
          EndIf;}
        Case #MenuItem_9c  ;{- Open Janeway Page
          Set_Database()
          If UM_Database()\UM_Janeway<>""
            RunProgram("http://janeway.exotica.org.uk/release.php?id="+UM_Database()\UM_Janeway)
          EndIf;}
        Case #MenuItem_9d  ;{- Open Pouet Page
          Set_Database()
          If UM_Database()\UM_Pouet<>""
            RunProgram("https://www.pouet.net/prod.php?which="+UM_Database()\UM_Pouet)
          EndIf;}
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
          Batch_LHA_Folders(PathRequester("Main Folder",""))
          ;} 
        Case #MenuItem_10d ;{- Make Singe IFF Folder
          Create_IFF_Single()
          ;}   
        Case #MenuItem_10c ;{- Archive Folder
          LHA_Folder(PathRequester("Main Folder",""))
          ;} 
        Case #MenuItem_11  ;{- Backup Images
          Backup_Images()  ;}
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
        Case #MenuItem_14  ;{- Save IG Database
          Save_IG_DB()
          ;}
        Case #MenuItem_15  ;{- Re-install game
          ReInstall_Game(List_Numbers())
          ;}
        Case #MenuItem_16  ;{- Delete Folder
          path=PathRequester("Delete Folder","")
          If path<>""
            If MessageRequester("Warning","Delete "+path,#PB_MessageRequester_Warning|#PB_MessageRequester_YesNo)=#PB_MessageRequester_Yes
              DeleteDirectory(path,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
            EndIf
          EndIf
          ;}  
        Case #MenuItem_17  ;{- Create WHD Drive
          Create_WHD_HDF()
          ;}  
        Case #MenuItem_18  ;{- Make AGS Folder
          Create_AGS_Files()
          ;}
        Case #MenuItem_19  ;{- Get All Archive Sizes
          OpenConsole("Getting Game Sizes")
          ForEach UM_Database()
              PrintN("Processing : "+UM_Database()\UM_Title+Tags())
              UM_Database()\UM_InstallSize=Get_Install_Size(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile)
              PrintN("Size : "+UM_Database()\UM_InstallSize) 
          Next
          CloseConsole()
          SetGadgetState(#MAIN_LIST,0)
          SelectElement(List_Numbers(),0)
          SelectElement(UM_Database(),List_Numbers())
          Draw_Info(List_Numbers())
          ;}
        Case #MenuItem_20  ;{- Get All Archive Sizes
          OpenConsole("Getting Game Sizes")
          PrintN("Processing : "+UM_Database()\UM_Title+Tags())
          UM_Database()\UM_InstallSize=Get_Install_Size(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile)
          PrintN("Size : "+UM_Database()\UM_InstallSize) 
          Delay(2000)
          CloseConsole()
          Draw_Info(List_Numbers())
          ;}      
        Case #MenuItem_21  ;{- Update FTP
          Update_FTP()
          ;}
        Case #MenuItem_22  ;{- Update Database
          Update_Database()
          Reset_Filter()
          Draw_List()  
          Draw_Info(List_Numbers())
          ;} 
        Case #MenuItem_22a ;{- Update HDF
          Update_HDF()
          ;} 
        Case #MenuItem_23  ;{- Full Update
          Update_FTP()
          Update_Database()
          If MessageRequester("Update","Update Amiga HDF",#PB_MessageRequester_YesNo|#PB_MessageRequester_Info)=#PB_MessageRequester_Yes
            Update_HDF()
          EndIf
          Draw_List();} 
        Case #MenuItem_24  ;{- Check Images
          Audit_Images()
          ;}      
        Case #MenuItem_25  ;{- Add CD32 Entry
          path=OpenFileRequester("Select CD32 Archive",CD32_Path,"*.zip",0)
          If path<>""
            AddElement(CD32_Database())
            CD32_Database()\CD_Title=GetFilePart(path,#PB_FileSystem_NoExtension)
            CD32_Database()\CD_File=GetFilePart(path)
            CD32_Database()\CD_Genre="Unknown"
            CD32_Database()\CD_Config=0
            SortStructuredList(CD32_Database(),#PB_Sort_Ascending|#PB_Sort_NoCase,OffsetOf(UM_Data\UM_Title),TypeOf(UM_Data\UM_Title))
            Draw_CD32_List()
            Draw_CD32_Info(0)              
          EndIf
          
          ;}  
        Case #MenuItem_26  ;{- Delete Entry
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
                If GetGadgetState(#CD32_LIST)>0
                  list_pos=GetGadgetState(#CD32_LIST)-1
                Else
                  list_pos=0
                EndIf
                DeleteElement(CD32_Database())
                Draw_CD32_List()
                SelectElement(CD32_Numbers(),list_pos)
                SetGadgetState(#CD32_LIST,list_pos)
                Draw_CD32_Info(CD32_Numbers())
              EndIf
              
            EndIf
          EndIf ;}         
        Case #MenuItem_27  ;{- Edit Entry
          If CountGadgetItems(#MAIN_LIST)>0
            SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
            Edit_GL(List_Numbers())
          EndIf ;}  
        Case #MenuItem_28  ;{- Extract text files
          Extract_Text_Files_Single(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile) ;} 
        Case #MenuItem_31  ;{- Settings Window
          Settings_Window();}
        Case #MenuItem_45  ;{- Reload Genres
          If ReadFile(0,Data_Path+"um_genres.dat")
            Pause_Window(#MAIN_WINDOW)
            ClearList(Genre_List())
            ClearMap(Genre_Map())
            
            While Not Eof(0)
              AddElement(Genre_List())
              Genre_List()=ReadString(0)
            Wend
            CloseFile(0)

            SortList(Genre_List(),#PB_Sort_Ascending)  
            
            ForEach Genre_List()
              Genre_Map(Genre_List())=ListIndex(Genre_List())
            Next
            
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
        Case #MenuItem_46  ;{- Refresh List
          
          Draw_List()
          If ListSize(List_Numbers())>0
            SelectElement(List_Numbers(),0)
            Draw_Info(List_Numbers())
          Else
            Draw_Info(-1)
          EndIf
          ;}
        Case #MenuItem_96  ;{- Copy Game Info Text
          If FileSize(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\game_info.txt")>0
            path=""
            path2=""
            ReadFile(0,Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\game_info.txt")
            While Not Eof(0)
              path=ReadString(0)
              path2+path+#CRLF$
            Wend
            CloseFile(0)
            SetClipboardText(path2)
          EndIf
          SetActiveGadget(#MAIN_LIST);}
        Case #MenuItem_97            ;{- Paste Game Info Text
          If GetClipboardText()<>"" And UM_Database()\UM_Type<>"Demo"
            CreateDirectory(Game_Data_Path+UM_Database()\UM_Type+"\")
            CreateDirectory(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\")
            CreateDirectory(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder)
            SetCurrentDirectory(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder)
            If FileSize("game_info.txt")>0 : DeleteFile("game_info.txt") : EndIf
            CreateFile(0,"game_info.txt")
            WriteStringN(0,GetClipboardText())
            FlushFileBuffers(0)
            CloseFile(0)
            Draw_Game_Info(0)
            DestroyCaret_()
            SetCurrentDirectory(Home_Path)
          EndIf
          SetActiveGadget(#MAIN_LIST);}
        Case #MenuItem_98            ;{- Delete Game Info Text
          If UM_Database()\UM_Type<>"Demo"
            If MessageRequester("Delete","Clear Info?",#PB_MessageRequester_Warning|#PB_MessageRequester_YesNo)=#PB_MessageRequester_Yes
              DeleteDirectory(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder,"*.txt")
              Draw_Game_Info(0)
            EndIf
            DestroyCaret_()
          EndIf
          SetActiveGadget(#MAIN_LIST);}    
        Case #MenuItem_99            ;{- Edit Game Info Text
          If UM_Database()\UM_Type<>"Demo"
            RunProgram("notepad.exe",Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\game_info.txt","",#PB_Program_Wait)
            Draw_Game_Info(0)
            DestroyCaret_()
          EndIf
          SetActiveGadget(#MAIN_LIST)  ;}
        Case #MenuItem_99a           ;{- Copy Web Info
          If UM_Database()\UM_Type<>"Demo"
            ClearList(WEB_List())
            AddElement(WEB_List())
            WEB_List()\WEB_HOL=UM_Database()\UM_HOL_Entry
            WEB_List()\WEB_Lemon=UM_Database()\UM_Lemon_Entry
            WEB_List()\WEB_WHDLoad=UM_Database()\UM_WHD_Entry
            WEB_List()\WEB_Developer=UM_Database()\UM_Developer
            WEB_List()\WEB_Players=UM_Database()\UM_Players
          EndIf
          SetActiveGadget(#MAIN_LIST);}
        Case #MenuItem_99b           ;{- Paste Web Info
          count=GetGadgetState(#MAIN_LIST)
          If UM_Database()\UM_Type<>"Demo"
            UM_Database()\UM_HOL_Entry=WEB_List()\WEB_HOL
            UM_Database()\UM_Lemon_Entry=WEB_List()\WEB_Lemon
            UM_Database()\UM_WHD_Entry=WEB_List()\WEB_WHDLoad
            UM_Database()\UM_Developer=WEB_List()\WEB_Developer
            UM_Database()\UM_Players=WEB_List()\WEB_Players
            Save_DB()
          EndIf
          Set_Database()
          Draw_Info(List_Numbers()) 
          ;}
          
      EndSelect
      
 ;- ############### Drag&Drop Events
      
    Case #PB_Event_GadgetDrop
      
      Select EventGadget()
          
        Case Cover_Image
          If EventDropFiles()>""
            If GetGadgetState(#MAIN_LIST)<>-1              
              If GetExtensionPart(EventDropFiles())="png" Or GetExtensionPart(EventDropFiles())="jpg" Or GetExtensionPart(EventDropFiles())="iff"
                If GetGadgetState(#MAIN_PANEL)=0
                  CreateDirectory(Game_Data_Path+UM_Database()\UM_Type+"\")
                  CreateDirectory(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\")
                  CreateDirectory(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder)
                  path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png"
                  Resize_Cover(EventDropFiles(), path)
                  Draw_Info(List_Numbers())
                EndIf
                If GetGadgetState(#MAIN_PANEL)=1
                  path=CD32_Path+CD32_Database()\CD_Folder+"\"+GetFilePart(CD32_Database()\CD_File,#PB_FileSystem_NoExtension)+"_Cover.png"
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
                  CreateDirectory(Game_Data_Path+UM_Database()\UM_Type+"\")
                  CreateDirectory(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\")
                  CreateDirectory(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder)
                  path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png"
                  Resize_Image(EventDropFiles(), path)
                  Draw_Info(List_Numbers())
                EndIf
                If GetGadgetState(#MAIN_PANEL)=1
                  path=CD32_Path+CD32_Database()\CD_Folder+"\"+GetFilePart(CD32_Database()\CD_File,#PB_FileSystem_NoExtension)+"_Title.png"
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
                  CreateDirectory(Game_Data_Path+UM_Database()\UM_Type+"\")
                  CreateDirectory(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\")
                  CreateDirectory(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder)
                  path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png"
                  Resize_Image(EventDropFiles(), path)
                  Draw_Info(List_Numbers())
                EndIf
                If GetGadgetState(#MAIN_PANEL)=1
                  path=CD32_Path+CD32_Database()\CD_Folder+"\"+GetFilePart(CD32_Database()\CD_File,#PB_FileSystem_NoExtension)+"_Screen.png"
                  Resize_Image(EventDropFiles(), path)
                  Draw_CD32_Info(CD32_Numbers())
                EndIf 
              Else
                MessageRequester("Error","Not An Image File!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
              EndIf
            EndIf
          EndIf            
          
      EndSelect
      
;- ############### Gadget Events    
      
    Case #PB_Event_Gadget
      
      Select EventGadget()
        Case Play_Button
          If ListSize(Music_List())>0
            If GetExtensionPart(Music_List())="ogg"
              If LoadSound(0,Music_List())
                SoundVolume(0,Track_Volume)
                PlaySound(0)
              EndIf
            Else
              If LoadMusic(0,Music_List())
                MusicVolume(0,Track_Volume)
                PlayMusic(0)
              EndIf
            EndIf
            SetActiveGadget(#MAIN_LIST)
          EndIf
          
        Case Stop_Button
          If IsSound(0)
            StopSound(0)
            FreeSound(0)
          EndIf
          If IsMusic(0)
            StopMusic(0)
            FreeMusic(0)
          EndIf
          SetActiveGadget(#MAIN_LIST)
          
        Case Volume_Slider
          If IsMusic(0)
            MusicVolume(0,GetGadgetState(Volume_Slider))
          EndIf
          If IsSound(0)
            SoundVolume(0,GetGadgetState(Volume_Slider))
          EndIf
          Track_Volume=GetGadgetState(Volume_Slider)
          SetActiveGadget(#MAIN_LIST)
          
        Case Track_Combo
          If IsMusic(0)
            StopMusic(0)
            FreeMusic(0)
          EndIf
          If IsSound(0)
            StopSound(0)
            FreeSound(0)
          EndIf
          SelectElement(Music_List(),GetGadgetState(Track_Combo))
          SetActiveGadget(#MAIN_LIST)
          
        Case Exit_Button
          CloseWindow(#FILTER_WINDOW)
                    
        Case Filter_Button
          Filter_Window()
          
        Case #MAIN_PANEL
          If EventType()=#PB_EventType_Change
            Pause_Window(#MAIN_WINDOW)
            If GetGadgetState(#MAIN_PANEL)=0
              Pause_Window(#MAIN_WINDOW)
              SetWindowTitle(#MAIN_WINDOW, W_Title+" (Showing "+Str(CountGadgetItems(#MAIN_LIST))+" of "+Str(ListSize(UM_Database()))+" Games)")
              DisableGadget(#MAIN_LIST,#False)
              DisableGadget(#CD32_LIST,#True)
              DisableGadget(#SYSTEM_LIST,#True)
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
            EndIf
            If GetGadgetState(#MAIN_PANEL)=1
              SetWindowTitle(#MAIN_WINDOW, W_Title+" (Showing "+Str(CountGadgetItems(#CD32_LIST))+" of "+Str(ListSize(CD32_Database()))+" CD32 Games)")
              DisableGadget(#MAIN_LIST,#True)
              DisableGadget(#CD32_LIST,#False)    
              DisableGadget(#SYSTEM_LIST,#True)
              SetActiveGadget(#CD32_LIST)
              SetGadgetState(#CD32_LIST,0)
              DisableMenuItem(Main_Menu,#MenuItem_25,0)
              DisableMenuItem(Main_Menu,#MenuItem_2,0)
              DisableMenuItem(Main_Menu,#MenuItem_1,1)
              DisableMenuItem(Main_Menu,#MenuItem_2a,1)
              Draw_CD32_Info(0)
              DisableGadget(Filter_Button,#True)
              DisableGadget(Search_Gadget,#True)
            EndIf
            If GetGadgetState(#MAIN_PANEL)=2
              SetWindowTitle(#MAIN_WINDOW, W_Title+" (Showing "+Str(CountGadgetItems(#CD32_LIST))+" of "+Str(ListSize(CD32_Database()))+" CD32 Games)")
              DisableGadget(#MAIN_LIST,#True)
              DisableGadget(#CD32_LIST,#True) 
              DisableGadget(#SYSTEM_LIST,#False)
              SetActiveGadget(#SYSTEM_LIST)
              SetGadgetState(#SYSTEM_LIST,0)
              DisableMenuItem(Main_Menu,#MenuItem_25,1)
              DisableMenuItem(Main_Menu,#MenuItem_2,1)
              DisableMenuItem(Main_Menu,#MenuItem_1,1)
              DisableMenuItem(Main_Menu,#MenuItem_2a,0)
              Draw_CD32_Info(0)
              DisableGadget(Filter_Button,#True)
              DisableGadget(Search_Gadget,#True)
            EndIf
            If GetGadgetState(#MAIN_PANEL)=3
              SetActiveGadget(#MAGAZINE_TREE)
              SetGadgetItemState(#MAGAZINE_TREE,0,#PB_Tree_Selected)
              Draw_Magazine_Info()
            EndIf
            Resume_Window(#MAIN_WINDOW)
          EndIf
          
        Case #CD32_LIST
          If CountGadgetItems(#CD32_LIST)>0 And GetGadgetState(#CD32_LIST)>-1
            If EventType()= #PB_EventType_Change
              SelectElement(CD32_Numbers(),GetGadgetState(#CD32_LIST))
              Draw_CD32_Info(CD32_Numbers())
              SelectElement(CD32_Database(),CD32_Numbers())
            EndIf
            If EventType() = #PB_EventType_LeftDoubleClick
              PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_2)
            EndIf
          EndIf  
          
          Case #MAGAZINE_TREE
          If CountGadgetItems(#MAGAZINE_TREE)>0 And GetGadgetState(#MAGAZINE_TREE)>-1
            If EventType() = #PB_EventType_LeftDoubleClick
              path=GetGadgetText(#MAGAZINE_TREE)
              ForEach Mag_List()
                ForEach Mag_List()\Mag_Files()
                If path=Mag_List()\Mag_Files()\Mag_Name 
                  File_Viewer(Mag_List()\Mag_Files()\Mag_Path)
                  Break(2)
                EndIf
              Next
            Next        
          EndIf
          If EventType()= #PB_EventType_Change
            path=GetGadgetText(#MAGAZINE_TREE)
            ForEach Mag_List()
              ForEach Mag_List()\Mag_Files()
                If path=Mag_List()\Mag_Files()\Mag_Name 
                  Break(2)
                EndIf
              Next
            Next
            Draw_Magazine_Info()
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
          
        Case #SYSTEM_LIST
          If CountGadgetItems(#SYSTEM_LIST)>0 And GetGadgetState(#SYSTEM_LIST)>-1
            If EventType() = #PB_EventType_LeftDoubleClick
              PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_2a)
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
          SetGadgetText(Search_Gadget,"")
          Draw_List()
          Draw_Info(List_Numbers())
          
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
      
    Case #PB_Event_SizeWindow
      Select EventWindow()
        Case #FILE_WINDOW_01 : ResizeGadget(#FILE_WEBGADGET_01,0,0,WindowWidth(#FILE_WINDOW_01),WindowHeight(#FILE_WINDOW_01))
        Case #FILE_WINDOW_02 : ResizeGadget(#FILE_WEBGADGET_02,0,0,WindowWidth(#FILE_WINDOW_02),WindowHeight(#FILE_WINDOW_02))
        Case #FILE_WINDOW_03 : ResizeGadget(#FILE_WEBGADGET_03,0,0,WindowWidth(#FILE_WINDOW_03),WindowHeight(#FILE_WINDOW_03))
        Case #FILE_WINDOW_04 : ResizeGadget(#FILE_WEBGADGET_04,0,0,WindowWidth(#FILE_WINDOW_04),WindowHeight(#FILE_WINDOW_04))
        Case #FILE_WINDOW_05 : ResizeGadget(#FILE_WEBGADGET_05,0,0,WindowWidth(#FILE_WINDOW_05),WindowHeight(#FILE_WINDOW_05))
        Case #FILE_WINDOW_06 : ResizeGadget(#FILE_WEBGADGET_06,0,0,WindowWidth(#FILE_WINDOW_06),WindowHeight(#FILE_WINDOW_06))
        Case #FILE_WINDOW_07 : ResizeGadget(#FILE_WEBGADGET_07,0,0,WindowWidth(#FILE_WINDOW_07),WindowHeight(#FILE_WINDOW_07))
        Case #FILE_WINDOW_08 : ResizeGadget(#FILE_WEBGADGET_08,0,0,WindowWidth(#FILE_WINDOW_08),WindowHeight(#FILE_WINDOW_08))
        Case #FILE_WINDOW_09 : ResizeGadget(#FILE_WEBGADGET_09,0,0,WindowWidth(#FILE_WINDOW_09),WindowHeight(#FILE_WINDOW_09))
        Case #FILE_WINDOW_10 : ResizeGadget(#FILE_WEBGADGET_10,0,0,WindowWidth(#FILE_WINDOW_10),WindowHeight(#FILE_WINDOW_10))
      EndSelect
      
    Case #PB_Event_CloseWindow
      Select EventWindow()
        ;Case #WHD_WINDOW : CloseWindow(#WHD_WINDOW)
        Case #MAIN_WINDOW : PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_5)
        Case #FILTER_WINDOW  : CloseWindow(#FILTER_WINDOW) : Window_Update()
        Case #FILE_WINDOW_01 : CloseWindow(#FILE_WINDOW_01) : Window_Update()
        Case #FILE_WINDOW_02 : CloseWindow(#FILE_WINDOW_02) : Window_Update()
        Case #FILE_WINDOW_03 : CloseWindow(#FILE_WINDOW_03) : Window_Update()
        Case #FILE_WINDOW_04 : CloseWindow(#FILE_WINDOW_04) : Window_Update()
        Case #FILE_WINDOW_05 : CloseWindow(#FILE_WINDOW_05) : Window_Update()
        Case #FILE_WINDOW_06 : CloseWindow(#FILE_WINDOW_06) : Window_Update()
        Case #FILE_WINDOW_07 : CloseWindow(#FILE_WINDOW_07) : Window_Update()
        Case #FILE_WINDOW_08 : CloseWindow(#FILE_WINDOW_08) : Window_Update()
        Case #FILE_WINDOW_09 : CloseWindow(#FILE_WINDOW_09) : Window_Update()
        Case #FILE_WINDOW_10 : CloseWindow(#FILE_WINDOW_10) : Window_Update()
          
      EndSelect
      
  EndSelect
  
ForEver

Save_Prefs()

End

;- ############### Data Section

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
  
  Fave_Image:
  IncludeBinary "images\Favourite.png"
  
  Folder_Image:
  IncludeBinary "images\Folder.png"
  
  HOL_Image:
  IncludeBinary "images\hol.png"
  
  Lemon_Image:
  IncludeBinary "images\lemon.png"
  
  WHD_Image:
  IncludeBinary "images\WHD.png"
  
  Janeway_Image:
  IncludeBinary "images\Janeway.png"
  
  Pouet_Image:
  IncludeBinary "images\Pouet.png"
  
EndDataSection
; IDE Options = PureBasic 6.00 Beta 3 (Windows - x64)
; CursorPosition = 4
; Folding = AAAAAAAAAAAAAAAAAAAAAAAAAA+
; Optimizer
; EnableThread
; EnableXP
; EnableUser
; DPIAware
; UseIcon = Images\joystick.ico
; Executable = E:\UltraMiggy\UltraMiggy.exe
; CurrentDirectory = E:\UltraMiggy\
; Compiler = PureBasic 6.00 Beta 3 (Windows - x64)
; Debugger = Standalone