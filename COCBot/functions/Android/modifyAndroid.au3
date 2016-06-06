; #FUNCTION# ====================================================================================================================
; Name ..........: modifyAndroid
; Description ...: Function to start the correct Android Instance
; Syntax ........: modifyAndroid()
; Parameters ....: None
; Return values .: None
; Author ........: LunaEclipse(March 2016)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func getEmulatorNumber($emulatorName)
	Local $return = -1
	Local $i = 0

	; This loops through the array but allows us to exit as soon as we find our match.
	While $i < UBound($AndroidAppConfig)
		If $AndroidAppConfig[$i][0] = $emulatorName Then
			$return = $i
			ExitLoop
		EndIf

		$i += 1
	WEnd

	; This returns -1 if not found in the array, otherwise the array index.
	Return $return
EndFunc   ;==>getEmulatorNumber

Func getInstalledEmulators() ; Returns an array of all installed Android Emulators
	Local $currentConfig = $AndroidConfig, $currentAndroid = $Android, $currentAndroidInstance = $AndroidInstance
	Local $aReturn[1], $arrayCounter = 0

    $SilentSetLog = True

	For $i = 0 To UBound($AndroidAppConfig) - 1
	    $AndroidConfig = $i
		$InitAndroid = True

		If UpdateAndroidConfig() Then
		    ; Installed Android found
			ReDim $aReturn[$arrayCounter + 1]

			$aReturn[$arrayCounter] = $AndroidAppConfig[$i][0]
			$arrayCounter += 1
		EndIf
	Next

	; Check to make sure an emulator was found.
	If $arrayCounter = 0 Then
		$aReturn[$arrayCounter] = "<No Emulators>"

		; No emulator found so show a message box and exit.
		MsgBox(0, $sBotTitle, _
				  "There is no valid Emulators installed.  This BOT will not work without a recognized emulator installed!" & @CRLF & @CRLF & _
				  "Please install a valid emulator before trying to use this BOT!" & @CRLF & @CRLF & _
				  "Valid emulators are BlueStacks, Bluestacks2, Nox, Droid4x and MEmu.")
		Exit
	EndIf

	; Reset to the previous settings
	$AndroidConfig = $CurrentConfig
	$Android = $currentAndroid
	$AndroidInstance = $currentAndroidInstance

	$InitAndroid = True
 	UpdateAndroidConfig($AndroidInstance)

    $SilentSetLog = False

	Return $aReturn
EndFunc   ;==>getInstalledEmulators

Func setupInstances()
	; Update Bot title
	Local $sOldTitle = $sBotTitle

	$sBotTitle = $sBotTitleDefault & "(" & ($AndroidInstance <> "" ? $AndroidInstance : $Android) & ")"
	Local $hMutexTmp = _Singleton($sBotTitle, 1)
	If $hMutexTmp = 0 And $sBotTitle <> $sOldTitle Then
		MsgBox(0, $sBotTitle, "My Bot for " & $Android & ($AndroidInstance <> "" ? " instance (" & $AndroidInstance & ")" : "") & " is already running." & @CRLF & @CRLF & _
			   "To use this profile you must close the BOT that is currently running on " & $Android & ($AndroidInstance <> "" ? " instance (" & $AndroidInstance & ")" : ""))
		Exit
	EndIf
	_WinAPI_CloseHandle($hMutex_BotTitle)

	$hMutex_BotTitle = $hMutexTmp
	WinSetTitle($frmBot, "", $sBotTitle)

	AndroidAdbTerminateShellInstance()
	$HWnD = 0 ; refresh Android Handle

	$InitAndroid = True
	UpdateAndroidConfig($AndroidInstance)
EndFunc   ;==>setupInstances

Func modifyAndroid()
	Local $currentConfig = $AndroidConfig, $currentAndroid = $Android, $currentAndroidInstance = $AndroidInstance

	; Only use the profile for stored emulator and instance if there was no specific emulator and/or instance specified in the command line.
	Switch $aCmdLine[0]
		Case 0, 1 ; Command line does not contain any emulator information so use the profile settings.
			; Set profile name to the text box value if no profiles are found.
			If $sCurrProfile = "<No Profiles>" Then $sCurrProfile = StringRegExpReplace(GUICtrlRead($txtVillageName), '[/:*?"<>|]', '_')

			$AndroidConfig = getEmulatorNumber($sAndroid)

			Switch $sAndroid
				Case "<No Emulators>"
					; Should never happen because the BOT should have exited if no emulator found.
				Case "BlueStacks", "BlueStacks2"
					; Bluestacks or Bluestacks2 so ignore the instance parameter.
					GUICtrlSetState($txtAndroidInstance, $GUI_DISABLE)

					$Android = $sAndroid
					$AndroidInstance = ""

					If $AndroidConfig <> $currentConfig Or $Android <> $currentAndroid Then setupInstances()
				Case Else
					; Another emulator so use the instance parameter
					GUICtrlSetState($txtAndroidInstance, $GUI_ENABLE)

					$Android = $sAndroid
					$AndroidInstance = $sAndroidInstance

					If $AndroidConfig <> $currentConfig Or $Android <> $currentAndroid Or $AndroidInstance <> $currentAndroidInstance Then setupInstances()
			EndSwitch
		Case 2 ; Emulator is specified by the command line so use it instead of the profile setting.
			$Android = $aCmdLine[2]
			$AndroidConfig = getEmulatorNumber($Android)
			$AndroidInstance = $AndroidAppConfig[$AndroidConfig][1] ; default instance

			If $AndroidConfig <> $currentConfig Or $Android <> $currentAndroid Then setupInstances()
		Case Else ; Emulator and instance is specified by the command line so use them instead of the profile settings.
			$Android = $aCmdLine[2]
			$AndroidConfig = getEmulatorNumber($Android)
			$AndroidInstance = $aCmdLine[3]

			If $AndroidConfig <> $currentConfig Or $Android <> $currentAndroid Or $AndroidInstance <> $currentAndroidInstance Then setupInstances()
	EndSwitch
EndFunc   ;==>modifyAndroid