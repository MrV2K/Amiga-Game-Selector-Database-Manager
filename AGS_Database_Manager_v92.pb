;- ############### Amiga Game Selector Database Manager Info
;
Global Version.s="0.9.2"
;
; © 2025 Paul Vince (MrV2k)
;
; https://www.amigagameselector.co.uk
;
; [ PB V5.7x/V6.x / 32Bit / 64Bit / Windows / DPI ]
;
; A database manager for the Amiga Game Selector WHDLoad launcher software
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
; 36. Added previous and next buttons to the Edit_Database window
; 37. Added a macro to populate the Edit_Database window gadgets
; 38. Re-added close UAE to prefs file ??????
; 39. Amiga startup script adjusts to Close_UAE variable
; 40. Tweaked sort to take into account tags
; 41. Genres list and map are only loaded once and shared between procedures
; 42. Improved genre selection in Edit_Database window.
; 43. Create IFF images removes editors and intros that share the same slave as the main game/demo for AGS slave scans.
; 44. *** Added AGS info and slaves to images *** Removed - Unnecessary
; 45. Included launchbox into 'All Sets' creation in Create_IFF procedure
; 46. Added 320x256 resize to IGame RTG IFF image creation as source is now 640x512
; 47. Fixed magazine image size
; 48. Removed Base Set from IFF creation as it's pointless
; 49. Split CD32 source code into separate program UltraCD32
; 50. Removed magazines from source. Created separate program.
; 51. Integrated new FTP procedures into main code.
; 52. Cleaned up Update_HDF procedure
; 53. Added UM_Sort to Add_Database_Entry procedure
; 54. Slaves are no longer lower case
; 55. Update Database now extracts the readme file from the WHDLoad archive automatically.
; 56. Improved load info speed.
; 57. Converted small procedures to macros.
; 58. Moved filter reset to main window.
; 59. Removed exit button from filter window and resized.
; 60. Filter window is now centered on the main window height.
; 61. Added database backup to update database procedure.
; 62. Fixed update hdf script.
; 63. Added load database entry procedure to restore from backups.
; 64. Fixed re-install script
; 65. Main window now sent to bottom of the window stack
; 66. Added word wrap to amiga startup script
; 67. Added extract readme file to add and update procedures.
; 68. Added Make USB Drive for A500 Mini
; 69. Fixed title when swapping panels
; 70. Added many procedures and macros to create configs and images for AGS.
; 71. All consoles are now centered on the main screen.
; 72. Update HDF now delete the icon file
; 73. Update database now removes the json backup
;
;============================================
; VERSION INFO v0.8
;============================================
;
; 01. Added support for WHDLoad disk magazines.
; 02. Fixed LHA & LZX extraction in add & update database procedures.
; 03. Added lzx support to get readme procedure.
; 04. Added launch button for WHDLoad.de on games list editor window.
; 05. Fixed a couple of bugs in edit game list when using next / previous buttons.
; 06. Added time to build version number
; 07. Changed PD disk header font
; 08. Update database cleanup deletes redundant folders.
; 09. Fixed the ASCii splash text
; 10. Got rid of annoying error message at end of HDF install.
; 11. Added magazines to add database entry.
; 12. Demos and Magazines now default to 0 players in add database entry.
; 13. List recursive full scrapes sha1 and crc32 data from files.
; 14. Filter window now a child of the main window.
; 15. Delete old files in download ftp now automatic
; 16. Disabled music stuff.
; 17. Removed dupe text file extraction from update database procedure.
; 18. Split ECS & OCS into separate database entries.
; 19. Added SPS scanning to add/update database.
; 20. Tweaked the create image procedure.
; 21. Updated the create IGame csv for v2.4.0.
; 22. Added igame.data creating macro.
; 23. Fixed IGame CSV creation for non game whdload icons in same archive.
; 24. Added disk and non disk miscellaneaous genres
; 25. Switched all FTP processes to HTTP.
; 26. Fixed MD5 Error
; 27. Fixed duplicate downloads if FTP update was triggered more than once.
; 28. Updated ftp procedures to new Beta process.
; 29. Added error checking to WinUAE startup procedure.
; 30. Updated Create PD Image for new beta process.
; 31. Added key break to download procedure.
; 32. Added filter to File menu.
;
;============================================
; VERSION INFO v0.9
;============================================
;
; 1. Added columns and column sort to the main list.
; 2. Added better text logic to edit database window.
; 3. Added new AGS settings window to edit database.
; 4. Added 'Open Archive' to menus
;
;============================================
; VERSION INFO v0.9.1
;============================================
;
; 1. Fixed UpdateHDF for the thousanth time. No longer checks for WHDTemp folder. Uses a standard path. Added check to WB side to check if drive has mounted successfully.
;
;============================================
; VERSION INFO v0.9.2
;============================================
;
; 1. Changed name to reflect AGS database management.
;
;============================================
;
; To Do List
;
;============================================
;
; 1. Add OCS (A500) (A2000 - 030) config
; 
;============================================

;- ############### Imports

Import ""
  GetConsoleWindow(Void)
EndImport

EnableExplicit

;- ############### Enumerations

Enumeration
  
  #FILE
  #REGEX
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
  #AGS_WINDOW
  #EXTRA_PANEL
  #FILTER_PANEL
  #MAIN_CONTAINER
  #AGS_LIST
  #AGS_START
  #AGS_CANCEL
  #AGS_CLEAR
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
  #LOGO_IMAGE
  #CONVERT_IMAGE
  #SCREEN_BLANK
  #COVER_BLANK
  #LOGO_BLANK
  #IFF_POPUP
  #OUTPUT_POPUP
  #PREVIEW_IMAGE
  #TEMP_IMAGE
  #BACK_IMAGE
  #POPUP_MENU
  #IMAGE_POPUP_MENU
  #ALPHA_MASK
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
  #HOL_NEW_ICON
  #LEMON_ICON
  #WHD_ICON
  #JANEWAY_ICON
  #POUET_ICON
  #SAVE_ICON
  #CREATE_ICON
  #DELETE_ICON
  #NEW_ICON
  #UPDATE_ICON
  #QUIT_ICON
  #ARCHIVE_ICON
  #AGS_ICON
  
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
  #MenuItem_2c
  #MenuItem_3
  #MenuItem_4
  #MenuItem_5
  #MenuItem_5a
  #MenuItem_6
  #MenuItem_7
  #MenuItem_8
  #MenuItem_8a
  #MenuItem_8b
  #MenuItem_9
  #MenuItem_9a
  #MenuItem_9b
  #MenuItem_9c
  #MenuItem_9d
  #MenuItem_9e
  #MenuItem_10
  #MenuItem_10a
  #MenuItem_10b
  #MenuItem_10c
  #MenuItem_10d
  #MenuItem_10e
  #MenuItem_11
  #MenuItem_12
  #MenuItem_13
  #MenuItem_14
  #MenuItem_15
  #MenuItem_16
  #MenuItem_17
  #MenuItem_18
  #MenuItem_18a
  #MenuItem_18b
  #MenuItem_18c
  #MenuItem_18d
  #MenuItem_18e
  #MenuItem_18f
  #MenuItem_19
  #MenuItem_20
  #MenuItem_21
  #MenuItem_21a
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
  #MenuItem_51
  #MenuItem_52
  #MenuItem_53
  #MenuItem_54
  #MenuItem_55
  #MenuItem_56
  #MenuItem_57
  #MenuItem_58
  #MenuItem_59
  #MenuItem_60
  #MenuItem_61
  #MenuItem_95
  #MenuItem_96
  #MenuItem_97
  #MenuItem_98
  #MenuItem_99
  #MenuItem_99a
  #MenuItem_99b
  #MenuItem_99c
EndEnumeration

;- ############### Structures

Structure Down_Data
  Down_Name.s
  Down_Type.s
  Down_Genre.s
  Down_Folder.s
  Down_FTP_Folder.s
  Down_HTTP_Folder.s
  Down_SubFolder_1.s
  Down_SubFolder_2.s
  Down_SubFolder_3.s
  Down_Path.s
  Down_0toZ.s
EndStructure

Structure Sort_Struc
  List nums.s()
  List a.s()
  List b.s()
  List c.s()
  List d.s()
  List e.s()
  List f.s()
  List g.s()
  List h.s()
  List i.s()
  List j.s()
  List k.s()
  List l.s()
  List m.s()
  List n.s()
  List o.s()
  List p.s()
  List q.s()
  List r.s()
  List s.s()
  List t.s()
  List u.s()
  List v.s()
  List w.s()
  List x.s()
  List y.s()
  List z.s()
EndStructure

Structure Sort_Struc2
  
  List nums.i()
  List a.i()
  List b.i()
  List c.i()
  List d.i()
  List e.i()
  List f.i()
  List g.i()
  List h.i()
  List i.i()
  List j.i()
  List k.i()
  List l.i()
  List m.i()
  List n.i()
  List o.i()
  List p.i()
  List q.i()
  List r.i()
  List s.i()
  List t.i()
  List u.i()
  List v.i()
  List w.i()
  List x.i()
  List y.i()
  List z.i()
  
EndStructure

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
  UM_ECS.b
  UM_OCS.b
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
  UM_Beta_Type.s
  UM_Year.s
  UM_Players.s
  UM_Icon.s
  UM_Sort_Name.s
  UM_Sort_Type.s
  UM_Sort_Date.i
  UM_HOL_Entry.s
  UM_HOL_Entry_New.s
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
  UM_Info_Avail.b

  UM_Beta.b
  UM_InstallSize.i
  UM_Version.s
  UM_7Mhz.b
  UM_14Mhz.b
  UM_UAE_14Mhz.b
  UM_25Mhz.b
  UM_Max.b
  UM_FC.b
  UM_IB.b
  UM_BW.b
  UM_NT.b
  UM_Offset.s
  UM_VRES.i
  UM_Cycle.b
  UM_NoCycle.b
  UM_Adult.b
  UM_Emerald.b
  UM_Theme.s
  UM_CRC32.s
  UM_SHA1.s
  UM_MD5.s
  UM_FileSize.i
  UM_SPS.s
  UM_Restricted.b
  UM_Data_Disk.b
  UM_Pure.b
  UM_JIT.b
  UM_Update.b
  UM_Screen_Width.i
  UM_Title_Width.i
  UM_Link.b
  UM_Online.b
EndStructure

Structure Fix_Data
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
  F_ECS.b
  F_OCS.b
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
  F_Beta_Type.s
  F_Year.s
  F_Config.i
  F_HOL.s
  F_HOL_New.s
  F_Lemon.s
  F_WHD.s
  F_Janeway.s
  F_Pouet.s
  F_Beta.b
  F_Default_Icon.s
  F_Default_Index.i
  F_InstallSize.i
  F_Version.s
  F_Adult.b
  F_CRC32.s
  F_SHA1.s
  F_MD5.s
  F_FileSize.i
  F_SPS.s
  F_Restricted.b
  F_Data_Disk.b
  F_Pure.b
  F_Image_Cover_CRC.s
  F_Screen_Cover_CRC.s
  F_Title_Cover_CRC.s
  F_7Mhz.b
  F_14Mhz.b
  F_UAE_14Mhz.b
  F_25Mhz.b
  F_Max.b
  F_FC.b
  F_IB.b
  F_BW.b
  F_NT.b
  F_Offset.s
  F_VRES.i
  F_Cycle.b
  F_NoCycle.b
  F_Link.b
  F_Online.b
EndStructure

Structure Export_Struct
  WHD_Title.s
  WHD_Short.s
  WHD_Genre.s
  WHD_Slave.s
  WHD_Slave_Date.s
  WHD_Folder.s
  WHD_LHAFile.s
  WHD_Language.s
  WHD_Chipset.s
  WHD_TV_System.s
  WHD_Sound.s
  WHD_Hardware.s
  WHD_Publisher.s
  WHD_Developer.s
  WHD_Party.s
  WHD_Year.s
  WHD_HOL.s
  WHD_HOL_New.s
  WHD_Lemon.s
  WHD_WHD.s
  WHD_Janeway.s
  WHD_Pouet.s
  WHD_Turran.s
  WHD_Default_Icon.s
  WHD_InstallSize.i
  WHD_Version.s
  WHD_Players.s
  WHD_SHA1.s
  WHD_CRC32.s
  WHD_MD5.s
  WHD_FileSize.i
EndStructure

Structure Arc_Data
  Arc_Name.s
  Arc_CRC.s
  Arc_Beta_Type.s
  Arc_HTTP_Folder.s
EndStructure

Structure Dat_Names
  Arc_Type.s
  Arc_Beta_Type.s
  Arc_Folder.s
  Arc_FTP_Path.s
  List Arc_Info.Arc_Data()
EndStructure

Structure System_Data
  Sys_Name.s
  Sys_File.s
EndStructure

Structure AGS_Update
  Input_Path.s
  Output_Path.s
  PC_Path.s
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
  Dupe_Short.b
EndStructure

Structure Sort_Data
  Col1.b
  Col2.b
  Col3.b
  Col4.b
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

Structure File_Data
  R_File_Size.l
  R_File_Name.s
  R_File_File.s
  R_File_CRC32.s
  R_File_SHA1.s
  R_File_MD5.s
  R_File_Type.s
EndStructure

Structure Sort_DB
  S_Name.s
  S_Index.i
  S_SubFolder.s
  S_Type.s
EndStructure

Structure search_data
  Search_Title.s
  Search_Type.s
  List Search_Folders.s()
EndStructure

Structure List_Data
  L_Number.i
  L_Name.s
  L_Type.s
  L_Year.s
  L_Slave_Date.i
EndStructure

Structure Check_Struct
  CS_Name.s
  CS_CRC32.s
  CS_Type.s
EndStructure

;- ############### Lists

Global NewList UM_Database.UM_Data()
Global NewList Systems_Database.System_Data()
Global NewList Fix_List.Fix_Data()
Global NewList Down_List.Down_Data()

Global NewList List_Numbers.List_Data()

Global NewList Files.s()
Global NewList File_List.s()
Global NewList File_List_Full.File_Data()

Global NewList WHD_List.WHD_Data()

Global NewList Genre_List.s()
Global NewMap  Genre_Map.i()
Global NewMap  Duplicates.i()
Global NewList Dupe_List.i()
Global NewList Music_List.s()
Global NewList List_Games.s()
Global NewList WEB_List.Web_Data()
Global NewList Dat_List.s()

;########### TEMP ############

Global NewList Menu_List.s()

;#############################

Global NewList Dat_Archives.Dat_Names()

Global Dim Filter.Filter_Data(1)
Global Dim Column_Sort.Sort_Data(1)

;- ############### Global Variables

Global W_Title.s="AGS Database Manager "+Version
Global Build.s=FormatDate("%dd%mm%yy-%hh%mm%ss", #PB_Compiler_Date)

Global Main_Path.s, path.s, path2.s, path3.s, path4.s

Global event.i, listnum.i, count.i, i.i, list_pos.i 

Global Main_Menu.i, Title_Image, Cover_Image, Screen_Image, IFF_Image, Logo_Image, Info_Gadget, Mutex, Video_Gadget
Global Play_Button, Stop_Button, Volume_Slider, Track_Combo

Global Title_Image_Title.i, paste_gadget.i

Global current_folder.s

Global w_list, w_tree

Global update_db.b

Global hWnd

Global Language_Gadget, Memory_Gadget, Year_Gadget, Publisher_Gadget, Disks_Gadget, Developer_Gadget
Global Chipset_Gadget, Hardware_Gadget, DiskCategory_Gadget, Sound_Gadget, DataType_Gadget, Players_Gadget, Group_Gadget
Global Search_Gadget, Coder_Gadget, Category_Gadget, Filter_Gadget, Genre_Gadget, Reset_Button, Filter_Button, Clear_Button

Global date_sort.b=#False ; True = Ascending...
Global type_sort.b=#False

Global t_image.i, t_path.s, startup_prog.i ; For Threads

Global Home_Path.s=GetCurrentDirectory()
Global Data_Path.s=Home_Path+"UM_Data\"
Global Dats_Path.s=Data_Path+"Dats\"
Global DB_Path.s=Home_Path
Global Game_Data_Path.s=Home_Path+"Game_Data\"
Global Backup_Path.s=Home_Path+"Backup\"
Global WHD_Folder.s=Home_Path+"WHD\"
Global IG_Path.s=Home_Path+"Configurations\" 
Global WHD_TempDir.s=Home_Path+"WHDTemp\"
Global AGS_Path.s=Home_Path+"HDF\Workbench\AGS\AGS2\"

Global LHA_Path.s=Home_Path+"Binaries\7z.exe"
Global IZARC_Path.s=Home_Path+"Binaries\izarcc.exe"
Global IZARCE_Path.s=Home_Path+"Binaries\izarce.exe"
Global LZX_Path.s=Home_Path+"Binaries\unlzx.exe"
Global NConvert_Path.s=Home_Path+"Binaries\nconvert.exe"
Global WinUAE_Path.s=Home_Path+"WinUAE\winuae64.exe"

Global HTTP_Server.s="http://ftp2.grandis.nu/turran/FTP/Retroplay%20WHDLoad%20Packs"

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

Global Sort_Column=0

Column_Sort(0)\Col1=#False
Column_Sort(0)\Col2=#False
Column_Sort(0)\Col3=#False
Column_Sort(0)\Col4=#False

;- ############### Declares

Declare WinCallback(hWnd, uMsg, WParam, LParam)

;- ############### Macros

Macro Center_Console()
  hWnd = GetConsoleWindow(0)
  MoveWindow_(hWnd, DpiX(WindowX(#MAIN_WINDOW))+(WindowWidth(#MAIN_WINDOW)/8), DpiY(WindowY(#MAIN_WINDOW))+(WindowHeight(#MAIN_WINDOW)/8), DpiX(WindowWidth(#MAIN_WINDOW)/1.25), DpiY(WindowHeight(#MAIN_WINDOW)/1.25), 1)
EndMacro

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
  PrintS()
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
  SelectElement(UM_Database(),List_Numbers()\L_Number)  
EndMacro

Macro Language(exp,lang)
  CreateRegularExpression(#REGEX,"_("+exp+")(\.|_)")
  If MatchRegularExpression(#REGEX, UM_Database()\UM_LHAFile) : UM_Database()\UM_Language=lang : EndIf
  FreeRegularExpression(#REGEX)
EndMacro

Macro Populate_Edit_Gadgets()
  
  Pause_Window(#EDIT_WINDOW)
  
  SetGadgetText(Title_String,UM_Database()\UM_Title)
  SetGadgetText(Short_Title,"Short ("+Str(Len(UM_Database()\UM_Short))+")")    
  SetGadgetText(Short_String,UM_Database()\UM_Short)
  SetGadgetText(Language_String,UM_Database()\UM_Language)
  SetGadgetText(Path_String,UM_Database()\UM_LHAFile)
  If UM_Database()\UM_Type="Demo"
    SetGadgetText(Publisher_Title, "Group ("+Str(Len(UM_Database()\UM_Publisher))+")")
  Else
    SetGadgetText(Publisher_Title, "Publ. ("+Str(Len(UM_Database()\UM_Publisher))+")")
  EndIf
  SetGadgetText(Coder_String,UM_Database()\UM_Publisher)
  SetGadgetText(Developer_String,UM_Database()\UM_Developer)
  SetGadgetText(Date_String,UM_Database()\UM_Slave_Date)
  SetGadgetText(Year_String,UM_Database()\UM_Year)
  SetGadgetText(Memory_String,UM_Database()\UM_Memory)
  SetGadgetText(Disk_String,UM_Database()\UM_Disks) 
  SetGadgetText(Players_String,UM_Database()\UM_Players)
  SetGadgetText(Folder_String,UM_Database()\UM_Folder)
  SetGadgetText(Slave_String,UM_Database()\UM_Slave)
  SetGadgetText(Icon_String,UM_Database()\UM_Icon)
  SetGadgetText(CRC_String,UM_Database()\UM_CRC32)
  SetGadgetText(HOL_String,UM_Database()\UM_HOL_Entry)  
  SetGadgetText(HOL_String_New,UM_Database()\UM_HOL_Entry_New)  
  SetGadgetText(Lemon_String,UM_Database()\UM_Lemon_Entry) 
  SetGadgetText(WHD_String,UM_Database()\UM_WHD_Entry) 
  SetGadgetText(Janeway_String,UM_Database()\UM_Janeway)
  SetGadgetText(Pouet_String,UM_Database()\UM_Pouet)
  SetGadgetText(Party_String,UM_Database()\UM_Party)
  
  If UM_Database()\UM_Type="Demo"
    DisableGadget(HOL_String,#True)
    DisableGadget(HOL_String_New,#True)
    DisableGadget(Lemon_String,#True)
    DisableGadget(Janeway_String,#False)
    DisableGadget(Pouet_String,#False)
    DisableGadget(Party_String,#False)
  EndIf
  If UM_Database()\UM_Type="Beta" And UM_Database()\UM_Beta_Type="Demo"
    DisableGadget(HOL_String,#True)
    DisableGadget(HOL_String_New,#True)
    DisableGadget(Lemon_String,#True)
    DisableGadget(Janeway_String,#False)
    DisableGadget(Pouet_String,#False)
    DisableGadget(Party_String,#False)
  EndIf
  If UM_Database()\UM_Type="Magazine"
    DisableGadget(HOL_String,#True)
    DisableGadget(HOL_String_New,#True)
    DisableGadget(Lemon_String,#True)
    DisableGadget(Janeway_String,#False)
    DisableGadget(Pouet_String,#False)
    DisableGadget(Party_String,#False)
  EndIf 
  If UM_Database()\UM_Type="Game"
    DisableGadget(Janeway_String,#True)
    DisableGadget(Pouet_String,#True)
    DisableGadget(Party_String,#True)
    DisableGadget(HOL_String,#False)
    DisableGadget(HOL_String_New,#False)
    DisableGadget(Lemon_String,#False)
  EndIf
  If UM_Database()\UM_Type="Beta" And UM_Database()\UM_Beta_Type="Game"
    DisableGadget(Janeway_String,#True)
    DisableGadget(Pouet_String,#True)
    DisableGadget(Party_String,#True)
    DisableGadget(HOL_String,#False)
    DisableGadget(HOL_String_New,#False)
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
    Case "Magazine"
      SetGadgetState(Type_Combo,4 )
  EndSelect
  
  Select UM_Database()\UM_Beta_Type
    Case ""
      SetGadgetState(Beta_Type_Combo,0)
    Case "Game"
      SetGadgetState(Beta_Type_Combo,1)
    Case "Demo"
      SetGadgetState(Beta_Type_Combo,2)
    Case "Beta"
      SetGadgetState(Beta_Type_Combo,3)
    Case "Magazine"
      SetGadgetState(Beta_Type_Combo,4 )
  EndSelect
  
  If UM_Database()\UM_Beta=#False
    DisableGadget(Beta_Type_Combo,1)
  Else
    DisableGadget(Beta_Type_Combo,0)
  EndIf
  
  SetGadgetState(Config_Combo,UM_Database()\UM_Config)
  
  If FindMapElement(Genre_Map(),UM_Database()\UM_Genre)
    SetGadgetState(Genre_Combo,Genre_Map())   
  Else
    SetGadgetState(Genre_Combo, CountGadgetItems(Genre_Combo))
  EndIf
  
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
  SetGadgetState(Pure_Check,UM_Database()\UM_Pure)
  SetGadgetState(Link_Check,UM_Database()\UM_Link)
  SetGadgetState(Online_Check,UM_Database()\UM_Online)
  SetGadgetState(Chipset_Combo,0)
  If UM_Database()\UM_AGA : SetGadgetState(Chipset_Combo,3) : EndIf
  If UM_Database()\UM_ECS : SetGadgetState(Chipset_Combo,2) : EndIf
  If UM_Database()\UM_OCS : SetGadgetState(Chipset_Combo,1) : EndIf
  
  SetGadgetState(PD_Check,UM_Database()\UM_PD)
  SetGadgetState(Restricted_Check,UM_Database()\UM_Restricted)
  
  SetGadgetState(Adult_Check,UM_Database()\UM_Adult) 
  
  SetGadgetState(Data_Disk_Check,UM_Database()\UM_Data_Disk)
  
  Resume_Window(#EDIT_WINDOW)
  
EndMacro

Macro Generate_Images()
  
  If response="1" Or response="5" ; IGame
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame\Covers\ECS_Laced\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -rtype lanczos -ratio -resize 160 128 -canvas 160 128 center -bgcolor 0 0 0 -resize 160 128 -colours 16 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait) 
      IGame_Data_Entry()
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame\Covers\AGA_Laced\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -rtype lanczos -ratio -resize 160 128 -canvas 160 128 center -bgcolor 0 0 0 -resize 160 128 -floyd -colours 64 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      IGame_Data_Entry()
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame\Covers\ECS_LoRes\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -rtype lanczos -ratio -resize 160 128 -canvas 160 128 center -bgcolor 0 0 0 -resize 160 64 -floyd -colours 16 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait) 
      IGame_Data_Entry()
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame\Covers\AGA_LoRes\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -rtype lanczos -ratio -resize 160 128 -canvas 160 128 center -bgcolor 0 0 0 -resize 160 64 -floyd -colours 64 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      IGame_Data_Entry()
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame\Covers\RTG\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -rtype lanczos -ratio -resize 320 256 -canvas 320 256 center -bgcolor 0 0 0 -resize 320 256 -floyd -colours 256 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      IGame_Data_Entry()
    EndIf
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame\Screens\ECS_Laced\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 160 128 -rtype quick -floyd -colours 16 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)      
      IGame_Data_Entry()
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame\Screens\AGA_Laced\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 160 128 -rtype quick -floyd -colours 64 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)    
      IGame_Data_Entry()
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame\Screens\ECS_LoRes\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 160 64 -rtype quick -floyd -colours 16 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)    
      IGame_Data_Entry()
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame\Screens\AGA_LoRes\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 160 64 -rtype quick -floyd -colours 64 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)   
      IGame_Data_Entry()
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame\Screens\RTG\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 320 256 -rtype quick -floyd -colours 256 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      IGame_Data_Entry()
    EndIf
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame\Titles\ECS_Laced\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 160 128 -rtype quick -floyd -colours 16 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)   
      IGame_Data_Entry()
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame\Titles\AGA_Laced\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 160 128 -rtype quick -floyd -colours 64 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      IGame_Data_Entry()
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame\Titles\ECS_LoRes\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 160 64 -rtype quick -floyd -colours 16 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait) 
      IGame_Data_Entry()
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame\Titles\AGA_LoRes\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 160 64 -rtype quick -floyd -colours 64 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      IGame_Data_Entry()
      new_file$=#DOUBLEQUOTE$+dest_folder$+"IGame\Titles\RTG\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 320 256 -rtype quick -floyd -colours 256 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      IGame_Data_Entry()
    EndIf
  EndIf
  
  If response="2" Or response="5" ; Tinylauncher
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"TinyLauncher\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+"_SCR1.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -ratio -resize 320 256 -rtype lanczos -canvas 320 256 center -colors 32 -floyd "+source_file$
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
  
  If response="3" Or response="5" ; PC
    source_file$=source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png"
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"PNG\Slave\Covers\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
      path="-quiet -overwrite -clevel 9 -resize 640 824 -rtype quick -out png -o "+new_file$+" "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"PNG\Slave\Screens\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
      path="-quiet -overwrite -clevel 9 -resize 640 512 -rtype quick -out png -o "+new_file$+" "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"PNG\Slave\Titles\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
      path="-quiet -overwrite -clevel 9 -resize 640 512 -rtype quick -out png -o "+new_file$+" "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf 
  EndIf 
  
  If response="4" Or response="5" ; Launchbox
    source_file$=source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png"
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"PNG\LHA\Covers\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_LHAFile,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
      path="-quiet -overwrite -clevel 9 -resize 640 824 -rtype quick -out png -o "+new_file$+" "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"PNG\LHA\Screens\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_LHAFile,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
      path="-quiet -overwrite -clevel 9 -resize 640 512 -rtype quick -out png -o "+new_file$+" "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0
      new_file$=#DOUBLEQUOTE$+dest_folder$+"PNG\LHA\Titles\"+UM_Database()\UM_Type+"\"+GetFilePart(UM_Database()\UM_LHAFile,#PB_FileSystem_NoExtension)+".png"+#DOUBLEQUOTE$
      path="-quiet -overwrite -clevel 9 -resize 640 512 -rtype quick -out png -o "+new_file$+" "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
    EndIf
  EndIf   
  
  If response="6" ; AGS RTG
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0        
      new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Mini_Covers_RTG\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 320 256 -rtype quick -colours 128 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      IGame_Data_Entry()
    EndIf
  EndIf
  
  If response="7" ; AGS AGA
    source_file$=#DOUBLEQUOTE$+source_folder$+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png"+#DOUBLEQUOTE$
    If FileSize(RemoveString(source_file$,#DOUBLEQUOTE$))>0        
      new_file$=#DOUBLEQUOTE$+dest_folder$+"AGS_Mini_Covers_AGA\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\igame.iff"+#DOUBLEQUOTE$
      path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 160 128 -rtype lanczos -floyd -colours 64 "+source_file$
      RunProgram(nconvert_path,path,"",#PB_Program_Wait)
      IGame_Data_Entry()
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

Macro Copy3Bytes(Source, Destination)
  PokeA(Destination, PeekA(Source))
  PokeW(Destination+1, PeekW(Source+1))
EndMacro

Macro Copy4Bytes(Source, Destination)
  PokeL(Destination, PeekL(Source))
EndMacro

Macro OpenFolder(folder_path)
  RunProgram(folder_path)  
EndMacro

Macro IGame_Data_Entry()
  
  If CreateFile(0,GetPathPart(new_file$)+"igame.data")
    output$="title="+UM_Database()\UM_Title+Tags()+#LF$
    output$+"year="+UM_Database()\UM_Year+#LF$
    output$+"by="+UM_Database()\UM_Publisher+#LF$
    If UM_Database()\UM_AGA
      output$+"chipset=AGA"+#LF$
    Else
      If UM_Database()\UM_OCS
        output$+"chipset=OCS"+#LF$
      Else
        output$+"chipset=ECS,OCS"+#LF$
      EndIf
    EndIf
    output$+"genre="+UM_Database()\UM_Genre+#LF$
    output$+"players="+UM_Database()\UM_Players+#LF$
    output$+"exe="+#LF$
    output$+"arguments="+#LF$
    output$+"lemon="+UM_Database()\UM_Lemon_Entry+#LF$
    output$+"hol="+UM_Database()\UM_HOL_Entry+#LF$
    output$+"pouet="+UM_Database()\UM_Pouet+#LF$
    WriteString(0,output$) 
    CloseFile(0)
  Else
    MessageRequester("Error","Cannot create file",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
  EndIf
  
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

Procedure List_Files_Recursive_Size(Dir.s, List Files.File_Data(), Extension.s) ; <------> Adds All Files In A Folder Into The Supplied List with size information
  
  Protected NewList Directories.s()
  
  Protected Folder_LIST
  
  If Right(Dir, 1) <> Chr(92)
    Dir + Chr(92)
  EndIf
  
  If ExamineDirectory(Folder_LIST, Dir, Extension)
    While NextDirectoryEntry(Folder_LIST)
      Select DirectoryEntryType(Folder_LIST)
        Case #PB_DirectoryEntry_File
          AddElement(Files())
          Files()\R_File_Name = Dir + DirectoryEntryName(Folder_LIST) 
          Files()\R_File_File = DirectoryEntryName(Folder_LIST) 
          Files()\R_File_Size = DirectoryEntrySize(Folder_LIST)
          If FindString(DirectoryEntryName(Folder_LIST),"_Demos") : Files()\R_File_Type="Demo" : EndIf
          If FindString(DirectoryEntryName(Folder_LIST),"_Games") : Files()\R_File_Type="Game" : EndIf
          If FindString(DirectoryEntryName(Folder_LIST),"_Beta") : Files()\R_File_Type="Beta" : EndIf
          If FindString(DirectoryEntryName(Folder_LIST),"_Magazine") : Files()\R_File_Type="Magazine" : EndIf
          Files()\R_File_CRC32 = FileFingerprint(Files()\R_File_Name,#PB_Cipher_CRC32)
        Case #PB_DirectoryEntry_Directory
          Select DirectoryEntryName(Folder_LIST)
            Case ".", ".."
              Continue
            Default
              AddElement(Directories())
              Directories() = Dir + DirectoryEntryName(Folder_LIST)
              
          EndSelect
      EndSelect
    Wend
    FinishDirectory(Folder_LIST)
    ForEach Directories()
      List_Files_Recursive_Size(Directories(), Files(), Extension)
    Next
  EndIf 
  
  FreeList(Directories())
  
EndProcedure

Procedure List_Files_Recursive_Size_Only(Dir.s, List Files.File_Data(), Extension.s) ; <------> Adds All Files In A Folder Into The Supplied List with size information
  
  Protected NewList Directories.s()
  
  Protected Folder_LIST
  
  If Right(Dir, 1) <> Chr(92)
    Dir + Chr(92)
  EndIf
  
  If ExamineDirectory(Folder_LIST, Dir, Extension)
    While NextDirectoryEntry(Folder_LIST)
      Select DirectoryEntryType(Folder_LIST)
        Case #PB_DirectoryEntry_File
          AddElement(Files())
          Files()\R_File_Name = Dir + DirectoryEntryName(Folder_LIST)
          count=FindString(files()\R_File_Name,"\")
          Files()\R_File_File = Left(Files()\R_File_Name,count)
          Files()\R_File_Size = DirectoryEntrySize(Folder_LIST)
        Case #PB_DirectoryEntry_Directory
          Select DirectoryEntryName(Folder_LIST)
            Case ".", ".."
              Continue
            Default
              AddElement(Directories())
              Directories() = Dir + DirectoryEntryName(Folder_LIST)
              
          EndSelect
      EndSelect
    Wend
    FinishDirectory(Folder_LIST)
    ForEach Directories()
      List_Files_Recursive_Size_Only(Directories(), Files(), Extension)
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

Procedure Check_Missing_Info()
  
  ForEach UM_Database()  
    UM_Database()\UM_Info_Avail=#False   
    path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\game_info.txt"
    If UM_Database()\UM_Type <> "Demo" And UM_Database()\UM_Type <> "Magazine" 
      If FileSize(path)>0
        UM_Database()\UM_Info_Avail=#True
      Else
        UM_Database()\UM_Info_Avail=#False
      EndIf
    EndIf
  Next
  
EndProcedure

Procedure Check_Image_Width()
  
  Protected path2.s, image_num.i
  
  ForEach UM_Database()  
    If UM_Database()\UM_Screen_Width<=0
      path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png" 
      image_num=LoadImage(#PB_Any,path)
      UM_Database()\UM_Screen_Width=ImageWidth(image_num)
      FreeImage(image_num) 
    EndIf

    If UM_Database()\UM_Title_Width<=0
      path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png"
      image_num=LoadImage(#PB_Any,path)
      UM_Database()\UM_Title_Width=ImageWidth(image_num) 
      FreeImage(image_num)  
    EndIf
  Next
  
EndProcedure

Procedure Check_Missing_Images(type.i)
  
  Protected path2.s, image_num.i
  
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

Procedure.s Tags_Short()
  
  Protected extras.s=" "
  
  If UM_Database()\UM_Memory<>""
    Select UM_Database()\UM_Memory
      Case "512k" : extras+"512k"
      Case "512KB" : extras+"512k"
      Case "1MB" : extras+"1MB"
      Case "1MB Chip" : extras+"1MBChp"
      Case "1.5MB" : extras+"1-5MB"
      Case "2MB" : extras+"2MB"
      Case "8MB" : extras+"8MB"
      Case "Chip Mem" : extras+"Chp"
      Case "Fast Mem" : extras+"Fst"
      Case "Low Mem" : extras+"Lw"
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
    extras+Chr(223)
  EndIf
  
  If UM_Database()\UM_Language<>"" And UM_Database()\UM_Language<>"English"
    Select UM_Database()\UM_Language
      Case "Croatian" : extras+"Hr"
      Case "Czech" : extras+"Cz"
      Case "Danish" : extras+"Dk"
      Case "Dutch" : extras+"Nl"
      Case "Finnish" : extras+"Fi"
      Case "French" : extras+"Fr"
      Case "German" : extras+"De"
      Case "Greek" : extras+"Gr"
      Case "Italian" : extras+"It"
      Case "Multi" : extras+"Mul"
      Case "Polish" : extras+"Pl"
      Case "Spanish" : extras+"Es"
      Case "Swedish" : extras+"Se"
    EndSelect
  EndIf
  
  If extras=" " : extras="" : EndIf
  
  ProcedureReturn extras
  
EndProcedure

Procedure.s Tags()
  
  Protected extras.s=""
  
  If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
    extras+" ("+UM_Database()\UM_Publisher+")"
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
  
  If UM_Database()\UM_Memory<>""
    extras+" ("+UM_Database()\UM_Memory+")"
  EndIf 
  
  If UM_Database()\UM_Language<>"" And UM_Database()\UM_Language<>"English"
    extras+" ("+UM_Database()\UM_Language+")"
  EndIf
  
  If UM_Database()\UM_Favourite=#True
    extras+ " (♥)"
  EndIf
  
  ProcedureReturn extras
  
EndProcedure

Procedure.s GetSelectedText(gad)
  Protected t$
  t$=Space(999) : SendMessage_(GadgetID(gad),#EM_GETSELTEXT,0,@t$)
  ProcedureReturn t$
EndProcedure

Procedure.s Get_SPS_Number(lha_name.s)
  
  Protected number.s
  
  lha_name=RemoveString(lha_name,".lha")
  lha_name=RemoveString(lha_name,".lzx")
  
  count=CountString(lha_name,"_")
  
  number=StringField(lha_name,count+1,"_")
  
  If Len(Str(Val(number)))=4
    ProcedureReturn number
  EndIf
  
EndProcedure

Procedure ButtonIconGadget(num, x, y, w, h, text$, imageId, icoW, icoH)
  Protected buttonBack, thisImg, gadId
  buttonBack = #White
  thisImg = CreateImage(#PB_Any, w, h)
  StartDrawing(ImageOutput(thisImg))
  Box(0, 0, w, h, buttonBack)
  DrawingMode(#PB_2DDrawing_AlphaBlend)
  DrawImage(imageId, 2, (h - icoH)/2, icoW, icoH)
  DrawingMode(#PB_2DDrawing_Default)
  DrawingFont(GetStockObject_(#DEFAULT_GUI_FONT))
  DrawText(icoW + 10, (h - TextHeight(text$))/2, text$, #Black, buttonBack)
  StopDrawing()
  gadId = ButtonImageGadget(num, x, y, w, h, ImageID(thisImg))
  ProcedureReturn gadId
EndProcedure

Procedure Process_Tosec()
  
  Protected Remove$, output$, fullname$, program$, extension$, description$, pad1, text$, script$, menu$
  Protected type.b
  
  type=MessageRequester("Information","Speccy (Yes) or C64 (No)",#PB_MessageRequester_Info|#PB_MessageRequester_YesNo)
  
  path=PathRequester("Select Path",Home_Path)
  
  ClearList(File_List())
  
  List_Files_Recursive(path,File_List(),"*.*")
  
  ForEach File_List()
    fullname$=GetFilePart(File_List())
    extension$=GetExtensionPart(File_List())
    Remove$=Mid(GetFilePart(File_List()),FindString(GetFilePart(File_List()),"(")-1,Len(GetFilePart(File_List()))-Len(extension$)+1)
    fullname$=RemoveString(fullname$,Remove$)
    fullname$=RemoveString(fullname$,",The")
    fullname$=RemoveString(fullname$,", The") 
    menu$=fullname$
    menu$=RemoveString(fullname$,",The")
    output$=RemoveString(GetFilePart(File_List()),Remove$)
    output$=RemoveString(output$," ")
    output$=RemoveString(output$,",The")
    output$=RemoveString(output$,", The")
    output$=RemoveString(output$,"'")
    If Len(fullname$)>36 
      Repeat
        fullname$=InputRequester("Name Too Long!","Shorten full name!",fullname$)
      Until Len(fullname$)<37
    EndIf
    If Len(menu$)>23
      Repeat  
        menu$=InputRequester("Name Too Long!","Shorten menu name!",menu$)
      Until Len(menu$)<24 
    EndIf
    If Len(output$)>23
      output$=Left(output$,21)
    EndIf
    output$+"."+extension$
    If FileSize(path+"Roms")<>-2: CreateDirectory(path+"Roms") : EndIf
    If FileSize(GetPathPart(File_List())+"Roms\"+output$)<>-1
      output$=InputRequester("File Already Exists!","Change File Name!",output$)
      If Len(output$)>21
        Repeat  
          output$=InputRequester("Name Too Long!","Shorten file name!",output$)
        Until Len(output$)<21
      EndIf
    EndIf
    CopyFile(File_List(),GetPathPart(File_List())+"Roms\"+output$)
    If FileSize(path+"Scripts")<>-2: CreateDirectory(path+"Scripts") : EndIf
    count=Len(fullname$)
    pad1=(40-count)/2
    text$=RSet(fullname$,pad1+count)
    description$=" **************************************** "+#LF$
    description$+" *                                      * "+#LF$
    description$+" *                                      * "+#LF$
    description$+" *                                      * "+#LF$
    description$+" *"+text$+RSet("* ",40-Len(text$))+#LF$
    description$+" *                                      * "+#LF$
    description$+" *                                      * "+#LF$
    description$+" *                                      * "+#LF$
    description$+" *                                      * "+#LF$
    description$+" **************************************** "
    If type=#PB_MessageRequester_Yes
      script$="ex scripts:splash"+#LF$
      script$+"ex scripts:disclaimer"+#LF$
      script$+"ex scripts:A4000_Speed"+#LF$
      script$+"cd emulators:zx-live"+#LF$
      script$+"zx-live zxfiles/"+output$+#LF$
      script$+"ex scripts:Speed_Reset"+#LF$
      script$+"cls"+#LF$
      script$+"AGS:"
    Else
      script$="ex scripts:splash"+#LF$
      script$+"ex scripts:disclaimer"+#LF$
      script$+"ex scripts:A4000_Speed"+#LF$
      script$+"cd emulators:Magic64"+#LF$
      If LCase(extension$)="d64"
        script$+"magic64 -ICONIFY -LOADSTRING=*** "+output$+#LF$
      EndIf
      If LCase(extension$)="t64"
        script$+"magic64 -ICONIFY "+output$+#LF$
      EndIf
      script$+"ex scripts:Speed_Reset"+#LF$
      script$+"cls"+#LF$
      script$+"AGS:"
    EndIf
    If FileSize(path+"Scripts\"+menu$+".run")<>-1
      menu$=InputRequester("File Already Exists!","Change menu Name!",menu$)
      If Len(menu$)>23
        Repeat  
          menu$=InputRequester("Name Too Long!","Shorten menu name!",menu$)
        Until Len(menu$)<24 
      EndIf
    EndIf
    If CreateFile(0,path+"Scripts\"+menu$+".run")
      WriteString(0,script$)
      CloseFile(0)
    EndIf
    If CreateFile(0,path+"Scripts\"+menu$+".txt")
      WriteString(0,description$)
      CloseFile(0)
    EndIf
  Next
  
EndProcedure

Procedure.i Convert_AGS_Date(date$)
  
  Protected day$, month$, year$
  
  day$=StringField(date$,1,"-")
  month$=StringField(date$,2,"-")
  month$=LCase(month$)
  
  Select month$
      
    Case "jan"
      month$="01"
    Case "feb"
      month$="02"
    Case "mar"
      month$="03"
    Case "apr"
      month$="04"   
    Case "may"
      month$="05"            
    Case "jun"
      month$="06"            
    Case "jul"
      month$="07"            
    Case "aug"
      month$="08"            
    Case "sep"
      month$="09"            
    Case "oct"
      month$="10"            
    Case "nov"
      month$="11"            
    Case "dec"
      month$="12"
      
  EndSelect
                          
  year$=StringField(date$,3,"-")
  
  If Val(year$)>25 : year$="19"+year$ : Else  : year$="20"+year$ : EndIf
  
  ProcedureReturn Date(Val(year$),Val(month$),Val(Day$),0,0,0)
  
EndProcedure

Procedure Update_Status_Bar()
  
  StatusBarText(#MAIN_STATUS,0,"Type: "+UM_Database()\UM_Type,#PB_StatusBar_Center)
  StatusBarText(#MAIN_STATUS,1,"Genre: "+UM_Database()\UM_Genre,#PB_StatusBar_Center)  
  StatusBarText(#MAIN_STATUS,2,"Year: "+UM_Database()\UM_Year,#PB_StatusBar_Center)
  StatusBarText(#MAIN_STATUS,3,"Players: "+UM_Database()\UM_Players,#PB_StatusBar_Center)
  StatusBarText(#MAIN_STATUS,4,"Language: "+UM_Database()\UM_Language,#PB_StatusBar_Center)
  StatusBarText(#MAIN_STATUS,5,"Icon: "+UM_Database()\UM_Icon,#PB_StatusBar_Center)
  If UM_Database()\UM_ECS : path="ECS" : EndIf
  If UM_Database()\UM_AGA : path="AGA" : EndIf
  If UM_Database()\UM_OCS : path="OCS" : EndIf
  StatusBarText(#MAIN_STATUS,6,"Chipset: "+path,#PB_StatusBar_Center)

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
    Center_Console()
    
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

Macro Set_Filter(bool)
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
EndMacro

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
  
  Column_Sort(0)\Col1=#False
  Column_Sort(0)\Col2=#False
  Column_Sort(0)\Col3=#False
  Column_Sort(0)\Col4=#False
  
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
  
  ForEach UM_Database()
    UM_Database()\UM_Screen_Width=0
     UM_Database()\UM_Title_Width=0
  Next
    
EndProcedure

Procedure Filter_List()
  
  If Filter(0)\Filter_Text="No Game Info"
    Check_Missing_Info()  
  EndIf 
  
  If Filter(0)\Filter_Text="No Image"
    Check_Missing_Images(1)  
  EndIf
  
  If Filter(0)\Filter_Text="No Cover"
    Check_Missing_Images(2)  
  EndIf
  
  If Filter(0)\Filter_Text="No Title"
    Check_Missing_Images(3)  
  EndIf
  
  If Filter(0)\Filter_Text="Image Width"
    Check_Image_Width()  
  EndIf
  
  ForEach UM_Database()
    
    UM_Database()\UM_Filtered=#False
    
    Select Filter(0)\Category_Text
        
      Case "All"
        UM_Database()\UM_Filtered=#False
        
      Case "Game"
        If UM_Database()\UM_Type<>"Game" And UM_Database()\UM_Beta_Type<>"Game"
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "Demo"
        If UM_Database()\UM_Type<>"Demo" And UM_Database()\UM_Beta_Type<>"Demo"
          UM_Database()\UM_Filtered=#True
        EndIf      
        
      Case "Beta"
        If UM_Database()\UM_Type<>"Beta"
          UM_Database()\UM_Filtered=#True
        EndIf 
        
      Case "Magazine"
        If UM_Database()\UM_Type<>"Magazine"
          UM_Database()\UM_Filtered=#True
        EndIf 
        
    EndSelect
    
    If Filter(0)\Search<>""
      If Not FindString(LCase(UM_Database()\UM_Title),LCase(Filter(0)\Search),#PB_String_NoCase)
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
          
    If Filter(0)\Players_Text="No Players"
      If UM_Database()\UM_Players<>"0" And UM_Database()\UM_Players<>""
        UM_Database()\UM_Filtered=#True
      EndIf
    EndIf
    
    If Filter(0)\Filter_Text="No CRC32"
      If UM_Database()\UM_CRC32<>""
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
      Case "Data Disk"
        If UM_Database()\UM_Data_Disk<>#True
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
      Case "ECS"
        If UM_Database()\UM_ECS<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
      Case "OCS"
        If UM_Database()\UM_OCS<>#True
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
        
      Case "Image Width"        
        If UM_Database()\UM_Screen_Width=640 Or UM_Database()\UM_Title_Width=640
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "AGS Pure"        
        If UM_Database()\UM_Pure=#False
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "No Image"        
        If UM_Database()\UM_Image_Avail=#True
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "Restricted"        
        If UM_Database()\UM_Restricted<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "Favourite"
        If UM_Database()\UM_Favourite<>#True
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "No Chipset"
        If UM_Database()\UM_ECS=#True
          UM_Database()\UM_Filtered=#True
        EndIf
        If UM_Database()\UM_OCS=#True
          UM_Database()\UM_Filtered=#True
        EndIf
        If UM_Database()\UM_AGA=#True
          UM_Database()\UM_Filtered=#True
        EndIf
        If UM_Database()\UM_CD32=#True
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "Too Long (Name)"        
        If Len(UM_Database()\UM_Short+Tags_Short())<26
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "Too Long (Pub)" 
        If Len(UM_Database()\UM_Publisher)<26 
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "Too Long (Dev)" 
        If Len(UM_Database()\UM_Developer)<26
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
        
      Case "No Game Info"        
        If UM_Database()\UM_Info_Avail=#True
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
        
      Case "No HOL New"        
        If UM_Database()\UM_HOL_Entry_New<>""
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
        
      Case "Invalid Genre"
        If FindMapElement(Genre_Map(),UM_Database()\UM_Genre)
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "Missing Type"
        If UM_Database()\UM_Type<>""
          UM_Database()\UM_Filtered=#True
        EndIf
        
      Case "Dupe Short"  
        If UM_Database()\UM_Short+Tags_Short()<>path
          UM_Database()\UM_Filtered=#True
        Else
          PreviousElement(UM_Database())
          UM_Database()\UM_Filtered=#False
          NextElement(UM_Database())
        EndIf
        
    EndSelect
    
    path=UM_Database()\UM_Short+Tags_Short()
    path2=UM_Database()\UM_Type
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

Macro Round_Image(imagenum) ; For Make PD Disk
  
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
  
EndMacro

Macro Resize_Image(img_path, out_path)
  
  If LoadImage(#CONVERT_IMAGE,img_path)
    ResizeImage(#CONVERT_IMAGE,640,512,Scaler)
    SaveImage(#CONVERT_IMAGE,out_path,#PB_ImagePlugin_PNG)
    FreeImage(#CONVERT_IMAGE)
  EndIf
  
EndMacro

Macro Resize_Logo(img_path, out_path)
  
  If LoadImage(#CONVERT_IMAGE,img_path)
    ResizeImage(#CONVERT_IMAGE,640,200,Scaler)
    SaveImage(#CONVERT_IMAGE,out_path,#PB_ImagePlugin_PNG)
    FreeImage(#CONVERT_IMAGE)
  EndIf
  
EndMacro

Macro Resize_Cover(img_path, out_path)
  
  If LoadImage(#CONVERT_IMAGE,img_path)
    ResizeImage(#CONVERT_IMAGE,640,824,#PB_Image_Smooth)
    SaveImage(#CONVERT_IMAGE,out_path,#PB_ImagePlugin_PNG)
    FreeImage(#CONVERT_IMAGE)
  EndIf
  
EndMacro

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
  
  CreateImage(#LOGO_BLANK,320,100,32,#Black)
  StartDrawing(ImageOutput(#LOGO_BLANK))
  Box(0,0,320,100,#White)
  RoundBox(5,5,310,90,20,20,$DDDDDDDD)
  FrontColor(#White)
  BackColor($DDDDDDDD)
  tw=TextWidth("No Image")
  th=TextHeight("No Image")
  DrawText(160-(tw/2),50-(th/2),"No Image")
  StopDrawing()
  ResizeImage(#LOGO_BLANK,DpiX(320),DpiY(100))
  
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
      SBpp = -SBpp                  ; reverse X iteration direction
    Else                            ; configure to rotate left
      *FPix = *SBuf + (Iw-1) * SPitch ; point to first pixel in last row
      SPitch = -SPitch                ; reverse Y iteration direction
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
      SendMessage_(GadgetID(#MAIN_LIST), #LVM_SCROLL, 0, (hotitem-(visible/2)) * itemheight)            ; scroll to center hot item in listicon
      Window_Update()
      Break
    EndIf
  Next
  
EndProcedure

Macro Add_Output(text)
  output$+text
EndMacro

Procedure Draw_Game_Info(*nul)
  
  Protected output$, input$, myfile, extra$
  
  Pause_Gadget(Info_Gadget)
  
  SetGadgetText(Info_Gadget,"")
  
  output$=""
  
  If GetGadgetState(#MAIN_LIST)<>-1
    
    Add_Output("")
    Add_Output(LSet("Game #",11," ")+": "+Str(ListIndex(UM_Database()))+#CRLF$)
    Add_Output(LSet("List #",11," ")+": "+Str(GetGadgetState(#MAIN_LIST)+1)+#CRLF$)
    If UM_Database()\UM_Type<>"Demo"
      Add_Output(LSet("Publisher",11," ")+": "+UM_Database()\UM_Publisher+#CRLF$)
      Add_Output(LSet("Developer",11," ")+": "+UM_Database()\UM_Developer+#CRLF$)
    Else
      Add_Output(LSet("Group",11," ")+": "+UM_Database()\UM_Publisher+#CRLF$)
      If UM_Database()\UM_Party<>""
        Add_Output(LSet("Party",11," ")+": "+UM_Database()\UM_Party+#CRLF$)
      EndIf
    EndIf
    If UM_Database()\UM_Players<>"0"
      Add_Output(LSet("Players",11," ")+": "+UM_Database()\UM_Players+#CRLF$)
    EndIf
    Add_Output(LSet("Short Name",11," ")+": "+UM_Database()\UM_Short+Tags_Short()+#CRLF$)
    Add_Output(LSet("Slave",11," ")+": "+UM_Database()\UM_Slave+#CRLF$)
    Add_Output(LSet("Slave Date",11," ")+": "+UM_Database()\UM_Slave_Date+#CRLF$)
    If UM_Database()\UM_HOL_Entry<>"" : Add_Output(LSet("HOL",11," ")+": "+UM_Database()\UM_HOL_Entry+#CRLF$) : EndIf
    If UM_Database()\UM_Lemon_Entry<>"" : Add_Output(LSet("Lemon",11," ")+": "+UM_Database()\UM_Lemon_Entry+#CRLF$) : EndIf
    If UM_Database()\UM_Janeway<>"" : Add_Output(LSet("BitWorld",11," ")+": "+UM_Database()\UM_Janeway+#CRLF$) : EndIf
    If UM_Database()\UM_Pouet<>"" : Add_Output(LSet("Pouët",11," ")+": "+UM_Database()\UM_Pouet+#CRLF$) : EndIf
    If UM_Database()\UM_WHD_Entry<>"" : Add_Output(LSet("WHD",11," ")+": "+UM_Database()\UM_WHD_Entry+#CRLF$) : EndIf
    Add_Output(LSet("CRC32",11," ")+": "+UM_Database()\UM_CRC32+#CRLF$)
    If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game" : Add_Output(LSet("HOL (New)",11," ")+": "+UM_Database()\UM_HOL_Entry_New+#CRLF$) : EndIf
    If UM_Database()\UM_SPS<>"" : Add_Output(LSet("SPS",11," ")+": "+UM_Database()\UM_SPS+#CRLF$) : EndIf
    Add_Output(#CRLF$)
    
    ForEach Menu_List()
      Add_Output(LSet("Files",11," ")+": "+Menu_List()+#CRLF$)
    Next
    
    Protected NewList Text_File.s()
    
    If FileSize(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\game_info.txt")>0 And UM_Database()\UM_Type<>"Demo"  
      myfile=ReadFile(#PB_Any,Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\game_info.txt")
      If IsFile(myfile)
        Add_Output(#CRLF$)
        Add_Output("Description"+#CRLF$)
        Add_Output("-----------"+#CRLF$)
        While Not Eof(myfile)
          Add_Output(ReadString(myfile)+#CRLF$)
        Wend
        CloseFile(myfile)
      EndIf
    EndIf
    
    If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
      Add_Output(#CRLF$)
      Add_Output("Description"+#CRLF$)
      Add_Output("-----------"+#CRLF$)
      If UM_Database()\UM_Party<>"" : extra$=" at '"+UM_Database()\UM_Party+"'" : Else : extra$="" : EndIf
      Add_Output(UM_Database()\UM_Title+" is a "+LCase(UM_Database()\UM_Genre)+" released in "+UM_Database()\UM_Year+" by "+UM_Database()\UM_Developer+extra$+".")
    EndIf
    
    SetGadgetText(Info_Gadget,output$)
    
  EndIf
  
  Resume_Gadget(Info_Gadget)
  
EndProcedure

Procedure Draw_Info(number)
  
  Protected output$, Smooth, imgw, imgh, input$, id
  
  Mutex=CreateMutex()
  
  If IFF_Smooth : Smooth=#PB_Image_Smooth : Else : Smooth=#PB_Image_Raw : EndIf
  
  If number<>-1
    
    SelectElement(UM_Database(),number)
    
    If IsMenu(#POPUP_MENU) : FreeMenu(#POPUP_MENU) : EndIf
    CreatePopupImageMenu(#POPUP_MENU)
    MenuItem(#Menuitem_1 ,"Play"            ,ImageID(#PLAY_ICON))
    MenuItem(#Menuitem_27,"Edit Database"    ,ImageID(#OPTIONS_ICON))
    MenuItem(#Menuitem_2b,"Favourite"       ,ImageID(#FAVOURITE_ICON))
    MenuBar()
    MenuItem(#MenuItem_7 ,"Open Data Folder",ImageID(#FOLDER_ICON))
    MenuItem(#MenuItem_8 ,"Open WHD Folder" ,ImageID(#FOLDER_ICON))
    MenuItem(#MenuItem_8b,"Open Archive" ,ImageID(#FOLDER_ICON))
    MenuItem(#MenuItem_8a,"Open Screenshots",ImageID(#FOLDER_ICON))
    MenuBar()
    MenuItem(#MenuItem_15,"Re-Install Game" ,ImageID(#FOLDER_ICON))
    MenuItem(#MenuItem_2c,"Re-Download Game" ,ImageID(#FOLDER_ICON))
    
    If UM_Database()\UM_HOL_Entry<>"" Or UM_Database()\UM_Lemon_Entry<>"" Or UM_Database()\UM_WHD_Entry<>"" Or UM_Database()\UM_Janeway<>"" Or UM_Database()\UM_Pouet<>"" Or UM_Database()\UM_WHD_Entry<>""
      MenuBar()
    EndIf
    
    If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Type="Beta"
      If UM_Database()\UM_HOL_Entry<>""
        MenuItem(#MenuItem_9,"Hall Of Light",ImageID(#HOL_ICON))
      EndIf
      If UM_Database()\UM_HOL_Entry_New<>""
        MenuItem(#MenuItem_9e,"Hall Of Light (New)",ImageID(#HOL_NEW_ICON))
      EndIf
      If UM_Database()\UM_Lemon_Entry<>""
        MenuItem(#MenuItem_9a,"Lemon Amiga",ImageID(#LEMON_ICON))
      EndIf
      If UM_Database()\UM_WHD_Entry<>""
        MenuItem(#MenuItem_9b,"WHDload",ImageID(#WHD_ICON))
      EndIf      
      If UM_Database()\UM_HOL_Entry<>"" Or UM_Database()\UM_Lemon_Entry<>"" Or UM_Database()\UM_WHD_Entry<>"" : MenuBar() : EndIf
    EndIf 
    If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
      If UM_Database()\UM_Janeway<>""
        MenuItem(#MenuItem_9c,"BitWorld",ImageID(#JANEWAY_ICON))
      EndIf
      If UM_Database()\UM_Pouet<>""
        MenuItem(#MenuItem_9d,"Pouët",ImageID(#POUET_ICON))
      EndIf
      If UM_Database()\UM_WHD_Entry<>""
        MenuItem(#MenuItem_9b,"WHDload",ImageID(#WHD_ICON))
      EndIf      
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
    
    ;If ListSize(Menu_List())>0 : MenuBar() : EndIf
    
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
      If FindString(Menu_List(),"readme.txt",-1,#PB_String_NoCase) : MenuBar() : EndIf
      If id=0
        MenuItem(900+count,Menu_List())
      Else
        MenuItem(900+count,Menu_List(),ImageID(id))
      EndIf
      count+1
    Next
    
    Protected thr.i
    
    Dim mythread.thrds(4)
    
    mythread(0)\t_image=#TITLE_IMAGE
    mythread(0)\t_path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png"
    mythread(1)\t_image=#SCREEN_IMAGE
    mythread(1)\t_path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png"
    mythread(2)\t_image=#COVER_IMAGE
    mythread(2)\t_path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png"
    mythread(3)\t_image=#LOGO_IMAGE
    mythread(3)\t_path=Game_Data_Path+"Logos\"+UM_Database()\UM_Publisher+".png"
    
    For i=0 To 3
      thr=CreateThread(@Load_Image(),@mythread(i))
      Delay(10)
    Next
    
    WaitThread(thr)
    
    FreeArray(mythread())
    
  EndIf
  
  Draw_Image(#TITLE_IMAGE,Title_Image,#SCREEN_BLANK,320,256)
  Draw_Image(#SCREEN_IMAGE,Screen_Image,#SCREEN_BLANK,320,256)
  Draw_Image(#COVER_IMAGE,Cover_Image,#COVER_BLANK,320,412)
  Draw_Image(#LOGO_IMAGE,Logo_Image,#LOGO_BLANK,320,100)
  
  thr=CreateThread(@Draw_Game_Info(),#Null)
  
  If IsImage(#COVER_IMAGE) : FreeImage(#COVER_IMAGE) : EndIf
  If IsImage(#TITLE_IMAGE) : FreeImage(#TITLE_IMAGE) : EndIf
  If IsImage(#SCREEN_IMAGE) : FreeImage(#SCREEN_IMAGE) : EndIf 
  If IsImage(#LOGO_IMAGE) : FreeImage(#LOGO_IMAGE) : EndIf 
  
  Update_Status_Bar()
  
EndProcedure

Procedure Draw_List()
  
  Protected game.i, demo.i, beta_game.i, beta_demo.i, icon.i, extras.s, magazine.i, type.s, beta.i
   
  UseGadgetList(WindowID(#MAIN_WINDOW))
  
  Pause_Gadget(#MAIN_LIST)
  
  ClearList(List_Numbers())
  ClearGadgetItems(#MAIN_LIST)
  
  Filter_List()
  
  game=0 : demo=0 : beta_game=0 : beta_demo=0 : magazine=0 : beta=0
  
  ForEach UM_Database()
    If UM_Database()\UM_Filtered=#False
      AddElement(List_Numbers())
      List_Numbers()\L_Number=ListIndex(UM_Database())
      List_Numbers()\L_Name=UM_Database()\UM_Sort_Name
      List_Numbers()\L_Type=UM_Database()\UM_Sort_Type
      List_Numbers()\L_Year=UM_Database()\UM_Year
      List_Numbers()\L_Slave_Date=UM_Database()\UM_Sort_Date
    EndIf
    If UM_Database()\UM_Type="Game" : game+1 : EndIf
    If UM_Database()\UM_Beta_Type="Game" : beta_game+1 : EndIf
    If UM_Database()\UM_Type="Demo" : demo+1 : EndIf
    If UM_Database()\UM_Beta_Type="Demo" : beta_demo+1 : EndIf
    If UM_Database()\UM_Type="Beta" : beta+1 : EndIf
    If UM_Database()\UM_Type="Magazine" : magazine+1 : EndIf
  Next
  
  Select Sort_Column
      
    Case 0
      If Column_Sort(0)\Col1=#False
        SortStructuredList(List_Numbers(),#PB_Sort_Ascending|#PB_Sort_NoCase,OffsetOf(List_Data\L_Name), TypeOf(List_Data\L_Name))
      Else
        SortStructuredList(List_Numbers(),#PB_Sort_Descending|#PB_Sort_NoCase,OffsetOf(List_Data\L_Name), TypeOf(List_Data\L_Name))
      EndIf
    Case 1
      If Column_Sort(0)\Col2=#False
        SortStructuredList(List_Numbers(),#PB_Sort_Ascending|#PB_Sort_NoCase,OffsetOf(List_Data\L_Year), TypeOf(List_Data\L_Year))
      Else
        SortStructuredList(List_Numbers(),#PB_Sort_Descending|#PB_Sort_NoCase,OffsetOf(List_Data\L_Year), TypeOf(List_Data\L_Year))
      EndIf
    Case 2
      If Column_Sort(0)\Col3=#False
        SortStructuredList(List_Numbers(),#PB_Sort_Ascending|#PB_Sort_NoCase,OffsetOf(List_Data\L_Type), TypeOf(List_Data\L_Type))
      Else
        SortStructuredList(List_Numbers(),#PB_Sort_Descending|#PB_Sort_NoCase,OffsetOf(List_Data\L_Type), TypeOf(List_Data\L_Type))
      EndIf
    Case 3
      If Column_Sort(0)\Col4=#False
        SortStructuredList(List_Numbers(),#PB_Sort_Ascending|#PB_Sort_NoCase,OffsetOf(List_Data\L_Slave_Date), TypeOf(List_Data\L_Slave_Date))
      Else
        SortStructuredList(List_Numbers(),#PB_Sort_Descending|#PB_Sort_NoCase,OffsetOf(List_Data\L_Slave_Date), TypeOf(List_Data\L_Slave_Date))
      EndIf
            
  EndSelect
  
  ForEach List_Numbers()
    SelectElement(UM_Database(),List_Numbers()\L_Number)
    If Short_Names
      If Show_Tags : extras=Tags_Short() : Else : extras="" : EndIf
      AddGadgetItem(#MAIN_LIST,-1,UM_Database()\UM_Short+extras+Chr(10)+UM_Database()\UM_Year+Chr(10)+UM_Database()\UM_Sort_Type+Chr(10)+FormatDate("%dd/%mm/%yyyy",UM_Database()\UM_Sort_Date))
    Else
      If Show_Tags : extras=Tags() : Else : extras="" : EndIf
      AddGadgetItem(#MAIN_LIST,-1,UM_Database()\UM_Title+extras+Chr(10)+UM_Database()\UM_Year+Chr(10)+UM_Database()\UM_Sort_Type+Chr(10)+FormatDate("%dd/%mm/%yyyy",UM_Database()\UM_Sort_Date))
    EndIf  
  Next
  
  For count=0 To CountGadgetItems(#MAIN_LIST) Step 2
    SetGadgetItemColor(#MAIN_LIST,count,#PB_Gadget_BackColor,$eeeeee)
  Next
  
  SetGadgetState(#MAIN_LIST,0)
    
  Resume_Gadget(#MAIN_LIST)
  
  If GetWindowLongPtr_(GadgetID(#MAIN_LIST), #GWL_STYLE) & #WS_VSCROLL
    SetGadgetItemAttribute(#MAIN_LIST,0,#PB_ListIcon_ColumnWidth,GadgetWidth(#MAIN_LIST)-18)
  Else
    SetGadgetItemAttribute(#MAIN_LIST,0,#PB_ListIcon_ColumnWidth,GadgetWidth(#MAIN_LIST))
  EndIf
  
  SetActiveGadget(#MAIN_LIST)
  
  Select Filter(0)\Category_Text
    Case "All" : count=ListSize(UM_Database())
    Case "Game" : count=game+beta_game
    Case "Game/Beta" : count=game+beta_game
    Case "Demo" : count=demo+beta_demo
    Case "Demo/Beta" : count=demo+beta_demo
    Case "Beta" : count=beta
    Case "Magazine" : count=magazine
  EndSelect
  
  SetWindowTitle(#MAIN_WINDOW, W_Title+" (Build "+Build+")"+" (Showing "+Str(CountGadgetItems(#MAIN_LIST))+" of "+Str(count)+" Games)")
  
  Update_Status_Bar()
  
  If ListSize(List_Numbers())>0
    SelectElement(List_Numbers(),0)
  EndIf
  
EndProcedure

Procedure Create_Menus()
  
  CreateImageMenu(Main_Menu, WindowID(#MAIN_WINDOW))
  MenuTitle("File")
  MenuItem(#MenuItem_1,  "Run Game"+Chr(9)+"Enter",ImageID(#PLAY_ICON))
  MenuBar()
  MenuItem(#MenuItem_5a, "Filter"+Chr(9)+"F4",ImageID(#OPTIONS_ICON))
  MenuBar()
  MenuItem(#MenuItem_2b, "Favourite"+Chr(9)+"F8",ImageID(#FAVOURITE_ICON))  
  MenuBar()
  MenuItem(#MenuItem_15,  "Re-Install Game",ImageID(#FOLDER_ICON))
  MenuItem(#MenuItem_2c,  "Re-Download Game",ImageID(#FOLDER_ICON))
  MenuItem(#MenuItem_2a,  "WinUAE Setup",ImageID(#OPTIONS_ICON))
  MenuBar()
  MenuItem(#MenuItem_7,  "Open Data Folder",ImageID(#FOLDER_ICON))
  MenuItem(#MenuItem_8,  "Open WHD Folder",ImageID(#FOLDER_ICON))
  MenuItem(#MenuItem_8b, "Open Archive" ,ImageID(#FOLDER_ICON))
  MenuBar()
  MenuItem(#MenuItem_4,  "Save Database",ImageID(#SAVE_ICON))
  MenuBar()
  MenuItem(#MenuItem_31, "Settings",ImageID(#OPTIONS_ICON))
  MenuBar()
  MenuItem(#MenuItem_5,  "Quit",ImageID(#QUIT_ICON))
  MenuTitle("Create")
  MenuItem(#MenuItem_10,  "Make Image Folders",ImageID(#NEW_ICON))
  MenuItem(#MenuItem_10d, "Make Single Image",ImageID(#NEW_ICON))
  MenuBar()
  MenuItem(#MenuItem_6,  "Make IGame Data",ImageID(#NEW_ICON))
  MenuItem(#MenuItem_3,  "Save Gameslist (CSV)",ImageID(#SAVE_ICON))
  MenuItem(#MenuItem_14,  "Make IG-Tool Data",ImageID(#NEW_ICON))
  MenuBar()
  MenuItem(#MenuItem_12,  "Make PD Image Set",ImageID(#NEW_ICON))
  MenuItem(#MenuItem_13,  "Make PD Image",ImageID(#NEW_ICON))
  MenuBar()
  MenuItem(#MenuItem_10c, "Archive Folder",ImageID(#ARCHIVE_ICON))
  MenuItem(#MenuItem_10b, "Batch Archive Folders",ImageID(#ARCHIVE_ICON))
  MenuItem(#MenuItem_16,  "Quick Delete Folder",ImageID(#DELETE_ICON))
  MenuBar()
  MenuItem(#MenuItem_10a, "Make CLRMame Dats",ImageID(#NEW_ICON))
  MenuBar()
  MenuItem(#MenuItem_11,  "Backup Images",ImageID(#SAVE_ICON))
  MenuBar()
  MenuItem(#MenuItem_17,  "Create WHD Drive",ImageID(#CREATE_ICON))
  MenuBar()
  MenuItem(#MenuItem_19,  "Get All Install Sizes",ImageID(#UPDATE_ICON))
  MenuItem(#MenuItem_20,  "Get Install Size",ImageID(#UPDATE_ICON))
  MenuTitle("Database")
  MenuItem(#MenuItem_21,  "Update FTP",ImageID(#UPDATE_ICON))
  MenuItem(#MenuItem_21a, "Update FTP (Clean)",ImageID(#UPDATE_ICON))
  MenuItem(#MenuItem_22,  "Update Database",ImageID(#UPDATE_ICON))
  MenuItem(#MenuItem_22a, "Update HDF",ImageID(#UPDATE_ICON))
  MenuItem(#MenuItem_23,  "Update Full",ImageID(#UPDATE_ICON))
  MenuBar() 
  MenuItem(#MenuItem_28,  "Save Guide",ImageID(#SAVE_ICON))
  MenuBar() 
  MenuItem(#menuitem_51,  "Save DB Entry",ImageID(#SAVE_ICON))
  MenuItem(#menuitem_52,  "Load DB Entry",ImageID(#FOLDER_ICON))
  MenuBar()
  MenuItem(#MenuItem_26,  "Delete Entry",ImageID(#DELETE_ICON))
  MenuItem(#MenuItem_27,  "Edit Database",ImageID(#TEXT_IMAGE))
  MenuBar()
  MenuItem(#MenuItem_45,  "Reload Genres",ImageID(#UPDATE_ICON))
  MenuItem(#MenuItem_46,  "Refresh"+Chr(9)+"F5",ImageID(#UPDATE_ICON))
  MenuTitle("AGS")
  MenuItem(#MenuItem_18,  "Make AGS Folder",ImageID(#NEW_ICON))
  MenuItem(#MenuItem_18a, "Make AGS Single",ImageID(#NEW_ICON))
  MenuBar() 
  MenuItem(#MenuItem_18b, "Create DB Guides",ImageID(#CREATE_ICON))
  ;MenuItem(#MenuItem_18c, "Create Demo List",ImageID(#CREATE_ICON))
  MenuItem(#MenuItem_18d, "Export Database",ImageID(#SAVE_ICON)) 
  MenuBar()
  MenuItem(#MenuItem_18e, "Create Extra Texts",ImageID(#CREATE_ICON))
  MenuItem(#MenuItem_18f, "Compare folders",ImageID(#CREATE_ICON))
  MenuBar() 
  MenuItem(#MenuItem_47,  "Create USB Drive",ImageID(#CREATE_ICON))
  
  DisableMenuItem(Main_Menu,#MenuItem_25,1)
  DisableMenuItem(Main_Menu,#MenuItem_2,1)
    
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
    MenuBar()
    MenuItem(#MenuItem_99c, "Copy Text")
  EndIf
  
EndProcedure

Procedure Draw_Main_Panel(offset.i)

  ListIconGadget(#MAIN_LIST, 5, 5, 485, 650, "Name", 40, #PB_ListIcon_GridLines | #PB_ListIcon_FullRowSelect)
  AddGadgetColumn(#MAIN_LIST,1,"Year",80)
  AddGadgetColumn(#MAIN_LIST,2,"Type",80)
  AddGadgetColumn(#MAIN_LIST,3,"Slave Date",100)
  SetWindowLongPtr_(GadgetID(#MAIN_LIST),#GWL_EXSTYLE,0)
  
EndProcedure

Procedure Draw_Media_Panel(offset)
  
  Protected Null.l
  
  ContainerGadget(#EXTRA_PANEL,495,0,658,682)
  Title_Image = CanvasGadget(#PB_Any, 4, 10, 320, 256)
  Screen_Image = CanvasGadget(#PB_Any, 328, 10, 320, 256)
  Cover_Image = CanvasGadget(#PB_Any, 4, 270, 320, 412)
  Logo_Image = CanvasGadget(#PB_Any, 328, 270, 320, 105)
  Info_Gadget= EditorGadget(#PB_Any,328,380,320,302,#PB_Editor_ReadOnly|#PB_Editor_WordWrap)
  
  DestroyCaret_()
  
  SetGadgetFont(Info_Gadget,FontID(#INFO_FONT))
  
  EnableGadgetDrop(Title_Image,#PB_Drop_Files,#PB_Drag_Copy)
  EnableGadgetDrop(Screen_Image,#PB_Drop_Files,#PB_Drag_Copy)
  EnableGadgetDrop(Cover_Image,#PB_Drop_Files,#PB_Drag_Copy)
  EnableGadgetDrop(Logo_Image,#PB_Drop_Files,#PB_Drag_Copy)
  
  CloseGadgetList()
  
EndProcedure

Procedure Draw_Main_Window()
  
  OpenWindow(#MAIN_WINDOW, 0, 0, 1153, 730, W_Title+"("+Build+")" , #PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_MinimizeGadget|#PB_Window_Invisible)
  
  SetWindowCallback(@WinCallback())
  
  CreateStatusBar(#MAIN_STATUS,WindowID(#MAIN_WINDOW))
  AddStatusBarField(100)
  AddStatusBarField(245)
  AddStatusBarField(100)
  AddStatusBarField(100)
  AddStatusBarField(180)
  AddStatusBarField(270)
  AddStatusBarField(150)

  Create_Menus()
  Draw_Main_Panel(0)
  Draw_Media_Panel(0)
  
  Filter_Button=ButtonGadget(#PB_Any,10,660,70,22,"Filter (F4)") 
  Search_Gadget=StringGadget(#PB_Any,85,661,300,20,"",#PB_String_BorderLess)
  Reset_Button=ButtonGadget(#PB_Any,390,660,100,22,"Reset (F6)")
  
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
  
  If GetWindowState(#MAIN_WINDOW)=#PB_Window_Minimize : SetWindowState(#MAIN_WINDOW,#PB_Window_Normal) : EndIf  
  
EndProcedure

Procedure Run_Game(gamenumber.i)
  
  Protected startup_file.i, old_pos.i, config.s, old_dir.s 
  
  SelectElement(UM_Database(), gamenumber)  
  
  old_pos=GetGadgetState(#MAIN_LIST)
  
  CreateDirectory(WHD_TempDir)
  
  SetCurrentDirectory(WHD_TempDir)
  
  startup_file=CreateFile(#PB_Any,"whd-startup",#PB_Ascii)
  
  If startup_file
    If UM_Database()\UM_NTSC : WriteString(startup_file,"uae-configuration ntsc 1 gfx_height_windowed 400"+#LF$) : EndIf
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
    WriteString(startup_file,"echo "+#DOUBLEQUOTE$+" |[__I_I_I_I_I_I_I_I_I_I_I_I_I_L_I __I_]_  [_I_I_T_||  "+#DOUBLEQUOTE$+#LF$)
    WriteString(startup_file,"echo "+#DOUBLEQUOTE$+" |[___I_I_I_I_I_I_I_I_I_I_I_I____] [_I_I_] [_I_I_I ||  "+#DOUBLEQUOTE$+#LF$)
    WriteString(startup_file,"echo "+#DOUBLEQUOTE$+" | [__I__I_________________I__L_]          [___I_I_J|  "+#DOUBLEQUOTE$+#LF$)
    WriteString(startup_file,"echo "+#DOUBLEQUOTE$+" |                                                  |  "+#DOUBLEQUOTE$+#LF$)
    WriteString(startup_file,"echo "+#DOUBLEQUOTE$+" l__________________________________________________j  "+#DOUBLEQUOTE$+#LF$)
    WriteString(startup_file,"echo "+#DOUBLEQUOTE$+""+#DOUBLEQUOTE$+#LF$)
    WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"            ____ "+#DOUBLEQUOTE$+#LF$)
    WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"           / / / "+#DOUBLEQUOTE$+#LF$)
    WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"          / / /  AGS Database Manager "+Version+#DOUBLEQUOTE$+#LF$)
    WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"         / / /   "+#DOUBLEQUOTE$+#LF$)
    If Len(UM_Database()\UM_Title)<59
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"        / / /    "+UM_Database()\UM_Title+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"       / / /     "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"____  / / /      By "+UM_Database()\UM_Publisher+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"\ \ \/ / /       "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+" \ \ \/ /        © "+UM_Database()\UM_Year+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"  \_\_\/         "+#DOUBLEQUOTE$+#LF$)
    Else
      count=59
      While Mid(UM_Database()\UM_Title,count,1)<>Chr(32) And count>0 And Len(UM_Database()\UM_Title)>count : count-1 : Wend
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"        / / /    "+Left(UM_Database()\UM_Title,count)+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"       / / /     "+Right(UM_Database()\UM_Title,Len(UM_Database()\UM_Title)-count)+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"____  / / /      "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"\ \ \/ / /       By "+UM_Database()\UM_Publisher+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+" \ \ \/ /        "+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"  \_\_\/         © "+UM_Database()\UM_Year+#DOUBLEQUOTE$+#LF$)
    EndIf  
    WriteString(startup_file,"echo "+#DOUBLEQUOTE$+""+#DOUBLEQUOTE$+#LF$)
    WriteString(startup_file,"echo "+#DOUBLEQUOTE$+""+#DOUBLEQUOTE$+#LF$)
    WriteString(startup_file,"wait 2"+#LF$)
    WriteString(startup_file,"cd WHD-HDD:"+#LF$)
    WriteString(startup_file,"cd "+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+"/"+#LF$)
    WriteString(startup_file,"kgiconload "+UM_Database()\UM_Icon+#LF$)
    If Close_UAE  
      WriteString(startup_file,"echo "+#DOUBLEQUOTE$+"Waiting for disk activity to finish..."+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"wait 4"+#LF$)
      WriteString(startup_file,"uae-configuration SPC_QUIT 1")
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
  
  If UM_Database()\UM_Type="Demo" : config+" -cfgparam gfx_filter_autoscale=standard" : EndIf
  If UM_Database()\UM_Type="Magazine" : config+" -cfgparam gfx_filter_autoscale=standard" : EndIf
  
  OpenWindow(#RUN_WINDOW,WindowX(#MAIN_WINDOW)+(WindowWidth(#MAIN_WINDOW)/2)-180,WindowY(#MAIN_WINDOW)+(WindowHeight(#MAIN_WINDOW)/2)-30,360,60,"Starting WinUAE. Please Wait...")
  TextGadget(#PB_Any,10,15,340,50,"Loading: "+UM_Database()\UM_Title+Tags(),#PB_Text_Center)
  
  If Use_Bezels : Create_Bezel(Bezel_Type) : EndIf
  
  startup_prog=RunProgram(WinUAE_Path, "-f "+config+" -s filesystem2=rw,DH1:WHDTemp:"+WHD_TempDir+",0","",#PB_Program_Open)
  
  If startup_prog
    
    SetWindowState(#MAIN_WINDOW,#PB_Window_Minimize)       
    CreateThread(@Cleanup(),0)
    Delay(2000)
    HideWindow(#RUN_WINDOW,#True)
    
  Else
    
    CloseWindow(#RUN_WINDOW)
    MessageRequester("Error","WinUAE did not start correctly...",#PB_MessageRequester_Ok|#PB_MessageRequester_Error)
    
  EndIf
  
  SetCurrentDirectory(home_path)
  
EndProcedure

Procedure Run_System(gamenumber.i)
  
  Protected output$, startup_prog.i, old_pos.i
  
  SelectElement(Systems_Database(),gamenumber)
  
  output$=" -f "+#DOUBLEQUOTE$+IG_Path+Systems_Database()\Sys_File+#DOUBLEQUOTE$+" -cfgparam use_gui=no"
  
  startup_prog=RunProgram(WinUAE_Path,output$,"",#PB_Program_Open)
  
  SetCurrentDirectory(home_path)
  
EndProcedure

;- ############### File I/O Procedures

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
      UM_Database()\UM_ECS=Fix_List()\F_ECS
      UM_Database()\UM_OCS=Fix_List()\F_OCS
      UM_Database()\UM_Publisher=Fix_List()\F_Publisher
      UM_Database()\UM_Developer=Fix_List()\F_Developer
      UM_Database()\UM_Party=Fix_List()\F_Party
      UM_Database()\UM_Favourite=Fix_List()\F_Favourite
      UM_Database()\UM_Genre=Fix_List()\F_Genre
      UM_Database()\UM_Preview=Fix_List()\F_Preview
      UM_Database()\UM_Type=Fix_List()\F_Type
      UM_Database()\UM_Beta_Type=Fix_List()\F_Beta_Type
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
      UM_Database()\UM_HOL_Entry=Fix_List()\F_HOL
      UM_Database()\UM_HOL_Entry_New=Fix_List()\F_HOL_New
      UM_Database()\UM_Lemon_Entry=Fix_List()\F_Lemon
      UM_Database()\UM_WHD_Entry=Fix_List()\F_WHD
      UM_Database()\UM_Janeway=Fix_List()\F_Janeway
      UM_Database()\UM_Pouet=Fix_List()\F_Pouet
      UM_Database()\UM_Beta=Fix_List()\F_Beta
      UM_Database()\UM_InstallSize=Fix_List()\F_InstallSize
      UM_Database()\UM_Version=Fix_List()\F_Version
      UM_Database()\UM_Adult=Fix_List()\F_Adult
      UM_Database()\UM_Pure=Fix_List()\F_Pure
      UM_Database()\UM_Online=Fix_List()\F_Online
      UM_Database()\UM_Link=Fix_List()\F_Link
      UM_Database()\UM_CRC32=Fix_List()\F_CRC32
      UM_Database()\UM_SHA1=Fix_List()\F_SHA1
      UM_Database()\UM_MD5=Fix_List()\F_MD5
      UM_Database()\UM_FileSize=Fix_List()\F_FileSize
      UM_Database()\UM_SPS=Fix_List()\F_SPS
      UM_Database()\UM_Restricted=Fix_List()\F_Restricted
      UM_Database()\UM_Data_Disk=Fix_List()\F_Data_Disk
      UM_Database()\UM_7Mhz=Fix_List()\F_7Mhz
      UM_Database()\UM_14Mhz=Fix_List()\F_14Mhz
      UM_Database()\UM_UAE_14Mhz=Fix_List()\F_UAE_14Mhz
      UM_Database()\UM_25Mhz=Fix_List()\F_25Mhz
      UM_Database()\UM_Max=Fix_List()\F_Max
      UM_Database()\UM_FC=Fix_List()\F_FC
      UM_Database()\UM_IB=Fix_List()\F_IB
      UM_Database()\UM_BW=Fix_List()\F_BW
      UM_Database()\UM_NT=Fix_List()\F_NT
      UM_Database()\UM_Offset=Fix_List()\F_Offset
      UM_Database()\UM_VRES=Fix_List()\F_VRES
      UM_Database()\UM_Cycle=Fix_List()\F_Cycle
      UM_Database()\UM_NoCycle=Fix_List()\F_NoCycle
    Next
  EndIf
  
  ClearList(Fix_List())
  
  ForEach UM_Database()
    UM_Database()\UM_Sort_Name=UM_Database()\UM_Title+Tags()
    If UM_Database()\UM_Type="Game" : UM_Database()\UM_Sort_Type="Game" : EndIf
    If UM_Database()\UM_Type="Demo" : UM_Database()\UM_Sort_Type="Demo" : EndIf
    If UM_Database()\UM_Type="Magazine" : UM_Database()\UM_Sort_Type="Magazine" : EndIf
    If UM_Database()\UM_Type="Beta" And UM_Database()\UM_Beta_Type="Game" : UM_Database()\UM_Sort_Type="Beta\Game" : EndIf
    If UM_Database()\UM_Type="Beta" And UM_Database()\UM_Beta_Type="Demo" : UM_Database()\UM_Sort_Type="Beta\Demo" : EndIf
    If UM_Database()\UM_Type="Beta" And UM_Database()\UM_Beta_Type="Magazine" : UM_Database()\UM_Sort_Type="Beta\Mag" : EndIf
  Next
  
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
    Fix_List()\F_OCS=UM_Database()\UM_OCS
    Fix_List()\F_ECS=UM_Database()\UM_ECS
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
    Fix_List()\F_Beta_Type=UM_Database()\UM_Beta_Type
    Fix_List()\F_Year=UM_Database()\UM_Year
    Fix_List()\F_Players=UM_Database()\UM_Players
    Fix_List()\F_Config=UM_Database()\UM_Config
    Fix_List()\F_HOL=UM_Database()\UM_HOL_Entry
    Fix_List()\F_HOL_New=UM_Database()\UM_HOL_Entry_New
    Fix_List()\F_Lemon=UM_Database()\UM_Lemon_Entry
    Fix_List()\F_WHD=UM_Database()\UM_WHD_Entry
    Fix_List()\F_Janeway=UM_Database()\UM_Janeway
    Fix_List()\F_Pouet=UM_Database()\UM_Pouet
    Fix_List()\F_Beta=UM_Database()\UM_Beta
    Fix_List()\F_Default_Icon=UM_Database()\UM_Icon
    Fix_List()\F_InstallSize=UM_Database()\UM_InstallSize
    Fix_List()\F_Version=UM_Database()\UM_Version
    Fix_List()\F_Adult=UM_Database()\UM_Adult
    Fix_List()\F_Pure=UM_Database()\UM_Pure
    Fix_List()\F_Link=UM_Database()\UM_Link
    Fix_List()\F_Online=UM_Database()\UM_Online
    Fix_List()\F_CRC32=UM_Database()\UM_CRC32
    Fix_List()\F_SHA1=UM_Database()\UM_SHA1
    Fix_List()\F_MD5=UM_Database()\UM_MD5
    Fix_List()\F_FileSize=UM_Database()\UM_FileSize
    Fix_List()\F_SPS=UM_Database()\UM_SPS
    Fix_List()\F_Restricted=UM_Database()\UM_Restricted
    Fix_List()\F_Data_Disk=UM_Database()\UM_Data_Disk
    Fix_List()\F_7Mhz=UM_Database()\UM_7Mhz
    Fix_List()\F_14Mhz=UM_Database()\UM_14Mhz
    Fix_List()\F_UAE_14Mhz=UM_Database()\UM_UAE_14Mhz
    Fix_List()\F_25Mhz=UM_Database()\UM_25Mhz
    Fix_List()\F_Max=UM_Database()\UM_Max
    Fix_List()\F_FC=UM_Database()\UM_FC
    Fix_List()\F_IB=UM_Database()\UM_IB
    Fix_List()\F_BW=UM_Database()\UM_BW
    Fix_List()\F_NT=UM_Database()\UM_NT
    Fix_List()\F_Offset=UM_Database()\UM_Offset
    Fix_List()\F_VRES=UM_Database()\UM_VRES
    Fix_List()\F_Cycle=UM_Database()\UM_Cycle
    Fix_List()\F_NoCycle=UM_Database()\UM_NoCycle
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
  
  Draw_List()
    
EndProcedure

Procedure.s HDD_Path(A500_Mini.b)
  
  Protected output$
  
  If A500_Mini=#True
    If UM_Database()\UM_Type="Game"
      Select UM_Database()\UM_Subfolder
        Case "0","A","B","C","D","E","F"
          output$="WHD1:"
        Case "G","H","I","J","K","L","M","N","O","P","Q","R","T","U","V","W","X","Y","Z"
          output$="WHD2:"
        Case "S"
          output$="WHD3:"
      EndSelect
    Else
      output$="WHD1:"
    EndIf   
  Else
    If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
      output$="WHD_Games:"
    EndIf
    If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Beta_Type="Demo" Or UM_Database()\UM_Type="Magazine"
      output$="WHD_Demos:"
    EndIf
  EndIf
  
  ProcedureReturn output$
  
EndProcedure

Procedure Save_GL_CSV(path.s,type.i,A500.b,restricted.b)
  
  ; Type 0:Default 1:NoAdult 2:GamesOnly 3:GamesOnlyNoAdult 4:Demos 5:DemosNoAdult
  
  Protected NewMap GL_MAP.s()
  Protected NewMap GL_Filter.i()
  
  Protected HDD_Path.s
  
  If path<>""
    
    If GetExtensionPart(path)<>"csv"  
      path+".csv"
    EndIf
    
    Protected igfile3, output$
    
    ForEach UM_Database()
      
      If restricted
        If UM_Database()\UM_Restricted
          Continue
        EndIf
      EndIf
      
      If UM_Database()\UM_Genre="Misc / Editor"
        Continue
      EndIf
      
      If UM_Database()\UM_Genre="Misc / Intro"
        Continue
      EndIf
      
      If UM_Database()\UM_Genre="Misc / Utility Disk"
        Continue
      EndIf
      
      If UM_Database()\UM_Data_Disk
        Continue
      EndIf
      
      If UM_Database()\UM_Intro
        Continue
      EndIf
      
      GL_Filter(UM_Database()\UM_LHAFile+UM_Database()\UM_Slave)=ListIndex(UM_Database())
      
    Next
    
    ForEach GL_Filter()
      SelectElement(UM_Database(),GL_Filter())
      If type=1
        If UM_Database()\UM_Adult
          Continue
        EndIf
      EndIf
      If type=2
        If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine"
          Continue
        EndIf
      EndIf
      If type=3
        If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine"
          Continue
        EndIf
        If UM_Database()\UM_Adult
          Continue
        EndIf
      EndIf
      If type=4
        If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Type="Beta"
          Continue
        EndIf
      EndIf
      If type=5
        If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Type="Beta"
          Continue
        EndIf
        If UM_Database()\UM_Adult
          Continue
        EndIf
      EndIf  
      
      output$="0;"
      output$+#DOUBLEQUOTE$+UM_Database()\UM_Title+Tags()+#DOUBLEQUOTE$+";"   
      output$+#DOUBLEQUOTE$+UM_Database()\UM_Genre+#DOUBLEQUOTE$+";"
      output$+#DOUBLEQUOTE$+HDD_Path(A500)+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+"/"+UM_Database()\UM_Slave+#DOUBLEQUOTE$+";"
      output$+"0;0;0;0;0;"+#DOUBLEQUOTE$+#DOUBLEQUOTE$+";"
      output$+UM_Database()\UM_Year+";"+UM_Database()\UM_Players+";"
      If UM_Database()\UM_AGA : output$+#DOUBLEQUOTE$+"AGA"+#DOUBLEQUOTE$+";" : EndIf
      If UM_Database()\UM_OCS : output$+#DOUBLEQUOTE$+"OCS"+#DOUBLEQUOTE$+";" : EndIf
      If UM_Database()\UM_ECS : output$+#DOUBLEQUOTE$+"ECS,OCS"+#DOUBLEQUOTE$+";" : EndIf
      GL_MAP(output$)=output$
    Next
    
    Protected NewList GL_Sort.s()
    
    ForEach GL_MAP()
      AddElement(GL_Sort())
      GL_Sort()=GL_MAP()
    Next
    
    SortList(GL_Sort(),#PB_Sort_Ascending)
    
    If CreateFile(igfile3, path,#PB_Ascii)
      ForEach GL_Sort()
        WriteString(igfile3,GL_Sort()+#LF$)
      Next
      CloseFile(igfile3)
    EndIf
    
  EndIf
  
  FreeMap(GL_MAP())
  
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
              Case "name"
                AddElement(Dat_Archives())
                Dat_Archives()\Arc_Type=path
                Dat_Archives()\Arc_Beta_Type=path4
                Dat_Archives()\Arc_Folder=attribval
            EndSelect
            
          Case "rom"
            Select attrib 
              Case "name"
                AddElement(Dat_Archives()\Arc_Info())
                If ListSize(Dat_Archives()\Arc_Info())=0 : AddElement(Dat_Archives()\Arc_Info()) : EndIf
                Dat_Archives()\Arc_Info()\Arc_Name=attribval
                Dat_Archives()\Arc_Info()\Arc_HTTP_Folder=path3
              Case "crc" : Dat_Archives()\Arc_Info()\Arc_CRC=attribval
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
  Center_Console()
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

;- ############### Update Procedures

Procedure Restore_DB_Entry()
  
  Protected lJSON
  
  Protected NewList Backup_List.UM_Data()
  
  path=OpenFileRequester("Load JSON","database_entry.json","*.json",-1)
  
  lJSON=LoadJSON(#PB_Any,path)
  
  If lJSON
    ExtractJSONList(JSONValue(lJSON),Backup_List())
    FreeJSON(lJSON)
  EndIf 
  
  UM_Database()\UM_AGA=Backup_List()\UM_AGA
  UM_Database()\UM_Arcadia=Backup_List()\UM_Arcadia
  UM_Database()\UM_Available=Backup_List()\UM_Available
  UM_Database()\UM_Beta=Backup_List()\UM_Beta
  UM_Database()\UM_CD32=Backup_List()\UM_CD32
  UM_Database()\UM_CDROM=Backup_List()\UM_CDROM
  UM_Database()\UM_CDTV=Backup_List()\UM_CDTV
  UM_Database()\UM_Config=Backup_List()\UM_Config
  UM_Database()\UM_Cover_Avail=Backup_List()\UM_Cover_Avail
  UM_Database()\UM_Coverdisk=Backup_List()\UM_Coverdisk
  UM_Database()\UM_Demo=Backup_List()\UM_Demo
  UM_Database()\UM_Developer=Backup_List()\UM_Developer
  UM_Database()\UM_Disks=Backup_List()\UM_Disks
  UM_Database()\UM_ECS=Backup_List()\UM_ECS
  UM_Database()\UM_OCS=Backup_List()\UM_OCS
  UM_Database()\UM_Favourite=Backup_List()\UM_Favourite
  UM_Database()\UM_Files=Backup_List()\UM_Files
  UM_Database()\UM_Filtered=Backup_List()\UM_Filtered
  UM_Database()\UM_Folder=Backup_List()\UM_Folder
  UM_Database()\UM_Genre=Backup_List()\UM_Genre
  UM_Database()\UM_HOL_Entry=Backup_List()\UM_HOL_Entry
  UM_Database()\UM_Icon=Backup_List()\UM_Icon
  UM_Database()\UM_Image=Backup_List()\UM_Image
  UM_Database()\UM_Image_Avail=Backup_List()\UM_Image_Avail
  UM_Database()\UM_InstallSize=Backup_List()\UM_InstallSize
  UM_Database()\UM_Intro=Backup_List()\UM_Intro
  UM_Database()\UM_Janeway=Backup_List()\UM_Janeway
  UM_Database()\UM_Language=Backup_List()\UM_Language
  UM_Database()\UM_Lemon_Entry=Backup_List()\UM_Lemon_Entry
  UM_Database()\UM_LHAFile=Backup_List()\UM_LHAFile
  UM_Database()\UM_Memory=Backup_List()\UM_Memory
  UM_Database()\UM_MT32=Backup_List()\UM_MT32
  UM_Database()\UM_NoIntro=Backup_List()\UM_NoIntro
  UM_Database()\UM_NoSound=Backup_List()\UM_NoSound
  UM_Database()\UM_NTSC=Backup_List()\UM_NTSC
  UM_Database()\UM_Party=Backup_List()\UM_Party
  UM_Database()\UM_PD=Backup_List()\UM_PD
  UM_Database()\UM_Players=Backup_List()\UM_Players
  UM_Database()\UM_Pouet=Backup_List()\UM_Pouet
  UM_Database()\UM_Preview=Backup_List()\UM_Preview
  UM_Database()\UM_Publisher=Backup_List()\UM_Publisher
  UM_Database()\UM_Short=Backup_List()\UM_Short
  UM_Database()\UM_Slave=Backup_List()\UM_Slave
  UM_Database()\UM_Sort_Name=Backup_List()\UM_Sort_Name
  UM_Database()\UM_Sort_Type=Backup_List()\UM_Sort_Type
  UM_Database()\UM_Subfolder=Backup_List()\UM_Subfolder
  UM_Database()\UM_Title=Backup_List()\UM_Title
  UM_Database()\UM_Title_Avail=Backup_List()\UM_Title_Avail
  UM_Database()\UM_Type=Backup_List()\UM_Type
  UM_Database()\UM_Version=Backup_List()\UM_Version
  UM_Database()\UM_WHD_Entry=Backup_List()\UM_WHD_Entry
  UM_Database()\UM_Year=Backup_List()\UM_Year
  
  FreeList(Backup_List())
  
EndProcedure 

Procedure Save_DB_Entry(entry_path.s)
  
  Protected lJSON
  
  Protected NewList Backup_List.UM_Data()
  
  AddElement(Backup_List())
  
  Backup_List()\UM_AGA=UM_Database()\UM_AGA
  Backup_List()\UM_Arcadia=UM_Database()\UM_Arcadia
  Backup_List()\UM_Available=UM_Database()\UM_Available
  Backup_List()\UM_Beta=UM_Database()\UM_Beta
  Backup_List()\UM_CD32=UM_Database()\UM_CD32
  Backup_List()\UM_CDROM=UM_Database()\UM_CDROM
  Backup_List()\UM_CDTV=UM_Database()\UM_CDTV
  Backup_List()\UM_Config=UM_Database()\UM_Config
  Backup_List()\UM_Cover_Avail=UM_Database()\UM_Cover_Avail
  Backup_List()\UM_Coverdisk=UM_Database()\UM_Coverdisk
  Backup_List()\UM_Demo=UM_Database()\UM_Demo
  Backup_List()\UM_Developer=UM_Database()\UM_Developer
  Backup_List()\UM_Disks=UM_Database()\UM_Disks
  Backup_List()\UM_ECS=UM_Database()\UM_ECS
  Backup_List()\UM_OCS=UM_Database()\UM_OCS
  Backup_List()\UM_Favourite=UM_Database()\UM_Favourite
  Backup_List()\UM_Files=UM_Database()\UM_Files
  Backup_List()\UM_Filtered=UM_Database()\UM_Filtered
  Backup_List()\UM_Folder=UM_Database()\UM_Folder
  Backup_List()\UM_Genre=UM_Database()\UM_Genre
  Backup_List()\UM_HOL_Entry=UM_Database()\UM_HOL_Entry
  Backup_List()\UM_Icon=UM_Database()\UM_Icon
  Backup_List()\UM_Image=UM_Database()\UM_Image
  Backup_List()\UM_Image_Avail=UM_Database()\UM_Image_Avail
  Backup_List()\UM_InstallSize=UM_Database()\UM_InstallSize
  Backup_List()\UM_Intro=UM_Database()\UM_Intro
  Backup_List()\UM_Janeway=UM_Database()\UM_Janeway
  Backup_List()\UM_Language=UM_Database()\UM_Language
  Backup_List()\UM_Lemon_Entry=UM_Database()\UM_Lemon_Entry
  Backup_List()\UM_LHAFile=UM_Database()\UM_LHAFile
  Backup_List()\UM_Memory=UM_Database()\UM_Memory
  Backup_List()\UM_MT32=UM_Database()\UM_MT32
  Backup_List()\UM_NoIntro=UM_Database()\UM_NoIntro
  Backup_List()\UM_NoSound=UM_Database()\UM_NoSound
  Backup_List()\UM_NTSC=UM_Database()\UM_NTSC
  Backup_List()\UM_Party=UM_Database()\UM_Party
  Backup_List()\UM_PD=UM_Database()\UM_PD
  Backup_List()\UM_Players=UM_Database()\UM_Players
  Backup_List()\UM_Pouet=UM_Database()\UM_Pouet
  Backup_List()\UM_Preview=UM_Database()\UM_Preview
  Backup_List()\UM_Publisher=UM_Database()\UM_Publisher
  Backup_List()\UM_Short=UM_Database()\UM_Short
  Backup_List()\UM_Slave=UM_Database()\UM_Slave
  Backup_List()\UM_Sort_Name=UM_Database()\UM_Sort_Name
  Backup_List()\UM_Sort_Type=UM_Database()\UM_Sort_Type
  Backup_List()\UM_Subfolder=UM_Database()\UM_Subfolder
  Backup_List()\UM_Title=UM_Database()\UM_Title
  Backup_List()\UM_Title_Avail=UM_Database()\UM_Title_Avail
  Backup_List()\UM_Type=UM_Database()\UM_Type
  Backup_List()\UM_Version=UM_Database()\UM_Version
  Backup_List()\UM_WHD_Entry=UM_Database()\UM_WHD_Entry
  Backup_List()\UM_Year=UM_Database()\UM_Year
  
  If JSON_Backup
    lJSON = CreateJSON(#PB_Any)
    InsertJSONList(JSONValue(lJSON), Backup_List())
    SaveJSON(lJSON,entry_path,#PB_JSON_PrettyPrint)
    FreeJSON(lJSON)
  EndIf
  
  FreeList(Backup_List())
  
EndProcedure

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
  
  Protected response.s, output$, Icon_file.i, count.i, cut.i, lower$
  
  response=""
  Icon_file=ReadFile(#PB_Any,file)
  If Icon_file
    While Not Eof(Icon_file)
      output$=ReadString(Icon_file,#PB_Ascii)
      lower$=LCase(output$)
      If FindString(lower$,"slave=",#PB_String_NoCase)
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
  
  Protected result.i, length.i, UM_Program.i, ReadO$, output$, lower$
  
  Protected NewList Text_Files.s()
  
  If FileSize(WHD_TempDir)<>-2 : CreateDirectory(WHD_TempDir) : EndIf
  
  If GetExtensionPart(GetFilePart(archive_path))="lha"
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
  EndIf
  
  If GetExtensionPart(GetFilePart(archive_path))="lzx"
    UM_Program=RunProgram(Lzx_Path,"-v "+#DOUBLEQUOTE$+archive_path+#DOUBLEQUOTE$,GetCurrentDirectory(),#PB_Program_Open|#PB_Program_Read)
    While ProgramRunning(UM_Program) 
      If AvailableProgramOutput(UM_Program)   
        ReadO$=ReadProgramString(UM_Program)
        If FindString(ReadO$,#DOUBLEQUOTE$)
          count=FindString(ReadO$,#DOUBLEQUOTE$)
          ReadO$=Mid(ReadO$,count,Len(ReadO$))
          ReadO$=RemoveString(ReadO$,#DOUBLEQUOTE$)
          If CountString(ReadO$,"/")=1  
            If GetExtensionPart(ReadO$)=""
              AddElement(Text_Files())
              Text_Files()=ReadO$
            EndIf
          EndIf
        EndIf
      EndIf
    Wend
    CloseProgram(UM_Program)
  EndIf
  
  output$=""
  
  ForEach Text_Files()
    lower$=LCase(Text_Files())
    If FindString(lower$,"readme")
      output$+Text_Files()
    EndIf
  Next
  
  If GetExtensionPart(GetFilePart(archive_path))="lha"
    UM_Program=RunProgram(LHA_Path,"e -aoa "+#DOUBLEQUOTE$+archive_path+#DOUBLEQUOTE$+" "+output$,WHD_TempDir,#PB_Program_Wait)
  EndIf
  
  If GetExtensionPart(GetFilePart(archive_path))="lzx"
    UM_Program=RunProgram(LZX_Path,"-x "+#DOUBLEQUOTE$+archive_path+#DOUBLEQUOTE$+" -p "+output$,WHD_TempDir,#PB_Program_Wait)
  EndIf
  
  CreateDirectory("Game_Data\"+UM_Database()\UM_Type)
  CreateDirectory("Game_Data\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\")
  CreateDirectory("Game_Data\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder)
  
  path="Game_Data\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"
  
  output$=ReplaceString(output$,"/","\")
  
  count=CountString(output$,"\")
  
  If count<>0
    output$=StringField(output$,count+1,"\")
    CopyFile(WHD_TempDir+"\"+output$,path+output$+".txt")
  EndIf
  
  If count=0
    CopyFile(WHD_TempDir+"\"+output$,path+output$+".txt")
  EndIf
  
  DeleteDirectory(WHD_TempDir,"")
  
  FreeList(Text_Files())  
  
EndProcedure

Procedure.b Scan_HTTP()
  
  Protected dat_archive.i, xml_file.i    
  Protected FileName$, proc_return.b
  
  Protected NewList FTP_Dir_Files.s()  
  
  proc_return=#True
  
  ClearList(Dat_List())
  
  Protected ConsoleTitle$, system_menu.l
  
  ConsoleTitle$="HTTP Download"
  
  OpenConsole(ConsoleTitle$)
  Center_Console()
  
  Protected response, info$, input$, i, path$
  
  response=HTTPRequest(#PB_HTTP_Get,HTTP_Server)
  info$=HTTPInfo(response,#PB_HTTP_Response)
  
  count=CountString(info$,#LF$)
  
  For i=1 To count+1
    input$=StringField(info$,i,#LF$)
    If FindString(input$,"zip",#PB_String_NoCase)
      AddElement(FTP_Dir_Files())
      path$=Trim(input$)
      path$=StringField(path$,6,#DOUBLEQUOTE$)
      path$=ReplaceString(path$,"amp;","")
      FTP_Dir_Files()=path$
    EndIf
  Next
  
  update_db=#False
  
  PrintNCol("Checking for update...",11,0)
  PrintN("")
  PrintNCol("Reading "+HTTP_Server,2,0)
  Count=0
  
  PrintN("")
  
  If ListSize(FTP_Dir_Files())>0
    SetCurrentDirectory(Dats_Path)
    ForEach FTP_Dir_Files()
      If FindString(FTP_Dir_Files(),"WHDLoad") 
        FileName$=FTP_Dir_Files()   
        FileName$=ReplaceString(FileName$,"%20"," ")
        FileName$=ReplaceString(filename$,"amp;","")
        AddElement(Dat_List())
        Dat_List()=Dats_Path+FileName$
        If FileSize(Dats_Path+FileName$)=-1  
          PrintN("Downloading : "+FileName$)
          If ReceiveHTTPFile(HTTP_Server+"/"+FTP_Dir_Files(),Dats_Path+FileName$)
            PrintN("Success")
            update_db=#True
          Else
            PrintN("Download Error!")
            proc_return=#False
          EndIf
        Else
          PrintN(FileName$+" up to date!")
        EndIf
      EndIf
    Next
  Else
    PrintN("")
    PrintNCol("Error - Cannot find HTTP folder!",4,0)
    proc_return=#False
  EndIf   
  
  ProcedureReturn proc_return
  
EndProcedure

Procedure Download_HTTP()
  
  ; 1. Download dat files
  ; 2. Process XML into list b       
  ; 3. Compare lists to PC
  ; 4. Remove/Backup Un-Needed archives
  ; 5. Download new archives, scan and update DB (Flag As unprocessed)
  ; 6. Scan PC WHD archives and update database
  ; 7. Scan Miggy Update WHD Drive
  ; 8. Clean up the PC Drive.
  
  Protected NewList XML_List.s()
  Protected NewList Delete_List.s()
  Protected NewList Down_List.Down_Data()
  Protected NewMap  Arc_Map.s()
  Protected NewList Comp_List.s()
  
  Protected old_pos.i, prog_path.s
  Protected dat_archive.i, xml_file.i    
  Protected cd_file.i, output.s, path2.s
  Protected UM_Program.i, time.i, name$
  Protected filename$
  
  ClearList(Dat_List())
  
  ;{ 1. Download dat files #####################################################################################################################################################################  
  
  If FileSize(Dats_Path)<>-2 : CreateDirectory(Dats_Path) : EndIf  
  
  OpenConsole("FTP Download...")
  Center_Console()
  
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
  
  ; Check and download Dat files from the Turran FTP
  
  If Not Scan_HTTP()
    Goto Clean_Up
  EndIf
  
  SetCurrentDirectory(Dats_Path)  
  
  ; Extract any zipped Dat files and add any XML files into XML_List.
  
  ForEach Dat_List()
    If FileSize(GetFilePart(Dat_List()))=-1 
      MessageRequester("Error","Download Error",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
      Goto Clean_Up   
    EndIf
    dat_archive=OpenPack(#PB_Any,GetFilePart(Dat_List()),#PB_PackerPlugin_Zip)
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
  
  ; ##### Clean up dat folder #####
  
  ; Scan all the files in the dats folder
  
  List_Files_Recursive(Dats_Path,New_List(),"*.zip") 
  
  ; Load the datfiles into a map
  
  ForEach Dat_List() 
    File_Map(Dat_List())=""
  Next
  
  ; Compare the file list to the dat folder map and delete anythind not needed
  
  ForEach New_List() 
    If Not FindMapElement(File_Map(),New_List()) : DeleteFile(New_List(),#PB_FileSystem_Force) : EndIf
  Next
  
  ; Tidy up lists & maps
  
  FreeMap(File_Map())
  FreeList(New_List())
  
  ;}
  ;{ 2. Process XML into list ##################################################################################################################################################################
  
  ; Process the XML dat files and load the data into the Dat_Archives list
  
  ForEach XML_List()
    
    path3=ReplaceString(XML_List()," ","_") 
    path3=StringField(path3,1,"(")
    path3=RemoveString(path3,"_",#PB_String_NoCase,Len(path3))
    
    If FindString(XML_List(), "Demos") And Not FindString(XML_List(), "Beta") : path="Demo" : EndIf
    If FindString(XML_List(), "Games") And Not FindString(XML_List(), "Beta") : path="Game" : EndIf 
    If FindString(XML_List(), "Beta") And FindString(XML_List(), "Game") :  path="Beta" : path4="Game" : EndIf
    If FindString(XML_List(), "Beta") And FindString(XML_List(), "Demo") :  path="Beta" : path4="Demo" : EndIf
    If FindString(XML_List(), "Magazines") : path="Magazine" : EndIf
    
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
  
  ; Clean up lists
  
  FreeList(XML_List())  
  
  SetCurrentDirectory(Home_Path)
  
  ; Update_db is set in the filltree procedure and is set if anything is different.
  
  If update_db=#False 
    PrintS()  
    PrintNCol("Database files up to date...",9,0)
    Delay(1500)
  EndIf
  
  Protected NewList Arc_List.Arc_Data() ; Archive data list
  Protected NewMap Comp_Map.s()         ; Comparison Map
  
  ; Add new data to Archive_Data list & Comp_Map
  
  ForEach Dat_Archives()
    ForEach Dat_Archives()\Arc_Info()
      AddElement(Arc_List())
      Arc_List()\Arc_Name=Dat_Archives()\Arc_Type+"\"+Dat_Archives()\Arc_Folder+"\"+Dat_Archives()\Arc_Info()\Arc_Name
      Arc_List()\Arc_CRC=Dat_Archives()\Arc_Info()\Arc_CRC
      Arc_List()\Arc_Beta_Type=Dat_Archives()\Arc_Beta_Type
      Arc_List()\Arc_HTTP_Folder=Dat_Archives()\Arc_Info()\Arc_HTTP_Folder
      Comp_Map(Dat_Archives()\Arc_Type+"\"+Dat_Archives()\Arc_Folder+"\"+Dat_Archives()\Arc_Info()\Arc_Name)=Dat_Archives()\Arc_Info()\Arc_CRC
    Next
  Next
  
  ;}
  ;{ 3. Compare lists to PC ####################################################################################################################################################################
  
  ; Add database data to Arc_Map & Comp_List
  
  ForEach UM_Database()
    Arc_Map(UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile)=UM_Database()\UM_CRC32
    AddElement(Comp_List())
    Comp_List()=UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile
  Next
  
  ; Check whether to update existing file CRC information.
  
  If MessageRequester("Update","Update DB CRC32 info?",#PB_MessageRequester_Info|#PB_MessageRequester_YesNo)=#PB_MessageRequester_Yes
    PrintS()
    PrintNCol("Updating database CRC32 information...",9,0)
    ForEach UM_Database() 
      path=WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile
      If FileSize(path)=-1
        UM_Database()\UM_CRC32=""
        UM_Database()\UM_Available=#False
        UM_Database()\UM_FileSize=0
      EndIf
      If FileSize(path)>-1
        path2=FileFingerprint(path,#PB_Cipher_CRC32)
        If path2<>UM_Database()\UM_CRC32
          PrintN("Updating: "+WHD_Folder+path3+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile+" New CRC : "+path2+" Old CRC : "+UM_Database()\UM_CRC32)
          UM_Database()\UM_CRC32=path2
        EndIf
      EndIf
    Next
  EndIf
  
  ; Compare the CRC and name in the Archive list against the main UM database and add any archive with differences to Down_List()
  
  ForEach Arc_List()
    If GetFilePart(Arc_List()\Arc_Name)<>"EmeraldMines_v1.0_CD.lzx" And GetFilePart(Arc_List()\Arc_Name)<>"DangerFreak_v1.0_0975.lha" ; Duplicate archives.
      If FindMapElement(Arc_Map(),Arc_List()\Arc_Name)
        If Arc_List()\Arc_CRC <> Arc_Map() And GetFilePart(Arc_List()\Arc_Name)<>"GianaSistersSE_v1.2.lha" ; remove Giana Sisters SE beta as it uses a custom lha file.
          AddElement(Down_List())
          Down_List()\Down_Name=Arc_List()\Arc_Name
          Down_List()\Down_HTTP_Folder=Arc_List()\Arc_HTTP_Folder
        EndIf
      EndIf
      If Not FindMapElement(Arc_Map(),Arc_List()\Arc_Name) And GetFilePart(Arc_List()\Arc_Name)<>"GianaSistersSE_v1.2.lha" ; remove Giana Sisters SE beta as it uses a custom lha file.
        AddElement(Down_List())
        Down_List()\Down_Name=Arc_List()\Arc_Name
        Down_List()\Down_HTTP_Folder=Arc_List()\Arc_HTTP_Folder
      EndIf    
    EndIf
  Next
  
  Clean_Up:  
  
  ; Compare the comparison list of archive names against the new archive comparison map and add anything with a different name to the delete list.
  
  ForEach Comp_List()
    If Not FindMapElement(Comp_Map(),Comp_List())
      AddElement(Delete_List())
      Delete_List()=Comp_List()
    EndIf
  Next
  
  ClearList(File_List())
  ClearList(Dat_Archives())
  FreeList(Arc_List())
  FreeList(Comp_List())
  FreeMap(Arc_Map())
  FreeMap(Comp_Map())
  
  ;}
  ;{ 4. Remove/Backup Un-Needed archives #######################################################################################################################################################
  
  
  path=WHD_Folder
  
  If ListSize(Delete_List())>0
    
    PrintS()
    
    PrintNCol("Deleting old archives...",2,0)
    
    SetCurrentDirectory(path)
    
    ForEach Delete_List()
      If FileSize(Delete_List())>-1
        If AskYN("Delete : "+Delete_List()+" (Y/N)")
          PrintNCol("Deleting : "+GetCurrentDirectory()+Delete_List(),4,0)       
          DeleteFile(GetCurrentDirectory()+Delete_List(),#PB_FileSystem_Force)
        EndIf
      EndIf
    Next
    PrintS()
    
    FreeList(Delete_List())
    
  Else
    
    PrintS()
    PrintNCol("Nothing To Delete!",2,0)
    
  EndIf
  
  ;}  
  ;{ 5. Download new archives ##############################################################################################################################################
  
  Protected HTTP_Path.s, Server_Path.s, Download_Path.s
  
  If ListSize(Down_List())>0
    
    PrintS()      
    PrintNCol("Downloading New Archives...",9,0)
    PrintS()
    
    PrintN("Connected to "+HTTP_Server)
    PrintS()
    
    ForEach Down_List()  
      
      If FindString(Down_List()\Down_HTTP_Folder,"Game") 
        path="Game\"
      EndIf
      If FindString(Down_List()\Down_HTTP_Folder,"Beta") 
        path="Beta\"
      EndIf
      If FindString(Down_List()\Down_HTTP_Folder,"Demo") 
        path="Demo\"
      EndIf
      If FindString(Down_List()\Down_HTTP_Folder,"Magazine")
        path="Magazine\"
      EndIf
      
      http_path=Down_List()\Down_HTTP_Folder
      
      PrintN("Downloading : " + StringField(Down_List()\Down_Name,3,"\"))
      CreateDirectory(WHD_Folder+path)
      CreateDirectory(WHD_Folder+path+StringField(Down_List()\Down_Name,2,"\"))
      
      Download_Path=WHD_Folder+Down_List()\Down_Name
      Server_Path=HTTP_Server+"/"+http_path+"/"+StringField(Down_List()\Down_Name,2,"\")+"/"+StringField(Down_List()\Down_Name,3,"\")
      
      If ReceiveHTTPFile(Server_Path,Download_Path)  
        PrintN("Downloaded (" + Str(ListIndex(Down_List())+1) + " of " + Str(ListSize(Down_List())) + ") - " + Down_List()\Down_Name + " (" + Str(FileSize(Download_Path)) + " bytes)")  
      Else
        PrintNCol("*** Error ***",4,0)
      EndIf 
      
    Next
    
  Else
    
    PrintS()
    PrintNCol("Archives Up To Date!",2,0)
    
  EndIf
  
  Delay(2000)
  
  ;}
  
  Proc_Exit:
  
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

Procedure.i Compare_Versions(lha_file.s,new_type.s)
  
  Protected response.i, old_file.s, new_file.s, old_type.s
  
  response=-1
  
  ForEach UM_Database()
    old_file=LCase(RemoveString(UM_Database()\UM_LHAFile,Version(UM_Database()\UM_LHAFile)))
    old_type=LCase(UM_Database()\UM_Type)
    new_file=LCase(RemoveString(lha_file,Version(lha_file)))
    If old_file=new_file
      If old_type=new_type
        response=ListIndex(UM_Database())
      EndIf
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
    If GetExtensionPart(GetFilePart(path))="lha"
      command="x "+path+" -o"+WHD_TempDir+" "+#DOUBLEQUOTE$+Icon_List()\Icon_File+#DOUBLEQUOTE$
      UM_Program=RunProgram(LHA_Path,command,GetCurrentDirectory(),#PB_Program_Wait)
    EndIf
    If GetExtensionPart(GetFilePart(path))="lzx"
      command="-x "+path+" -o "+WHD_TempDir+" -p "+#DOUBLEQUOTE$+Icon_List()\Icon_File+#DOUBLEQUOTE$
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
    If UM_Database()\UM_Type="Magazine" : UM_Database()\UM_Genre="Disk Magazine" : EndIf
    If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine"
      UM_Database()\UM_Players="0"
    Else
      UM_Database()\UM_Players="1"
    EndIf
    path2=UM_Database()\UM_Type
    If UM_Database()\UM_Type="Demo" And UM_Database()\UM_Beta=#True  : path2="Beta-Demo" : EndIf
    UM_Database()\UM_CRC32=FileFingerprint(WHD_Folder+path2+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile,#PB_Cipher_CRC32)
    UM_Database()\UM_SHA1=FileFingerprint(WHD_Folder+path2+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile,#PB_Cipher_SHA1)
    UM_Database()\UM_MD5=FileFingerprint(WHD_Folder+path2+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile,#PB_Cipher_MD5)
    UM_Database()\UM_FileSize=FileSize(WHD_Folder+path2+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile)
    Language("Cz","Czech")
    Language("De","German")
    Language("Dk","Danish")
    Language("Es","Spanish")
    Language("Fi","Finnish")
    Language("Fr","French")
    Language("Gr","Greek")
    Language("Hr","Croatian")
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
      UM_Database()\UM_ECS=#True
    EndIf
    If FindString(UM_Database()\UM_LHAFile,"CD32")
      UM_Database()\UM_CD32=#True
      UM_Database()\UM_AGA=#True
      UM_Database()\UM_ECS=#False
      UM_Database()\UM_OCS=#False
    EndIf
    If FindString(UM_Database()\UM_LHAFile,"CDTV")
      UM_Database()\UM_CDTV=#True
      UM_Database()\UM_AGA=#False
      UM_Database()\UM_ECS=#True
      UM_Database()\UM_OCS=#False
    EndIf
    If FindString(UM_Database()\UM_LHAFile,"NTSC")
      UM_Database()\UM_NTSC=#True
    EndIf
    UM_Database()\UM_Folder=Copy_List()\Copy_Folder
    UM_Database()\UM_Title=Split_On_Capital(GetFilePart(add_archive,#PB_FileSystem_NoExtension))
    UM_Database()\UM_Short=UM_Database()\UM_Title
    UM_Database()\UM_WHD_Entry=GetFilePart(UM_Database()\UM_Slave,#PB_FileSystem_NoExtension)
    UM_Database()\UM_InstallSize=Get_Install_Size(add_archive)
    UM_Database()\UM_Sort_Name=UM_Database()\UM_Title + Tags()
    UM_Database()\UM_SPS=Get_SPS_Number(UM_Database()\UM_LHAFile)
  Next
  
  SetCurrentDirectory(Home_Path)
  
  FreeList(Icon_List())
  FreeList(Copy_List())
  
  Extract_Text_Files_Single(add_archive)
  
  DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Force|#PB_FileSystem_Recursive)    
  
  SelectElement(UM_Database(),List_Numbers()\L_Number+1)
  
EndProcedure

Procedure Update_ReDownload()
  
  Protected ReadO$, Output$, SubFolder$, length.i, UM_Program.i, zeros.i
  Protected old_path.s, command.s, response.s, date$
  
  Protected NewList Icon_List.Icon_Data()      ; List for icons in archive.
  Protected NewList Copy_List.Copy_Struct()
  
  ClearList(Icon_List())
  
  PrintN("Processing "+UM_Database()\UM_LHAFile) ; Display which archive is being processed
  
  If FileSize(WHD_TempDir)<>-2 : CreateDirectory(WHD_TempDir) : EndIf
  
  ; Create Icon List
  
  path=WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile ; new archive name
  
  ; Extracts the archive info and populates the Icon_List
  
  If GetExtensionPart(UM_Database()\UM_LHAFile)="lha"
    UM_Program=RunProgram(LHA_Path,"l "+path,GetCurrentDirectory(),#PB_Program_Open|#PB_Program_Read)
  EndIf
  
  If GetExtensionPart(UM_Database()\UM_LHAFile)="lzx"
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
      
      If FindString(ReadO$,".slave",0,#PB_String_NoCase)    ; Read only info and slave files from output          
        If GetExtensionPart(UM_Database()\UM_LHAFile)="lha"
          zeros=53 ; Set 53 characters for lha files
        EndIf
        If GetExtensionPart(UM_Database()\UM_LHAFile)="lzx"
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
            date$=Process_Date(GetExtensionPart(UM_Database()\UM_LHAFile),ReadO$) ; Get Slave Date
          EndIf
        Else
          Continue
        EndIf
      EndIf 
      
    Next
    
  EndIf               
  
  path=WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile ; new archive name
  
  ; Extract Info Files To Temp Folder
  
  SetCurrentDirectory(WHD_TempDir)
  
  ForEach Icon_List() ; Extract all the icon files
    PrintN("Extracting: "+Icon_List()\Icon_Name+" - "+#DOUBLEQUOTE$+Icon_List()\Icon_File+#DOUBLEQUOTE$)
    If GetExtensionPart(GetFilePart(path))="lha"
      command="x "+path+" -o"+WHD_TempDir+" "+#DOUBLEQUOTE$+Icon_List()\Icon_File+#DOUBLEQUOTE$
      UM_Program=RunProgram(LHA_Path,command,GetCurrentDirectory(),#PB_Program_Wait)
    EndIf
    If GetExtensionPart(GetFilePart(path))="lzx"
      command="-x "+path+" -o "+WHD_TempDir+" -p "+#DOUBLEQUOTE$+Icon_List()\Icon_File+#DOUBLEQUOTE$
      UM_Program=RunProgram(LZX_Path,command,GetCurrentDirectory(),#PB_Program_Wait)
    EndIf
  Next
  
  UM_Database()\UM_Slave_Date=date$
  ;UM_Database()\UM_Version=Version(UM_Database()\UM_LHAFile)
  UM_Database()\UM_InstallSize=Get_Install_Size(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile)
  UM_Database()\UM_CRC32=FileFingerprint(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile,#PB_Cipher_CRC32)
  UM_Database()\UM_MD5=FileFingerprint(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile,#PB_Cipher_MD5)
  UM_Database()\UM_SHA1=FileFingerprint(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile,#PB_Cipher_SHA1)
  UM_Database()\UM_FileSize=FileSize(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile)
  UM_Database()\UM_SPS=Get_SPS_Number(UM_Database()\UM_LHAFile)
  ClearList(Copy_List())
  ClearList(Icon_List())
  
  DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Force|#PB_FileSystem_Recursive) 
  
  SetCurrentDirectory(Home_Path)
  
  FreeList(Icon_List())
  FreeList(Copy_List())
  
  Extract_Text_Files_Single(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile)
  
EndProcedure

Procedure ReDownload_Game()
  
  Protected HTTP_Path.s, Server_Path.s, Download_Path.s
  
  If MessageRequester("Download","Redownload "+UM_Database()\UM_LHAFile+"?",#PB_MessageRequester_YesNo|#PB_MessageRequester_Info)=#PB_MessageRequester_Yes
    
    OpenConsole("Re-Download "+UM_Database()\UM_Title)
    
    If UM_Database()\UM_Type="Game" 
      path="Game\"
      http_path="Commodore_Amiga_-_WHDLoad_-_Games"
    EndIf
    If UM_Database()\UM_Type="Demo"
      path="Demo\"
      http_path="Commodore_Amiga_-_WHDLoad_-_Demos"
    EndIf
    If UM_Database()\UM_Type="Beta"
      path="Beta\"
      http_path="Commodore_Amiga_-_WHDLoad_-_Games_-_Beta_&_Unreleased"
    EndIf
    If UM_Database()\UM_Type="Magazine"
      path="Magazine\"
      http_path="Commodore_Amiga_-_WHDLoad_-_Magazines"
    EndIf
    
    PrintN("Downloading : " + UM_Database()\UM_Title)
    
    Download_Path=WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile
    
    Server_Path=HTTP_Server+"/"+http_path+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_LHAFile
    
    If ReceiveHTTPFile(Server_Path,Download_Path)  
      PrintN("Downloaded " +  UM_Database()\UM_Title + " (" + Str(FileSize(Download_Path)) + " bytes)")  
      Update_ReDownload()
    Else
      PrintNCol("*** Error ***",4,0)
    EndIf 
    
    Delay(1000)
    
    CloseConsole()
    
  EndIf
  
EndProcedure

Procedure Update_Database_Entry(add_archive.s,add_index.i)
  
  Protected ReadO$, Output$, SubFolder$, length.i, UM_Program.i, zeros.i
  Protected old_path.s, command.s, response.s, date$
  
  Protected NewList Icon_List.Icon_Data()      ; List for icons in archive.
  Protected NewList Copy_List.Copy_Struct()
  
  ClearList(Icon_List())
  
  PrintN("Processing "+GetFilePart(add_archive)) ; Display which archive is being processed
  
  If FileSize(WHD_TempDir)<>-2 : CreateDirectory(WHD_TempDir) : EndIf
  
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
    If GetExtensionPart(GetFilePart(path))="lha"
      command="x "+path+" -o"+WHD_TempDir+" "+#DOUBLEQUOTE$+Icon_List()\Icon_File+#DOUBLEQUOTE$
      UM_Program=RunProgram(LHA_Path,command,GetCurrentDirectory(),#PB_Program_Wait)
    EndIf
    If GetExtensionPart(GetFilePart(path))="lzx"
      command="-x "+path+" -o "+WHD_TempDir+" -p "+#DOUBLEQUOTE$+Icon_List()\Icon_File+#DOUBLEQUOTE$
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
  UM_Database()\UM_Sort_Date=Convert_AGS_Date(date$)
  UM_Database()\UM_Sort_Name=UM_Database()\UM_Title+Tags()
  ;UM_Database()\UM_Version=Version(add_archive)
  UM_Database()\UM_InstallSize=Get_Install_Size(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile)
  UM_Database()\UM_CRC32=FileFingerprint(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile,#PB_Cipher_CRC32)
  UM_Database()\UM_MD5=FileFingerprint(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile,#PB_Cipher_MD5)
  UM_Database()\UM_SHA1=FileFingerprint(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile,#PB_Cipher_SHA1)
  UM_Database()\UM_FileSize=FileSize(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile)
  UM_Database()\UM_SPS=Get_SPS_Number(UM_Database()\UM_LHAFile)
  ClearList(Copy_List())
  ClearList(Icon_List())
  
  DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Force|#PB_FileSystem_Recursive) 
  
  SetCurrentDirectory(Home_Path)
  
  FreeList(Icon_List())
  FreeList(Copy_List())
  
  Extract_Text_Files_Single(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile)
  
  SelectElement(UM_Database(),List_Numbers()\L_Number)
  
EndProcedure

Procedure Update_Database()
  
  Structure Update_Info
    Update_Name.s
    Update_Index.i
  EndStructure
  
  Protected NewMap  Folder_Check.i()   ; Folder & Slave Lookup Map 
  Protected NewList Check_List.Check_Struct()     ; Not Found List Of Main DB Element Numbers
  Protected NewList Update_List.Update_Info()       ; Not Found List Of Main DB Element Numbers
  Protected NewList New_List.s()                    ; Not Found List Of Main DB Element Numbers
  Protected NewMap  Check_Archives.s()              ; LHA Lookup Map
  
  Protected ReadO$, Output$, SubFolder$, length.i, UM_Program.i, zeros.i
  Protected old_path.s, command.s, response.s, date$
  
  OpenConsole("Update...")
  Center_Console()
  
  ConsoleCursor(0) 
  
  PrintNCol("**************************",6,0)
  PrintNCol("*                        *",6,0)
  PrintNCol("*  Updating Database...  *",6,0)
  PrintNCol("*                        *",6,0)
  PrintNCol("**************************",6,0)
  PrintS()  
  
  ClearList(File_List())
  
  ; Create List of WHD Archives On PC
  
  PrintNCol("Checking file CRCs...",5,0)
  PrintS()
  
  List_Files_Recursive_Size(WHD_Folder,File_List_Full(),"") 
  
  PrintNCol("Comparing files...",6,0)
  PrintS()
  
  If ListSize(File_List_Full())>0 
    
    ; Add Existing Database WHD Archives to Map
    
    ForEach UM_Database()      
      Check_Archives(UCase(UM_Database()\UM_CRC32))=Str(ListIndex(UM_Database()))  ; Map To check If WHD archive exists
    Next
    
    ; Scan through file list and if the file is not in the database, add it to a list to be checked. 
    
    ForEach File_List_Full()
      If Not FindMapElement(Check_Archives(),UCase(File_List_Full()\R_File_CRC32)) ; New Files
        If GetFilePart(File_List_Full()\R_File_File)<>"EmeraldMines_v1.0_CD.lzx" And GetFilePart(File_List_Full()\R_File_File)<>"DangerFreak_v1.0_0975.lha"  
          AddElement(Check_List())
          Check_List()\CS_Name=File_List_Full()\R_File_Name
          Check_List()\CS_CRC32=File_List_Full()\R_File_CRC32
        EndIf
      EndIf
    Next
    
    ; Compare version number of file against database

    Protected reply.i
    
    If ListSize(Check_List())>0    
      ForEach Check_List()
        reply=Compare_Versions(GetFilePart(Check_List()\CS_Name),LCase(StringField(Check_List()\CS_Name,4,"\")))
        If reply<>-1
          AddElement(Update_List())
          Update_List()\Update_Name=Check_List()\CS_Name
          Update_List()\Update_Index=reply
        Else
          AddElement(New_List())
          New_List()=Check_List()\CS_Name
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
  
  Protected NewList Backup_List.UM_Data()
  
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
        
        path2=UM_Database()\UM_Type
        
        olddir=Game_Data_Path+path2+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"
        
        Save_DB_Entry(olddir+"database_entry.json")
        
        Zip_Folder(olddir,Backup_Path+UM_Database()\UM_Folder+".zip")
        
        DeleteFile(olddir+"database_entry.json")
        DeleteDirectorySafely(olddir)
        
        ; Delete selected database entry 
        
        PrintNCol("Deleting Database Entry For "+UM_Database()\UM_Title,4,0)
        DeleteElement(UM_Database())
      EndIf   
    EndIf
  Next
  
  Protected NewMap search_map.s()
  Protected NewMap delete_map.s()
  
  ForEach UM_Database()
    path2=UM_Database()\UM_Type
    If UM_Database()\UM_Type="Demo" And UM_Database()\UM_Beta=#True  : path2="Beta-Demo" : EndIf  
    search_map(Game_Data_Path+path2+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\")=""
  Next
  
  List_Files_Recursive(Game_Data_Path,File_List(),"*.*")
  
  ForEach File_List()
    If CountString(GetPathPart(File_List()),"\")=6
      If Not FindMapElement(search_map(),GetPathPart(File_List()))
        delete_map(GetPathPart(File_List()))=""
      EndIf
    EndIf
  Next
  
  ForEach delete_map()
    PrintNCol("Not Required : "+MapKey(delete_map()),4,0)
  Next
  
  If MapSize(delete_map())>0
    PrintN("")
    
    PrintN("These folders are no longer required. Delete (Y/N/C)?")
    Repeat : path2=Inkey() :  Until path2="Y" Or path2="y" Or path2="N" Or path2="n" Or path2="C" Or path2="c"
    If path2="y" Or path2="Y"
      ForEach delete_map()
        
        ; Backup Game Info
        
        path2=UM_Database()\UM_Type
        If UM_Database()\UM_Type="Demo" And UM_Database()\UM_Beta=#True  : path2="Beta-Demo" : EndIf  
        
        olddir=Game_Data_Path+path2+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"
        
        Save_DB_Entry(olddir+"database_entry.json")
        
        Zip_Folder(olddir,Backup_Path+UM_Database()\UM_Folder+".zip")
        
        DeleteFile(olddir+"database_entry.json")
        
        PrintNCol("Deleting "+MapKey(delete_map()),4,0)
        
        DeleteDirectory(MapKey(delete_map()),"*.*",#PB_FileSystem_Force|#PB_FileSystem_Recursive)
        
      Next 
      Delay(1000)
    EndIf
  EndIf
  
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
  FreeMap(search_map())
  FreeMap(delete_map())
  ClearList(New_List())
  ClearList(File_List())
  
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
  Center_Console()
  
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
  
  CreateDirectory(WHD_TempDir)
  
  ; Create a new temporary directory for DH1:
  
  SetCurrentDirectory(WHD_TempDir)
  
  ; Create a text file for WB startup to run
  
  DeleteFile("whd-startup")
  startup_file=CreateFile(#PB_Any,"whd-startup")
  
  If startup_file
    
    ; Check to see if WHD drive is mounted.
    
    WriteString(startup_file,"If EXISTS WHD-HDD:"+#LF$)
    WriteString(startup_file," CD WHD-HDD:"+#LF$)
    WriteString(startup_file," Echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$)
    WriteString(startup_file," Echo "+#DOUBLEQUOTE$+"Creating Folders List... Please Wait!"+#DOUBLEQUOTE$+#LF$)
    WriteString(startup_file," Echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$)
    WriteString(startup_file," Echo "+#DOUBLEQUOTE$+"This could take a few minutes..."+#DOUBLEQUOTE$+#LF$)
    WriteString(startup_file," Echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$)
    WriteString(startup_file," Echo "+#DOUBLEQUOTE$+"Executing Command: list DIRS ALL LFORMAT %P%N"+#DOUBLEQUOTE$+#LF$)
    
    ; Create a file of directories in the temp folder
    
    WriteString(startup_file," List dirs all lformat %p%n >DH1:dirs.txt"+#LF$)
    WriteString(startup_file," Echo "+#DOUBLEQUOTE$+"Executing Command: list P=#?.slave DATES ALL LFORMAT %P%N¬%D"+#DOUBLEQUOTE$+#LF$)
    
    ; Create a file of slaves and dates in the temp folder
    
    WriteString(startup_file," List P=#?.slave DATES ALL LFORMAT %P%N¬%D >DH1:slaves.txt"+#LF$)
    
    ; Create a file if the batch file completes
    
    WriteString(startup_file," Echo "+#DOUBLEQUOTE$+"Complete"+#DOUBLEQUOTE$+" TO DH1:complete.txt"+#LF$)
    WriteString(startup_file,"Else"+#LF$)
    WriteString(startup_file," RequestChoice >NIL: Error "+#DOUBLEQUOTE$+"WHD-HDD Not Available. "+#DOUBLEQUOTE$+"OK"+#LF$)
    WriteString(startup_file,"Endif"+#LF$)
    WriteString(startup_file,"Wait 2"+#LF$)
    WriteString(startup_file,"C:UaeQuit")
    FlushFileBuffers(startup_file)
    CloseFile(startup_file)      
  EndIf
  
  ; Run WinUAE with the batch file and wait
  
  startup_prog=RunProgram(WinUAE_Path, "-f "+IG_Path+"Update.uae -s filesystem2=rw,DH1:WHDTemp:"+WHD_TempDir+",0","",#PB_Program_Wait) 
  
  ; If the complete.txt file doesn't exist, go to exit.
  
  If FileSize("complete.txt")=0 Or FileSize("complete.txt")=-1
    DeleteFile("dirs.txt")
    DeleteFile("slaves.txt")
    DeleteFile("whd-startup")
    DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
    PrintNCol("WinUAE Error!",4,0)
    PrintS()
    Delay(2000)
    Goto CleanUp
  EndIf
  
  ; Remove the temporary folder
  
  
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
  
  cd_file=ReadFile(#PB_Any,"dirs.txt")
  
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
    DeleteFile("dirs.txt")  
    
    If ListSize(Miggy_List())=0 : Goto Cleanup : EndIf
    
    SortList(Miggy_List(),#PB_Sort_Ascending)
    
    ; Copy the Amiga directories into a new map for comparison.
    
    ForEach Miggy_List()
      Miggy_Map(Miggy_List())=Miggy_List()  
    Next
    
  Else
    
    MessageRequester("Error","Cannot open dirs.txt",#PB_MessageRequester_Ok)
    Goto Cleanup
    
  EndIf 
  
  ; Create list on not needed directories on the Amiga drive called Delete List.
  
  ForEach Miggy_Map()
    If Not FindMapElement(PC_Map(),MapKey(Miggy_Map())) ; If the entry isn't in the map, add it to Delete List
      AddElement(Delete_List())
      Delete_List()="WHD-HDD:"+MapKey(Miggy_Map()) ; Directory on Amiga drive to be removed
    EndIf
  Next 
  
  ; Open slaves.txt file and extract it's name and date for comparison
  
  cd_file=ReadFile(#PB_Any,"slaves.txt")
  
  If cd_file
    While Not Eof(cd_file)
      output=ReadString(cd_file)
      Miggy_Comp_Map(LCase(StringField(output,1,"¬")))=StringField(output,2,"¬")   
    Wend 
    CloseFile(cd_file)
    DeleteFile("slaves.txt")  
  Else
    MessageRequester("Error","Cannot open slaves.txt",#PB_MessageRequester_Ok)
    Goto Cleanup
  EndIf 
  
  ; Remove data from Copy List, ready for new data
  
  ClearList(Copy_List())
  
  ; Scan through database to find new entries to copy
  
  Protected add_dir.b=#False
  Protected update_dir.b=#False
  Protected path3.s
  
  ForEach UM_Database()  
    path3=UM_Database()\UM_Type
    If UM_Database()\UM_Type="Demo" And UM_Database()\UM_Beta=#True  : path3="Beta-Demo" : EndIf   
    path2=path3+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+"/"+UM_Database()\UM_Slave
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
      PrintN("Update Amiga (Y/N)?") 
      Repeat : path2=Inkey() :  Until path2="Y" Or path2="y" Or path2="N" Or path2="n"
    EndIf
    
    If add_dir And Not update_dir
      PrintS()
      PrintN("Extract new archives (Yes/No)?.")
      Repeat : path2=Inkey() :  Until path2="Y" Or path2="y" Or path2="N" Or path2="n"
    EndIf
    
    exit=#False
    
    If path2="n" Or path2="N"
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
    PrintNCol(#LF$+"WARNING! WARNING! WARNING!"+#LF$,4,0)
    PrintNCol("You are about to make changes to the Amiga drive! Continue (Y/N)?",15,0)
    Repeat : path=Inkey() :  Until path="Y" Or path="y" Or path="N" Or path="n"
    PrintS()
    
    If path="y" Or path="Y"
      
      ; If the answer is yes, continue.
      
      PrintNCol("Starting WinUAE...",14,0)
      PrintS()
      
      ; Create the batch file that the Amiga will use to update it's drive
      
      output=""
      
      If ListSize(Delete_List())>0
        
        output+"echo "+#DOUBLEQUOTE$+"Deleting Unneeded Directories..."+#DOUBLEQUOTE$+#LF$
        output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
        
        ; Create list of files to be deleted based on the Delete List.
        
        ForEach Delete_List()
          output+"delete "+Delete_List()+" ALL FORCE"+#LF$ ; Delete Directory
          output+"delete "+Delete_List()+".info"+#LF$      ; Delete Icon
        Next
        
      EndIf
      
      If ListSize(Copy_List())>0
        
        ; If the Full option is selected, add list of directories to be deleted to script based on the Copy List.
        
        ForEach Copy_List()
          SelectElement(UM_Database(),Copy_List()\c_number)  
          output+"delete WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+" ALL FORCE"+#LF$
          output+"delete WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+".info"+#LF$
        Next
        
        output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
        output+"echo "+#DOUBLEQUOTE$+"Extracting New Archives..."+#DOUBLEQUOTE$+#LF$
        output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
        
        ; Wait For Disk To Finish before starting archive extraction.
        
        output+"wait 2"+#LF$
        
        ; Add unarchive commands based on the Copy List.
        
        ForEach Copy_List()
          SelectElement(UM_Database(),Copy_List()\c_number)
          output+"if NOT EXISTS "+"WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+#LF$
          output+"  makedir "+"WHD-HDD:"+UM_Database()\UM_Type+#LF$
          output+"  makedir "+"WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+#LF$
          output+"endif"+#LF$
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
      output+"echo "+#DOUBLEQUOTE$+"Waiting For disk activity To finish... "+#DOUBLEQUOTE$+#LF$
      output+"wait 4"+#LF$
      
      ; Quit WinUAE
      
      output+"uae-configuration SPC_QUIT 1"
      
      ; Check if temporary folder exists and delete if necessary.
      
      Protected result.i        
      
      ; Create a new temporary directory for DH1:
      
      SetCurrentDirectory(WHD_TempDir)
      
      ; Create the startup script
      
      startup_file=CreateFile(#PB_Any,"whd-startup")
      
      If startup_file
        
        ; Write the output script to the batch file
        
        WriteString(startup_file,output,#PB_Ascii)
        
        ; copy the required archive into the temporary folder and name as 1.lha,2.lha... to remove extraction name problems
        
        ForEach Copy_List()
          SelectElement(UM_Database(),Copy_List()\c_number)
          path2=UM_Database()\UM_Type
          If UM_Database()\UM_Type="Demo" And UM_Database()\UM_Beta=#True  : path2="Beta-Demo" : EndIf   
          path=ReplaceString(WHD_Folder+path2+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile,"/","\")
          If GetExtensionPart(UM_Database()\UM_LHAFile)="lha"
            result=CopyFile(path,Str(ListIndex(Copy_List()))+".lha")
            Continue
          EndIf
          If GetExtensionPart(UM_Database()\UM_LHAFile)="lzx"
            result=CopyFile(path,Str(ListIndex(Copy_List()))+".lzx")
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
  
  ; On error go to here!
  
  CleanUp:
  
  CloseConsole()
  
  ; Clear Resources
  
  If FileSize(home_path+"dirs.txt")>0 : DeleteFile(home_path+"dirs.txt") : EndIf
  If FileSize(home_path+"slaves.txt")>0 : DeleteFile(home_path+"slaves.txt") : EndIf
  If FileSize(WHD_TempDir)=-2 : DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force) : EndIf
  
  FreeList(Miggy_List())
  FreeMap(Miggy_Map())
  FreeMap(PC_Map())
  FreeList(PC_List())
  FreeMap(Miggy_Comp_Map())
  FreeList(Copy_List())
  FreeList(Delete_List())
  
EndProcedure

Procedure Make_AGS_HDF()
  
  Protected type_folder.s
  
  Protected NewList Output_Path.AGS_Update()
  
  ForEach UM_Database()
    AddElement(Output_Path())
    Output_Path()\Input_Path="WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder
    If UM_Database()\UM_AGA : type_folder="/AGA/"+UM_Database()\UM_Type+"/" : EndIf 
    If UM_Database()\UM_ECS Or UM_Database()\UM_OCS : type_folder="/ECS-OCS/"+UM_Database()\UM_Type+"/" : EndIf
    If UM_Database()\UM_CD32 : type_folder="/CD32/" : EndIf
    If UM_Database()\UM_CDTV : type_folder="/CDTV/" : EndIf
    If UM_Database()\UM_Arcadia : type_folder="/Arcadia/" : EndIf
    Output_Path()\Output_Path="WHD-HDD2:"+type_folder+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder
    Debug Output_Path()\Input_Path
    Debug Output_Path()\Output_Path
  Next
    
EndProcedure

Procedure ReInstall_Game(gamenum)
  
  If MessageRequester("Install","Re-install?",#PB_MessageRequester_Warning|#PB_MessageRequester_YesNo)=#PB_MessageRequester_Yes
    
    SelectElement(UM_Database(),gamenum)
    
    Protected exit.b, output.s, startup_file, startup_prog
    
    OpenConsole("Re-Install Game...")
    Center_Console()
    
    ConsoleCursor(0)
    
    PrintNCol("**************************",6,0)
    PrintNCol("*                        *",6,0)
    PrintNCol("*       Re-Install...    *",6,0)
    PrintNCol("*                        *",6,0)
    PrintNCol("**************************",6,0)
    PrintS() 
    
    PrintNCol("Reinstalling: "+UM_Database()\UM_Title+Tags(),10,0)
    PrintS()
    
    PrintN("Update Amiga Drive (Y/N)?")
    
    Repeat : path2=Inkey() :  Until path2="Y" Or path2="y" Or path2="N" Or path2="n"
    
    exit=#False
    
    If LCase(path2)="n"
      exit=#True
    EndIf
    
    ; If a valid entry is made check that it's OK to continue
    
    If Not exit
      
      PrintNCol(#LF$+"WARNING!WARNING!WARNING!"+#LF$,4,0)
      PrintNCol("You are about to make changes to the Amiga drive! Continue (Y/N)?",15,0)
      Repeat : path=Inkey() :  Until path="Y" Or path="y" Or path="N" Or path="n"
      PrintS()
      
      If LCase(path)="y"
        
        ; If the answer is yes, continue.
        
        PrintNCol("Starting WinUAE...",14,0)
        PrintS()
        
        ; Create the batch file that the Amiga will use to update it's drive
        
        output+"echo "+#DOUBLEQUOTE$+"Deleting Old Directories..."+#DOUBLEQUOTE$+#LF$
        output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
        output+"delete WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+" ALL FORCE"+#LF$
        output+"delete WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+".info"+#LF$
        
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
        output+"echo "+#DOUBLEQUOTE$+"Waiting For disk activity to finish... "+#DOUBLEQUOTE$+#LF$
        output+"wait 4"+#LF$
        output+"echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$
        ;output+"ask "+#DOUBLEQUOTE$+"Press A Key to Close WinUAE..."+#DOUBLEQUOTE$+#LF$
        
        ; Quit WinUAE
        
        output+"uae-configuration SPC_QUIT 1"
        
        ; Check if temporary folder exists and delete if necessary.
        
        If FileSize(WHD_TempDir)=-2 : DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force) : EndIf
        
        Protected result.i        
        
        ; Create a new temporary directory for DH1:
        
        If CreateDirectory(WHD_TempDir)
          SetCurrentDirectory(WHD_TempDir)
          
          ; Create the startup script
          
          startup_file=CreateFile(#PB_Any,"whd-startup",#PB_Ascii)
          
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

;- ############### A500 Mini Stuff

Procedure Make_A500_WHD_USB()
  
  Structure Copy_Path
    Input_Folder.s
    Output_Root.s
    Output_Type.s
    Output_SubFolder.s
    Output_LHA.s
    Output_Folder.s
  EndStructure
  
  Protected NewList USB_List.Copy_Path()
  
  Protected usb_path.s=PathRequester("Select USB Drive","")
  Protected NewMap filter_map()
  
  count=1
  
  If usb_path<>""
    
    ForEach UM_Database()
      
      If UM_Database()\UM_Language="English"
        If UM_Database()\UM_Files<>#True
          If UM_Database()\UM_Arcadia<>#True
            If UM_Database()\UM_Demo<>#True
              If UM_Database()\UM_Intro<>#True
                If UM_Database()\UM_Memory<>"Chip Mem"
                  filter_map(UM_Database()\UM_LHAFile)=ListIndex(UM_Database())
                EndIf
              EndIf
            EndIf
          EndIf
        EndIf
      EndIf
    Next
    
    ForEach filter_map()
      SelectElement(UM_Database(),filter_map())
      AddElement(USB_List())
      USB_List()\Input_Folder=WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile
      USB_List()\Output_Root=usb_path
      USB_List()\Output_SubFolder=UM_Database()\UM_Subfolder
      
      Select LCase(Left(UM_Database()\UM_Subfolder,1))
        Case Chr(115) ; s
          Select LCase(Mid(UM_Database()\UM_LHAFile,2,1))
            Case "a","b","c","d","e","f","g","h","i","j","k","l","m","_"
              USB_List()\Output_SubFolder="S0-SL"
            Case "n","o","p","q","r","s","t","u","v","w","x","y","z"
              USB_List()\Output_SubFolder="SN-SZ"
          EndSelect  
      EndSelect
      
      Select LCase(Left(UM_Database()\UM_Subfolder,1))
        Case Chr(116) ; t
          Select LCase(Mid(UM_Database()\UM_LHAFile,2,1))
            Case "a","b","c","d","e","f","g","h","i","j","k","l","m"
              USB_List()\Output_SubFolder="T0-TL"
            Case "n","o","p","q","r","s","t","u","v","w","x","y","z"
              USB_List()\Output_SubFolder="TN-TZ"
          EndSelect  
      EndSelect
      
      USB_List()\Output_LHA=UM_Database()\UM_LHAFile
      
      If UM_Database()\UM_Type="Game"
        If UM_Database()\UM_AGA=#True
          USB_List()\Output_Type="AGA"
        EndIf
        If UM_Database()\UM_ECS=#True
          USB_List()\Output_Type="ECS"
        EndIf
        If UM_Database()\UM_OCS=#True
          USB_List()\Output_Type="OCS"
        EndIf
        If UM_Database()\UM_CD32=#True
          USB_List()\Output_Type="CD32"
        EndIf
        If UM_Database()\UM_CDTV=#True
          USB_List()\Output_Type="CDTV"
        EndIf
        If UM_Database()\UM_NTSC=#True
          USB_List()\Output_Type="NTSC"
        EndIf
      EndIf
      
      If UM_Database()\UM_Type="Beta"
        USB_List()\Output_Type="BETA"
      EndIf
      
      If UM_Database()\UM_Type="Demo"
        If UM_Database()\UM_AGA=#True
          USB_List()\Output_Type="DEMOS-AGA"
        Else
          USB_List()\Output_Type="DEMOS-ECS"
        EndIf
      EndIf
      
    Next
    
    OpenConsole("USB File Copy")
    Center_Console()
    
    ForEach USB_List()
      PrintN("Copying : "+USB_List()\Output_LHA+" ("+Str(count)+" of "+MapSize(filter_map())+")")
      USB_List()\Output_Folder=USB_List()\Output_Root+USB_List()\Output_Type+"\"+USB_List()\Output_SubFolder+"\"+USB_List()\Output_LHA
      If FileSize(USB_List()\Output_Root+USB_List()\Output_Type)=-1 : CreateDirectory(USB_List()\Output_Root+USB_List()\Output_Type) : EndIf
      If FileSize(USB_List()\Output_Root+USB_List()\Output_Type+"\"+USB_List()\Output_SubFolder)=-1 : CreateDirectory(USB_List()\Output_Root+USB_List()\Output_Type+"\"+USB_List()\Output_SubFolder) : EndIf
      CopyFile(USB_List()\Input_Folder,USB_List()\Output_Folder)
      count+1
    Next
    
    CloseConsole()
    
  EndIf
  
  FreeList(USB_List())
  FreeMap(filter_map())
  
EndProcedure

;- ############### Creation Procedures

Procedure AGS_ECS_Delete_List()
  
  OpenConsole("AGS_ECS")
  
  CreateFile(0,Home_Path+"delete_list")
  
  ForEach UM_Database()
    If Not UM_Database()\UM_AGA
      Continue
    EndIf
    If Not UM_Database()\UM_CDROM
      Continue
    EndIf
    If Not UM_Database()\UM_CD32
      Continue
    EndIf
    WriteString(0,"Delete WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+" ALL FORCE"+#LF$)
    WriteString(0,"Delete WHD-HDD:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+".info"+#LF$)
  Next
  
  CloseFile(0)
  
  Pause_Console()
  
  CloseConsole()
  
EndProcedure

Procedure Save_IG_DB()
  
  Protected IG_File, Chipset.s
  
  IG_File=CreateFile(#PB_Any,Home_Path+"IG_Data.dat",#PB_Ascii)
  
  If IG_File

    ForEach UM_Database()
      If UM_Database()\UM_Intro : Continue : EndIf
      If UM_Database()\UM_Data_Disk : Continue : EndIf
      If UM_Database()\UM_Genre="Misc / Editor" : Continue : EndIf
      If UM_Database()\UM_Genre="Misc / Utility" : Continue : EndIf
      Chipset=""
      If UM_Database()\UM_AGA : Chipset="AGA" : EndIf
      If UM_Database()\UM_OCS : Chipset="OCS" : EndIf
      If UM_Database()\UM_ECS : Chipset="ECS\OCS" : EndIf
      WriteStringN(IG_File,UM_Database()\UM_Slave+";"+UM_Database()\UM_Folder+";"+UM_Database()\UM_Genre+";"+UM_Database()\UM_Title+Tags()+";"+UM_Database()\UM_Short+Tags_Short()+";"+UM_Database()\UM_Icon+";"+UM_Database()\UM_LHAFile)
    Next
  EndIf
  
  CloseFile(IG_File)
  
EndProcedure

Procedure Generate_IGame_Data(dest_folder$)
  
  Protected f_type.s
  
  If dest_folder$<>""
    
    Protected new_file$, output$
    
    OpenConsole("Generate IGame Data Files")
    
    ForEach UM_Database()
      If UM_Database()\UM_Intro : Continue : EndIf
      If UM_Database()\UM_Data_Disk : Continue : EndIf
      If UM_Database()\UM_Genre="Misc / Editor" : Continue : EndIf
      If UM_Database()\UM_Genre="Misc / Utility" : Continue : EndIf
      If FileSize(dest_folder$+f_type)<>-2 : CreateDirectory(dest_folder$+f_type) : EndIf
      If FileSize(dest_folder$+f_type+"\"+UM_Database()\UM_Subfolder)<>-2 : CreateDirectory(dest_folder$+f_type+"\"+UM_Database()\UM_Subfolder) : EndIf
      If FileSize(dest_folder$+f_type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder)<>-2 : CreateDirectory(dest_folder$+f_type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder) : EndIf
      new_file$=dest_folder$+f_type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"
      IGame_Data_Entry()
    Next
    
    CloseConsole()
    
  EndIf
  
EndProcedure

Procedure Make_Extra_Texts()
  
  Protected output$, text$, pad1, pad2
  
  ClearList(File_List())
  
  path=PathRequester("Select Folder",Home_Path)
  
  List_Files_Recursive(path,File_List(),"*.run")
  ForEach File_List()
    If CreateFile(0,GetPathPart(File_List())+GetFilePart(File_List(),#PB_FileSystem_NoExtension)+".txt")
      count=Len(GetFilePart(File_List(),#PB_FileSystem_NoExtension))
      pad1=(40-count)/2
      text$=RSet(GetFilePart(File_List(),#PB_FileSystem_NoExtension),pad1+count)
      output$=" **************************************** "+#LF$
      output$+" *                                      * "+#LF$
      output$+" *                                      * "+#LF$
      output$+" *                                      * "+#LF$
      output$+" *"+text$+RSet("* ",40-Len(text$))+#LF$
      output$+" *                                      * "+#LF$
      output$+" *                                      * "+#LF$
      output$+" *                                      * "+#LF$
      output$+" *                                      * "+#LF$
      output$+" **************************************** "
      WriteString(0,output$)
      CloseFile(0)  
    EndIf
  Next
  
EndProcedure

Procedure Export_AGS_Database()
  
  Protected NewList Export_List.Export_Struct()
  
  ForEach UM_Database()
    AddElement(Export_List())
    Export_List()\WHD_Title=UM_Database()\UM_Title+Tags()
    Export_List()\WHD_Short=UM_Database()\UM_Short
    Export_List()\WHD_Genre=UM_Database()\UM_Genre
    If UM_Database()\UM_CD32 : Export_List()\WHD_Hardware="CD32" : EndIf
    If UM_Database()\UM_CDTV : Export_List()\WHD_Hardware="CDTV" : EndIf
    If UM_Database()\UM_Arcadia : Export_List()\WHD_Hardware="Arcadia" : EndIf
    If Not UM_Database()\UM_CD32 And Not UM_Database()\UM_CDTV And Not UM_Database()\UM_Arcadia : Export_List()\WHD_Hardware="Amiga" : EndIf
    Export_List()\WHD_Publisher=UM_Database()\UM_Publisher
    If UM_Database()\UM_Party<>"" : Export_List()\WHD_Party=UM_Database()\UM_Party : EndIf
    If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Type="Beta" : Export_List()\WHD_Developer=UM_Database()\UM_Developer : EndIf
    Export_List()\WHD_Year=UM_Database()\UM_Year
    Export_List()\WHD_Language=UM_Database()\UM_Language
    Export_List()\WHD_Players=UM_Database()\UM_Players
    If UM_Database()\UM_AGA Or UM_Database()\UM_CD32
      Export_List()\WHD_Chipset="AGA"
    Else
      Export_List()\WHD_Chipset="ECS-OCS"
    EndIf
    If UM_Database()\UM_NTSC
      Export_List()\WHD_TV_System="NTSC"
    Else
      Export_List()\WHD_TV_System="PAL"
    EndIf
    If UM_Database()\UM_MT32
      Export_List()\WHD_Sound="Paula / MT32"
    Else
      Export_List()\WHD_Sound="Paula"
    EndIf
    Export_List()\WHD_Folder=UM_Database()\UM_Folder
    Export_List()\WHD_InstallSize=UM_Database()\UM_InstallSize
    Export_List()\WHD_Slave=UM_Database()\UM_Slave
    Export_List()\WHD_Slave_Date=UM_Database()\UM_Slave_Date
    Export_List()\WHD_Version=UM_Database()\UM_Version
    Export_List()\WHD_Default_Icon=UM_Database()\UM_Icon
    Export_List()\WHD_LHAFile=UM_Database()\UM_LHAFile
    Export_List()\WHD_FileSize=UM_Database()\UM_FileSize
    Export_List()\WHD_CRC32=UM_Database()\UM_CRC32
    Export_List()\WHD_MD5=UM_Database()\UM_MD5
    Export_List()\WHD_SHA1=UM_Database()\UM_SHA1
    path=""
    If UM_Database()\UM_WHD_Entry<>""
      If UM_Database()\UM_Type="Game" : path="http://www.whdload.de/games/"+UM_Database()\UM_WHD_Entry+".html" : EndIf
      If UM_Database()\UM_Type="Demo" : path="http://www.whdload.de/demos/"+UM_Database()\UM_WHD_Entry+".html" : EndIf
      If UM_Database()\UM_Type="Magazine" : path="http://www.whdload.de/mags/"+UM_Database()\UM_WHD_Entry+".html" : EndIf
    EndIf
    Export_List()\WHD_WHD=path
    If UM_Database()\UM_HOL_Entry<>""
      Export_List()\WHD_HOL="http://hol.abime.net/"+UM_Database()\UM_HOL_Entry
    Else
      Export_List()\WHD_HOL=""
    EndIf
    If UM_Database()\UM_HOL_Entry_New<>""
      Export_List()\WHD_HOL_New="https://amiga.abime.net/games/view/"+UM_Database()\UM_HOL_Entry_New
    Else
      Export_List()\WHD_HOL_New=""
    EndIf
    If UM_Database()\UM_Lemon_Entry<>"" 
      Export_List()\WHD_Lemon="https://www.lemonamiga.com/games/details.php?id="+UM_Database()\UM_Lemon_Entry
    Else
      Export_List()\WHD_Lemon=""
    EndIf
    If UM_Database()\UM_Pouet<>"" 
      Export_List()\WHD_Pouet="https://www.pouet.net/prod.php?which="+UM_Database()\UM_Pouet
    Else
      Export_List()\WHD_Pouet=""
    EndIf
    If UM_Database()\UM_Janeway<> "" 
      Export_List()\WHD_Janeway="http://janeway.exotica.org.uk/release.php?id="+UM_Database()\UM_Janeway
    Else
      Export_List()\WHD_Janeway=""
    EndIf
    If UM_Database()\UM_Type="Game" : path2="Commodore_Amiga_-_WHDLoad_-_Games/" : EndIf 
    If UM_Database()\UM_Type="Demo" : path2="Commodore_Amiga_-_WHDLoad_-_Demos/" : EndIf 
    If UM_Database()\UM_Type="Beta" And UM_Database()\UM_Beta_Type="Game" : path2="Commodore_Amiga_-_WHDLoad_-_Games_-_Beta_&_Unreleased/" : EndIf 
    If UM_Database()\UM_Type="Beta" And UM_Database()\UM_Beta_Type="Demo" : path2="Commodore_Amiga_-_WHDLoad_-_Demos_-_Beta_&_Unreleased/" : EndIf 
    If UM_Database()\UM_Type="Magazine" : path2="Commodore_Amiga_-_WHDLoad_-_Magazines/" : EndIf 
    Export_List()\WHD_Turran="https://ftp2.grandis.nu/turran/FTP/Retroplay%20WHDLoad%20Packs/"+path2+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_LHAFile
  Next
  
  Protected lJSON
  
  lJSON = CreateJSON(#PB_Any)
  
  lJSON = CreateJSON(#PB_Any)
  InsertJSONList(JSONValue(lJSON), Export_List())
  SaveJSON(lJSON,Home_Path+"WHDLoad_Database.json",#PB_JSON_PrettyPrint)
  FreeJSON(lJSON)
  
  Protected xml_file,item,mainnode,mainitem,attrib
  
  xml_file=CreateXML(#PB_Any,#PB_Ascii)
  
  SetXMLStandalone(xml_file,#PB_XML_StandaloneYes)
  SetXMLEncoding(xml_file,#PB_Ascii)
  Protected Build.s=FormatDate("%dd-%mm-%yy %hh:%mm:%ss", Date())
  mainnode=CreateXMLNode(RootXMLNode(xml_file),"WHDLoad_DB")
  attrib=SetXMLAttribute(mainnode,"Created",Build)
  ForEach UM_Database()    
    mainitem=CreateXMLNode(mainnode,"Software")
    attrib=SetXMLAttribute(mainitem,"FileName",UM_Database()\UM_LHAFile)  
    attrib=SetXMLAttribute(mainitem,"FileSize",Str(UM_Database()\UM_FileSize))   
    attrib=SetXMLAttribute(mainitem,"CRC32", UM_Database()\UM_CRC32)
    attrib=SetXMLAttribute(mainitem,"MD5", UM_Database()\UM_MD5)
    attrib=SetXMLAttribute(mainitem,"SHA1", UM_Database()\UM_SHA1)
    item=CreateXMLNode(mainitem,"FullName") : SetXMLNodeText(item,UM_Database()\UM_Title+Tags())
    item=CreateXMLNode(mainitem,"ShortName") : SetXMLNodeText(item,UM_Database()\UM_Short)
    item=CreateXMLNode(mainitem,"FileType") : SetXMLNodeText(item,UM_Database()\UM_Type)
    item=CreateXMLNode(mainitem,"Hardware")
    If UM_Database()\UM_CD32 : SetXMLNodeText(item,"CD32") : EndIf
    If UM_Database()\UM_CDTV : SetXMLNodeText(item,"CDTV") : EndIf
    If UM_Database()\UM_Arcadia : SetXMLNodeText(item,"Arcadia") : EndIf
    If Not UM_Database()\UM_CD32 And Not UM_Database()\UM_CDTV And Not UM_Database()\UM_Arcadia : SetXMLNodeText(item,"Amiga") : EndIf
    item=CreateXMLNode(mainitem,"Genre") : SetXMLNodeText(item,UM_Database()\UM_Genre)
    item=CreateXMLNode(mainitem,"Publisher_Group") : SetXMLNodeText(item,UM_Database()\UM_Publisher)
    item=CreateXMLNode(mainitem,"Developer") : SetXMLNodeText(item,UM_Database()\UM_Publisher)
    item=CreateXMLNode(mainitem,"ReleaseParty") : SetXMLNodeText(item,UM_Database()\UM_Party)
    item=CreateXMLNode(mainitem,"Year") : SetXMLNodeText(item,UM_Database()\UM_Year)
    item=CreateXMLNode(mainitem,"Language") : SetXMLNodeText(item,UM_Database()\UM_Language)     
    item=CreateXMLNode(mainitem,"Players") : SetXMLNodeText(item,UM_Database()\UM_Players)
    item=CreateXMLNode(mainitem,"Chipset")
    If UM_Database()\UM_ECS : SetXMLNodeText(item,"ECS") : EndIf
    If UM_Database()\UM_OCS : SetXMLNodeText(item,"OCS") : EndIf
    If UM_Database()\UM_AGA : SetXMLNodeText(item,"AGA") : EndIf
    item=CreateXMLNode(mainitem,"TVSystem")
    If UM_Database()\UM_NTSC 
      SetXMLNodeText(item,"NTSC")
    Else
      SetXMLNodeText(item,"PAL")
    EndIf
    item=CreateXMLNode(mainitem,"Sound")
    If UM_Database()\UM_MT32 
      SetXMLNodeText(item,"Paula / MT32")
    Else
      SetXMLNodeText(item,"Paula")
    EndIf
    item=CreateXMLNode(mainitem,"GameFolder") : SetXMLNodeText(item,UM_Database()\UM_Folder)
    item=CreateXMLNode(mainitem,"InstallSize") : SetXMLNodeText(item,Str(UM_Database()\UM_InstallSize))
    item=CreateXMLNode(mainitem,"SlaveName") : SetXMLNodeText(item,UM_Database()\UM_Slave)
    item=CreateXMLNode(mainitem,"SlaveDate") : SetXMLNodeText(item,UM_Database()\UM_Slave_Date)
    item=CreateXMLNode(mainitem,"SlaveVersion") : SetXMLNodeText(item,UM_Database()\UM_Version)
    item=CreateXMLNode(mainitem,"GameIcon") : SetXMLNodeText(item,UM_Database()\UM_Icon)
    
    If UM_Database()\UM_Type="Game" : path="games" : EndIf
    If UM_Database()\UM_Type="Demo" : path="demos" : EndIf
    If UM_Database()\UM_Type="Magazine" : path="mags" : EndIf
    If UM_Database()\UM_WHD_Entry<>""
      item=CreateXMLNode(mainitem,"WHDLoadDE") : SetXMLNodeText(item,"http://www.whdload.de/"+path+"/"+UM_Database()\UM_WHD_Entry+".html")
    Else
      item=CreateXMLNode(mainitem,"WHDLoadDE") : SetXMLNodeText(item,"")
    EndIf
    If UM_Database()\UM_HOL_Entry<>""
      item=CreateXMLNode(mainitem,"HallOfLight") : SetXMLNodeText(item,"http://hol.abime.net/"+UM_Database()\UM_HOL_Entry)
    Else
      item=CreateXMLNode(mainitem,"HallOfLight") : SetXMLNodeText(item,"")
    EndIf
    If UM_Database()\UM_HOL_Entry_New<>""
      item=CreateXMLNode(mainitem,"HallOfLightNew") : SetXMLNodeText(item,"https://amiga.abime.net/games/view/"+UM_Database()\UM_HOL_Entry_New)
    Else
      item=CreateXMLNode(mainitem,"HallOfLightNew") : SetXMLNodeText(item,"")
    EndIf
    If UM_Database()\UM_Lemon_Entry<>""
      item=CreateXMLNode(mainitem,"LemonAmiga") : SetXMLNodeText(item,"https://www.lemonamiga.com/games/details.php?id="+UM_Database()\UM_Lemon_Entry)
    Else
      item=CreateXMLNode(mainitem,"LemonAmiga") : SetXMLNodeText(item,"")
    EndIf
    If UM_Database()\UM_Pouet<>""
      item=CreateXMLNode(mainitem,"Pouet") : SetXMLNodeText(item,"https://www.pouet.net/prod.php?which="+UM_Database()\UM_Pouet)
    Else
      item=CreateXMLNode(mainitem,"Pouet") : SetXMLNodeText(item,"")
    EndIf
    If UM_Database()\UM_Janeway<>""
      item=CreateXMLNode(mainitem,"Bitworld") : SetXMLNodeText(item,"http://janeway.exotica.org.uk/release.php?id="+UM_Database()\UM_Janeway)
    Else
      item=CreateXMLNode(mainitem,"Bitworld") : SetXMLNodeText(item,"")
    EndIf
    If UM_Database()\UM_Type="Game" : path2="Commodore_Amiga_-_WHDLoad_-_Games/" : EndIf 
    If UM_Database()\UM_Type="Demo" : path2="Commodore_Amiga_-_WHDLoad_-_Demos/" : EndIf 
    If UM_Database()\UM_Type="Beta" And UM_Database()\UM_Beta_Type="Game" : path2="Commodore_Amiga_-_WHDLoad_-_Games_-_Beta_&_Unreleased/" : EndIf 
    If UM_Database()\UM_Type="Beta" And UM_Database()\UM_Beta_Type="Demo" : path2="Commodore_Amiga_-_WHDLoad_-_Demos_-_Beta_&_Unreleased/" : EndIf 
    If UM_Database()\UM_Type="Magazine" : path2="Commodore_Amiga_-_WHDLoad_-_Magazines/" : EndIf 
    item=CreateXMLNode(mainitem,"Turran") : SetXMLNodeText(item,"https://ftp2.grandis.nu/turran/FTP/Retroplay%20WHDLoad%20Packs/"+path2+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_LHAFile)
  Next  
  
  FormatXML(xml_file,#PB_XML_WindowsNewline|#PB_XML_ReFormat,4)
  SaveXML(xml_file,Home_Path+"WHDLoad_Database.xml")
  
  If CreateFile(0,Home_Path+"WHDLoad_Database.csv",#PB_Ascii)
    
    ForEach UM_Database()
      path=""
      path+UM_Database()\UM_Title+Tags()+";"
      path+UM_Database()\UM_Short+";"
      path+UM_Database()\UM_Type+";"
      If UM_Database()\UM_CD32 : path+"CD32;" : EndIf
      If UM_Database()\UM_CDTV : path+"CDTV;" : EndIf
      If UM_Database()\UM_Arcadia : path+"Arcadia;" : EndIf
      If Not UM_Database()\UM_CD32 And Not UM_Database()\UM_CDTV And Not UM_Database()\UM_Arcadia : path+"Amiga;" : EndIf
      path+UM_Database()\UM_Genre+";"
      path+UM_Database()\UM_Publisher+";"
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Type="Beta"
        path+UM_Database()\UM_Developer+";"
      Else
        path+";"
      EndIf
      path+UM_Database()\UM_Party+";"
      path+UM_Database()\UM_Year+";"
      path+UM_Database()\UM_Language+";"
      path+UM_Database()\UM_Players+";"
      If UM_Database()\UM_ECS : path+"ECS"+";" : EndIf
      If UM_Database()\UM_OCS : path+"OCS"+";" : EndIf
      If UM_Database()\UM_AGA : path+"AGA"+";" : EndIf
      If UM_Database()\UM_NTSC 
        path+"NTSC"+";"
      Else
        path+"PAL"+";"
      EndIf
      If UM_Database()\UM_MT32 
        path+"Paula / MT32"+";"
      Else
        path+"Paula"+";"
      EndIf
      path+UM_Database()\UM_Folder+";"
      path+Str(UM_Database()\UM_InstallSize)+";"
      path+UM_Database()\UM_Slave+";"
      path+UM_Database()\UM_Slave_Date+";"
      path+UM_Database()\UM_Version+";"
      path+UM_Database()\UM_Icon+";"
      path+UM_Database()\UM_LHAFile+";"
      path+UM_Database()\UM_FileSize+";"
      path+UM_Database()\UM_CRC32+";"
      path+UM_Database()\UM_MD5+";"
      path+UM_Database()\UM_SHA1+";"
      Protected path2.s
      If UM_Database()\UM_Type="Game" : path2="games" : EndIf
      If UM_Database()\UM_Type="Demo" : path2="demos" : EndIf
      If UM_Database()\UM_Type="Magazine" : path2="mags" : EndIf
      If UM_Database()\UM_WHD_Entry<>""
        path+"http://www.whdload.de/"+path2+"/"+UM_Database()\UM_WHD_Entry+".html;"
      Else
        path+";"
      EndIf
      If UM_Database()\UM_HOL_Entry<>""
        path+"http://hol.abime.net/"+UM_Database()\UM_HOL_Entry+";"
      Else
        path+";"
      EndIf
      If UM_Database()\UM_HOL_Entry_New<>""
        path+"https://amiga.abime.net/games/view/"+UM_Database()\UM_HOL_Entry_New+";"
      Else
        path+";"
      EndIf
      If UM_Database()\UM_Lemon_Entry<>""
        path+"https://www.lemonamiga.com/games/details.php?id="+UM_Database()\UM_Lemon_Entry+";"
      Else
        path+";"
      EndIf
      If UM_Database()\UM_Pouet<>""
        path+"https://www.pouet.net/prod.php?which="+UM_Database()\UM_Pouet+";"
      Else
        path+";"
      EndIf
      If UM_Database()\UM_Janeway<>""
        path+"http://janeway.exotica.org.uk/release.php?id="+UM_Database()\UM_Janeway+";"
      Else
        path+";"
      EndIf
      If UM_Database()\UM_Type="Game" : path2="Commodore_Amiga_-_WHDLoad_-_Games/" : EndIf 
      If UM_Database()\UM_Type="Demo" : path2="Commodore_Amiga_-_WHDLoad_-_Demos/" : EndIf 
      If UM_Database()\UM_Type="Beta" And UM_Database()\UM_Beta_Type="Game" : path2="Commodore_Amiga_-_WHDLoad_-_Games_-_Beta_&_Unreleased/" : EndIf 
      If UM_Database()\UM_Type="Beta" And UM_Database()\UM_Beta_Type="Demo" : path2="Commodore_Amiga_-_WHDLoad_-_Demos_-_Beta_&_Unreleased/" : EndIf 
      If UM_Database()\UM_Type="Magazine" : path2="Commodore_Amiga_-_WHDLoad_-_Magazines/" : EndIf 
      path+"https://ftp2.grandis.nu/turran/FTP/Retroplay%20WHDLoad%20Packs/"+path2+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_LHAFile+#LF$
      WriteString(0,path)
    Next
    
    CloseFile(0)
    
  EndIf
  
  FreeList(Export_List())
  
EndProcedure

Procedure Write_Guide_Single(Outpath.s,ags.b)
   
 SelectElement(UM_Database(),List_Numbers()\L_Number)
  
  CreateDirectory(Outpath+"Search.ags")
  CreateDirectory(outpath+"Search.ags\WHD-Data")
  CreateDirectory(outpath+"Search.ags\WHD-Data\"+UM_Database()\UM_Type)
  
  Outpath=outpath+"Search.ags\WHD-Data\"+UM_Database()\UM_Type+"\"
  
  If UM_Database()\UM_Restricted<>#True
    If CreateFile(0,outpath+UM_Database()\UM_Short+Tags_Short()+".guide",#PB_Ascii)
      WriteString(0,"@database"+#LF$)
      WriteString(0,"@wordwrap"+#LF$)
      WriteString(0,""+#LF$)
      
      WriteString(0,"@node Main"+#LF$)
      WriteString(0,"@{b}"+UM_Database()\UM_Title+Tags()+#LF$)
      WriteString(0,"@{b}"+LSet("",Len(UM_Database()\UM_Title+Tags()),"-")+"@{ub}"+#LF$)
      WriteString(0,""+#LF$) 
      WriteString(0,"@{b}Short Title@{ub}  : "+UM_Database()\UM_Short+#LF$)
      If UM_Database()\UM_Type="Beta"
        WriteString(0,"@{b}Status@{ub}       : Beta & Unreleased"+#LF$)
      Else
        WriteString(0,"@{b}Status@{ub}       : Full Release"+#LF$)
      EndIf 
      If UM_Database()\UM_CD32
        WriteString(0,"@{b}Hardware@{ub}     : CD32"+#LF$)
      EndIf
      If UM_Database()\UM_Arcadia
        WriteString(0,"@{b}Hardware@{ub}     : Arcadia"+#LF$)
      EndIf
      If UM_Database()\UM_CDTV
        WriteString(0,"@{b}Hardware@{ub}     : CDTV"+#LF$)
      EndIf 
      If UM_Database()\UM_AGA And Not UM_Database()\UM_CD32
        WriteString(0,"@{b}Hardware@{ub}     : Amiga A1200 / A4000"+#LF$)
      EndIf
      If UM_Database()\UM_ECS And Not UM_Database()\UM_CDTV And Not UM_Database()\UM_Arcadia
        WriteString(0,"@{b}Hardware@{ub}     : Amiga A500 / A600 / A2000 / A3000"+#LF$)
      EndIf
      If UM_Database()\UM_OCS And Not UM_Database()\UM_CDTV And Not UM_Database()\UM_Arcadia
        WriteString(0,"@{b}Hardware@{ub}     : Amiga A1000 / A500 / A2000"+#LF$)
      EndIf
      WriteString(0,"@{b}Genre@{ub}        : "+UM_Database()\UM_Genre+#LF$)
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Type="Beta" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{b}Publisher@{ub}    : "+UM_Database()\UM_Publisher+#LF$)
      EndIf
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{b}Group@{ub}        : "+UM_Database()\UM_Publisher+#LF$)
      EndIf
      If UM_Database()\UM_Type="Game"  Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{b}Developer@{ub}    : "+UM_Database()\UM_Developer+#LF$)
      EndIf
      WriteString(0,"@{b}Year@{ub}         : "+UM_Database()\UM_Year+#LF$)
      WriteString(0,"@{b}Language@{ub}     : "+UM_Database()\UM_Language+#LF$)
      WriteString(0,"@{b}Players@{ub}      : "+UM_Database()\UM_Players+#LF$)
      If UM_Database()\UM_AGA
        WriteString(0,"@{b}Chipset@{ub}      : AGA"+#LF$)
      EndIf
      If UM_Database()\UM_ECS
        WriteString(0,"@{b}Chipset@{ub}      : ECS"+#LF$)
      EndIf
      If UM_Database()\UM_OCS
        WriteString(0,"@{b}Chipset@{ub}      : OCS"+#LF$)
      EndIf
      If UM_Database()\UM_NTSC
        WriteString(0,"@{b}TV System@{ub}    : NTSC"+#LF$)
      EndIf
      If UM_Database()\UM_NTSC<>#True
        WriteString(0,"@{b}TV System@{ub}    : PAL"+#LF$)
      EndIf
      If UM_Database()\UM_MT32
        WriteString(0,"@{b}Sound@{ub}        : Paula / MT32"+#LF$)
      Else
        WriteString(0,"@{b}Sound@{ub}        : Paula"+#LF$)
      EndIf
      WriteString(0,"@{b}Main Folder@{ub}  : "+UM_Database()\UM_Folder+#LF$)
      WriteString(0,"@{b}Install Size@{ub} : "+UM_Database()\UM_InstallSize+#LF$)
      WriteString(0,"@{b}Slave Name@{ub}   : "+UM_Database()\UM_Slave+#LF$)
      WriteString(0,"@{b}Slave Date@{ub}   : "+UM_Database()\UM_Slave_Date+#LF$)
      WriteString(0,"@{b}Slave Version@{ub}: "+UM_Database()\UM_Version+#LF$)
      WriteString(0,"@{b}Main Icon@{ub}    : "+UM_Database()\UM_Icon+#LF$)
      If UM_Database()\UM_SPS<>""
        WriteString(0,"@{b}CAPS Number@{ub}  : "+UM_Database()\UM_SPS+#LF$)
      EndIf
      WriteString(0,"@{b}LHA File@{ub}     : "+UM_Database()\UM_LHAFile+#LF$)
      WriteString(0,"@{b}LHA Size@{ub}     : "+Str(UM_Database()\UM_FileSize)+#LF$)
      If AGS<>#True
        WriteString(0,"@{b}LHA CRC32@{ub}    : "+UM_Database()\UM_CRC32+#LF$)       
        WriteString(0,"@{b}LHA MD5@{ub}      : "+UM_Database()\UM_MD5+#LF$)
        WriteString(0,"@{b}LHA SHA1@{ub}     : "+UM_Database()\UM_SHA1+#LF$)   
      Else
        WriteString(0,""+#LF$)
        WriteString(0,"@{b}AGS Lists@{ub}"+#LF$)
        WriteString(0,"@{b}---------@{ub}"+#LF$)
        If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
          If UM_Database()\UM_Language="English"
            WriteString(0,"+  Games - 0-Z"+#LF$)
            If UM_Database()\UM_Adult : WriteString(0,"+  Games - Adult"+#LF$) : EndIf
            If UM_Database()\UM_AGA : WriteString(0,"+  Games - AGA"+#LF$) : EndIf
            If UM_Database()\UM_Type="Beta" : WriteString(0,"+  Games - Beta"+#LF$) : EndIf
            WriteString(0,"+  Games - By Genre - "+RemoveString(UM_Database()\UM_Genre," /",0)+#LF$)
            WriteString(0,"+  Games - By Publisher - "+UM_Database()\UM_Publisher+#LF$)
            If UM_Database()\UM_CD32 : WriteString(0,"+  Games - By System - CD32"+#LF$) : EndIf
            If UM_Database()\UM_CDTV : WriteString(0,"+  Games - By System - CDTV"+#LF$) : EndIf
            If UM_Database()\UM_Arcadia : WriteString(0,"+  Games - By System - Arcadia"+#LF$) : EndIf
            WriteString(0,"+  Games - By Year - "+UM_Database()\UM_Year+#LF$)
            If FindString(UM_Database()\UM_Title,"Emerald") : WriteString(0,"+  Games - Emerald Mines"+#LF$) : EndIf
            If UM_Database()\UM_MT32 : WriteString(0,"+  Games - MT32"+#LF$) : EndIf
            If UM_Database()\UM_Players="2" : WriteString(0,"+  Games - Multiplayer - 2 Players"+#LF$) : EndIf
            If UM_Database()\UM_Players="3" : WriteString(0,"+  Games - Multiplayer - 3 Players"+#LF$) : EndIf
            If UM_Database()\UM_Players="4" : WriteString(0,"+  Games - Multiplayer - 4 Players"+#LF$) : EndIf
            If UM_Database()\UM_Players<>"1" And UM_Database()\UM_Players<>"2" And UM_Database()\UM_Players<>"3" And UM_Database()\UM_Players<>"4" : WriteString(0,"+  Games - Multiplayer - 5+ Players"+#LF$) : EndIf
            If UM_Database()\UM_NTSC : WriteString(0,"+  Games - NTSC"+#LF$) : EndIf
          Else
            WriteString(0,"+  Games - Non English - "+UM_Database()\UM_Language+#LF$)
          EndIf
        EndIf
        If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Beta_Type="Demo"
          WriteString(0,"-  Demos - 0-Z"+#LF$)
          If UM_Database()\UM_Adult : WriteString(0,"-  Demos - Adult"+#LF$) : EndIf
          If UM_Database()\UM_AGA : WriteString(0,"-  Demos - AGA"+#LF$) : EndIf
          WriteString(0,"-  Demos - By Genre - "+RemoveString(UM_Database()\UM_Genre," /",0)+#LF$)
          WriteString(0,"-  Demos - By Group - "+UM_Database()\UM_Publisher+#LF$)
          WriteString(0,"-  Demos - By Year - "+UM_Database()\UM_Year+#LF$)
        EndIf
        If UM_Database()\UM_Type="Magazine"
          WriteString(0,"- Disk Magazines"+UM_Database()\UM_Language+#LF$)
        EndIf
      EndIf
      
      WriteString(0,""+#LF$)
      
      If UM_Database()\UM_WHD_Entry<>""
        If UM_Database()\UM_Type="Game"
          WriteString(0,"@{b}WHDLoad.de@{ub}   : http://www.whdload.de/games/"+UM_Database()\UM_WHD_Entry+".html"+#LF$)
        EndIf
        If UM_Database()\UM_Type="Demo"
          WriteString(0,"@{b}WHDLoad.de@{ub}   : http://www.whdload.de/demos/"+UM_Database()\UM_WHD_Entry+".html"+#LF$)
        EndIf         
        If UM_Database()\UM_Type="Magazine"
          WriteString(0,"@{b}WHDLoad.de@{ub}   : http://www.whdload.de/mags/"+UM_Database()\UM_WHD_Entry+".html"+#LF$)
        EndIf
      EndIf
      
      If UM_Database()\UM_HOL_Entry<>""
        WriteString(0,"@{b}HOL (Old)@{ub}    : http://hol.abime.net/"+UM_Database()\UM_HOL_Entry+#LF$)
      EndIf
      
      If UM_Database()\UM_HOL_Entry_New<>""
        WriteString(0,"@{b}HOL (New)@{ub}    : https://amiga.abime.net/games/view/"+UM_Database()\UM_HOL_Entry_New+#LF$)
      EndIf
      
      If UM_Database()\UM_Lemon_Entry<>""
        WriteString(0,"@{b}Lemon Amiga@{ub}  : https://www.lemonamiga.com/games/details.php?id="+UM_Database()\UM_Lemon_Entry+#LF$)
      EndIf
      
      If UM_Database()\UM_Pouet<>""
        WriteString(0,"@{b}Pouet@{ub}        : https://www.pouet.net/prod.php?which="+UM_Database()\UM_Pouet+#LF$)
      EndIf
      
      If UM_Database()\UM_Janeway<>""
        WriteString(0,"@{b}Bitworld@{ub}     : http://janeway.exotica.org.uk/release.php?id="+UM_Database()\UM_Janeway+#LF$)
      EndIf
      
      If UM_Database()\UM_Type="Game" : path2="Commodore_Amiga_-_WHDLoad_-_Games/" : EndIf 
      If UM_Database()\UM_Type="Demo" : path2="Commodore_Amiga_-_WHDLoad_-_Demos/" : EndIf 
      If UM_Database()\UM_Type="Beta" And UM_Database()\UM_Beta_Type="Game" : path2="Commodore_Amiga_-_WHDLoad_-_Games_-_Beta_&_Unreleased/" : EndIf 
      If UM_Database()\UM_Type="Beta" And UM_Database()\UM_Beta_Type="Demo" : path2="Commodore_Amiga_-_WHDLoad_-_Demos_-_Beta_&_Unreleased/" : EndIf 
      If UM_Database()\UM_Type="Magazine" : path2="Commodore_Amiga_-_WHDLoad_-_Magazines/" : EndIf 
      
      WriteString(0,"@{b}Turran@{ub}       : https://ftp2.grandis.nu/turran/FTP/Retroplay%20WHDLoad%20Packs/"+path2+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_LHAFile+#LF$)
      
      WriteString(0,"@endnode"+#LF$) 
      CloseFile(0)
    Else
      MessageRequester("Error","Cannot create guide for "+UM_Database()\UM_Title+Tags()+"...")
    EndIf   
  EndIf
  
EndProcedure

Procedure Write_Guides(outpath.s,ags.b)
  
  Protected out_folder.s
  
  If ags : Outpath+"Search.ags\" : EndIf
  
  CreateDirectory(Outpath)
  CreateDirectory(outpath+"WHD-Data")
  CreateDirectory(outpath+"WHD-Data\Game")
  CreateDirectory(outpath+"WHD-Data\Beta")
  CreateDirectory(outpath+"WHD-Data\Magazine")
  CreateDirectory(outpath+"WHD-Data\Demo")
  
  ForEach UM_Database()
    
    out_folder=UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"
    
    If UM_Database()\UM_Restricted<>#True
      If CreateFile(0,outpath+"WHD-Data\"+UM_Database()\UM_Type+"\"+UM_Database()\UM_Short+Tags_Short()+".guide",#PB_Ascii)
        
        WriteString(0,"@database"+#LF$)
        WriteString(0,"@wordwrap"+#LF$)
        WriteString(0,""+#LF$)
        
        WriteString(0,"@node Main"+#LF$)
        WriteString(0,"@{b}"+UM_Database()\UM_Title+Tags()+#LF$)
        WriteString(0,"@{b}"+LSet("",Len(UM_Database()\UM_Title+Tags()),"-")+"@{ub}"+#LF$)
        WriteString(0,""+#LF$) 
        WriteString(0,"@{b}Short Title@{ub}  : "+UM_Database()\UM_Short+#LF$)
        If UM_Database()\UM_Type="Beta"
          WriteString(0,"@{b}Status@{ub}       : Beta & Unreleased"+#LF$)
        Else
          WriteString(0,"@{b}Status@{ub}       : Full Release"+#LF$)
        EndIf 
        If UM_Database()\UM_CD32
          WriteString(0,"@{b}Hardware@{ub}     : CD32"+#LF$)
        EndIf
        If UM_Database()\UM_Arcadia
          WriteString(0,"@{b}Hardware@{ub}     : Arcadia"+#LF$)
        EndIf
        If UM_Database()\UM_CDTV
          WriteString(0,"@{b}Hardware@{ub}     : CDTV"+#LF$)
        EndIf 
        If UM_Database()\UM_AGA And Not UM_Database()\UM_CD32
          WriteString(0,"@{b}Hardware@{ub}     : Amiga A1200 / A4000"+#LF$)
        EndIf
        If UM_Database()\UM_ECS And Not UM_Database()\UM_CDTV And Not UM_Database()\UM_Arcadia
          WriteString(0,"@{b}Hardware@{ub}     : Amiga A500 / A600 / A2000 / A3000"+#LF$)
        EndIf
        If UM_Database()\UM_OCS And Not UM_Database()\UM_CDTV And Not UM_Database()\UM_Arcadia
          WriteString(0,"@{b}Hardware@{ub}     : Amiga A1000 / A500 / A2000"+#LF$)
        EndIf
        WriteString(0,"@{b}Genre@{ub}        : "+UM_Database()\UM_Genre+#LF$)
        If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Type="Beta" Or UM_Database()\UM_Beta_Type="Game"
          WriteString(0,"@{b}Publisher@{ub}    : "+UM_Database()\UM_Publisher+#LF$)
        EndIf
        If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
          WriteString(0,"@{b}Group@{ub}        : "+UM_Database()\UM_Publisher+#LF$)
        EndIf
        If UM_Database()\UM_Type="Game"  Or UM_Database()\UM_Beta_Type="Game"
          WriteString(0,"@{b}Developer@{ub}    : "+UM_Database()\UM_Developer+#LF$)
        EndIf
        WriteString(0,"@{b}Year@{ub}         : "+UM_Database()\UM_Year+#LF$)
        WriteString(0,"@{b}Language@{ub}     : "+UM_Database()\UM_Language+#LF$)
        WriteString(0,"@{b}Players@{ub}      : "+UM_Database()\UM_Players+#LF$)
        If UM_Database()\UM_AGA
          WriteString(0,"@{b}Chipset@{ub}      : AGA"+#LF$)
        EndIf
        If UM_Database()\UM_ECS
          WriteString(0,"@{b}Chipset@{ub}      : ECS"+#LF$)
        EndIf
        If UM_Database()\UM_OCS
          WriteString(0,"@{b}Chipset@{ub}      : OCS"+#LF$)
        EndIf
        If UM_Database()\UM_NTSC
          WriteString(0,"@{b}TV System@{ub}    : NTSC"+#LF$)
        EndIf
        If UM_Database()\UM_NTSC<>#True
          WriteString(0,"@{b}TV System@{ub}    : PAL"+#LF$)
        EndIf
        If UM_Database()\UM_MT32
          WriteString(0,"@{b}Sound@{ub}        : Paula / MT32"+#LF$)
        Else
          WriteString(0,"@{b}Sound@{ub}        : Paula"+#LF$)
        EndIf
        WriteString(0,"@{b}Main Folder@{ub}  : "+UM_Database()\UM_Folder+#LF$)
        WriteString(0,"@{b}Install Size@{ub} : "+UM_Database()\UM_InstallSize+#LF$)
        WriteString(0,"@{b}Slave Name@{ub}   : "+UM_Database()\UM_Slave+#LF$)
        WriteString(0,"@{b}Slave Date@{ub}   : "+UM_Database()\UM_Slave_Date+#LF$)
        WriteString(0,"@{b}Slave Version@{ub}: "+UM_Database()\UM_Version+#LF$)
        WriteString(0,"@{b}Main Icon@{ub}    : "+UM_Database()\UM_Icon+#LF$)
        If UM_Database()\UM_SPS<>""
          WriteString(0,"@{b}CAPS Number@{ub}  : "+UM_Database()\UM_SPS+#LF$)
        EndIf
        WriteString(0,"@{b}LHA File@{ub}     : "+UM_Database()\UM_LHAFile+#LF$)
        WriteString(0,"@{b}LHA Size@{ub}     : "+Str(UM_Database()\UM_FileSize)+#LF$)
        If AGS<>#True
          WriteString(0,"@{b}LHA CRC32@{ub}    : "+UM_Database()\UM_CRC32+#LF$)       
          WriteString(0,"@{b}LHA MD5@{ub}      : "+UM_Database()\UM_MD5+#LF$)
          WriteString(0,"@{b}LHA SHA1@{ub}     : "+UM_Database()\UM_SHA1+#LF$)   
        Else
          WriteString(0,""+#LF$)
          WriteString(0,"@{b}AGS Lists@{ub}"+#LF$)
          WriteString(0,"@{b}---------@{ub}"+#LF$)
          If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
            If UM_Database()\UM_Language="English"
              WriteString(0,"+  Games - 0-Z"+#LF$)
              If UM_Database()\UM_Adult : WriteString(0,"+  Games - Adult"+#LF$) : EndIf
              If UM_Database()\UM_AGA : WriteString(0,"+  Games - AGA"+#LF$) : EndIf
              If UM_Database()\UM_Type="Beta" : WriteString(0,"+  Games - Beta"+#LF$) : EndIf
              WriteString(0,"+  Games - By Genre - "+RemoveString(UM_Database()\UM_Genre," /",0)+#LF$)
              WriteString(0,"+  Games - By Publisher - "+UM_Database()\UM_Publisher+#LF$)
              If UM_Database()\UM_CD32 : WriteString(0,"+  Games - By System - CD32"+#LF$) : EndIf
              If UM_Database()\UM_CDTV : WriteString(0,"+  Games - By System - CDTV"+#LF$) : EndIf
              If UM_Database()\UM_Arcadia : WriteString(0,"+  Games - By System - Arcadia"+#LF$) : EndIf
              WriteString(0,"+  Games - By Year - "+UM_Database()\UM_Year+#LF$)
              If FindString(UM_Database()\UM_Title,"Emerald") : WriteString(0,"+  Games - Emerald Mines"+#LF$) : EndIf
              If UM_Database()\UM_MT32 : WriteString(0,"+  Games - MT32"+#LF$) : EndIf
              If UM_Database()\UM_Players="2" : WriteString(0,"+  Games - Multiplayer - 2 Players"+#LF$) : EndIf
              If UM_Database()\UM_Players="3" : WriteString(0,"+  Games - Multiplayer - 3 Players"+#LF$) : EndIf
              If UM_Database()\UM_Players="4" : WriteString(0,"+  Games - Multiplayer - 4 Players"+#LF$) : EndIf
              If UM_Database()\UM_Players<>"1" And UM_Database()\UM_Players<>"2" And UM_Database()\UM_Players<>"3" And UM_Database()\UM_Players<>"4" : WriteString(0,"+  Games - Multiplayer - 5+ Players"+#LF$) : EndIf
              If UM_Database()\UM_NTSC : WriteString(0,"+  Games - NTSC"+#LF$) : EndIf
            Else
              WriteString(0,"+  Games - Non English - "+UM_Database()\UM_Language+#LF$)
            EndIf
          EndIf
          If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Beta_Type="Demo"
            WriteString(0,"-  Demos - 0-Z"+#LF$)
            If UM_Database()\UM_Adult : WriteString(0,"-  Demos - Adult"+#LF$) : EndIf
            If UM_Database()\UM_AGA : WriteString(0,"-  Demos - AGA"+#LF$) : EndIf
            WriteString(0,"-  Demos - By Genre - "+RemoveString(UM_Database()\UM_Genre," /",0)+#LF$)
            WriteString(0,"-  Demos - By Group - "+UM_Database()\UM_Publisher+#LF$)
            WriteString(0,"-  Demos - By Year - "+UM_Database()\UM_Year+#LF$)
          EndIf
          If UM_Database()\UM_Type="Magazine"
            WriteString(0,"- Disk Magazines"+UM_Database()\UM_Language+#LF$)
          EndIf
        EndIf
        
        WriteString(0,""+#LF$)
        
        If UM_Database()\UM_WHD_Entry<>""
          If UM_Database()\UM_Type="Game"
            WriteString(0,"@{b}WHDLoad.de@{ub}   : http://www.whdload.de/games/"+UM_Database()\UM_WHD_Entry+".html"+#LF$)
          EndIf
          If UM_Database()\UM_Type="Demo"
            WriteString(0,"@{b}WHDLoad.de@{ub}   : http://www.whdload.de/demos/"+UM_Database()\UM_WHD_Entry+".html"+#LF$)
          EndIf         
          If UM_Database()\UM_Type="Magazine"
            WriteString(0,"@{b}WHDLoad.de@{ub}   : http://www.whdload.de/mags/"+UM_Database()\UM_WHD_Entry+".html"+#LF$)
          EndIf
        EndIf
        
        If UM_Database()\UM_HOL_Entry<>""
          WriteString(0,"@{b}HOL (Old)@{ub}    : http://hol.abime.net/"+UM_Database()\UM_HOL_Entry+#LF$)
        EndIf
        
        If UM_Database()\UM_HOL_Entry_New<>""
          WriteString(0,"@{b}HOL (New)@{ub}    : https://amiga.abime.net/games/view/"+UM_Database()\UM_HOL_Entry_New+#LF$)
        EndIf
        
        If UM_Database()\UM_Lemon_Entry<>""
          WriteString(0,"@{b}Lemon Amiga@{ub}  : https://www.lemonamiga.com/games/details.php?id="+UM_Database()\UM_Lemon_Entry+#LF$)
        EndIf
        
        If UM_Database()\UM_Pouet<>""
          WriteString(0,"@{b}Pouet@{ub}        : https://www.pouet.net/prod.php?which="+UM_Database()\UM_Pouet+#LF$)
        EndIf
        
        If UM_Database()\UM_Janeway<>""
          WriteString(0,"@{b}Bitworld@{ub}     : http://janeway.exotica.org.uk/release.php?id="+UM_Database()\UM_Janeway+#LF$)
        EndIf
        
        If UM_Database()\UM_Type="Game" : path2="Commodore_Amiga_-_WHDLoad_-_Games/" : EndIf 
        If UM_Database()\UM_Type="Demo" : path2="Commodore_Amiga_-_WHDLoad_-_Demos/" : EndIf 
        If UM_Database()\UM_Type="Beta" And UM_Database()\UM_Beta_Type="Game" : path2="Commodore_Amiga_-_WHDLoad_-_Games_-_Beta_&_Unreleased/" : EndIf 
        If UM_Database()\UM_Type="Beta" And UM_Database()\UM_Beta_Type="Demo" : path2="Commodore_Amiga_-_WHDLoad_-_Demos_-_Beta_&_Unreleased/" : EndIf 
        If UM_Database()\UM_Type="Magazine" : path2="Commodore_Amiga_-_WHDLoad_-_Magazines/" : EndIf 
        
        WriteString(0,"@{b}Turran@{ub}       : https://ftp2.grandis.nu/turran/FTP/Retroplay%20WHDLoad%20Packs/"+path2+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_LHAFile+#LF$)
        
        WriteString(0,"@endnode"+#LF$) 
        CloseFile(0)
      EndIf   
    EndIf
  Next
  
EndProcedure

Procedure Make_Lazybench_Menu()
  
  path=""
  
  If CreateFile(#FILE,Home_Path+"LazyBench.menu",#PB_Ascii)
    ForEach UM_Database()
      
      If UM_Database()\UM_AGA
        Continue
      EndIf
      
      If UM_Database()\UM_CD32
        Continue
      EndIf
      
      If UM_Database()\UM_CDROM
        Continue
      EndIf
      
      path+"AGS_Drive:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+"/"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+#LF$
    Next
    WriteString(#FILE,path)
    CloseFile(#FILE)
  EndIf
  
EndProcedure

Procedure Make_Retroarch_Dat()
  
  UseMD5Fingerprint()
  
  Protected outstring.s
  
  outstring+"clrmamepro ("+#LF$
  outstring+"        name "+#DOUBLEQUOTE$+"Commodore - Amiga - WHDLoad"+#DOUBLEQUOTE$+#LF$
  outstring+"        description "+#DOUBLEQUOTE$+"Commodore - Amiga - WHDLoad"+#DOUBLEQUOTE$+#LF$
  outstring+"        date "+#DOUBLEQUOTE$+FormatDate("%yyyy-%mm-%dd",Date())+#DOUBLEQUOTE$+#LF$
  outstring+"        author "+#DOUBLEQUOTE$+"MrV2k"+#DOUBLEQUOTE$+#LF$
  outstring+"        comment "+#DOUBLEQUOTE$+"Retroplay"+#DOUBLEQUOTE$+#LF$
  outstring+")"+#LF$
  
  ForEach UM_Database()
    If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
      If UM_Database()\UM_Intro : Continue : EndIf
      If UM_Database()\UM_Data_Disk : Continue : EndIf
      If UM_Database()\UM_Genre="Misc / Editor" : Continue : EndIf
      If UM_Database()\UM_Genre="Misc / Utility" : Continue : EndIf
      outstring+""+#LF$
      outstring+"game ("+#LF$
      outstring+"        name "+#DOUBLEQUOTE$+UM_Database()\UM_Title+Tags()+#DOUBLEQUOTE$+#LF$
      outstring+"        description "+#DOUBLEQUOTE$+UM_Database()\UM_Title+Tags()+#DOUBLEQUOTE$+#LF$
      outstring+"        rom ( name "+#DOUBLEQUOTE$+UM_Database()\UM_LHAFile+#DOUBLEQUOTE$+" size "+Str(UM_Database()\UM_FileSize)+" crc "+UCase(UM_Database()\UM_CRC32)+" md5 "+UCase(UM_Database()\UM_MD5)+" sha1 "+UM_Database()\UM_SHA1+" )"+#LF$
      outstring+")"+#LF$
    EndIf
  Next
  
  DeleteFile(Home_Path+"Commodore - Amiga.dat")
  
  If CreateFile(#FILE,Home_Path+"Commodore - Amiga.dat",#PB_Ascii)
    WriteString(#FILE,outstring,#PB_Ascii)
    CloseFile(#FILE)
  EndIf
  
EndProcedure
  
Procedure Make_AGS_Demos_Guide(outpath.s,ags.b,ecs.b)
  
  NewList sort_list.sort_struc2()
  
  AddElement(sort_list())
  
  ForEach UM_Database()
    If ECS
      If UM_Database()\UM_AGA
        Continue
      EndIf
      If UM_Database()\UM_CD32
        Continue
      EndIf
    EndIf
    Select LCase(Left(UM_Database()\UM_Title,1))
      Case "0","1","2","3","4","5","6","7","8","9"
        AddElement(sort_list()\nums())
        sort_list()\nums()=ListIndex(UM_Database())
      Case "a"
        AddElement(sort_list()\a())
        sort_list()\a()=ListIndex(UM_Database())
      Case "b"
        AddElement(sort_list()\b())
        sort_list()\b()=ListIndex(UM_Database())
      Case "c"
        AddElement(sort_list()\c())
        sort_list()\c()=ListIndex(UM_Database())
      Case "d"
        AddElement(sort_list()\d())
        sort_list()\d()=ListIndex(UM_Database())
      Case "e"
        AddElement(sort_list()\e())
        sort_list()\e()=ListIndex(UM_Database())
      Case "f"
        AddElement(sort_list()\f())
        sort_list()\f()=ListIndex(UM_Database())  
      Case "g"
        AddElement(sort_list()\g())
        sort_list()\g()=ListIndex(UM_Database())
      Case "h"
        AddElement(sort_list()\h())
        sort_list()\h()=ListIndex(UM_Database())
      Case "i"
        AddElement(sort_list()\i())
        sort_list()\i()=ListIndex(UM_Database())
      Case "j"
        AddElement(sort_list()\j())
        sort_list()\j()=ListIndex(UM_Database())
      Case "k"
        AddElement(sort_list()\k())
        sort_list()\k()=ListIndex(UM_Database())
      Case "l"
        AddElement(sort_list()\l())
        sort_list()\l()=ListIndex(UM_Database())
      Case "m"
        AddElement(sort_list()\m())
        sort_list()\m()=ListIndex(UM_Database())
      Case "n"
        AddElement(sort_list()\n())
        sort_list()\n()=ListIndex(UM_Database())
      Case "o"
        AddElement(sort_list()\o())
        sort_list()\o()=ListIndex(UM_Database())
      Case "p"
        AddElement(sort_list()\p())
        sort_list()\p()=ListIndex(UM_Database())
      Case "q"
        AddElement(sort_list()\q())
        sort_list()\q()=ListIndex(UM_Database())
      Case "r"
        AddElement(sort_list()\r())
        sort_list()\r()=ListIndex(UM_Database())
      Case "s"
        AddElement(sort_list()\s())
        sort_list()\s()=ListIndex(UM_Database())
      Case "t"
        AddElement(sort_list()\t())
        sort_list()\t()=ListIndex(UM_Database())
      Case "u"
        AddElement(sort_list()\u())
        sort_list()\u()=ListIndex(UM_Database())
      Case "v"
        AddElement(sort_list()\v())
        sort_list()\v()=ListIndex(UM_Database())
      Case "w"
        AddElement(sort_list()\w())
        sort_list()\w()=ListIndex(UM_Database())
      Case "x"
        AddElement(sort_list()\x())
        sort_list()\x()=ListIndex(UM_Database())
      Case "y"
        AddElement(sort_list()\y())
        sort_list()\y()=ListIndex(UM_Database())
      Case "z"
        AddElement(sort_list()\z())
        sort_list()\z()=ListIndex(UM_Database())
    EndSelect
  Next
  
  SelectElement(sort_list(),0)
  
  If FileSize(outpath)>0 : DeleteFile(outpath) : EndIf
  
  If CreateFile(0,outpath,#PB_Ascii)
    
    WriteString(0,"@database"+#LF$)
    WriteString(0,"@wordwrap"+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@node Main "+#DOUBLEQUOTE$+"Main Index"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    If ags
      WriteString(0,"@{b}           Amiga Game Selector WHDLoad Database@{ub}"+#LF$)
      WriteString(0,"@{b}           ------------------------------------@{ub}"+#LF$)
    Else
      WriteString(0,"@{b}           Welcome to MrV2k's WHDLoad Database@{ub}"+#LF$)
      WriteString(0,"@{b}           -----------------------------------@{ub}"+#LF$)
    EndIf
    WriteString(0,""+#LF$)
    WriteString(0,"This Amigaguide database is based on the awesome WHDLoad collection"+#LF$)
    Protected Build.s=FormatDate("%dd-%mm-%yy", Date())
    WriteString(0,"by Retroplay. This document is up to date as of "+build+". The games"+#LF$)
    WriteString(0,"and demos have been split alphabetically and there is a button next "+#LF$)
    WriteString(0,"to each entry that will show the game information."+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"The information included has been collated from several sources"+#LF$)
    WriteString(0,"including the Hall Of Light, Lemon Amiga, Moby Games, Open Retro DB,"+#LF$)
    WriteString(0,"WHDLoad.de, Pouet and Janeway/Bitworld. Please show appreciation"+#LF$)
    WriteString(0,"of their hard work by supporting their sites."+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"All software titles are formatted in 'Title, The' for easier searching."+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"WHDLoad Demos (0-9) @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link Demos0}"+#LF$)
    WriteString(0,"WHDLoad Demos  (A)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosA}"+#LF$)
    WriteString(0,"WHDLoad Demos  (B)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosB}"+#LF$)
    WriteString(0,"WHDLoad Demos  (C)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosC}"+#LF$)
    WriteString(0,"WHDLoad Demos  (D)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosD}"+#LF$)
    WriteString(0,"WHDLoad Demos  (E)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosE}"+#LF$)
    WriteString(0,"WHDLoad Demos  (F)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosF}"+#LF$)
    WriteString(0,"WHDLoad Demos  (G)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosG}"+#LF$)
    WriteString(0,"WHDLoad Demos  (H)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosH}"+#LF$)
    WriteString(0,"WHDLoad Demos  (I)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosI}"+#LF$)
    WriteString(0,"WHDLoad Demos  (J)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosJ}"+#LF$)
    WriteString(0,"WHDLoad Demos  (K)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosK}"+#LF$)
    WriteString(0,"WHDLoad Demos  (L)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosL}"+#LF$)
    WriteString(0,"WHDLoad Demos  (M)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosM}"+#LF$)
    WriteString(0,"WHDLoad Demos  (N)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosN}"+#LF$)
    WriteString(0,"WHDLoad Demos  (O)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosO}"+#LF$)
    WriteString(0,"WHDLoad Demos  (P)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosP}"+#LF$)
    WriteString(0,"WHDLoad Demos  (Q)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosQ}"+#LF$)
    WriteString(0,"WHDLoad Demos  (R)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosR}"+#LF$)
    WriteString(0,"WHDLoad Demos  (S)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosS}"+#LF$)
    WriteString(0,"WHDLoad Demos  (T)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosT}"+#LF$)
    WriteString(0,"WHDLoad Demos  (U)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosU}"+#LF$)
    WriteString(0,"WHDLoad Demos  (V)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosV}"+#LF$)
    WriteString(0,"WHDLoad Demos  (W)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosW}"+#LF$)
    WriteString(0,"WHDLoad Demos  (X)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosX}"+#LF$)
    WriteString(0,"WHDLoad Demos  (Y)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosY}"+#LF$)
    WriteString(0,"WHDLoad Demos  (Z)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link DemosZ}"+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"                             Statistics"+#LF$)
    WriteString(0,"                             ----------"+#LF$)
    WriteString(0,""+#LF$)
    
    Protected demos=0, mags=0
    
    ForEach UM_Database()
      If UM_Database()\UM_Type="Demo" : demos+1 : EndIf
      If UM_Database()\UM_Beta_Type="Demo" : demos+1 : EndIf
      If UM_Database()\UM_Type="Magazine" : mags+1 : EndIf
    Next
    
    WriteString(0,"                 Total Demos          : "+Str(demos)+#LF$)
    WriteString(0,"                 Total Disk Magazines : "+Str(mags)+#LF$)
    WriteString(0,"                 Total Entries        : "+Str(mags+demos)+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}                 (c) 2024 Paul Vince (MrV2K)@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"                 (File Created : "+FormatDate("%dd/%mm/%yyyy",Date())+")"+#LF$)
    
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node Demos0"+#LF$)
    WriteString(0,"@title WHDload Demos (0-9)"+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (0-9)@{ub}"+#LF$)
    WriteString(0,"@{b}-------------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\nums()
      SelectElement(UM_Database(),sort_list()\nums())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosA"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (A)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (A)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\a()
      SelectElement(UM_Database(),sort_list()\a())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosB"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (B)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (B)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\b()
      SelectElement(UM_Database(),sort_list()\b())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosC"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (C)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (C)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\c()
      SelectElement(UM_Database(),sort_list()\c())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosD"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (D)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (D)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\d()
      SelectElement(UM_Database(),sort_list()\d())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosE"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (E)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (E)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\e()
      SelectElement(UM_Database(),sort_list()\e())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosF"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (F)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (F)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\f()
      SelectElement(UM_Database(),sort_list()\f())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosG"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (G)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (G)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\g()
      SelectElement(UM_Database(),sort_list()\g())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosH"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (H)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (H)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\h()
      SelectElement(UM_Database(),sort_list()\h())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosI"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (I)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (I)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\i()
      SelectElement(UM_Database(),sort_list()\i())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosJ"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (J)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (J)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\j()
      SelectElement(UM_Database(),sort_list()\j())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosK"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (K)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (K)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\k()
      SelectElement(UM_Database(),sort_list()\k())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosL"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (L)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (L)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\l()
      SelectElement(UM_Database(),sort_list()\l())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosM"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (M)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (M)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\m()
      SelectElement(UM_Database(),sort_list()\m())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosN"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (N)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (N)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\n()
      SelectElement(UM_Database(),sort_list()\n())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosO"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (O)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (O)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\o()
      SelectElement(UM_Database(),sort_list()\o())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosP"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (P)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (P)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\p()
      SelectElement(UM_Database(),sort_list()\p())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosQ"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (Q)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (Q)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\q()
      SelectElement(UM_Database(),sort_list()\q())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosR"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (R)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (R)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\r()
      SelectElement(UM_Database(),sort_list()\r())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosS"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (S)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (S)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\s()
      SelectElement(UM_Database(),sort_list()\s())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosT"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (T)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (T)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\t()
      SelectElement(UM_Database(),sort_list()\t())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosU"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (U)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (U)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\u()
      SelectElement(UM_Database(),sort_list()\u())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosV"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (V)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (V)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\v()
      SelectElement(UM_Database(),sort_list()\v())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosW"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (W)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (W)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\w()
      SelectElement(UM_Database(),sort_list()\w())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosX"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (X)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (X)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\x()
      SelectElement(UM_Database(),sort_list()\x())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosY"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (Y)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (Y)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\y()
      SelectElement(UM_Database(),sort_list()\y())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node DemosZ"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Demos (Z)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Demos (Z)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\z()
      SelectElement(UM_Database(),sort_list()\z())
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    
    WriteString(0,"@endnode"+#LF$)
    
    CloseFile(0)
    
  EndIf
  
  FreeList(sort_list())
  
EndProcedure

Procedure Make_AGS_Guide(outpath.s,ags.b,ecs.b)
  
  NewList sort_list.sort_struc2()
  
  AddElement(sort_list())
  
  ForEach UM_Database()
    If ECS
      If UM_Database()\UM_AGA
        Continue
      EndIf
      If UM_Database()\UM_CD32
        Continue
      EndIf
    EndIf
    Select LCase(Left(UM_Database()\UM_Title,1))
      Case "0","1","2","3","4","5","6","7","8","9"
        AddElement(sort_list()\nums())
        sort_list()\nums()=ListIndex(UM_Database())
      Case "a"
        AddElement(sort_list()\a())
        sort_list()\a()=ListIndex(UM_Database())
      Case "b"
        AddElement(sort_list()\b())
        sort_list()\b()=ListIndex(UM_Database())
      Case "c"
        AddElement(sort_list()\c())
        sort_list()\c()=ListIndex(UM_Database())
      Case "d"
        AddElement(sort_list()\d())
        sort_list()\d()=ListIndex(UM_Database())
      Case "e"
        AddElement(sort_list()\e())
        sort_list()\e()=ListIndex(UM_Database())
      Case "f"
        AddElement(sort_list()\f())
        sort_list()\f()=ListIndex(UM_Database())  
      Case "g"
        AddElement(sort_list()\g())
        sort_list()\g()=ListIndex(UM_Database())
      Case "h"
        AddElement(sort_list()\h())
        sort_list()\h()=ListIndex(UM_Database())
      Case "i"
        AddElement(sort_list()\i())
        sort_list()\i()=ListIndex(UM_Database())
      Case "j"
        AddElement(sort_list()\j())
        sort_list()\j()=ListIndex(UM_Database())
      Case "k"
        AddElement(sort_list()\k())
        sort_list()\k()=ListIndex(UM_Database())
      Case "l"
        AddElement(sort_list()\l())
        sort_list()\l()=ListIndex(UM_Database())
      Case "m"
        AddElement(sort_list()\m())
        sort_list()\m()=ListIndex(UM_Database())
      Case "n"
        AddElement(sort_list()\n())
        sort_list()\n()=ListIndex(UM_Database())
      Case "o"
        AddElement(sort_list()\o())
        sort_list()\o()=ListIndex(UM_Database())
      Case "p"
        AddElement(sort_list()\p())
        sort_list()\p()=ListIndex(UM_Database())
      Case "q"
        AddElement(sort_list()\q())
        sort_list()\q()=ListIndex(UM_Database())
      Case "r"
        AddElement(sort_list()\r())
        sort_list()\r()=ListIndex(UM_Database())
      Case "s"
        AddElement(sort_list()\s())
        sort_list()\s()=ListIndex(UM_Database())
      Case "t"
        AddElement(sort_list()\t())
        sort_list()\t()=ListIndex(UM_Database())
      Case "u"
        AddElement(sort_list()\u())
        sort_list()\u()=ListIndex(UM_Database())
      Case "v"
        AddElement(sort_list()\v())
        sort_list()\v()=ListIndex(UM_Database())
      Case "w"
        AddElement(sort_list()\w())
        sort_list()\w()=ListIndex(UM_Database())
      Case "x"
        AddElement(sort_list()\x())
        sort_list()\x()=ListIndex(UM_Database())
      Case "y"
        AddElement(sort_list()\y())
        sort_list()\y()=ListIndex(UM_Database())
      Case "z"
        AddElement(sort_list()\z())
        sort_list()\z()=ListIndex(UM_Database())
    EndSelect
  Next
  
  SelectElement(sort_list(),0)
  
  If FileSize(outpath)>0 : DeleteFile(outpath) : EndIf
  
  If CreateFile(0,outpath,#PB_Ascii)
    
    WriteString(0,"@database"+#LF$)
    WriteString(0,"@wordwrap"+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@node Main "+#DOUBLEQUOTE$+"Main Index"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    If ags
      WriteString(0,"@{b}           Amiga Game Selector WHDLoad Database@{ub}"+#LF$)
      WriteString(0,"@{b}           ------------------------------------@{ub}"+#LF$)
    Else
      WriteString(0,"@{b}           Welcome to MrV2k's WHDLoad Database@{ub}"+#LF$)
      WriteString(0,"@{b}           -----------------------------------@{ub}"+#LF$)
    EndIf
    WriteString(0,""+#LF$)
    WriteString(0,"This Amigaguide database is based on the awesome WHDLoad collection"+#LF$)
    Protected Build.s=FormatDate("%dd-%mm-%yy", Date())
    WriteString(0,"by Retroplay. This document is up to date as of "+build+". The games"+#LF$)
    WriteString(0,"and demos have been split alphabetically and there is a button next "+#LF$)
    WriteString(0,"to each entry that will show the game information."+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"The information included has been collated from several sources"+#LF$)
    WriteString(0,"including the Hall Of Light, Lemon Amiga, Moby Games, Open Retro DB,"+#LF$)
    WriteString(0,"WHDLoad.de, Pouet and Janeway/Bitworld. Please show appreciation"+#LF$)
    WriteString(0,"of their hard work by supporting their sites."+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"All software titles are formatted in 'Title, The' for easier searching."+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"WHDLoad Games (0-9) @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link Games0}"+#LF$)
    WriteString(0,"WHDLoad Games  (A)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesA}"+#LF$)
    WriteString(0,"WHDLoad Games  (B)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesB}"+#LF$)
    WriteString(0,"WHDLoad Games  (C)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesC}"+#LF$)
    WriteString(0,"WHDLoad Games  (D)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesD}"+#LF$)
    WriteString(0,"WHDLoad Games  (E)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesE}"+#LF$)
    WriteString(0,"WHDLoad Games  (F)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesF}"+#LF$)
    WriteString(0,"WHDLoad Games  (G)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesG}"+#LF$)
    WriteString(0,"WHDLoad Games  (H)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesH}"+#LF$)
    WriteString(0,"WHDLoad Games  (I)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesI}"+#LF$)
    WriteString(0,"WHDLoad Games  (J)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesJ}"+#LF$)
    WriteString(0,"WHDLoad Games  (K)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesK}"+#LF$)
    WriteString(0,"WHDLoad Games  (L)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesL}"+#LF$)
    WriteString(0,"WHDLoad Games  (M)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesM}"+#LF$)
    WriteString(0,"WHDLoad Games  (N)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesN}"+#LF$)
    WriteString(0,"WHDLoad Games  (O)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesO}"+#LF$)
    WriteString(0,"WHDLoad Games  (P)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesP}"+#LF$)
    WriteString(0,"WHDLoad Games  (Q)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesQ}"+#LF$)
    WriteString(0,"WHDLoad Games  (R)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesR}"+#LF$)
    WriteString(0,"WHDLoad Games  (S)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesS}"+#LF$)
    WriteString(0,"WHDLoad Games  (T)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesT}"+#LF$)
    WriteString(0,"WHDLoad Games  (U)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesU}"+#LF$)
    WriteString(0,"WHDLoad Games  (V)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesV}"+#LF$)
    WriteString(0,"WHDLoad Games  (W)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesW}"+#LF$)
    WriteString(0,"WHDLoad Games  (X)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesX}"+#LF$)
    WriteString(0,"WHDLoad Games  (Y)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesY}"+#LF$)
    WriteString(0,"WHDLoad Games  (Z)  @{"+#DOUBLEQUOTE$+"Open"+#DOUBLEQUOTE$+" link GamesZ}"+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"                             Statistics"+#LF$)
    WriteString(0,"                             ----------"+#LF$)
    WriteString(0,""+#LF$)
    
    Protected demos=0, mags=0
    
    ForEach UM_Database()
      If UM_Database()\UM_Type="Game" : demos+1 : EndIf
      If UM_Database()\UM_Beta_Type="Game" : mags+1 : EndIf
    Next
    
    WriteString(0,"                 Total Games           : "+Str(demos)+#LF$)
    WriteString(0,"                 Total Beta/Unreleased : "+Str(mags)+#LF$)
    WriteString(0,"                 Total Entries         : "+Str(mags+demos)+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}                 (c) 2024 Paul Vince (MrV2K)@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"                 (File Created : "+FormatDate("%dd/%mm/%yyyy",Date())+")"+#LF$)
    WriteString(0,"@endnode"+#LF$)
    WriteString(0,"@Node Games0"+#LF$)
    WriteString(0,"@title WHDload Games (0-9)"+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (0-9)@{ub}"+#LF$)
    WriteString(0,"@{b}-------------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\nums()
      SelectElement(UM_Database(),sort_list()\nums())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesA"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (A)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (A)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\a()
      SelectElement(UM_Database(),sort_list()\a())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesB"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (B)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (B)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\b()
      SelectElement(UM_Database(),sort_list()\b())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesC"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (C)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (C)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\c()
      SelectElement(UM_Database(),sort_list()\c())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesD"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (D)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (D)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\d()
      SelectElement(UM_Database(),sort_list()\d())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesE"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (E)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (E)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\e()
      SelectElement(UM_Database(),sort_list()\e())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesF"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (F)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (F)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\f()
      SelectElement(UM_Database(),sort_list()\f())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesG"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (G)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (G)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\g()
      SelectElement(UM_Database(),sort_list()\g())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesH"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (H)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (H)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\h()
      SelectElement(UM_Database(),sort_list()\h())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesI"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (I)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (I)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\i()
      SelectElement(UM_Database(),sort_list()\i())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesJ"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (J)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (J)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\j()
      SelectElement(UM_Database(),sort_list()\j())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesK"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (K)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (K)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\k()
      SelectElement(UM_Database(),sort_list()\k())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesL"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (L)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (L)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\l()
      SelectElement(UM_Database(),sort_list()\l())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesM"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (M)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (M)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\m()
      SelectElement(UM_Database(),sort_list()\m())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesN"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (N)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (N)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\n()
      SelectElement(UM_Database(),sort_list()\n())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesO"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (O)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (O)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\o()
      SelectElement(UM_Database(),sort_list()\o())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesP"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (P)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (P)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\p()
      SelectElement(UM_Database(),sort_list()\p())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesQ"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (Q)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (Q)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\q()
      SelectElement(UM_Database(),sort_list()\q())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesR"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (R)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (R)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\r()
      SelectElement(UM_Database(),sort_list()\r())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesS"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (S)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (S)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\s()
      SelectElement(UM_Database(),sort_list()\s())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesT"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (T)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (T)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\t()
      SelectElement(UM_Database(),sort_list()\t())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesU"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (U)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (U)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\u()
      SelectElement(UM_Database(),sort_list()\u())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesV"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (V)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (V)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\v()
      SelectElement(UM_Database(),sort_list()\v())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesW"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (W)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (W)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\w()
      SelectElement(UM_Database(),sort_list()\w())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesX"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (X)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (X)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\x()
      SelectElement(UM_Database(),sort_list()\x())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesY"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (Y)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (Y)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\y()
      SelectElement(UM_Database(),sort_list()\y())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    WriteString(0,"@Node GamesZ"+#LF$)
    WriteString(0,"@title "+#DOUBLEQUOTE$+"WHDload Games (Z)"+#DOUBLEQUOTE$+#LF$)
    WriteString(0,""+#LF$)
    WriteString(0,"@{b}WHDload Games (Z)@{ub}"+#LF$)
    WriteString(0,"@{b}-----------------@{ub}"+#LF$)
    WriteString(0,""+#LF$)
    ForEach sort_list()\z()
      SelectElement(UM_Database(),sort_list()\z())
      If UM_Database()\UM_Restricted : Continue : EndIf
      If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
        WriteString(0,"@{"+#DOUBLEQUOTE$+"Info"+#DOUBLEQUOTE$+" link "+#DOUBLEQUOTE$+"WHD-Data/"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Short+Tags_Short()+".guide"+"/main"+#DOUBLEQUOTE$+" 0} - "+UM_Database()\UM_Title+Tags()+" "+#LF$)
      EndIf
    Next
    WriteString(0,"@endnode"+#LF$)
    
    CloseFile(0)
    
  EndIf
  
  FreeList(sort_list())
  
EndProcedure

Procedure Make_Demo_List(outpath.s)
  
  NewList sort_list.sort_struc()
  
  AddElement(sort_list())
  
  ForEach UM_Database()
    If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Beta_Type="Demo"
      Select LCase(Left(UM_Database()\UM_Title,1))
        Case "0","1","2","3","4","5","6","7","8","9"
          AddElement(sort_list()\nums())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\nums()=path
        Case "a"
          AddElement(sort_list()\a())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\a()=path
        Case "b"
          AddElement(sort_list()\b())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\b()=path
        Case "c"
          AddElement(sort_list()\c())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\c()=path
        Case "d"
          AddElement(sort_list()\d())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\d()=path
        Case "e"
          AddElement(sort_list()\e())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\e()=path
        Case "f"
          AddElement(sort_list()\f())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\f()=path   
        Case "g"
          AddElement(sort_list()\g())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\g()=path
        Case "h"
          AddElement(sort_list()\h())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\h()=path
        Case "i"
          AddElement(sort_list()\i())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\i()=path
        Case "j"
          AddElement(sort_list()\j())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\j()=path
        Case "k"
          AddElement(sort_list()\k())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\k()=path
        Case "l"
          AddElement(sort_list()\l())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\l()=path
        Case "m"
          AddElement(sort_list()\m())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\m()=path
        Case "n"
          AddElement(sort_list()\n())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\n()=path
        Case "o"
          AddElement(sort_list()\o())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\o()=path
        Case "p"
          AddElement(sort_list()\p())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\p()=path
        Case "q"
          AddElement(sort_list()\q())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\q()=path
        Case "r"
          AddElement(sort_list()\r())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\r()=path
        Case "s"
          AddElement(sort_list()\s())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\s()=path
        Case "t"
          AddElement(sort_list()\t())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\t()=path
        Case "u"
          AddElement(sort_list()\u())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\u()=path
        Case "v"
          AddElement(sort_list()\v())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\v()=path
        Case "w"
          AddElement(sort_list()\w())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\w()=path
        Case "x"
          AddElement(sort_list()\x())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\x()=path
        Case "y"
          AddElement(sort_list()\y())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\y()=path
        Case "z"
          AddElement(sort_list()\z())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\z()=path
      EndSelect
    EndIf
  Next
  
  SelectElement(sort_list(),0)
  
  If FileSize(outpath)>0 : DeleteFile(outpath) : EndIf
  
  If CreateFile(0,outpath,#PB_Ascii)
    
    WriteString(0,"******************"+#LF$)
    WriteString(0,"*                *"+#LF$)
    WriteString(0,"* AGS Demos List *"+#LF$)
    WriteString(0,"*                *"+#LF$)
    WriteString(0,"******************"+#LF$)
    
    count=0
    
    If ListSize(sort_list()\nums())>0 
      WriteString(0,#LF$)
      WriteString(0,"Demos - 0-9"+#LF$)
      WriteString(0,"-----------"+#LF$)
      SortList(sort_list()\nums(),#PB_Sort_Ascending)
      ForEach sort_list()\nums()
        WriteString(0,sort_list()\nums()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\a())>0
      WriteString(0,#LF$)
      WriteString(0,"Demos - A"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\a(),#PB_Sort_Ascending)
      ForEach sort_list()\a()
        WriteString(0,sort_list()\a()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\b())>0
      WriteString(0,#LF$)
      WriteString(0,"Demos - B"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\b(),#PB_Sort_Ascending)
      ForEach sort_list()\b()
        WriteString(0,sort_list()\b()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\c())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - C"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\c(),#PB_Sort_Ascending)
      ForEach sort_list()\c()
        WriteString(0,sort_list()\c()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\d())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - D"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\d(),#PB_Sort_Ascending)
      ForEach sort_list()\d()
        WriteString(0,sort_list()\d()+#LF$)
        count+1
      Next
    EndIf
    
    
    If ListSize(sort_list()\e())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - E"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\e(),#PB_Sort_Ascending)
      ForEach sort_list()\e()
        WriteString(0,sort_list()\e()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\f())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - F"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\f(),#PB_Sort_Ascending)
      ForEach sort_list()\f()
        WriteString(0,sort_list()\f()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\g())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - G"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\g(),#PB_Sort_Ascending)
      ForEach sort_list()\g()
        WriteString(0,sort_list()\g()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\h())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - H"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\h(),#PB_Sort_Ascending)
      ForEach sort_list()\h()
        WriteString(0,sort_list()\h()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\i())>0 
      WriteString(0,#LF$)
      WriteString(0,"Demos - I"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\i(),#PB_Sort_Ascending)
      ForEach sort_list()\i()
        WriteString(0,sort_list()\i()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\j())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - J"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\j(),#PB_Sort_Ascending)
      ForEach sort_list()\j()
        WriteString(0,sort_list()\j()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\k())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - K"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\k(),#PB_Sort_Ascending)
      ForEach sort_list()\k()
        WriteString(0,sort_list()\k()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\l())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - L"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\l(),#PB_Sort_Ascending)
      ForEach sort_list()\l()
        WriteString(0,sort_list()\l()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\m())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - M"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\m(),#PB_Sort_Ascending)
      ForEach sort_list()\m()
        WriteString(0,sort_list()\m()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\n())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - N"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\n(),#PB_Sort_Ascending)
      ForEach sort_list()\n()
        WriteString(0,sort_list()\n()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\o())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - O"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\o(),#PB_Sort_Ascending)
      ForEach sort_list()\o()
        WriteString(0,sort_list()\o()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\p())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - P"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\p(),#PB_Sort_Ascending)
      ForEach sort_list()\p()
        WriteString(0,sort_list()\p()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\q())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - Q"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\q(),#PB_Sort_Ascending)
      ForEach sort_list()\q()
        WriteString(0,sort_list()\q()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\r())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - R"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\r(),#PB_Sort_Ascending)
      ForEach sort_list()\r()
        WriteString(0,sort_list()\r()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\s())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - S"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\s(),#PB_Sort_Ascending)
      ForEach sort_list()\s()
        WriteString(0,sort_list()\s()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\t())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - T"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\t(),#PB_Sort_Ascending)
      ForEach sort_list()\t()
        WriteString(0,sort_list()\t()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\u())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - U"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\u(),#PB_Sort_Ascending)
      ForEach sort_list()\u()
        WriteString(0,sort_list()\u()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\v())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - V"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\v(),#PB_Sort_Ascending)
      ForEach sort_list()\v()
        WriteString(0,sort_list()\v()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\w())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - W"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\w(),#PB_Sort_Ascending)
      ForEach sort_list()\w()
        WriteString(0,sort_list()\w()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\x())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - X"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\x(),#PB_Sort_Ascending)
      ForEach sort_list()\x()
        WriteString(0,sort_list()\x()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\y())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - Y"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\y(),#PB_Sort_Ascending)
      ForEach sort_list()\y()
        WriteString(0,sort_list()\y()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\z())>0    
      WriteString(0,#LF$)
      WriteString(0,"Demos - Z"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\z(),#PB_Sort_Ascending)
      ForEach sort_list()\z()
        WriteString(0,sort_list()\z()+#LF$)
        count+1
      Next
    EndIf
    
    WriteString(0,#LF$)
    WriteString(0,"*** Demo Count - "+Str(count)+" ***")
    
    CloseFile(0)
    
  EndIf
  
  FreeList(sort_list())
  
EndProcedure

Procedure Make_Magazine_List(outpath.s)
  
  If FileSize(outpath)>0 : DeleteFile(outpath) : EndIf  
  
  count=0
  
  If CreateFile(0,outpath,#PB_Ascii)
    
    WriteString(0,"*********************"+#LF$)
    WriteString(0,"*                   *"+#LF$)
    WriteString(0,"* AGS Magazine List *"+#LF$)
    WriteString(0,"*                   *"+#LF$)
    WriteString(0,"*********************"+#LF$) 
    WriteString(0,#LF$)
    WriteString(0,"Magazines - 0-Z"+#LF$)
    WriteString(0,"---------------"+#LF$)
    
    ForEach UM_Database()
      If UM_Database()\UM_Type="Magazine"        
        WriteString(0,UM_Database()\UM_Title+#LF$)
        count+1
      EndIf
    Next
    
    WriteString(0,#LF$)
    WriteString(0,"*** Magazine Count - "+Str(count)+" ***")
    
    CloseFile(0)
    
  EndIf
  
EndProcedure

Procedure Make_Game_List(outpath.s)
  
  NewList sort_list.sort_struc()
  
  AddElement(sort_list())
  
  ForEach UM_Database()
    If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
      Select LCase(Left(UM_Database()\UM_Title,1))
        Case "0","1","2","3","4","5","6","7","8","9"
          AddElement(sort_list()\nums())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\nums()=path
        Case "a"
          AddElement(sort_list()\a())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\a()=path
        Case "b"
          AddElement(sort_list()\b())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\b()=path
        Case "c"
          AddElement(sort_list()\c())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\c()=path
        Case "d"
          AddElement(sort_list()\d())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\d()=path
        Case "e"
          AddElement(sort_list()\e())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\e()=path
        Case "f"
          AddElement(sort_list()\f())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\f()=path   
        Case "g"
          AddElement(sort_list()\g())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\g()=path
        Case "h"
          AddElement(sort_list()\h())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\h()=path
        Case "i"
          AddElement(sort_list()\i())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\i()=path
        Case "j"
          AddElement(sort_list()\j())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\j()=path
        Case "k"
          AddElement(sort_list()\k())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\k()=path
        Case "l"
          AddElement(sort_list()\l())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\l()=path
        Case "m"
          AddElement(sort_list()\m())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\m()=path
        Case "n"
          AddElement(sort_list()\n())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\n()=path
        Case "o"
          AddElement(sort_list()\o())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\o()=path
        Case "p"
          AddElement(sort_list()\p())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\p()=path
        Case "q"
          AddElement(sort_list()\q())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\q()=path
        Case "r"
          AddElement(sort_list()\r())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\r()=path
        Case "s"
          AddElement(sort_list()\s())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\s()=path
        Case "t"
          AddElement(sort_list()\t())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\t()=path
        Case "u"
          AddElement(sort_list()\u())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\u()=path
        Case "v"
          AddElement(sort_list()\v())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\v()=path
        Case "w"
          AddElement(sort_list()\w())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\w()=path
        Case "x"
          AddElement(sort_list()\x())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\x()=path
        Case "y"
          AddElement(sort_list()\y())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\y()=path
        Case "z"
          AddElement(sort_list()\z())
          path=UM_Database()\UM_Title+Tags()+" - ["+UM_Database()\UM_Short+Tags_Short()+"]"
          sort_list()\z()=path
      EndSelect
    EndIf
  Next
  
  SelectElement(sort_list(),0)
  
  If FileSize(outpath)>0 : DeleteFile(outpath) : EndIf
  
  count=0
  
  If CreateFile(0,outpath,#PB_Ascii)
    
    WriteString(0,"******************"+#LF$)
    WriteString(0,"*                *"+#LF$)
    WriteString(0,"* AGS Games List *"+#LF$)
    WriteString(0,"*                *"+#LF$)
    WriteString(0,"******************"+#LF$) 
    
    If ListSize(sort_list()\nums())>0 
      WriteString(0,#LF$)
      WriteString(0,"Games - 0-9"+#LF$)
      WriteString(0,"-----------"+#LF$)
      SortList(sort_list()\nums(),#PB_Sort_Ascending)
      ForEach sort_list()\nums()
        WriteString(0,sort_list()\nums()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\a())>0
      WriteString(0,#LF$)
      WriteString(0,"Games - A"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\a(),#PB_Sort_Ascending)
      ForEach sort_list()\a()
        WriteString(0,sort_list()\a()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\b())>0
      WriteString(0,#LF$)
      WriteString(0,"Games - B"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\b(),#PB_Sort_Ascending)
      ForEach sort_list()\b()
        WriteString(0,sort_list()\b()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\c())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - C"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\c(),#PB_Sort_Ascending)
      ForEach sort_list()\c()
        WriteString(0,sort_list()\c()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\d())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - D"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\d(),#PB_Sort_Ascending)
      ForEach sort_list()\d()
        WriteString(0,sort_list()\d()+#LF$)
        count+1
      Next
    EndIf
    
    
    If ListSize(sort_list()\e())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - E"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\e(),#PB_Sort_Ascending)
      ForEach sort_list()\e()
        WriteString(0,sort_list()\e()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\f())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - F"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\f(),#PB_Sort_Ascending)
      ForEach sort_list()\f()
        WriteString(0,sort_list()\f()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\g())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - G"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\g(),#PB_Sort_Ascending)
      ForEach sort_list()\g()
        WriteString(0,sort_list()\g()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\h())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - H"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\h(),#PB_Sort_Ascending)
      ForEach sort_list()\h()
        WriteString(0,sort_list()\h()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\i())>0 
      WriteString(0,#LF$)
      WriteString(0,"Games - I"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\i(),#PB_Sort_Ascending)
      ForEach sort_list()\i()
        WriteString(0,sort_list()\i()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\j())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - J"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\j(),#PB_Sort_Ascending)
      ForEach sort_list()\j()
        WriteString(0,sort_list()\j()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\k())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - K"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\k(),#PB_Sort_Ascending)
      ForEach sort_list()\k()
        WriteString(0,sort_list()\k()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\l())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - L"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\l(),#PB_Sort_Ascending)
      ForEach sort_list()\l()
        WriteString(0,sort_list()\l()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\m())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - M"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\m(),#PB_Sort_Ascending)
      ForEach sort_list()\m()
        WriteString(0,sort_list()\m()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\n())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - N"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\n(),#PB_Sort_Ascending)
      ForEach sort_list()\n()
        WriteString(0,sort_list()\n()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\o())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - O"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\o(),#PB_Sort_Ascending)
      ForEach sort_list()\o()
        WriteString(0,sort_list()\o()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\p())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - P"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\p(),#PB_Sort_Ascending)
      ForEach sort_list()\p()
        WriteString(0,sort_list()\p()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\q())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - Q"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\q(),#PB_Sort_Ascending)
      ForEach sort_list()\q()
        WriteString(0,sort_list()\q()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\r())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - R"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\r(),#PB_Sort_Ascending)
      ForEach sort_list()\r()
        WriteString(0,sort_list()\r()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\s())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - S"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\s(),#PB_Sort_Ascending)
      ForEach sort_list()\s()
        WriteString(0,sort_list()\s()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\t())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - T"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\t(),#PB_Sort_Ascending)
      ForEach sort_list()\t()
        WriteString(0,sort_list()\t()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\u())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - U"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\u(),#PB_Sort_Ascending)
      ForEach sort_list()\u()
        WriteString(0,sort_list()\u()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\v())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - V"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\v(),#PB_Sort_Ascending)
      ForEach sort_list()\v()
        WriteString(0,sort_list()\v()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\w())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - W"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\w(),#PB_Sort_Ascending)
      ForEach sort_list()\w()
        WriteString(0,sort_list()\w()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\x())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - X"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\x(),#PB_Sort_Ascending)
      ForEach sort_list()\x()
        WriteString(0,sort_list()\x()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\y())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - Y"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\y(),#PB_Sort_Ascending)
      ForEach sort_list()\y()
        WriteString(0,sort_list()\y()+#LF$)
        count+1
      Next
    EndIf
    
    If ListSize(sort_list()\z())>0    
      WriteString(0,#LF$)
      WriteString(0,"Games - Z"+#LF$)
      WriteString(0,"---------"+#LF$)
      SortList(sort_list()\z(),#PB_Sort_Ascending)
      ForEach sort_list()\z()
        WriteString(0,sort_list()\z()+#LF$)
        count+1
      Next
    EndIf
    
    WriteString(0,#LF$)
    WriteString(0,"*** Game Count - "+Str(count)+" ***")
    
    CloseFile(0)
    
  EndIf
  
  FreeList(sort_list())
  
EndProcedure

Procedure Make_PD_Disk(out_path.s="")
  
  ;253x178
  
  Protected text_x.i, aga.s, out_folder.s, disk_title.s, demo_title_1.s, demo_title_2.s, temp.s, cut.s
  
  If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine"  Or UM_Database()\UM_Beta_Type="Demo" Or UM_Database()\UM_Beta_Type="Magazine"
    
    If UM_Database()\UM_Type="Demo"
      out_folder="Demo\"
      disk_title="Public Domain Disk"
    EndIf
    
    If UM_Database()\UM_Type="Beta"
      out_folder="Beta\"
      disk_title="Public Domain Disk"
    EndIf
    
    If UM_Database()\UM_Type="Magazine"
      out_folder="Magazine\"
      disk_title="Disk Magazine"
    EndIf
    
    If UM_Database()\UM_AGA=#True : aga=" (AGA)" : Else : aga="" : EndIf
    
    temp=UM_Database()\UM_Title+aga
    
    demo_title_1=""
    demo_title_2=""
    
    If Len(temp) > 25
      count=25
      Repeat 
        If Mid(temp,count,1)=" "
          demo_title_1=Trim(Left(temp,count))
          cut=Left(temp,count)
          temp=RemoveString(temp,cut,#PB_String_NoCase)
          demo_title_2=temp
          temp=""
        EndIf 
        count-1       
      Until count=0 Or temp=""
    Else 
      demo_title_1=temp
    EndIf
       
    If out_path=""
      path=Game_Data_Path+out_folder+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"   
      CreateDirectory(Game_Data_Path+"\"+out_folder+UM_Database()\UM_Subfolder+"\")
      CreateDirectory(Game_Data_Path+"\"+out_folder+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder)
      SetCurrentDirectory(path)
    Else
      path=out_path+out_folder+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\" 
      CreateDirectory(out_path+out_folder)
      CreateDirectory(out_path+out_folder+UM_Database()\UM_Subfolder+"\")
      CreateDirectory(out_path+out_folder+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder)
      SetCurrentDirectory(path)
    EndIf
    
    LoadImage(#BACK_IMAGE,Game_Data_Path+out_folder+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png")      
    ResizeImage(#BACK_IMAGE,505,354)
    Round_Image(#BACK_IMAGE)
    
    LoadImage(#PREVIEW_IMAGE,Game_Data_Path+"floppydisk.png")
    CreateImage(#TEMP_IMAGE,640,824,32)
    CopyImage(#PREVIEW_IMAGE,#TEMP_IMAGE)
    
    StartDrawing(ImageOutput(#TEMP_IMAGE))
    DrawingMode(#PB_2DDrawing_AlphaBlend)
    DrawAlphaImage(ImageID(#BACK_IMAGE),65,348,50)
    DrawingFont(FontID(#HEADER_FONT))
    text_x=(ImageWidth(#TEMP_IMAGE)-TextWidth(disk_title))/2
    DrawText(text_x,360,disk_title,RGBA(0,0,0,255),RGBA(0,0,0,0))
    DrawingFont(FontID(#PREVIEW_FONT))
    
    If demo_title_1<>"" And demo_title_2<>""
      text_x=(ImageWidth(#TEMP_IMAGE)-TextWidth(demo_title_1))/2
      DrawText(text_x,460,demo_title_1,RGBA(0,0,200,255),RGBA(0,0,0,0))
      text_x=(ImageWidth(#TEMP_IMAGE)-TextWidth(demo_title_2))/2
      DrawText(text_x,510,demo_title_2,RGBA(0,0,200,255),RGBA(0,0,0,0))
      text_x=(ImageWidth(#TEMP_IMAGE)-TextWidth("By"))/2
      DrawText(text_x,560,"By",RGBA(0,0,200,255),RGBA(0,0,0,0))
      If TextWidth(UM_Database()\UM_Publisher)>177
        DrawingFont(FontID(#SMALL_FONT))
      EndIf
      text_x=(ImageWidth(#TEMP_IMAGE)-TextWidth(UM_Database()\UM_Publisher))/2
      DrawText(text_x,610,UM_Database()\UM_Publisher,RGBA(0,0,200,255),RGBA(0,0,0,0))
    EndIf
    
    If demo_title_1<>"" And demo_title_2=""
      text_x=(ImageWidth(#TEMP_IMAGE)-TextWidth(demo_title_1))/2
      DrawText(text_x,460,demo_title_1,RGBA(0,0,200,255),RGBA(0,0,0,0))
      text_x=(ImageWidth(#TEMP_IMAGE)-TextWidth("By"))/2
      DrawText(text_x,520,"By",RGBA(0,0,200,255),RGBA(0,0,0,0))
      If TextWidth(UM_Database()\UM_Publisher)>177
        DrawingFont(FontID(#SMALL_FONT))
      EndIf
      text_x=(ImageWidth(#TEMP_IMAGE)-TextWidth(UM_Database()\UM_Publisher))/2
      DrawText(text_x,580,UM_Database()\UM_Publisher,RGBA(0,0,200,255),RGBA(0,0,0,0))
    EndIf

    StopDrawing()
    
    SaveImage(#TEMP_IMAGE,GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png",#PB_ImagePlugin_PNG)
    
    FreeImage(#PREVIEW_IMAGE)
    FreeImage(#TEMP_IMAGE)
    FreeImage(#BACK_IMAGE)
    
    If out_path=""
      Draw_Info(List_Numbers()\L_Number)
    EndIf
  Else
    MessageRequester("Error!","Not a demo or magazine!",#PB_MessageRequester_Ok|#PB_MessageRequester_Error)
  EndIf
  
  
EndProcedure

Procedure Make_PD_Disk_Set()
  
  Protected oldgadgetlist.i, text_x.i, result.i, path2.s, old_pos.i, aga.s, pd_path.s
  
  pd_path=PathRequester("Test","")
  
  If pd_path<>""
    
    old_pos=GetGadgetState(#MAIN_LIST) 
    
    OpenConsole("Create PD Images")
    Center_Console()
    
    ForEach UM_Database()
      If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo" Or UM_Database()\UM_Beta_Type="Magazine"
        PrintN("Processing: "+UM_Database()\UM_Title)
        Make_PD_Disk(pd_path)
      EndIf
    Next
    
    SetCurrentDirectory(Home_Path)
    
    CloseConsole()
    
    SetGadgetState(#MAIN_LIST,old_pos)
    SelectElement(List_Numbers(),old_pos)
    SelectElement(UM_Database(),List_Numbers()\L_Number)
    Draw_Info(List_Numbers()\L_Number)
    
  EndIf
  
EndProcedure

Procedure Make_CLRMame_Dats(clr_path.s,clr_title.s, clr_sub.b)
  
  UseCRC32Fingerprint()
  UseMD5Fingerprint()
  
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
    SetXMLNodeText(item,"Created By AGS Database Manager")
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

Procedure Compare_AGS_Folders_Old()
  
  Protected startup_file
  
  OpenConsole("Update...")
  Center_Console()
  ConsoleCursor(0)
  
  EnableGraphicalConsole(1)
  ClearConsole()
  EnableGraphicalConsole(0)
  
  PrintNCol("***************************",6,0)
  PrintNCol("*                         *",6,0)
  PrintNCol("*   Compare AGS Drive...  *",6,0)
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
      WriteString(startup_file,"cd AGS_Drive:"+#LF$)
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+"Creating Folders List... Please Wait!"+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+"This could take a few minutes..."+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$)
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+"Executing Command: list DIRS ALL LFORMAT %P%N"+#DOUBLEQUOTE$+#LF$)
      
      ; Create a file of directories in the temp folder
      
      WriteString(startup_file,"Assign AGS: System:AGS2"+#LF$)
      WriteString(startup_file,"cd AGS:"+#LF$)      
      WriteString(startup_file,"list files "+#DOUBLEQUOTE$+"Demos - AGA.ags"+#DOUBLEQUOTE$+" all lformat %p%n~%l >RAM:dir1"+#LF$)
      WriteString(startup_file,"list files "+#DOUBLEQUOTE$+"Demos - By Group.ags"+#DOUBLEQUOTE$+" all lformat %p%n~%l >RAM:dir2"+#LF$)
      WriteString(startup_file,"list files "+#DOUBLEQUOTE$+"Demos - ECS-OCS.ags"+#DOUBLEQUOTE$+" all lformat %p%n~%l >RAM:dir3"+#LF$)
      WriteString(startup_file,"list files "+#DOUBLEQUOTE$+"Games - AGA.ags"+#DOUBLEQUOTE$+" all lformat %p%n~%l >RAM:dir4"+#LF$)
      WriteString(startup_file,"list files "+#DOUBLEQUOTE$+"Games - Arcadia.ags"+#DOUBLEQUOTE$+" all lformat %p%n~%l >RAM:dir5"+#LF$)
      WriteString(startup_file,"list files "+#DOUBLEQUOTE$+"Games - Beta & Unreleased.ags"+#DOUBLEQUOTE$+" all lformat %p%n~%l >RAM:dir6"+#LF$)
      WriteString(startup_file,"list files "+#DOUBLEQUOTE$+"Games - By Genre.ags"+#DOUBLEQUOTE$+" all lformat %p%n~%l >RAM:dir7"+#LF$)
      WriteString(startup_file,"list files "+#DOUBLEQUOTE$+"Games - By Year.ags"+#DOUBLEQUOTE$+" all lformat %p%n~%l >RAM:dir8"+#LF$)
      WriteString(startup_file,"list files "+#DOUBLEQUOTE$+"Games - CD32.ags"+#DOUBLEQUOTE$+" all lformat %p%n~%l >RAM:dir9"+#LF$)
      WriteString(startup_file,"list files "+#DOUBLEQUOTE$+"Games - CDTV.ags"+#DOUBLEQUOTE$+" all lformat %p%n~%l >RAM:dir10"+#LF$)
      WriteString(startup_file,"list files "+#DOUBLEQUOTE$+"Games - ECS-OCS.ags"+#DOUBLEQUOTE$+" all lformat %p%n~%l >RAM:dir11"+#LF$)
      WriteString(startup_file,"list files "+#DOUBLEQUOTE$+"Games - MT32.ags"+#DOUBLEQUOTE$+" all lformat %p%n~%l >RAM:dir12"+#LF$)
      WriteString(startup_file,"list files "+#DOUBLEQUOTE$+"Games - Non English.ags"+#DOUBLEQUOTE$+" all lformat %p%n~%l >RAM:dir13"+#LF$)
      WriteString(startup_file,"list files "+#DOUBLEQUOTE$+"Games - NTSC.ags"+#DOUBLEQUOTE$+" all lformat %p%n~%l >RAM:dir14"+#LF$)
      WriteString(startup_file,"list files "+#DOUBLEQUOTE$+"ReadMe - Demos.ags"+#DOUBLEQUOTE$+" all lformat %p%n~%l >RAM:dir15"+#LF$)
      WriteString(startup_file,"list files "+#DOUBLEQUOTE$+"ReadMe - Games.ags"+#DOUBLEQUOTE$+" all lformat %p%n~%l >RAM:dir16"+#LF$)
      WriteString(startup_file,"RAM:"+#LF$)
      WriteString(startup_file,"join dir1 dir2 dir3 dir4 dir5 dir6 dir7 dir8 dir9 dir10 dir11 dir12 dir13 dir14 dir15 dir16 AS dh1:dirs.txt"+#LF$)
      
      ; Create a file if the batch file completes
      
      WriteString(startup_file,"Echo "+#DOUBLEQUOTE$+"Complete"+#DOUBLEQUOTE$+" TO DH1:complete.txt"+#LF$)
      WriteString(startup_file,"c:uaequit")
      FlushFileBuffers(startup_file)
      CloseFile(startup_file)      
    EndIf
    
    ; Run WinUAE with the batch file and wait
    
    startup_prog=RunProgram(WinUAE_Path, "-f "+IG_Path+"Update_AGS.uae -s filesystem2=rw,DH1:WHDTemp:"+WHD_TempDir+",0","",#PB_Program_Wait)
    
    ; Remove dirs.txt and slaves.txt if they exist in the home folder
    
    If FileSize(home_path+"dirs.txt")>0 : DeleteFile(home_path+"dirs.txt") : EndIf
    
    ; Copy the new files into the home folder
    
    CopyFile("dirs.txt",home_path+"dirs.txt")
    SetCurrentDirectory(home_path)
    
    ; Remove the temporary folder
    
    DeleteDirectory(WHD_TempDir,"*.*",#PB_FileSystem_Recursive|#PB_FileSystem_Force)
    
  EndIf
  
  PrintS()
  PrintN("Processing Data...")
  
  Structure Dir_Data
    list_name.s
    list_size.s
  EndStructure
  
  Protected NewList AmigaDirs.Dir_Data()
  Protected NewList PCDirs.Dir_Data()
  
  If OpenFile(#FILE,Home_Path+"dirs.txt")
    While Not Eof(#file)
      path=ReadString(#FILE,#PB_Ascii)
      AddElement(AmigaDirs())
      AmigaDirs()\list_name=StringField(path,1,Chr(126))
      AmigaDirs()\list_size=StringField(path,2,Chr(126))
    Wend
  EndIf
  
  CloseFile(#FILE)
  
  If FileSize(home_path+"dirs.txt")>0 : DeleteFile(home_path+"dirs.txt") : EndIf
  
  path=PathRequester("Select Folder",AGS_Path)
  
  ClearList(Files())
  
  If path<>""
    List_Files_Recursive(path,Files(),"")
    ForEach Files()
      AddElement(PCDirs())
      If CountString(files(),Chr(92))=4 : PCDirs()\list_name=StringField(files(),3,Chr(92))+"/"+StringField(files(),4,Chr(92))+"/"+StringField(files(),5,Chr(92)) : EndIf
      If CountString(files(),Chr(92))=3 : PCDirs()\list_name=StringField(files(),3,Chr(92))+"/"+StringField(files(),4,Chr(92)) : EndIf
      PCDirs()\list_size=Str(FileSize(files()))
    Next
  EndIf
  
  Protected NewMap Amiga_Map.i()
  Protected NewList Copy_List.s()
  
  ForEach AmigaDirs()
    Amiga_Map(AmigaDirs()\list_name)=ListIndex(AmigaDirs())
  Next
  
  ForEach PCDirs()
    If FindMapElement(Amiga_Map(),PCDirs()\list_name)
      SelectElement(AmigaDirs(),Amiga_Map())
      If PCDirs()\list_size<>AmigaDirs()\list_size
        AddElement(Copy_List())
        Copy_List()=path+ReplaceString(PCDirs()\list_name,Chr(47),Chr(92))
      EndIf
    EndIf
  Next
  
  Protected NewMap PC_Map.i()
  Protected NewList Delete_List.s()
  
  ForEach PCDirs()
    PC_Map(PCDirs()\list_name)=ListIndex(PCDirs())
  Next
  
  ForEach AmigaDirs()
    If Not FindMapElement(PC_Map(),AmigaDirs()\list_name)
      AddElement(Delete_List())
      Delete_List()=AmigaDirs()\list_name
    EndIf
  Next
  
  PrintS()
  PrintN("Please pick an output folder...")
  
  path=PathRequester("Output Path",Home_Path)
  
  If path<>""
    
    If ListSize(Copy_List())>0
      PrintS()
      PrintN("Writing data...")
      CreateDirectory(path+"AGS2")
      ForEach Copy_List()
        If CountString(Copy_List(),Chr(92))=4 
          path2=StringField(Copy_List(),3,Chr(92))+"\"+StringField(Copy_List(),4,Chr(92))+"\"+StringField(Copy_List(),5,Chr(92)) 
          CreateDirectory(path+"AGS2\"+StringField(Copy_List(),3,Chr(92)))
          CreateDirectory(path+"AGS2\"+StringField(Copy_List(),3,Chr(92))+"\"+StringField(Copy_List(),4,Chr(92)))
        EndIf
        If CountString(Copy_List(),Chr(92))=3 
          path2=StringField(Copy_List(),3,Chr(92))+"\"+StringField(Copy_List(),4,Chr(92))
          CreateDirectory(path+"AGS2\"+StringField(Copy_List(),3,Chr(92)))
        EndIf
        CopyFile(Copy_List(),path+"AGS2\"+path2)
      Next
    EndIf
    
    Protected string.s
    
    string=""
    
    If FileSize(path+"delete_script.txt")>0 : DeleteFile(path+"delete_script.txt") : EndIf
    
    If ListSize(Delete_List())>0
      If CreateFile(#File,path+"delete_script.txt")
        ForEach Delete_List()
          string+"delete "+#DOUBLEQUOTE$+"AGS:"+Delete_List()+#DOUBLEQUOTE$+#LF$
        Next
        WriteString(#file,string,#PB_Ascii)
      EndIf
    EndIf
    
    CloseFile(#File)
    
  EndIf
  
  CloseConsole()
  
  OpenFolder(path)
  
  FreeList(AmigaDirs())
  FreeList(PCDirs())
  FreeMap(Amiga_Map())
  FreeMap(PC_Map())
  
EndProcedure

Macro Make_AGS_Image(image_path)
  
  If make_images
    
    source_folder$=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"

    source_file$=#DOUBLEQUOTE$+source_folder$+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png"+#DOUBLEQUOTE$
    new_file$=#DOUBLEQUOTE$+image_path+"-1.iff"+#DOUBLEQUOTE$
    
    If Real Or a500_mini
      If ECS
        i_path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -rtype lanczos2 -resize 320 128 -colors 8 -floyd "+source_file$
      Else
        i_path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 320 128 -rtype lanczos2 -colors 64 "+source_file$
      EndIf
    Else
      i_path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 320 256 -rtype lanczos2 -colors 128 "+source_file$
    EndIf  
    If FileSize(GetCurrentDirectory()+RemoveString(new_file$,#DOUBLEQUOTE$))=-1 Or force_iff=#True
      RunProgram(nconvert_path,i_path,"",#PB_Program_Wait)
    EndIf

    source_file$=#DOUBLEQUOTE$+source_folder$+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png"+#DOUBLEQUOTE$
    new_file$=#DOUBLEQUOTE$+image_path+"-2.iff"+#DOUBLEQUOTE$
    
    If Real Or a500_mini
      If ECS
        i_path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -rtype lanczos2 -resize 320 128 -colors 8 -floyd "+source_file$
      Else
        i_path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 320 128 -rtype lanczos2 -colors 64 "+source_file$
      EndIf
    Else
      i_path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -resize 320 256 -rtype lanczos2 -colors 128 "+source_file$
    EndIf  
    If FileSize(GetCurrentDirectory()+RemoveString(new_file$,#DOUBLEQUOTE$))=-1 Or force_iff=#True
      RunProgram(nconvert_path,i_path,"",#PB_Program_Wait)
    EndIf  
    
        
    source_file$=#DOUBLEQUOTE$+source_folder$+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png"+#DOUBLEQUOTE$    
    new_file$=#DOUBLEQUOTE$+image_path+"-3.iff"+#DOUBLEQUOTE$    
    
    If Real Or a500_mini
      If ECS
        i_path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -rtype lanczos2 -ratio -resize 320 256 -canvas 320 256 center -bgcolor 0 0 0 -resize 320 128 -floyd -colors 8 "+source_file$
      Else
        i_path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -rtype lanczos2 -ratio -resize 320 256 -canvas 320 256 center -bgcolor 0 0 0 -resize 320 128 -floyd -colors 64 "+source_file$
      EndIf
    Else
      i_path="-quiet -overwrite -out iff -o "+new_file$+" -c 1 -rtype lanczos2 -ratio -resize 320 256 -canvas 320 256 center -bgcolor 0 0 0 -resize 320 256 -floyd -colors 128 "+source_file$
    EndIf
    If FileSize(GetCurrentDirectory()+RemoveString(new_file$,#DOUBLEQUOTE$))=-1 Or force_iff=#True
      RunProgram(nconvert_path,i_path,"",#PB_Program_Wait)
    EndIf
    
  EndIf
  
EndMacro

Macro Add_Script(s_text)
  AddElement(script())
  script()=s_text
EndMacro

Macro Make_AGS_Run(info_path)
  
  FC=""
  IB=""
  NTSC=""
  VRES=""
  VHeight=""
  CYCLE=""
  CPU=""
  
  ClearList(script())
  
  ; Stop the music player
  
  Add_Script("; Stop the menu music"+#LF$)
  Add_Script(#LF$)
  Add_Script("Bastyplayer >NIL: x"+#LF$)
  
  Add_Script(#LF$)
  Add_Script("; Show the splash text and game info."+#LF$)
  Add_Script(#LF$)
  Add_Script("Ex Scripts:Splash"+#LF$)
  Add_Script("Ex Scripts:Disclaimer"+#LF$)
  Add_Script("echo "+#DOUBLEQUOTE$+"*E[1m*E[32m Loading "+UM_Database()\UM_Title+Tags()+"*E[0m"+#DOUBLEQUOTE$+#LF$)
  Add_Script("echo "+#DOUBLEQUOTE$+#DOUBLEQUOTE$+#LF$) 
  Add_Script(""+#LF$) 
  
  If Real=#True And a500_mini=#False
    
    Add_Script("; Emulator Settings"+#LF$)
    Add_Script(#LF$)
    Add_Script("If $Expert EQ "+#DOUBLEQUOTE$+"1"+#DOUBLEQUOTE$+#LF$)
    Add_Script(#LF$)
    Add_Script(" SetEnv XFave "+#DOUBLEQUOTE$+"AGS:+  Favourites.ags/"+info_path+".run"+#DOUBLEQUOTE$+#LF$)
    Add_Script(" SetEnv XPath "+#DOUBLEQUOTE$+"AGS:"+current_folder+info_path+#DOUBLEQUOTE$+#LF$)
    Add_Script(" SetEnv XFile "+#DOUBLEQUOTE$+info_path+#DOUBLEQUOTE$+#LF$)
    If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Beta_Type="Demo"
      Add_Script(" SetEnv XFolder "+#DOUBLEQUOTE$+"WHD_Demos:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+#DOUBLEQUOTE$+#LF$)
    Else
      Add_Script(" SetEnv XFolder "+#DOUBLEQUOTE$+"WHD_Games:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+#DOUBLEQUOTE$+#LF$)
    EndIf
    Add_Script(" SetEnv XInfo "+#DOUBLEQUOTE$+UM_Database()\UM_Icon+#DOUBLEQUOTE$+#LF$)
    Add_Script(" SetEnv XType "+"WHDLOAD"+#LF$)
    Add_Script(" SetEnv XSubfolder "+#DOUBLEQUOTE$+UM_Database()\UM_Type+#DOUBLEQUOTE$+#LF$)
    Add_Script(" Ex Scripts:Expert_Mode"+#LF$)
    Add_Script(" SKIP Clean-Up"+#LF$)
    Add_Script(#LF$)
    Add_Script("Endif"+#LF$)
    
  EndIf
  
  If Real=#False Or a500_mini=#True
    
    Add_Script("; Emulator Settings"+#LF$)
    Add_Script(#LF$)
    
    If UM_Database()\UM_Type="Demo" : UM_Database()\UM_VRES=288 : EndIf
    If UM_Database()\UM_Type="Magazine" : UM_Database()\UM_VRES=288 : EndIf
    
    ; Reset and set global settings
    
    Add_Script("If $Expert EQ "+#DOUBLEQUOTE$+"1"+#DOUBLEQUOTE$+#LF$)
    Add_Script(#LF$)
    Add_Script(" SetEnv XFave "+#DOUBLEQUOTE$+"AGS:+  Favourites.ags/"+info_path+".run"+#DOUBLEQUOTE$+#LF$)
    Add_Script(" SetEnv XPath "+#DOUBLEQUOTE$+"AGS:"+current_folder+info_path+#DOUBLEQUOTE$+#LF$)
    Add_Script(" SetEnv XFile "+#DOUBLEQUOTE$+info_path+#DOUBLEQUOTE$+#LF$)
    If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Beta_Type="Demo"
      Add_Script(" SetEnv XFolder "+#DOUBLEQUOTE$+"WHD_Demos:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+#DOUBLEQUOTE$+#LF$)
    Else
      Add_Script(" SetEnv XFolder "+#DOUBLEQUOTE$+"WHD_Games:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+#DOUBLEQUOTE$+#LF$)
    EndIf
    Add_Script(" SetEnv XInfo "+#DOUBLEQUOTE$+UM_Database()\UM_Icon+#DOUBLEQUOTE$+#LF$)
    Add_Script(" SetEnv XType "+"WHDLOAD"+#LF$)
    Add_Script(" SetEnv XSubfolder "+#DOUBLEQUOTE$+UM_Database()\UM_Type+#DOUBLEQUOTE$+#LF$)
    Add_Script(" Ex Scripts:Expert_Mode"+#LF$)
    Add_Script(" SKIP Clean-Up"+#LF$)
    Add_Script(#LF$)
    Add_Script("Else"+#LF$) 
    Add_Script(#LF$) 
    
    If UM_Database()\UM_NTSC Or UM_Database()\UM_NT
      Add_Script(" Ex Scripts:NTSC true"+#LF$)
      Add_Script(#LF$)
    EndIf
    
    If UM_Database()\UM_JIT
      Add_Script(" Ex Scripts:JIT_Enable"+#LF$)
      Add_Script(#LF$)
    EndIf      
    
    ; A500 Mini  
    
    Add_Script(" ; A500 Mini Settings"+#LF$)
    Add_Script(#LF$)
    Add_Script(" If $HW EQ "+#DOUBLEQUOTE$+"Mini"+#DOUBLEQUOTE$+#LF$)
    
    If UM_Database()\UM_AGA And Not UM_Database()\UM_25Mhz
      UM_Database()\UM_14Mhz=#True : UM_Database()\UM_7Mhz=#False
    EndIf
    
    If UM_Database()\UM_14Mhz
      If UM_Database()\UM_NoCycle
        Add_Script("  Ex Scripts:A1200_Speed_NC"+#LF$)
      Else
        Add_Script("  Ex Scripts:A1200_Speed"+#LF$)
      EndIf
    EndIf
    
    If UM_Database()\UM_25Mhz And UM_Database()\UM_Type="Demo"
      add_script("  Ex Scripts:A4000_Speed"+#LF$)
    EndIf 
    
    If Not UM_Database()\UM_14Mhz And Not UM_Database()\UM_25Mhz 
      If UM_Database()\UM_NoCycle
        Add_Script("  Ex Scripts:A500_Speed_NC"+#LF$)
      Else
        Add_Script("  Ex Scripts:A500_Speed"+#LF$)
      EndIf
    EndIf 
    
    If UM_Database()\UM_VRES<>0
      Add_Script("  Ex Scripts:Screen_Height "+Str(UM_Database()\UM_VRES)+#LF$)
    EndIf
    
    If UM_Database()\UM_Offset<>"" 
      Add_Script("  Ex Scripts:Screen_Offset "+UM_Database()\UM_Offset+#LF$) 
    EndIf 
    
    If UM_Database()\UM_Type="Demo" : Add_Script(" Ex Scripts:FC"+#LF$) : EndIf
    If UM_Database()\UM_FC : Add_Script("  Ex Scripts:FC"+#LF$) : EndIf
    If UM_Database()\UM_IB : Add_Script("  Ex Scripts:IB"+#LF$) : EndIf
    If UM_Database()\UM_BW : Add_Script("  Ex Scripts:BW"+#LF$) : EndIf
    Add_Script(" Endif"+#LF$)
    
    ; Raspberry Pi
    
    Add_Script(#LF$)
    Add_Script(" ; Raspberry Pi Settings"+#LF$)
    Add_Script(#LF$)
    Add_Script(" If $HW EQ "+#DOUBLEQUOTE$+"Pi"+#DOUBLEQUOTE$+#LF$)
    If UM_Database()\UM_7Mhz
      Add_Script("  Ex Scripts:A500_Speed_NC"+#LF$)
    EndIf
    If Not UM_Database()\UM_7Mhz And Not UM_Database()\UM_25Mhz
      Add_Script("  Ex Scripts:A1200_Speed_NC"+#LF$)
    EndIf
    If UM_Database()\UM_25Mhz
      add_script("  Ex Scripts:A4000_Speed"+#LF$)
    EndIf 
    If UM_Database()\UM_Max
      add_script("  Ex Scripts:Max_Speed"+#LF$)
    EndIf 
    If UM_Database()\UM_IB : Add_Script("  Ex Scripts:IB"+#LF$) : EndIf
    If UM_Database()\UM_BW : Add_Script("  Ex Scripts:BW"+#LF$) : EndIf
    Add_Script(" Endif"+#LF$)
    
    ; WinUAE
    
    Add_Script(#LF$)
    Add_Script(" ; UAE Settings"+#LF$)
    Add_Script(#LF$)
    multiplier="2"
    Add_Script(" If $HW EQ "+#DOUBLEQUOTE$+"UAE"+#DOUBLEQUOTE$+#LF$)
    If UM_Database()\UM_7Mhz
      If UM_Database()\UM_NoCycle
        Add_Script("  Ex Scripts:A500_Speed_NC"+#LF$)
      Else
        Add_Script("  Ex Scripts:A500_Speed"+#LF$)
      EndIf
    EndIf
    If Not UM_Database()\UM_7Mhz And Not UM_Database()\UM_25Mhz
      If UM_Database()\UM_NoCycle
        Add_Script("  Ex Scripts:A1200_Speed_NC"+#LF$)
      Else
        Add_Script("  Ex Scripts:A1200_Speed"+#LF$)
      EndIf
    EndIf
    If UM_Database()\UM_25Mhz
      Add_Script("  Ex Scripts:A4000_Speed"+#LF$)
    EndIf 
    If UM_Database()\UM_Max
      add_script("  Ex Scripts:Max_Speed"+#LF$)
    EndIf 
    If UM_Database()\UM_IB : Add_Script("  Ex Scripts:IB"+#LF$) : EndIf
    Add_Script(" Endif"+#LF$)
    
    Add_Script(#LF$)
    Add_Script("Endif"+#LF$)
    
  EndIf
  
  ; Run the game
  
  Add_Script(#LF$)
  Add_Script("; Run The Game"+#LF$)
  Add_Script(#LF$)
  Add_Script("Ex Scripts:File_Log "+#DOUBLEQUOTE$+UM_Database()\UM_Short+Tags_Short()+#DOUBLEQUOTE$+#LF$)
  If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Beta_Type="Demo"
    Add_Script("cd "+#DOUBLEQUOTE$+"WHD_Demos:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+#DOUBLEQUOTE$+#LF$)
  Else
    Add_Script("cd "+#DOUBLEQUOTE$+"WHD_Games:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+#DOUBLEQUOTE$+#LF$)
  EndIf
  
  Add_Script("kgiconload "+UM_Database()\UM_Icon+#LF$)
  Add_Script(#LF$)
  
  ; Cleanup
  
  Add_Script("; Cleanup"+#LF$)
  Add_Script(#LF$)
  Add_Script("LAB Clean-Up"+#LF$)
  If Real=#False
    Add_Script("Ex Scripts:Speed_Reset"+#LF$)  
  EndIf
  Add_Script("UnSet XFave"+#LF$)
  Add_Script("UnSet XPath"+#LF$)
  Add_Script("UnSet XFile"+#LF$)
  Add_Script("UnSet XFolder"+#LF$)
  Add_Script("UnSet XInfo"+#LF$)
  Add_Script("UnSet XType"+#LF$)
  Add_Script("UnSet XSubfolder"+#LF$)
  Add_Script("Ex Scripts:Play_Module"+#LF$)
  Add_Script("AGS:"+#LF$)
  
  If CreateFile(0,info_path+".run")
    ForEach script()
      WriteString(0,script(),#PB_Ascii)
    Next
    CloseFile(0)
  EndIf
  
EndMacro

Macro Make_AGS_ReadMe(info_path)
  
  ClearList(script())
  Add_Script("If $HW EQ "+#DOUBLEQUOTE$+"Mini"+#DOUBLEQUOTE$+#LF$)
  Add_Script(" Bastyplayer >NIL: x"+#LF$)
  Add_Script("Endif"+#LF$)
  Add_Script(""+#LF$)
  Add_Script("Cls"+#LF$)
  Add_Script(""+#LF$)
  Add_Script("CD AGS_Drive:"+UM_Database()\UM_Type+"/"+UM_Database()\UM_Subfolder+"/"+UM_Database()\UM_Folder+#LF$)
  Add_Script("Multiview readme"+#LF$)
  Add_Script(""+#LF$)
  Add_Script("If $HW EQ "+#DOUBLEQUOTE$+"Mini"+#DOUBLEQUOTE$+#LF$)
  Add_Script(" Ex Scripts:Play_Module"+#LF$)
  Add_Script("Endif"+#LF$)
  Add_Script(""+#LF$)
  Add_Script("AGS:")
  
  If FileSize(info_path+"run")>0 : info_path+"("+UM_Database()\UM_Type+")" : EndIf
  
  If CreateFile(0,info_path+".run")
    ForEach script()
      WriteString(0,script(),#PB_Ascii)
    Next
    CloseFile(0)
  EndIf
  
EndMacro

Macro Make_AGS_Info(info_path)
  
  ClearList(script())
  
  If Len(UM_Database()\UM_Title)>38
    i_path=Mid(" "+UM_Database()\UM_Title,1,39)
    Add_Script(i_path+#LF$)
  Else
    i_path=RSet(" "+UM_Database()\UM_Title,Len(UM_Database()\UM_Title)+((39-Len(UM_Database()\UM_Title))/2))
    Add_Script(i_path+#LF$)
  EndIf
  
  If UM_Database()\UM_Type<>"Demo" And UM_Database()\UM_Type<>"Magazine"
    i_path=RSet(" Developed By "+UM_Database()\UM_Developer,Len("Developed By "+UM_Database()\UM_Developer)+((39-Len("Developed By "+UM_Database()\UM_Developer))/2))
    If Len(i_path)>38 : i_path=Mid(i_path,1,39) : EndIf
    Add_Script(i_path+#LF$)
  Else
    Add_Script(#LF$)
  EndIf
  i_path=RSet("© "+UM_Database()\UM_Year+" "+UM_Database()\UM_Publisher,Len("© "+UM_Database()\UM_Year+" "+UM_Database()\UM_Publisher)+((38-Len("© "+UM_Database()\UM_Year+" "+UM_Database()\UM_Publisher))/2))
  If Len(i_path)>38 : i_path=Mid(i_path,1,39) : EndIf
  Add_Script(i_path+#LF$)
  Add_Script(#LF$)
  Add_Script(" Genre : "+UM_Database()\UM_Genre+#LF$) 
  If UM_Database()\UM_Type<>"Demo" And UM_Database()\UM_Type<>"Magazine" And UM_Database()\UM_Beta_Type<>"Demo"
    Add_Script(" Players     : "+UM_Database()\UM_Players+#LF$)
  Else
    If UM_Database()\UM_Party<>""
      i_path=" Party : "+UM_Database()\UM_Party
      Add_Script(i_path+#LF$)
    EndIf
  EndIf
  If UM_Database()\UM_NTSC
    Add_Script(" Display Type: NTSC"+#LF$)
  Else
    Add_Script(" Display Type: PAL"+#LF$)
  EndIf
  Add_Script(" Language    : "+UM_Database()\UM_Language+#LF$)
  If UM_Database()\UM_AGA=#False And UM_Database()\UM_CD32=#False
    If UM_Database()\UM_ECS
      Add_Script(" Chipset     : ECS"+#LF$)
    EndIf
    If UM_Database()\UM_OCS
      Add_Script(" Chipset     : OCS"+#LF$)
    EndIf
    If UM_Database()\UM_CDTV
      Add_Script(" Hardware    : CDTV")
    ElseIf UM_Database()\UM_Arcadia
      Add_Script(" Hardware    : Arcadia")
    Else
      If UM_Database()\UM_OCS
        Add_Script(" Hardware    : A500/1000/2000"+#LF$)
      Else
        Add_Script(" Hardware    : A500/600/2000/3000")
      EndIf
    EndIf
  Else
    Add_Script(" Chipset     : AGA"+#LF$)
    If UM_Database()\UM_CD32
      Add_Script(" Hardware    : CD32")
    Else
      Add_Script(" Hardware    : A1200/4000")
    EndIf
  EndIf
  
  If CreateFile(0,info_path+".txt",#PB_Ascii)
    ForEach script()
      WriteString(0,script(),#PB_Ascii)
    Next
    CloseFile(0)
  EndIf
  
EndMacro

Macro Add_Check()
  
  AddElement(Check_List())
  Check_List()=GetCurrentDirectory()+UM_Database()\UM_Short+Tags_Short()+".run"
  AddElement(Check_List())
  Check_List()=GetCurrentDirectory()+UM_Database()\UM_Short+Tags_Short()+".txt"
  AddElement(Check_List())
  Check_List()=GetCurrentDirectory()+UM_Database()\UM_Short+Tags_Short()+"-1.iff"
  AddElement(Check_List())
  Check_List()=GetCurrentDirectory()+UM_Database()\UM_Short+Tags_Short()+"-2.iff"
  AddElement(Check_List())
  Check_List()=GetCurrentDirectory()+UM_Database()\UM_Short+Tags_Short()+"-3.iff"
  
EndMacro

Macro Create_Data()
  
  Add_Check()
  Make_AGS_Run(UM_Database()\UM_Short+Tags_Short())
  Make_AGS_Info(UM_Database()\UM_Short+Tags_Short())
  Make_AGS_Image(UM_Database()\UM_Short+Tags_Short()) 
  
EndMacro

Procedure Create_AGS_Single()
  
  Protected file, script.s, commands.s, commands_jit.s, source_folder$, source_file$, new_file$, dest_folder$, old_pos.i, slave.s ; short_name.s
  Protected out_folder.s, key$, force_iff.b, set_type.i, Real.b, ECS.b, current_index.i, make_images.b, ans.i, a500_mini.b, ans2.i, i_path.s
  
  Protected.s CPU, FC, IB, NTSC, VRES, VHeight, CYCLE, OFFSET
  Protected NewList script.s()
  
  Protected multiplier.s
  
  force_iff=#False
  set_type=0
  a500_mini=#False
  old_pos=List_Numbers()\L_Number
  current_index=ListIndex(UM_Database())
  
  OpenConsole("Creating AGS Folder")
  Center_Console()  
  
  PrintN("Creating config files for "+UM_Database()\UM_Title+Tags()+"...")
  
  AGS_Path=PathRequester("Output Path",Home_Path)
  
  If AGS_Path<>""  
    
    ans=MessageRequester("Information","Include Images?",#PB_MessageRequester_YesNoCancel|#PB_MessageRequester_Info)
    If ans=#PB_MessageRequester_Yes
      make_images=#True
    ElseIf ans=#PB_MessageRequester_No
      make_images=#False
    ElseIf ans=#PB_MessageRequester_Cancel
      Goto Proc_Exit
    EndIf
    
    ans=MessageRequester("Information","AGS Classic Setup?",#PB_MessageRequester_YesNoCancel|#PB_MessageRequester_Info)
    
    If ans=#PB_MessageRequester_Yes
      Real=#True 
      ans2=MessageRequester("Information","A500 Mini Classic?",#PB_MessageRequester_YesNoCancel|#PB_MessageRequester_Info)
      If ans2=#PB_MessageRequester_Yes
        a500_mini=#True
      ElseIf ans2=#PB_MessageRequester_No
        a500_mini=#False
      ElseIf ans2=#PB_MessageRequester_Cancel
        MessageRequester("Error","Process Cancelled",#PB_MessageRequester_Ok)
        Goto Proc_Exit
      EndIf
      ans2=MessageRequester("Information","ECS Images?",#PB_MessageRequester_YesNoCancel|#PB_MessageRequester_Info)
      If ans2=#PB_MessageRequester_Yes
        ECS=#True
      ElseIf ans2=#PB_MessageRequester_No
        ECS=#False
      ElseIf ans2=#PB_MessageRequester_Cancel
        MessageRequester("Error","Process Cancelled",#PB_MessageRequester_Ok)
        Goto Proc_Exit
      EndIf  
    ElseIf ans=#PB_MessageRequester_No
      Real=#False
    ElseIf ans=#PB_MessageRequester_Cancel
      MessageRequester("Error","Process Cancelled",#PB_MessageRequester_Ok)
      Goto Proc_Exit
    EndIf
    
    Protected NewList Sort_List.Sort_DB() ; Needed for Games by Theme
    Protected NewMap Search_Map.i()
    
    ClearList(Sort_List())
    ClearList(File_List())
    
    Protected NewList Check_List.s()  
    
    SelectElement(UM_Database(),List_Numbers()\L_Number)
    
    Search_Map(LCase(UM_Database()\UM_Icon))=ListIndex(UM_Database())
    
    List_Files_Recursive(Data_Path+"UM_Themes",File_List(),"*.txt")
    
    CreateDirectory(AGS_Path+UM_Database()\UM_Folder)
    
    ForEach File_List()
      If ReadFile(0,File_List())
        Repeat
          path=ReadString(0)
          If path<>""
            AddElement(Sort_List())
            Sort_List()\S_Name=LCase(path+".info")
          EndIf
        Until Eof(0)
        CloseFile(0)
      EndIf
      If ListSize(Sort_List())>0       
        PrintN("Adding "+GetFilePart(File_List(),#PB_FileSystem_NoExtension)+" files...")
        ForEach Sort_List()
          If FindMapElement(Search_Map(),Sort_List()\S_Name)
            SelectElement(UM_Database(),Search_Map())
            PrintN("Processing: "+UM_Database()\UM_Title+Tags())
            out_folder="\"+UM_Database()\UM_Folder+"\+  Games - By Theme.ags\"
            path=GetFilePart(File_List(),#PB_FileSystem_NoExtension) 
            current_folder="+  Games - By Theme.ags/"+path+".ags"+"/"
            If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
            If FileSize(AGS_Path+out_folder+path+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+path+".ags") : EndIf
            SetCurrentDirectory(AGS_Path+out_folder+path+".ags")
            Create_Data()
          EndIf
        Next
        ClearList(Sort_List())
      EndIf  
    Next
    
    FreeMap(Search_Map())
    FreeList(Sort_List())
    
    SelectElement(UM_Database(),List_Numbers()\L_Number)
    
    PrintN("Processing: "+UM_Database()\UM_Title+Tags())
    
    out_folder="\"+UM_Database()\UM_Folder+"\Readme Files.ags\"
    If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
    If FileSize(AGS_Path+out_folder+UM_Database()\UM_Subfolder+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+UM_Database()\UM_Subfolder+".ags") : EndIf
    SetCurrentDirectory(AGS_Path+out_folder+UM_Database()\UM_Subfolder+".ags")
    Make_AGS_ReadMe(UM_Database()\UM_Short+Tags_Short())  
    
    If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game" ; Only Adds games or beta games
      
      If UM_Database()\UM_Language="English" And UM_Database()\UM_Adult<>#True ; Add only english and non adult games
        
        If UM_Database()\UM_Beta=#True
          out_folder="\"+UM_Database()\UM_Folder+"\+  Games - Beta.ags\"
          current_folder="+  Games - Beta.ags/"+UM_Database()\UM_Subfolder+".ags/"
          If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
          If FileSize(AGS_Path+out_folder+UM_Database()\UM_Subfolder+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+UM_Database()\UM_Subfolder+".ags") : EndIf
          SetCurrentDirectory(AGS_Path+out_folder+UM_Database()\UM_Subfolder+".ags")
          Create_Data() 
        EndIf
        
        If UM_Database()\UM_AGA=#True And UM_Database()\UM_CD32<>#True
          out_folder="\"+UM_Database()\UM_Folder+"\+  Games - AGA.ags\"
          current_folder="+  Games - AGA.ags/"+UM_Database()\UM_Subfolder+".ags"+"/"
          If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
          If FileSize(AGS_Path+out_folder+UM_Database()\UM_Subfolder+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+UM_Database()\UM_Subfolder+".ags") : EndIf
          SetCurrentDirectory(AGS_Path+out_folder+UM_Database()\UM_Subfolder+".ags")
          Create_Data() 
        EndIf
        
        out_folder="\"+UM_Database()\UM_Folder+"\+  Games - 0-Z.ags\"
        current_folder="+  Games - 0-Z.ags/"+UM_Database()\UM_Subfolder+".ags"+"/"
        If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
        If FileSize(AGS_Path+out_folder+UM_Database()\UM_Subfolder+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+UM_Database()\UM_Subfolder+".ags") : EndIf
        SetCurrentDirectory(AGS_Path+out_folder+UM_Database()\UM_Subfolder+".ags")
        Create_Data()        
        
        out_folder="\"+UM_Database()\UM_Folder+"\+  Games - By Publisher.ags\"
        current_folder="+  Games - By Publisher.ags/"+UM_Database()\UM_Publisher+".ags"+"/"
        If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
        If FileSize(AGS_Path+out_folder+UM_Database()\UM_Publisher+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+UM_Database()\UM_Publisher+".ags") : EndIf
        SetCurrentDirectory(AGS_Path+out_folder+UM_Database()\UM_Publisher+".ags")
        Create_Data()  
        
        If UM_Database()\UM_Players="2"
          out_folder="\"+UM_Database()\UM_Folder+"\+  Games - Multiplayer.ags\"
          path=LCase(Left(UM_Database()\UM_Title,1))
          Select path
            Case "0","1","2","3","4","5","6","7","8","9","0","a","b","c","d"
              If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
              If FileSize(AGS_Path+out_folder+"2 Players 0-D.ags")=-1 : CreateDirectory(AGS_Path+out_folder+"2 Players 0-D.ags") : EndIf
              SetCurrentDirectory(AGS_Path+out_folder+"2 Players 0-D.ags")
              current_folder="+  Games - Multiplayer.ags/2 Players 0-D.ags/"
            Case "e","f","g","h","i"
              If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
              If FileSize(AGS_Path+out_folder+"2 Players E-I.ags")=-1 : CreateDirectory(AGS_Path+out_folder+"2 Players E-I.ags") : EndIf
              SetCurrentDirectory(AGS_Path+out_folder+"2 Players E-I.ags")
              current_folder="+  Games - Multiplayer.ags/2 Players E-I.ags/"
            Case "j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"
              If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
              If FileSize(AGS_Path+out_folder+"2 Players J-Z.ags")=-1 : CreateDirectory(AGS_Path+out_folder+"2 Players J-Z.ags") : EndIf
              SetCurrentDirectory(AGS_Path+out_folder+"2 Players J-Z.ags")
              current_folder="+  Games - Multiplayer.ags/2 Players J-Z.ags/"
          EndSelect
          Create_Data()      
        EndIf
        
        If UM_Database()\UM_Players="3"
          out_folder="\"+UM_Database()\UM_Folder+"\+  Games - Multiplayer.ags\"  
          current_folder="+  Games - Multiplayer.ags/3 Players.ags/"
          If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
          If FileSize(AGS_Path+out_folder+"3 Players.ags")=-1 : CreateDirectory(AGS_Path+out_folder+"3 Players.ags") : EndIf
          SetCurrentDirectory(AGS_Path+out_folder+"3 Players.ags")
          Create_Data()    
        EndIf
        
        If UM_Database()\UM_Players="4"
          out_folder="\"+UM_Database()\UM_Folder+"\+  Games - Multiplayer.ags\" 
          current_folder="+  Games - Multiplayer.ags/4 Players.ags/"
          If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
          If FileSize(AGS_Path+out_folder+"4 Players.ags")=-1 : CreateDirectory(AGS_Path+out_folder+"4 Players.ags") : EndIf
          SetCurrentDirectory(AGS_Path+out_folder+"4 Players.ags")
          Create_Data()     
        EndIf
        
        If UM_Database()\UM_Players<>"1" And UM_Database()\UM_Players<>"2" And UM_Database()\UM_Players<>"3" And UM_Database()\UM_Players<>"4"
          out_folder="\"+UM_Database()\UM_Folder+"\+  Games - Multiplayer.ags\"
          current_folder="+  Games - Multiplayer.ags/5+ Players.ags/"
          If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
          If FileSize(AGS_Path+out_folder+"5+ Players.ags")=-1 : CreateDirectory(AGS_Path+out_folder+"5+ Players.ags") : EndIf
          SetCurrentDirectory(AGS_Path+out_folder+"5+ Players.ags")
          Create_Data()     
        EndIf
        
        If UM_Database()\UM_Emerald=#True
          out_folder="\"+UM_Database()\UM_Folder+"\+  Games - Emerald Mines.ags\" 
          current_folder="+  Games - Emerald Mines.ags/"
          If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
          SetCurrentDirectory(AGS_Path+out_folder)
          Create_Data()  
        EndIf
        
        If UM_Database()\UM_CD32=#True
          out_folder="\"+UM_Database()\UM_Folder+"\+  Games - By System.ags\"   
          current_folder="+  Games - By System.ags/"   
          If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
          If FileSize(AGS_Path+out_folder+"CD32.ags")=-1 : CreateDirectory(AGS_Path+out_folder+"CD32.ags") : EndIf
          SetCurrentDirectory(AGS_Path+out_folder+"CD32.ags")
          Create_Data()
        EndIf
        
        If UM_Database()\UM_CDTV=#True
          out_folder="\"+UM_Database()\UM_Folder+"\+  Games - By System.ags\"   
          current_folder="+  Games - By System.ags/"   
          If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
          If FileSize(AGS_Path+out_folder+"CDTV.ags")=-1 : CreateDirectory(AGS_Path+out_folder+"CDTV.ags") : EndIf
          SetCurrentDirectory(AGS_Path+out_folder+"CDTV.ags")
          Create_Data() 
        EndIf
        
        If UM_Database()\UM_Arcadia=#True
          out_folder="\"+UM_Database()\UM_Folder+"\+  Games - By System.ags\" 
          current_folder="+  Games - By System.ags/" 
          If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
          If FileSize(AGS_Path+out_folder+"Arcadia.ags")=-1 : CreateDirectory(AGS_Path+out_folder+"Arcadia.ags") : EndIf
          SetCurrentDirectory(AGS_Path+out_folder+"Arcadia.ags")
          Create_Data()
        EndIf
        
        If UM_Database()\UM_MT32=#True
          out_folder="\"+UM_Database()\UM_Folder+"\+  Games - MT32.ags\"    
          current_folder="+  Games - MT32.ags/"    
          If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
          SetCurrentDirectory(AGS_Path+out_folder)
          Create_Data()
        EndIf
        
        If UM_Database()\UM_NTSC=#True
          out_folder="\"+UM_Database()\UM_Folder+"\+  Games - NTSC.ags\"   
          current_folder="+  Games - NTSC.ags/"  
          If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
          SetCurrentDirectory(AGS_Path+out_folder)
          Create_Data() 
        EndIf
        
        out_folder="\"+UM_Database()\UM_Folder+"\+  Games - By Year.ags\"
        current_folder="+  Games - By Year.ags/"+UM_Database()\UM_Year+".ags/"
        If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
        If FileSize(AGS_Path+out_folder+UM_Database()\UM_Year+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+UM_Database()\UM_Year+".ags") : EndIf
        SetCurrentDirectory(AGS_Path+out_folder+UM_Database()\UM_Year+".ags")
        Create_Data()  
        
        out_folder="\"+UM_Database()\UM_Folder+"\+  Games - By Genre.ags\"  
        current_folder="+  Games - By Genre.ags/"+ReplaceString(UM_Database()\UM_Genre," / "," ")+".ags/"
        If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
        If FileSize(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Genre," / "," ")+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Genre," / "," ")+".ags") : EndIf
        SetCurrentDirectory(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Genre," / "," ")+".ags")
        Create_Data()  
        
      EndIf ; End of adult and english if statement
      
      If UM_Database()\UM_Adult<>#True And UM_Database()\UM_Language<>"English"
        out_folder="\"+UM_Database()\UM_Folder+"\+  Games - Non English.ags\"
        current_folder="+  Games - Non English.ags/"+UM_Database()\UM_Language+".ags/"
        If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
        If FileSize(AGS_Path+out_folder+UM_Database()\UM_Language)=-1 : CreateDirectory(AGS_Path+out_folder+UM_Database()\UM_Language+".ags") : EndIf
        SetCurrentDirectory(AGS_Path+out_folder+UM_Database()\UM_Language+".ags")
        Create_Data()   
      EndIf
      
      If UM_Database()\UM_Adult=#True
        out_folder="\"+UM_Database()\UM_Folder+"\+  Games - Adult.ags\"
        current_folder=UM_Database()\UM_Folder+"/+  Games - Adult.ags/"
        If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
        If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
        SetCurrentDirectory(AGS_Path+out_folder)
        Create_Data()  
      EndIf
      
    EndIf ; End  of game if statement
    
    If UM_Database()\UM_Type="Magazine"
      out_folder="\"+UM_Database()\UM_Folder+"\-  Disk Magazines.ags\"
      current_folder=UM_Database()\UM_Folder+"/-  Disk Magazines.ags/"
      If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
      If FileSize(AGS_Path+out_folder+UM_Database()\UM_Subfolder+".ags")=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
      SetCurrentDirectory(AGS_Path+out_folder)
      Create_Data()    
    EndIf
    
    If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Beta_Type="Demo"
      
      If UM_Database()\UM_Adult<>#True
        out_folder="\"+UM_Database()\UM_Folder+"\-  Demos - 0-Z.ags\"
        current_folder=UM_Database()\UM_Folder+"/-  Demos - 0-Z.ags/"+UM_Database()\UM_Subfolder+".ags/"
        If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
        If FileSize(AGS_Path+out_folder+UM_Database()\UM_Subfolder+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+UM_Database()\UM_Subfolder+".ags") : EndIf
        SetCurrentDirectory(AGS_Path+out_folder+UM_Database()\UM_Subfolder+".ags")
        Create_Data()     
        
        out_folder="\"+UM_Database()\UM_Folder+"\-  Demos - By Group.ags\"
        current_folder=UM_Database()\UM_Folder+"/-  Demos - By Group.ags/"+UM_Database()\UM_Publisher+".ags/"
        If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
        If FileSize(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Publisher," / "," ")+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Publisher," / "," ")+".ags") : EndIf
        SetCurrentDirectory(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Publisher," / "," ")+".ags") 
        Create_Data()   
        
        out_folder="\"+UM_Database()\UM_Folder+"\-  Demos - By Year.ags\"
        current_folder=UM_Database()\UM_Folder+"/-  Demos - By Year.ags/"+UM_Database()\UM_Year+".ags/"
        If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
        If FileSize(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Year," / "," ")+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Year," / "," ")+".ags") : EndIf
        SetCurrentDirectory(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Year," / "," ")+".ags")
        Create_Data() 
        
        out_folder="\"+UM_Database()\UM_Folder+"\-  Demos - By Genre.ags\" 
        current_folder=UM_Database()\UM_Folder+"/-  Demos - By Genre.ags/"+ReplaceString(UM_Database()\UM_Genre," / "," ")+".ags/"
        If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
        If FileSize(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Genre," / "," ")+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Genre," / "," ")+".ags") : EndIf
        SetCurrentDirectory(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Genre," / "," ")+".ags")
        Create_Data()   
        
        If UM_Database()\UM_AGA=#True
          out_folder="\"+UM_Database()\UM_Folder+"\-  Demos - AGA.ags\" 
          current_folder=UM_Database()\UM_Folder+"/-  Demos - AGA.ags/"+UM_Database()\UM_Subfolder+".ags/"
          If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
          If FileSize(AGS_Path+out_folder+UM_Database()\UM_Subfolder+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+UM_Database()\UM_Subfolder+".ags") : EndIf
          SetCurrentDirectory(AGS_Path+out_folder+UM_Database()\UM_Subfolder+".ags")
          Create_Data()  
        EndIf  
        
      EndIf ; End if adult if statement
      
      If UM_Database()\UM_Adult=#True
        out_folder="\"+UM_Database()\UM_Folder+"\-  Demos - Adult.ags\"
        current_folder=UM_Database()\UM_Folder+"/-  Demos - Adult.ags/"
        If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
        If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
        SetCurrentDirectory(AGS_Path+out_folder)
        Create_Data()            
      EndIf
      
    EndIf ; End of demo if statement
    
    CreateDirectory(AGS_Path+"Search.ags")
    If ECS
      Make_AGS_Guide(AGS_Path+"Search.ags\WHDLoad_Game_List.guide",#True,#True)
          Make_AGS_Demos_Guide(AGS_Path+"Search.ags\WHDLoad_Demo_List.guide",#True,#True)
    Else
      Make_AGS_Guide(AGS_Path+"Search.ags\WHDLoad_Game_List.guide",#True,#False)
          Make_AGS_Demos_Guide(AGS_Path+"Search.ags\WHDLoad_Demo_List.guide",#True,#False)
    EndIf
    Write_Guide_Single(AGS_Path,#True)
    
    CreateDirectory(AGS_Path+"IGame")
    
    Save_GL_CSV(AGS_Path+"IGame\gameslist.csv",0,#False,#True)
    Save_GL_CSV(AGS_Path+"IGame\gameslist_noadult.csv",1,#False,#True)
    Save_GL_CSV(AGS_Path+"IGame\gameslist_games.csv",2,#False,#True)
    Save_GL_CSV(AGS_Path+"IGame\gameslist_gamesnoadult.csv",3,#False,#True)
    Save_GL_CSV(AGS_Path+"IGame\gameslist_demos.csv",4,#False,#True)
    Save_GL_CSV(AGS_Path+"IGame\gameslist_demosnoadult.csv",5,#False,#True)
    Save_GL_CSV(AGS_Path+"IGame\gameslist_A500.csv",0,#True,#True)
    Save_GL_CSV(AGS_Path+"IGame\gameslist_noadult_A500.csv",1,#True,#True)
    Save_GL_CSV(AGS_Path+"IGame\gameslist_games_A500.csv",2,#True,#True)
    Save_GL_CSV(AGS_Path+"IGame\gameslist_gamesnoadult_A500.csv",3,#True,#True)
    Save_GL_CSV(AGS_Path+"IGame\gameslist_demos_A500.csv",4,#True,#True)
    Save_GL_CSV(AGS_Path+"IGame\gameslist_demosnoadult_A500.csv",5,#True,#True)
    
    CopyFile(Data_Path+"genres",AGS_Path+"IGame\genres")
    CopyFile(Data_Path+"genres_demos",AGS_Path+"IGame\genres_demos")
    CopyFile(Data_Path+"genres_games",AGS_Path+"IGame\genres_games")
    
    CreateDirectory(AGS_Path+"Scripts")
    
    CreateFile(0,AGS_Path+"Scripts\Random_Game",#PB_Ascii) 
    CreateFile(1,AGS_Path+"Scripts\Random_Demo",#PB_Ascii) 
    
    ForEach UM_Database()
      If ECS And UM_Database()\UM_AGA
        Continue
      EndIf
      
      If UM_Database()\UM_Language="English" And UM_Database()\UM_Adult<>#True
        If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
          path="AGS:+  Games - 0-Z.ags/"+UM_Database()\UM_Subfolder+".ags/"+UM_Database()\UM_Short+Tags_Short()+".run"
          WriteString(0,"Ex "+#DOUBLEQUOTE$+path+#DOUBLEQUOTE$+#LF$)
        EndIf
        If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Beta_Type="Demo"
          path="AGS:-  Demos - 0-Z.ags/"+UM_Database()\UM_Subfolder+".ags/"+UM_Database()\UM_Short+Tags_Short()+".run"
          WriteString(1,"Ex "+#DOUBLEQUOTE$+path+#DOUBLEQUOTE$+#LF$)
        EndIf
        If UM_Database()\UM_Type="Magazine"
          path="AGS:-  Disk Magazines.ags/"+UM_Database()\UM_Short+Tags_Short()+".run"
          WriteString(1,"Ex "+#DOUBLEQUOTE$+path+#DOUBLEQUOTE$+#LF$)
        EndIf
      EndIf
    Next
    CloseFile(0)
    CloseFile(1)
    
  EndIf ; End of output path if statement
  
  Proc_Exit:
  
  Delay(1500)
  
  CloseConsole()
  
  FreeList(Sort_List())
  
  FreeList(script())
  
  SetCurrentDirectory(Home_Path)
  
  SelectElement(UM_Database(),old_pos)
  
EndProcedure

Procedure Folder_Return_Text(fpath.s)
  
  Protected description$
  
  description$=" **************************************** "+#LF$
  description$+" *                                      * "+#LF$
  description$+" *                                      * "+#LF$
  description$+" *                                      * "+#LF$
  description$+" *       Return to previous menu...     * "+#LF$
  description$+" *                                      * "+#LF$
  description$+" *                                      * "+#LF$
  description$+" *                                      * "+#LF$
  description$+" *                                      * "+#LF$
  description$+" **************************************** "
  
  CreateFile(#FILE,fpath)
  WriteString(#FILE,description$)
  CloseFile(#FILE)
  
EndProcedure
  
Procedure Create_AGS_Files()
  
  Protected file, script.s, commands.s, commands_jit.s, source_folder$, source_file$, new_file$, dest_folder$, old_pos.i, slave.s, icon.s
  Protected out_folder.s, key$, force_iff.b, set_type.i, Real.b, ECS.b, ans.i, ans2.i, make_images.b, a500_mini.b, ex_path.s, i_path.s
  
  Protected.s CPU, FC, IB, NTSC, VRES, VHeight, CYCLE, OFFSET
  
  Protected NewList script.s()
  Protected NewList random_script.s()
  
  Protected multiplier.s
  
  make_images=#True
  force_iff=#False
  a500_mini=#False
  set_type=0
  old_pos=List_Numbers()\L_Number
  
  OpenConsole("Creating AGS Files (Press Escape to cancel...)")
  Center_Console()  
  
  PrintN("Creating configs...")
  
  AGS_Path=PathRequester("Output Path",Home_Path)
  
  If AGS_Path<>""
    
    ans=MessageRequester("Information","Create images?",#PB_MessageRequester_YesNoCancel|#PB_MessageRequester_Info)
    
    If ans=#PB_MessageRequester_Yes
      make_images=#True
    ElseIf ans=#PB_MessageRequester_No
      make_images=#False
    ElseIf ans=#PB_MessageRequester_Cancel
      Goto Proc_Exit
    EndIf     
    
    ans=MessageRequester("Information","AGS Classic Setup?",#PB_MessageRequester_YesNoCancel|#PB_MessageRequester_Info)
    
    If ans=#PB_MessageRequester_Yes
      Real=#True 
      ans2=MessageRequester("Information","A500 Mini Classic?",#PB_MessageRequester_YesNoCancel|#PB_MessageRequester_Info)
      If ans2=#PB_MessageRequester_Yes
        a500_mini=#True
      ElseIf ans2=#PB_MessageRequester_No
        a500_mini=#False
      ElseIf ans2=#PB_MessageRequester_Cancel
        MessageRequester("Error","Process Cancelled",#PB_MessageRequester_Ok)
        Goto Proc_Exit
      EndIf
      ans2=MessageRequester("Information","ECS Images?",#PB_MessageRequester_YesNoCancel|#PB_MessageRequester_Info)
      If ans2=#PB_MessageRequester_Yes
        ECS=#True
      ElseIf ans2=#PB_MessageRequester_No
        ECS=#False
      ElseIf ans2=#PB_MessageRequester_Cancel
        MessageRequester("Error","Process Cancelled",#PB_MessageRequester_Ok)
        Goto Proc_Exit
      EndIf  
    ElseIf ans=#PB_MessageRequester_No
      Real=#False
    ElseIf ans=#PB_MessageRequester_Cancel
      MessageRequester("Error","Process Cancelled",#PB_MessageRequester_Ok)
      Goto Proc_Exit
    EndIf
    
    If make_images=#True
      ans=MessageRequester("Information","Force IFF creation?",#PB_MessageRequester_YesNoCancel|#PB_MessageRequester_Info)
      If ans=#PB_MessageRequester_Yes
        force_iff=#True
      ElseIf ans=#PB_MessageRequester_No
        force_iff=#False
      ElseIf ans=#PB_MessageRequester_Cancel
        MessageRequester("Error","Process Cancelled",#PB_MessageRequester_Ok)
        Goto Proc_Exit
      EndIf
    EndIf
        
    Protected NewList Sort_List.Sort_DB()
    Protected NewMap Search_Map.i()
    Protected NewMap Game_Search_Map.i()
    Protected NewMap Demo_Search_Map.i()
    Protected NewList Missing_List.s()
    
    ClearList(Sort_List())
    ClearList(File_List())
    ClearMap(Search_Map())
    ClearMap(Game_Search_Map())
    ClearMap(Demo_Search_Map())
    
    Protected NewList Check_List.s()  
    
    If AGS_Path<>""
      
      ForEach UM_Database()
        
        If FindString(UM_Database()\UM_Title, "Emerald Mine") : UM_Database()\UM_Emerald=#True : UM_Database()\UM_14Mhz=#True : Else : UM_Database()\UM_Emerald=#False : EndIf
        
        If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
          Game_Search_Map(LCase(UM_Database()\UM_Icon))=ListIndex(UM_Database())
        EndIf
        
        If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Beta_Type="Demo"
          Demo_Search_Map(LCase(UM_Database()\UM_Icon))=ListIndex(UM_Database())
        EndIf
        
      Next
      
      List_Files_Recursive(Data_Path+"UM_Themes",File_List(),"*.txt")
      
      Protected Keypressed$, Quit.b
      
      ForEach File_List()
        
        If ReadFile(0,File_List())
          Repeat
            path=ReadString(0)
            If path="*Game*" : ClearMap(Search_Map()) : CopyMap(Game_Search_Map(),Search_Map()) : Continue : EndIf
            If path="*Demo*" : ClearMap(Search_Map()) : CopyMap(Demo_Search_Map(),Search_Map()) : Continue : EndIf
            If path<>""
              AddElement(Sort_List())
              Sort_List()\S_Name=LCase(path+".info")
            EndIf
          Until Eof(0)
          CloseFile(0)
        EndIf
        
        If ListSize(Sort_List())>0       
          
          PrintN("Adding "+GetFilePart(File_List(),#PB_FileSystem_NoExtension)+" files...")
          
          ForEach Sort_List()
            If FindMapElement(Search_Map(),Sort_List()\S_Name)
              SelectElement(UM_Database(),Search_Map())
              
              If ECS 
                If UM_Database()\UM_AGA Or UM_Database()\UM_CD32
                  Continue
                EndIf
              EndIf
              
              PrintN("Processing: "+UM_Database()\UM_Title+Tags())
              
              path=GetFilePart(File_List(),#PB_FileSystem_NoExtension)
              
              If ECS
                path2="Top 200 ECS"
                path3="Top 200 AGA"
              Else
                path2="Top 200 AGA"
                path3="Top 200 ECS"
              EndIf
              
              If path=path2
                out_folder="+  Games - Top 200.ags\"
                current_folder="+  Games - Top 200.ags/"
                If FileSize(AGS_Path+out_folder)=-1 
                  CreateDirectory(AGS_Path+out_folder)
                EndIf
                SetCurrentDirectory(AGS_Path+out_folder)    
                Create_Data()
              EndIf

              If path<>path2 And path<>path3
                out_folder="+  Games - By Theme.ags\"
                current_folder="+  Games - By Theme.ags/"+path+".ags/"   
                If FileSize(AGS_Path+out_folder)=-1 
                  CreateDirectory(AGS_Path+out_folder)
                EndIf
                If FileSize(AGS_Path+out_folder+path+".ags")=-1 
                  CreateDirectory(AGS_Path+out_folder+path+".ags") 
                EndIf
                SetCurrentDirectory(AGS_Path+out_folder+path+".ags")    
                Create_Data()
              EndIf  
              
            Else 
              
              AddElement(Missing_List())
              Missing_List()=File_List()+" - "+Sort_List()\S_Name
              
            EndIf
            
          Next
          
          If ListSize(Missing_List())>0 
            DeleteFile(Home_Path+"Missing.txt")
            CreateFile(#FILE,Home_Path+"Missing.txt")
            ForEach Missing_List()
              WriteStringN(#FILE,Missing_List())
            Next
            CloseFile(#FILE)
          EndIf
        
          ClearList(Sort_List())
          
        EndIf  
        
      Next
      
      ClearMap(Search_Map())
      ClearList(Sort_List())
      
      ForEach UM_Database()
        
        If ECS And UM_Database()\UM_AGA
          Continue
        EndIf
        
        If ECS And UM_Database()\UM_CD32
          Continue
        EndIf
        
        If ECS And UM_Database()\UM_CDROM
          Continue
        EndIf
                
        AddElement(Sort_List())
        ReplaceString(UM_Database()\UM_Short,"(","")
        ReplaceString(UM_Database()\UM_Short,")","")
        Sort_List()\S_Name=UM_Database()\UM_Short+Tags_Short()
        Sort_List()\S_Type=UM_Database()\UM_Type
        Sort_List()\S_Index=ListIndex(UM_Database())
        If Left(Sort_List()\S_Name,1)>Chr(47) And Left(Sort_List()\S_Name,1)<Chr(58)
          Sort_List()\S_SubFolder="0"
        Else
          Sort_List()\S_SubFolder=Left(Sort_List()\S_Name,1)
          Sort_List()\S_SubFolder=UCase(Sort_List()\S_SubFolder)
        EndIf
        
      Next
      
      SortStructuredList(Sort_List(),#PB_Sort_Ascending|#PB_Sort_NoCase,OffsetOf(Sort_DB\S_Name),TypeOf(Sort_DB\S_Name))
     
      ForEach Sort_List() 
        
        Keypressed$=Inkey()
        If Keypressed$=Chr(27)
          PrintN("")
          PrintNCol("*** Process Cancelled ***",4,0)
          Delay(1000)
          Goto Proc_Exit
        EndIf
        
        SelectElement(UM_Database(),Sort_List()\S_Index) 
        
        PrintN("Processing: "+UM_Database()\UM_Title+Tags())
        
        out_folder="\Readme Files.ags\"
        If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
        If FileSize(AGS_Path+out_folder+Sort_List()\S_SubFolder+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+Sort_List()\S_SubFolder+".ags") : EndIf
        SetCurrentDirectory(AGS_Path+out_folder+Sort_List()\S_SubFolder+".ags")
        Add_Check()
        Make_AGS_ReadMe(UM_Database()\UM_Short+Tags_Short())  
        
        If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game" ; Only Adds games or beta games
          
          If UM_Database()\UM_Language="English" And UM_Database()\UM_Adult<>#True ; Add only english and non adult games
            
            If UM_Database()\UM_Emerald=#False   
              
              If UM_Database()\UM_Beta=#True
                out_folder="\+  Games - Beta.ags\"
                current_folder="+  Games - Beta.ags/"+Sort_List()\S_SubFolder+".ags/"
                If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
                If FileSize(AGS_Path+out_folder+Sort_List()\S_SubFolder+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+Sort_List()\S_SubFolder+".ags") : EndIf
                SetCurrentDirectory(AGS_Path+out_folder+Sort_List()\S_SubFolder+".ags")
                Create_Data() 
              EndIf
              
              If UM_Database()\UM_AGA=#True And UM_Database()\UM_CD32<>#True
                out_folder="\+  Games - AGA.ags\" 
                current_folder="+  Games - AGA.ags/"+Sort_List()\S_SubFolder+".ags/"
                If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
                If FileSize(AGS_Path+out_folder+Sort_List()\S_SubFolder+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+Sort_List()\S_SubFolder+".ags") : EndIf
                SetCurrentDirectory(AGS_Path+out_folder+Sort_List()\S_SubFolder+".ags")
                Create_Data() 
              EndIf
              
              out_folder="\+  Games - By Publisher.ags\" 
              current_folder="+  Games - By Publisher.ags/"+UM_Database()\UM_Publisher+".ags/"
              If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
              If FileSize(AGS_Path+out_folder+UM_Database()\UM_Publisher+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+UM_Database()\UM_Publisher+".ags") : EndIf
              SetCurrentDirectory(AGS_Path+out_folder+UM_Database()\UM_Publisher+".ags")
              Create_Data()  
              
              If UM_Database()\UM_Players="2"
                out_folder="\+  Games - Multiplayer.ags\"
                path=LCase(Left(UM_Database()\UM_Title,1))
                Select path
                  Case "0","1","2","3","4","5","6","7","8","9","0","a","b","c","d"
                    If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
                    If FileSize(AGS_Path+out_folder+"2 Players 0-D.ags")=-1 : CreateDirectory(AGS_Path+out_folder+"2 Players 0-D.ags") : EndIf
                    SetCurrentDirectory(AGS_Path+out_folder+"2 Players 0-D.ags")
                    current_folder="+  Games - Multiplayer.ags/2 Players 0-D.ags/"
                  Case "e","f","g","h","i"
                    If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
                    If FileSize(AGS_Path+out_folder+"2 Players E-I.ags")=-1 : CreateDirectory(AGS_Path+out_folder+"2 Players E-I.ags") : EndIf
                    SetCurrentDirectory(AGS_Path+out_folder+"2 Players E-I.ags")
                    current_folder="+  Games - Multiplayer.ags/2 Players E-I.ags/"
                  Case "j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"
                    If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
                    If FileSize(AGS_Path+out_folder+"2 Players J-Z.ags")=-1 : CreateDirectory(AGS_Path+out_folder+"2 Players J-Z.ags") : EndIf
                    SetCurrentDirectory(AGS_Path+out_folder+"2 Players J-Z.ags")
                    current_folder="+  Games - Multiplayer.ags/2 Players J-Z.ags/"
                EndSelect
                Create_Data()      
              EndIf
              
              If UM_Database()\UM_Players="3"
                out_folder="\+  Games - Multiplayer.ags\"
                current_folder="+  Games - Multiplayer.ags/3 Players.ags/"
                If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
                If FileSize(AGS_Path+out_folder+"3 Players.ags")=-1 : CreateDirectory(AGS_Path+out_folder+"3 Players.ags") : EndIf
                SetCurrentDirectory(AGS_Path+out_folder+"3 Players.ags")
                Create_Data()     
              EndIf
            
              If UM_Database()\UM_Players="4"
                out_folder="\+  Games - Multiplayer.ags\"
                current_folder="+  Games - Multiplayer.ags/4 Players.ags/"
                If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
                If FileSize(AGS_Path+out_folder+"4 Players.ags")=-1 : CreateDirectory(AGS_Path+out_folder+"4 Players.ags") : EndIf
                SetCurrentDirectory(AGS_Path+out_folder+"4 Players.ags")
                Create_Data()    
              EndIf
              
              If UM_Database()\UM_Players<>"1" And UM_Database()\UM_Players<>"2" And UM_Database()\UM_Players<>"3" And UM_Database()\UM_Players<>"4"
                out_folder="\+  Games - Multiplayer.ags\"
                current_folder="+  Games - Multiplayer.ags/5+ Players.ags/"
                If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
                If FileSize(AGS_Path+out_folder+"5+ Players.ags")=-1 : CreateDirectory(AGS_Path+out_folder+"5+ Players.ags") : EndIf
                SetCurrentDirectory(AGS_Path+out_folder+"5+ Players.ags")
                Create_Data()     
              EndIf
              
              If UM_Database()\UM_Link=#True
                out_folder="\+  Games - Multiplayer.ags\"
                current_folder="+  Games - Multiplayer.ags/Null Modem - Link.ags/"
                If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
                If FileSize(AGS_Path+out_folder+"Null Modem - Link.ags")=-1 : CreateDirectory(AGS_Path+out_folder+"Null Modem - Link.ags") : EndIf
                SetCurrentDirectory(AGS_Path+out_folder+"Null Modem - Link.ags")
                Create_Data()     
              EndIf   
              
              If UM_Database()\UM_Online=#True
                out_folder="\+  Games - Multiplayer.ags\"
                current_folder="+  Games - Multiplayer.ags/Modem - Online.ags/"
                If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
                If FileSize(AGS_Path+out_folder+"Modem - Online.ags")=-1 : CreateDirectory(AGS_Path+out_folder+"Modem - Online.ags") : EndIf
                SetCurrentDirectory(AGS_Path+out_folder+"Modem - Online.ags")
                Create_Data()     
              EndIf 
              
              If UM_Database()\UM_CD32=#True
                out_folder="\+  Games - By System.ags\"
                current_folder="+  Games - By System.ags/CD32.ags/"
                If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
                If FileSize(AGS_Path+out_folder+"CD32.ags")=-1 : CreateDirectory(AGS_Path+out_folder+"CD32.ags") : EndIf
                SetCurrentDirectory(AGS_Path+out_folder+"CD32.ags")
                Create_Data()
              EndIf
              
              If UM_Database()\UM_CDTV=#True
                out_folder="\+  Games - By System.ags\"
                current_folder="+  Games - By System.ags/CDTV.ags/"
                If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
                If FileSize(AGS_Path+out_folder+"CDTV.ags")=-1 : CreateDirectory(AGS_Path+out_folder+"CDTV.ags") : EndIf
                SetCurrentDirectory(AGS_Path+out_folder+"CDTV.ags")
                Create_Data()
              EndIf
              
              If UM_Database()\UM_Arcadia=#True
                out_folder="\+  Games - By System.ags\"
                current_folder="+  Games - By System.ags/Arcadia.ags/"
                If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
                If FileSize(AGS_Path+out_folder+"Arcadia.ags")=-1 : CreateDirectory(AGS_Path+out_folder+"Arcadia.ags") : EndIf
                SetCurrentDirectory(AGS_Path+out_folder+"Arcadia.ags")
                Create_Data()
              EndIf
              
              If UM_Database()\UM_MT32=#True
                out_folder="\+  Games - By System.ags\"
                current_folder="+  Games - By System.ags/MT32.ags/"
                If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
                If FileSize(AGS_Path+out_folder+"MT32.ags")=-1 : CreateDirectory(AGS_Path+out_folder+"MT32.ags") : EndIf
                SetCurrentDirectory(AGS_Path+out_folder+"MT32.ags")
                Create_Data()
              EndIf
              
              If UM_Database()\UM_NTSC=#True
                out_folder="\+  Games - NTSC.ags\" 
                current_folder="+  Games - NTSC.ags/" 
                If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
                SetCurrentDirectory(AGS_Path+out_folder)
                Create_Data()
              EndIf
              
              out_folder="\+  Games - By Year.ags\"
              current_folder="+  Games - By Year.ags/"+UM_Database()\UM_Year+".ags/"
              If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
              If FileSize(AGS_Path+out_folder+UM_Database()\UM_Year+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+UM_Database()\UM_Year+".ags") : EndIf
              SetCurrentDirectory(AGS_Path+out_folder+UM_Database()\UM_Year+".ags")
              Create_Data()

            EndIf ; Emerald mine if statement

          ; These need to be here for emerald mines to be added to games by genre and 0-Z
            
            out_folder="\+  Games - By Genre.ags\"
            current_folder="+  Games - By Genre.ags/"+ReplaceString(UM_Database()\UM_Genre," / "," ")+".ags/"
            If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
            If FileSize(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Genre," / "," ")+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Genre," / "," ")+".ags") : EndIf
            SetCurrentDirectory(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Genre," / "," ")+".ags")
            Create_Data()
            
            out_folder="\+  Games - 0-Z.ags\"
            current_folder="+  Games - 0-Z.ags/"+Sort_List()\S_SubFolder+".ags/"
            If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
            If FileSize(AGS_Path+out_folder+Sort_List()\S_SubFolder+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+Sort_List()\S_SubFolder+".ags") : EndIf
            SetCurrentDirectory(AGS_Path+out_folder+Sort_List()\S_SubFolder+".ags")
            Create_Data()
            
          EndIf ; End of adult and english if statement
          
          If UM_Database()\UM_Adult=#True
            out_folder="\+  Games - Adult.ags\"
            current_folder="+  Games - Adult.ags/"
            If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
            If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
            SetCurrentDirectory(AGS_Path+out_folder)
            Create_Data()
          EndIf
            
          If UM_Database()\UM_Adult<>#True And UM_Database()\UM_Language<>"English"
            out_folder="\+  Games - Non English.ags\"
            current_folder="+  Games - Non English.ags/"+UM_Database()\UM_Language+".ags/"
            If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
            If FileSize(AGS_Path+out_folder+UM_Database()\UM_Language)=-1 : CreateDirectory(AGS_Path+out_folder+UM_Database()\UM_Language+".ags") : EndIf
            SetCurrentDirectory(AGS_Path+out_folder+UM_Database()\UM_Language+".ags")
            Create_Data()
          EndIf
            
;           If UM_Database()\UM_Emerald=#True
;             out_folder="\+  Games - Emerald Mines.ags\"
;             current_folder="+  Games - Emerald Mines.ags/"
;             If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
;             SetCurrentDirectory(AGS_Path+out_folder)
;             Create_Data()
;           EndIf
          
        EndIf ; End  of game if statement
        
        If UM_Database()\UM_Type="Magazine"
          out_folder="\-  Disk Magazines.ags\" 
          current_folder="-  Disk Magazines.ags/" 
          If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
          If FileSize(AGS_Path+out_folder+Sort_List()\S_SubFolder+".ags")=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
          SetCurrentDirectory(AGS_Path+out_folder)
          Create_Data()  
        EndIf
        
        If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Beta_Type="Demo"
          
          If UM_Database()\UM_Adult<>#True
            out_folder="\-  Demos - 0-Z.ags\"
            current_folder="-  Demos - 0-Z.ags/"+Sort_List()\S_SubFolder+".ags/"
            If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
            If FileSize(AGS_Path+out_folder+Sort_List()\S_SubFolder+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+Sort_List()\S_SubFolder+".ags") : EndIf
            SetCurrentDirectory(AGS_Path+out_folder+Sort_List()\S_SubFolder+".ags")
            Create_Data()
            
            out_folder="\-  Demos - By Group.ags\" 
            current_folder="-  Demos - By Group.ags/" +UM_Database()\UM_Publisher+".ags/"
            If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
            If FileSize(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Publisher," / "," ")+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Publisher," / "," ")+".ags") : EndIf
            SetCurrentDirectory(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Publisher," / "," ")+".ags") 
            Create_Data()
            
            out_folder="\-  Demos - By Year.ags\"
            current_folder="-  Demos - By Year.ags/"+UM_Database()\UM_Year+".ags/"
            If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
            If FileSize(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Year," / "," ")+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Year," / "," ")+".ags") : EndIf
            SetCurrentDirectory(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Year," / "," ")+".ags")
            Create_Data()
            
            out_folder="\-  Demos - By Genre.ags\"
            current_folder="-  Demos - By Genre.ags/"+ReplaceString(UM_Database()\UM_Genre," / "," ")+".ags/"
            If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
            If FileSize(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Genre," / "," ")+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Genre," / "," ")+".ags") : EndIf
            SetCurrentDirectory(AGS_Path+out_folder+ReplaceString(UM_Database()\UM_Genre," / "," ")+".ags")
            Create_Data()
            
            If UM_Database()\UM_AGA=#True
              out_folder="\-  Demos - AGA.ags\"
              current_folder="-  Demos - AGA.ags/"+Sort_List()\S_SubFolder+".ags/"
              If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
              If FileSize(AGS_Path+out_folder+Sort_List()\S_SubFolder+".ags")=-1 : CreateDirectory(AGS_Path+out_folder+Sort_List()\S_SubFolder+".ags") : EndIf
              SetCurrentDirectory(AGS_Path+out_folder+Sort_List()\S_SubFolder+".ags")
              Create_Data()
            EndIf  
            
          EndIf ; End if adult if statement
          
          If UM_Database()\UM_Adult=#True
            out_folder="\-  Demos - Adult.ags\"
            current_folder="-  Demos - Adult.ags/"
            If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
            If FileSize(AGS_Path+out_folder)=-1 : CreateDirectory(AGS_Path+out_folder) : EndIf
            SetCurrentDirectory(AGS_Path+out_folder)
            Create_Data()       
          EndIf
          
        EndIf ; End of demo if statement
        
      Next ; End of UM_Database loop
      
      Protected NewMap Check_Map.i()
      
      ForEach Check_List()
        Check_Map(Check_List())=ListIndex(Check_List())
      Next
      
      ClearList(Files())
      
      List_Files_Recursive(AGS_Path,Files(),"")
      
      ForEach Files()
        If Not FindMapElement(Check_Map(),Files())
          PrintN("Deleting "+Files())
          DeleteFile(Files())
          DeleteDirectorySafely(GetPathPart(files()))
        EndIf
      Next
           
      CreateDirectory(AGS_Path+"Search.ags")
      
      If ECS
        Make_AGS_Guide(AGS_Path+"Search.ags\WHDLoad_Game_List.guide",#True,#True)
        Make_AGS_Demos_Guide(AGS_Path+"Search.ags\WHDLoad_Demo_List.guide",#True,#True)
      Else
        Make_AGS_Guide(AGS_Path+"Search.ags\WHDLoad_Game_List.guide",#True,#False)
        Make_AGS_Demos_Guide(AGS_Path+"Search.ags\WHDLoad_Demo_List.guide",#True,#False)
      EndIf

      Write_Guides(AGS_Path,#True)
      
      CreateDirectory(AGS_Path+"IGame")
      
      Save_GL_CSV(AGS_Path+"IGame\gameslist.csv",0,#False,#True)
      Save_GL_CSV(AGS_Path+"IGame\gameslist_noadult.csv",1,#False,#True)
      Save_GL_CSV(AGS_Path+"IGame\gameslist_games.csv",2,#False,#True)
      Save_GL_CSV(AGS_Path+"IGame\gameslist_gamesnoadult.csv",3,#False,#True)
      Save_GL_CSV(AGS_Path+"IGame\gameslist_demos.csv",4,#False,#True)
      Save_GL_CSV(AGS_Path+"IGame\gameslist_demosnoadult.csv",5,#False,#True)
      Save_GL_CSV(AGS_Path+"IGame\gameslist_A500.csv",0,#True,#True)
      Save_GL_CSV(AGS_Path+"IGame\gameslist_noadult_A500.csv",1,#True,#True)
      Save_GL_CSV(AGS_Path+"IGame\gameslist_games_A500.csv",2,#True,#True)
      Save_GL_CSV(AGS_Path+"IGame\gameslist_gamesnoadult_A500.csv",3,#True,#True)
      Save_GL_CSV(AGS_Path+"IGame\gameslist_demos_A500.csv",4,#True,#True)
      Save_GL_CSV(AGS_Path+"IGame\gameslist_demosnoadult_A500.csv",5,#True,#True)
      
      CopyFile(Data_Path+"genres",AGS_Path+"IGame\genres")
      CopyFile(Data_Path+"genres_demos",AGS_Path+"IGame\genres_demos")
      CopyFile(Data_Path+"genres_games",AGS_Path+"IGame\genres_games")
      
      CreateDirectory(AGS_Path+"Scripts")
      
      CreateFile(0,AGS_Path+"Scripts\Random_Game",#PB_Ascii) 
      CreateFile(1,AGS_Path+"Scripts\Random_Demo",#PB_Ascii) 
      
      ForEach UM_Database()
        If ECS And UM_Database()\UM_AGA
          Continue
        EndIf
        
        If UM_Database()\UM_Language="English" And UM_Database()\UM_Adult<>#True
          If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
            path="AGS:+  Games - 0-Z.ags/"+UM_Database()\UM_Subfolder+".ags/"+UM_Database()\UM_Short+Tags_Short()+".run"
            WriteString(0,"Ex "+#DOUBLEQUOTE$+path+#DOUBLEQUOTE$+#LF$)
          EndIf
          If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Beta_Type="Demo"
            path="AGS:-  Demos - 0-Z.ags/"+UM_Database()\UM_Subfolder+".ags/"+UM_Database()\UM_Short+Tags_Short()+".run"
            WriteString(1,"Ex "+#DOUBLEQUOTE$+path+#DOUBLEQUOTE$+#LF$)
          EndIf
          If UM_Database()\UM_Type="Magazine"
            path="AGS:-  Disk Magazines.ags/"+UM_Database()\UM_Short+Tags_Short()+".run"
            WriteString(1,"Ex "+#DOUBLEQUOTE$+path+#DOUBLEQUOTE$+#LF$)
          EndIf
        EndIf
      Next
      CloseFile(0)
      CloseFile(1)
      
    EndIf
    
  EndIf
  
  Proc_Exit:
  
  Delay(1500)
  
  CloseConsole()
  
  FreeList(Sort_List())
  FreeList(script())
  FreeList(random_script())
  
  SetCurrentDirectory(Home_Path)
  
  SelectElement(UM_Database(),old_pos)
  
EndProcedure

Procedure Create_IFF_Single()
  
  Protected source_folder$, dest_folder$, source_file$, new_file$, title$, result.i, response.s, text_info.i, Keypressed$, output$
   
  source_folder$=Game_Data_Path
  
  response=Str(5)
  
  If source_folder$<>""
    dest_folder$=PathRequester("Select Output Folder","")  
    If dest_folder$<>""
      OpenConsole("Create Image Folders (Press ESC to quit)")
      Center_Console()
      ConsoleCursor(0)
      
      SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))      
      SelectElement(UM_Database(),List_Numbers()\L_Number)
      
      PrintN("Processing: "+UM_Database()\UM_Title+Tags())
      Generate_Images()
      Pause_Console()
      
    EndIf
    CloseConsole()
  EndIf

  SetCurrentDirectory(Home_Path)
  
EndProcedure

Procedure Create_IFF_Folders()
  
  Protected source_folder$, dest_folder$, source_file$, new_file$, title$, result.i, response.s, text_info.i, Keypressed$, output$
  
  Protected NewList Image_List.i()
  
  source_folder$=Game_Data_Path
  
  If source_folder$<>""
    dest_folder$=PathRequester("Select Output Folder","")  
    If dest_folder$<>""
      OpenConsole("Create Image Folders (Press ESC to quit)")
      Center_Console()
      ConsoleCursor(0)
      PrintNCol("Select Image Type.",9,0)
      PrintS()
      PrintN("1. IGame")
      PrintN("2. TinyLauncher")
      PrintN("3. PNG (Slave)")
      PrintN("4. PNG (LHA)") 
      PrintN("5. All Above Sets")
      PrintN("6. AGS Mini")
      PrintN("7. AGS Real")
      PrintN("C. Cancel")
      PrintS()
      Print("Please select a number: ")
      response=Input() 
      PrintS()
      If LCase(response)<>"c"
        
        ForEach UM_Database()
          
          If UM_Database()\UM_Genre="Misc / Editor"
            Continue
          EndIf
          
          If UM_Database()\UM_Genre="Misc / Intro"
            Continue
          EndIf
          
          If UM_Database()\UM_Genre="Misc / Utility Disk"
            Continue
          EndIf
          
          If UM_Database()\UM_Data_Disk
            Continue
          EndIf
          
          AddElement(Image_List())
          Image_List()=ListIndex(UM_Database())
          
        Next
        
        ForEach Image_List()
          SelectElement(UM_Database(),Image_List())
          PrintN("Processing: "+UM_Database()\UM_Title+Tags()+" ("+Str(ListIndex(Image_List())+1)+" of "+Str(ListSize(Image_List()))+")")
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
    If GetGadgetItemState(w_tree,1)<>#PB_Tree_Checked
      SelectElement(UM_Database(),WHD_List()\WHD_Index)
      If UM_Database()\UM_Type<>"Game" : WHD_List()\WHD_Filtered=#True : EndIf
    EndIf   
  Next
  
EndProcedure

Procedure Draw_WHD_List()
  
  Filter_WHD_List()
  
  Pause_Gadget(w_list)
  
  ClearGadgetItems(w_list)
  
  ForEach WHD_List()
    If WHD_List()\WHD_Filtered<>#True : AddGadgetItem(w_list,-1,WHD_List()\WHD_Archive) : EndIf
  Next
  
  Resume_Gadget(w_list)
  
EndProcedure

Macro TreeGadget_SetStateImageMask(Gadget,Item,fCheck)
  Protected tvItem.TV_ITEM
  tvItem\mask = #TVIF_HANDLE | #TVIF_STATE
  tvItem\hItem = GadgetItemID(Gadget,Item)
  tvItem\stateMask = #TVIS_STATEIMAGEMASK;
  tvItem\state = fCheck << 12
  SendMessage_(GadgetID(Gadget), #TVM_SETITEM,0,@tvItem);
EndMacro

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
    
    TreeGadget_SetStateImageMask(w_tree,0,16)
    
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

;- ############### Window Procedures

Procedure Image_Popup(type.i)
  
  Protected popup_imagegadget, pevent, popup_image, ww.i, wh.i, wx.i, wy.i, ih.i, iw.i, Smooth, old_gadget_list, zoom.f, rotate.i, oldpos.i, extension.s
  
  zoom=0.8
  rotate=0
  
  If GetGadgetState(#MAIN_LIST)>-1
    
    If IFF_Smooth : Smooth=#PB_Image_Smooth : Else : Smooth=#PB_Image_Raw : EndIf
    
    oldpos=GetGadgetState(#MAIN_LIST)
    
    SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
    SelectElement(UM_Database(),List_Numbers()\L_Number)
    
    DisableWindow(#MAIN_WINDOW,#True)
    
    Select type
      Case 1 : extension="_Title.png" :  wh=512
      Case 2 : extension="_Screen.png" :  wh=512
      Case 3 : extension="_Cover.png" :  wh=824    
    EndSelect   
    ww=640    
           
    path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+extension     
    
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
  
  OpenWindow(f_window,0,0,700,600,"File Viewer ("+GetFilePart(file)+")",#PB_Window_SystemMenu|#PB_Window_SizeGadget|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_WindowCentered, WindowID(#MAIN_WINDOW))
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
  Protected Path_Genres_Button, Path_Genres_String, Path_Database_Button, Path_Database_String, Path_NConvert_String, Path_NConvert_Button
  Protected Path_Amiga_String, Path_Amiga_Button, Path_IGame_String, Path_IGame_Button, Path_Game_LHA_String, Path_Demo_LHA_String, Path_Beta_LHA_String, Path_Game_LHA_Button, Path_Demo_LHA_Button, Path_Beta_LHA_Button
  Protected old_pos, old_gadget_list, Path_Update_String, Path_Update_Button, Path_IZARC_String, Path_IZARC_Button, Path_Info_String, Path_Info_Button
  Protected change.b=#False
  
  Protected Options_Short_Check, Options_CloseUAE_Check, Options_Smooth_Check, Options_Quality_Check, Options_Backup_Check, Options_Tags_Check
  Protected Options_Bezel_Check, Options_BezelType_Combo, Options_BezelSource_Combo, Options_BezelName_String, Options_BezelSelect_Button
  
  old_pos=GetGadgetState(#MAIN_LIST)
  
  If OpenWindow(#PATH_WINDOW, 0, 0, 490, 580, "AGS Database Manager Settings", #PB_Window_SystemMenu|#PB_Window_WindowCentered, WindowID(#MAIN_WINDOW))
    
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

Procedure AGS_Window()
  
  Protected AGSWindow, gadget, type
  Protected BW_Check, FC_Check, IB_Check, NC_Check, CPUSpeed_Combo, UAECPU14_Check, JIT_Check, NTSC_Check, ScreenHeight_String, ScreenOffset_String, Cycle_Check
  Protected save_button,cancel_button
  
  AGSWindow=OpenWindow(#PB_Any, 0,0,235,250,"AGS Settings",#PB_Window_SystemMenu|#PB_Window_WindowCentered,WindowID(#EDIT_WINDOW))
  
  Pause_Window(AGSWindow)
  
  TextGadget(#PB_Any,5,7,120,20,"Force CPU Speed",#PB_Text_Center)
  CPUSpeed_Combo=ComboBoxGadget(#PB_Any,130,5,100,20)
  
  AddGadgetItem(CPUSpeed_Combo,-1,"Default")
  AddGadgetItem(CPUSpeed_Combo,-1,"7mhz")
  AddGadgetItem(CPUSpeed_Combo,-1,"14mhz")
  AddGadgetItem(CPUSpeed_Combo,-1,"25mhz")
  AddGadgetItem(CPUSpeed_Combo,-1,"Max")
   
  UAECPU14_Check=CheckBoxGadget(#PB_Any,5,35,100,22,"UAE CPU 14")
  JIT_Check=CheckBoxGadget(#PB_Any,130,35,100,22,"Force JIT")
  BW_Check=CheckBoxGadget(#PB_Any,5,65,100,22,"Blitter Wait")
  FC_Check=CheckBoxGadget(#PB_Any,130,65,100,22,"Fast Copper")
  IB_Check=CheckBoxGadget(#PB_Any,5,95,100,22,"Immediate Blits")
  NTSC_Check=CheckBoxGadget(#PB_Any,130,95,100,22,"Force NTSC")
  NC_Check=CheckBoxGadget(#PB_Any,5,125,100,22,"No Cycle Exact")
  Cycle_Check=CheckBoxGadget(#PB_Any,130,125,100,22,"Cycle Exact")
  
  TextGadget(#PB_Any,5,157,120,22,"Screen Height",#PB_Text_Center)
  ScreenHeight_String=StringGadget(#PB_Any,130,155,100,22,Str(UM_Database()\UM_VRES) )
  
  TextGadget(#PB_Any,5,187,120,22,"Screen Offset",#PB_Text_Center)
  ScreenOffset_String=StringGadget(#PB_Any,130,185,100,22,UM_Database()\UM_Offset)
    
  save_button=ButtonGadget(#PB_Any, 5,215,110,30,"Save")
  cancel_button=ButtonGadget(#PB_Any, 120,215,110,30,"Cancel")
  
  If UM_Database()\UM_7Mhz
    SetGadgetState(CPUSpeed_Combo,1)
  EndIf
  If UM_Database()\UM_14Mhz
    SetGadgetState(CPUSpeed_Combo,2)
  EndIf
  If UM_Database()\UM_25Mhz
    SetGadgetState(CPUSpeed_Combo,3)
  EndIf
  If UM_Database()\UM_Max
    SetGadgetState(CPUSpeed_Combo,4)
  EndIf
  If Not UM_Database()\UM_7Mhz And Not UM_Database()\UM_14Mhz And Not UM_Database()\UM_25Mhz And Not UM_Database()\UM_Max
    SetGadgetState(CPUSpeed_Combo,0)
  EndIf
  SetGadgetState(UAECPU14_Check,UM_Database()\UM_UAE_14Mhz)
  SetGadgetState(JIT_Check,UM_Database()\UM_JIT)
  SetGadgetState(IB_Check,UM_Database()\UM_IB)
  SetGadgetState(BW_Check,UM_Database()\UM_BW)
  SetGadgetState(FC_Check,UM_Database()\UM_FC)
  SetGadgetState(NC_Check,UM_Database()\UM_NoCycle)
  SetGadgetState(Cycle_Check,UM_Database()\UM_Cycle)
    
  Resume_Window(AGSWindow)
  
  While WindowEvent() : Wend
  
  Repeat
    event=WaitWindowEvent()
    gadget=EventGadget()
    type=EventType()
    
    Select event
        
      Case #PB_Event_CloseWindow
        If EventWindow()=AGSWindow : Break : EndIf
        
    EndSelect
    
    Select gadget       
        
      Case cancel_button     
        
        If EventWindow()=AGSWindow And type=#PB_EventType_LeftClick
          Break
        EndIf
        
      Case save_button     
        
        If EventWindow()=AGSWindow And type=#PB_EventType_LeftClick
          If GetGadgetState(CPUSpeed_Combo)=0
            UM_Database()\UM_7Mhz=#False : UM_Database()\UM_14Mhz=#False : UM_Database()\UM_25Mhz=#False : UM_Database()\UM_Max=#False
          EndIf
          If GetGadgetState(CPUSpeed_Combo)=1
            UM_Database()\UM_7Mhz=#True : UM_Database()\UM_14Mhz=#False : UM_Database()\UM_25Mhz=#False : UM_Database()\UM_Max=#False
          EndIf
          If GetGadgetState(CPUSpeed_Combo)=2
            UM_Database()\UM_7Mhz=#False : UM_Database()\UM_14Mhz=#True : UM_Database()\UM_25Mhz=#False : UM_Database()\UM_Max=#False
          EndIf
          If GetGadgetState(CPUSpeed_Combo)=3
            UM_Database()\UM_7Mhz=#False : UM_Database()\UM_14Mhz=#False : UM_Database()\UM_25Mhz=#True : UM_Database()\UM_Max=#False
          EndIf
          If GetGadgetState(CPUSpeed_Combo)=4
            UM_Database()\UM_7Mhz=#False : UM_Database()\UM_14Mhz=#False : UM_Database()\UM_25Mhz=#False : UM_Database()\UM_Max=#True
          EndIf
          UM_Database()\UM_UAE_14Mhz=GetGadgetState(UAECPU14_Check)
          UM_Database()\UM_JIT=GetGadgetState(JIT_Check)
          UM_Database()\UM_IB=GetGadgetState(IB_Check)
          UM_Database()\UM_BW=GetGadgetState(BW_Check)
          UM_Database()\UM_FC=GetGadgetState(FC_Check)
          UM_Database()\UM_NoCycle=GetGadgetState(NC_Check)
          UM_Database()\UM_VRES=Val(GetGadgetText(ScreenHeight_String))
          UM_Database()\UM_Offset=GetGadgetText(ScreenOffset_String)
          Break
        EndIf
        
    EndSelect
    
    
  ForEver
  
  CloseWindow(AGSWindow)  
  
EndProcedure

Procedure Edit_Database(number) 
  
  CatchImage(#AGS_ICON,?AGS_Image)
  
  SelectElement(UM_Database(),number)
  
  Protected NewList Backup_List.UM_Data()
  
  CopyList(UM_Database(),Backup_List())
  
  Protected change.b=#False, oldindex.s, star.s, g_file.i, text$, old_num, count, old_path.s
  Protected old_gadget_list, old_pos.s, Title_String, Language_String, Path_String, Frame_0, CD32_Check, Icon_Button, Preview_Check
  Protected Files_Check, Image_Check, NoIntro_Check, Date_String, Icon_String, Close_Button, HOL_String, HOL_String_New, Lemon_String, WHD_String, Data_Disk_Check
  Protected CDTV_Check, MT32_Check, Memory_String, Genre_Combo, CDROM_Check, Arcadia_Check, Demo_Check, Intro_Check, PD_Check
  Protected Cover_Check, NTSC_Check, Disk_String, Coder_String, Type_Combo, File_Button, Config_Combo, Janeway_String, Pouet_String, Beta_Type_Combo
  Protected Year_String, Cancel_Button, Short_String, Chipset_Combo, Short_Title, Players_String, NoSound_Check, Developer_String, Folder_String, Party_String
  Protected Next_Button, Prev_Button, Publisher_Text, WHD_Button, Restricted_Check, Data_Disk, Adult_Check, Pure_Check, Publisher_Title, AGS_Button
  Protected Info_Container, Filter_Container, Slave_String, CRC_String, link_check, online_check
  
  old_num=GetGadgetState(#MAIN_LIST)
  
  DisableWindow(#MAIN_WINDOW,#True)
  
  If OpenWindow(#EDIT_WINDOW, 0, 0, 450, 630, "Edit Database ("+Str(ListIndex(List_Numbers())+1)+" of "+Str(ListSize(List_Numbers()))+")", #PB_Window_SystemMenu | #PB_Window_WindowCentered, WindowID(#MAIN_WINDOW))
    
    Pause_Window(#EDIT_WINDOW)
    
    old_gadget_list=UseGadgetList(WindowID(#EDIT_WINDOW))
    
    TextGadget(#PB_Any, 8, 10, 60, 20, "Name", #PB_Text_Center)    
    Title_String = StringGadget(#PB_Any, 80, 8, 360, 24, UM_Database()\UM_Title)
    Short_Title=TextGadget(#PB_Any, 5, 42, 60, 20, "Short ("+Str(Len(UM_Database()\UM_Short))+")", #PB_Text_Center)    
    Short_String = StringGadget(#PB_Any, 80, 40, 360, 24, UM_Database()\UM_Short)
    TextGadget(#PB_Any, 8, 74, 60, 20, "Language", #PB_Text_Center)
    Language_String = StringGadget(#PB_Any, 80, 72, 360, 24, UM_Database()\UM_Language)
    TextGadget(#PB_Any, 8, 106, 60, 20, "Archive", #PB_Text_Center) 
    Path_String = StringGadget(#PB_Any, 80, 104, 360, 24, UM_Database()\UM_LHAFile)
    TextGadget(#PB_Any, 8, 140, 60, 20, "Slave Name", #PB_Text_Center)
    Slave_String = StringGadget(#PB_Any, 80, 138, 140, 24, UM_Database()\UM_Slave) 
    TextGadget(#PB_Any, 230, 140, 60, 20, "Def. Icon", #PB_Text_Center)
    Icon_String = StringGadget(#PB_Any, 300, 138, 140, 24, UM_Database()\UM_Icon)  
    Publisher_Title=TextGadget(#PB_Any, 8, 172, 60, 20, "", #PB_Text_Center)
    If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Beta_Type="Demo" Or UM_Database()\UM_Type="Magazine"
      SetGadgetText(Publisher_Title,"Group ("+Str(Len(UM_Database()\UM_Publisher))+")")
    EndIf
    If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
      SetGadgetText(Publisher_Title,"Publ. ("+Str(Len(UM_Database()\UM_Publisher))+")")
    EndIf
    Coder_String = StringGadget(#PB_Any, 80, 170, 140, 24, UM_Database()\UM_Publisher)
    TextGadget(#PB_Any, 230, 172, 60, 20, "Developer", #PB_Text_Center)
    Developer_String = StringGadget(#PB_Any, 300, 170, 140, 24, UM_Database()\UM_Developer)
    TextGadget(#PB_Any, 8, 206, 60, 20, "Slave Date", #PB_Text_Center)
    Date_String = StringGadget(#PB_Any, 80, 202, 80, 24, UM_Database()\UM_Slave_Date)
    TextGadget(#PB_Any, 170, 206, 40, 20, "Year", #PB_Text_Center)
    Year_String = StringGadget(#PB_Any, 220, 202, 60, 24, UM_Database()\UM_Year)
    TextGadget(#PB_Any, 300, 206, 40, 20, "CRC32", #PB_Text_Center)
    CRC_String = StringGadget(#PB_Any, 350, 202, 90, 24, UM_Database()\UM_CRC32)    
    
    Frame_0 = FrameGadget(#PB_Any, 8, 224, 438, 208, "")
    Chipset_Combo = ComboBoxGadget(#PB_Any, 16, 240, 60, 20)
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
    Memory_String = StringGadget(#PB_Any, 336, 272, 102, 24, UM_Database()\UM_Memory)
    Preview_Check = CheckBoxGadget(#PB_Any, 16, 304, 60, 20, "Preview", #PB_CheckBox_Center)
    Files_Check = CheckBoxGadget(#PB_Any, 88, 304, 60, 20, "Files")
    Image_Check = CheckBoxGadget(#PB_Any, 152, 304, 54, 20, "Image")
    Cover_Check = CheckBoxGadget(#PB_Any, 210, 304, 80, 20, "Cover Disk")
    TextGadget(#PB_Any, 296, 306, 36, 20, "Disks", #PB_Text_Right)
    Disk_String = StringGadget(#PB_Any, 336, 304, 102, 24, UM_Database()\UM_Disks) 
    Adult_Check=CheckBoxGadget(#PB_Any,16,336,60,20,"Adult")
    Data_Disk_Check = CheckBoxGadget(#PB_Any, 88, 336, 65, 20, "DataDisk", #PB_CheckBox_Center)
    PD_Check = CheckBoxGadget(#PB_Any, 162, 336, 40, 20, "PD")
    Restricted_Check = CheckBoxGadget(#PB_Any, 210, 336, 80, 20, "Restricted")
    TextGadget(#PB_Any, 296, 338, 36, 20, "Players", #PB_Text_Right)
    Players_String = StringGadget(#PB_Any, 336, 336, 102, 24, UM_Database()\UM_Players,#PB_String_Numeric)
    
    Link_Check = CheckBoxGadget(#PB_Any, 16, 366, 60, 20, "Null")
    online_check = CheckBoxGadget(#PB_Any, 88, 366, 60, 20, "Online")
    
    Pure_Check=CheckBoxGadget(#PB_Any,16,398,60,20,"Pure")
    AGS_Button=ButtonIconGadget(#PB_Any,88,397,110,22,"AGS Settings",ImageID(#AGS_ICON),16,16)
    Party_String = StringGadget(#PB_Any,276,398,140,24,UM_Database()\UM_Party)
    TextGadget(#PB_Any, 212, 400, 60, 20, "Rel. Party") 
    
    TextGadget(#PB_Any, 8, 438, 46, 20, "Type")
    Type_Combo = ComboBoxGadget(#PB_Any, 54, 436, 88, 24)
    TextGadget(#PB_Any, 153, 438, 56, 20, "Beta Type")
    Beta_Type_Combo = ComboBoxGadget(#PB_Any, 214, 436, 74, 24)
    TextGadget(#PB_Any, 298, 438, 50, 20, "Config")  
    Config_Combo = ComboBoxGadget(#PB_Any, 342, 436, 74, 24)
    
    TextGadget(#PB_Any, 8, 470, 60, 20, "Genre")
    Genre_Combo = ComboBoxGadget(#PB_Any, 54, 468, 216, 24) 
    
    TextGadget(#PB_Any, 8, 500, 60, 20, "Folder")   
    Folder_String = StringGadget(#PB_Any,54,498,336,24,UM_Database()\UM_Folder)
    
    TextGadget(#PB_Any, 8, 530, 40, 20, "HOL #")   
    HOL_String = StringGadget(#PB_Any,50,528,50,24,UM_Database()\UM_HOL_Entry)
    TextGadget(#PB_Any, 108, 530, 50, 20, "HOL New")   
    HOL_String_New = StringGadget(#PB_Any,165,528,175,24,UM_Database()\UM_HOL_Entry_New)   
    TextGadget(#PB_Any, 350, 530, 40, 20, "Lemon #")    
    Lemon_String = StringGadget(#PB_Any,395,528,50,24,UM_Database()\UM_Lemon_Entry)
    
    Janeway_String = StringGadget(#PB_Any,50,558,50,24,UM_Database()\UM_Janeway)
    TextGadget(#PB_Any, 8, 560, 40, 20, "B'World") 
    Pouet_String = StringGadget(#PB_Any,154,558,50,24,UM_Database()\UM_Pouet)
    TextGadget(#PB_Any, 110, 560, 40, 20, "Pouët") 
    TextGadget(#PB_Any, 212, 560, 60, 20, "WHDLoad") 
    WHD_String = StringGadget(#PB_Any,276,558,120,24,UM_Database()\UM_WHD_Entry)
    WHD_Button = ButtonGadget(#PB_Any,398,558,20,24,"Go")
    
    Prev_Button = ButtonGadget(#PB_Any, 20, 588, 72, 24, "Previous")
    Next_Button = ButtonGadget(#PB_Any, 100, 588, 72, 24, "Next")
    Cancel_Button = ButtonGadget(#PB_Any, 270, 588, 72, 24, "Cancel")
    Close_Button = ButtonGadget(#PB_Any, 344, 588, 72, 24, "Close")
    
    If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Beta_Type="Demo"
      DisableGadget(HOL_String,#True)
      DisableGadget(HOL_String_New,#True)
      DisableGadget(Lemon_String,#True)
    EndIf
    
    If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Beta_Type="Game"
      DisableGadget(Janeway_String,#True)
      DisableGadget(Pouet_String,#True)
      DisableGadget(Party_String,#True)
    EndIf
    
    AddGadgetItem(Chipset_Combo,-1,"None")
    AddGadgetItem(Chipset_Combo,-1,"OCS")
    AddGadgetItem(Chipset_Combo,-1,"ECS")
    AddGadgetItem(Chipset_Combo,-1,"AGA")
    SetGadgetState(Chipset_Combo,0)
    If UM_Database()\UM_AGA : SetGadgetState(Chipset_Combo,3) : EndIf
    If UM_Database()\UM_ECS : SetGadgetState(Chipset_Combo,2) : EndIf
    If UM_Database()\UM_OCS : SetGadgetState(Chipset_Combo,1) : EndIf
    
    AddGadgetItem(Type_Combo,-1,"Unknown")
    AddGadgetItem(Type_Combo,-1,"Game")
    AddGadgetItem(Type_Combo,-1,"Demo")
    AddGadgetItem(Type_Combo,-1,"Beta")
    AddGadgetItem(Type_Combo,-1,"Magazine")
    AddGadgetItem(Type_Combo,-1,"Premium")
    
    AddGadgetItem(Beta_Type_Combo,-1,"Unknown")
    AddGadgetItem(Beta_Type_Combo,-1,"Game")
    AddGadgetItem(Beta_Type_Combo,-1,"Demo")
    AddGadgetItem(Beta_Type_Combo,-1,"Magazine")
    
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
      SetGadgetState(Genre_Combo,Genre_Map())   
    Else
      SetGadgetState(Genre_Combo, CountGadgetItems(Genre_Combo))
    EndIf
    
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
    SetGadgetState(Data_Disk_Check,UM_Database()\UM_Data_Disk)
    SetGadgetState(PD_Check,UM_Database()\UM_PD)
    SetGadgetState(Restricted_Check,UM_Database()\UM_Restricted)
    SetGadgetState(Adult_Check,UM_Database()\UM_Adult)
    SetGadgetState(Pure_Check,UM_Database()\UM_Pure)
    SetGadgetState(Link_Check,UM_Database()\UM_Link)
    SetGadgetState(online_check,UM_Database()\UM_Online)
    
    Select UM_Database()\UM_Type
      Case ""
        SetGadgetState(Type_Combo,0)
      Case "Game"
        SetGadgetState(Type_Combo,1)
      Case "Demo"
        SetGadgetState(Type_Combo,2)
      Case "Beta"
        SetGadgetState(Type_Combo,3)
      Case "Magazine"
        SetGadgetState(Type_Combo,4)
      Case "Premium"
        SetGadgetState(Type_Combo,5);         
    EndSelect
    
    Select UM_Database()\UM_Beta_Type
      Case ""
        SetGadgetState(Beta_Type_Combo,0)
      Case "Game"
        SetGadgetState(Beta_Type_Combo,1)
      Case "Demo"
        SetGadgetState(Beta_Type_Combo,2)
      Case "Beta"
        SetGadgetState(Beta_Type_Combo,3)
      Case "Magazine"
        SetGadgetState(Beta_Type_Combo,4)
    EndSelect
    
    If UM_Database()\UM_Beta=#False : DisableGadget(Beta_Type_Combo,1) : EndIf
    
    Resume_Window(#EDIT_WINDOW)
    
    SetActiveGadget(title_string)
    
    oldindex=UM_Database()\UM_Title
    
    count=0
    
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
              
            Case Beta_Type_Combo
              UM_Database()\UM_Beta_Type=GetGadgetText(Beta_Type_Combo)
              If UM_Database()\UM_Beta_Type="Game"
                UM_Database()\UM_Sort_Type="Beta\Game"
                DisableGadget(Pouet_String,#True)
                DisableGadget(Janeway_String,#True)
                DisableGadget(Party_String,#True)
                DisableGadget(HOL_String,#False)
                DisableGadget(Lemon_String,#False)
                SetGadgetText(Publisher_Title,"Publ. ("+Str(Len(UM_Database()\UM_Publisher))+")")
              EndIf
              If UM_Database()\UM_Beta_Type="Demo" Or UM_Database()\UM_Beta_Type="Magazine"
                UM_Database()\UM_Sort_Type="Beta\Demo"
                DisableGadget(Pouet_String,#False)
                DisableGadget(Janeway_String,#False)
                DisableGadget(Party_String,#False)
                DisableGadget(HOL_String,#True)
                DisableGadget(Lemon_String,#True) 
                SetGadgetText(Publisher_Title,"Group ("+Str(Len(UM_Database()\UM_Publisher))+")")
              EndIf
              If UM_Database()\UM_Beta_Type="Magazine"
                UM_Database()\UM_Sort_Type="Beta\Mag"
                DisableGadget(Pouet_String,#False)
                DisableGadget(Janeway_String,#False)
                DisableGadget(Party_String,#False)
                DisableGadget(HOL_String,#True)
                DisableGadget(Lemon_String,#True) 
                SetGadgetText(Publisher_Title,"Group ("+Str(Len(UM_Database()\UM_Publisher))+")")
              EndIf
              If UM_Database()\UM_Beta_Type="Unknown"
                UM_Database()\UM_Sort_Type="Unknown"
                DisableGadget(Pouet_String,#True)
                DisableGadget(Janeway_String,#True)
                DisableGadget(Party_String,#True)
                DisableGadget(HOL_String,#True)
                DisableGadget(Lemon_String,#True)
                SetGadgetText(Publisher_Title,"")
              EndIf
              change=#True  
              
            Case AGS_Button
              AGS_Window()
              
            Case Next_Button
              If ListIndex(List_Numbers())<ListSize(List_Numbers())
                UM_Database()\UM_Sort_Name=UM_Database()\UM_Title + Tags()
                NextElement(List_Numbers())
                SelectElement(UM_Database(),List_Numbers()\L_Number)
                Populate_Edit_Gadgets()
                SetWindowTitle(#EDIT_WINDOW,"Edit Database ("+Str(ListIndex(List_Numbers())+1)+" of "+Str(ListSize(List_Numbers()))+")")
                Draw_Info(List_Numbers()\L_Number)
              EndIf
              
            Case Prev_Button
              If ListIndex(List_Numbers())>-1
                UM_Database()\UM_Sort_Name=UM_Database()\UM_Title + Tags()
                PreviousElement(List_Numbers())
                SelectElement(UM_Database(),List_Numbers()\L_Number)
                Populate_Edit_Gadgets()
                SetWindowTitle(#EDIT_WINDOW,"Edit Database ("+Str(ListIndex(List_Numbers())+1)+" of "+Str(ListSize(List_Numbers()))+")")
                Draw_Info(List_Numbers()\L_Number)
              EndIf
              
            Case title_string
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Title=GetGadgetText(title_string)
                UM_Database()\UM_Sort_Name=UM_Database()\UM_Title+Tags()
                change=#True
              EndIf
              
            Case Short_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Short=GetGadgetText(Short_String)
                SetGadgetText(Short_Title,"Short ("+Str(Len(UM_Database()\UM_Short))+")")
                change=#True
              EndIf
              
            Case CRC_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_CRC32=GetGadgetText(CRC_String)
                change=#True
              EndIf
              
            Case Coder_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Publisher=GetGadgetText(Coder_String)
                If UM_Database()\UM_Type="Demo"
                  SetGadgetText(Publisher_Title, "Group ("+Str(Len(UM_Database()\UM_Publisher))+")")
                Else
                  SetGadgetText(Publisher_Title, "Publ. ("+Str(Len(UM_Database()\UM_Publisher))+")")
                EndIf
                change=#True
              EndIf
              
            Case Slave_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Slave=GetGadgetText(slave_string)
                change=#True
              EndIf
              
            Case Icon_String
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_Icon=GetGadgetText(Icon_String)
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
              
            Case HOL_String_New
              If EventType()=#PB_EventType_Change
                UM_Database()\UM_HOL_Entry_New=GetGadgetText(HOL_String_New)
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
              
            Case WHD_Button
              If UM_Database()\UM_WHD_Entry<>""
                Select UM_Database()\UM_Type
                  Case "Demo" : RunProgram("http://www.whdload.de/demos/"+UM_Database()\UM_WHD_Entry+".html")
                  Case "Game" : RunProgram("http://www.whdload.de/games/"+UM_Database()\UM_WHD_Entry+".html")
                  Case "Beta" 
                    If UM_Database()\UM_Beta_Type="Game"
                      RunProgram("http://www.whdload.de/games/"+UM_Database()\UM_WHD_Entry+".html")
                    EndIf
                    If UM_Database()\UM_Beta_Type="Demo"
                      RunProgram("http://www.whdload.de/demos/"+UM_Database()\UM_WHD_Entry+".html")
                    EndIf
                  Case "Magazine": RunProgram("http://www.whdload.de/mags/"+UM_Database()\UM_WHD_Entry+".html")
                EndSelect
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
                UM_Database()\UM_Sort_Date=Convert_AGS_Date(UM_Database()\UM_Slave_Date)
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
              
            Case Chipset_Combo
              Select GetGadgetState(Chipset_Combo)
                Case 0
                  UM_Database()\UM_AGA=#False
                  UM_Database()\UM_ECS=#False
                  UM_Database()\UM_OCS=#False
                Case 1
                  UM_Database()\UM_AGA=#False
                  UM_Database()\UM_ECS=#False
                  UM_Database()\UM_OCS=#True
                Case 2
                  UM_Database()\UM_AGA=#False
                  UM_Database()\UM_ECS=#True
                  UM_Database()\UM_OCS=#False
                Case 3
                  UM_Database()\UM_AGA=#True
                  UM_Database()\UM_ECS=#False
                  UM_Database()\UM_OCS=#False
              EndSelect
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
              
            Case Data_Disk_Check
              UM_Database()\UM_Data_Disk=GetGadgetState(Data_Disk_Check)
              change=#True
              
            Case PD_Check
              UM_Database()\UM_PD=GetGadgetState(PD_Check)
              change=#True
              
            Case Restricted_Check
              UM_Database()\UM_Restricted=GetGadgetState(Restricted_Check)
              change=#True  
              
            Case Adult_Check
              UM_Database()\UM_Adult=GetGadgetState(Adult_Check)
              change=#True 
              
            Case Pure_Check
              UM_Database()\UM_Pure=GetGadgetState(Pure_Check)
              change=#True 
              
            Case Link_Check
              UM_Database()\UM_Link=GetGadgetState(link_check)
              change=#True 
              
            Case online_check
              UM_Database()\UM_Online=GetGadgetState(online_check)
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
          If EventWindow()=#EDIT_WINDOW
            Break
          EndIf
          
      EndSelect
      
    ForEver
    
    UseGadgetList(old_gadget_list) 
    
    CloseWindow(#EDIT_WINDOW)  
    
    DisableWindow(#MAIN_WINDOW,#False)
    SetActiveWindow(#MAIN_WINDOW)
    SetActiveGadget(#MAIN_LIST)
    
    UM_Database()\UM_Sort_Name=UM_Database()\UM_Title + Tags()
    
    SortStructuredList(UM_Database(),#PB_Sort_Ascending|#PB_Sort_NoCase,OffsetOf(UM_Data\UM_Sort_Name),TypeOf(UM_Data\UM_Sort_Name))
    
    If Short_Names
      old_pos=UM_Database()\UM_Short+Tags_Short()
    Else
      old_pos=UM_Database()\UM_Title+Tags()
    EndIf
    
    Protected itemheight, hotitem
    
    If change
      Save_DB()
    Else  
      SetActiveGadget(#MAIN_LIST)
    EndIf 
    
    Center_List(old_pos)
    
    If ListIndex(List_Numbers())=-1
      SelectElement(List_Numbers(),0)
      SetGadgetState(#MAIN_LIST,0)
    EndIf
    
    If ListSize(List_Numbers())>0
      Draw_Info(List_Numbers()\L_Number)
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
    
    If OpenWindow(#FILTER_WINDOW, x_pos, WindowY(#MAIN_WINDOW)+((WindowHeight(#MAIN_WINDOW)-610)/2), 325, 635, "Filter", #PB_Window_SystemMenu, WindowID(#MAIN_WINDOW))
      
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
      
      FrameGadgetCustom(#PB_Any,4,250,316,289,"Game Info")
      
      TextGadgetCol(12,274,86,24,"Publisher",#White)
      Publisher_Gadget=ComboBoxGadget(#PB_Any,106,270,206,22)
      TextGadgetCol(12,304,86,24,"Developer",#White)
      Developer_Gadget=ComboBoxGadget(#PB_Any,106,300,206,22)
      
      TextGadgetCol(12,364,86,24,"Demo Group",#White)
      Coder_Gadget=ComboBoxGadget(#PB_Any,106,360,206,22)
      TextGadgetCol(12,394,86,24,"Year",#White)
      Year_Gadget=ComboBoxGadget(#PB_Any,106,390,206,22)
      TextGadgetCol(12,424,86,24,"Language",#White)
      Language_Gadget=ComboBoxGadget(#PB_Any,106,420,206,22)
      TextGadgetCol(12,454,86,24,"Memory",#White)
      Memory_Gadget=ComboBoxGadget(#PB_Any,106,450,206,22)
      TextGadgetCol(12,484,94,24,"Number Of Disks",#White)
      Disks_Gadget=ComboBoxGadget(#PB_Any,106,480,206,22)
      TextGadgetCol(12,514,86,22,"Disk Type",#White)
      DiskCategory_Gadget=ComboBoxGadget(#PB_Any,106,510,206,22)
      
      FrameGadgetCustom(#PB_Any,4,545,316,82,"Other")
      
      TextGadgetCol(12,569,186,24,"Data Type",#White)
      DataType_Gadget=ComboBoxGadget(#PB_Any,106,565,206,20)
      
      TextGadgetCol(12,599,186,24,"Players",#White)
      Players_Gadget=ComboBoxGadget(#PB_Any,106,595,206,20)
      
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
      AddGadgetItem(Chipset_Gadget,-1,"OCS")
      AddGadgetItem(Chipset_Gadget,-1,"ECS")
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
      AddGadgetItem(DiskCategory_Gadget,-1,"Data Disk")
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
      Protected NewMap FGroup.s()
      Protected NewMap FCoder.s()
      Protected NewMap FYear.s()
      Protected NewMap FLang.s()
      Protected NewMap FDisks.s()
      Protected NewMap FMem.s()
      Protected NewList Sort.s()
      
      ForEach UM_Database()
        If UM_Database()\UM_Type="Demo" Or UM_Database()\UM_Type="Magazine" Or UM_Database()\UM_Type="Beta" 
          If UM_Database()\UM_Beta_Type<>"Game"          
            FCoder(UM_Database()\UM_Publisher)=UM_Database()\UM_Developer
          EndIf
        EndIf
        If UM_Database()\UM_Type="Game" Or UM_Database()\UM_Type="Beta" 
          If UM_Database()\UM_Beta_Type<>"Demo"  
            FPub(UM_Database()\UM_Publisher)=UM_Database()\UM_Publisher
            FDev(UM_Database()\UM_Developer)=UM_Database()\UM_Developer
          EndIf
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
      AddGadgetItem(Category_Gadget,-1,"Demos")
      AddGadgetItem(Category_Gadget,-1,"Beta")
      AddGadgetItem(Category_Gadget,-1,"Magazine")
      SetGadgetState(Category_Gadget,Filter(0)\Category)
      Resume_Gadget(Category_Gadget)
      
      Pause_Gadget(Filter_Gadget)
      AddGadgetItem(Filter_Gadget,-1,"All")
      AddGadgetItem(Filter_Gadget,-1,"AGS Pure")
      AddGadgetItem(Filter_Gadget,-1,"Favourite")
      AddGadgetItem(Filter_Gadget,-1,"Restricted")
      AddGadgetItem(Filter_Gadget,-1,"Too Long (Name)")
      AddGadgetItem(Filter_Gadget,-1,"Too Long (Pub)")
      AddGadgetItem(Filter_Gadget,-1,"Too Long (Dev)")
      AddGadgetItem(Filter_Gadget,-1,"Image Width")
      AddGadgetItem(Filter_Gadget,-1,"No Game Info")
      AddGadgetItem(Filter_Gadget,-1,"No Chipset")
      AddGadgetItem(Filter_Gadget,-1,"No CRC32")
      AddGadgetItem(Filter_Gadget,-1,"No Developer")
      AddGadgetItem(Filter_Gadget,-1,"No InstallSize")
      AddGadgetItem(Filter_Gadget,-1,"No Publisher")
      AddGadgetItem(Filter_Gadget,-1,"No Image")
      AddGadgetItem(Filter_Gadget,-1,"No Title")
      AddGadgetItem(Filter_Gadget,-1,"No Cover")   
      AddGadgetItem(Filter_Gadget,-1,"No Year")
      AddGadgetItem(Filter_Gadget,-1,"No HOL")
      AddGadgetItem(Filter_Gadget,-1,"No HOL New")
      AddGadgetItem(Filter_Gadget,-1,"No Lemon")
      AddGadgetItem(Filter_Gadget,-1,"No WHDLoad")
      AddGadgetItem(Filter_Gadget,-1,"No BitWorld")
      AddGadgetItem(Filter_Gadget,-1,"No Pouet")
      AddGadgetItem(Filter_Gadget,-1,"Invalid Genre")
      AddGadgetItem(Filter_Gadget,-1,"Dupe Slave")
      AddGadgetItem(Filter_Gadget,-1,"Missing Type")
      AddGadgetItem(Filter_Gadget,-1,"Dupe Short")
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
  
  If WParam = #WM_RBUTTONDOWN ; Editor gadget right click
    If GetActiveGadget() = Info_Gadget
      PostEvent(#PB_Event_Gadget, #MAIN_WINDOW, Info_Gadget, #PB_EventType_RightClick)
    EndIf
  EndIf
  
  Select umsg ; Listicon header click
    Case #WM_NOTIFY        ; these events are send as notification messages
      Protected *pnmh.NMHDR = lParam  ; lParam points to a structure with more info
      If *pnmh\hwndFrom = GadgetID(#MAIN_LIST) ; see if it is the right gadget
        Select *pnmh\code                      ; code contains actual message
          Case #LVN_COLUMNCLICK                ; user clicked on the Header of a column
            Protected *pnmv.NMLISTVIEW = lParam; another info structure  
            Protected Column.l = *pnmv\iSubItem; clicked column     
            Sort_Column=Column
            Select Column
              Case 0
                If Column_Sort(0)\Col1=#False : Column_Sort(0)\Col1=#True : Else : Column_Sort(0)\Col1=#False : EndIf
              Case 1
                If Column_Sort(0)\Col2=#False : Column_Sort(0)\Col2=#True : Else : Column_Sort(0)\Col2=#False : EndIf
              Case 2
                If Column_Sort(0)\Col3=#False : Column_Sort(0)\Col3=#True : Else : Column_Sort(0)\Col3=#False : EndIf
              Case 3
                If Column_Sort(0)\Col4=#False : Column_Sort(0)\Col4=#True : Else : Column_Sort(0)\Col4=#False : EndIf
            EndSelect                                                    
            Draw_List()
            Draw_Info(0)
        EndSelect     
      EndIf 
  EndSelect
  
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
      output$+"; Created With AGS Database Manager "+Version+#CRLF$
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
  UseLZMAPacker()
  UseZipPacker()
  UseCRC32Fingerprint()
  UseSHA1Fingerprint()
  UseMD5Fingerprint()
  
  CatchImage(#CREATE_ICON,?Create_Image)
  CatchImage(#DELETE_ICON,?Delete_Image)
  CatchImage(#NEW_ICON,?New_Image)
  CatchImage(#QUIT_ICON,?Quit_Image)
  CatchImage(#UPDATE_ICON,?Update_Image)
  CatchImage(#ARCHIVE_ICON,?Archive_Image)
  CatchImage(#PDF_IMAGE,?PDF_Image)
  CatchImage(#TEXT_IMAGE,?Text_Image)
  CatchImage(#PLAY_ICON,?Play_Image)
  CatchImage(#SAVE_ICON,?Save_Image)
  CatchImage(#IMAGE_ICON,?Image_Image)
  CatchImage(#OPTIONS_ICON,?Options_Image)
  CatchImage(#FAVOURITE_ICON,?Fave_Image)
  CatchImage(#FOLDER_ICON,?Folder_Image)
  CatchImage(#HOL_ICON,?Hol_Image)
  CatchImage(#LEMON_ICON,?Lemon_Image)
  CatchImage(#WHD_ICON,?WHD_Image)
  CatchImage(#JANEWAY_ICON,?Janeway_Image)
  CatchImage(#POUET_ICON,?Pouet_Image)
  CatchImage(#HOL_NEW_ICON,?Hol_New_Image)
  ResizeImage(#HOL_NEW_ICON,16,16,#PB_Image_Smooth)
  ResizeImage(#HOL_ICON,16,16,#PB_Image_Smooth)
  Create_Blanks()
  
  ; PD Image Fonts
  
  LoadFont(#SMALL_FONT,"Ballpoint Signature",25,#PB_Font_Bold)
  LoadFont(#PREVIEW_FONT,"Ballpoint Signature",27,#PB_Font_Bold)
  LoadFont(#HEADER_FONT,"Times New Roman",32,#PB_Font_Bold)
  
  ; Game Info Font
  
  LoadFont(#INFO_FONT,"Consolas",9)
  
  Load_Prefs() 
  Load_DB()
    
  ForEach UM_Database()
    UM_Database()\UM_Sort_Date=Convert_AGS_Date(UM_Database()\UM_Slave_Date)
  Next
  
  ;Make_AGS_HDF()
  
  ;Make_Lazybench_Menu()
  
  If ReadFile(#FILE,Data_Path+"um_genres.dat")
    While Not Eof(#FILE)
      AddElement(Genre_List())
      Genre_List()=ReadString(#FILE)
      Genre_Map(Genre_List())=ListIndex(Genre_List())
    Wend
    AddElement(Genre_List())
    Genre_List()="Unknown"
    Genre_Map(Genre_List())=ListIndex(Genre_List())
    CloseFile(#FILE)  
  EndIf
  
  SortList(Genre_List(),#PB_Sort_Ascending)  
  
  ForEach Genre_List()
    Genre_Map(Genre_List())=ListIndex(Genre_List())
  Next
  
  path=""
  path2="" 
    
  Reset_Filter()
  Draw_Main_Window()
  Draw_List()
  
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
      
        If CountGadgetItems(#MAIN_LIST)>0
          If EventwParam() = #VK_F6
            Reset_Filter()
            SetGadgetText(Search_Gadget,"")
            Draw_List()
            Draw_Info(List_Numbers()\L_Number)
          EndIf
          If GetActiveGadget()<>Search_Gadget
            If EventwParam() = #VK_RETURN
              If CountGadgetItems(#MAIN_LIST)>0 And GetGadgetState(#MAIN_LIST)>-1
                Set_Database()
                Run_Game(List_Numbers()\L_Number)
              EndIf 
            EndIf
            If EventwParam() = #VK_SPACE
              If CountGadgetItems(#MAIN_LIST)>0 And GetGadgetState(#MAIN_LIST)>-1
                Set_Database()
                Edit_Database(List_Numbers()\L_Number)
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
              Run_Game(List_Numbers()\L_Number)
            EndIf
          EndIf ;} 
        Case #MenuItem_2a  ;{- WinUAE Setup
          RunProgram(WinUAE_Path, "-f "+IG_Path+"Setup.uae","",#PB_Program_Wait) 
                           ;}   
        Case #Menuitem_2b  ;{- Favourite
          If ListSize(List_Numbers())>0
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
        Case #Menuitem_2c  ;{- Redownload Game
          If ListSize(List_Numbers())>0
            Set_Database()
            ReDownload_Game()
          EndIf
          ;}
        Case #MenuItem_3   ;{- Save Gameslist (CSV)
          If ListSize(UM_Database())>0
            path=SaveFileRequester("Save List (CSV)","gameslist.csv","*.csv",0)
            If path<>""
              Save_GL_CSV(path,#False,#False,#False)
            EndIf
          EndIf ;}
        Case #MenuItem_4   ;{- Save Database
          If MessageRequester("Save DB","Save Database?",#PB_MessageRequester_Warning|#PB_MessageRequester_YesNo)=#PB_MessageRequester_Yes
            Save_DB()
          EndIf ;}
        Case #MenuItem_5a  ;{- Filter
          Filter_Window()
          ;}
        Case #MenuItem_6   ;{- IGame Data
          Generate_IGame_Data(PathRequester("Select output folder",""));}
        Case #MenuItem_7   ;{- Open Game Data Folder
          Set_Database()
          path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"
          RunProgram("file://"+path);}
        Case #MenuItem_8   ;{- Open WHD Folder
          Set_Database()
          path=WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"
          RunProgram("file://"+path);}
        Case #MenuItem_8a  ;{- Open Screen Shots
          Set_Database()
          path=Home_Path+"Screenshots\"
          RunProgram("file://"+path);}
        Case #MenuItem_8b  ;{- Open Archive
          Set_Database()
          path=WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile
          RunProgram("file://"+path);}
        Case #MenuItem_9   ;{- Open HOL Page
          Set_Database()
          If UM_Database()\UM_HOL_Entry<>""
            RunProgram("http://hol.abime.net/"+UM_Database()\UM_HOL_Entry)
          EndIf;}
        Case #MenuItem_9e  ;{- Open HOL Page
          Set_Database()
          If UM_Database()\UM_HOL_Entry_New<>""
            RunProgram("http://amiga.abime.net/games/view/"+UM_Database()\UM_HOL_Entry_New)
          EndIf;}
        Case #MenuItem_9a  ;{- Open Lemon Page
          Set_Database()
          If UM_Database()\UM_Lemon_Entry<>""
            RunProgram("https://www.lemonamiga.com/games/details.php?id="+UM_Database()\UM_Lemon_Entry)
          EndIf;}
        Case #MenuItem_9b  ;{- Open WHDLoad Page
          Set_Database()
          If UM_Database()\UM_WHD_Entry<>""
            Select UM_Database()\UM_Type
              Case "Demo": RunProgram("http://www.whdload.de/demos/"+UM_Database()\UM_WHD_Entry+".html")
              Case "Beta": RunProgram("http://www.whdload.de/games/"+UM_Database()\UM_WHD_Entry+".html")
              Case "Game": RunProgram("http://www.whdload.de/games/"+UM_Database()\UM_WHD_Entry+".html")
              Case "Magazine": RunProgram("http://www.whdload.de/mags/"+UM_Database()\UM_WHD_Entry+".html")
            EndSelect
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
          If MessageRequester("Exit AGS Database Manager", "Do you want to quit?",#PB_MessageRequester_YesNo|#PB_MessageRequester_Warning,WindowID(#MAIN_WINDOW))=#PB_MessageRequester_Yes
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
        Case #MenuItem_10e ;{- EMPTY!
          
          ;}          
        Case #MenuItem_11  ;{- Backup Images
          Backup_Images()  ;}
        Case #MenuItem_12  ;{- Make PD Image Set
          Make_PD_Disk_Set() ;}
        Case #MenuItem_13  ;{- Make PD Image
          Make_PD_Disk()
          ;} 
        Case #MenuItem_14  ;{- Generate IGame Data
          Save_IG_DB()
          ;}
        Case #MenuItem_15  ;{- Re-install game
          ReInstall_Game(List_Numbers()\L_Number)
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
        Case #MenuItem_18a ;{- Make AGS Folder
          Create_AGS_Single()
          ;}
        Case #MenuItem_18b ;{- Make Game List
          Make_AGS_Guide(Home_Path+"WHDLoad_Games_Database.guide",#False,#False)
          Make_AGS_Demos_Guide(Home_Path+"WHDLoad_Demos_Database.guide",#False,#False)
          Write_Guides(Home_Path,#False)
          ;}
        Case #MenuItem_18e ;{- Make Extra Texts
          Make_Extra_Texts()
          ;}
        Case #MenuItem_18c ;{- Make Demo List
          Make_AGS_Demos_Guide(Home_Path+"WHDLoad_Demo_List.guide",#False,#False)
          ;}        
        Case #MenuItem_18d ;{- Export Database
          Export_AGS_Database()
          Make_Retroarch_Dat()
          ;}
        Case #MenuItem_18f ;{- Compare AGS Folders
          Compare_AGS_Folders_Old()
          ;}
        Case #MenuItem_19  ;{- Get All Archive Sizes
          OpenConsole("Getting Game Sizes")
          Center_Console()
          ForEach UM_Database()
            PrintN("Processing : "+UM_Database()\UM_Title+Tags())
            UM_Database()\UM_InstallSize=Get_Install_Size(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile)
            PrintN("Size : "+UM_Database()\UM_InstallSize) 
          Next
          CloseConsole()
          SetGadgetState(#MAIN_LIST,0)
          SelectElement(List_Numbers(),0)
          SelectElement(UM_Database(),List_Numbers()\L_Number)
          Draw_Info(List_Numbers()\L_Number)
          ;}
        Case #MenuItem_20  ;{- Get Archive Sizes
          OpenConsole("Getting Game Sizes")
          Center_Console()
          PrintN("Processing : "+UM_Database()\UM_Title+Tags())
          UM_Database()\UM_InstallSize=Get_Install_Size(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile)
          PrintN("Size : "+UM_Database()\UM_InstallSize) 
          Delay(2000)
          CloseConsole()
          Draw_Info(List_Numbers()\L_Number)
          ;}      
        Case #MenuItem_21  ;{- Update FTP
          Download_HTTP()
          ;Scan_FTP()
          ;}
        Case #MenuItem_21a ;{- Update FTP (Clean)
          DeleteDirectory(Dats_Path,"",#PB_FileSystem_Force)
          Download_HTTP()
          ;Scan_FTP()
          ;}
        Case #MenuItem_22  ;{- Update Database
          Update_Database()
          Reset_Filter()
          Draw_List()  
          Draw_Info(List_Numbers()\L_Number)
          ;} 
        Case #MenuItem_22a ;{- Update HDF
          Update_HDF()
          ;} 
        Case #MenuItem_23  ;{- Full Update
          Download_HTTP()
          Update_Database()
          If MessageRequester("Update","Update Amiga HDF",#PB_MessageRequester_YesNo|#PB_MessageRequester_Info)=#PB_MessageRequester_Yes
            Update_HDF()
          EndIf
          Draw_List();}  
        Case #MenuItem_26  ;{- Delete Entry
          If CountGadgetItems(#MAIN_LIST)>0
            If MessageRequester("Delete Entry","Delete Current Entry?", #PB_MessageRequester_YesNo|#PB_MessageRequester_Warning)=#PB_MessageRequester_Yes              
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
              Draw_Info(List_Numbers()\L_Number)
            EndIf                        
          EndIf ;}         
        Case #MenuItem_27  ;{- Edit Entry
          If CountGadgetItems(#MAIN_LIST)>0
            SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
            Edit_Database(List_Numbers()\L_Number)
          EndIf ;}  
        Case #MenuItem_28  ;{- Extract text files
          Make_AGS_Guide(Home_Path+"Games.guide",#False,#False)
          Make_AGS_Demos_Guide(Home_Path+"Demos.guide",#False,#False)
          Write_Guides(Home_Path,#False)
          Export_AGS_Database()
          ;Extract_Text_Files_Single(WHD_Folder+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_LHAFile)
          ;} 
        Case #MenuItem_31  ;{- Settings Window
          Settings_Window()  
          ;}
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
              Draw_Info(List_Numbers()\L_Number)
            EndIf
          Else
            MessageRequester("Error","Cannot find genres file!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
          EndIf                
          ;}           
        Case #MenuItem_46  ;{- Refresh List
          Draw_List()
          If ListSize(List_Numbers())>0
            SelectElement(List_Numbers(),0)
            Draw_Info(List_Numbers()\L_Number)
          Else
            Draw_Info(-1)
          EndIf
          ;}
        Case #MenuItem_47  ;{- Make USB Drive
          Make_A500_WHD_USB()
          ;}
        Case #MenuItem_51  ;{- Save DB Entry
          path=SaveFileRequester("Save Entry","database_entry.json","*.json",-1)
          Save_DB_Entry(path)
          ;}
        Case #MenuItem_52  ;{- Load DB Entry
          If MessageRequester("Warning","Load database entry?",#PB_MessageRequester_Warning|#PB_MessageRequester_YesNo)=#PB_MessageRequester_Yes
            Restore_DB_Entry()
            Draw_List()
            If ListSize(List_Numbers())>0
              SelectElement(List_Numbers(),0)
              Draw_Info(List_Numbers()\L_Number)
            Else
              Draw_Info(-1)
            EndIf
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
        Case #MenuItem_97  ;{- Paste Game Info Text
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
        Case #MenuItem_98  ;{- Delete Game Info Text
          If UM_Database()\UM_Type<>"Demo"
            If MessageRequester("Delete","Clear Info?",#PB_MessageRequester_Warning|#PB_MessageRequester_YesNo)=#PB_MessageRequester_Yes
              DeleteDirectory(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder,"*.txt")
              Draw_Game_Info(0)
            EndIf
            DestroyCaret_()
          EndIf
          SetActiveGadget(#MAIN_LIST);}    
        Case #MenuItem_99  ;{- Edit Game Info Text
          If UM_Database()\UM_Type<>"Demo"
            RunProgram("notepad.exe",Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\game_info.txt","",#PB_Program_Wait)
            Draw_Game_Info(0)
            DestroyCaret_()
          EndIf
          SetActiveGadget(#MAIN_LIST)  ;}
        Case #MenuItem_99a ;{- Copy Web Info
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
        Case #MenuItem_99b ;{- Paste Web Info
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
          Draw_Info(List_Numbers()\L_Number) 
          ;}
        Case #MenuItem_99c ;{- Edit Game Info Text
          SetClipboardText(GetSelectedText(Info_Gadget))
          ;}
          
      EndSelect
      
      ;- ############### Drag&Drop Events
      
    Case #PB_Event_GadgetDrop
      
      Select EventGadget()
          
        Case Cover_Image
          If EventDropFiles()>""
            If GetGadgetState(#MAIN_LIST)<>-1              
              If GetExtensionPart(EventDropFiles())="png" Or GetExtensionPart(EventDropFiles())="jpg" Or GetExtensionPart(EventDropFiles())="iff"
                  CreateDirectory(Game_Data_Path+UM_Database()\UM_Type+"\")
                  CreateDirectory(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\")
                  CreateDirectory(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder)
                  path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Cover.png"
                  Resize_Cover(EventDropFiles(), path)
                  Draw_Info(List_Numbers()\L_Number)
              Else
                MessageRequester("Error","Not An Image File!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
              EndIf
            EndIf
          EndIf
          
        Case Title_Image
          If EventDropFiles()>""
            If GetGadgetState(#MAIN_LIST)<>-1
              If GetExtensionPart(EventDropFiles())="png" Or GetExtensionPart(EventDropFiles())="jpg" Or GetExtensionPart(EventDropFiles())="iff"
                CreateDirectory(Game_Data_Path+UM_Database()\UM_Type+"\")
                CreateDirectory(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\")
                CreateDirectory(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder)
                path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Title.png"
                Resize_Image(EventDropFiles(), path)
                Draw_Info(List_Numbers()\L_Number)
              Else
                MessageRequester("Error","Not An Image File!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
              EndIf
            EndIf
          EndIf
          
        Case Screen_Image
          If EventDropFiles()>""
            If GetGadgetState(#MAIN_LIST)<>-1
              If GetExtensionPart(EventDropFiles())="png" Or GetExtensionPart(EventDropFiles())="jpg" Or GetExtensionPart(EventDropFiles())="iff"
                CreateDirectory(Game_Data_Path+UM_Database()\UM_Type+"\")
                CreateDirectory(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\")
                CreateDirectory(Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder)
                path=Game_Data_Path+UM_Database()\UM_Type+"\"+UM_Database()\UM_Subfolder+"\"+UM_Database()\UM_Folder+"\"+GetFilePart(UM_Database()\UM_Icon,#PB_FileSystem_NoExtension)+"_Screen.png"
                Resize_Image(EventDropFiles(), path)
                Draw_Info(List_Numbers()\L_Number)
              Else
                MessageRequester("Error","Not An Image File!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
              EndIf
            EndIf
          EndIf            
          
        Case Logo_Image
          If EventDropFiles()>""
            If GetGadgetState(#MAIN_LIST)<>-1
              If GetExtensionPart(EventDropFiles())="png" Or GetExtensionPart(EventDropFiles())="jpg" Or GetExtensionPart(EventDropFiles())="iff"
                path=Game_Data_Path+"Logos\"+UM_Database()\UM_Publisher+".png"
                Resize_Logo(EventDropFiles(), path)
                Draw_Info(List_Numbers()\L_Number)
              Else
                MessageRequester("Error","Not An Image File!",#PB_MessageRequester_Error|#PB_MessageRequester_Ok)
              EndIf
            EndIf
          EndIf 
      EndSelect
      
      ;- ############### Gadget Events    
      
    Case #PB_Event_Gadget
      
      Select EventGadget()
          
        Case Filter_Button
          Filter_Window()
                    
        Case #MAIN_LIST
          If CountGadgetItems(#MAIN_LIST)>0 And GetGadgetState(#MAIN_LIST)>-1
            If EventType()= #PB_EventType_Change
              SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
              SelectElement(UM_Database(),List_Numbers()\L_Number)
              Draw_Info(List_Numbers()\L_Number)
            EndIf
            If EventType() = #PB_EventType_LeftDoubleClick
              PostEvent(#PB_Event_Menu,#MAIN_WINDOW,#MenuItem_1)
            EndIf
            If EventType() = #PB_EventType_RightClick
              SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
              SelectElement(UM_Database(),List_Numbers()\L_Number)
              Draw_Info(List_Numbers()\L_Number)
              If GetActiveGadget()=#MAIN_LIST
                DisplayPopupMenu(#POPUP_MENU, WindowID(#MAIN_WINDOW))
              EndIf
            EndIf
          EndIf
          
        Case Info_Gadget
          If EventType() = #PB_EventType_RightClick
            SelectElement(List_Numbers(),GetGadgetState(#MAIN_LIST))
            SelectElement(UM_Database(),List_Numbers()\L_Number)
            If GetActiveGadget()=Info_Gadget
              If UM_Database()\UM_Type<>"Demo"
                DisplayPopupMenu(#EDITOR_MENU, WindowID(#MAIN_WINDOW))
                SetActiveGadget(#MAIN_LIST)
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
          SetGadgetText(Search_Gadget,"")
          Draw_List()
          Draw_Info(List_Numbers()\L_Number)
          
        Case Chipset_Gadget, Year_Gadget, Language_Gadget, Memory_Gadget, Disks_Gadget, Hardware_Gadget, Sound_Gadget, DiskCategory_Gadget, DataType_Gadget, Category_Gadget, Genre_Gadget, Filter_Gadget, Players_Gadget
          
          If EventType()=#PB_EventType_Change 
            
            Select GetGadgetState(Category_Gadget)
              Case 0 : Filter(0)\Category_Text="All" 
              Case 1 : Filter(0)\Category_Text="Game"
              Case 2 : Filter(0)\Category_Text="Demo"
              Case 3 : Filter(0)\Category_Text="Beta"
              Case 4 : Filter(0)\Category_Text="Magazine"
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
              Draw_Info(List_Numbers()\L_Number)
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
              Draw_Info(List_Numbers()\L_Number)
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
              Draw_Info(List_Numbers()\L_Number)
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
              Draw_Info(List_Numbers()\L_Number)
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
              Draw_Info(List_Numbers()\L_Number)
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
  
  Archive_Image:
  IncludeBinary "images\archive.png"
  
  Create_Image:
  IncludeBinary "images\create.png"
  
  Delete_Image:
  IncludeBinary "images\delete.png"
  
  New_Image:
  IncludeBinary "images\new.png"
  
  Quit_Image:
  IncludeBinary "images\quit.png"
  
  Update_Image:
  IncludeBinary "images\update.png"
  
  PDF_Image:
  IncludeBinary "images\pdf.png"
  
  Text_Image:
  IncludeBinary "images\text.png"
  
  Options_Image:
  IncludeBinary "images\options.png"
  
  Save_Image:
  IncludeBinary "images\save.png"
  
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
  
  HOL_New_Image:
  IncludeBinary "images\hol_new.png"
  
  Lemon_Image:
  IncludeBinary "images\lemon.png"
  
  WHD_Image:
  IncludeBinary "images\WHD.png"
  
  Janeway_Image:
  IncludeBinary "images\Janeway.png"
  
  Pouet_Image:
  IncludeBinary "images\Pouet.png"
  
  AGS_Image:
  IncludeBinary "images\ags_icon.png"
  
EndDataSection
; IDE Options = PureBasic 6.21 (Windows - x64)
; CursorPosition = 14029
; FirstLine = 3928
; Folding = AAAAAAAgAAAAAAAAAAAIISAYCAAAAAAAAAg
; Optimizer
; EnableThread
; EnableXP
; DPIAware
; UseIcon = Images\joystick.ico
; Executable = E:\AGS_Database\AGS_Database_Manager.exe
; CurrentDirectory = E:\AGS_Database\
; Compiler = PureBasic 6.21 (Windows - x64)
; Debugger = Standalone