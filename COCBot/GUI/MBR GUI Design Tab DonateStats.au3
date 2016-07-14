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

Global $ImageList, $lvDonatedTroops, $chkLimitDStats, $iLimitDStats, $lblCurDonate, $DonateFile, $bm1, $bm2, $iChkDStats, $DonatedValue = 0, $iImageCompare = False, $ImageExist = "", $aFileList

Local $tabDonateStats = GUICtrlCreateTabItem("Donate Stats")
Local $x = 20, $y = 25

$lvDonatedTroops = GUICtrlCreateListView("Name|Barbarians|Archers|Giants|Goblins|Wall Breakers|Balloons|Wizards|Healers|Dragons|Pekkas|Minions|Hog Riders|Valkyries|Golems|Witches|Lava Hounds|Bowlers|Poison Spells|Earthquake Spells|Haste Spells", $x - 20, $y, 443, 342, $LVS_REPORT)
_GUICtrlListView_SetExtendedListViewStyle($lvDonatedTroops, $LVS_EX_GRIDLINES+$LVS_EX_FULLROWSELECT)
_GUICtrlListView_SetColumnWidth($lvDonatedTroops, 0, 139)

GUICtrlCreateLabel("Current Donations:", $x - 18, $y - 20, 90, 20)
$txtTip = "Current Donations of All Troops"
	GUICtrlSetTip(-1, $txtTip)
$lblCurDonate = GUICtrlCreateLabel("0", $x + 73, $y - 20, 40, 20, $SS_LEFT)
GUICtrlSetColor(-1, 0x7C00CE)
$txtTip = "Number of Total Donations of All Troops"
	GUICtrlSetTip(-1, $txtTip)
$chkLimitDStats = GUICtrlCreateCheckbox("Stop Donation After:", $x + 130, $y - 22, 111, 20)
$txtTip = "Check This to Automatically STOP Donations as You Want"
	GUICtrlSetTip(-1, $txtTip)
$iLimitDStats = GUICtrlCreateInput("5000", $x + 248, $y - 22, 37, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 4)
	GUICtrlSetColor(-1, 0xFF05BD)
	$txtTip = "Number of Max Limit Donations, If it reaches the max donations, Then the bot will STOP donations"
	GUICtrlSetTip(-1, $txtTip)

Local $chkDStats = GUICtrlCreateCheckbox("Enable", $x + 300, $y - 22, 50, 20)
$DonateStatsReset = GUICtrlCreateButton("ResetDStats", $x + 355, $y - 22, 65, 20)
_GUICtrlListView_SetExtendedListViewStyle(-1, $WS_EX_TOPMOST + $WS_EX_TRANSPARENT)
GUICtrlSetOnEvent(-1, "InitDonateStats")

For $x = 0 To 22
	_GUICtrlListView_JustifyColumn($lvDonatedTroops, $x, 2) ; Center text in all columns
Next
InitDonateStats()

GUICtrlCreateGroup("", -99, -99, 1, 1)
;GUICtrlCreateTabItem("")
