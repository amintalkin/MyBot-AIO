; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Control
; Description ...: This file Includes all functions to current GUI
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........:
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func cmbProfile()
	saveConfig()

	FileClose($hLogFileHandle)
	FileClose($hAttackLogFileHandle)

	; Setup the profile in case it doesn't exist.
	setupProfile()

	readConfig()
	applyConfig()
	saveConfig()

	SetLog(_PadStringCenter("Profile " & $sCurrProfile & " loaded from " & $config, 50, "="), $COLOR_GREEN)
EndFunc   ;==>cmbProfile

Func btnAddConfirm()
	Switch @GUI_CtrlId
		Case $btnAdd
			GUICtrlSetState($cmbProfile, $GUI_HIDE)
			GUICtrlSetState($txtVillageName, $GUI_SHOW)
			GUICtrlSetState($btnAdd, $GUI_HIDE)
			GUICtrlSetState($btnConfirmAdd, $GUI_SHOW)
			GUICtrlSetState($btnDelete, $GUI_HIDE)
			GUICtrlSetState($btnCancel, $GUI_SHOW)
			GUICtrlSetState($btnConfirmRename, $GUI_HIDE)
			GUICtrlSetState($btnRename, $GUI_HIDE)
			; IceCube (Misc v1.0)
			GUICtrlSetState($btnRecycle, $GUI_HIDE)
			; IceCube (Misc v1.0)
		Case $btnConfirmAdd
			Local $newProfileName = StringRegExpReplace(GUICtrlRead($txtVillageName), '[/:*?"<>|]', '_')
			If FileExists($sProfilePath & "\" & $newProfileName) Then
				MsgBox($MB_ICONWARNING, GetTranslated(7,108, "Profile Already Exists"), $newProfileName & " " & GetTranslated(7,109, "already exists.") & @CRLF & GetTranslated(7,110, "Please choose another name for your profile"))
				Return
			EndIf

			$sCurrProfile = $newProfileName
			; Setup the profile if it doesn't exist.
			createProfile()
			setupProfileComboBox()
			setupProfileComboBoxswitch()
			selectProfile()
			GUICtrlSetState($txtVillageName, $GUI_HIDE)
			GUICtrlSetState($cmbProfile, $GUI_SHOW)
			GUICtrlSetState($btnAdd, $GUI_SHOW)
			GUICtrlSetState($btnConfirmAdd, $GUI_HIDE)
			GUICtrlSetState($btnDelete, $GUI_SHOW)
			GUICtrlSetState($btnCancel, $GUI_HIDE)
			GUICtrlSetState($btnConfirmRename, $GUI_HIDE)
			GUICtrlSetState($btnRename, $GUI_SHOW)
			; IceCube (Misc v1.0)
			GUICtrlSetState($btnRecycle, $GUI_SHOW)
			; IceCube (Misc v1.0)

			If GUICtrlGetState($btnDelete) <> $GUI_ENABLE Then GUICtrlSetState($btnDelete, $GUI_ENABLE)
			If GUICtrlGetState($btnRename) <> $GUI_ENABLE Then GUICtrlSetState($btnRename, $GUI_ENABLE)
			; IceCube (Misc v1.0)
			If GUICtrlGetState($btnRecycle) <> $GUI_ENABLE Then GUICtrlSetState($btnRecycle, $GUI_ENABLE)
			; IceCube (Misc v1.0)
			;DonateStats
			;InitDonateStats()
		Case Else
			SetLog("If you are seeing this log message there is something wrong.", $COLOR_RED)
	EndSwitch
EndFunc   ;==>btnAddConfirm

Func btnDeleteCancel()
	Switch @GUI_CtrlId
		Case $btnDelete
			Local $msgboxAnswer = MsgBox($MB_ICONWARNING + $MB_OKCANCEL, GetTranslated(7,111, "Delete Profile"), GetTranslated(7,112, "Are you sure you really want to delete the profile?") & @CRLF & GetTranslated(7,113, "This action can not be undone."))
			If $msgboxAnswer = $IDOK Then
				; Confirmed profile deletion so delete it.
				deleteProfile()
				setupProfileComboBox()
				setupProfileComboBoxswitch()
				selectProfile()
			EndIf
		Case $btnCancel
			GUICtrlSetState($txtVillageName, $GUI_HIDE)
			GUICtrlSetState($cmbProfile, $GUI_SHOW)
			GUICtrlSetState($btnConfirmAdd, $GUI_HIDE)
			GUICtrlSetState($btnAdd, $GUI_SHOW)
			GUICtrlSetState($btnCancel, $GUI_HIDE)
			GUICtrlSetState($btnDelete, $GUI_SHOW)
			GUICtrlSetState($btnConfirmRename, $GUI_HIDE)
			GUICtrlSetState($btnRename, $GUI_SHOW)
			; IceCube (Misc v1.0)
			GUICtrlSetState($btnRecycle, $GUI_SHOW)
			; IceCube (Misc v1.0)
		Case Else
			SetLog("If you are seeing this log message there is something wrong.", $COLOR_RED)
	EndSwitch

	If GUICtrlRead($cmbProfile) = "<No Profiles>" Then
		GUICtrlSetState($btnDelete, $GUI_DISABLE)
		GUICtrlSetState($btnRename, $GUI_DISABLE)
		; IceCube (Misc v1.0)
		GUICtrlSetState($btnRecycle, $GUI_DISABLE)
		; IceCube (Misc v1.0)
	EndIf
EndFunc   ;==>btnDeleteCancel

; IceCube (Misc v1.0)
Func btnRecycle()
	FileDelete($config)
	SaveConfig()
	SetLog("Profile " & $sCurrProfile & " was recycled with success", $COLOR_GREEN)
	SetLog("All unused settings were removed", $COLOR_GREEN)
EndFunc   ;==>btnRecycle
; IceCube (Misc v1.0)

Func btnRenameConfirm()
	Switch @GUI_CtrlId
		Case $btnRename
			GUICtrlSetData($txtVillageName, GUICtrlRead($cmbProfile))
			GUICtrlSetState($cmbProfile, $GUI_HIDE)
			GUICtrlSetState($txtVillageName, $GUI_SHOW)
			GUICtrlSetState($btnAdd, $GUI_HIDE)
			GUICtrlSetState($btnConfirmAdd, $GUI_HIDE)
			GUICtrlSetState($btnDelete, $GUI_HIDE)
			GUICtrlSetState($btnCancel, $GUI_SHOW)
			GUICtrlSetState($btnRename, $GUI_HIDE)
			GUICtrlSetState($btnConfirmRename, $GUI_SHOW)
			; IceCube (Misc v1.0)
			GUICtrlSetState($btnRecycle, $GUI_HIDE)
			; IceCube (Misc v1.0)
		Case $btnConfirmRename
			Local $newProfileName = StringRegExpReplace(GUICtrlRead($txtVillageName), '[/:*?"<>|]', '_')
			If FileExists($sProfilePath & "\" & $newProfileName) Then
				MsgBox($MB_ICONWARNING, GetTranslated(7,108, "Profile Already Exists"), $newProfileName & " " & GetTranslated(7,109, "already exists.") & @CRLF & GetTranslated(7,110, "Please choose another name for your profile"))
				Return
			EndIf

			$sCurrProfile = $newProfileName
			; Rename the profile.
			renameProfile()
			setupProfileComboBox()
			setupProfileComboBoxswitch()
			selectProfile()

			GUICtrlSetState($txtVillageName, $GUI_HIDE)
			GUICtrlSetState($cmbProfile, $GUI_SHOW)
			GUICtrlSetState($btnConfirmAdd, $GUI_HIDE)
			GUICtrlSetState($btnAdd, $GUI_SHOW)
			GUICtrlSetState($btnCancel, $GUI_HIDE)
			GUICtrlSetState($btnDelete, $GUI_SHOW)
			GUICtrlSetState($btnConfirmRename, $GUI_HIDE)
			GUICtrlSetState($btnRename, $GUI_SHOW)
			; IceCube (Misc v1.0)
			GUICtrlSetState($btnRecycle, $GUI_SHOW)
			; IceCube (Misc v1.0)
		Case Else
			SetLog("If you are seeing this log message there is something wrong.", $COLOR_RED)
	EndSwitch
EndFunc   ;==>btnRenameConfirm
Func setupProfileComboBoxswitch()
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbGoldMaxProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbGoldMaxProfile, $profileString, "<No Profiles>")
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbGoldMinProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbGoldMinProfile, $profileString, "<No Profiles>")
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbElixirMaxProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbElixirMaxProfile, $profileString, "<No Profiles>")
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbElixirMinProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbElixirMinProfile, $profileString, "<No Profiles>")
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbDEMaxProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbDEMaxProfile, $profileString, "<No Profiles>")
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbDEMinProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbDEMinProfile, $profileString, "<No Profiles>")
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbTrophyMaxProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbTrophyMaxProfile, $profileString, "<No Profiles>")
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbTrophyMinProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbTrophyMinProfile, $profileString, "<No Profiles>")
EndFunc   ;==>setupProfileComboBox
