; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design
; Description ...: This file Includes GUI Design
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
Global $txtPresetSaveFilename, $txtSavePresetMessage, $lblLoadPresetMessage,$btnGUIPresetDeleteConf, $chkCheckDeleteConf
Global $cmbPresetList, $txtPresetMessage,$btnGUIPresetLoadConf,  $lblLoadPresetMessage,$btnGUIPresetDeleteConf, $chkCheckDeleteConf

$hGUI_Profiles = GUICreate("", $_GUI_MAIN_WIDTH - 28, $_GUI_MAIN_HEIGHT - 255 - 28, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $hGUI_BOT)
GUISetBkColor($COLOR_WHITE, $hGUI_Profiles)

GUISwitch($hGUI_Profiles)



;$tabProfiles = GUICtrlCreateTabItem(GetTranslated(19,33,"Switch Profiles"))

Local $x = 20, $y = 25
	$grpProfiles = GUICtrlCreateGroup(GetTranslated(7,26, "Switch Profiles"), $x - 20, $y - 20, 438, 45)
		$y -= 0
		$lblProfile = GUICtrlCreateLabel(GetTranslated(19,2,"Current Profile:"), $x - 10, $y, -1, -1)
		$cmbProfile = GUICtrlCreateCombo("", $x + 75, $y - 5, 220, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip =GetTranslated(19,3, "Use this to switch to a different profile") & @CRLF & GetTranslated(19,4,"Your profiles can be found in") & ": " & @CRLF &  $sProfilePath
			GUICtrlSetTip(-1, $txtTip)
			setupProfileComboBox()
			GUICtrlSetState(-1, $GUI_SHOW)
			GUICtrlSetOnEvent(-1, "cmbProfile")
		$txtVillageName = GUICtrlCreateInput(GetTranslated(19,5,"MyVillage"), $x + 75, $y - 4, 220, 20, BitOR($SS_CENTER, $ES_AUTOHSCROLL))
			GUICtrlSetLimit (-1, 100, 0)
			GUICtrlSetFont(-1, 9, 400, 1)
			GUICtrlSetTip(-1, GetTranslated(7,31, "Your village/profile's name"))
			GUICtrlSetState(-1, $GUI_HIDE)
			; GUICtrlSetOnEvent(-1, "txtVillageName") - No longer needed

		$bIconAdd = _GUIImageList_Create(22, 22, 4)
			_GUIImageList_AddBitmap($bIconAdd, @ScriptDir & "\images\Button\iconAdd.bmp")
			_GUIImageList_AddBitmap($bIconAdd, @ScriptDir & "\images\Button\iconAdd_2.bmp")
			_GUIImageList_AddBitmap($bIconAdd, @ScriptDir & "\images\Button\iconAdd_2.bmp")
			_GUIImageList_AddBitmap($bIconAdd, @ScriptDir & "\images\Button\iconAdd_4.bmp")
			_GUIImageList_AddBitmap($bIconAdd, @ScriptDir & "\images\Button\iconAdd.bmp")
		$bIconConfirm = _GUIImageList_Create(22, 22, 4)
			_GUIImageList_AddBitmap($bIconConfirm, @ScriptDir & "\images\Button\iconConfirm.bmp")
			_GUIImageList_AddBitmap($bIconConfirm, @ScriptDir & "\images\Button\iconConfirm_2.bmp")
			_GUIImageList_AddBitmap($bIconConfirm, @ScriptDir & "\images\Button\iconConfirm_2.bmp")
			_GUIImageList_AddBitmap($bIconConfirm, @ScriptDir & "\images\Button\iconConfirm_4.bmp")
			_GUIImageList_AddBitmap($bIconConfirm, @ScriptDir & "\images\Button\iconConfirm.bmp")
		$bIconDelete = _GUIImageList_Create(22, 22, 4)
			_GUIImageList_AddBitmap($bIconDelete, @ScriptDir & "\images\Button\iconDelete.bmp")
			_GUIImageList_AddBitmap($bIconDelete, @ScriptDir & "\images\Button\iconDelete_2.bmp")
			_GUIImageList_AddBitmap($bIconDelete, @ScriptDir & "\images\Button\iconDelete_2.bmp")
			_GUIImageList_AddBitmap($bIconDelete, @ScriptDir & "\images\Button\iconDelete_4.bmp")
			_GUIImageList_AddBitmap($bIconDelete, @ScriptDir & "\images\Button\iconDelete.bmp")
		$bIconCancel = _GUIImageList_Create(22, 22, 4)
			_GUIImageList_AddBitmap($bIconCancel, @ScriptDir & "\images\Button\iconCancel.bmp")
			_GUIImageList_AddBitmap($bIconCancel, @ScriptDir & "\images\Button\iconCancel_2.bmp")
			_GUIImageList_AddBitmap($bIconCancel, @ScriptDir & "\images\Button\iconCancel_2.bmp")
			_GUIImageList_AddBitmap($bIconCancel, @ScriptDir & "\images\Button\iconCancel_4.bmp")
			_GUIImageList_AddBitmap($bIconCancel, @ScriptDir & "\images\Button\iconCancel.bmp")
		$bIconEdit = _GUIImageList_Create(22, 22, 4)
			_GUIImageList_AddBitmap($bIconEdit, @ScriptDir & "\images\Button\iconEdit.bmp")
			_GUIImageList_AddBitmap($bIconEdit, @ScriptDir & "\images\Button\iconEdit_2.bmp")
			_GUIImageList_AddBitmap($bIconEdit, @ScriptDir & "\images\Button\iconEdit_2.bmp")
			_GUIImageList_AddBitmap($bIconEdit, @ScriptDir & "\images\Button\iconEdit_4.bmp")
			_GUIImageList_AddBitmap($bIconEdit, @ScriptDir & "\images\Button\iconEdit.bmp")
		; IceCube (Misc v1.0)
		$bIconRecycle = _GUIImageList_Create(22, 22, 4)
			_GUIImageList_AddBitmap($bIconRecycle, @ScriptDir & "\images\Button\iconRecycle.bmp")
			_GUIImageList_AddBitmap($bIconRecycle, @ScriptDir & "\images\Button\iconRecycle_2.bmp")
			_GUIImageList_AddBitmap($bIconRecycle, @ScriptDir & "\images\Button\iconRecycle_2.bmp")
			_GUIImageList_AddBitmap($bIconRecycle, @ScriptDir & "\images\Button\iconRecycle_4.bmp")
			_GUIImageList_AddBitmap($bIconRecycle, @ScriptDir & "\images\Button\iconRecycle.bmp")
		; IceCube (Misc v1.0)
			
		$btnAdd = GUICtrlCreateButton("", $x + 300, $y - 5, 22, 22)
			_GUICtrlButton_SetImageList($btnAdd, $bIconAdd, 4)
			GUICtrlSetOnEvent(-1, "btnAddConfirm")
			GUICtrlSetState(-1, $GUI_SHOW)
			GUICtrlSetTip(-1, GetTranslated(7,103, "Add New Profile"))
		$btnConfirmAdd = GUICtrlCreateButton("", $x + 300, $y - 5, 22, 22)
			_GUICtrlButton_SetImageList($btnConfirmAdd, $bIconConfirm, 4)
			GUICtrlSetOnEvent(-1, "btnAddConfirm")
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, GetTranslated(7,104, "Confirm"))
		$btnConfirmRename = GUICtrlCreateButton("", $x + 300, $y - 5, 22, 22)
			_GUICtrlButton_SetImageList($btnConfirmRename, $bIconConfirm, 4)
			GUICtrlSetOnEvent(-1, "btnRenameConfirm")
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, GetTranslated(7,104, "Confirm"))
		$btnDelete = GUICtrlCreateButton("", $x + 327, $y - 5, 22, 22)
			_GUICtrlButton_SetImageList($btnDelete, $bIconDelete, 4)
			GUICtrlSetOnEvent(-1, "btnDeleteCancel")
			GUICtrlSetState(-1, $GUI_SHOW)
			GUICtrlSetTip(-1, GetTranslated(7,105, "Delete Profile"))
			If GUICtrlRead($cmbProfile) = "<No Profiles>" Then
				GUICtrlSetState(-1, $GUI_DISABLE)
			Else
				GUICtrlSetState(-1, $GUI_ENABLE)
			EndIf

		$btnCancel = GUICtrlCreateButton("", $x + 327, $y - 5, 22, 22)
			_GUICtrlButton_SetImageList($btnCancel, $bIconCancel, 4)
			GUICtrlSetOnEvent(-1, "btnDeleteCancel")
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, GetTranslated(7,106, "Cancel"))
		$btnRename = GUICtrlCreateButton("", $x + 355, $y - 5, 22, 22)
			_GUICtrlButton_SetImageList($btnRename, $bIconEdit, 4)
			GUICtrlSetOnEvent(-1, "btnRenameConfirm")
			GUICtrlSetTip(-1, GetTranslated(7,107, "Rename Profile"))
			If GUICtrlRead($cmbProfile) = "<No Profiles>" Then
				GUICtrlSetState(-1, $GUI_DISABLE)
			Else
				GUICtrlSetState(-1, $GUI_ENABLE)
			EndIf
		; IceCube (Misc v1.0)
		$btnRecycle = GUICtrlCreateButton("", $x + 383, $y - 5, 22, 22)
			_GUICtrlButton_SetImageList($btnRecycle, $bIconRecycle, 4)
			GUICtrlSetOnEvent(-1, "btnRecycle")
			GUICtrlSetState(-1, $GUI_SHOW)
			GUICtrlSetTip(-1, "Recycle Profile by removing all settings no longer suported that could lead to bad behaviour")
			If GUICtrlRead($cmbProfile) = "<No Profiles>" Then
				GUICtrlSetState(-1, $GUI_DISABLE)
			Else
				GUICtrlSetState(-1, $GUI_ENABLE)
			EndIf			
		; IceCube (Misc v1.0)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

		$y -= 5

Local $x = 20, $y = 75
	$grpGoldSwitch = GUICtrlCreateGroup(GetTranslated(19,7,"Gold Switch Profile Conditions"), $x - 20, $y - 20, 438, 75) ;Gold Switch
		$chkGoldSwitchMax = GUICtrlCreateCheckbox(GetTranslated(19,8,"Switch To"), $x-10, $y - 5, -1, -1)
			$txtTip = GetTranslated(19,9,"Enable this to switch profiles when gold is above amount.")
			GUICtrlSetTip(-1, $txtTip)
		$cmbGoldMaxProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(19,10,"Select which profile to be switched to when conditions met")
			GUICtrlSetTip(-1, $txtTip)
		$lblGoldMax = GUICtrlCreateLabel(GetTranslated(19,11,"When Gold is Above"), $x + 145, $y, -1, -1)
		$txtMaxGoldAmount = GUICtrlCreateInput("6000000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(19,12,"Set the amount of Gold to trigger switching Profile.")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 7)
$y += 30
		$chkGoldSwitchMin = GUICtrlCreateCheckbox(GetTranslated(19,8,"Switch To"), $x-10, $y - 5, -1, -1)
			$txtTip = GetTranslated(19,13,"Enable this to switch profiles when gold is below amount.")
			GUICtrlSetTip(-1, $txtTip)
		$cmbGoldMinProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(19,10,"Select which profile to be switched to when conditions met")
			GUICtrlSetTip(-1, $txtTip)
		$lblGoldMin = GUICtrlCreateLabel(GetTranslated(19,14,"When Gold is Below"), $x + 145, $y, -1, -1)
		$txtMinGoldAmount = GUICtrlCreateInput("500000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(19,12,"Set the amount of Gold to trigger switching Profile.")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 7)
		;$picProfileGold = GUICtrlCreateIcon($pIconLib, $eIcnGold, $x + 360, $y - 40, 64, 64)
		;$picProfileGold = GUICtrlCreateIcon($pIconLib, $eIcnGold, $x + 350, $y - 30, 16, 16)
		;$picProfileGold = GUICtrlCreateIcon($pIconLib, $eIcnGold, $x + 330, $y - 15, 32, 32)
		$picProfileGold = GUICtrlCreatePic(@ScriptDir & "\Images\GoldStorage.jpg", $x + 350, $y - 40, 60, 60)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
$y += 48
	$grpElixirSwitch = GUICtrlCreateGroup(GetTranslated(19,15,"Elixir Switch Profile Conditions"), $x - 20, $y - 20, 438, 75) ; Elixir Switch
		$chkElixirSwitchMax = GUICtrlCreateCheckbox(GetTranslated(19,8,"Switch To"), $x-10, $y - 5, -1, -1)
			$txtTip = GetTranslated(19,16,"Enable this to switch profiles when Elixir is above amount.")
			GUICtrlSetTip(-1, $txtTip)

		$cmbElixirMaxProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(19,10,"Select which profile to be switched to when conditions met")
			GUICtrlSetTip(-1, $txtTip)
		$lblElixirMax = GUICtrlCreateLabel(GetTranslated(19,17,"When Elixir is Above"), $x + 145, $y, -1, -1)
		$txtMaxElixirAmount = GUICtrlCreateInput("6000000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(19,18,"Set the amount of Elixir to trigger switching Profile.")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 7)
$y += 30
		$chkElixirSwitchMin = GUICtrlCreateCheckbox(GetTranslated(19,8,"Switch To"), $x-10, $y - 5, -1, -1)
			$txtTip = GetTranslated(19,19,"Enable this to switch profiles when Elixir is below amount.")
			GUICtrlSetTip(-1, $txtTip)
		$cmbElixirMinProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(19,10,"Select which profile to be switched to when conditions met")
			GUICtrlSetTip(-1, $txtTip)
		$lblElixirMin = GUICtrlCreateLabel(GetTranslated(19,20,"When Elixir is Below"), $x + 145, $y, -1, -1)
		$txtMinElixirAmount = GUICtrlCreateInput("500000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(19,18,"Set the amount of Elixir to trigger switching Profile.")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 7)
		;$picProfileElixir = GUICtrlCreateIcon($pIconLib, $eIcnElixir, $x + 360, $y - 40, 64, 64)
		;$picProfileElixir = GUICtrlCreateIcon($pIconLib, $eIcnElixir, $x + 350, $y - 30, 16, 16)
		;$picProfileElixir = GUICtrlCreateIcon($pIconLib, $eIcnElixir, $x + 330, $y - 15, 32, 32)
		$picProfileElixir = GUICtrlCreatePic(@ScriptDir & "\Images\ElixirStorage.jpg", $x + 350, $y - 40, 60, 60)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
$y += 48
	$grpDESwitch = GUICtrlCreateGroup(GetTranslated(19,21,"Dark Elixir Switch Profile Conditions"), $x - 20, $y - 20, 438, 75) ;DE Switch
		$chkDESwitchMax = GUICtrlCreateCheckbox(GetTranslated(19,8,"Switch To"), $x-10, $y - 5, -1, -1)
			$txtTip = GetTranslated(19,22,"Enable this to switch profiles when Dark Elixir is above amount.")
			GUICtrlSetTip(-1, $txtTip)
		$cmbDEMaxProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(19,10,"Select which profile to be switched to when conditions met")
			GUICtrlSetTip(-1, $txtTip)
		$lblDEMax = GUICtrlCreateLabel(GetTranslated(19,23,"When Dark Elixir is Above"), $x + 145, $y, -1, -1)
		$txtMaxDEAmount = GUICtrlCreateInput("200000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(19,24,"Set the amount of Dark Elixir to trigger switching Profile.")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
$y += 30
		$chkDESwitchMin = GUICtrlCreateCheckbox(GetTranslated(19,8,"Switch To"), $x-10, $y - 5, -1, -1)
			$txtTip = GetTranslated(19,25,"Enable this to switch profiles when Dark Elixir is below amount.")
			GUICtrlSetTip(-1, $txtTip)
		$cmbDEMinProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(19,10,"Select which profile to be switched to when conditions met")
			GUICtrlSetTip(-1, $txtTip)
		$lblDEMin = GUICtrlCreateLabel(GetTranslated(19,26,"When  Dark Elixir is Below"), $x + 145, $y, -1, -1)
		$txtMinDEAmount = GUICtrlCreateInput("10000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(19,24,"Set the amount of Dark Elixir to trigger switching Profile.")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
		;$picProfileDE = GUICtrlCreateIcon($pIconLib, $eIcnDark, $x + 360, $y - 40, 64, 64)
		;$picProfileDE = GUICtrlCreateIcon($pIconLib, $eIcnDark, $x + 350, $y - 30, 16, 16)
		;$picProfileDE = GUICtrlCreateIcon($pIconLib, $eIcnDark, $x + 330, $y - 15, 32, 32)
		$picProfileDE = GUICtrlCreatePic(@ScriptDir & "\Images\DEStorage.jpg", $x + 350, $y - 40, 60, 60)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
$y += 48
	$grpTrophySwitch = GUICtrlCreateGroup(GetTranslated(19,27,"Trophy Switch Profile Conditions"), $x - 20, $y - 20, 438, 75) ; Trophy Switch
		$chkTrophySwitchMax = GUICtrlCreateCheckbox(GetTranslated(19,8,"Switch To"), $x-10, $y - 5, -1, -1)
			$txtTip = GetTranslated(19,28,"Enable this to switch profiles when Trophies are above amount.")
			GUICtrlSetTip(-1, $txtTip)
		$cmbTrophyMaxProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(19,10,"Select which profile to be switched to when conditions met")
			GUICtrlSetTip(-1, $txtTip)
		$lblTrophyMax = GUICtrlCreateLabel(GetTranslated(19,29,"When Trophies are Above"), $x + 145, $y, -1, -1)
		$txtMaxTrophyAmount = GUICtrlCreateInput("3000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(19,30,"Set the amount of Trophies to trigger switching Profile.")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 4)
$y += 30
		$chkTrophySwitchMin = GUICtrlCreateCheckbox(GetTranslated(19,8,"Switch To"), $x-10, $y - 5, -1, -1)
			$txtTip = GetTranslated(19,31,"Enable this to switch profiles when Trophies are below amount.")
			GUICtrlSetTip(-1, $txtTip)
		$cmbTrophyMinProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(19,10,"Select which profile to be switched to when conditions met")
			GUICtrlSetTip(-1, $txtTip)
		$lblTrophyMin = GUICtrlCreateLabel(GetTranslated(19,32,"When Trophies are Below"), $x + 145, $y, -1, -1)
		$txtMinTrophyAmount = GUICtrlCreateInput("1000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(19,30,"Set the amount of Trophies to trigger switching Profile.")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 4)
		;$picProfileTrophy = GUICtrlCreateIcon($pIconLib, $eIcnTrophy, $x + 360, $y - 40, 64, 64)
		;$picProfileTrophy = GUICtrlCreateIcon($pIconLib, $eIcnTrophy, $x + 345, $y - 35, 16, 16)
		;$picProfileTrophy = GUICtrlCreateIcon($pIconLib, $eIcnTrophy, $x + 330, $y - 15, 32, 32)
		$picProfileTrophy = GUICtrlCreatePic(@ScriptDir & "\Images\TrophyLeague.jpg", $x + 350, $y - 40, 60, 60)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
		setupProfileComboBoxswitch()
GUICtrlCreateTabItem("")