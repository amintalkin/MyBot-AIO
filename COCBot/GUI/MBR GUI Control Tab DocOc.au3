; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Controls Tab DocOc
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

Func calculateSleepTime($startHour, $endHour)
	Local $hours = $endHour - $startHour

	If $hours < 0 Then $hours += 24

	GUICtrlSetData($lblTotalSleep, "Estimated Sleep Time: " & String($hours - 1) & " - " & String($hours + 1) & " Hours")
EndFunc   ;==>calculateSleepTime

Func chkUseSleep()
	If GUICtrlRead($chkUseSleep) = $GUI_CHECKED Then
		For $i = $lblStartSleep To $lblTotalSleep
			GUICtrlSetState($i, $GUI_SHOW)
		Next
		$ichkCloseNight = 1
	Else
		For $i = $lblStartSleep To $lblTotalSleep
			GUICtrlSetState($i, $GUI_HIDE)
		Next
		$ichkCloseNight = 0
	EndIf
EndFunc   ;==>chkUseSleep

Func cmbStartSleep()
	$sleepStart = _GUICtrlComboBox_GetCurSel($cmbStartSleep)
	$nextSleepStart = calculateSleepStart()

	calculateSleepTime($sleepStart, $sleepEnd)
EndFunc   ;==>cmbStartSleep

Func cmbEndSleep()
	$sleepEnd = _GUICtrlComboBox_GetCurSel($cmbEndSleep)
	$nextSleepEnd = calculateSleepEnd()

	calculateSleepTime($sleepStart, $sleepEnd)
EndFunc   ;==>cmbEndSleep

Func chkUseTrainingClose()
	If GUICtrlRead($chkUseTrainingClose) = $GUI_CHECKED Then
		For $i = $lblExtraTimeMin To $chkRandomStayORClose
			GUICtrlSetState($i, $GUI_SHOW)
		Next
		$ichkCloseTraining = 1
	Else
		For $i = $lblExtraTimeMin To $chkRandomStayORClose
			GUICtrlSetState($i, $GUI_HIDE)
		Next
		$ichkCloseTraining = 0
	EndIf
EndFunc   ;==>chkUseTrainingClose

Func sldExtraTimeMin()
	$minTrainAddition = GUICtrlRead($sldExtraTimeMin)
	GUICtrlSetData($lblExtraTimeMinNumber, $minTrainAddition)

	; Move the maximum slider if needed
	If $minTrainAddition > $maxTrainAddition Then
		$maxTrainAddition = $minTrainAddition

		GUICtrlSetData($lblExtraTimeMaxNumber, $minTrainAddition)
		GUICtrlSetData($sldExtraTimeMax, $minTrainAddition)
	EndIf

	GUICtrlSetData($lblExtraTimeMinUnit, ($minTrainAddition = 1) ? "minute" : "minutes")
	GUICtrlSetData($lblExtraTimeMaxUnit, ($maxTrainAddition = 1) ? "minute" : "minutes")
EndFunc   ;==>sldExtraTimeMin

Func sldExtraTimeMax()
	$maxTrainAddition = GUICtrlRead($sldExtraTimeMax)
	GUICtrlSetData($lblExtraTimeMaxNumber, $maxTrainAddition)

	; Move the minimum slider if needed
	If $maxTrainAddition < $minTrainAddition Then
		$minTrainAddition = $maxTrainAddition

		GUICtrlSetData($lblExtraTimeMinNumber, $maxTrainAddition)
		GUICtrlSetData($sldExtraTimeMin, $maxTrainAddition)
	EndIf

	GUICtrlSetData($lblExtraTimeMinUnit, ($minTrainAddition = 1) ? "minute" : "minutes")
	GUICtrlSetData($lblExtraTimeMaxUnit, ($maxTrainAddition = 1) ? "minute" : "minutes")
EndFunc   ;==>sldExtraTimeMax

Func chkUseAttackLimit()
	If GUICtrlRead($chkUseAttackLimit) = $GUI_CHECKED Then
		For $i = $lblAttacksMin To $sldAttacksMax
			GUICtrlSetState($i, $GUI_SHOW)
		Next
		$ichkLimitAttacks = 1
	Else
		For $i = $lblAttacksMin To $sldAttacksMax
			GUICtrlSetState($i, $GUI_HIDE)
		Next
		$ichkLimitAttacks = 0
	EndIf
EndFunc   ;==>chkUseAttackLimit

Func sldAttacksMin()
	$rangeAttacksStart = GUICtrlRead($sldAttacksMin)
	GUICtrlSetData($lblAttacksMinNumber, $rangeAttacksStart)

	; Move the maximum slider if needed
	If $rangeAttacksStart > $rangeAttacksEnd Then
		$rangeAttacksEnd = $rangeAttacksStart

		GUICtrlSetData($lblAttacksMaxNumber, $rangeAttacksStart)
		GUICtrlSetData($sldAttacksMax, $rangeAttacksStart)
	EndIf

	GUICtrlSetData($lblAttacksMinUnit, ($rangeAttacksStart = 1) ? "attack" : "attacks")
	GUICtrlSetData($lblAttacksMaxUnit, ($rangeAttacksEnd = 1) ? "attack" : "attacks")
EndFunc   ;==>sldAttacksMin

Func sldAttacksMax()
	$rangeAttacksEnd = GUICtrlRead($sldAttacksMax)
	GUICtrlSetData($lblAttacksMaxNumber, $rangeAttacksEnd)

	; Move the minimum slider if needed
	If $rangeAttacksEnd < $rangeAttacksStart Then
		$rangeAttacksStart = $rangeAttacksEnd

		GUICtrlSetData($lblAttacksMinNumber, $rangeAttacksEnd)
		GUICtrlSetData($sldAttacksMin, $rangeAttacksEnd)
	EndIf

	GUICtrlSetData($lblAttacksMinUnit, ($rangeAttacksStart = 1) ? "attack" : "attacks")
	GUICtrlSetData($lblAttacksMaxUnit, ($rangeAttacksEnd = 1) ? "attack" : "attacks")
EndFunc   ;==>sldAttacksMax