; #FUNCTION# ====================================================================================================================
; Name ..........: unitInfo.au3
; Description ...: Gets various information about units such as the number, location on the bar, clan castle spell type etc...
; Syntax ........:
; Parameters ....:
; Return values .:
; Author ........: @LunaEclipse
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func getTranslatedTroopName($kind)
    ;Troop string as an array
	;This order must exactly match the troops enum from MBR Global Variables.au3
    Local $result[$eHaSpell + 1] = [GetTranslated(1, 17, "Barbarians"), _
								    GetTranslated(1, 18, "Archers"), _
									GetTranslated(1, 19, "Giants"), _
									GetTranslated(1, 20, "Goblins"), _
									GetTranslated(1, 21, "Wall Breakers"), _
									GetTranslated(1, 22, "Balloons"), _
									GetTranslated(1, 23, "Wizards"), _
									GetTranslated(1, 24, "Healers"), _
									GetTranslated(1, 25, "Dragons"), _
									GetTranslated(1, 26, "Pekkas"), _
									GetTranslated(1, 48, "Minions"), _
									GetTranslated(1, 49, "Hog Riders"), _
									GetTranslated(1, 50, "Valkyries"), _
									GetTranslated(1, 51, "Golems"), _
									GetTranslated(1, 52, "Witches"), _
									GetTranslated(1, 53, "Lava Hounds"), _
									GetTranslated(7, 79, "King"), _
									GetTranslated(7, 81, "Queen"), _
									GetTranslated(7, 94, "Grand Warden"), _
									GetTranslated(7, 70, "Clan Castle"), _
									GetTranslated(8, 15, "Lightning Spell"), _
									GetTranslated(8, 16, "Healing Spell"), _
									GetTranslated(8, 17, "Rage Spell"), _
									GetTranslated(8, 18, "Jump Spell"), _
									GetTranslated(8, 19, "Freeze Spell"), _
									GetTranslated(8, 20, "Poison Spell"), _
									GetTranslated(8, 21, "Earthquake Spell"), _
									GetTranslated(8, 22, "Haste Spell")]

	Return $result[$kind]
EndFunc   ;==>getTranslatedTroopName

Func unitLocation($kind) ; Gets the location of the unit type on the bar.
	Local $return = -1
	Local $i = 0

	; This loops through the bar array but allows us to exit as soon as we find our match.
	While $i < UBound($atkTroops)
		; $atkTroops[$i][0] holds the unit ID for that position on the deployment bar.
		If $atkTroops[$i][0] = $kind Then
			$return = $i
			ExitLoop
		EndIf

		$i += 1
	WEnd

	; This returns -1 if not found on the bar, otherwise the bar position number.
	Return $return
EndFunc   ;==>unitLocation

Func unitCount($kind) ; Gets a count of the number of units of the type specified.
	Local $numUnits = 0
	Local $unitText = getTranslatedTroopName($kind)
	Local $barLocation = unitLocation($kind)

	; $barLocation is -1 if the unit/spell type is not found on the deployment bar.
	If $barLocation <> -1 Then
		$numUnits = $atkTroops[unitLocation($kind)][1]
		If $debugSetlog = 1 Then SetLog($numUnits & " " & $unitText & " in slot " & $barLocation, $COLOR_PURPLE)
	EndIf

	Return $numUnits
EndFunc   ;==>unitCount