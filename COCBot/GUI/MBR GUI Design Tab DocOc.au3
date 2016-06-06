; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design Tab DocOc
; Description ...: This file Includes GUI Design
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: LunaEclipse(April, 2016)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
$hGUI_ModDocOc = GUICreate("", $_GUI_MAIN_WIDTH - 28, $_GUI_MAIN_HEIGHT - 255 - 28, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $hGUI_MOD)
GUISetBkColor($COLOR_WHITE, $hGUI_ModDocOc)

GUISwitch($hGUI_ModDocOc)
;$tabDocOc = GUICtrlCreateTabItem("Doc Oc")
	; Simulate Sleep Settings
	;Local $x = 35, $y = 150
	Local $x = 20, $y = 25
	$grpSleep = GUICtrlCreateGroup("Simulate Sleep", $x - 20, $y - 20, 438, 90)
		$chkUseSleep = GUICtrlCreateCheckbox("Enable Sleep Mode", $x + 50, $y - 5, -1, -1)
			$txtTip = "Enable this option to cause the bot to log out for an extended period to simulate sleeping." & @CRLF & @CRLF & _
				      "     Doctor's Recommendation: Use this setting, with at least 8 hours sleep."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkUseSleep")
		$lblStartSleep = GUICtrlCreateLabel("Start Time: ", $x + 150, $y, 90, -1, $SS_RIGHT)
		$cmbStartSleep = GUICtrlCreateCombo("", $x + 250, $y - 3, 60, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Select the hour you wish the bot to start its sleep cycle." & @CRLF & _
				      "     This time can be offset by +/- 30 mins." & @CRLF & @CRLF & _
				      "     Doctor's Recommendation: Minimum of 8 hours between start and finish."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "12 AM|  1 AM|  2 AM|  3 AM|  4 AM|  5 AM|  6 AM|  7 AM|  8 AM|  9 AM|10 AM|11 AM|12 PM|  1 PM|  2 PM|  3 PM|  4 PM|  5 PM|  6 PM|  7 PM|  8 PM|  9 PM|10 PM|11 PM", "12 AM")
			GUICtrlSetOnEvent(-1, "cmbStartSleep")
		$lblEndSleep = GUICtrlCreateLabel("End Time: ", $x + 150, $y + 26, 90, -1, $SS_RIGHT)
		$cmbEndSleep = GUICtrlCreateCombo("", $x + 250, $y + 23, 60, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Select the hour you wish the bot to finish its sleep cycle." & @CRLF & _
				      "     This time can be offset by +/- 30 mins." & @CRLF & @CRLF & _
				      "     Doctor's Recommendation: Minimum of 8 hours between start and finish."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "12 AM|  1 AM|  2 AM|  3 AM|  4 AM|  5 AM|  6 AM|  7 AM|  8 AM|  9 AM|10 AM|11 AM|12 PM|  1 PM|  2 PM|  3 PM|  4 PM|  5 PM|  6 PM|  7 PM|  8 PM|  9 PM|10 PM|11 PM", "  8 AM")
			GUICtrlSetOnEvent(-1, "cmbEndSleep")
		$lblTotalSleep = GUICtrlCreateLabel("Estimated Sleep Time: 7 - 9 Hours", $x + 50, $y + 50, 360, 15, $SS_CENTER)
		GUICtrlCreateIcon ($pIconLib, $eIcnSleepMode, $x - 10, $y + 10, 48, 48)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	; Close When Training Settings
	Local $x = 20, $y = 115
	$grpTrainingClose = GUICtrlCreateGroup("Training Settings", $x - 20, $y - 20, 438, 170)
		GUICtrlCreateIcon ($pIconLib, $eIcnTrainMode, $x - 10, $y + 10, 48, 48)
		$chkUseTrainingClose = GUICtrlCreateCheckbox("Enable Close While Training", $x + 50, $y - 5, -1, -1)
			$txtTip = "Enable this option to cause the bot to close when there is more than 2 mins remaining on training times." & @CRLF & @CRLF & _
				      "     Doctor's Recommendation: Use this setting to reduce overall time spent online."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkUseTrainingClose")
		$lblExtraTimeMin = GUICtrlCreateLabel("Extra Time Min: ", $x + 67, $y + 24, 90, -1, $SS_RIGHT)
		$lblExtraTimeMinNumber = GUICtrlCreateLabel("10", $x + 165, $y + 24, 15, 15, $SS_RIGHT)
		$lblExtraTimeMinUnit = GUICtrlCreateLabel("minutes", $x + 185, $y + 24, -1, -1)
		$sldExtraTimeMin = GUICtrlCreateSlider($x + 235, $y + 22, 150, 25, BITOR($TBS_TOOLTIPS, $TBS_AUTOTICKS)) ;,
			$txtTip = "Select the minimum number of mins to add extra to the log out time for training." & @CRLF & _
				      "     Value can be from 0 to 30 mins."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetBkColor(-1, $COLOR_WHITE)
			_GUICtrlSlider_SetTipSide(-1, $TBTS_BOTTOM)
			_GUICtrlSlider_SetTicFreq(-1, 1)
			GUICtrlSetLimit(-1, 30)
			GUICtrlSetData(-1, 10)
			GUICtrlSetOnEvent(-1, "sldExtraTimeMin")
		$lblExtraTimeMax = GUICtrlCreateLabel("Extra Time Max: ", $x + 70, $y + 50, 90, -1, $SS_RIGHT)
		$lblExtraTimeMaxNumber = GUICtrlCreateLabel("20", $x + 165, $y + 50, 15, 15, $SS_RIGHT)
		$lblExtraTimeMaxUnit = GUICtrlCreateLabel("minutes", $x + 185, $y + 50, -1, -1)
		$sldExtraTimeMax = GUICtrlCreateSlider($x + 235, $y + 47, 150, 25, BITOR($TBS_TOOLTIPS, $TBS_AUTOTICKS)) ;,
			$txtTip = "Select the maximum number of mins to add extra to the log out time for training." & @CRLF & _
				      "     Value can be from 0 to 30 mins."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetBkColor(-1, $COLOR_WHITE)
			_GUICtrlSlider_SetTipSide(-1, $TBTS_BOTTOM)
			_GUICtrlSlider_SetTicFreq(-1, 1)
			GUICtrlSetLimit(-1, 30)
			GUICtrlSetData(-1, 20)
			GUICtrlSetOnEvent(-1, "sldExtraTimeMax")
		$radLeaveCoCOpen = GUICtrlCreateRadio("Leave CoC open and disconnect by inactivity", $x + 81, $y + 70, -1, -1)
			GUICtrlSetTip(-1, "While training the bot will leave CoC open and disconnect by inactivity.")
			;GUICtrlSetOnEvent(-1, "chkLeaveOpenOrClose")
			;GUICtrlSetState(-1, $GUI_DISABLE)
		$radCloseCoCGame = GUICtrlCreateRadio("Close CoC game and stay on home screen", $x + 81, $y + 90, -1, -1)
		GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetTip(-1, "While training the bot will close CoC game and stay on android home screen.")
			;GUICtrlSetOnEvent(-1, "chkLeaveOpenOrClose")
			;GUICtrlSetState(-1, $GUI_DISABLE)
		$radRandomCoCOpen = GUICtrlCreateRadio("Random Close or Leave! ", $x + 81, $y + 110, -1, -1)
			GUICtrlSetTip(-1, "Random between leave coc open or Close the game.")
			;GUICtrlSetOnEvent(-1, "chkLeaveOpenOrClose")
			;GUICtrlSetState(-1, $GUI_DISABLE)
		$chkRandomStayORClose = GUICtrlCreateCheckbox("Random Stay or Close the Game while Training", $x + 50, $y + 127, -1, -1)
			GUICtrlSetTip(-1, "Random Stay in the Game and Close the Game with your previous settings!")
			;GUICtrlSetState(-1, $GUI_DISABLE)

	GUICtrlCreateGroup("", -99, -99, 1, 1)

	; Daily Settings
	Local $x = 20, $y = 285
	$grpTrainingClose = GUICtrlCreateGroup("Daily Settings", $x - 20, $y - 20, 438, 100)
	GUICtrlCreateIcon ($pIconLib, $eIcnDailyProgram, $x - 10, $y + 10, 48, 48)
		$chkUseAttackLimit = GUICtrlCreateCheckbox("Enable Daily Attack Limit", $x + 50, $y - 5, -1, -1)
			$txtTip = "Enable this option to limit the maximum amount of attacks the bot can perform per day." & @CRLF & @CRLF & _
				      "     Doctor's Recommendation: Use this setting to stop excessive attacks."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkUseAttackLimit")
		$lblAttacksMin = GUICtrlCreateLabel("Min Attacks: ", $x + 70, $y + 24, 90, -1, $SS_RIGHT)
		$lblAttacksMinNumber = GUICtrlCreateLabel("20", $x + 165, $y + 24, 15, 15, $SS_RIGHT)
		$lblAttacksMinUnit = GUICtrlCreateLabel("attacks", $x + 185, $y + 24, -1, -1)
		$sldAttacksMin = GUICtrlCreateSlider($x + 235, $y + 22, 150, 25, BITOR($TBS_TOOLTIPS, $TBS_AUTOTICKS)) ;,
			$txtTip = "Select the lower limit of max attacks range." & @CRLF & _
				      "     Value can be from 0 to 25 attacks."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetBkColor(-1, $COLOR_WHITE)
			_GUICtrlSlider_SetTipSide(-1, $TBTS_BOTTOM)
			_GUICtrlSlider_SetTicFreq(-1, 1)
			GUICtrlSetLimit(-1, 25)
			GUICtrlSetData(-1, 20)
			GUICtrlSetOnEvent(-1, "sldAttacksMin")
		$lblAttacksMax = GUICtrlCreateLabel("Max Attacks: ", $x + 70, $y + 50, 90, -1, $SS_RIGHT)
		$lblAttacksMaxNumber = GUICtrlCreateLabel("25", $x + 165, $y + 50, 15, 15, $SS_RIGHT)
		$lblAttacksMaxUnit = GUICtrlCreateLabel("attacks", $x + 185, $y + 50, -1, -1)
		$sldAttacksMax = GUICtrlCreateSlider($x + 235, $y + 47, 150, 25, BITOR($TBS_TOOLTIPS, $TBS_AUTOTICKS)) ;,
			$txtTip = "Select the upper limit of max attacks range." & @CRLF & _
				      "     Value can be from 0 to 25 attacks."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetBkColor(-1, $COLOR_WHITE)
			_GUICtrlSlider_SetTipSide(-1, $TBTS_BOTTOM)
			_GUICtrlSlider_SetTicFreq(-1, 1)
			GUICtrlSetLimit(-1, 25)
			GUICtrlSetData(-1, 25)
			GUICtrlSetOnEvent(-1, "sldAttacksMax")
	GUICtrlCreateGroup("", -99, -99, 1, 1)
;GUICtrlCreateTabItem("")
Global $LastControlToHideModAIO = GUICtrlCreateDummy()
Global $iPrevState[$LastControlToHideModAIO + 1]