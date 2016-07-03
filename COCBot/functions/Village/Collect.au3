
; #FUNCTION# ====================================================================================================================
; Name ..........: Collect
; Description ...:
; Syntax ........: Collect()
; Parameters ....:
; Return values .: None
; Author ........: Code Gorilla #3
; Modified ......: Sardo 2015-08, KnowJack(Aug 2015), kaganus (August 2015), ProMac (04-2016)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func Collect()
	Local $ImagesToUse[3]
	$ImagesToUse[0] = @ScriptDir & "\images\Button\Treasury.png"
	$ImagesToUse[1] = @ScriptDir & "\images\Button\Collect.png"
	$ImagesToUse[2] = @ScriptDir & "\images\Button\CollectOkay.png"
	$ToleranceImgLoc = 0.90
	Local $t = 0
	If $RunState = False Then Return

	ClickP($aAway, 1, 0, "#0332") ;Click Away

	If $iChkCollect = 0 Then Return

	VillageReport(True, True)
	$tempCounter = 0
	While ($iGoldCurrent = "" Or $iElixirCurrent = "" Or ($iDarkCurrent = "" And $iDarkStart <> "")) And $tempCounter < 3
		$tempCounter += 1
		VillageReport(True, True)
	WEnd
	Local $tempGold = $iGoldCurrent
	Local $tempElixir = $iElixirCurrent
	Local $tempDElixir = $iDarkCurrent

	checkAttackDisable($iTaBChkIdle) ; Early Take-A-Break detection

	SetLog("Collecting Resources", $COLOR_BLUE)
	If _Sleep($iDelayCollect2) Then Return
	
	; Collect function to Parallel Search , will run all pictures inside the directory
	Local $directory = @ScriptDir & "\images\Resources\Collect"
	; Setup arrays, including default return values for $return
	Local $Filename = ""
	Local $CollectXY
	
	Local $aResult = returnMultipleMatchesOwnVillage($directory)
	If UBound($aResult) > 1 Then
		For $i = 1 To UBound($aResult) - 1
			$Filename = $aResult[$i][1] ; Filename
			$CollectXY = $aResult[$i][5] ; Coords
			If IsMainPage() Then
				If IsArray($CollectXY) Then
					For $t = 0 To UBound($CollectXY) - 1 ; each filename can have several positions
						If $DebugSetLog = 1 Then SetLog($Filename & " found (" & $CollectXY[$t][0] & "," & $CollectXY[$t][1] & ")", $COLOR_GREEN)
						;If IsMainPage() Then Click($CollectXY[$t][0], $CollectXY[$t][1], 1, 0, "#0430")
						Click($CollectXY[$t][0], $CollectXY[$t][1], 1, 0, "#0430")
						If _Sleep($iDelayCollect2) Then Return
					Next
				EndIf 
			EndIf
		Next 
	EndIf 

	If _Sleep($iDelayCollect3) Then Return
	checkMainScreen(False) ; check if errors during function

	; Loot Cart Collect Function

	Setlog("Searching for a Loot Cart..", $COLOR_BLUE)

	Local $LootCart = @ScriptDir & "\images\Resources\LootCart\loot_cart.png"
	Local $LootCartX, $LootCartY

	$ToleranceImgLoc = 0.850
	Local $fullCocAreas = "ECD"
	Local $MaxReturnPoints = 1

	_CaptureRegion2()
	;Local $res = DllCall($pImgLib, "str", "SearchTile", "handle", $hHBitmap2, "str", $LootCart, "float", $ToleranceImgLoc, "str", $fullCocAreas, "Int", $MaxReturnPoints)
	Local $res = DllCall($hImgLib, "str", "SearchTile", "handle", $hHBitmap2, "str", $LootCart, "float", $ToleranceImgLoc, "str", $fullCocAreas, "Int", $MaxReturnPoints)
	If @error Then _logErrorDLLCall($pImgLib, @error)
	If IsArray($res) Then
		If $DebugSetlog = 1 Then SetLog("DLL Call succeeded " & $res[0], $COLOR_RED)
		If $res[0] = "0" Or $res[0] = "" Then
			SetLog("No Loot Cart found, Yard is clean!", $COLOR_GREEN)
		ElseIf StringLeft($res[0], 2) = "-1" Then
			SetLog("DLL Error: " & $res[0], $COLOR_RED)
		Else
			$expRet = StringSplit($res[0], "|", $STR_NOCOUNT)
			;$expret contains 2 positions; 0 is the total objects; 1 is the point in X,Y format
			$posPoint = StringSplit($expRet[1], ",", $STR_NOCOUNT)
			$LootCartX = Int($posPoint[0])
			$LootCartY = Int($posPoint[1])
			If $LootCartX > 80 Then  ; secure x because of clan chat tab
				If $DebugSetlog Then SetLog("LootCart found (" & $LootCartX & "," & $LootCartY & ")", $COLOR_GREEN)
				If IsMainPage() Then Click($LootCartX, $LootCartY, 1, 0, "#0330")
				If _Sleep($iDelayCollect1) Then Return

				;Get LootCart info confirming the name
				Local $sInfo = BuildingInfo(242, 520 + $bottomOffsetY); 860x780
				If @error Then SetError(0, 0, 0)
				Local $CountGetInfo = 0
				While IsArray($sInfo) = False
					$sInfo = BuildingInfo(242, 520 + $bottomOffsetY); 860x780
					If @error Then SetError(0, 0, 0)
					If _Sleep($iDelayCollect1) Then Return
					$CountGetInfo += 1
					If $CountGetInfo >= 5 Then Return
				WEnd
				If $DebugSetlog Then SetLog(_ArrayToString($sInfo, " "), $COLOR_PURPLE)
				If @error Then Return SetError(0, 0, 0)
				If $sInfo[0] > 1 Or $sInfo[0] = "" Then
					If StringInStr($sInfo[1], "Loot") = 0 Then
						If $DebugSetlog Then SetLog("Bad Loot Cart location", $COLOR_ORANGE)
					Else
						If IsMainPage() Then Click($aLootCartBtn[0], $aLootCartBtn[1], 1, 0, "#0331") ;Click loot cart button
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf

	VillageReport(True, True)
	$tempCounter = 0
	While ($iGoldCurrent = "" Or $iElixirCurrent = "" Or ($iDarkCurrent = "" And $iDarkStart <> "")) And $tempCounter < 3
		$tempCounter += 1
		VillageReport(True, True)
	WEnd

	If $tempGold <> "" And $iGoldCurrent <> "" Then
		$tempGoldCollected = $iGoldCurrent - $tempGold
		$iGoldFromMines += $tempGoldCollected
		$iGoldTotal += $tempGoldCollected
	EndIf

	If $tempElixir <> "" And $iElixirCurrent <> "" Then
		$tempElixirCollected = $iElixirCurrent - $tempElixir
		$iElixirFromCollectors += $tempElixirCollected
		$iElixirTotal += $tempElixirCollected
	EndIf

	If $tempDElixir <> "" And $iDarkCurrent <> "" Then
		$tempDElixirCollected = $iDarkCurrent - $tempDElixir
		$iDElixirFromDrills += $tempDElixirCollected
		$iDarkTotal += $tempDElixirCollected
	EndIf

	UpdateStats()
If $ichkTRFull = 1 Then
	If ($aCCPos[0] = "-1" Or $aCCPos[1] = "-1") Then
   SetLog("Clan Castle Not Located To Collect Loot Treasury, Please Locate Clan Castle.",$COLOR_RED)
LocateClanCastle()
EndIf
	SetLog("Checking for full Treasury",$COLOR_BLUE)
	ClickP($aAway, 1, 0, "#04004") ; Click away
	Sleep(100)
	click($aCCPos[0], $aCCPos[1], 1, 0, "#04005")
	Sleep(300)
		;Click Treasury Button To Open Treasury Page
		_CaptureRegion2(125, 610, 740, 715)
		$res = DllCall($hImgLib, "str", "SearchTile", "handle", $hHBitmap2, "str", $ImagesToUse[0], "float", $ToleranceImgLoc, "str", "FV", "int", 1)
			If IsArray($res) Then
			   If $DebugSetlog = 1 Then SetLog("DLL Call succeeded " & $res[0], $COLOR_RED)
				  If $res[0] = "0" Or $res[0] = "" Then
					; failed to find Treasury Button
					 If $DebugSetlog then SetLog("No Button found")
					 SetLog("No Treasury Button Found",$COLOR_RED)
				  ElseIf $res[0] = "-1" Then
					SetLog("DLL Error", $COLOR_RED)
				  ElseIf $res[0] = "-2" Then
					SetLog("Invalid Resolution", $COLOR_RED)
				  Else
					$expRet = StringSplit($res[0], "|", $STR_NOCOUNT)
					$posPoint = StringSplit($expRet[1], ",", $STR_NOCOUNT)
					$ButtonX = 125 + Int($posPoint[0])
					$ButtonY = 610 + Int($posPoint[1])
					 Click($ButtonX, $ButtonY, 1, 0, "#04006")
				 Sleep(1000)
				 EndIf
			EndIf	;EndIf for: If IsArray($res)
		;End Click Treasury Button To Open Treasury Page
	$slps = _PixelSearch(688, 296, 691, 355,Hex(0x50BD10, 6),20)
	If IsArray($slps) Then
		SetLog("Found full Treasury, Collecting Treasury loot due to full Treasury...",$COLOR_BLUE)
		_CaptureRegion2()
	  $res = DllCall($hImgLib, "str", "SearchTile", "handle", $hHBitmap2, "str", $ImagesToUse[1], "float", $ToleranceImgLoc, "str", "FV", "int", 1)
		 If IsArray($res) Then
			   If $DebugSetlog = 1 Then SetLog("DLL Call succeeded " & $res[0], $COLOR_RED)
				  If $res[0] = "0" Or $res[0] = "" Then
					; failed to find Treasury Button
					If $DebugSetlog then SetLog("No Button found")
					SetLog("No Treasury Button Found",$COLOR_RED)
				  ElseIf $res[0] = "-1" Then
					SetLog("DLL Error", $COLOR_RED)
				  ElseIf $res[0] = "-2" Then
					SetLog("Invalid Resolution", $COLOR_RED)
				  Else
					$expRet = StringSplit($res[0], "|", $STR_NOCOUNT)
					$posPoint = StringSplit($expRet[1], ",", $STR_NOCOUNT)
					$ButtonX = Int($posPoint[0])
					$ButtonY = Int($posPoint[1])
					Click($ButtonX, $ButtonY, 1, 0, "#04007")
			    Sleep(1000)
		_CaptureRegion2()
	  $res = DllCall($hImgLib, "str", "SearchTile", "handle", $hHBitmap2, "str", $ImagesToUse[2], "float", $ToleranceImgLoc, "str", "FV", "int", 1)
			   If IsArray($res) Then
				  If $DebugSetlog = 1 Then SetLog("DLL Call succeeded " & $res[0], $COLOR_RED)
					 If $res[0] = "0" Or $res[0] = "" Then
						; failed to find Treasury Button
						If $DebugSetlog then SetLog("No Button found")
						SetLog("No Treasury Button Found",$COLOR_RED)
					 ElseIf $res[0] = "-1" Then
					 SetLog("DLL Error", $COLOR_RED)
					 ElseIf $res[0] = "-2" Then
					 SetLog("Invalid Resolution", $COLOR_RED)
					 Else
					$expRet = StringSplit($res[0], "|", $STR_NOCOUNT)
					$posPoint = StringSplit($expRet[1], ",", $STR_NOCOUNT)
					$ButtonX = Int($posPoint[0])
					$ButtonY = Int($posPoint[1])
					Click($ButtonX, $ButtonY, 1, 0, "#04008")
					SetLog("Loot Treasury Collected Successfully.",$COLOR_BLUE)
					ClickP($aAway, 1, 0, "#04004") ; Click away
				 EndIf
			  EndIf
		   EndIf
		 EndIf
	Else
		 SetLog("Treasury not full, Skipping collecting treasury",$COLOR_ORANGE)
		 ClickP($aAway, 1, 0, "#04004") ; Click away
	EndIf
EndIf
If (Number($tempGold) <= Number($itxtTRGold)) Or (Number($tempElixir) <= Number($itxtTRElixir)) Or (Number($tempDElixir) <= Number($itxtTRDElixir)) Then
If ($aCCPos[0] = "-1" Or $aCCPos[1] = "-1") Then
   SetLog("Clan Castle Not Located To Collect Loot Treasury, Please Locate Clan Castle.",$COLOR_RED)
LocateClanCastle()
EndIf
	SetLog("Collecting Treasury Loot Due to Low Resources...",$COLOR_BLUE)
		ClickP($aAway, 1, 0, "#04004") ; Click away
		Sleep(100)
		click($aCCPos[0], $aCCPos[1], 1, 0, "#04005")
	  Sleep(1000)

		_CaptureRegion2(125, 610, 740, 715)
	  $res = DllCall($hImgLib, "str", "SearchTile", "handle", $hHBitmap2, "str", $ImagesToUse[0], "float", $ToleranceImgLoc, "str", "FV", "int", 1)
		 If IsArray($res) Then
			   If $DebugSetlog = 1 Then SetLog("DLL Call succeeded " & $res[0], $COLOR_RED)
				  If $res[0] = "0" Or $res[0] = "" Then
					; failed to find Treasury Button
					 If $DebugSetlog then SetLog("No Button found")
					 SetLog("No Treasury Button Found",$COLOR_RED)
				  ElseIf $res[0] = "-1" Then
					SetLog("DLL Error", $COLOR_RED)
				  ElseIf $res[0] = "-2" Then
					SetLog("Invalid Resolution", $COLOR_RED)
				  Else
					$expRet = StringSplit($res[0], "|", $STR_NOCOUNT)
					$posPoint = StringSplit($expRet[1], ",", $STR_NOCOUNT)
					$ButtonX = 125 + Int($posPoint[0])
					$ButtonY = 610 + Int($posPoint[1])
					 Click($ButtonX, $ButtonY, 1, 0, "#04006")
				 Sleep(1000)
		_CaptureRegion2()
	  $res = DllCall($hImgLib, "str", "SearchTile", "handle", $hHBitmap2, "str", $ImagesToUse[1], "float", $ToleranceImgLoc, "str", "FV", "int", 1)
		 If IsArray($res) Then
			   If $DebugSetlog = 1 Then SetLog("DLL Call succeeded " & $res[0], $COLOR_RED)
				  If $res[0] = "0" Or $res[0] = "" Then
					; failed to find Treasury Button
					If $DebugSetlog then SetLog("No Button found")
					SetLog("No Treasury Button Found",$COLOR_RED)
				  ElseIf $res[0] = "-1" Then
					SetLog("DLL Error", $COLOR_RED)
				  ElseIf $res[0] = "-2" Then
					SetLog("Invalid Resolution", $COLOR_RED)
				  Else
					$expRet = StringSplit($res[0], "|", $STR_NOCOUNT)
					$posPoint = StringSplit($expRet[1], ",", $STR_NOCOUNT)
					$ButtonX = Int($posPoint[0])
					$ButtonY = Int($posPoint[1])
					Click($ButtonX, $ButtonY, 1, 0, "#04007")
			    Sleep(1000)
		_CaptureRegion2()
	  $res = DllCall($hImgLib, "str", "SearchTile", "handle", $hHBitmap2, "str", $ImagesToUse[2], "float", $ToleranceImgLoc, "str", "FV", "int", 1)
			   If IsArray($res) Then
				  If $DebugSetlog = 1 Then SetLog("DLL Call succeeded " & $res[0], $COLOR_RED)
					 If $res[0] = "0" Or $res[0] = "" Then
						; failed to find Treasury Button
						If $DebugSetlog then SetLog("No Button found")
						SetLog("No Treasury Button Found",$COLOR_RED)
					 ElseIf $res[0] = "-1" Then
					 SetLog("DLL Error", $COLOR_RED)
					 ElseIf $res[0] = "-2" Then
					 SetLog("Invalid Resolution", $COLOR_RED)
					 Else
					$expRet = StringSplit($res[0], "|", $STR_NOCOUNT)
					$posPoint = StringSplit($expRet[1], ",", $STR_NOCOUNT)
					$ButtonX = Int($posPoint[0])
					$ButtonY = Int($posPoint[1])
					Click($ButtonX, $ButtonY, 1, 0, "#04008")
					SetLog("Loot Treasury Collected Successfully.",$COLOR_BLUE)
				 EndIf
			  EndIf
		   EndIf
		EndIf
	 EndIf
  EndIf
ElseIF (Number($tempGold) <= Number($itxtTRGold)) Or (Number($tempElixir) <= Number($itxtTRElixir)) Or (Number($tempDElixir) <= Number($itxtTRDElixir)) = False Then
			   SetLog("Resources Don't Match With Minimum Required Resources To Collect Loot Treasury",$COLOR_ORANGE)
			   ClickP($aAway, 1, 0, "#04004") ; Click away
EndIf
	VillageReport(True, True)
	$tempCounter = 0
	While ($iGoldCurrent = "" Or $iElixirCurrent = "" Or ($iDarkCurrent = "" And $iDarkStart <> "")) And $tempCounter < 3
		$tempCounter += 1
		VillageReport(True, True)
	WEnd

	If $tempGold <> "" And $iGoldCurrent <> "" Then
		$tempGoldCollected = $iGoldCurrent - $tempGold
		$iGoldFromMines += $tempGoldCollected
		$iGoldTotal += $tempGoldCollected
	EndIf

	If $tempElixir <> "" And $iElixirCurrent <> "" Then
		$tempElixirCollected = $iElixirCurrent - $tempElixir
		$iElixirFromCollectors += $tempElixirCollected
		$iElixirTotal += $tempElixirCollected
	EndIf

	If $tempDElixir <> "" And $iDarkCurrent <> "" Then
		$tempDElixirCollected = $iDarkCurrent - $tempDElixir
		$iDElixirFromDrills += $tempDElixirCollected
		$iDarkTotal += $tempDElixirCollected
	 EndIf
	UpdateStats()

EndFunc   ;==>Collect
