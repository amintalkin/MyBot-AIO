Func ProfileSwitch()
	If $ichkGoldSwitchMax = 1 Or $ichkGoldSwitchMin = 1 Or $ichkElixirSwitchMax = 1 Or $ichkElixirSwitchMin = 1 Or _
	$ichkDESwitchMax = 1 Or $ichkDESwitchMin = 1 Or $ichkTrophySwitchMax = 1 Or $ichkTrophySwitchMin = 1 Then
		Local $SwitchtoProfile = ""
		While True
			If $ichkGoldSwitchMax = 1 Then
				If Number($iGoldCurrent) >= Number($itxtMaxGoldAmount) Then
					$SwitchtoProfile = $icmbGoldMaxProfile
					Setlog("Village Gold detected Above Gold Profile Switch Conditions")
					Setlog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $ichkGoldSwitchMin = 1 Then
				If Number($iGoldCurrent) < Number($itxtMinGoldAmount) And Number($iGoldCurrent) > 1 Then
					$SwitchtoProfile = $icmbGoldMinProfile
					Setlog("Village Gold detected Below Gold Profile Switch Conditions")
					Setlog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $ichkElixirSwitchMax = 1 Then
				If Number($iElixirCurrent) >= Number($itxtMaxElixirAmount) Then
					$SwitchtoProfile = $icmbElixirMaxProfile
					Setlog("Village Gold detected Above Elixir Profile Switch Conditions")
					Setlog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $ichkElixirSwitchMin = 1 Then
				If Number($iElixirCurrent) < Number($itxtMinElixirAmount) And Number($iElixirCurrent) > 1 Then
					$SwitchtoProfile = $icmbElixirMinProfile
					Setlog("Village Gold detected Below Elixir Switch Conditions")
					Setlog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $ichkDESwitchMax = 1 Then
				If Number($iDarkCurrent) >=	Number($itxtMaxDEAmount) Then
					$SwitchtoProfile = $icmbDEMaxProfile
					Setlog("Village Dark Elixir detected Above Dark Elixir Profile Switch Conditions")
					Setlog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $ichkDESwitchMin = 1 Then
				If Number($iDarkCurrent) < Number($itxtMinDEAmount) And Number($iDarkCurrent) > 1 Then
					$SwitchtoProfile = $icmbDEMinProfile
					Setlog("Village Dark Elixir detected Below Dark Elixir Profile Switch Conditions")
					Setlog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $ichkTrophySwitchMax = 1 Then
				If Number($iTrophyCurrent) >= Number($itxtMaxTrophyAmount) Then
					$SwitchtoProfile = $icmbTrophyMaxProfile
					Setlog("Village Trophies detected Above Throphy Profile Switch Conditions")
					Setlog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $ichkTrophySwitchMin = 1 Then
				If Number($iTrophyCurrent) < Number($itxtMinTrophyAmount) And Number($iTrophyCurrent) > 1 Then
					$SwitchtoProfile = $icmbTrophyMinProfile
					Setlog("Village Trophies detected Below Trophy Profile Switch Conditions")
					Setlog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			ExitLoop
		WEnd

		If $SwitchtoProfile <> "" Then
				TrayTip( " Profile Switch Village Report!", "Gold: "  & _NumberFormat($iGoldCurrent) & "; Elixir: " &  _NumberFormat($iElixirCurrent) & "; Dark: " &  _NumberFormat($iDarkCurrent) & "; Trophy: " & _NumberFormat($iTrophyCurrent), "", 0)
				If FileExists(@ScriptDir & "\Audio\SwitchingProfiles.wav") Then
					SoundPlay(@ScriptDir & "\Audio\SwitchingProfiles.wav", 1)
				ElseIf FileExists(@WindowsDir & "\media\tada.wav") Then
					SoundPlay(@WindowsDir & "\media\tada.wav", 1)
				EndIf

			_GUICtrlComboBox_SetCurSel($cmbProfile, $SwitchtoProfile)
			cmbProfile()
			If _Sleep(2000) Then Return
			runBot()
		EndIf
	EndIf

EndFunc