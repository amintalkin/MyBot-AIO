; #FUNCTION# ====================================================================================================================
; Name ..........: RemainTrainTime
; Description ...: Read the remaining time to complete the train troops & Spells on ArmyOverView Window
; Syntax ........: RemainTrainTime
; Parameters ....: $Troops and $Spells
; Return values .: Most high value from Spells or Troops in minutes
; Author ........: ProMac (04-2016)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......: openArmyOverview
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================


Func getRemainingTraining($Troops = True, $Spells = True)

	; Lets open the ArmyOverView Window (this function will check if we are on Main Page and wait for the window open returning True or False)
	If openArmyOverview() Then

		Local $aRemainTrainTroopTimer = 0
		Local $aRemainTrainSpellsTimer = 0
		Local $ResultTroopsHour, $ResultTroopsMinutes
		Local $ResultSpellsHour, $ResultSpellsMinutes

		Local $ResultTroops = getRemainTrainingTimer(680, 176)
		Local $ResultSpells = getRemainTrainingTimer(360, 423)

		If $Troops = True Then
			SetLog(" Total time train troop(s): " & $ResultTroops)
			If StringInStr($ResultTroops, "h") > 1 Then
				$ResultTroopsHour = StringSplit($ResultTroops, "h", $STR_NOCOUNT)
				; $ResultTroopsHour[0] will be the Hour and the $ResultTroopsHour[1] will be the Minutes with the "m" at end
				$ResultTroopsMinutes = StringTrimRight($ResultTroopsHour[1], 1) ; removing the "m"
				$aRemainTrainTroopTimer = (Number($ResultTroopsHour[0]) * 60) + Number($ResultTroopsMinutes)
			Else
				; Verify if exist "s" for seconds or "m" for minutes
				If StringInStr($ResultTroops, "s") > 1 Then
					$aRemainTrainTroopTimer = 1
				Else
					$aRemainTrainTroopTimer = Number(StringTrimRight($ResultTroops, 1)) ; removing the "m"
				EndIf
			EndIf
		EndIf

		If $Spells = True Then
			SetLog(" Total time brew Spell(s): " & $ResultSpells)
			If StringInStr($ResultSpells, "h") > 1 Then
				$ResultSpellsHour = StringSplit($ResultSpells, "h", $STR_NOCOUNT)
				; $ResultSpellsHour[0] will be the Hour and the $ResultSpellsHour[1] will be the Minutes with the "m" at end
				$ResultSpellsMinutes = StringTrimRight($ResultSpellsHour[1], 1) ; removing the "m"
				$aRemainTrainSpellsTimer = (Number($ResultSpellsHour[0]) * 60) + Number($ResultSpellsMinutes)
			Else
				; Verify if exist "s" for seconds or "m" for minutes
				If StringInStr($ResultSpells, "s") > 1 Then
					$aRemainTrainSpellsTimer = 1
				Else
					$aRemainTrainSpellsTimer = Number(StringTrimRight($ResultSpells, 1)) ; removing the "m"
				EndIf
			EndIf
		EndIf

		; Verify the higest value to return in minutes and the % for fulll troops
		If $aRemainTrainTroopTimer > $aRemainTrainSpellsTimer Then
			Return ($aRemainTrainTroopTimer * $fulltroop)/100
		Else
			Return ($aRemainTrainSpellsTimer * $fulltroop)/100
		EndIf
	Else
		SetLog("Can not read the remaining Troops&Spells time!", $COLOR_RED)
		Return 0
	EndIf

EndFunc   ;==>getRemainingTraining

