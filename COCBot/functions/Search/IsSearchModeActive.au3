
; #FUNCTION# ====================================================================================================================
; Name ..........: IsSearchModeActive
; Description ...:
; Syntax ........: IsSearchModeActive($iMatchMode)
; Parameters ....:
; Return values .: None
; Author ........: Sardo (2016-01)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func IsSearchModeActive($iMatchMode, $nocheckHeroes = False)
	Local $currentSearch = $SearchCount + 1
	Local $currentTropies = $iTrophyCurrent
	Local $currentArmyCamps =  Int($CurCamp / $TotalCamp * 100)

	Local $bMatchModeEnabled = True
	Local $checkSearches = Int($currentSearch) >= Int($iEnableAfterCount[$iMatchMode]) And Int($currentSearch) <= Int($iEnableBeforeCount[$iMatchMode]) And $iEnableSearchSearches[$iMatchMode] = 1
	Local $checkTropies = Int($currentTropies) >= Int($iEnableAfterTropies[$iMatchMode]) And Int($currentTropies) <= Int($iEnableBeforeTropies[$iMatchMode]) And $iEnableSearchTropies[$iMatchMode] = 1
	Local $checkArmyCamps = Int($currentArmyCamps) >= Int($iEnableAfterArmyCamps[$iMatchMode] Or $fullarmy = True) And $iEnableSearchCamps[$iMatchMode] = 1
	Local $checkHeroes = Not ($iHeroWait[$iMatchMode] > $HERO_NOHERO And (BitAND($iHeroAttack[$iMatchMode], $iHeroWait[$iMatchMode], $iHeroAvailable) = $iHeroWait[$iMatchMode]) = False) Or $nocheckHeroes
	
	;mikemikemikecoc - Wait For Spells
	Local $checkSpells = ($bFullArmySpells And $iEnableSpellsWait[$iMatchMode] = 1) Or $iEnableSpellsWait[$iMatchMode] = 0

	Switch $iMatchMode
		Case $DB
			$bMatchModeEnabled = ($iDBcheck = 1)
		Case $LB
			$bMatchModeEnabled = ($iABcheck = 1)
		Case $TS
			$bMatchModeEnabled = ($iTScheck = 1)
	EndSwitch

	;mikemikemikecoc - Wait For Spells
	If $checkHeroes And $checkSpells Then ;If $checkHeroes Then
		 If $bMatchModeEnabled And ($checkSearches Or $checkTropies Or $checkArmyCamps) Then
			 ;mikemikemikecoc - Wait For Spells
			 If $debugsetlog = 1 Then Setlog($sModeText[$iMatchMode] & " active! ($checkSearches=" & $checkSearches & ",$checkTropies=" & $checkTropies &",$checkArmyCamps=" & $checkArmyCamps & ",$checkHeroes=" & $checkHeroes & ",$checkSpells=" & $checkSpells & ")" , $Color_Blue) ;If $debugsetlog = 1 Then Setlog($sModeText[$iMatchMode] & " active! ($checkSearches=" & $checkSearches & ",$checkTropies=" & $checkTropies &",$checkArmyCamps=" & $checkArmyCamps & ",$checkHeroes=" & $checkHeroes & ")" , $Color_Blue)
			 Return True
		 Else
			 If $debugsetlog = 1 Then
				 Setlog($sModeText[$iMatchMode] & " not active!", $Color_Blue)
				 If $bMatchModeEnabled Then
					 Local $txtsearches = "Fail"
					 If $checkSearches Then $txtsearches = "Success"
					 Local $txttropies = "Fail"
					 If $checkTropies Then $txttropies = "Success"
					 Local $txtArmyCamp = "Fail"
					 If $checkArmyCamps Then $txtArmyCamp = "Success"
					 Local $txtHeroes = "Fail"
					 If $checkHeroes Then $txtHeroes = "Success"
					 If $iEnableSearchSearches[$iMatchMode] = 1 Then Setlog("searches range: " & $iEnableAfterCount[$iMatchMode] & "-" & $iEnableBeforeCount[$iMatchMode] & "  actual value: " & $currentSearch & " - " & $txtsearches, $Color_Blue)
					 If $iEnableSearchTropies[$iMatchMode] = 1 Then Setlog("tropies range: " & $iEnableAfterTropies[$iMatchMode] & "-" & $iEnableBeforeTropies[$iMatchMode] & "  actual value: " & $currentTropies & " | " & $txttropies, $Color_Blue)
					 If $iEnableSearchCamps[$iMatchMode] = 1 Then Setlog("Army camps % range >=: " & $iEnableAfterArmyCamps[$iMatchMode] & " actual value: " & $currentArmyCamps & " | " & $txtArmyCamp, $Color_Blue)
					 If $iHeroWait[$iMatchMode] > $HERO_NOHERO Then SetLog("Hero status " & BitAND($iHeroAttack[$iMatchMode], $iHeroWait[$iMatchMode], $iHeroAvailable) & " " & $iHeroAvailable & " | " & $txtHeroes, $COLOR_Blue)
					 
					 ;mikemikemikecoc - Wait For Spells
					 Local $txtSpells = "Fail"
					 If $checkSpells Then $txtSpells = "Success"
					 If $iEnableSpellsWait[$iMatchMode] = 1 Then SetLog("Full spell status: " & $bFullArmySpells & " | " & $txtSpells, $COLOR_Blue)
				 EndIf
			 EndIf
			 Return False
		 EndIf
	;mikemikemikecoc - Wait For Spells
	ElseIf $checkHeroes = 0 Then
		If $debugsetlog= 1 Then Setlog("Heroes not ready",$color_purple)	 
	Else
		If $debugsetlog= 1 Then Setlog("Spells not ready",$color_purple)
	EndIf
EndFunc   ;==>IsSearchModeActive