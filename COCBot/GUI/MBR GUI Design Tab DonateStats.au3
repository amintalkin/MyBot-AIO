; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design
; Description ...: This file Includes GUI Design
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Cutidudz (2016)
; Modified ......: TheRevenor (2016)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
$hGUI_DonateStats = GUICreate("", $_GUI_MAIN_WIDTH - 28, $_GUI_MAIN_HEIGHT - 255 - 28, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $hGUI_MOD)
;GUISetBkColor($COLOR_ORANGE, $hGUI_DonateStats)

;~ -------------------------------------------------------------
;~ DonateStats Tab
;~ -------------------------------------------------------------
#include <ListViewConstants.au3>
#include <GuiListView.au3>

Global $ImageList, $lvDonatedTroops, $DonateFile, $bm1, $bm2, $iChkDStats, $DonatedValue = 0, $iImageCompare = False, $ImageExist = "", $aFileList

	Local $tabDonateStats = GUICtrlCreateTabItem("Donate Stats")
	Local $x = 20, $y = 25
	$lvDonatedTroops = GUICtrlCreateListView("Name|Barbarians|Archers|Giants|Goblins|Wall Breakers|Balloons|Wizards|Healers|Dragons|Pekkas|Minions|Hog Riders|Valkyries|Golems|Witches|Lava Hounds|Bowlers|Poison Spells|Earthquake Spells|Haste Spells", $x - 20, $y, 443, 342, $LVS_REPORT) ; $x - 25, $y, 459, 363
	_GUICtrlListView_SetExtendedListViewStyle($lvDonatedTroops, $LVS_EX_GRIDLINES+$LVS_EX_FULLROWSELECT)
	_GUICtrlListView_SetColumnWidth($lvDonatedTroops, 0, 140) ;139

	Local $chkDStats = GUICtrlCreateCheckbox("Enable", $x + 290, $y - 24, 50, 20) ;310
	$DonateStatsReset = GUICtrlCreateButton("Reset Stats", $x + 346, $y - 24, 60, 20) ; 336
	GUICtrlSetOnEvent(-1, "InitDonateStats")
	
	_GUICtrlListView_SetExtendedListViewStyle(-1, $WS_EX_TOPMOST + $WS_EX_TRANSPARENT)

	For $x = 0 To 22
		_GUICtrlListView_JustifyColumn($lvDonatedTroops, $x, 2) ; Center text in all columns
	Next
	InitDonateStats()

GUICtrlCreateGroup("", -99, -99, 1, 1)
;GUICtrlCreateTabItem("")
