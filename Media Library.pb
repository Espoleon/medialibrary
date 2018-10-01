;##################################################
;# 
;# Project:		Media Library
;# Created:		11.09.2018
;# Author:		Espoleon a.k.a. Autonomus
;# Copyright:	Define X Software
;# 
;##################################################

;{ =====[Developer Log]=====

;#####################
;# 									 #
;# Developer Log		 #
;# » List of changes #
;# 									 #
;#####################

;
; + Added, - Removed, / Changed
; 
; 01.10.2018
; 
; / Expanded the search function -> [AgeRating] and [Role]
; + New function -> ML_Func_SQL()
; + SQL binding
; 
; 30.09.2018
; 
; / Compiler changed from [32-Bit] to [64-Bit]
; 
; 21.09.2018
; 
; + ML_Func_Movies() -> [AddMovie], [LoadMovies], [LoadMoviesByTitle], [LoadMoviesByRelease], [LoadMoviesByLength], [LoadMoviesByGenre], [LoadMoviesByStudio], [LoadMoviesByRegie], [LoadMoviesByActor], [LoadMoviesByAgeRating] and [ListMoviesQuery]
; + ML_Func_Movies() -> [ListMoviesQuery] -> search by [Title], [Release], [Length], [Genre] (search between 1 and 3 genres by using ", "), [Studio], [Regie], [Actor] (search between 1 and 3 actors by using ", ") and [AgeRating]
; + Fifth SubNavi
; 
; Reached Line [3000]
; 
; 20.09.2018
; 
; Reached Line [2000]
; 
; 18.09.2018
; 
; + Added 2 new Navi Designs [Version One] and [Version Two]
; + Navi now usable
; 
; Reached Line [1000]
; 
; 17.09.2018
; 
; + Create SubNavigation
; 
; 15.09.2018
; 
; + New function -> ML_Func_Movies()
; + Create Navigation
; + Load Font [Arial] from size 8 to 12 in regular and bold
; / Set window background color
; 
; 12.09.2018
; 
; + Create Window with different parameters to choose [Default], [Borderless], [Centered] or [BorderlessCentered]
; + Create Shortcut [Esc] with parameters [Quit] or [Minimize]
; 
; 11.09.2018
; 
; + Start new project [Media Library]
; 

;}

;{ =====[Media Library - Preparing]=====

;{ -----[Include]-----

XIncludeFile "Source\Core Project.pbi"

;}

Procedure ML_Msg(Text.s)
  
  MessageRequester(ML_Info_Name.s, Text.s)
  
EndProcedure

Procedure ML_Msg_Error(ErrorText.s)
  
  MessageRequester(ML_Info_Name.s, "Error: " + ErrorText.s)
  
EndProcedure

Procedure ML_Init()
  
  If Not UsePNGImageDecoder() : ML_Msg_Error(ML_Error_InitPNGDecoder.s) : End : EndIf
  If Not UsePNGImageEncoder() : ML_Msg_Error(ML_Error_InitPNGEncoder.s) : End : EndIf
  If Not UseSQLiteDatabase() : ML_Msg_Error(ML_Error_InitSQLDatabase.s) : End : EndIf
  
EndProcedure

;{ -----[Adding To List]-----

CLMF("Add", 0, "Media Library Info", "Name", 0, 0, 0, 0, 0, "Media Library")
CLMF("Add", 0, "Media Library Info", "Description", 0, 0, 0, 0, 0, "Verwaltung für Medien")
CLMF("Add", 0, "Media Library Info", "Created", 0, 0, 0, 0, 0, "11.09.2018")

CLMF("Add", 0, "Media Library Settings", "Window_X", 0, 15, 0, 0, 0, "15")
CLMF("Add", 0, "Media Library Settings", "Window_Y", 0, 15, 0, 0, 0, "15")
CLMF("Add", 0, "Media Library Settings", "Window_W", 0, 1280, 0, 0, 0, "1280")
CLMF("Add", 0, "Media Library Settings", "Window_H", 0, 720, 0, 0, 0, "720")
CLMF("Add", 0, "Media Library Settings", "Window_F", 0, 2, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Settings", "Window_BGColor", 0, RGB(89, 89, 89), 0, 0, 0, Str(RGB(89, 89, 89)))
CLMF("Add", 0, "Media Library Settings", "Navi_Design", 0, 0, 0, 0, 0, "") ; Default = [0], Version One = [1], Version Two = [2]
CLMF("Add", 0, "Media Library Settings", "NaviButton_Color", 0, RGB(155, 155, 155), 0, 0, 0, Str(RGB(155, 155, 155)))
CLMF("Add", 0, "Media Library Settings", "NaviButtonOver_Color", 0, RGB(255, 255, 255), 0, 0, 0, Str(RGB(255, 255, 255)))
CLMF("Add", 0, "Media Library Settings", "NaviText_Font", 0, 7, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Settings", "SubNaviText_Font", 0, 5, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Settings", "Shortcut_Esc", 0, 0, 0, 0, 0, "Quit") ; Quit = [0], Minimize = [1]
CLMF("Add", 0, "Media Library Settings", "Menu", 0, 0, 0, 0, 0, "") ; Start = [0], Movies = [1], Series = [2], Games = [3], Settings = [4], Informations = [5]
CLMF("Add", 0, "Media Library Settings", "Movies_Entry_View", 0, 0, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Settings", "Movies_Entry_Edge", 0, 2, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Settings", "Movies_Entry_BGColor", 0, RGB(155, 155, 155), 0, 0, 0, "")
CLMF("Add", 0, "Media Library Settings", "Movies_Entry_Over_BGColor", 0, RGB(255, 255, 255), 0, 0, 0, "")
CLMF("Add", 0, "Media Library Settings", "Movies_Entry_Title_Color", 0, RGB(0, 0, 0), 0, 0, 0, "")
CLMF("Add", 0, "Media Library Settings", "Movies_Entry_Details_Color", 0, RGB(75, 75, 75), 0, 0, 0, "")
CLMF("Add", 0, "Media Library Settings", "File_Movies", 0, 0, 0, 0, 0, "Data\Movies.ini")

CLMF("Add", 0, "Media Library Coordinates", "SubNaviTitle_X", 0, 0, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviTitle_Y", 0, 45, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviTitle_W", 0, 450, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviTitle_H", 0, 40, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviOne_X", 0, 450, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviOne_Y", 0, 45, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviOne_W", 0, 160, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviOne_H", 0, 40, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviOneText_X", 0, 70, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviOneText_Y", 0, 15, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviTwo_X", 0, 610, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviTwo_Y", 0, 45, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviTwo_W", 0, 160, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviTwo_H", 0, 40, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviTwoText_X", 0, 30, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviTwoText_Y", 0, 15, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviThree_X", 0, 770, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviThree_Y", 0, 45, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviThree_W", 0, 160, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviThree_H", 0, 40, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviThreeText_X", 0, 60, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviThreeText_Y", 0, 15, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviFour_X", 0, 930, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviFour_Y", 0, 45, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviFour_W", 0, 160, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviFour_H", 0, 40, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviFourText_X", 0, 55, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviFourText_Y", 0, 15, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviFive_X", 0, 1090, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviFive_Y", 0, 45, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviFive_W", 0, 160, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviFive_H", 0, 40, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviFiveText_X", 0, 50, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviFiveText_Y", 0, 15, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviEnd_X", 0, 1250, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviEnd_Y", 0, 45, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviEnd_W", 0, 30, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "SubNaviEnd_H", 0, 40, 0, 0, 0, "")

CLMF("Add", 0, "Media Library Coordinates", "Movies_Count_X", 0, 55, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "Movies_Count_Y", 0, 47, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "Movies_Count_W", 0, 40, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "Movies_Count_H", 0, 30, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "Movies_Entry_Line_X", 0, 30, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "Movies_Entry_Line_Y", 0, 115, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "Movies_Entry_Line_W", 0, 600, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "Movies_Entry_Line_H", 0, 25, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "Movies_Entry_LineDetails_X", 0, 30, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "Movies_Entry_LineDetails_Y", 0, 115, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "Movies_Entry_LineDetails_W", 0, 600, 0, 0, 0, "")
CLMF("Add", 0, "Media Library Coordinates", "Movies_Entry_LineDetails_H", 0, 40, 0, 0, 0, "")

;}

;{ -----[Globals]-----

Global ML_Info_Name.s = CLMF_String("GetStr", 0, "Media Library Info", "Name")
Global ML_Info_Description.s = CLMF_String("GetStr", 0, "Media Library Info", "Description")
Global ML_Info_Created.s = CLMF_String("GetStr", 0, "Media Library Info", "Created")
Global ML_Info_Date.s = FormatDate("%dd.%mm.%yyyy", Date())
Global ML_Info_Time.s = FormatDate("%hh:%ii:%ss", Date())

Global ML_Settings_Window_X.i = CLMF("GetInt", 0, "Media Library Settings", "Window_X")
Global ML_Settings_Window_Y.i = CLMF("GetInt", 0, "Media Library Settings", "Window_Y")
Global ML_Settings_Window_W.i = CLMF("GetInt", 0, "Media Library Settings", "Window_W")
Global ML_Settings_Window_H.i = CLMF("GetInt", 0, "Media Library Settings", "Window_H")
Global ML_Settings_Window_F.i = CLMF("GetInt", 0, "Media Library Settings", "Window_F")
Global ML_Settings_Window_BGColor.i = CLMF("GetInt", 0, "Media Library Settings", "Window_BGColor")
Global ML_Settings_Navi_Design.i = CLMF("GetInt", 0, "Media Library Settings", "Navi_Design")
Global ML_Settings_NaviButton_Color.i = CLMF("GetInt", 0, "Media Library Settings", "NaviButton_Color")
Global ML_Settings_NaviButtonOver_Color.i = CLMF("GetInt", 0, "Media Library Settings", "NaviButtonOver_Color")
Global ML_Settings_NaviText_Font.i = CLMF("GetInt", 0, "Media Library Settings", "NaviText_Font")
Global ML_Settings_SubNaviText_Font.i = CLMF("GetInt", 0, "Media Library Settings", "SubNaviText_Font")
Global ML_Settings_Shortcut_Esc.s = CLMF_String("GetStr", 0, "Media Library Settings", "Shortcut_Esc")
Global ML_Settings_Menu.i = CLMF("GetInt", 0, "Media Library Settings", "Menu")
Global ML_Settings_Movies_Entry_View.i = CLMF("GetInt", 0, "Media Library Settings", "Movies_Entry_View")
Global ML_Settings_Movies_Entry_Edge.i = CLMF("GetInt", 0, "Media Library Settings", "Movies_Entry_Edge")
Global ML_Settings_Movies_Entry_BGColor.i = CLMF("GetInt", 0, "Media Library Settings", "Movies_Entry_BGColor")
Global ML_Settings_Movies_Entry_Over_BGColor.i = CLMF("GetInt", 0, "Media Library Settings", "Movies_Entry_Over_BGColor")
Global ML_Settings_Movies_Entry_Title_Color.i = CLMF("GetInt", 0, "Media Library Settings", "Movies_Entry_Title_Color")
Global ML_Settings_Movies_Entry_Details_Color.i = CLMF("GetInt", 0, "Media Library Settings", "Movies_Entry_Details_Color")
Global ML_Settings_File_Movies.s = CLMF_String("GetStr", 0, "Media Library Settings", "File_Movies")

Global ML_Coordinate_SubNaviTitle_X.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviTitle_X")
Global ML_Coordinate_SubNaviTitle_Y.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviTitle_Y")
Global ML_Coordinate_SubNaviTitle_W.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviTitle_W")
Global ML_Coordinate_SubNaviTitle_H.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviTitle_H")
Global ML_Coordinate_SubNaviOne_X.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviOne_X")
Global ML_Coordinate_SubNaviOne_Y.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviOne_Y")
Global ML_Coordinate_SubNaviOne_W.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviOne_W")
Global ML_Coordinate_SubNaviOne_H.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviOne_H")
Global ML_Coordinate_SubNaviOneText_X.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviOneText_X")
Global ML_Coordinate_SubNaviOneText_Y.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviOneText_Y")
Global ML_Coordinate_SubNaviTwo_X.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviTwo_X")
Global ML_Coordinate_SubNaviTwo_Y.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviTwo_Y")
Global ML_Coordinate_SubNaviTwo_W.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviTwo_W")
Global ML_Coordinate_SubNaviTwo_H.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviTwo_H")
Global ML_Coordinate_SubNaviTwoText_X.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviTwoText_X")
Global ML_Coordinate_SubNaviTwoText_Y.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviTwoText_Y")
Global ML_Coordinate_SubNaviThree_X.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviThree_X")
Global ML_Coordinate_SubNaviThree_Y.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviThree_Y")
Global ML_Coordinate_SubNaviThree_W.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviThree_W")
Global ML_Coordinate_SubNaviThree_H.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviThree_H")
Global ML_Coordinate_SubNaviThreeText_X.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviThreeText_X")
Global ML_Coordinate_SubNaviThreeText_Y.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviThreeText_Y")
Global ML_Coordinate_SubNaviFour_X.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviFour_X")
Global ML_Coordinate_SubNaviFour_Y.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviFour_Y")
Global ML_Coordinate_SubNaviFour_W.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviFour_W")
Global ML_Coordinate_SubNaviFour_H.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviFour_H")
Global ML_Coordinate_SubNaviFourText_X.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviFourText_X")
Global ML_Coordinate_SubNaviFourText_Y.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviFourText_Y")
Global ML_Coordinate_SubNaviFive_X.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviFive_X")
Global ML_Coordinate_SubNaviFive_Y.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviFive_Y")
Global ML_Coordinate_SubNaviFiveText_X.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviFiveText_X")
Global ML_Coordinate_SubNaviFiveText_Y.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviFiveText_Y")
Global ML_Coordinate_SubNaviFive_W.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviFive_W")
Global ML_Coordinate_SubNaviFive_H.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviFive_H")
Global ML_Coordinate_SubNaviEnd_X.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviEnd_X")
Global ML_Coordinate_SubNaviEnd_Y.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviEnd_Y")
Global ML_Coordinate_SubNaviEnd_W.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviEnd_W")
Global ML_Coordinate_SubNaviEnd_H.i = CLMF("GetInt", 0, "Media Library Coordinates", "SubNaviEnd_H")

Global ML_Coordinate_Movies_Count_X.i = CLMF("GetInt", 0, "Media Library Coordinates", "Movies_Count_X")
Global ML_Coordinate_Movies_Count_Y.i = CLMF("GetInt", 0, "Media Library Coordinates", "Movies_Count_Y")
Global ML_Coordinate_Movies_Count_W.i = CLMF("GetInt", 0, "Media Library Coordinates", "Movies_Count_W")
Global ML_Coordinate_Movies_Count_H.i = CLMF("GetInt", 0, "Media Library Coordinates", "Movies_Count_H")
Global ML_Coordinate_Movies_Entry_Line_X.i = CLMF("GetInt", 0, "Media Library Coordinates", "Movies_Entry_Line_X")
Global ML_Coordinate_Movies_Entry_Line_Y.i = CLMF("GetInt", 0, "Media Library Coordinates", "Movies_Entry_Line_Y")
Global ML_Coordinate_Movies_Entry_Line_W.i = CLMF("GetInt", 0, "Media Library Coordinates", "Movies_Entry_Line_W")
Global ML_Coordinate_Movies_Entry_Line_H.i = CLMF("GetInt", 0, "Media Library Coordinates", "Movies_Entry_Line_H")
Global ML_Coordinate_Movies_Entry_LineDetails_X.i = CLMF("GetInt", 0, "Media Library Coordinates", "Movies_Entry_LineDetails_X")
Global ML_Coordinate_Movies_Entry_LineDetails_Y.i = CLMF("GetInt", 0, "Media Library Coordinates", "Movies_Entry_LineDetails_Y")
Global ML_Coordinate_Movies_Entry_LineDetails_W.i = CLMF("GetInt", 0, "Media Library Coordinates", "Movies_Entry_LineDetails_W")
Global ML_Coordinate_Movies_Entry_LineDetails_H.i = CLMF("GetInt", 0, "Media Library Coordinates", "Movies_Entry_LineDetails_H")

Global ML_NaviButtonOne.s = ML_Info_Name.s
Global ML_NaviButtonTwo.s = "Filme"
Global ML_NaviButtonThree.s = "Serien"
Global ML_NaviButtonFour.s = "Spiele"
Global ML_NaviButtonFive.s = "Einstellungen"
Global ML_NaviButtonSix.s = "Informationen"

Global ML_Movies_Count.i = 0

Global ML_Font_Arial8.i = LoadFont(1, "Arial", 8)
Global ML_Font_Arial8Bold.i = LoadFont(2, "Arial", 8, #PB_Font_Bold)
Global ML_Font_Arial9.i = LoadFont(3, "Arial", 9)
Global ML_Font_Arial9Bold.i = LoadFont(4, "Arial", 9, #PB_Font_Bold)
Global ML_Font_Arial10.i = LoadFont(5, "Arial", 10)
Global ML_Font_Arial10Bold.i = LoadFont(6, "Arial", 10, #PB_Font_Bold)
Global ML_Font_Arial11.i = LoadFont(7, "Arial", 11)
Global ML_Font_Arial11Bold.i = LoadFont(8, "Arial", 11, #PB_Font_Bold)
Global ML_Font_Arial12.i = LoadFont(9, "Arial", 12)
Global ML_Font_Arial12Bold.i = LoadFont(10, "Arial", 12, #PB_Font_Bold)

Global ML_Error_InitWindow.s = "Can't initialize window"
Global ML_Error_InitPNGDecoder.s = "Can't initialize PNG Decoder"
Global ML_Error_InitPNGEncoder.s = "Can't initialize PNG Encoder"
Global ML_Error_InitSQLDatabase.s = "Can't initialize SQLite Database Environment"
Global ML_Error_CreateImage.s = "Can't create Image "
Global ML_Error_Prefs_Movies.s = "Can't open Data\Movies.ini"

;}

;{ -----[Constants]-----

Enumeration
  
  #ML_Menu_Start = 0
  #ML_Menu_Movies = 1
  #ML_Menu_Series = 2
  #ML_Menu_Games = 3
  #ML_Menu_Settings = 4
  #ML_Menu_Informations = 5
  
EndEnumeration

;}

;{ -----[Declare]-----

Declare.i ML_Func_Movies(Func.s = "", ID.i = 0, Title.s = "", Release.i = 0, Length.i = 0, AgeRating.i = 0, Genre.s = "", Studio.s = "", Regie.s = "", Actor.s = "", Role.s = "", Plot.s = "", Language.s = "", Resolution.s = "", AspectRatio.s = "", FileSize.s = "", FilePath.s = "", FileFormat.s = "", PicturePath.s = "", PictureID.i = 0, ImageID.i = 0, ImageOverID.i = 0)

;}

;{ -----[Structure and List]-----

Procedure ML_List_Movies_Init()
  
  Structure ML_Struc_Movies
		ML_ID.i
		ML_Date.s
		ML_Time.s
		ML_Date_Modified.s
		ML_Time_Modified.s
		ML_Title.s
		ML_Release.i
		ML_Length.i
		ML_AgeRating.i
		ML_Genre.s
		ML_Studio.s
		ML_Regie.s
		ML_Actor.s
		ML_Role.s
		ML_Plot.s
		ML_Language.s
		ML_Resolution.s
		ML_AspectRatio.s
		ML_FileSize.s
		ML_FilePath.s
		ML_FileFormat.s
		ML_PicturePath.s
		ML_PictureID.i
		ML_ImageID.i
		ML_ImageOverID.i
	EndStructure
	
	Global NewList ML_List_Movies.ML_Struc_Movies()
	
	Structure ML_Struc_Movies_Old
		ML_ID.i
		ML_Date.s
		ML_Time.s
		ML_Date_Modified.s
		ML_Time_Modified.s
		ML_Title.s
		ML_Release.i
		ML_Length.i
		ML_AgeRating.i
		ML_Genre.s
		ML_Studio.s
		ML_Regie.s
		ML_Actor.s
		ML_Role.s
		ML_Plot.s
		ML_Language.s
		ML_Resolution.s
		ML_AspectRatio.s
		ML_FileSize.s
		ML_FilePath.s
		ML_FileFormat.s
		ML_PicturePath.s
		ML_PictureID.i
		ML_ImageID.i
		ML_ImageOverID.i
	EndStructure
	
	Global NewList ML_List_Movies_Old.ML_Struc_Movies_Old()
	
EndProcedure

;}

;{ -----[Macros]-----

Macro ML_DrawImage_Navi_Design()
  
  Select ML_Settings_Navi_Design.i
    
    Case 0
      
      If WindowMouseX(1) > 10 And WindowMouseX(1) < 150 And WindowMouseY(1) > 10 And WindowMouseY(1) < 35 : DrawImage(ImageID(7), 10, 10) : Else : DrawImage(ImageID(1), 10, 10) : EndIf
      If WindowMouseX(1) > 160 And WindowMouseX(1) < 300 And WindowMouseY(1) > 10 And WindowMouseY(1) < 35 : DrawImage(ImageID(8), 160, 10) : Else : DrawImage(ImageID(2), 160, 10) : EndIf
      If WindowMouseX(1) > 310 And WindowMouseX(1) < 450 And WindowMouseY(1) > 10 And WindowMouseY(1) < 35 : DrawImage(ImageID(9), 310, 10) : Else : DrawImage(ImageID(3), 310, 10) : EndIf
      If WindowMouseX(1) > 460 And WindowMouseX(1) < 600 And WindowMouseY(1) > 10 And WindowMouseY(1) < 35 : DrawImage(ImageID(10), 460, 10) : Else : DrawImage(ImageID(4), 460, 10) : EndIf
      If WindowMouseX(1) > 610 And WindowMouseX(1) < 750 And WindowMouseY(1) > 10 And WindowMouseY(1) < 35 : DrawImage(ImageID(11), 610, 10) : Else : DrawImage(ImageID(5), 610, 10) : EndIf
      If WindowMouseX(1) > 760 And WindowMouseX(1) < 900 And WindowMouseY(1) > 10 And WindowMouseY(1) < 35 : DrawImage(ImageID(12), 760, 10) : Else : DrawImage(ImageID(6), 760, 10) : EndIf
      
    Case 1
      
      If WindowMouseX(1) > 10 And WindowMouseX(1) < 150 And WindowMouseY(1) > 10 And WindowMouseY(1) < 35 : DrawImage(ImageID(27), 10, 10) : Else : DrawImage(ImageID(21), 10, 10) : EndIf
      If WindowMouseX(1) > 160 And WindowMouseX(1) < 300 And WindowMouseY(1) > 10 And WindowMouseY(1) < 35 : DrawImage(ImageID(28), 160, 10) : Else : DrawImage(ImageID(22), 160, 10) : EndIf
      If WindowMouseX(1) > 310 And WindowMouseX(1) < 450 And WindowMouseY(1) > 10 And WindowMouseY(1) < 35 : DrawImage(ImageID(29), 310, 10) : Else : DrawImage(ImageID(23), 310, 10) : EndIf
      If WindowMouseX(1) > 460 And WindowMouseX(1) < 600 And WindowMouseY(1) > 10 And WindowMouseY(1) < 35 : DrawImage(ImageID(30), 460, 10) : Else : DrawImage(ImageID(24), 460, 10) : EndIf
      If WindowMouseX(1) > 610 And WindowMouseX(1) < 750 And WindowMouseY(1) > 10 And WindowMouseY(1) < 35 : DrawImage(ImageID(31), 610, 10) : Else : DrawImage(ImageID(25), 610, 10) : EndIf
      If WindowMouseX(1) > 760 And WindowMouseX(1) < 900 And WindowMouseY(1) > 10 And WindowMouseY(1) < 35 : DrawImage(ImageID(32), 760, 10) : Else : DrawImage(ImageID(26), 760, 10) : EndIf
      
    Case 2
      
      If WindowMouseX(1) > 10 And WindowMouseX(1) < 150 And WindowMouseY(1) > 10 And WindowMouseY(1) < 35 : DrawImage(ImageID(47), 10, 10) : Else : DrawImage(ImageID(41), 10, 10) : EndIf
      If WindowMouseX(1) > 160 And WindowMouseX(1) < 300 And WindowMouseY(1) > 10 And WindowMouseY(1) < 35 : DrawImage(ImageID(48), 160, 10) : Else : DrawImage(ImageID(42), 160, 10) : EndIf
      If WindowMouseX(1) > 310 And WindowMouseX(1) < 450 And WindowMouseY(1) > 10 And WindowMouseY(1) < 35 : DrawImage(ImageID(49), 310, 10) : Else : DrawImage(ImageID(43), 310, 10) : EndIf
      If WindowMouseX(1) > 460 And WindowMouseX(1) < 600 And WindowMouseY(1) > 10 And WindowMouseY(1) < 35 : DrawImage(ImageID(50), 460, 10) : Else : DrawImage(ImageID(44), 460, 10) : EndIf
      If WindowMouseX(1) > 610 And WindowMouseX(1) < 750 And WindowMouseY(1) > 10 And WindowMouseY(1) < 35 : DrawImage(ImageID(51), 610, 10) : Else : DrawImage(ImageID(45), 610, 10) : EndIf
      If WindowMouseX(1) > 760 And WindowMouseX(1) < 900 And WindowMouseY(1) > 10 And WindowMouseY(1) < 35 : DrawImage(ImageID(52), 760, 10) : Else : DrawImage(ImageID(46), 760, 10) : EndIf
      
  EndSelect
  
EndMacro

Macro ML_Movies_Entry_MouseOver()
  
  Select ML_Settings_Movies_Entry_View.i
    
    Case 0
      
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(101)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + GadgetHeight(101)) : SetGadgetState(101, ImageID(1002)) : Else : SetGadgetState(101, ImageID(1001)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(102)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 30) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 30 + GadgetHeight(102)) : SetGadgetState(102, ImageID(1004)) : Else : SetGadgetState(102, ImageID(1003)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(103)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 60) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 60 + GadgetHeight(103)) : SetGadgetState(103, ImageID(1006)) : Else : SetGadgetState(103, ImageID(1005)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(104)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 90) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 90 + GadgetHeight(104)) : SetGadgetState(104, ImageID(1008)) : Else : SetGadgetState(104, ImageID(1007)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(105)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 120) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 120 + GadgetHeight(105)) : SetGadgetState(105, ImageID(1010)) : Else : SetGadgetState(105, ImageID(1009)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(106)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 150) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 150 + GadgetHeight(106)) : SetGadgetState(106, ImageID(1012)) : Else : SetGadgetState(106, ImageID(1011)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(107)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 180) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 180 + GadgetHeight(107)) : SetGadgetState(107, ImageID(1014)) : Else : SetGadgetState(107, ImageID(1013)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(108)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 210) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 210 + GadgetHeight(108)) : SetGadgetState(108, ImageID(1016)) : Else : SetGadgetState(108, ImageID(1015)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(109)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 240) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 240 + GadgetHeight(109)) : SetGadgetState(109, ImageID(1018)) : Else : SetGadgetState(109, ImageID(1017)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(110)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 270) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 270 + GadgetHeight(110)) : SetGadgetState(110, ImageID(1020)) : Else : SetGadgetState(110, ImageID(1019)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(111)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 300) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 300 + GadgetHeight(111)) : SetGadgetState(111, ImageID(1022)) : Else : SetGadgetState(111, ImageID(1021)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(112)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 330) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 330 + GadgetHeight(112)) : SetGadgetState(112, ImageID(1024)) : Else : SetGadgetState(112, ImageID(1023)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(113)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 360) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 360 + GadgetHeight(113)) : SetGadgetState(113, ImageID(1026)) : Else : SetGadgetState(113, ImageID(1025)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(114)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 390) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 390 + GadgetHeight(114)) : SetGadgetState(114, ImageID(1028)) : Else : SetGadgetState(114, ImageID(1027)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(115)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 420) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 420 + GadgetHeight(115)) : SetGadgetState(115, ImageID(1030)) : Else : SetGadgetState(115, ImageID(1029)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(116)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 450) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 450 + GadgetHeight(116)) : SetGadgetState(116, ImageID(1032)) : Else : SetGadgetState(116, ImageID(1031)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(117)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 480) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 480 + GadgetHeight(117)) : SetGadgetState(117, ImageID(1034)) : Else : SetGadgetState(117, ImageID(1033)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(118)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 510) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 510 + GadgetHeight(118)) : SetGadgetState(118, ImageID(1036)) : Else : SetGadgetState(118, ImageID(1035)) : EndIf
      
    Case 1
      
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(201)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + GadgetHeight(201)) : SetGadgetState(201, ImageID(10002)) : Else : SetGadgetState(201, ImageID(10001)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(202)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 45) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 45 + GadgetHeight(202)) : SetGadgetState(202, ImageID(10004)) : Else : SetGadgetState(202, ImageID(10003)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(203)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 90) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 90 + GadgetHeight(203)) : SetGadgetState(203, ImageID(10006)) : Else : SetGadgetState(203, ImageID(10005)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(204)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 135) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 135 + GadgetHeight(204)) : SetGadgetState(204, ImageID(10008)) : Else : SetGadgetState(204, ImageID(10007)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(205)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 180) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 180 + GadgetHeight(205)) : SetGadgetState(205, ImageID(10010)) : Else : SetGadgetState(205, ImageID(10009)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(206)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 225) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 225 + GadgetHeight(206)) : SetGadgetState(206, ImageID(10012)) : Else : SetGadgetState(206, ImageID(10011)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(207)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 270) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 270 + GadgetHeight(207)) : SetGadgetState(207, ImageID(10014)) : Else : SetGadgetState(207, ImageID(10013)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(208)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 315) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 315 + GadgetHeight(208)) : SetGadgetState(208, ImageID(10016)) : Else : SetGadgetState(208, ImageID(10015)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(209)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 360) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 360 + GadgetHeight(209)) : SetGadgetState(209, ImageID(10018)) : Else : SetGadgetState(209, ImageID(10017)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(210)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 405) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 405 + GadgetHeight(210)) : SetGadgetState(210, ImageID(10020)) : Else : SetGadgetState(210, ImageID(10019)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(211)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 450) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 450 + GadgetHeight(211)) : SetGadgetState(211, ImageID(10022)) : Else : SetGadgetState(211, ImageID(10021)) : EndIf
      If WindowMouseX(1) > (ML_Coordinate_Movies_Entry_Line_X.i) And WindowMouseX(1) < (ML_Coordinate_Movies_Entry_Line_X.i + GadgetWidth(212)) And WindowMouseY(1) > (ML_Coordinate_Movies_Entry_Line_Y.i + 495) And WindowMouseY(1) < (ML_Coordinate_Movies_Entry_Line_Y.i + 495 + GadgetHeight(212)) : SetGadgetState(212, ImageID(10024)) : Else : SetGadgetState(212, ImageID(10023)) : EndIf
      
  EndSelect
  
EndMacro

;}

;{ Mouse (Window)

Procedure ML_MouseOver(Win.i, X.i, Y.i, W.i, H.i)
  
  MX.i = WindowMouseX(Win.i)
  MY.i = WindowMouseY(Win.i)
  
  If MX.i > X.i And MX.i < (X.i + W.i) And MY.i > Y.i And MY.i < (Y.i + H.i)
    
    ProcedureReturn #True
    
  EndIf
  
EndProcedure

Procedure ML_Mouse_LeftClick()
  
  If EventType() = #PB_EventType_LeftClick
    
    ProcedureReturn #True
    
  EndIf
  
EndProcedure

Procedure ML_Mouse_LeftDoubleClick()
  
  If EventType() = #PB_EventType_LeftDoubleClick
    
    ProcedureReturn #True
    
  EndIf
  
EndProcedure

Procedure ML_Mouse_RightClick()
  
  If EventType() = #PB_EventType_RightClick
    
    ProcedureReturn #True
    
  EndIf
  
EndProcedure

Procedure ML_Mouse_RightDoubleClick()
  
  If EventType() = #PB_EventType_RightDoubleClick
    
    ProcedureReturn #True
    
  EndIf
  
EndProcedure

;}



Procedure ML_Func_SQL(Func.s = "", File.i = 0, Filename.s = "", Database.i = 0, Username.s = "", Password.s = "", Query.s = "")
  
  If Func.s = "CreateDatabase" Or Func.s = "createdatabase"
    
    ;{ CreateDatabase
    
    If CreateFile(File.i, Filename.s)
      
      CloseFile(File.i)
      
      If OpenDatabase(Database.i, Filename.s, Username.s, Password.s, #PB_Database_SQLite)
        
        CloseDatabase(Database.i)
        
      EndIf
      
    EndIf
    
    ;}
    
  ElseIf Func.s = "CreateTables" Or Func.s = "createtables"
    
    ;{ CreateTables
    
    If OpenDatabase(Database.i, Filename.s, Username.s, Password.s, #PB_Database_SQLite)
      
      Result.i = DatabaseUpdate(Database.i, "CREATE TABLE ml_settings (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, time TEXT, date_modified TEXT, time_modified TEXT, category TEXT, entry TEXT, int INTEGER, string TEXT)")
      
      If Result.i = 0
        
        Debug DatabaseError()
        
      EndIf
      
      Result.i = DatabaseUpdate(Database.i, "CREATE TABLE ml_movies (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, time TEXT, date_modified TEXT, time_modified TEXT, title TEXT, release INTEGER, length INTEGER, agerating INTEGER, genre TEXT, studio TEXT, regie TEXT, actor TEXT, role TEXT, plot TEXT, language TEXT)")
      
      If Result.i = 0
        
        Debug DatabaseError()
        
      EndIf
      
      Result.i = DatabaseUpdate(Database.i, "CREATE TABLE ml_series (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, time TEXT, date_modified TEXT, time_modified TEXT, title TEXT, release INTEGER, length INTEGER, agerating INTEGER, genre TEXT, season INTEGER, episode INTEGER, studio TEXT, regie TEXT, actor TEXT, role TEXT, plot TEXT, language TEXT)")
      
      If Result.i = 0
        
        Debug DatabaseError()
        
      EndIf
      
      Result.i = DatabaseUpdate(Database.i, "CREATE TABLE ml_games (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, time TEXT, date_modified TEXT, time_modified TEXT, title TEXT, release INTEGER, agerating INTEGER, genre TEXT, size TEXT, studio TEXT, plot TEXT, language TEXT)")
      
      If Result.i = 0
        
        Debug DatabaseError()
        
      EndIf
      
      CloseDatabase(Database.i)
      
    EndIf
    
    ;}
    
  ElseIf Func.s = "AddEntry" Or Func.s = "addentry"
    
    ;{ AddEntry
    
    If OpenDatabase(Database.i, Filename.s, Username.s, Password.s, #PB_Database_SQLite)
      
      Result.i = DatabaseUpdate(Database.i, Query.s)
      
      If Result.i = 0
        
        Debug DatabaseError()
        
      EndIf
      
      CloseDatabase(Database.i)
      
    EndIf
    
    ;}
    
  ElseIf Func.s = "LoadMovies" Or Func.s = "loadmovies"
    
    ;{ LoadMovies
    
    If OpenDatabase(Database.i, Filename.s, Username.s, Password.s, #PB_Database_SQLite)
      
      Result.i = DatabaseQuery(Database.i, "SELECT * FROM ml_movies")
      
      If Result.i = 0
        
        Debug DatabaseError()
        
      Else
        
        While NextDatabaseRow(Database.i)
          
          Entries.i + 1
          
          ML_Func_Movies("AddMovie", 0, GetDatabaseString(Database.i, 5), Val(GetDatabaseString(Database.i, 6)), Val(GetDatabaseString(Database.i, 7)), Val(GetDatabaseString(Database.i, 8)), GetDatabaseString(Database.i, 9), GetDatabaseString(Database.i, 10), GetDatabaseString(Database.i, 11), GetDatabaseString(Database.i, 12), GetDatabaseString(Database.i, 13), GetDatabaseString(Database.i, 14), GetDatabaseString(Database.i, 15))
          
          ;{ Debug
          
          ;Debug DatabaseColumnName(Database.i, 0) + " [" + GetDatabaseString(Database.i, 0) + "]"   ; id
          ;Debug DatabaseColumnName(Database.i, 1) + " [" + GetDatabaseString(Database.i, 1) + "]"   ; date
          ;Debug DatabaseColumnName(Database.i, 2) + " [" + GetDatabaseString(Database.i, 2) + "]"   ; time
          ;Debug DatabaseColumnName(Database.i, 3) + " [" + GetDatabaseString(Database.i, 3) + "]"   ; date_modified
          ;Debug DatabaseColumnName(Database.i, 4) + " [" + GetDatabaseString(Database.i, 4) + "]"   ; time_modified
          Debug DatabaseColumnName(Database.i, 5) + " [" + GetDatabaseString(Database.i, 5) + "]"   ; title
          ;Debug DatabaseColumnName(Database.i, 6) + " [" + GetDatabaseString(Database.i, 6) + "]"   ; release
          ;Debug DatabaseColumnName(Database.i, 7) + " [" + GetDatabaseString(Database.i, 7) + "]"   ; length
          ;Debug DatabaseColumnName(Database.i, 8) + " [" + GetDatabaseString(Database.i, 8) + "]"   ; agerating
          ;Debug DatabaseColumnName(Database.i, 9) + " [" + GetDatabaseString(Database.i, 9) + "]"   ; genre
          ;Debug DatabaseColumnName(Database.i, 10) + " [" + GetDatabaseString(Database.i, 10) + "]" ; studio
          ;Debug DatabaseColumnName(Database.i, 11) + " [" + GetDatabaseString(Database.i, 11) + "]" ; regie
          ;Debug DatabaseColumnName(Database.i, 12) + " [" + GetDatabaseString(Database.i, 12) + "]" ; actor
          ;Debug DatabaseColumnName(Database.i, 13) + " [" + GetDatabaseString(Database.i, 13) + "]" ; role
          ;Debug DatabaseColumnName(Database.i, 14) + " [" + GetDatabaseString(Database.i, 14) + "]" ; plot
          ;Debug DatabaseColumnName(Database.i, 15) + " [" + GetDatabaseString(Database.i, 15) + "]" ; language
          
          ;}
          
        Wend
        
        Debug "Movies in Database: " + Str(Entries.i)
        
      EndIf
      
      CloseDatabase(Database.i)
      
    EndIf
    
    ;}
    
  EndIf
  
EndProcedure

Procedure ML_Func_Movies(Func.s = "", ID.i = 0, Title.s = "", Release.i = 0, Length.i = 0, AgeRating.i = 0, Genre.s = "", Studio.s = "", Regie.s = "", Actor.s = "", Role.s = "", Plot.s = "", Language.s = "", Resolution.s = "", AspectRatio.s = "", FileSize.s = "", FilePath.s = "", FileFormat.s = "", PicturePath.s = "", PictureID.i = 0, ImageID.i = 0, ImageOverID.i = 0)
  
  If Func.s = "AddMovie" Or Func.s = "addmovie"
		
		;{ AddMovie
		
		With ML_List_Movies()
			
			AddElement(ML_List_Movies())
			\ML_ID.i = ListSize(ML_List_Movies())
			\ML_Date.s = FormatDate("%dd.%mm.%yyyy", Date())
			\ML_Time.s = FormatDate("%hh:%ii:%ss", Date())
			\ML_Title.s = Title.s
			\ML_Release.i = Release.i
			\ML_Length.i = Length.i
			\ML_AgeRating.i = AgeRating.i
			\ML_Genre.s = Genre.s
			\ML_Studio.s = Studio.s
			\ML_Regie.s = Regie.s
			\ML_Actor.s = Actor.s
			\ML_Role.s = Role.s
			\ML_Plot.s = Plot.s
			\ML_Language.s = Language.s
			\ML_Resolution.s = Resolution.s
			\ML_AspectRatio.s = AspectRatio.s
			\ML_FileSize.s = FileSize.s
			\ML_FilePath.s = FilePath.s
			\ML_FileFormat.s = FileFormat.s
			\ML_PicturePath.s = PicturePath.s
			\ML_PictureID.i = PictureID.i
			\ML_ImageID.i = ImageID.i
			\ML_ImageOverID.i = ImageOverID.i
		EndWith
		
		;}
		
	ElseIf Func.s = "LoadMovies" Or Func.s = "loadmovies"
	  
	  ;{ LoadMovies
	  
	  If OpenPreferences(ML_Settings_File_Movies.s)
	    
	    ExaminePreferenceGroups()
	    While NextPreferenceGroup()
	      
	      ML_Movies_Count.i + 1
	      ML_AddToList_Title.s = PreferenceGroupName()
	      
	      ;{ Preferences
	      
	      ExaminePreferenceKeys()
	      While NextPreferenceKey()
	        
	        If PreferenceKeyName() = "Release"
	          
	          ML_AddToList_Release.i = Val(PreferenceKeyValue())
	          
	        ElseIf PreferenceKeyName() = "Length"
	          
	          ML_AddToList_Length.i = Val(PreferenceKeyValue())
	          
	        ElseIf PreferenceKeyName() = "AgeRating"
	          
	          ML_AddToList_AgeRating.i = Val(PreferenceKeyValue())
	          
	        ElseIf PreferenceKeyName() = "Genre"
	          
	          ML_AddToList_Genre.s = PreferenceKeyValue()
	          
	        ElseIf PreferenceKeyName() = "Studio"
	          
	          ML_AddToList_Studio.s = PreferenceKeyValue()
	          
	        ElseIf PreferenceKeyName() = "Regie"
	          
	          ML_AddToList_Regie.s = PreferenceKeyValue()
	          
	        ElseIf PreferenceKeyName() = "Actor"
	          
	          ML_AddToList_Actor.s = PreferenceKeyValue()
	          
	        ElseIf PreferenceKeyName() = "Role"
	          
	          ML_AddToList_Role.s = PreferenceKeyValue()
	          
	        ElseIf PreferenceKeyName() = "Plot"
	          
	          ML_AddToList_Plot.s = PreferenceKeyValue()
	          
	        ElseIf PreferenceKeyName() = "Language"
	          
	          ML_AddToList_Language.s = PreferenceKeyValue()
	          
	        EndIf
	        
	      Wend
	      
	      ;}
	      
	      ;{ Debug
	      
	      ;Debug "Movie: " + ML_AddToList_Title.s
        ;Debug "» Release: " + Str(ML_AddToList_Release.i)
        ;Debug "» Length: " + Str(ML_AddToList_Length.i)
	      ;Debug "» AgeRating: " + Str(ML_AddToList_AgeRating.i)
        ;Debug "» Genre: " + ML_AddToList_Genre.s
        ;Debug "» Studio: " + ML_AddToList_Studio.s
        ;Debug "» Regie: " + ML_AddToList_Regie.s
        ;Debug "» Actor: " + ML_AddToList_Actor.s
	      ;Debug "» Role: " + ML_AddToList_Role.s
        ;Debug "» Plot: " + ML_AddToList_Plot.s
        ;Debug "» Language: " + ML_AddToList_Language.s
        
        ;}
        
	      ;{ Add to list
        
        CLMF("Add", 0, "Media Library Movies", "Movies Count", 0, ML_Movies_Count.i, 0, 0, 0, "")
        ML_Func_Movies("AddMovie", ListSize(ML_List_Movies()) + 1, ML_AddToList_Title.s, ML_AddToList_Release.i, ML_AddToList_Length.i, ML_AddToList_AgeRating.i, ML_AddToList_Genre.s, ML_AddToList_Studio.s, ML_AddToList_Regie.s, ML_AddToList_Actor.s, ML_AddToList_Role.s, ML_AddToList_Plot.s, ML_AddToList_Language.s, ML_AddToList_Resolution.s, ML_AddToList_AspectRatio.s, ML_AddToList_FileSize.s, ML_AddToList_FilePath.s, ML_AddToList_FileFormat.s, ML_AddToList_PicturePath.s, PictureID.i, ImageID.i, ImageOverID.i)
        
        ;}
	      
	    Wend
	    
	    ;{ Debug
	    
	    ;Debug "Movies Total: " + Str(ML_Movies_Count.i)
	    
	    ;}
	    
	  Else
	    
	    ML_Msg_Error(ML_Error_Prefs_Movies.s)
	    
	  EndIf
	  
	  ;}
	  
	ElseIf Func.s = "LoadMoviesCreateImage" Or Func.s = "loadmoviescreateimage"
	  
	  ;{ LoadMoviesCreateImage
	  
	  If OpenPreferences(ML_Settings_File_Movies.s)
	    
	    ExaminePreferenceGroups()
	    While NextPreferenceGroup()
	      
	      ML_Movies_Count.i + 1
	      ML_AddToList_Title.s = PreferenceGroupName()
	      
	      ;{ Preferences
	      
	      ExaminePreferenceKeys()
	      While NextPreferenceKey()
	        
	        If PreferenceKeyName() = "Release"
	          
	          ML_AddToList_Release.i = Val(PreferenceKeyValue())
	          
	        ElseIf PreferenceKeyName() = "Length"
	          
	          ML_AddToList_Length.i = Val(PreferenceKeyValue())
	          
	        ElseIf PreferenceKeyName() = "AgeRating"
	          
	          ML_AddToList_AgeRating.i = Val(PreferenceKeyValue())
	          
	        ElseIf PreferenceKeyName() = "Genre"
	          
	          ML_AddToList_Genre.s = PreferenceKeyValue()
	          
	        ElseIf PreferenceKeyName() = "Studio"
	          
	          ML_AddToList_Studio.s = PreferenceKeyValue()
	          
	        ElseIf PreferenceKeyName() = "Regie"
	          
	          ML_AddToList_Regie.s = PreferenceKeyValue()
	          
	        ElseIf PreferenceKeyName() = "Actor"
	          
	          ML_AddToList_Actor.s = PreferenceKeyValue()
	          
	        ElseIf PreferenceKeyName() = "Role"
	          
	          ML_AddToList_Role.s = PreferenceKeyValue()
	          
	        ElseIf PreferenceKeyName() = "Plot"
	          
	          ML_AddToList_Plot.s = PreferenceKeyValue()
	          
	        ElseIf PreferenceKeyName() = "Language"
	          
	          ML_AddToList_Language.s = PreferenceKeyValue()
	          
	        EndIf
	        
	      Wend
	      
	      ;}
	      
	      ;{ CreateImage
	      
  	    Rnd.i = 2
        Edge.i = ML_Settings_Movies_Entry_Edge.i
        
        ML_AddToList_ImageID.i = CreateImage(#PB_Any, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, 32)
        If ML_AddToList_ImageID.i
          
          StartDrawing(ImageOutput(ML_AddToList_ImageID.i))
            
            BackColor(ML_Settings_Window_BGColor.i)
            FrontColor(RGB(255, 255, 255))
            DrawingMode(#PB_2DDrawing_Transparent)
            RoundBox(0, 0, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, Rnd.i, Rnd.i)
            FrontColor(RGB(200, 200, 200))
            RoundBox(Edge.i - 1, Edge.i - 1, ML_Coordinate_Movies_Entry_Line_W.i - (Edge.i * 2) + 2, ML_Coordinate_Movies_Entry_Line_H.i - (Edge.i * 2) + 2, Rnd.i, Rnd.i)
            FrontColor(ML_Settings_Movies_Entry_BGColor.i)
            RoundBox(Edge.i, Edge.i, ML_Coordinate_Movies_Entry_Line_W.i - (Edge.i * 2), ML_Coordinate_Movies_Entry_Line_H.i - (Edge.i * 2), Rnd.i, Rnd.i)
            
            FrontColor(ML_Settings_Movies_Entry_Title_Color.i)
            DrawingFont(FontID(5))
            DrawText(8, 4, PreferenceGroupName())
            
          StopDrawing()
          
        Else
          
          ML_Msg_Error(ML_Error_CreateImage.s + Str(ML_AddToList_ImageID.i))
          
        EndIf
        
        ML_AddToList_ImageOverID.i = CreateImage(#PB_Any, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, 32)
        If ML_AddToList_ImageOverID.i
          
          StartDrawing(ImageOutput(ML_AddToList_ImageOverID.i))
            
            BackColor(ML_Settings_Window_BGColor.i)
            FrontColor(RGB(255, 255, 255))
            DrawingMode(#PB_2DDrawing_Transparent)
            RoundBox(0, 0, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, Rnd.i, Rnd.i)
            FrontColor(RGB(200, 200, 200))
            RoundBox(Edge.i - 1, Edge.i - 1, ML_Coordinate_Movies_Entry_Line_W.i - (Edge.i * 2) + 2, ML_Coordinate_Movies_Entry_Line_H.i - (Edge.i * 2) + 2, Rnd.i, Rnd.i)
            FrontColor(ML_Settings_Movies_Entry_Over_BGColor.i)
            RoundBox(Edge.i, Edge.i, ML_Coordinate_Movies_Entry_Line_W.i - (Edge.i * 2), ML_Coordinate_Movies_Entry_Line_H.i - (Edge.i * 2), Rnd.i, Rnd.i)
            
            FrontColor(ML_Settings_Movies_Entry_Title_Color.i)
            DrawingFont(FontID(5))
            DrawText(8, 4, PreferenceGroupName())
            
          StopDrawing()
          
        Else
          
          ML_Msg_Error(ML_Error_CreateImage.s + Str(ML_AddToList_ImageOverID.i))
          
        EndIf
        
  	    ;}
        
        ;{ Debug
        
        Debug "Movie: " + ML_AddToList_Title.s
        Debug "» Release: " + Str(ML_AddToList_Release.i)
        Debug "» Length: " + Str(ML_AddToList_Length.i)
        Debug "» AgeRating: " + Str(ML_AddToList_AgeRating.i)
        Debug "» Genre: " + ML_AddToList_Genre.s
        Debug "» Studio: " + ML_AddToList_Studio.s
        Debug "» Regie: " + ML_AddToList_Regie.s
        Debug "» Actor: " + ML_AddToList_Actor.s
        Debug "» Role: " + ML_AddToList_Role.s
        Debug "» Plot: " + ML_AddToList_Plot.s
        Debug "» Language: " + ML_AddToList_Language.s
        Debug "» ImageID: " + ML_AddToList_ImageID.i
        Debug "» ImageOverID: " + ML_AddToList_ImageOverID.i
        
        ;}
        
	      ;{ Add to list
        
        CLMF("Add", 0, "Media Library Movies", "Movies Count", 0, ML_Movies_Count.i, 0, 0, 0, "")
        ML_Func_Movies("AddMovie", ListSize(ML_List_Movies()) + 1, ML_AddToList_Title.s, ML_AddToList_Release.i, ML_AddToList_Length.i, ML_AddToList_AgeRating.i, ML_AddToList_Genre.s, ML_AddToList_Studio.s, ML_AddToList_Regie.s, ML_AddToList_Actor.s, ML_AddToList_Role.s, ML_AddToList_Plot.s, ML_AddToList_Language.s, ML_AddToList_Resolution.s, ML_AddToList_AspectRatio.s, ML_AddToList_FileSize.s, ML_AddToList_FilePath.s, ML_AddToList_FileFormat.s, ML_AddToList_PicturePath.s, PictureID.i, ImageID.i, ImageOverID.i)
        
        ;}
	      
	    Wend
	    
	  Else
	    
	    ML_Msg_Error(ML_Error_Prefs_Movies.s)
	    
	  EndIf
	  
	  ;}
	  
	ElseIf Func.s = "LoadMoviesByTitle" Or Func.s = "loadmoviesbytitle"
	  
	  ;{ LoadMoviesByTitle
	  
	  If OpenPreferences(ML_Settings_File_Movies.s)
	    
	    ExaminePreferenceGroups()
	    While NextPreferenceGroup()
	      
	      ML_AddToList_Title.s = PreferenceGroupName()
	      
	      ;{ Preferences
	      
	      ExaminePreferenceKeys()
	      While NextPreferenceKey()
	        
	        If PreferenceKeyName() = "Title"
	          
	          If FindString(PreferenceKeyValue(), Title.s, 1, #PB_String_NoCase)
	            
	            Count.i + 1
	            
	            If Movies.s = ""
	              
	              Movies.s = PreferenceGroupName()
	              
	            Else
	              
	              MoviesLen.i = Len(Movies.s) + 1
	              Movies.s = InsertString(Movies.s, ", " + PreferenceGroupName(), MoviesLen.i)
	              
	            EndIf
	            
	          EndIf
	          
	        EndIf
	        
	      Wend
	      
	      ;}
	      
	      ;{ Add to list
        
        ;CLMF("Add", 0, "Media Library Movies", "Movies Count", 0, ML_Movies_Count.i, 0, 0, 0, "")
        ;ML_Func_Movies("AddMovie", ListSize(ML_List_Movies()) + 1, ML_AddToList_Title.s, ML_AddToList_Release.i, ML_AddToList_Length.i, ML_AddToList_AgeRating.i, ML_AddToList_Genre.s, ML_AddToList_Studio.s, ML_AddToList_Regie.s, ML_AddToList_Actor.s, ML_AddToList_Role.s, ML_AddToList_Plot.s, ML_AddToList_Language.s, ML_AddToList_Resolution.s, ML_AddToList_AspectRatio.s, ML_AddToList_FileSize.s, ML_AddToList_FilePath.s, ML_AddToList_FileFormat.s, ML_AddToList_PicturePath.s, PictureID.i, ImageID.i, ImageOverID.i)
        
        ;}
	      
	    Wend
	    
	    ;{ Debug
	    
	    Debug Title.s + ": " + Str(Count.i)
	    Debug "» Movies: " + Movies.s
	    
	    ;}
	    
	  Else
	    
	    ML_Msg_Error(ML_Error_Prefs_Movies.s)
	    
	  EndIf
	  
	  ;}
	  
	ElseIf Func.s = "LoadMoviesByRelease" Or Func.s = "loadmoviesbyrelease"
	  
	  ;{ LoadMoviesByRelease
	  
	  If OpenPreferences(ML_Settings_File_Movies.s)
	    
	    ExaminePreferenceGroups()
	    While NextPreferenceGroup()
	      
	      ML_AddToList_Title.s = PreferenceGroupName()
	      
	      ;{ Preferences
	      
	      ExaminePreferenceKeys()
	      While NextPreferenceKey()
	        
	        If PreferenceKeyName() = "Release"
	          
	          If FindString(PreferenceKeyValue(), Str(Release.i), 1, #PB_String_NoCase)
	            
	            Count.i + 1
	            
	            If Movies.s = ""
	              
	              Movies.s = PreferenceGroupName()
	              
	            Else
	              
	              MoviesLen.i = Len(Movies.s) + 1
	              Movies.s = InsertString(Movies.s, ", " + PreferenceGroupName(), MoviesLen.i)
	              
	            EndIf
	            
	          EndIf
	          
	        EndIf
	        
	      Wend
	      
	      ;}
	      
	      ;{ Add to list
        
        ;CLMF("Add", 0, "Media Library Movies", "Movies Count", 0, ML_Movies_Count.i, 0, 0, 0, "")
        ;ML_Func_Movies("AddMovie", ListSize(ML_List_Movies()) + 1, ML_AddToList_Title.s, ML_AddToList_Release.i, ML_AddToList_Length.i, ML_AddToList_AgeRating.i, ML_AddToList_Genre.s, ML_AddToList_Studio.s, ML_AddToList_Regie.s, ML_AddToList_Actor.s, ML_AddToList_Role.s, ML_AddToList_Plot.s, ML_AddToList_Language.s, ML_AddToList_Resolution.s, ML_AddToList_AspectRatio.s, ML_AddToList_FileSize.s, ML_AddToList_FilePath.s, ML_AddToList_FileFormat.s, ML_AddToList_PicturePath.s, PictureID.i, ImageID.i, ImageOverID.i)
        
        ;}
	      
	    Wend
	    
	    ;{ Debug
	    
	    Debug Str(Release.i) + ": " + Str(Count.i)
	    Debug "» Movies: " + Movies.s
	    
	    ;}
	    
	  Else
	    
	    ML_Msg_Error(ML_Error_Prefs_Movies.s)
	    
	  EndIf
	  
	  ;}
	  
	ElseIf Func.s = "LoadMoviesByLength" Or Func.s = "loadmoviesbylength"
	  
	  ;{ LoadMoviesByLength
	  
	  If OpenPreferences(ML_Settings_File_Movies.s)
	    
	    ExaminePreferenceGroups()
	    While NextPreferenceGroup()
	      
	      ML_AddToList_Title.s = PreferenceGroupName()
	      
	      ;{ Preferences
	      
	      ExaminePreferenceKeys()
	      While NextPreferenceKey()
	        
	        If PreferenceKeyName() = "Length"
	          
	          If FindString(PreferenceKeyValue(), Str(Length.i), 1, #PB_String_NoCase)
	            
	            Count.i + 1
	            
	            If Movies.s = ""
	              
	              Movies.s = PreferenceGroupName()
	              
	            Else
	              
	              MoviesLen.i = Len(Movies.s) + 1
	              Movies.s = InsertString(Movies.s, ", " + PreferenceGroupName(), MoviesLen.i)
	              
	            EndIf
	            
	          EndIf
	          
	        EndIf
	        
	      Wend
	      
	      ;}
	      
	      ;{ Add to list
        
        ;CLMF("Add", 0, "Media Library Movies", "Movies Count", 0, ML_Movies_Count.i, 0, 0, 0, "")
        ;ML_Func_Movies("AddMovie", ListSize(ML_List_Movies()) + 1, ML_AddToList_Title.s, ML_AddToList_Release.i, ML_AddToList_Length.i, ML_AddToList_AgeRating.i, ML_AddToList_Genre.s, ML_AddToList_Studio.s, ML_AddToList_Regie.s, ML_AddToList_Actor.s, ML_AddToList_Role.s, ML_AddToList_Plot.s, ML_AddToList_Language.s, ML_AddToList_Resolution.s, ML_AddToList_AspectRatio.s, ML_AddToList_FileSize.s, ML_AddToList_FilePath.s, ML_AddToList_FileFormat.s, ML_AddToList_PicturePath.s, PictureID.i, ImageID.i, ImageOverID.i)
        
        ;}
	      
	    Wend
	    
	    ;{ Debug
	    
	    Debug Str(Length.i) + ": " + Str(Count.i)
	    Debug "» Movies: " + Movies.s
	    
	    ;}
	    
	  Else
	    
	    ML_Msg_Error(ML_Error_Prefs_Movies.s)
	    
	  EndIf
	  
	  ;}
	  
	ElseIf Func.s = "LoadMoviesByAgeRating" Or Func.s = "loadmoviesbyagerating"
	  
	  ;{ LoadMoviesByAgeRating
	  
	  If OpenPreferences(ML_Settings_File_Movies.s)
	    
	    ExaminePreferenceGroups()
	    While NextPreferenceGroup()
	      
	      ML_AddToList_Title.s = PreferenceGroupName()
	      
	      ;{ Preferences
	      
	      ExaminePreferenceKeys()
	      While NextPreferenceKey()
	        
	        If PreferenceKeyName() = "AgeRating"
	          
	          If FindString(PreferenceKeyValue(), Str(AgeRating.i), 1, #PB_String_NoCase)
	            
	            Count.i + 1
	            
	            If Movies.s = ""
	              
	              Movies.s = PreferenceGroupName()
	              
	            Else
	              
	              MoviesLen.i = Len(Movies.s) + 1
	              Movies.s = InsertString(Movies.s, ", " + PreferenceGroupName(), MoviesLen.i)
	              
	            EndIf
	            
	          EndIf
	          
	        EndIf
	        
	      Wend
	      
	      ;}
	      
	      ;{ Add to list
        
        ;CLMF("Add", 0, "Media Library Movies", "Movies Count", 0, ML_Movies_Count.i, 0, 0, 0, "")
        ;ML_Func_Movies("AddMovie", ListSize(ML_List_Movies()) + 1, ML_AddToList_Title.s, ML_AddToList_Release.i, ML_AddToList_Length.i, ML_AddToList_AgeRating.i, ML_AddToList_Genre.s, ML_AddToList_Studio.s, ML_AddToList_Regie.s, ML_AddToList_Actor.s, ML_AddToList_Role.s, ML_AddToList_Plot.s, ML_AddToList_Language.s, ML_AddToList_Resolution.s, ML_AddToList_AspectRatio.s, ML_AddToList_FileSize.s, ML_AddToList_FilePath.s, ML_AddToList_FileFormat.s, ML_AddToList_PicturePath.s, PictureID.i, ImageID.i, ImageOverID.i)
        
        ;}
	      
	    Wend
	    
	    ;{ Debug
	    
	    Debug Str(AgeRating.i) + ": " + Str(Count.i)
	    Debug "» Movies: " + Movies.s
	    
	    ;}
	    
	  Else
	    
	    ML_Msg_Error(ML_Error_Prefs_Movies.s)
	    
	  EndIf
	  
	  ;}
	  
	ElseIf Func.s = "LoadMoviesByGenre" Or Func.s = "loadmoviesbygenre"
	  
	  ;{ LoadMoviesByGenre
	  
	  If OpenPreferences(ML_Settings_File_Movies.s)
	    
	    ExaminePreferenceGroups()
	    While NextPreferenceGroup()
	      
	      ML_AddToList_Title.s = PreferenceGroupName()
	      
	      ;{ Preferences
	      
	      ExaminePreferenceKeys()
	      While NextPreferenceKey()
	        
	        If PreferenceKeyName() = "Genre"
	          
	          If FindString(PreferenceKeyValue(), Genre.s, 1, #PB_String_NoCase)
	            
	            Count.i + 1
	            
	            If Movies.s = ""
	              
	              Movies.s = PreferenceGroupName()
	              
	            Else
	              
	              MoviesLen.i = Len(Movies.s) + 1
	              Movies.s = InsertString(Movies.s, ", " + PreferenceGroupName(), MoviesLen.i)
	              
	            EndIf
	            
	          EndIf
	          
	        EndIf
	        
	      Wend
	      
	      ;}
	      
	      ;{ Add to list
        
        ;CLMF("Add", 0, "Media Library Movies", "Movies Count", 0, ML_Movies_Count.i, 0, 0, 0, "")
        ;ML_Func_Movies("AddMovie", ListSize(ML_List_Movies()) + 1, ML_AddToList_Title.s, ML_AddToList_Release.i, ML_AddToList_Length.i, ML_AddToList_AgeRating.i, ML_AddToList_Genre.s, ML_AddToList_Studio.s, ML_AddToList_Regie.s, ML_AddToList_Actor.s, ML_AddToList_Role.s, ML_AddToList_Plot.s, ML_AddToList_Language.s, ML_AddToList_Resolution.s, ML_AddToList_AspectRatio.s, ML_AddToList_FileSize.s, ML_AddToList_FilePath.s, ML_AddToList_FileFormat.s, ML_AddToList_PicturePath.s, PictureID.i, ImageID.i, ImageOverID.i)
        
        ;}
	      
	    Wend
	    
	    ;{ Debug
	    
	    Debug Genre.s + ": " + Str(Count.i)
	    Debug "» Movies: " + Movies.s
	    
	    ;}
	    
	  Else
	    
	    ML_Msg_Error(ML_Error_Prefs_Movies.s)
	    
	  EndIf
	  
	  ;}
	  
	ElseIf Func.s = "LoadMoviesByStudio" Or Func.s = "loadmoviesbystudio"
	  
	  ;{ LoadMoviesByStudio
	  
	  If OpenPreferences(ML_Settings_File_Movies.s)
	    
	    ExaminePreferenceGroups()
	    While NextPreferenceGroup()
	      
	      ML_AddToList_Title.s = PreferenceGroupName()
	      
	      ;{ Preferences
	      
	      ExaminePreferenceKeys()
	      While NextPreferenceKey()
	        
	        If PreferenceKeyName() = "Studio"
	          
	          If FindString(PreferenceKeyValue(), Studio.s, 1, #PB_String_NoCase)
	            
	            Count.i + 1
	            
	            If Movies.s = ""
	              
	              Movies.s = PreferenceGroupName()
	              
	            Else
	              
	              MoviesLen.i = Len(Movies.s) + 1
	              Movies.s = InsertString(Movies.s, ", " + PreferenceGroupName(), MoviesLen.i)
	              
	            EndIf
	            
	          EndIf
	          
	        EndIf
	        
	      Wend
	      
	      ;}
	      
	      ;{ Add to list
        
        ;CLMF("Add", 0, "Media Library Movies", "Movies Count", 0, ML_Movies_Count.i, 0, 0, 0, "")
        ;ML_Func_Movies("AddMovie", ListSize(ML_List_Movies()) + 1, ML_AddToList_Title.s, ML_AddToList_Release.i, ML_AddToList_Length.i, ML_AddToList_AgeRating.i, ML_AddToList_Genre.s, ML_AddToList_Studio.s, ML_AddToList_Regie.s, ML_AddToList_Actor.s, ML_AddToList_Role.s, ML_AddToList_Plot.s, ML_AddToList_Language.s, ML_AddToList_Resolution.s, ML_AddToList_AspectRatio.s, ML_AddToList_FileSize.s, ML_AddToList_FilePath.s, ML_AddToList_FileFormat.s, ML_AddToList_PicturePath.s, PictureID.i, ImageID.i, ImageOverID.i)
        
        ;}
	      
	    Wend
	    
	    ;{ Debug
	    
	    Debug Studio.s + ": " + Str(Count.i)
	    Debug "» Movies: " + Movies.s
	    
	    ;}
	    
	  Else
	    
	    ML_Msg_Error(ML_Error_Prefs_Movies.s)
	    
	  EndIf
	  
	  ;}
	  
	ElseIf Func.s = "LoadMoviesByRegie" Or Func.s = "loadmoviesbyregie"
	  
	  ;{ LoadMoviesByRegie
	  
	  If OpenPreferences(ML_Settings_File_Movies.s)
	    
	    ExaminePreferenceGroups()
	    While NextPreferenceGroup()
	      
	      ML_AddToList_Title.s = PreferenceGroupName()
	      
	      ;{ Preferences
	      
	      ExaminePreferenceKeys()
	      While NextPreferenceKey()
	        
	        If PreferenceKeyName() = "Regie"
	          
	          If FindString(PreferenceKeyValue(), Regie.s, 1, #PB_String_NoCase)
	            
	            Count.i + 1
	            
	            If Movies.s = ""
	              
	              Movies.s = PreferenceGroupName()
	              
	            Else
	              
	              MoviesLen.i = Len(Movies.s) + 1
	              Movies.s = InsertString(Movies.s, ", " + PreferenceGroupName(), MoviesLen.i)
	              
	            EndIf
	            
	          EndIf
	          
	        EndIf
	        
	      Wend
	      
	      ;}
	      
	      ;{ Add to list
        
        ;CLMF("Add", 0, "Media Library Movies", "Movies Count", 0, ML_Movies_Count.i, 0, 0, 0, "")
        ;ML_Func_Movies("AddMovie", ListSize(ML_List_Movies()) + 1, ML_AddToList_Title.s, ML_AddToList_Release.i, ML_AddToList_Length.i, ML_AddToList_AgeRating.i, ML_AddToList_Genre.s, ML_AddToList_Studio.s, ML_AddToList_Regie.s, ML_AddToList_Actor.s, ML_AddToList_Role.s, ML_AddToList_Plot.s, ML_AddToList_Language.s, ML_AddToList_Resolution.s, ML_AddToList_AspectRatio.s, ML_AddToList_FileSize.s, ML_AddToList_FilePath.s, ML_AddToList_FileFormat.s, ML_AddToList_PicturePath.s, PictureID.i, ImageID.i, ImageOverID.i)
        
        ;}
	      
	    Wend
	    
	    ;{ Debug
	    
	    Debug Regie.s + ": " + Str(Count.i)
	    Debug "» Movies: " + Movies.s
	    
	    ;}
	    
	  Else
	    
	    ML_Msg_Error(ML_Error_Prefs_Movies.s)
	    
	  EndIf
	  
	  ;}
	  
	ElseIf Func.s = "LoadMoviesByActor" Or Func.s = "loadmoviesbyactor"
	  
	  ;{ LoadMoviesByActor
	  
	  If OpenPreferences(ML_Settings_File_Movies.s)
	    
	    ExaminePreferenceGroups()
	    While NextPreferenceGroup()
	      
	      ML_AddToList_Title.s = PreferenceGroupName()
	      
	      ;{ Preferences
	      
	      ExaminePreferenceKeys()
	      While NextPreferenceKey()
	        
	        If PreferenceKeyName() = "Actor"
	          
	          If FindString(PreferenceKeyValue(), Actor.s, 1, #PB_String_NoCase)
	            
	            Count.i + 1
	            
	            If Movies.s = ""
	              
	              Movies.s = PreferenceGroupName()
	              
	            Else
	              
	              MoviesLen.i = Len(Movies.s) + 1
	              Movies.s = InsertString(Movies.s, ", " + PreferenceGroupName(), MoviesLen.i)
	              
	            EndIf
	            
	          EndIf
	          
	        EndIf
	        
	      Wend
	      
	      ;}
	      
	      ;{ Add to list
        
        ;CLMF("Add", 0, "Media Library Movies", "Movies Count", 0, ML_Movies_Count.i, 0, 0, 0, "")
        ;ML_Func_Movies("AddMovie", ListSize(ML_List_Movies()) + 1, ML_AddToList_Title.s, ML_AddToList_Release.i, ML_AddToList_Length.i, ML_AddToList_AgeRating.i, ML_AddToList_Genre.s, ML_AddToList_Studio.s, ML_AddToList_Regie.s, ML_AddToList_Actor.s, ML_AddToList_Role.s, ML_AddToList_Plot.s, ML_AddToList_Language.s, ML_AddToList_Resolution.s, ML_AddToList_AspectRatio.s, ML_AddToList_FileSize.s, ML_AddToList_FilePath.s, ML_AddToList_FileFormat.s, ML_AddToList_PicturePath.s, PictureID.i, ImageID.i, ImageOverID.i)
        
        ;}
	      
	    Wend
	    
	    ;{ Debug
	    
	    Debug Actor.s + ": " + Str(Count.i)
	    Debug "» Movies: " + Movies.s
	    
	    ;}
	    
	  Else
	    
	    ML_Msg_Error(ML_Error_Prefs_Movies.s)
	    
	  EndIf
	  
	  ;}
	  
	ElseIf Func.s = "LoadMoviesByRole" Or Func.s = "loadmoviesbyrole"
	  
	  ;{ LoadMoviesByRole
	  
	  If OpenPreferences(ML_Settings_File_Movies.s)
	    
	    ExaminePreferenceGroups()
	    While NextPreferenceGroup()
	      
	      ML_AddToList_Title.s = PreferenceGroupName()
	      
	      ;{ Preferences
	      
	      ExaminePreferenceKeys()
	      While NextPreferenceKey()
	        
	        If PreferenceKeyName() = "Role"
	          
	          If FindString(PreferenceKeyValue(), Role.s, 1, #PB_String_NoCase)
	            
	            Count.i + 1
	            
	            If Movies.s = ""
	              
	              Movies.s = PreferenceGroupName()
	              
	            Else
	              
	              MoviesLen.i = Len(Movies.s) + 1
	              Movies.s = InsertString(Movies.s, ", " + PreferenceGroupName(), MoviesLen.i)
	              
	            EndIf
	            
	          EndIf
	          
	        EndIf
	        
	      Wend
	      
	      ;}
	      
	      ;{ Add to list
        
        ;CLMF("Add", 0, "Media Library Movies", "Movies Count", 0, ML_Movies_Count.i, 0, 0, 0, "")
        ;ML_Func_Movies("AddMovie", ListSize(ML_List_Movies()) + 1, ML_AddToList_Title.s, ML_AddToList_Release.i, ML_AddToList_Length.i, ML_AddToList_AgeRating.i, ML_AddToList_Genre.s, ML_AddToList_Studio.s, ML_AddToList_Regie.s, ML_AddToList_Actor.s, ML_AddToList_Role.s, ML_AddToList_Plot.s, ML_AddToList_Language.s, ML_AddToList_Resolution.s, ML_AddToList_AspectRatio.s, ML_AddToList_FileSize.s, ML_AddToList_FilePath.s, ML_AddToList_FileFormat.s, ML_AddToList_PicturePath.s, PictureID.i, ImageID.i, ImageOverID.i)
        
        ;}
	      
	    Wend
	    
	    ;{ Debug
	    
	    Debug Role.s + ": " + Str(Count.i)
	    Debug "» Movies: " + Movies.s
	    
	    ;}
	    
	  Else
	    
	    ML_Msg_Error(ML_Error_Prefs_Movies.s)
	    
	  EndIf
	  
	  ;}
	  
	ElseIf Func.s = "ListMoviesQuery" Or Func.s = "listmoviesquery"
	  
	  ;{ ListMoviesQuery
	  
	  ;{ Debug
	  
	  ;If Title.s <> "" : Debug "Search [" + Title.s + "]" : EndIf
	  ;If Release.i <> "" : Debug "Search [" + Str(Release.i) + "]" : EndIf
    ;If Length.i <> "" : Debug "Search [" + Str(Length.i) + "]" : EndIf
	  ;If AgeRating.i <> "" : Debug "Search [" + Str(AgeRating.i) + "]" : EndIf
	  ;If Genre.s <> "" : Debug "Search [" + Genre.s + "]" : EndIf
	  ;If Studio.s <> "" : Debug "Search [" + Studio.s + "]" : EndIf
	  ;If Regie.s <> "" : Debug "Search [" + Regie.s + "]" : EndIf
    ;If Actor.s <> "" : Debug "Search [" + Actor.s + "]" : EndIf
    ;If Role.s <> "" : Debug "Search [" + Role.s + "]" : EndIf
	  ;If Language.s <> "" : Debug "Search [" + Language.s + "]" : EndIf
	  
	  ;}
	  
	  ResetList(ML_List_Movies())
	  While NextElement(ML_List_Movies())
	    
	    With ML_List_Movies()
	      
	      If Title.s <> "" And FindString(\ML_Title.s, Title.s, 1, #PB_String_NoCase)
	        
	        Count.i + 1
	        Debug "» " + \ML_Title.s
	        
	      EndIf
	      
	      If Release.i <> 0 And \ML_Release.i = Release.i
	        
	        Count.i + 1
	        Debug "» " + \ML_Title.s
	        
	      EndIf
	      
	      If Length.i <> 0 And \ML_Length.i = Length.i
	        
	        Count.i + 1
	        Debug "» " + \ML_Title.s
	        
	      EndIf
	      
	      If AgeRating.i <> 0 And \ML_AgeRating.i = AgeRating.i
	        
	        Count.i + 1
	        Debug "» " + \ML_Title.s
	        
	      EndIf
	      
	      If Genre.s <> ""
	        
	        Select CountString(Genre.s, ",")
	          
	          Case 0
	            
	            If FindString(\ML_Genre.s, Genre.s, 1, #PB_String_NoCase)
	              
	              Count.i + 1
	              Debug "» " + \ML_Title.s
	              
	            EndIf
	            
	          Case 1
	            
	            FindComma.i = FindString(Genre.s, ",")
	            GenreOne.s = Mid(Genre.s, 1, FindComma.i - 1)
	            GenreTwo.s = Mid(Genre.s, FindComma.i + 2)
	            
	            If FindString(\ML_Genre.s, GenreOne.s, 1, #PB_String_NoCase) And FindString(\ML_Genre.s, GenreTwo.s, 1, #PB_String_NoCase)
	              
	              Count.i + 1
	              Debug "» " + \ML_Title.s
	              
	            EndIf
	            
	          Case 2
	            
	            FindCommaOne.i = FindString(Genre.s, ",")
	            FindCommaTwo.i = FindString(Genre.s, ",", FindCommaOne.i + 1)
	            
	            GenreOne.s = Mid(Genre.s, 1, FindCommaOne.i - 1)
	            GenreTwo.s = Mid(Genre.s, FindCommaOne.i + 2, FindCommaTwo.i - FindCommaOne.i - 2)
	            GenreThree.s = Mid(Genre.s, FindCommaTwo.i + 2)
	            
	            If FindString(\ML_Genre.s, GenreOne.s, 1, #PB_String_NoCase) And FindString(\ML_Genre.s, GenreTwo.s, 1, #PB_String_NoCase) And FindString(\ML_Genre.s, GenreThree.s, 1, #PB_String_NoCase)
	              
	              Count.i + 1
	              Debug "» " + \ML_Title.s
	              
	            EndIf
	            
	        EndSelect
	        
	      EndIf
	        
	      If Studio.s <> "" And FindString(\ML_Studio.s, Studio.s, 1, #PB_String_NoCase)
	        
	        Count.i + 1
	        Debug "» " + \ML_Title.s
	        
	      EndIf
	      
	      If Regie.s <> "" And FindString(\ML_Regie.s, Regie.s, 1, #PB_String_NoCase)
	        
	        Count.i + 1
	        Debug "» " + \ML_Title.s
	        
	      EndIf
	      
	      If Actor.s <> ""
	        
	        Select CountString(Actor.s, ",")
	          
	          Case 0
	            
	            If FindString(\ML_Actor.s, Actor.s, 1, #PB_String_NoCase)
	              
	              Count.i + 1
	              Debug "» " + \ML_Title.s
	              
	            EndIf
	            
	          Case 1
	            
	            FindComma.i = FindString(Actor.s, ",")
	            ActorOne.s = Mid(Actor.s, 1, FindComma.i - 1)
	            ActorTwo.s = Mid(Actor.s, FindComma.i + 2)
	            
	            If FindString(\ML_Actor.s, ActorOne.s, 1, #PB_String_NoCase) And FindString(\ML_Actor.s, ActorTwo.s, 1, #PB_String_NoCase)
	              
	              Count.i + 1
	              Debug "» " + \ML_Title.s
	              
	            EndIf
	            
	          Case 2
	            
	            FindCommaOne.i = FindString(Actor.s, ",")
	            FindCommaTwo.i = FindString(Actor.s, ",", FindCommaOne.i + 1)
	            
	            ActorOne.s = Mid(Actor.s, 1, FindCommaOne.i - 1)
	            ActorTwo.s = Mid(Actor.s, FindCommaOne.i + 2, FindCommaTwo.i - FindCommaOne.i - 2)
	            ActorThree.s = Mid(Actor.s, FindCommaTwo.i + 2)
	            
	            If FindString(\ML_Actor.s, ActorOne.s, 1, #PB_String_NoCase) And FindString(\ML_Actor.s, ActorTwo.s, 1, #PB_String_NoCase) And FindString(\ML_Actor.s, ActorThree.s, 1, #PB_String_NoCase)
	              
	              Count.i + 1
	              Debug "» " + \ML_Title.s
	              
	            EndIf
	            
	        EndSelect
	        
	      EndIf
	      
	      If Role.s <> ""
	        
	        Select CountString(Role.s, ",")
	          
	          Case 0
	            
	            If FindString(\ML_Role.s, Role.s, 1, #PB_String_NoCase)
	              
	              Count.i + 1
	              Debug "» " + \ML_Title.s
	              
	            EndIf
	            
	          Case 1
	            
	            FindComma.i = FindString(Role.s, ",")
	            RoleOne.s = Mid(Role.s, 1, FindComma.i - 1)
	            RoleTwo.s = Mid(Role.s, FindComma.i + 2)
	            
	            If FindString(\ML_Role.s, RoleOne.s, 1, #PB_String_NoCase) And FindString(\ML_Role.s, RoleTwo.s, 1, #PB_String_NoCase)
	              
	              Count.i + 1
	              Debug "» " + \ML_Title.s
	              
	            EndIf
	            
	          Case 2
	            
	            FindCommaOne.i = FindString(Role.s, ",")
	            FindCommaTwo.i = FindString(Role.s, ",", FindCommaOne.i + 1)
	            
	            RoleOne.s = Mid(Role.s, 1, FindCommaOne.i - 1)
	            RoleTwo.s = Mid(Role.s, FindCommaOne.i + 2, FindCommaTwo.i - FindCommaOne.i - 2)
	            RoleThree.s = Mid(Role.s, FindCommaTwo.i + 2)
	            
	            If FindString(\ML_Role.s, RoleOne.s, 1, #PB_String_NoCase) And FindString(\ML_Role.s, RoleTwo.s, 1, #PB_String_NoCase) And FindString(\ML_Role.s, RoleThree.s, 1, #PB_String_NoCase)
	              
	              Count.i + 1
	              Debug "» " + \ML_Title.s
	              
	            EndIf
	            
	        EndSelect
	        
	      EndIf
	      
	      If Language.s <> "" And FindString(\ML_Language.s, Language.s, 1, #PB_String_NoCase)
	        
	        Count.i + 1
	        Debug "» " + \ML_Title.s
	        
	      EndIf
	      
	    EndWith
	    
	  Wend
	  
	  ;{ Debug
	  
	  Debug "Movies: " + Str(Count.i)
	  
	  ;}
	  
	  ;}
	  
	ElseIf Func.s = "ListMoviesQueryInfoComplete" Or Func.s = "listmoviesqueryinfocomplete"
	  
	  ;{ ListMoviesQueryInfoComplete
	  
	  ResetList(ML_List_Movies())
	  While NextElement(ML_List_Movies())
	    
	    With ML_List_Movies()
	      
	      MoviesTotal.i + 1
	      
	      If \ML_Title.s <> "" And \ML_Release.i <> 0 And \ML_Length.i <> 0 And \ML_AgeRating.i <> 0 And \ML_Genre.s <> "" And \ML_Studio.s <> "" And \ML_Regie.s <> "" And \ML_Actor.s <> "" And \ML_Role.s <> "" And \ML_Language.s <> ""
	        
	        MoviesFullInfo.i + 1
	        
	      EndIf
	      
	    EndWith
	    
	  Wend
	  
	  Debug "Movies with Info: Title, Release, Length, AgeRating, Genre, Studio, Regie, Actor, Role and Language [" + Str(MoviesFullInfo.i) + " / " + Str(MoviesTotal.i) + "]"
	  
	  ;}
	  
	EndIf
	
EndProcedure



;{ Preparing GadgetState

Procedure ML_Movies_Line(State.i)
  
  Select State.i
    
    Case 0
      
      HideGadget(101, 0)
      HideGadget(102, 0)
      HideGadget(103, 0)
      HideGadget(104, 0)
      HideGadget(105, 0)
      HideGadget(106, 0)
      HideGadget(107, 0)
      HideGadget(108, 0)
      HideGadget(109, 0)
      HideGadget(110, 0)
      HideGadget(111, 0)
      HideGadget(112, 0)
      HideGadget(113, 0)
      HideGadget(114, 0)
      HideGadget(115, 0)
      HideGadget(116, 0)
      HideGadget(117, 0)
      HideGadget(118, 0)
      
    Case 1
      
      HideGadget(101, 1)
      HideGadget(102, 1)
      HideGadget(103, 1)
      HideGadget(104, 1)
      HideGadget(105, 1)
      HideGadget(106, 1)
      HideGadget(107, 1)
      HideGadget(108, 1)
      HideGadget(109, 1)
      HideGadget(110, 1)
      HideGadget(111, 1)
      HideGadget(112, 1)
      HideGadget(113, 1)
      HideGadget(114, 1)
      HideGadget(115, 1)
      HideGadget(116, 1)
      HideGadget(117, 1)
      HideGadget(118, 1)
      
  EndSelect
  
EndProcedure

Procedure ML_Movies_LineDetails(State.i)
  
  Select State.i
    
    Case 0
      
      HideGadget(201, 0)
      HideGadget(202, 0)
      HideGadget(203, 0)
      HideGadget(204, 0)
      HideGadget(205, 0)
      HideGadget(206, 0)
      HideGadget(207, 0)
      HideGadget(208, 0)
      HideGadget(209, 0)
      HideGadget(210, 0)
      HideGadget(211, 0)
      HideGadget(212, 0)
      
    Case 1
      
      HideGadget(201, 1)
      HideGadget(202, 1)
      HideGadget(203, 1)
      HideGadget(204, 1)
      HideGadget(205, 1)
      HideGadget(206, 1)
      HideGadget(207, 1)
      HideGadget(208, 1)
      HideGadget(209, 1)
      HideGadget(210, 1)
      HideGadget(211, 1)
      HideGadget(212, 1)
      
  EndSelect
  
EndProcedure

;}

;{ Preparing Images

Procedure ML_CreateImage_NaviButton(ImageID.i, W.i, H.i, BGColor.i, FColor.i, ImageText.s)
  
  If CreateImage(ImageID.i, W.i, H.i, 32, BGColor.i)
    
    Rnd.i = 2
    
    StartDrawing(ImageOutput(ImageID.i))
      
      BackColor(BGColor.i)
      FrontColor(FColor.i)
      DrawingMode(#PB_2DDrawing_Transparent)
      RoundBox(1, 1, W.i - 2, H.i - 2, Rnd.i, Rnd.i)
      
      DrawingFont(FontID(ML_Settings_NaviText_Font.i))
      DrawText(8, 3, ImageText.s, $000000)
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageID.i))
    
  EndIf
  
EndProcedure

Procedure ML_CreateImage_NaviButtonOver(ImageID.i, W.i, H.i, BGColor.i, FColor.i, ImageText.s)
  
  If CreateImage(ImageID.i, W.i, H.i, 32, BGColor.i)
    
    Rnd.i = 2
    
    StartDrawing(ImageOutput(ImageID.i))
      
      BackColor(BGColor.i)
      FrontColor(FColor.i)
      DrawingMode(#PB_2DDrawing_Transparent)
      RoundBox(1, 1, W.i - 2, H.i - 2, Rnd.i, Rnd.i)
      
      DrawingFont(FontID(ML_Settings_NaviText_Font.i))
      DrawText(8, 3, ImageText.s, $000000)
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageID.i))
    
  EndIf
  
EndProcedure

Procedure ML_CreateImage_NaviButtonVersionOne(ImageID.i, W.i, H.i, BGColor.i, FColor.i, ImageText.s)
  
  If CreateImage(ImageID.i, W.i, H.i, 32, BGColor.i)
    
    Rnd.i = 1
    
    StartDrawing(ImageOutput(ImageID.i))
      
      BackColor(BGColor.i)
      FrontColor(FColor.i)
      DrawingMode(#PB_2DDrawing_Transparent)
      
      RoundBox(1, 1, W.i - 2, H.i - 2, Rnd.i, Rnd.i)
      
      Box(0, 0, 9, 1, BGColor.i)
      Box(0, 1, 8, 1, BGColor.i)
      Box(0, 2, 7, 1, BGColor.i)
      Box(0, 3, 6, 1, BGColor.i)
      Box(0, 4, 5, 1, BGColor.i)
      Box(0, 5, 4, 1, BGColor.i)
      Box(0, 6, 3, 1, BGColor.i)
      Box(0, 7, 2, 1, BGColor.i)
      Box(0, 8, 1, 1, BGColor.i)
      
      DrawingFont(FontID(ML_Settings_NaviText_Font.i))
      DrawText(8, 3, ImageText.s, $000000)
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageID.i))
    
  EndIf
  
EndProcedure

Procedure ML_CreateImage_NaviButtonOverVersionOne(ImageID.i, W.i, H.i, BGColor.i, FColor.i, ImageText.s)
  
  If CreateImage(ImageID.i, W.i, H.i, 32, BGColor.i)
    
    Rnd.i = 1
    
    StartDrawing(ImageOutput(ImageID.i))
      
      BackColor(BGColor.i)
      FrontColor(FColor.i)
      DrawingMode(#PB_2DDrawing_Transparent)
      RoundBox(1, 1, W.i - 2, H.i - 2, Rnd.i, Rnd.i)
      
      Box(0, 0, 9, 1, BGColor.i)
      Box(0, 1, 8, 1, BGColor.i)
      Box(0, 2, 7, 1, BGColor.i)
      Box(0, 3, 6, 1, BGColor.i)
      Box(0, 4, 5, 1, BGColor.i)
      Box(0, 5, 4, 1, BGColor.i)
      Box(0, 6, 3, 1, BGColor.i)
      Box(0, 7, 2, 1, BGColor.i)
      Box(0, 8, 1, 1, BGColor.i)
      
      DrawingFont(FontID(ML_Settings_NaviText_Font.i))
      DrawText(8, 3, ImageText.s, $000000)
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageID.i))
    
  EndIf
  
EndProcedure

Procedure ML_CreateImage_NaviButtonVersionTwo(ImageID.i, W.i, H.i, BGColor.i, FColor.i, ImageText.s)
  
  If CreateImage(ImageID.i, W.i, H.i, 32, BGColor.i)
    
    Rnd.i = 1
    
    StartDrawing(ImageOutput(ImageID.i))
      
      BackColor(BGColor.i)
      FrontColor(FColor.i)
      DrawingMode(#PB_2DDrawing_Transparent)
      
      RoundBox(1, 1, W.i - 2, H.i - 2, Rnd.i, Rnd.i)
      
      Box(0, 0, 9, 1, BGColor.i)
      Box(0, 1, 8, 1, BGColor.i)
      Box(0, 2, 7, 1, BGColor.i)
      Box(0, 3, 6, 1, BGColor.i)
      Box(0, 4, 5, 1, BGColor.i)
      Box(0, 5, 4, 1, BGColor.i)
      Box(0, 6, 3, 1, BGColor.i)
      Box(0, 7, 2, 1, BGColor.i)
      Box(0, 8, 1, 1, BGColor.i)
      
      Box(W.i - 1, H.i - 9, 1, 1, BGColor.i)
      Box(W.i - 2, H.i - 8, 2, 1, BGColor.i)
      Box(W.i - 3, H.i - 7, 3, 1, BGColor.i)
      Box(W.i - 4, H.i - 6, 4, 1, BGColor.i)
      Box(W.i - 5, H.i - 5, 5, 1, BGColor.i)
      Box(W.i - 6, H.i - 4, 6, 1, BGColor.i)
      Box(W.i - 7, H.i - 3, 7, 1, BGColor.i)
      Box(W.i - 8, H.i - 2, 8, 1, BGColor.i)
      Box(W.i - 9, H.i - 1, 9, 1, BGColor.i)
      
      DrawingFont(FontID(ML_Settings_NaviText_Font.i))
      DrawText(8, 3, ImageText.s, $000000)
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageID.i))
    
  EndIf
  
EndProcedure

Procedure ML_CreateImage_NaviButtonOverVersionTwo(ImageID.i, W.i, H.i, BGColor.i, FColor.i, ImageText.s)
  
  If CreateImage(ImageID.i, W.i, H.i, 32, BGColor.i)
    
    Rnd.i = 1
    
    StartDrawing(ImageOutput(ImageID.i))
      
      BackColor(BGColor.i)
      FrontColor(FColor.i)
      DrawingMode(#PB_2DDrawing_Transparent)
      RoundBox(1, 1, W.i - 2, H.i - 2, Rnd.i, Rnd.i)
      
      Box(0, 0, 9, 1, BGColor.i)
      Box(0, 1, 8, 1, BGColor.i)
      Box(0, 2, 7, 1, BGColor.i)
      Box(0, 3, 6, 1, BGColor.i)
      Box(0, 4, 5, 1, BGColor.i)
      Box(0, 5, 4, 1, BGColor.i)
      Box(0, 6, 3, 1, BGColor.i)
      Box(0, 7, 2, 1, BGColor.i)
      Box(0, 8, 1, 1, BGColor.i)
      
      Box(W.i - 1, H.i - 9, 1, 1, BGColor.i)
      Box(W.i - 2, H.i - 8, 2, 1, BGColor.i)
      Box(W.i - 3, H.i - 7, 3, 1, BGColor.i)
      Box(W.i - 4, H.i - 6, 4, 1, BGColor.i)
      Box(W.i - 5, H.i - 5, 5, 1, BGColor.i)
      Box(W.i - 6, H.i - 4, 6, 1, BGColor.i)
      Box(W.i - 7, H.i - 3, 7, 1, BGColor.i)
      Box(W.i - 8, H.i - 2, 8, 1, BGColor.i)
      Box(W.i - 9, H.i - 1, 9, 1, BGColor.i)
      
      DrawingFont(FontID(ML_Settings_NaviText_Font.i))
      DrawText(8, 3, ImageText.s, $000000)
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageID.i))
    
  EndIf
  
EndProcedure



Procedure ML_CreateImage_SubNavi(ImageID.i, W.i, H.i)
  
  Protected color.i = 89
  Protected b.i = 450
  Protected height.i = 1
  Protected red.i = color.i
  Protected green.i = color.i
  Protected blue.i = color.i
  
  If CreateImage(ImageID.i, W.i, H.i, 32)
    
    StartDrawing(ImageOutput(ImageID.i))
      
      BackColor(ML_Settings_Window_BGColor.i)
      FrontColor(RGB(0, 0, 0))
      DrawingMode(#PB_2DDrawing_Transparent)
      Box(0, 20, W.i, H.i)
      
      For a = 450 To 482
        
        Box(b.i, H.i - height.i, W.i, 1, RGB(red.i, green.i, blue.i))
        
        b.i + 1
        height.i + 1
        red.i + 1
        green.i + 1
        blue.i + 1
        
      Next
      
      ;{ Rounded Top
      
      Plot(481, 7, RGB(0, 0, 0))
      Plot(482, 7, RGB(0, 0, 0))
      Plot(483, 7, RGB(0, 0, 0))
      Plot(484, 7, RGB(0, 0, 0))
      
      Plot(480, 8, RGB(0, 0, 0))
      Plot(481, 8, RGB(0, 0, 0))
      Plot(482, 8, RGB(0, 0, 0))
      
      Plot(479, 9, RGB(0, 0, 0))
      Plot(480, 9, RGB(0, 0, 0))
      
      Plot(478, 10, RGB(0, 0, 0))
      
      ;}
      
      ;{ Rounded Bottom
      
      Plot(452, H.i - 4, RGB(color.i, color.i, color.i))
      
      Plot(450, H.i - 3, RGB(color.i, color.i, color.i))
      Plot(451, H.i - 3, RGB(color.i, color.i, color.i))
      
      Plot(448, H.i - 2, RGB(color.i, color.i, color.i))
      Plot(449, H.i - 2, RGB(color.i, color.i, color.i))
      Plot(450, H.i - 2, RGB(color.i, color.i, color.i))
      
      Plot(446, H.i - 1, RGB(color.i, color.i, color.i))
      Plot(447, H.i - 1, RGB(color.i, color.i, color.i))
      Plot(448, H.i - 1, RGB(color.i, color.i, color.i))
      Plot(449, H.i - 1, RGB(color.i, color.i, color.i))
      
      ;}
      
      ;Line(445, 1, 1, H.i, RGB(200, 200, 200))   \
      ;Line(645, 1, 1, H.i, RGB(200, 200, 200))    \
      ;Line(845, 1, 1, H.i, RGB(200, 200, 200))     |-> helps to grab subnavi images
      ;Line(1045, 1, 1, H.i, RGB(200, 200, 200))   /
      ;Line(1245, 1, 1, H.i, RGB(200, 200, 200))  /
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageID.i))
    
  EndIf
  
EndProcedure

Procedure ML_CreateImage_SubNaviOver(ImageID.i, W.i, H.i)
  
  Protected color.i = 109
  Protected b.i = 450
  Protected height.i = 1
  Protected red.i = color.i
  Protected green.i = color.i
  Protected blue.i = color.i
  
  If CreateImage(ImageID.i, W.i, H.i, 32)
    
    StartDrawing(ImageOutput(ImageID.i))
      
      BackColor(ML_Settings_Window_BGColor.i)
      FrontColor(RGB(0, 0, 0))
      DrawingMode(#PB_2DDrawing_Transparent)
      Box(0, 20, W.i, H.i)
      
      For a = 450 To 482
        
        Box(b.i, H.i - height.i, W.i, 1, RGB(red.i, green.i, blue.i))
        
        b.i + 1
        height.i + 1
        red.i + 1
        green.i + 1
        blue.i + 1
        
      Next
      
      ;{ Rounded Top
      
      Plot(481, 7, RGB(0, 0, 0))
      Plot(482, 7, RGB(0, 0, 0))
      Plot(483, 7, RGB(0, 0, 0))
      Plot(484, 7, RGB(0, 0, 0))
      
      Plot(480, 8, RGB(0, 0, 0))
      Plot(481, 8, RGB(0, 0, 0))
      Plot(482, 8, RGB(0, 0, 0))
      
      Plot(479, 9, RGB(0, 0, 0))
      Plot(480, 9, RGB(0, 0, 0))
      
      Plot(478, 10, RGB(0, 0, 0))
      
      ;}
      
      ;{ Rounded Bottom
      
      Plot(452, H.i - 4, RGB(color.i, color.i, color.i))
      
      Plot(450, H.i - 3, RGB(color.i, color.i, color.i))
      Plot(451, H.i - 3, RGB(color.i, color.i, color.i))
      
      Plot(448, H.i - 2, RGB(color.i, color.i, color.i))
      Plot(449, H.i - 2, RGB(color.i, color.i, color.i))
      Plot(450, H.i - 2, RGB(color.i, color.i, color.i))
      
      Plot(446, H.i - 1, RGB(color.i, color.i, color.i))
      Plot(447, H.i - 1, RGB(color.i, color.i, color.i))
      Plot(448, H.i - 1, RGB(color.i, color.i, color.i))
      Plot(449, H.i - 1, RGB(color.i, color.i, color.i))
      
      ;}
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageID.i))
    
  EndIf
  
EndProcedure



Procedure ML_CreateImage_SubNaviTitle(ImageID.i, Title.s, Text.s)
  
  If CreateImage(ImageID.i, 450, 40, 32)
    
    GrabImage(51, ImageID.i, 0, 0, 450, 40)
    
    StartDrawing(ImageOutput(ImageID.i))
      
      BackColor(ML_Settings_Window_BGColor.i)
      FrontColor(RGB(255, 255, 255))
      DrawingMode(#PB_2DDrawing_Transparent)
      
      DrawingFont(FontID(10))
      DrawText(10, 2, Title.s)
      DrawingFont(FontID(5))
      DrawText(10, 22, Text.s)
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageID.i))
    
  EndIf
  
EndProcedure

Procedure ML_CreateImage_SubNaviOne(ImageID.i, ImageOverID.i, ImageText.s)
  
  If CreateImage(ImageID.i, ML_Coordinate_SubNaviOne_W.i, ML_Coordinate_SubNaviOne_H.i, 32)
    
    GrabImage(51, ImageID.i, ML_Coordinate_SubNaviOne_X.i, 0, ML_Coordinate_SubNaviOne_W.i, ML_Coordinate_SubNaviOne_H.i)
    
    StartDrawing(ImageOutput(ImageID.i))
      
      BackColor(ML_Settings_Window_BGColor.i)
      FrontColor(RGB(255, 255, 255))
      DrawingMode(#PB_2DDrawing_Transparent)
      
      DrawingFont(FontID(ML_Settings_SubNaviText_Font.i))
      DrawText(ML_Coordinate_SubNaviOneText_X.i, ML_Coordinate_SubNaviOneText_Y.i, ImageText.s)
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageID.i))
    
  EndIf
  
  If CreateImage(ImageOverID.i, ML_Coordinate_SubNaviOne_W.i, ML_Coordinate_SubNaviOne_H.i, 32)
    
    GrabImage(52, ImageOverID.i, ML_Coordinate_SubNaviOne_X.i, 0, ML_Coordinate_SubNaviOne_W.i, ML_Coordinate_SubNaviOne_H.i)
    
    StartDrawing(ImageOutput(ImageOverID.i))
      
      BackColor(ML_Settings_Window_BGColor.i)
      FrontColor(RGB(255, 255, 255))
      DrawingMode(#PB_2DDrawing_Transparent)
      
      DrawingFont(FontID(ML_Settings_SubNaviText_Font.i))
      DrawText(ML_Coordinate_SubNaviOneText_X.i, ML_Coordinate_SubNaviOneText_Y.i, ImageText.s)
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageOverID.i))
    
  EndIf
  
EndProcedure

Procedure ML_CreateImage_SubNaviTwo(ImageID.i, ImageOverID.i, ImageText.s)
  
  If CreateImage(ImageID.i, ML_Coordinate_SubNaviTwo_W.i, ML_Coordinate_SubNaviTwo_H.i, 32)
    
    GrabImage(51, ImageID.i, ML_Coordinate_SubNaviTwo_X.i, 0, ML_Coordinate_SubNaviTwo_W.i, ML_Coordinate_SubNaviTwo_H.i)
    
    StartDrawing(ImageOutput(ImageID.i))
      
      BackColor(ML_Settings_Window_BGColor.i)
      FrontColor(RGB(255, 255, 255))
      DrawingMode(#PB_2DDrawing_Transparent)
      
      DrawingFont(FontID(ML_Settings_SubNaviText_Font.i))
      DrawText(ML_Coordinate_SubNaviTwoText_X.i, ML_Coordinate_SubNaviTwoText_Y.i, ImageText.s)
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageID.i))
    
  EndIf
  
  If CreateImage(ImageOverID.i, ML_Coordinate_SubNaviTwo_W.i, ML_Coordinate_SubNaviTwo_H.i, 32)
    
    GrabImage(52, ImageOverID.i, ML_Coordinate_SubNaviTwo_X.i, 0, ML_Coordinate_SubNaviTwo_W.i, ML_Coordinate_SubNaviTwo_H.i)
    
    StartDrawing(ImageOutput(ImageOverID.i))
      
      BackColor(ML_Settings_Window_BGColor.i)
      FrontColor(RGB(255, 255, 255))
      DrawingMode(#PB_2DDrawing_Transparent)
      
      DrawingFont(FontID(ML_Settings_SubNaviText_Font.i))
      DrawText(ML_Coordinate_SubNaviTwoText_X.i, ML_Coordinate_SubNaviTwoText_Y.i, ImageText.s)
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageOverID.i))
    
  EndIf
  
EndProcedure

Procedure ML_CreateImage_SubNaviThree(ImageID.i, ImageOverID.i, ImageText.s)
  
  If CreateImage(ImageID.i, ML_Coordinate_SubNaviThree_W.i, ML_Coordinate_SubNaviThree_H.i, 32)
    
    GrabImage(51, ImageID.i, ML_Coordinate_SubNaviThree_X.i, 0, ML_Coordinate_SubNaviThree_W.i, ML_Coordinate_SubNaviThree_H.i)
    
    StartDrawing(ImageOutput(ImageID.i))
      
      BackColor(ML_Settings_Window_BGColor.i)
      FrontColor(RGB(255, 255, 255))
      DrawingMode(#PB_2DDrawing_Transparent)
      
      DrawingFont(FontID(ML_Settings_SubNaviText_Font.i))
      DrawText(ML_Coordinate_SubNaviThreeText_X.i, ML_Coordinate_SubNaviThreeText_Y.i, ImageText.s)
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageID.i))
    
  EndIf
  
  If CreateImage(ImageOverID.i, ML_Coordinate_SubNaviThree_W.i, ML_Coordinate_SubNaviThree_H.i, 32)
    
    GrabImage(52, ImageOverID.i, ML_Coordinate_SubNaviThree_X.i, 0, ML_Coordinate_SubNaviThree_W.i, ML_Coordinate_SubNaviThree_H.i)
    
    StartDrawing(ImageOutput(ImageOverID.i))
      
      BackColor(ML_Settings_Window_BGColor.i)
      FrontColor(RGB(255, 255, 255))
      DrawingMode(#PB_2DDrawing_Transparent)
      
      DrawingFont(FontID(ML_Settings_SubNaviText_Font.i))
      DrawText(ML_Coordinate_SubNaviThreeText_X.i, ML_Coordinate_SubNaviThreeText_Y.i, ImageText.s)
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageOverID.i))
    
  EndIf
  
EndProcedure

Procedure ML_CreateImage_SubNaviFour(ImageID.i, ImageOverID.i, ImageText.s)
  
  If CreateImage(ImageID.i, ML_Coordinate_SubNaviFour_W.i, ML_Coordinate_SubNaviFour_H.i, 32)
    
    GrabImage(51, ImageID.i, ML_Coordinate_SubNaviFour_X.i, 0, ML_Coordinate_SubNaviFour_W.i, ML_Coordinate_SubNaviFour_H.i)
    
    StartDrawing(ImageOutput(ImageID.i))
      
      BackColor(ML_Settings_Window_BGColor.i)
      FrontColor(RGB(255, 255, 255))
      DrawingMode(#PB_2DDrawing_Transparent)
      
      DrawingFont(FontID(ML_Settings_SubNaviText_Font.i))
      DrawText(ML_Coordinate_SubNaviFourText_X.i, ML_Coordinate_SubNaviFourText_Y.i, ImageText.s)
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageID.i))
    
  EndIf
  
  If CreateImage(ImageOverID.i, ML_Coordinate_SubNaviFour_W.i, ML_Coordinate_SubNaviFour_H.i, 32)
    
    GrabImage(52, ImageOverID.i, ML_Coordinate_SubNaviFour_X.i, 0, ML_Coordinate_SubNaviFour_W.i, ML_Coordinate_SubNaviFour_H.i)
    
    StartDrawing(ImageOutput(ImageOverID.i))
      
      BackColor(ML_Settings_Window_BGColor.i)
      FrontColor(RGB(255, 255, 255))
      DrawingMode(#PB_2DDrawing_Transparent)
      
      DrawingFont(FontID(ML_Settings_SubNaviText_Font.i))
      DrawText(ML_Coordinate_SubNaviFourText_X.i, ML_Coordinate_SubNaviFourText_Y.i, ImageText.s)
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageOverID.i))
    
  EndIf
  
EndProcedure

Procedure ML_CreateImage_SubNaviFive(ImageID.i, ImageOverID.i, ImageText.s)
  
  If CreateImage(ImageID.i, ML_Coordinate_SubNaviFive_W.i, ML_Coordinate_SubNaviFive_H.i, 32)
    
    GrabImage(51, ImageID.i, ML_Coordinate_SubNaviFive_X.i, 0, ML_Coordinate_SubNaviFive_W.i, ML_Coordinate_SubNaviFive_H.i)
    
    StartDrawing(ImageOutput(ImageID.i))
      
      BackColor(ML_Settings_Window_BGColor.i)
      FrontColor(RGB(255, 255, 255))
      DrawingMode(#PB_2DDrawing_Transparent)
      
      DrawingFont(FontID(ML_Settings_SubNaviText_Font.i))
      DrawText(ML_Coordinate_SubNaviFiveText_X.i, ML_Coordinate_SubNaviFiveText_Y.i, ImageText.s)
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageID.i))
    
  EndIf
  
  If CreateImage(ImageOverID.i, ML_Coordinate_SubNaviFive_W.i, ML_Coordinate_SubNaviFive_H.i, 32)
    
    GrabImage(52, ImageOverID.i, ML_Coordinate_SubNaviFive_X.i, 0, ML_Coordinate_SubNaviFive_W.i, ML_Coordinate_SubNaviFive_H.i)
    
    StartDrawing(ImageOutput(ImageOverID.i))
      
      BackColor(ML_Settings_Window_BGColor.i)
      FrontColor(RGB(255, 255, 255))
      DrawingMode(#PB_2DDrawing_Transparent)
      
      DrawingFont(FontID(ML_Settings_SubNaviText_Font.i))
      DrawText(ML_Coordinate_SubNaviFiveText_X.i, ML_Coordinate_SubNaviFiveText_Y.i, ImageText.s)
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageOverID.i))
    
  EndIf
  
EndProcedure

Procedure ML_CreateImage_SubNaviEnd(ImageID.i)
  
  If CreateImage(ImageID.i, ML_Coordinate_SubNaviEnd_W.i, ML_Coordinate_SubNaviEnd_H.i, 32)
    
    GrabImage(51, ImageID.i, 1250, 0, ML_Coordinate_SubNaviEnd_W.i, ML_Coordinate_SubNaviEnd_H.i)
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageID.i))
    
  EndIf
  
EndProcedure



Procedure ML_CreateImage_Movies_Entry_Line(ImageID.i, ImageOverID.i, W.i, H.i, Title.s)
  
  Rnd.i = 2
  Edge.i = ML_Settings_Movies_Entry_Edge.i
  
  If CreateImage(ImageID.i, W.i, H.i, 32)
    
    StartDrawing(ImageOutput(ImageID.i))
      
      BackColor(ML_Settings_Window_BGColor.i)
      FrontColor(RGB(255, 255, 255))
      DrawingMode(#PB_2DDrawing_Transparent)
      RoundBox(0, 0, W.i, H.i, Rnd.i, Rnd.i)
      FrontColor(RGB(200, 200, 200))
      RoundBox(Edge.i - 1, Edge.i - 1, W.i - (Edge.i * 2) + 2, H.i - (Edge.i * 2) + 2, Rnd.i, Rnd.i)
      FrontColor(ML_Settings_Movies_Entry_BGColor.i)
      RoundBox(Edge.i, Edge.i, W.i - (Edge.i * 2), H.i - (Edge.i * 2), Rnd.i, Rnd.i)
      
      FrontColor(ML_Settings_Movies_Entry_Title_Color.i)
      DrawingFont(FontID(5))
      DrawText(8, 4, Title.s)
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageID.i))
    
  EndIf
  
  If CreateImage(ImageOverID.i, W.i, H.i, 32)
    
    StartDrawing(ImageOutput(ImageOverID.i))
      
      BackColor(ML_Settings_Window_BGColor.i)
      FrontColor(RGB(255, 255, 255))
      DrawingMode(#PB_2DDrawing_Transparent)
      RoundBox(0, 0, W.i, H.i, Rnd.i, Rnd.i)
      FrontColor(RGB(200, 200, 200))
      RoundBox(Edge.i - 1, Edge.i - 1, W.i - (Edge.i * 2) + 2, H.i - (Edge.i * 2) + 2, Rnd.i, Rnd.i)
      FrontColor(ML_Settings_Movies_Entry_Over_BGColor.i)
      RoundBox(Edge.i, Edge.i, W.i - (Edge.i * 2), H.i - (Edge.i * 2), Rnd.i, Rnd.i)
      
      FrontColor(ML_Settings_Movies_Entry_Title_Color.i)
      DrawingFont(FontID(5))
      DrawText(8, 4, Title.s)
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageOverID.i))
    
  EndIf
  
EndProcedure

Procedure ML_CreateImage_Movies_Entry_LineDetails(ImageID.i, ImageOverID.i, W.i, H.i, Title.s, TextOne.s, TextTwo.s)
  
  Rnd.i = 2
  Edge.i = ML_Settings_Movies_Entry_Edge.i
  
  If CreateImage(ImageID.i, W.i, H.i, 32)
    
    StartDrawing(ImageOutput(ImageID.i))
      
      BackColor(ML_Settings_Window_BGColor.i)
      FrontColor(RGB(255, 255, 255))
      DrawingMode(#PB_2DDrawing_Transparent)
      RoundBox(0, 0, W.i, H.i, Rnd.i, Rnd.i)
      FrontColor(RGB(200, 200, 200))
      RoundBox(Edge.i - 1, Edge.i - 1, W.i - (Edge.i * 2) + 2, H.i - (Edge.i * 2) + 2, Rnd.i, Rnd.i)
      FrontColor(ML_Settings_Movies_Entry_BGColor.i)
      RoundBox(Edge.i, Edge.i, W.i - (Edge.i * 2), H.i - (Edge.i * 2), Rnd.i, Rnd.i)
      
      FrontColor(ML_Settings_Movies_Entry_Title_Color.i)
      DrawingFont(FontID(5))
      DrawText(8, 4, Title.s)
      FrontColor(ML_Settings_Movies_Entry_Details_Color.i)
      DrawingFont(FontID(3))
      DrawText(27, 20, TextOne.s)
      FrontColor(ML_Settings_Movies_Entry_Details_Color.i)
      DrawingFont(FontID(3))
      DrawText(160, 20, TextTwo.s)
      
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageID.i))
    
  EndIf
  
  If CreateImage(ImageOverID.i, W.i, H.i, 32)
    
    StartDrawing(ImageOutput(ImageOverID.i))
      
      BackColor(ML_Settings_Window_BGColor.i)
      FrontColor(RGB(255, 255, 255))
      DrawingMode(#PB_2DDrawing_Transparent)
      RoundBox(0, 0, W.i, H.i, Rnd.i, Rnd.i)
      FrontColor(RGB(200, 200, 200))
      RoundBox(Edge.i - 1, Edge.i - 1, W.i - (Edge.i * 2) + 2, H.i - (Edge.i * 2) + 2, Rnd.i, Rnd.i)
      FrontColor(ML_Settings_Movies_Entry_Over_BGColor.i)
      RoundBox(Edge.i, Edge.i, W.i - (Edge.i * 2), H.i - (Edge.i * 2), Rnd.i, Rnd.i)
      
      FrontColor(ML_Settings_Movies_Entry_Title_Color.i)
      DrawingFont(FontID(5))
      DrawText(8, 4, Title.s)
      FrontColor(ML_Settings_Movies_Entry_Details_Color.i)
      DrawingFont(FontID(3))
      DrawText(27, 20, TextOne.s)
      FrontColor(ML_Settings_Movies_Entry_Details_Color.i)
      DrawingFont(FontID(3))
      DrawText(160, 20, TextTwo.s)
      
      
    StopDrawing()
    
  Else
    
    ML_Msg_Error(ML_Error_CreateImage.s + Str(ImageOverID.i))
    
  EndIf
  
EndProcedure

;}

;{ Create Images

;{ Navi (Default)

ML_CreateImage_NaviButton(1, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButton_Color.i, ML_NaviButtonOne.s)
ML_CreateImage_NaviButton(2, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButton_Color.i, ML_NaviButtonTwo.s)
ML_CreateImage_NaviButton(3, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButton_Color.i, ML_NaviButtonThree.s)
ML_CreateImage_NaviButton(4, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButton_Color.i, ML_NaviButtonFour.s)
ML_CreateImage_NaviButton(5, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButton_Color.i, ML_NaviButtonFive.s)
ML_CreateImage_NaviButton(6, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButton_Color.i, ML_NaviButtonSix.s)

ML_CreateImage_NaviButtonOver(7, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButtonOver_Color.i, ML_NaviButtonOne.s)
ML_CreateImage_NaviButtonOver(8, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButtonOver_Color.i, ML_NaviButtonTwo.s)
ML_CreateImage_NaviButtonOver(9, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButtonOver_Color.i, ML_NaviButtonThree.s)
ML_CreateImage_NaviButtonOver(10, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButtonOver_Color.i, ML_NaviButtonFour.s)
ML_CreateImage_NaviButtonOver(11, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButtonOver_Color.i, ML_NaviButtonFive.s)
ML_CreateImage_NaviButtonOver(12, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButtonOver_Color.i, ML_NaviButtonSix.s)

;}

;{ Navi (Version One)

ML_CreateImage_NaviButtonVersionOne(21, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButton_Color.i, ML_NaviButtonOne.s)
ML_CreateImage_NaviButtonVersionOne(22, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButton_Color.i, ML_NaviButtonTwo.s)
ML_CreateImage_NaviButtonVersionOne(23, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButton_Color.i, ML_NaviButtonThree.s)
ML_CreateImage_NaviButtonVersionOne(24, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButton_Color.i, ML_NaviButtonFour.s)
ML_CreateImage_NaviButtonVersionOne(25, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButton_Color.i, ML_NaviButtonFive.s)
ML_CreateImage_NaviButtonVersionOne(26, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButton_Color.i, ML_NaviButtonSix.s)

ML_CreateImage_NaviButtonOverVersionOne(27, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButtonOver_Color.i, ML_NaviButtonOne.s)
ML_CreateImage_NaviButtonOverVersionOne(28, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButtonOver_Color.i, ML_NaviButtonTwo.s)
ML_CreateImage_NaviButtonOverVersionOne(29, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButtonOver_Color.i, ML_NaviButtonThree.s)
ML_CreateImage_NaviButtonOverVersionOne(30, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButtonOver_Color.i, ML_NaviButtonFour.s)
ML_CreateImage_NaviButtonOverVersionOne(31, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButtonOver_Color.i, ML_NaviButtonFive.s)
ML_CreateImage_NaviButtonOverVersionOne(32, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButtonOver_Color.i, ML_NaviButtonSix.s)

;}

;{ Navi (Version Two)

ML_CreateImage_NaviButtonVersionTwo(41, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButton_Color.i, ML_NaviButtonOne.s)
ML_CreateImage_NaviButtonVersionTwo(42, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButton_Color.i, ML_NaviButtonTwo.s)
ML_CreateImage_NaviButtonVersionTwo(43, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButton_Color.i, ML_NaviButtonThree.s)
ML_CreateImage_NaviButtonVersionTwo(44, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButton_Color.i, ML_NaviButtonFour.s)
ML_CreateImage_NaviButtonVersionTwo(45, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButton_Color.i, ML_NaviButtonFive.s)
ML_CreateImage_NaviButtonVersionTwo(46, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButton_Color.i, ML_NaviButtonSix.s)

ML_CreateImage_NaviButtonOverVersionTwo(47, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButtonOver_Color.i, ML_NaviButtonOne.s)
ML_CreateImage_NaviButtonOverVersionTwo(48, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButtonOver_Color.i, ML_NaviButtonTwo.s)
ML_CreateImage_NaviButtonOverVersionTwo(49, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButtonOver_Color.i, ML_NaviButtonThree.s)
ML_CreateImage_NaviButtonOverVersionTwo(50, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButtonOver_Color.i, ML_NaviButtonFour.s)
ML_CreateImage_NaviButtonOverVersionTwo(51, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButtonOver_Color.i, ML_NaviButtonFive.s)
ML_CreateImage_NaviButtonOverVersionTwo(52, 140, 24, ML_Settings_Window_BGColor.i, ML_Settings_NaviButtonOver_Color.i, ML_NaviButtonSix.s)

;}

;{ SubNavi (Default)

Procedure ML_SubNavi_Init()
  
  ML_CreateImage_SubNavi(51, 1280, 40)
  ML_CreateImage_SubNaviOver(52, 1280, 40)
  
  ML_CreateImage_SubNaviTitle(100, ML_Info_Name.s, ML_Info_Description.s)
  ML_CreateImage_SubNaviTitle(120, "Filme", "Auswahl nach Titel, Erscheinungsjahr, Genre, Studio oder Darsteller")
  ML_CreateImage_SubNaviTitle(140, "Serien", "Auswahl nach Titel, Erscheinungsjahr, Genre oder Darsteller")
  ML_CreateImage_SubNaviTitle(160, "Spiele", "Auswahl nach Titel, Erscheinungsjahr oder Genre")
  ML_CreateImage_SubNaviTitle(180, "Einstellungen", "Anpassen")
  ML_CreateImage_SubNaviTitle(200, "Informationen", "Weitere Informationen")
  ; Start
  ML_CreateImage_SubNaviOne(101, 102, "")
  ML_CreateImage_SubNaviTwo(103, 104, "")
  ML_CreateImage_SubNaviThree(105, 106, "")
  ML_CreateImage_SubNaviFour(107, 108, "")
  ML_CreateImage_SubNaviFive(109, 110, "")
  ; Movies
  ML_CreateImage_SubNaviOne(121, 122, "Titel")
  ML_CreateImage_SubNaviTwo(123, 124, "Erscheinungsjahr")
  ML_CreateImage_SubNaviThree(125, 126, "Genre")
  ML_CreateImage_SubNaviFour(127, 128, "Studio")
  ML_CreateImage_SubNaviFive(129, 130, "Darsteller")
  ; Series
  ML_CreateImage_SubNaviOne(141, 142, "Titel")
  ML_CreateImage_SubNaviTwo(143, 144, "Erscheinungsjahr")
  ML_CreateImage_SubNaviThree(145, 146, "Genre")
  ML_CreateImage_SubNaviFour(147, 148, "Darsteller")
  ML_CreateImage_SubNaviFive(149, 150, "")
  ; Games
  ML_CreateImage_SubNaviOne(161, 162, "Titel")
  ML_CreateImage_SubNaviTwo(163, 164, "Erscheinungsjahr")
  ML_CreateImage_SubNaviThree(165, 166, "Genre")
  ML_CreateImage_SubNaviFour(167, 168, "")
  ML_CreateImage_SubNaviFive(169, 170, "")
  ; Settings
  ML_CreateImage_SubNaviOne(181, 182, "Allgemein")
  ML_CreateImage_SubNaviTwo(183, 184, "")
  ML_CreateImage_SubNaviThree(185, 186, "")
  ML_CreateImage_SubNaviFour(187, 188, "")
  ML_CreateImage_SubNaviFive(189, 190, "")
  ; Informations
  ML_CreateImage_SubNaviOne(201, 202, "Über")
  ML_CreateImage_SubNaviTwo(203, 204, "")
  ML_CreateImage_SubNaviThree(205, 206, "")
  ML_CreateImage_SubNaviFour(207, 208, "")
  ML_CreateImage_SubNaviFive(209, 210, "")
  
  ML_CreateImage_SubNaviEnd(220)
  
EndProcedure

;}

;{ Movies

ML_CreateImage_Movies_Entry_Line(1001, 1002, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, "  1 | 16 Blocks")
ML_CreateImage_Movies_Entry_Line(1003, 1004, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, "  2 | A Clockwork Orange - Uhrwerk Orange")
ML_CreateImage_Movies_Entry_Line(1005, 1006, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, "  3 | After Earth")
ML_CreateImage_Movies_Entry_Line(1007, 1008, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, "  4 | Alex Cross")
ML_CreateImage_Movies_Entry_Line(1009, 1010, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, "  5 | American Pie 1 - Wie Ein Heißer Apfelkuchen")
ML_CreateImage_Movies_Entry_Line(1011, 1012, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, "  6 | American Pie 2")
ML_CreateImage_Movies_Entry_Line(1013, 1014, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, "  7 | American Pie 3 - Jetzt Wird Geheiratet")
ML_CreateImage_Movies_Entry_Line(1015, 1016, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, "  8 | American Pie 4 - Das Klassentreffen")
ML_CreateImage_Movies_Entry_Line(1017, 1018, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, "  9 | Assassins - Die Killer")
ML_CreateImage_Movies_Entry_Line(1019, 1020, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, "10 | Bedtime Stories")
ML_CreateImage_Movies_Entry_Line(1021, 1022, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, "11 | Big Daddy")
ML_CreateImage_Movies_Entry_Line(1023, 1024, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, "12 | Blade 1")
ML_CreateImage_Movies_Entry_Line(1025, 1026, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, "13 | Blade 2")
ML_CreateImage_Movies_Entry_Line(1027, 1028, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, "14 | Blade 3 - Trinity")
ML_CreateImage_Movies_Entry_Line(1029, 1030, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, "15 | Bourne 1 - Die Bourne Identität")
ML_CreateImage_Movies_Entry_Line(1031, 1032, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, "16 | Bourne 2 - Die Bourne Verschwörung")
ML_CreateImage_Movies_Entry_Line(1033, 1034, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, "17 | Bourne 3 - Das Bourne Ultimatum")
ML_CreateImage_Movies_Entry_Line(1035, 1036, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, "18 | Bourne 4 - Das Bourne Vermächtnis")
ML_CreateImage_Movies_Entry_Line(1037, 1038, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, "19 | Bourne 5 - Jason Bourne")
ML_CreateImage_Movies_Entry_Line(1039, 1040, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, "20 | Butterfly Effect (Directors Cut)")

ML_CreateImage_Movies_Entry_LineDetails(10001, 10002, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, "  1 | 16 Blocks", "| Laufzeit: 102 Minuten", "| Darsteller: Bruce Willis, Mos Def, David Morse")
ML_CreateImage_Movies_Entry_LineDetails(10003, 10004, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, "  2 | A Clockwork Orange - Uhrwerk Orange", "| Laufzeit: 131 Minuten", "| Darsteller: Malcolm MacDowell, Patrick Magee, Adrienne Corri")
ML_CreateImage_Movies_Entry_LineDetails(10005, 10006, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, "  3 | After Earth", "| Laufzeit: 100 Minuten", "| Darsteller: Jaden Smith, Will Smith, Sophie Okonedo")
ML_CreateImage_Movies_Entry_LineDetails(10007, 10008, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, "  4 | Alex Cross", "| Laufzeit: 106 Minuten", "| Darsteller: Tyler Perry, Jean Reno, John C. McGinley")
ML_CreateImage_Movies_Entry_LineDetails(10009, 10010, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, "  5 | American Pie 1 - Wie Ein Heißer Apfelkuchen", "| Laufzeit: 95 Minuten", "| Darsteller: Jason Biggs, Shannon Elizabeth, Alyson Hannigan")
ML_CreateImage_Movies_Entry_LineDetails(10011, 10012, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, "  6 | American Pie 2", "| Laufzeit: 106 Minuten", "| Darsteller: Jason Biggs, Shannon Elizabeth, Alyson Hannigan")
ML_CreateImage_Movies_Entry_LineDetails(10013, 10014, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, "  7 | American Pie 3 - Jetzt Wird Geheiratet", "| Laufzeit: 96 Minuten", "| Darsteller: Jason Biggs, Alyson Hannigan, Thomas Ian Nicholas")
ML_CreateImage_Movies_Entry_LineDetails(10015, 10016, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, "  8 | American Pie 4 - Das Klassentreffen", "| Laufzeit: 113 Minuten", "| Darsteller: Jason Biggs, Alyson Hannigan, Chris Klein")
ML_CreateImage_Movies_Entry_LineDetails(10017, 10018, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, "  9 | Assassins - Die Killer", "| Laufzeit: 133 Minuten", "| Darsteller: Sylvester Stallone, Antonio Banderas, Julianne More")
ML_CreateImage_Movies_Entry_LineDetails(10019, 10020, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, "10 | Bedtime Stories", "| Laufzeit: 99 Minuten", "| Darsteller: Adam Sandler, Keri Russell, Guy Pearce")
ML_CreateImage_Movies_Entry_LineDetails(10021, 10022, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, "11 | Big Daddy", "| Laufzeit: 93 Minuten", "| Darsteller: Adam Sandler, Joey Lauren Adams, Jon Stewart")
ML_CreateImage_Movies_Entry_LineDetails(10023, 10024, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, "12 | Blade 1", "| Laufzeit: 119 Minuten", "| Darsteller: Wesley Snipes, Stephen Dorff, Kris Kristofferson")

;}

;}

;}

;{ =====[Media Library - Main]=====

Procedure ML_Window()
  
  Buttons.i = 0
  
  ;{ Check Window Parameters
  
  Select ML_Settings_Window_F.i
    
    Case 0 : ML_Window_Flag.i = #PB_Window_MinimizeGadget
    
    Case 1 : ML_Window_Flag.i = #PB_Window_BorderLess
    
    Case 2 : ML_Window_Flag.i = #PB_Window_MinimizeGadget | #PB_Window_ScreenCentered
    
    Case 3 : ML_Window_Flag.i = #PB_Window_BorderLess | #PB_Window_ScreenCentered
    
  EndSelect
  
  ;}
  
  If OpenWindow(1, ML_Settings_Window_X.i, ML_Settings_Window_Y.i, ML_Settings_Window_W.i, ML_Settings_Window_H.i, ML_Info_Name.s, ML_Window_Flag.i)
    
    ;{ Shortcuts
    
    SetWindowColor(1, ML_Settings_Window_BGColor.i)
    AddKeyboardShortcut(1, #PB_Shortcut_Escape, 9999)
    AddKeyboardShortcut(1, #PB_Shortcut_1, 9998)
    AddKeyboardShortcut(1, #PB_Shortcut_2, 9997)
    AddKeyboardShortcut(1, #PB_Shortcut_3, 9996)
    AddKeyboardShortcut(1, #PB_Shortcut_L, 9991)
    AddKeyboardShortcut(1, #PB_Shortcut_D, 9990)
    
    ;}
    
    ;{ Gadgets
    
    ;TextGadget(90, ML_Coordinate_Movies_Count_X.i, ML_Coordinate_Movies_Count_Y.i, ML_Coordinate_Movies_Count_W.i, ML_Coordinate_Movies_Count_H.i, "(" + Str(ML_Movies_Count.i) + ")")
    ;SetGadgetColor(90, #PB_Gadget_BackColor, RGB(0, 0, 0))
    ;SetGadgetColor(90, #PB_Gadget_FrontColor, RGB(255, 255, 255))
    ;SetGadgetFont(90, FontID(10))
    
    ImageGadget(101, ML_Coordinate_Movies_Entry_Line_X.i, ML_Coordinate_Movies_Entry_Line_Y.i, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, ImageID(1001))
    ImageGadget(102, ML_Coordinate_Movies_Entry_Line_X.i, ML_Coordinate_Movies_Entry_Line_Y.i + 30, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, ImageID(1003))
    ImageGadget(103, ML_Coordinate_Movies_Entry_Line_X.i, ML_Coordinate_Movies_Entry_Line_Y.i + 60, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, ImageID(1005))
    ImageGadget(104, ML_Coordinate_Movies_Entry_Line_X.i, ML_Coordinate_Movies_Entry_Line_Y.i + 90, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, ImageID(1007))
    ImageGadget(105, ML_Coordinate_Movies_Entry_Line_X.i, ML_Coordinate_Movies_Entry_Line_Y.i + 120, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, ImageID(1009))
    ImageGadget(106, ML_Coordinate_Movies_Entry_Line_X.i, ML_Coordinate_Movies_Entry_Line_Y.i + 150, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, ImageID(1011))
    ImageGadget(107, ML_Coordinate_Movies_Entry_Line_X.i, ML_Coordinate_Movies_Entry_Line_Y.i + 180, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, ImageID(1013))
    ImageGadget(108, ML_Coordinate_Movies_Entry_Line_X.i, ML_Coordinate_Movies_Entry_Line_Y.i + 210, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, ImageID(1015))
    ImageGadget(109, ML_Coordinate_Movies_Entry_Line_X.i, ML_Coordinate_Movies_Entry_Line_Y.i + 240, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, ImageID(1017))
    ImageGadget(110, ML_Coordinate_Movies_Entry_Line_X.i, ML_Coordinate_Movies_Entry_Line_Y.i + 270, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, ImageID(1019))
    ImageGadget(111, ML_Coordinate_Movies_Entry_Line_X.i, ML_Coordinate_Movies_Entry_Line_Y.i + 300, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, ImageID(1021))
    ImageGadget(112, ML_Coordinate_Movies_Entry_Line_X.i, ML_Coordinate_Movies_Entry_Line_Y.i + 330, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, ImageID(1023))
    ImageGadget(113, ML_Coordinate_Movies_Entry_Line_X.i, ML_Coordinate_Movies_Entry_Line_Y.i + 360, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, ImageID(1025))
    ImageGadget(114, ML_Coordinate_Movies_Entry_Line_X.i, ML_Coordinate_Movies_Entry_Line_Y.i + 390, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, ImageID(1027))
    ImageGadget(115, ML_Coordinate_Movies_Entry_Line_X.i, ML_Coordinate_Movies_Entry_Line_Y.i + 420, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, ImageID(1029))
    ImageGadget(116, ML_Coordinate_Movies_Entry_Line_X.i, ML_Coordinate_Movies_Entry_Line_Y.i + 450, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, ImageID(1031))
    ImageGadget(117, ML_Coordinate_Movies_Entry_Line_X.i, ML_Coordinate_Movies_Entry_Line_Y.i + 480, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, ImageID(1033))
    ImageGadget(118, ML_Coordinate_Movies_Entry_Line_X.i, ML_Coordinate_Movies_Entry_Line_Y.i + 510, ML_Coordinate_Movies_Entry_Line_W.i, ML_Coordinate_Movies_Entry_Line_H.i, ImageID(1035))
    
    ImageGadget(201, ML_Coordinate_Movies_Entry_LineDetails_X.i, ML_Coordinate_Movies_Entry_LineDetails_Y.i, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, ImageID(10001))
    ImageGadget(202, ML_Coordinate_Movies_Entry_LineDetails_X.i, ML_Coordinate_Movies_Entry_LineDetails_Y.i + 45, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, ImageID(10003))
    ImageGadget(203, ML_Coordinate_Movies_Entry_LineDetails_X.i, ML_Coordinate_Movies_Entry_LineDetails_Y.i + 90, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, ImageID(10005))
    ImageGadget(204, ML_Coordinate_Movies_Entry_LineDetails_X.i, ML_Coordinate_Movies_Entry_LineDetails_Y.i + 135, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, ImageID(10007))
    ImageGadget(205, ML_Coordinate_Movies_Entry_LineDetails_X.i, ML_Coordinate_Movies_Entry_LineDetails_Y.i + 180, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, ImageID(10009))
    ImageGadget(206, ML_Coordinate_Movies_Entry_LineDetails_X.i, ML_Coordinate_Movies_Entry_LineDetails_Y.i + 225, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, ImageID(10011))
    ImageGadget(207, ML_Coordinate_Movies_Entry_LineDetails_X.i, ML_Coordinate_Movies_Entry_LineDetails_Y.i + 270, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, ImageID(10013))
    ImageGadget(208, ML_Coordinate_Movies_Entry_LineDetails_X.i, ML_Coordinate_Movies_Entry_LineDetails_Y.i + 315, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, ImageID(10015))
    ImageGadget(209, ML_Coordinate_Movies_Entry_LineDetails_X.i, ML_Coordinate_Movies_Entry_LineDetails_Y.i + 360, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, ImageID(10017))
    ImageGadget(210, ML_Coordinate_Movies_Entry_LineDetails_X.i, ML_Coordinate_Movies_Entry_LineDetails_Y.i + 405, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, ImageID(10019))
    ImageGadget(211, ML_Coordinate_Movies_Entry_LineDetails_X.i, ML_Coordinate_Movies_Entry_LineDetails_Y.i + 450, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, ImageID(10021))
    ImageGadget(212, ML_Coordinate_Movies_Entry_LineDetails_X.i, ML_Coordinate_Movies_Entry_LineDetails_Y.i + 495, ML_Coordinate_Movies_Entry_LineDetails_W.i, ML_Coordinate_Movies_Entry_LineDetails_H.i, ImageID(10023))
    
    ;}
    
    If Buttons.i = 1
      
      ButtonGadget(1, -42, 110, 42, 42, "1")
      ButtonGadget(2, -42, 152, 42, 42, "2")
      ButtonGadget(3, -42, 194, 42, 42, "3")
      ButtonGadget(4, -42, 236, 42, 42, "4")
      ButtonGadget(5, -42, 278, 42, 42, "5")
      
    EndIf
    
    Start.i = ElapsedMilliseconds()
    Speed.i = 5
    
  Repeat
    
    Event.i = WaitWindowEvent()
    Time.i = ElapsedMilliseconds() - Start.i
    
    ;{ Menu
    
    Select ML_Settings_Menu.i
      
      Case #ML_Menu_Start
        
        ;{ Menu
        
        If ML_MouseOver(1, 10, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Start
          
        ElseIf ML_MouseOver(1, 160, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Movies
          
        ElseIf ML_MouseOver(1, 310, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Series
          
        ElseIf ML_MouseOver(1, 460, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Games
          
        ElseIf ML_MouseOver(1, 600, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Settings
          
        ElseIf ML_MouseOver(1, 750, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Informations
          
        EndIf
        
        ;}
        
        ;{ GFX
        
        StartDrawing(WindowOutput(1))
          
          ML_DrawImage_Navi_Design()
          
          DrawImage(ImageID(100), ML_Coordinate_SubNaviTitle_X.i, ML_Coordinate_SubNaviTitle_Y.i)
          DrawImage(ImageID(101), ML_Coordinate_SubNaviOne_X.i, ML_Coordinate_SubNaviOne_Y.i)
          DrawImage(ImageID(103), ML_Coordinate_SubNaviTwo_X.i, ML_Coordinate_SubNaviTwo_Y.i)
          DrawImage(ImageID(105), ML_Coordinate_SubNaviThree_X.i, ML_Coordinate_SubNaviThree_Y.i)
          DrawImage(ImageID(107), ML_Coordinate_SubNaviFour_X.i, ML_Coordinate_SubNaviFour_Y.i)
          DrawImage(ImageID(109), ML_Coordinate_SubNaviFive_X.i, ML_Coordinate_SubNaviFive_Y.i)
          DrawImage(ImageID(220), ML_Coordinate_SubNaviEnd_X.i, ML_Coordinate_SubNaviEnd_Y.i)
          
        StopDrawing()
        
        ;}
        
        ML_Movies_Line(1)
        ML_Movies_LineDetails(1)
        
      Case #ML_Menu_Movies
        
        ;{ Menu
        
        If ML_MouseOver(1, 10, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Start
          
        ElseIf ML_MouseOver(1, 160, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Movies
          
        ElseIf ML_MouseOver(1, 310, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Series
          
        ElseIf ML_MouseOver(1, 460, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Games
          
        ElseIf ML_MouseOver(1, 600, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Settings
          
        ElseIf ML_MouseOver(1, 750, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Informations
          
        EndIf
        
        ;}
        
        ;{ GFX
        
        StartDrawing(WindowOutput(1))
          
          ML_DrawImage_Navi_Design()
          
          DrawImage(ImageID(120), ML_Coordinate_SubNaviTitle_X.i, ML_Coordinate_SubNaviTitle_Y.i)
          If WindowMouseX(1) > ML_Coordinate_SubNaviOne_X.i And WindowMouseX(1) < (ML_Coordinate_SubNaviOne_X.i + ML_Coordinate_SubNaviOne_W.i) And WindowMouseY(1) > (ML_Coordinate_SubNaviOne_Y.i + 6) And WindowMouseY(1) < (ML_Coordinate_SubNaviOne_Y.i + ML_Coordinate_SubNaviOne_H.i) : DrawImage(ImageID(122), ML_Coordinate_SubNaviOne_X.i, ML_Coordinate_SubNaviOne_Y.i) : Else : DrawImage(ImageID(121), ML_Coordinate_SubNaviOne_X.i, ML_Coordinate_SubNaviOne_Y.i) : EndIf
          If WindowMouseX(1) > ML_Coordinate_SubNaviTwo_X.i And WindowMouseX(1) < (ML_Coordinate_SubNaviTwo_X.i + ML_Coordinate_SubNaviTwo_W.i) And WindowMouseY(1) > (ML_Coordinate_SubNaviTwo_Y.i + 6) And WindowMouseY(1) < (ML_Coordinate_SubNaviTwo_Y.i + ML_Coordinate_SubNaviTwo_H.i) : DrawImage(ImageID(124), ML_Coordinate_SubNaviTwo_X.i, ML_Coordinate_SubNaviTwo_Y.i) : Else : DrawImage(ImageID(123), ML_Coordinate_SubNaviTwo_X.i, ML_Coordinate_SubNaviTwo_Y.i) : EndIf
          If WindowMouseX(1) > ML_Coordinate_SubNaviThree_X.i And WindowMouseX(1) < (ML_Coordinate_SubNaviThree_X.i + ML_Coordinate_SubNaviThree_W.i) And WindowMouseY(1) > (ML_Coordinate_SubNaviThree_Y.i + 6) And WindowMouseY(1) < (ML_Coordinate_SubNaviThree_Y.i + ML_Coordinate_SubNaviThree_H.i) : DrawImage(ImageID(126), ML_Coordinate_SubNaviThree_X.i, ML_Coordinate_SubNaviThree_Y.i) : Else : DrawImage(ImageID(125), ML_Coordinate_SubNaviThree_X.i, ML_Coordinate_SubNaviThree_Y.i) : EndIf
          If WindowMouseX(1) > ML_Coordinate_SubNaviFour_X.i And WindowMouseX(1) < (ML_Coordinate_SubNaviFour_X.i + ML_Coordinate_SubNaviFour_W.i) And WindowMouseY(1) > (ML_Coordinate_SubNaviFour_Y.i + 6) And WindowMouseY(1) < (ML_Coordinate_SubNaviFour_Y.i + ML_Coordinate_SubNaviFour_H.i) : DrawImage(ImageID(128), ML_Coordinate_SubNaviFour_X.i, ML_Coordinate_SubNaviFour_Y.i) : Else : DrawImage(ImageID(127), ML_Coordinate_SubNaviFour_X.i, ML_Coordinate_SubNaviFour_Y.i) : EndIf
          If WindowMouseX(1) > ML_Coordinate_SubNaviFive_X.i And WindowMouseX(1) < (ML_Coordinate_SubNaviFive_X.i + ML_Coordinate_SubNaviFive_W.i) And WindowMouseY(1) > (ML_Coordinate_SubNaviFive_Y.i + 6) And WindowMouseY(1) < (ML_Coordinate_SubNaviFive_Y.i + ML_Coordinate_SubNaviFive_H.i) : DrawImage(ImageID(130), ML_Coordinate_SubNaviFive_X.i, ML_Coordinate_SubNaviFive_Y.i) : Else : DrawImage(ImageID(129), ML_Coordinate_SubNaviFive_X.i, ML_Coordinate_SubNaviFive_Y.i) : EndIf
          DrawImage(ImageID(220), ML_Coordinate_SubNaviEnd_X.i, ML_Coordinate_SubNaviEnd_Y.i)
          
          DrawingFont(FontID(10))
          DrawText(ML_Coordinate_Movies_Count_X.i, ML_Coordinate_Movies_Count_Y.i, "(" + Str(ML_Movies_Count.i) + ")", RGB(255, 255, 255), RGB(0, 0, 0))
          
        StopDrawing()
        
        ;}
        
        ;{ ImageGadget
        
        Select ML_Settings_Movies_Entry_View.i
          
          Case 0
            
            ML_Movies_Line(0)
            ML_Movies_LineDetails(1)
            
          Case 1
            
            ML_Movies_Line(1)
            ML_Movies_LineDetails(0)
            
        EndSelect
        
        ;}
        
        ML_Movies_Entry_MouseOver()
        
      Case #ML_Menu_Series
        
        ;{ Menu
        
        If ML_MouseOver(1, 10, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Start
          
        ElseIf ML_MouseOver(1, 160, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Movies
          
        ElseIf ML_MouseOver(1, 310, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Series
          
        ElseIf ML_MouseOver(1, 460, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Games
          
        ElseIf ML_MouseOver(1, 600, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Settings
          
        ElseIf ML_MouseOver(1, 750, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Informations
          
        EndIf
        
        ;}
        
        ;{ GFX
        
        StartDrawing(WindowOutput(1))
          
          ML_DrawImage_Navi_Design()
          
          DrawImage(ImageID(140), ML_Coordinate_SubNaviTitle_X.i, ML_Coordinate_SubNaviTitle_Y.i)
          If WindowMouseX(1) > ML_Coordinate_SubNaviOne_X.i And WindowMouseX(1) < (ML_Coordinate_SubNaviOne_X.i + ML_Coordinate_SubNaviOne_W.i) And WindowMouseY(1) > (ML_Coordinate_SubNaviOne_Y.i + 6) And WindowMouseY(1) < (ML_Coordinate_SubNaviOne_Y.i + ML_Coordinate_SubNaviOne_H.i) : DrawImage(ImageID(142), ML_Coordinate_SubNaviOne_X.i, ML_Coordinate_SubNaviOne_Y.i) : Else : DrawImage(ImageID(141), ML_Coordinate_SubNaviOne_X.i, ML_Coordinate_SubNaviOne_Y.i) : EndIf
          If WindowMouseX(1) > ML_Coordinate_SubNaviTwo_X.i And WindowMouseX(1) < (ML_Coordinate_SubNaviTwo_X.i + ML_Coordinate_SubNaviTwo_W.i) And WindowMouseY(1) > (ML_Coordinate_SubNaviTwo_Y.i + 6) And WindowMouseY(1) < (ML_Coordinate_SubNaviTwo_Y.i + ML_Coordinate_SubNaviTwo_H.i) : DrawImage(ImageID(144), ML_Coordinate_SubNaviTwo_X.i, ML_Coordinate_SubNaviTwo_Y.i) : Else : DrawImage(ImageID(143), ML_Coordinate_SubNaviTwo_X.i, ML_Coordinate_SubNaviTwo_Y.i) : EndIf
          If WindowMouseX(1) > ML_Coordinate_SubNaviThree_X.i And WindowMouseX(1) < (ML_Coordinate_SubNaviThree_X.i + ML_Coordinate_SubNaviThree_W.i) And WindowMouseY(1) > (ML_Coordinate_SubNaviThree_Y.i + 6) And WindowMouseY(1) < (ML_Coordinate_SubNaviThree_Y.i + ML_Coordinate_SubNaviThree_H.i) : DrawImage(ImageID(146), ML_Coordinate_SubNaviThree_X.i, ML_Coordinate_SubNaviThree_Y.i) : Else : DrawImage(ImageID(145), ML_Coordinate_SubNaviThree_X.i, ML_Coordinate_SubNaviThree_Y.i) : EndIf
          If WindowMouseX(1) > ML_Coordinate_SubNaviFour_X.i And WindowMouseX(1) < (ML_Coordinate_SubNaviFour_X.i + ML_Coordinate_SubNaviFour_W.i) And WindowMouseY(1) > (ML_Coordinate_SubNaviFour_Y.i + 6) And WindowMouseY(1) < (ML_Coordinate_SubNaviFour_Y.i + ML_Coordinate_SubNaviFour_H.i) : DrawImage(ImageID(148), ML_Coordinate_SubNaviFour_X.i, ML_Coordinate_SubNaviFour_Y.i) : Else : DrawImage(ImageID(147), ML_Coordinate_SubNaviFour_X.i, ML_Coordinate_SubNaviFour_Y.i) : EndIf
          DrawImage(ImageID(149), ML_Coordinate_SubNaviFive_X.i, ML_Coordinate_SubNaviFive_Y.i)
          DrawImage(ImageID(220), ML_Coordinate_SubNaviEnd_X.i, ML_Coordinate_SubNaviEnd_Y.i)
          
        StopDrawing()
        
        ;}
        
        ML_Movies_Line(1)
        ML_Movies_LineDetails(1)
        
      Case #ML_Menu_Games
        
        ;{ Menu
        
        If ML_MouseOver(1, 10, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Start
          
        ElseIf ML_MouseOver(1, 160, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Movies
          
        ElseIf ML_MouseOver(1, 310, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Series
          
        ElseIf ML_MouseOver(1, 460, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Games
          
        ElseIf ML_MouseOver(1, 600, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Settings
          
        ElseIf ML_MouseOver(1, 750, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Informations
          
        EndIf
        
        ;}
        
        ;{ GFX
        
        StartDrawing(WindowOutput(1))
          
          ML_DrawImage_Navi_Design()
          
          DrawImage(ImageID(160), ML_Coordinate_SubNaviTitle_X.i, ML_Coordinate_SubNaviTitle_Y.i)
          If WindowMouseX(1) > ML_Coordinate_SubNaviOne_X.i And WindowMouseX(1) < (ML_Coordinate_SubNaviOne_X.i + ML_Coordinate_SubNaviOne_W.i) And WindowMouseY(1) > (ML_Coordinate_SubNaviOne_Y.i + 6) And WindowMouseY(1) < (ML_Coordinate_SubNaviOne_Y.i + ML_Coordinate_SubNaviOne_H.i) : DrawImage(ImageID(162), ML_Coordinate_SubNaviOne_X.i, ML_Coordinate_SubNaviOne_Y.i) : Else : DrawImage(ImageID(161), ML_Coordinate_SubNaviOne_X.i, ML_Coordinate_SubNaviOne_Y.i) : EndIf
          If WindowMouseX(1) > ML_Coordinate_SubNaviTwo_X.i And WindowMouseX(1) < (ML_Coordinate_SubNaviTwo_X.i + ML_Coordinate_SubNaviTwo_W.i) And WindowMouseY(1) > (ML_Coordinate_SubNaviTwo_Y.i + 6) And WindowMouseY(1) < (ML_Coordinate_SubNaviTwo_Y.i + ML_Coordinate_SubNaviTwo_H.i) : DrawImage(ImageID(164), ML_Coordinate_SubNaviTwo_X.i, ML_Coordinate_SubNaviTwo_Y.i) : Else : DrawImage(ImageID(163), ML_Coordinate_SubNaviTwo_X.i, ML_Coordinate_SubNaviTwo_Y.i) : EndIf
          If WindowMouseX(1) > ML_Coordinate_SubNaviThree_X.i And WindowMouseX(1) < (ML_Coordinate_SubNaviThree_X.i + ML_Coordinate_SubNaviThree_W.i) And WindowMouseY(1) > (ML_Coordinate_SubNaviThree_Y.i + 6) And WindowMouseY(1) < (ML_Coordinate_SubNaviThree_Y.i + ML_Coordinate_SubNaviThree_H.i) : DrawImage(ImageID(166), ML_Coordinate_SubNaviThree_X.i, ML_Coordinate_SubNaviThree_Y.i) : Else : DrawImage(ImageID(165), ML_Coordinate_SubNaviThree_X.i, ML_Coordinate_SubNaviThree_Y.i) : EndIf
          If WindowMouseX(1) > ML_Coordinate_SubNaviFour_X.i And WindowMouseX(1) < (ML_Coordinate_SubNaviFour_X.i + ML_Coordinate_SubNaviFour_W.i) And WindowMouseY(1) > (ML_Coordinate_SubNaviFour_Y.i + 6) And WindowMouseY(1) < (ML_Coordinate_SubNaviFour_Y.i + ML_Coordinate_SubNaviFour_H.i) : DrawImage(ImageID(168), ML_Coordinate_SubNaviFour_X.i, ML_Coordinate_SubNaviFour_Y.i) : Else : DrawImage(ImageID(167), ML_Coordinate_SubNaviFour_X.i, ML_Coordinate_SubNaviFour_Y.i) : EndIf
          DrawImage(ImageID(169), ML_Coordinate_SubNaviFive_X.i, ML_Coordinate_SubNaviFive_Y.i)
          DrawImage(ImageID(220), ML_Coordinate_SubNaviEnd_X.i, ML_Coordinate_SubNaviEnd_Y.i)
          
        StopDrawing()
        
        ;}
        
        ML_Movies_Line(1)
        ML_Movies_LineDetails(1)
        
      Case #ML_Menu_Settings
        
        ;{ Menu
        
        If ML_MouseOver(1, 10, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Start
          
        ElseIf ML_MouseOver(1, 160, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Movies
          
        ElseIf ML_MouseOver(1, 310, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Series
          
        ElseIf ML_MouseOver(1, 460, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Games
          
        ElseIf ML_MouseOver(1, 600, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Settings
          
        ElseIf ML_MouseOver(1, 750, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Informations
          
        EndIf
        
        ;}
        
        ;{ GFX
        
        StartDrawing(WindowOutput(1))
          
          ML_DrawImage_Navi_Design()
          
          DrawImage(ImageID(180), ML_Coordinate_SubNaviTitle_X.i, ML_Coordinate_SubNaviTitle_Y.i)
          If WindowMouseX(1) > ML_Coordinate_SubNaviOne_X.i And WindowMouseX(1) < (ML_Coordinate_SubNaviOne_X.i + ML_Coordinate_SubNaviOne_W.i) And WindowMouseY(1) > (ML_Coordinate_SubNaviOne_Y.i + 6) And WindowMouseY(1) < (ML_Coordinate_SubNaviOne_Y.i + ML_Coordinate_SubNaviOne_H.i) : DrawImage(ImageID(182), ML_Coordinate_SubNaviOne_X.i, ML_Coordinate_SubNaviOne_Y.i) : Else : DrawImage(ImageID(181), ML_Coordinate_SubNaviOne_X.i, ML_Coordinate_SubNaviOne_Y.i) : EndIf
          DrawImage(ImageID(183), ML_Coordinate_SubNaviTwo_X.i, ML_Coordinate_SubNaviTwo_Y.i)
          DrawImage(ImageID(185), ML_Coordinate_SubNaviThree_X.i, ML_Coordinate_SubNaviThree_Y.i)
          DrawImage(ImageID(187), ML_Coordinate_SubNaviFour_X.i, ML_Coordinate_SubNaviFour_Y.i)
          DrawImage(ImageID(189), ML_Coordinate_SubNaviFive_X.i, ML_Coordinate_SubNaviFive_Y.i)
          DrawImage(ImageID(220), ML_Coordinate_SubNaviEnd_X.i, ML_Coordinate_SubNaviEnd_Y.i)
          
        StopDrawing()
        
        ;}
        
        ML_Movies_Line(1)
        ML_Movies_LineDetails(1)
        
      Case #ML_Menu_Informations
        
        ;{ Menu
        
        If ML_MouseOver(1, 10, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Start
          
        ElseIf ML_MouseOver(1, 160, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Movies
          
        ElseIf ML_MouseOver(1, 310, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Series
          
        ElseIf ML_MouseOver(1, 460, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Games
          
        ElseIf ML_MouseOver(1, 600, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Settings
          
        ElseIf ML_MouseOver(1, 750, 10, 140, 25) And ML_Mouse_LeftClick()
          
          ML_Settings_Menu.i = #ML_Menu_Informations
          
        EndIf
        
        ;}
        
        ;{ GFX
        
        StartDrawing(WindowOutput(1))
          
          ML_DrawImage_Navi_Design()
          
          DrawImage(ImageID(200), ML_Coordinate_SubNaviTitle_X.i, ML_Coordinate_SubNaviTitle_Y.i)
          If WindowMouseX(1) > ML_Coordinate_SubNaviOne_X.i And WindowMouseX(1) < (ML_Coordinate_SubNaviOne_X.i + ML_Coordinate_SubNaviOne_W.i) And WindowMouseY(1) > (ML_Coordinate_SubNaviOne_Y.i + 6) And WindowMouseY(1) < (ML_Coordinate_SubNaviOne_Y.i + ML_Coordinate_SubNaviOne_H.i) : DrawImage(ImageID(202), ML_Coordinate_SubNaviOne_X.i, ML_Coordinate_SubNaviOne_Y.i) : Else : DrawImage(ImageID(201), ML_Coordinate_SubNaviOne_X.i, ML_Coordinate_SubNaviOne_Y.i) : EndIf
          DrawImage(ImageID(203), ML_Coordinate_SubNaviTwo_X.i, ML_Coordinate_SubNaviTwo_Y.i)
          DrawImage(ImageID(205), ML_Coordinate_SubNaviThree_X.i, ML_Coordinate_SubNaviThree_Y.i)
          DrawImage(ImageID(207), ML_Coordinate_SubNaviFour_X.i, ML_Coordinate_SubNaviFour_Y.i)
          DrawImage(ImageID(209), ML_Coordinate_SubNaviFive_X.i, ML_Coordinate_SubNaviFive_Y.i)
          DrawImage(ImageID(220), ML_Coordinate_SubNaviEnd_X.i, ML_Coordinate_SubNaviEnd_Y.i)
          
        StopDrawing()
        
        ;}
        
        ML_Movies_Line(1)
        ML_Movies_LineDetails(1)
        
    EndSelect
    
    ;}
    
    ;{ Slide-Buttons
    
    If Buttons.i = 1 And Time.i < 15000
      
      cox1 = Time.i / Speed.i
      cox2 = Time.i / Speed.i
      cox3 = Time.i / Speed.i
      cox4 = Time.i / Speed.i
      cox5 = Time.i / Speed.i
      
      If cox1 < 84
        
        cox1 - 42
        ResizeGadget(1, cox1, #PB_Ignore, #PB_Ignore, #PB_Ignore)
        
      EndIf
      
      If cox1 >= 84 And cox2 < 126
        
        cox2 - 84
        ResizeGadget(2, cox2, #PB_Ignore, #PB_Ignore, #PB_Ignore)
        
      EndIf
      
      If cox2 >= 126 And cox3 < 168
        
        cox3 - 126
        ResizeGadget(3, cox3, #PB_Ignore, #PB_Ignore, #PB_Ignore)
        
      EndIf
      
      If cox3 >= 168 And cox4 < 210
        
        cox4 - 168
        ResizeGadget(4, cox4, #PB_Ignore, #PB_Ignore, #PB_Ignore)
        
      EndIf
      
      If cox4 >= 210 And cox5 < 252
        
        cox5 - 210
        ResizeGadget(5, cox5, #PB_Ignore, #PB_Ignore, #PB_Ignore)
        
      EndIf
      
    EndIf
    
    ;}
    
    ;{ Select
    
    Select Event.i
      
      Case #PB_Event_Menu
        
        Select EventMenu()
          
          Case 9999
            
            If ML_Settings_Shortcut_Esc.s = "Quit" : CloseWindow(1) : Break : EndIf
            If ML_Settings_Shortcut_Esc.s = "Minimize" : SetWindowState(1, #PB_Window_Minimize) : EndIf
            
          Case 9998
            
            If ML_Settings_Navi_Design.i = 1 Or ML_Settings_Navi_Design.i = 2 : ML_Settings_Navi_Design.i = 0 : EndIf
            
          Case 9997
            
            If ML_Settings_Navi_Design.i = 0 Or ML_Settings_Navi_Design.i = 2 : ML_Settings_Navi_Design.i = 1 : EndIf
            
          Case 9996
            
            If ML_Settings_Navi_Design.i = 0 Or ML_Settings_Navi_Design.i = 1 : ML_Settings_Navi_Design.i = 2 : EndIf
            
          Case 9991
            
            If ML_Settings_Movies_Entry_View.i = 1 : ML_Settings_Movies_Entry_View.i = 0 : EndIf
            
          Case 9990
            
            If ML_Settings_Movies_Entry_View.i = 0 : ML_Settings_Movies_Entry_View.i = 1 : EndIf
            
        EndSelect
      
      Case #PB_Event_CloseWindow
        
        CloseWindow(1) : Break
      
    EndSelect
    
    ;}
    
  Until Event.i = #PB_Event_CloseWindow
  
Else
  
  ML_Msg_Error(ML_Error_InitWindow.s)
  
EndIf

EndProcedure

;}

;{ =====[Media Library - Execute]=====

ML_Init()
ML_List_Movies_Init()

;{ -----[Test]-----

ML_Func_Movies("LoadMovies")

ML_Func_SQL("CreateDatabase", 0, "Data\Media Library.sqlite", 0)
ML_Func_SQL("CreateTables", 0, "Data\Media Library.sqlite", 0)
;ML_Func_SQL("AddEntry", 0, "Data\Media Library.sqlite", 0, "", "", "INSERT INTO ml_movies (title, release, length, agerating, genre, studio, regie, actor, role, plot, language) VALUES ('16 Blocks', '2006', '102', '12', 'Action, Crime, Drama', 'Warner Bros. Pictures, Millennium Films', 'Richard Donner', 'Bruce Willis, Mos Def, David Morse, Jenna Stern, Casey Sander, Cylk Cozart, David Zayas, Sasha Roiz, Peter McRobbie, Robert Clohessy, Kim Chan', 'Jack Mosley, Eddie Bunker, Frank Nugent, Diane Mosley, Captain Gruber, Jimmy Mulvey, Robert Torres, Kaller, Mike Sheehan, Cannova, Sam', '...', 'Ger, Eng')")
;ML_Func_SQL("AddEntry", 0, "Data\Media Library.sqlite", 0, "", "", "INSERT INTO ml_movies (title, release, length, agerating, genre, studio, regie, actor, role, plot, language) VALUES ('A Clockwork Orange - Uhrwerk Orange', '1971', '131', '16', 'Crime, Drama, Sci-Fi', 'Warner Bros. Pictures, Hawk Films', 'Stanley Kubrick', 'Malcolm MacDowell, Patrick Magee, Adrienne Corri, Michael Bates, Warren Clarke, James Marcus, Michael Tarn, Carl Duering, Paul Farrell, Miriam Karlin, Philip Stone, Sheila Reynor, Aubrey Morris, Godfrey Quigley, Clive Francis, David Prowse, Steven Berkoff, Anthony Sharp, Michael Gover, Madge Ryan, John Savident, Carol Drinkwater', 'Alexander DeLarge, Mr Alexander, Mrs Alexander, Hauptwachtmeister, Dim, Georgie, Pete, Dr Brodsky, Obdachloser, Katzenlady, Mr DeLarge, Mrs DeLarge, Mr Deltoid, Gefängniskaplan, Untermieter Joe, Julian, Constable, Innenminister, Gefängnisdirektor, Dr Branom, Verschwörer, Krankenschwester Feeley', '...', 'Ger, Eng')")
;ML_Func_SQL("LoadMovies", 0, "Data\Media Library.sqlite", 0)

;ML_Func_Movies("LoadMoviesByGenre", 0, "", "", "", "", "Action")
;ML_Func_Movies("LoadMoviesByGenre", 0, "", "", "", "", "Comedy")
;ML_Func_Movies("LoadMoviesByGenre", 0, "", "", "", "", "Crime")
;ML_Func_Movies("LoadMoviesByGenre", 0, "", "", "", "", "Thriller")
;ML_Func_Movies("LoadMoviesByGenre", 0, "", "", "", "", "Crime, Thriller")
;ML_Func_Movies("LoadMoviesByActor", 0, "", "", "", "", "", "", "", "Adam Sandler")
;ML_Func_Movies("LoadMoviesByActor", 0, "", "", "", "", "", "", "", "Julia Stiles")

;ML_Func_Movies("ListMoviesQuery", 0, "", "Pie")
;ML_Func_Movies("ListMoviesQuery", 0, "", "2001")
;ML_Func_Movies("ListMoviesQuery", 0, "", "", "102")
;ML_Func_Movies("ListMoviesQuery", 0, "", "", "", "12")
;ML_Func_Movies("ListMoviesQuery", 0, "", "", "", "", "Adventure")
;ML_Func_Movies("ListMoviesQuery", 0, "", "", "", "", "Thriller, Crime")
;ML_Func_Movies("ListMoviesQuery", 0, "", "", "", "", "Sci-Fi, Action, Adventure")
;ML_Func_Movies("ListMoviesQuery", 0, "", "", "", "", "", "Warner")
;ML_Func_Movies("ListMoviesQuery", 0, "", "", "", "", "", "", "Donner")
;ML_Func_Movies("ListMoviesQuery", 0, "", "", "", "", "", "", "", "Bruce Willis")
;ML_Func_Movies("ListMoviesQuery", 0, "", "", "", "", "", "", "", "Franka Potente, Matt Damon")
;ML_Func_Movies("ListMoviesQuery", 0, "", "", "", "", "", "", "", "Chris Klein, Jason Biggs, Thomas Ian Nicholas")
;ML_Func_Movies("ListMoviesQueryInfoComplete")

;}

;ML_SubNavi_Init()
;ML_Window()

;CLMF("ExportLog", 1, "", "", 0, 0, 0, 0, 0, "", "Log\Media Library.log")
;CLMF("ExportLogPDF", 1, "", "", 0, 0, 0, 0, 0, "", "Log\Media Library.pdf")
;CLMF("Debug")

;}

; IDE Options = PureBasic 5.40 LTS (Windows - x86)
; Folding = AAAAAAAAAAAAAAAAAAAAAA9
; EnableAsm
; EnableUnicode
; EnableThread
; EnableXP
; Executable = Media Library.exe
; Compiler = PureBasic 5.40 LTS (Windows - x64)
; Warnings = Display
; EnableCompileCount = 1934
; EnableBuildCount = 13
; EnableExeConstant