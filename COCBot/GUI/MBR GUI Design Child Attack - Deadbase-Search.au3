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

Local $x = 25, $y = 45
	$grpDBActivate = GUICtrlCreateGroup(GetTranslated(625,0, "Start Search IF"), $x - 20, $y - 20, 190, 305)
		$x -= 15
		$chkDBActivateSearches = GUICtrlCreateCheckbox(GetTranslated(625,1,"Search"), $x, $y, 68, 18)
			GUICtrlSetState(-1,$GUI_CHECKED)
			GUICtrlSetOnEvent(-1, "chkDBActivateSearches")
		$txtDBSearchesMin = GUICtrlCreateInput("1", $x + 70, $y, 40, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(625,2, "Set the Min. number of searches to activate this option")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
		$lblDBSearches = GUICtrlCreateLabel("-", $x + 113, $y + 2, -1, -1)
		$txtDBSearchesMax = GUICtrlCreateInput("9999", $x + 120, $y, 40, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER)) ;ChrW(8734)
			$txtTip = GetTranslated(625,3, "Set the Max number of searches to activate this option")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
		$picDBSearches = GUICtrlCreateIcon($pIconLib, $eIcnMagnifier, $x + 163, $y + 1, 16, 16)
	$y += 21
		$chkDBActivateTropies = GUICtrlCreateCheckbox(GetTranslated(625,4,"Trophies"), $x, $y, 68, 18)
			GUICtrlSetOnEvent(-1, "chkDBActivateTropies")
		$txtDBTropiesMin = GUICtrlCreateInput("0", $x + 70, $y, 40, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetState(-1,$GUI_DISABLE)
			$txtTip = GetTranslated(625,5, "Set the Min. number of tropies to activate this option")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
		$lblDBTropies = GUICtrlCreateLabel("-", $x + 113, $y + 2, -1, -1)
			GUICtrlSetState(-1,$GUI_DISABLE)
		$txtDBTropiesMax = GUICtrlCreateInput("6000", $x + 120, $y, 40, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetState(-1,$GUI_DISABLE)
			$txtTip = GetTranslated(625,6, "Set the Max number of tropies to activate this option")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
		$picDBTrophies = GUICtrlCreateIcon($pIconLib, $eIcnTrophy, $x + 163, $y + 1, 16, 16)
	$y +=21
		$chkDBActivateCamps = GUICtrlCreateCheckbox(GetTranslated(625,7, "Army Camps"), $x, $y, 110, 18)
			$txtTip = GetTranslated(625,8, "Set the % Army camps before activate this option")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkDBActivateCamps")
		$lblDBArmyCamps = GUICtrlCreateLabel(ChrW(8805), $x + 113 - 1, $y + 2, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1,$GUI_DISABLE)
		$txtDBArmyCamps = GUICtrlCreateInput("80", $x + 120, $y, 40, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1,$GUI_DISABLE)
			GUICtrlSetLimit(-1, 6)
		$txtDBArmyCampsPerc = GUICtrlCreateLabel("%", $x + 163 + 3, $y + 4, -1, -1)
			GUICtrlSetState(-1,$GUI_DISABLE)
	$y +=23
		$picDBHeroesWait = GUICtrlCreateIcon($pIconLib, $eIcnHourGlass, $x - 1, $y + 3, 16, 16)
		$txtDBHeroesWait = GUICtrlCreateLabel(GetTranslated(625,9,"Wait for Heroes to be Ready") & ":", $x + 20, $y + 4, 180, 18)
	$y += 20
	$x += 20
		$chkDBKingWait = GUICtrlCreateCheckbox("", $x, $y + 55, 16, 16)
			Local $sTxtKingWait = GetTranslated(625,50, "Wait for Hero option disabled when continuous Upgrade Hero selected!")
			$txtTip = GetTranslated(625,10, "Wait for King to be ready before attacking...") & @CRLF & $sTxtKingWait & @CRLF & GetTranslated(625,51, "Enabled with TownHall 7 and higher")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkDBKingWait")
		$IMGchkDBKingWait=GUICtrlCreateIcon($pIconLib, $eIcnKing, $x - 18, $y + 4, 48, 48)
			GUICtrlSetTip(-1, $txtTip)
		$IMGchkDBKingSleepWait=GUICtrlCreateIcon($pIconLib, $eIcnSleepingKing, $x - 18, $y + 4, 48, 48)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1,$GUI_HIDE)
	$x += 55
		$chkDBQueenWait = GUICtrlCreateCheckbox("", $x, $y + 55, 16, 16)
			$txtTip = GetTranslated(625,12, "Wait for Queen to be ready before attacking...") & @CRLF & $sTxtKingWait & @CRLF & GetTranslated(625,52, "Enabled with TownHall 9 and higher")
			GUICtrlSetTip(-1, $txtTip)
 			GUICtrlSetOnEvent(-1, "chkDBQueenWait")
		$IMGchkDBQueenWait=GUICtrlCreateIcon($pIconLib, $eIcnQueen, $x - 18, $y + 4, 48, 48)
			GUICtrlSetTip(-1, $txtTip)
		$IMGchkDBQueenSleepWait=GUICtrlCreateIcon($pIconLib, $eIcnSleepingQueen, $x - 18, $y + 4, 48, 48)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1,$GUI_HIDE)
	$x += 55
		$chkDBWardenWait = GUICtrlCreateCheckbox("", $x, $y + 55, 16, 16)
 			$txtTip = GetTranslated(625,13, "Wait for Warden to be ready before attacking...") & @CRLF & $sTxtKingWait & @CRLF & GetTranslated(625,53, "Enabled with TownHall 11")
 			GUICtrlSetTip(-1, $txtTip)
 			GUICtrlSetOnEvent(-1, "chkDBWardenWait")
		$IMGchkDBWardenWait=GUICtrlCreateIcon($pIconLib, $eIcnWarden, $x - 18, $y + 4, 48, 48)
 			GUICtrlSetTip(-1, $txtTip)
		$IMGchkDBWardenSleepWait=GUICtrlCreateIcon($pIconLib, $eIcnSleepingWarden, $x - 18, $y + 4, 48, 48)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1,$GUI_HIDE)
			
	;mikemikemikecoc - Wait For Spells
	$y += 80
	$x = 10
	    $chkDBSpellsWait = GUICtrlCreateCheckbox("Wait for Spells to be Ready", $x, $y, -1, -1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

Local $x = 220, $y = 45
	$grpDBFilter = GUICtrlCreateGroup(GetTranslated(625,14, "Filters"), $x - 20, $y - 20, 225, 305)
		$x -= 15
		$cmbDBMeetGE = GUICtrlCreateCombo("", $x , $y + 10, 65, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(625,15, "Search for a base that meets the values set for Gold And/Or/Plus Elixir.") & @CRLF & GetTranslated(625,16, "AND: Both conditions must meet, Gold and Elixir.") & @CRLF & GetTranslated(625,17, "OR: One condition must meet, Gold or Elixir.") & @CRLF & GetTranslated(625,18, "+ (PLUS): Total amount of Gold + Elixir must meet.")
			GUICtrlSetData(-1, GetTranslated(625,19, "G And E") &"|" & GetTranslated(625,20, "G Or E") & "|" & GetTranslated(625,21, "G + E"), GetTranslated(625,19, -1))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "cmbDBGoldElixir")
		$txtDBMinGold = GUICtrlCreateInput("80000", $x + 85, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(625,23, "Set the Min. amount of Gold to search for on a village to attack.")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
		$picDBMinGold = GUICtrlCreateIcon($pIconLib, $eIcnGold, $x + 140, $y, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
		$y += 21
		$txtDBMinElixir = GUICtrlCreateInput("80000", $x + 85, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(625,24, "Set the Min. amount of Elixir to search for on a village to attack.")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
		$picDBMinElixir = GUICtrlCreateIcon($pIconLib, $eIcnElixir, $x + 140, $y, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
		$y -= 11
		$txtDBMinGoldPlusElixir = GUICtrlCreateInput("160000", $x + 85, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(625,25, "Set the Min. amount of Gold + Elixir to search for on a village to attack.")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
			GUICtrlSetState (-1, $GUI_HIDE)
 		$picDBMinGPEGold = GUICtrlCreateIcon($pIconLib, $eIcnGoldElixir, $x + 140, $y + 1, 16, 16)
 			GUICtrlSetTip(-1, $txtTip)
 			GUICtrlSetState (-1, $GUI_HIDE)
		$y += 34
		$chkDBMeetDE = GUICtrlCreateCheckbox(GetTranslated(625,26, "Dark Elixir"), $x , $y, -1, -1)
			$txtTip = GetTranslated(625,27, "Search for a base that meets the value set for Min. Dark Elixir.")
			GUICtrlSetOnEvent(-1, "chkDBMeetDE")
			GUICtrlSetTip(-1, $txtTip)
		$txtDBMinDarkElixir = GUICtrlCreateInput("0", $x + 85, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(625,28, "Set the Min. amount of Dark Elixir to search for on a village to attack.")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 5)
			_GUICtrlEdit_SetReadOnly(-1, True)
		$picDBMinDarkElixir = GUICtrlCreateIcon($pIconLib, $eIcnDark, $x + 140, $y, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
		$y += 24
		$chkDBMeetTrophy = GUICtrlCreateCheckbox(GetTranslated(625,4, -1), $x, $y, -1, -1)
			$txtTip = GetTranslated(625,29, "Search for a base that meets the value set for Min. Trophies.")
			GUICtrlSetOnEvent(-1, "chkDBMeetTrophy")
			GUICtrlSetTip(-1, $txtTip)
		$txtDBMinTrophy = GUICtrlCreateInput("0", $x + 85, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(625,30, "Set the Min. amount of Trophies to search for on a village to attack.")
			GUICtrlSetTip(-1, $txtTip)
			_GUICtrlEdit_SetReadOnly(-1, True)
			GUICtrlSetLimit(-1, 2)
		$picDBMinTrophies = GUICtrlCreateIcon($pIconLib, $eIcnTrophy, $x + 140, $y, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
		$y += 24
		$chkDBMeetTH = GUICtrlCreateCheckbox(GetTranslated(625,31, "Townhall"), $x, $y, -1, -1)
			$txtTip = GetTranslated(625,32, "Search for a base that meets the value set for Max. Townhall Level.")
			GUICtrlSetOnEvent(-1, "chkDBMeetTH")
			GUICtrlSetTip(-1, $txtTip)
		$cmbDBTH = GUICtrlCreateCombo("", $x + 85, $y - 1, 50, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(625,33, "Set the Max. level of the Townhall to search for on a village to attack.")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetData(-1, "4-6|7|8|9|10|11", "4-6")
		$picDBMaxTH10 = GUICtrlCreateIcon($pIconLib, $eIcnTH10, $x + 140, $y - 3, 24, 24)
			GUICtrlSetTip(-1, $txtTip)
		$y += 24
		$chkDBMeetTHO = GUICtrlCreateCheckbox(GetTranslated(625,34, "Townhall Outside"), $x, $y, -1, -1)
			$txtTip = GetTranslated(625,35, "Search for a base that has an exposed Townhall. (Outside of Walls)")
			GUICtrlSetTip(-1, $txtTip)
		$y += 24
		$chkDBWeakBase = GUICtrlCreateCheckbox(GetTranslated(625,36, "WeakBase"), $x, $y, -1, -1)
			$txtTip = GetTranslated(625,37, "Search for a base that has low defences.")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkDBWeakBase")
		$cmbDBWeakMortar = GUICtrlCreateCombo("", $x + 85, $y, 50, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(625,38, "Set the Max. level of the Mortar to search for on a village to attack.")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "-|Lvl 1|Lvl 2|Lvl 3|Lvl 4|Lvl 5|Lvl 6|Lvl 7|Lvl 8|Lvl 9", "Lvl 5")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$picDBWeakMortar = GUICtrlCreateIcon($pIconLib, $eIcnMortar, $x + 140, $y - 2, 24, 24)
			GUICtrlSetTip(-1, $txtTip)
		$y +=24
		$cmbDBWeakWizTower = GUICtrlCreateCombo("", $x + 85, $y, 50, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(625,39, "Set the Max. level of the Wizard Tower to search for on a village to attack.")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "-|Lvl 1|Lvl 2|Lvl 3|Lvl 4|Lvl 5|Lvl 6|Lvl 7|Lvl 8|Lvl 9", "Lvl 4")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$picDBWeakWizTower = GUICtrlCreateIcon($pIconLib, $eIcnWizTower, $x + 140, $y - 2, 24, 24)
			GUICtrlSetTip(-1, $txtTip)
		$y += 21
		$chkDBMeetOne = GUICtrlCreateCheckbox(GetTranslated(625,40, "Meet One Then Attack"), $x, $y, -1, -1)
			$txtTip = GetTranslated(625,41, "Just meet only ONE of the above conditions, then Attack.")
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
