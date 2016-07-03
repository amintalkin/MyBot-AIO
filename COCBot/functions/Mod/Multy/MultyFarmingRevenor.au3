; #FUNCTION# ====================================================================================================================
; Name ..........: Detect Account, Switch Account, And Switch Donate With Smart Switch
; Description ...:
; Syntax ........:
; Parameters ....:
; Return values .:
; Author ........: Lakereng (2016)
; Modified ......: IceCube and TheRevenor (2016)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

 Func DetectAccount()

	While 1
		ZoomOut()
	ExitLoop
	WEnd
	Sleep (2000)

	_CaptureRegion()

Local $hBMP_Cropped = _GDIPlus_BitmapCloneArea($hBitmap, 0, 0,  200, 18)
Local $hHBMP_Cropped = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBMP_Cropped)

If  Not FileExists(@ScriptDir & "\images\Multyfarming\main.bmp") Then
	 _GDIPlus_ImageSaveToFile($hBMP_Cropped, @ScriptDir & "\images\Multyfarming\main.bmp")
ElseIf  Not FileExists(@ScriptDir & "\images\Multyfarming\Second.bmp") Then
	 _GDIPlus_ImageSaveToFile($hBMP_Cropped, @ScriptDir & "\images\Multyfarming\Second.bmp")
ElseIf  Not FileExists(@ScriptDir & "\images\Multyfarming\Third.bmp") And ($iAccount = "3" Or $iAccount = "4" Or $iAccount = "5" Or $iAccount = "6") Then

	 _GDIPlus_ImageSaveToFile($hBMP_Cropped, @ScriptDir & "\images\Multyfarming\Third.bmp")
ElseIf  Not FileExists(@ScriptDir & "\images\Multyfarming\Fourth.bmp") And ($iAccount = "4" Or $iAccount = "5" Or $iAccount = "6") Then

	 _GDIPlus_ImageSaveToFile($hBMP_Cropped, @ScriptDir & "\images\Multyfarming\Fourth.bmp")
ElseIf  Not FileExists(@ScriptDir & "\images\Multyfarming\Fifth.bmp") And ($iAccount = "5" Or $iAccount = "6") Then

	 _GDIPlus_ImageSaveToFile($hBMP_Cropped, @ScriptDir & "\images\Multyfarming\Fifth.bmp")
ElseIf  Not FileExists(@ScriptDir & "\images\Multyfarming\Sixth.bmp") And $iAccount = "6" Then

	 _GDIPlus_ImageSaveToFile($hBMP_Cropped, @ScriptDir & "\images\Multyfarming\Sixth.bmp")
EndIf

If FileExists(@ScriptDir & "\images\Multyfarming\temp.bmp") Then
   FileDelete(@ScriptDir & "\images\Multyfarming\temp.bmp")
EndIf

	  _GDIPlus_ImageSaveToFile($hBMP_Cropped, @ScriptDir & "\images\Multyfarming\temp.bmp")
	  _GDIPlus_ImageDispose($hBitmap)

$bm1 = _GDIPlus_ImageLoadFromFile (@ScriptDir & "\images\Multyfarming\main.bmp")
$bm3 = _GDIPlus_ImageLoadFromFile (@ScriptDir & "\images\Multyfarming\Second.bmp")
$bm2 = _GDIPlus_ImageLoadFromFile (@ScriptDir & "\images\Multyfarming\temp.bmp")
$bm4 = _GDIPlus_ImageLoadFromFile (@ScriptDir & "\images\Multyfarming\Third.bmp")
$bm5 = _GDIPlus_ImageLoadFromFile (@ScriptDir & "\images\Multyfarming\Fourth.bmp")
$bm6 = _GDIPlus_ImageLoadFromFile (@ScriptDir & "\images\Multyfarming\Fifth.bmp")
$bm7 = _GDIPlus_ImageLoadFromFile (@ScriptDir & "\images\Multyfarming\Sixth.bmp")

	If CompareBitmaps($bm1, $bm2) Then
		SetLog("Main account Detected...", $COLOR_GREEN)
		_GUICtrlComboBox_SetCurSel($cmbProfile, 0)
		cmbProfile()
	ElseIf CompareBitmaps($bm3, $bm2) Then
		SetLog("Second account Detected...", $COLOR_GREEN)
		_GUICtrlComboBox_SetCurSel($cmbProfile, 1)
		cmbProfile()
	ElseIf ($iAccount = "3" Or $iAccount = "4" Or $iAccount = "5" Or $iAccount = "6") And CompareBitmaps($bm4, $bm2) Then
		SetLog("Third account Detected...", $COLOR_GREEN)
		_GUICtrlComboBox_SetCurSel($cmbProfile, 2)
		cmbProfile()
	ElseIf ($iAccount = "4" Or $iAccount = "5" Or $iAccount = "6") And CompareBitmaps($bm5, $bm2) Then
		SetLog("Fourth account Detected...", $COLOR_GREEN)
		_GUICtrlComboBox_SetCurSel($cmbProfile, 3)
		cmbProfile()
	ElseIf ($iAccount = "5" Or $iAccount = "6") And CompareBitmaps($bm6, $bm2) Then
		SetLog("Fifth account Detected...", $COLOR_GREEN)
		_GUICtrlComboBox_SetCurSel($cmbProfile, 4)
		cmbProfile()
	ElseIf $iAccount = "6" And CompareBitmaps($bm7, $bm2) Then
		SetLog("Sixth account Detected...", $COLOR_GREEN)
		_GUICtrlComboBox_SetCurSel($cmbProfile, 5)
		cmbProfile()
	Else
		SetLog("Temporary account Detected...", $COLOR_Red)
	EndIf

_GDIPlus_ImageDispose($bm1)
_GDIPlus_ImageDispose($bm2)
_GDIPlus_ImageDispose($bm3)
_GDIPlus_ImageDispose($bm4)
_GDIPlus_ImageDispose($bm5)
_GDIPlus_ImageDispose($bm6)
_GDIPlus_ImageDispose($bm7)

EndFunc


Func CompareBitmaps($bm1, $bm2)
    $Bm1W = _GDIPlus_ImageGetWidth($bm1)
    $Bm1H = _GDIPlus_ImageGetHeight($bm1)
    $BitmapData1 = _GDIPlus_BitmapLockBits($bm1, 0, 0, $Bm1W, $Bm1H, $GDIP_ILMREAD, $GDIP_PXF32RGB)
    $Stride = DllStructGetData($BitmapData1, "Stride")
    $Scan0 = DllStructGetData($BitmapData1, "Scan0")
    $ptr1 = $Scan0
    $size1 = ($Bm1H - 1) * $Stride + ($Bm1W - 1) * 4
    $Bm2W = _GDIPlus_ImageGetWidth($bm2)
    $Bm2H = _GDIPlus_ImageGetHeight($bm2)
    $BitmapData2 = _GDIPlus_BitmapLockBits($bm2, 0, 0, $Bm2W, $Bm2H, $GDIP_ILMREAD, $GDIP_PXF32RGB)
    $Stride = DllStructGetData($BitmapData2, "Stride")
    $Scan0 = DllStructGetData($BitmapData2, "Scan0")
    $ptr2 = $Scan0
    $size2 = ($Bm2H - 1) * $Stride + ($Bm2W - 1) * 4
    $smallest = $size1
    If $size2 < $smallest Then $smallest = $size2
    $call = DllCall("msvcrt.dll", "int:cdecl", "memcmp", "ptr", $ptr1, "ptr", $ptr2, "int", $smallest)
    _GDIPlus_BitmapUnlockBits($bm1, $BitmapData1)
    _GDIPlus_BitmapUnlockBits($bm2, $BitmapData2)

    Return ($call[0]=0)
EndFunc

Func MakeAccount()
	Local $iLoopCount = 0
	waitMainScreen()
	Click(830, 590) ;Click Switch
	Sleep(2000) ;1000
	Click(437, 399 + $midOffsetY) ;Click  Disconn
	Sleep(500) ;1000
	Click(437, 399 + $midOffsetY) ;Click  Connect
	While 1
		Sleep(1000)

		Local $Message = _PixelSearch(230, 235 + $midOffsetY, 232, 455 + $midOffsetY, Hex(0xF5F5F5, 6), 0) ;(164, 45 + $midOffsetY, 166, 281 + $midOffsetY, Hex(0x689F38, 6), 0)
		If IsArray($Message) Then
			Click($Message[0], $Message[1] + 63 + $midOffsetY)
			Sleep(2000)
			_CaptureRegion()
			ExitLoop
		EndIf

		$iLoopCount += 1
		ConsoleWrite($iLoopCount & @CRLF)
		If $iLoopCount > 2000 Then
			ExitLoop
		EndIf
	WEnd
	Local $Message = _PixelSearch(230, 235 + $midOffsetY, 232, 455 + $midOffsetY, Hex(0xF5F5F5, 6), 0) ;(164, 45 + $midOffsetY, 166, 281 + $midOffsetY, Hex(0x689F38, 6), 0)
		If IsArray($Message) Then
			Click($Message[0], $Message[1] + 63 + $midOffsetY)
			Sleep(2000)
			_CaptureRegion()
		EndIf
	If Not FileExists(@ScriptDir & "\images\Multyfarming\Accmain.bmp") Then

		Local $hBMP_Cropped = _GDIPlus_BitmapCloneArea($hBitmap, 155, 339,  200, 18)
		Local $hHBMP_Cropped = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBMP_Cropped)
		_GDIPlus_ImageSaveToFile($hBMP_Cropped, @ScriptDir & "\images\Multyfarming\Accmain.bmp")
	EndIf
	Sleep(1500)
	If Not FileExists(@ScriptDir & "\images\Multyfarming\AccSecond.bmp") Then

		Local $hBMP_Cropped = _GDIPlus_BitmapCloneArea($hBitmap, 155, 385,  200, 18)
		Local $hHBMP_Cropped = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBMP_Cropped)
		_GDIPlus_ImageSaveToFile($hBMP_Cropped, @ScriptDir & "\images\Multyfarming\AccSecond.bmp")
	EndIf
	Sleep(1500)
	If Not FileExists(@ScriptDir & "\images\Multyfarming\AccThird.bmp") And ($iAccount = "3" Or $iAccount = "4" Or $iAccount = "5" Or $iAccount = "6") Then

		Local $hBMP_Cropped = _GDIPlus_BitmapCloneArea($hBitmap, 155, 431,  200, 18)
		Local $hHBMP_Cropped = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBMP_Cropped)
		_GDIPlus_ImageSaveToFile($hBMP_Cropped, @ScriptDir & "\images\Multyfarming\AccThird.bmp")
	EndIf
	Sleep(1500)
	If Not FileExists(@ScriptDir & "\images\Multyfarming\AccFourth.bmp") And ($iAccount = "4" Or $iAccount = "5" Or $iAccount = "6") Then

		Local $hBMP_Cropped = _GDIPlus_BitmapCloneArea($hBitmap, 155, 477,  200, 18)
		Local $hHBMP_Cropped = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBMP_Cropped)
		_GDIPlus_ImageSaveToFile($hBMP_Cropped, @ScriptDir & "\images\Multyfarming\AccFourth.bmp")
	EndIf
	Sleep(1500)
	If Not FileExists(@ScriptDir & "\images\Multyfarming\AccFifth.bmp") And ($iAccount = "5" Or $iAccount = "6") Then

		Local $hBMP_Cropped = _GDIPlus_BitmapCloneArea($hBitmap, 155, 493,  200, 18)
		Local $hHBMP_Cropped = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBMP_Cropped)
		_GDIPlus_ImageSaveToFile($hBMP_Cropped, @ScriptDir & "\images\Multyfarming\AccFifth.bmp")
	EndIf
	Sleep(1500)
	If Not FileExists(@ScriptDir & "\images\Multyfarming\AccSixth.bmp") And $iAccount = "6" Then

		Local $hBMP_Cropped = _GDIPlus_BitmapCloneArea($hBitmap, 155, 539,  200, 18)
		Local $hHBMP_Cropped = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBMP_Cropped)
		_GDIPlus_ImageSaveToFile($hBMP_Cropped, @ScriptDir & "\images\Multyfarming\AccSixth.bmp")
	EndIf
	Sleep(1500)
	If Not FileExists(@ScriptDir & "\images\Multyfarming\Ok.bmp") And $iAccount = "4" Then
		Local $hBMP_Cropped = _GDIPlus_BitmapCloneArea($hBitmap, 532, 579,  70, 18)
		Local $hHBMP_Cropped = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBMP_Cropped)
		_GDIPlus_ImageSaveToFile($hBMP_Cropped, @ScriptDir & "\images\Multyfarming\Ok.bmp")

	ElseIf Not FileExists(@ScriptDir & "\images\Multyfarming\Ok.bmp") And $iAccount = "3" Then
		Local $hBMP_Cropped = _GDIPlus_BitmapCloneArea($hBitmap, 532, 533,  70, 18)
		Local $hHBMP_Cropped = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBMP_Cropped)
		_GDIPlus_ImageSaveToFile($hBMP_Cropped, @ScriptDir & "\images\Multyfarming\Ok.bmp")
	ElseIf Not FileExists(@ScriptDir & "\images\Multyfarming\Ok.bmp") Then
		Local $hBMP_Cropped = _GDIPlus_BitmapCloneArea($hBitmap, 532, 487,  70, 18)
		Local $hHBMP_Cropped = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBMP_Cropped)
		_GDIPlus_ImageSaveToFile($hBMP_Cropped, @ScriptDir & "\images\Multyfarming\Ok.bmp")
	EndIf
EndFunc


; Validate the account before switch
 Func DetectCurrentAccount($CheckAccountID)

	While 1
		ZoomOut()
	ExitLoop
	WEnd
	Sleep (2000)

	_CaptureRegion()

	Local $hBMP_Cropped = _GDIPlus_BitmapCloneArea($hBitmap, 0, 0,  200, 18)
	Local $hHBMP_Cropped = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBMP_Cropped)

	if Not FileExists(@ScriptDir & "\images\Multyfarming\" & $CheckAccountID & ".bmp") Then
		SetLog("Multy-farming not configured correctly. File \images\Multyfarming\main.bmp is missing.", $COLOR_BLUE)
		Return False
	EndIf

	if FileExists(@ScriptDir & "\images\Multyfarming\temp.bmp") Then
	   FileDelete(@ScriptDir & "\images\Multyfarming\temp.bmp")
	EndIf

	  _GDIPlus_ImageSaveToFile($hBMP_Cropped, @ScriptDir & "\images\Multyfarming\temp.bmp")
	  _GDIPlus_ImageDispose($hBitmap)

	$bm1 = _GDIPlus_ImageLoadFromFile (@ScriptDir & "\images\Multyfarming\main.bmp")
	$bm3 = _GDIPlus_ImageLoadFromFile (@ScriptDir & "\images\Multyfarming\Second.bmp")
	$bm2 = _GDIPlus_ImageLoadFromFile (@ScriptDir & "\images\Multyfarming\temp.bmp")
	$bm4 = _GDIPlus_ImageLoadFromFile (@ScriptDir & "\images\Multyfarming\Third.bmp")
	$bm5 = _GDIPlus_ImageLoadFromFile (@ScriptDir & "\images\Multyfarming\Fourth.bmp")
	$bm6 = _GDIPlus_ImageLoadFromFile (@ScriptDir & "\images\Multyfarming\Fifth.bmp")
	$bm7 = _GDIPlus_ImageLoadFromFile (@ScriptDir & "\images\Multyfarming\Sixth.bmp")

	If $CheckAccountID = "Main" AND CompareBitmaps($bm1, $bm2) Then
		SetLog("Main account Detected. No switch is required.", $COLOR_RED)
		_GDIPlus_ImageDispose($bm1)
		_GDIPlus_ImageDispose($bm2)
		_GDIPlus_ImageDispose($bm3)
		_GDIPlus_ImageDispose($bm4)
		_GDIPlus_ImageDispose($bm5)
		_GDIPlus_ImageDispose($bm6)
		_GDIPlus_ImageDispose($bm7)
		Return False
	ElseIf $CheckAccountID = "Second" AND CompareBitmaps($bm3, $bm2) Then
		SetLog("Second account Detected. No switch is required.", $COLOR_RED)
		_GDIPlus_ImageDispose($bm1)
		_GDIPlus_ImageDispose($bm2)
		_GDIPlus_ImageDispose($bm3)
		_GDIPlus_ImageDispose($bm4)
		_GDIPlus_ImageDispose($bm5)
		_GDIPlus_ImageDispose($bm6)
		_GDIPlus_ImageDispose($bm7)
		Return False
	ElseIf $CheckAccountID = "Third" AND ($iAccount = "3" Or $iAccount = "4" Or $iAccount = "5" Or $iAccount = "6") And CompareBitmaps($bm4, $bm2) Then
		SetLog("Third account Detected. No switch is required.", $COLOR_RED)
		_GDIPlus_ImageDispose($bm1)
		_GDIPlus_ImageDispose($bm2)
		_GDIPlus_ImageDispose($bm3)
		_GDIPlus_ImageDispose($bm4)
		_GDIPlus_ImageDispose($bm5)
		_GDIPlus_ImageDispose($bm6)
		_GDIPlus_ImageDispose($bm7)
		Return False
	ElseIf $CheckAccountID = "Fourth" AND ($iAccount = "4" Or $iAccount = "5" Or $iAccount = "6") And CompareBitmaps($bm5, $bm2) Then
		SetLog("Fourth account Detected. No switch is required.", $COLOR_RED)
		_GDIPlus_ImageDispose($bm1)
		_GDIPlus_ImageDispose($bm2)
		_GDIPlus_ImageDispose($bm3)
		_GDIPlus_ImageDispose($bm4)
		_GDIPlus_ImageDispose($bm5)
		_GDIPlus_ImageDispose($bm6)
		_GDIPlus_ImageDispose($bm7)
		Return False
	ElseIf $CheckAccountID = "Fifth" AND ($iAccount = "5" Or $iAccount = "6") And CompareBitmaps($bm6, $bm2) Then
		SetLog("Fifth account Detected. No switch is required.", $COLOR_RED)
		_GDIPlus_ImageDispose($bm1)
		_GDIPlus_ImageDispose($bm2)
		_GDIPlus_ImageDispose($bm3)
		_GDIPlus_ImageDispose($bm4)
		_GDIPlus_ImageDispose($bm5)
		_GDIPlus_ImageDispose($bm6)
		_GDIPlus_ImageDispose($bm7)
		Return False
	ElseIf $CheckAccountID = "Sixth" AND $iAccount = "6" And CompareBitmaps($bm7, $bm2) Then
		SetLog("Sixth account Detected. No switch is required.", $COLOR_RED)
		_GDIPlus_ImageDispose($bm1)
		_GDIPlus_ImageDispose($bm2)
		_GDIPlus_ImageDispose($bm3)
		_GDIPlus_ImageDispose($bm4)
		_GDIPlus_ImageDispose($bm5)
		_GDIPlus_ImageDispose($bm6)
		_GDIPlus_ImageDispose($bm7)
		Return False
	EndIf

	_GDIPlus_ImageDispose($bm1)
	_GDIPlus_ImageDispose($bm2)
	_GDIPlus_ImageDispose($bm3)
	_GDIPlus_ImageDispose($bm4)
	_GDIPlus_ImageDispose($bm5)
	_GDIPlus_ImageDispose($bm6)
	_GDIPlus_ImageDispose($bm7)

	Return True
 EndFunc  ;==>DetectCurrentAccount

 ; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Controls Tab Mod Option
; Description ...: This file Includes GUI Design
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Lakereng (2016)
; Modified ......: TheRevenor (2016)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func SwitchAndDonate()
	If GUICtrlRead($chkSwitchDonate) = $GUI_CHECKED Then
		$ichkSwitchDonate = 1
	Else
		$ichkSwitchDonate = 0
	EndIf
EndFunc   ;==>SwitchAndDonate


Func MultiFarming()
	If GUICtrlRead($chkMultyFarming) = $GUI_CHECKED Then
		$ichkMultyFarming = 1
		GUICtrlSetState($Account, $GUI_ENABLE)
		GUICtrlSetState($lblmultyAcc, $GUI_ENABLE)
		For $i = $grpControls To $cmbHoursStop
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
		If GUICtrlRead($chkBotStop) = $GUI_CHECKED Then
			GUICtrlSetState($chkBotStop, $GUI_UNCHECKED)
		EndIf
	Else
		$ichkMultyFarming = 0
		GUICtrlSetState($Account, $GUI_DISABLE)
		GUICtrlSetState($lblmultyAcc, $GUI_DISABLE)
		For $i = $grpControls To $cmbHoursStop
			GUICtrlSetState($i, $GUI_ENABLE)
		Next
	EndIf


	GUICtrlSetState($btnmultyAcc1, $GUI_DISABLE)
	GUICtrlSetState($btnmultyAcc2, $GUI_DISABLE)
	GUICtrlSetState($btnmultyAcc3, $GUI_DISABLE)
	GUICtrlSetState($btnmultyAcc4, $GUI_DISABLE)
	GUICtrlSetState($btnmultyAcc5, $GUI_DISABLE)
	GUICtrlSetState($btnmultyAcc6, $GUI_DISABLE)

	If  FileExists(@ScriptDir & "\images\Multyfarming\Accmain.bmp") AND FileExists(@ScriptDir & "\images\Multyfarming\main.bmp") Then
		GUICtrlSetState($btnmultyAcc1, $GUI_ENABLE)
	EndIf
	If  FileExists(@ScriptDir & "\images\Multyfarming\AccSecond.bmp") AND FileExists(@ScriptDir & "\images\Multyfarming\Second.bmp") Then
		GUICtrlSetState($btnmultyAcc2, $GUI_ENABLE)
	EndIf
	If  FileExists(@ScriptDir & "\images\Multyfarming\AccThird.bmp") AND FileExists(@ScriptDir & "\images\Multyfarming\Third.bmp") Then
		GUICtrlSetState($btnmultyAcc3, $GUI_ENABLE)
	EndIf
	If  FileExists(@ScriptDir & "\images\Multyfarming\AccFourth.bmp") AND FileExists(@ScriptDir & "\images\Multyfarming\Fourth.bmp") Then
		GUICtrlSetState($btnmultyAcc4, $GUI_ENABLE)
	EndIf
	If  FileExists(@ScriptDir & "\images\Multyfarming\AccFifth.bmp") AND FileExists(@ScriptDir & "\images\Multyfarming\Fifth.bmp") Then
		GUICtrlSetState($btnmultyAcc5, $GUI_ENABLE)
	EndIf
	If  FileExists(@ScriptDir & "\images\Multyfarming\AccSixth.bmp") AND FileExists(@ScriptDir & "\images\Multyfarming\Sixth.bmp") Then
		GUICtrlSetState($btnmultyAcc6, $GUI_ENABLE)
	EndIf

EndFunc   ;==>MultiFarming

Func Account()
	$iAccount = GUICtrlRead($Account)
	IniWrite($config, "Multy", "Account", $iAccount)
EndFunc

;================ Smart Switch ================;
;Main Account
Func btnmultyDetectAcc()
	If $RunState Then Return
	LockGUI()
	SetLog("==================== Bot Start ====================", $COLOR_GREEN)
	Sleep(2000)
	SetLog("Multy-farming Account Detection Requested ...", $COLOR_BLUE)
	SetLog("PLEASE DO NOT STOP OR PAUSE BOT", $COLOR_RED)
	$RunState = True
	waitMainScreen()
	If IsMainPage()  Then
		DetectAccount()
	Else
		SetLog("Multy-farming Account Detection Canceled", $COLOR_RED)
	EndIf
	$RunState = False
	UnLockGUI()
EndFunc
;Main Account
Func btnmultyAcc1()
	If $RunState Then Return
	LockGUI()
	SetLog("==================== Bot Start ====================", $COLOR_GREEN)
	Sleep(2000)
	SetLog("Multy-farming Main Account Switch Requested ...", $COLOR_BLUE)
	SetLog("PLEASE DO NOT STOP OR PAUSE BOT", $COLOR_RED)
		$RunState = True
	waitMainScreen()
	If IsMainPage() AND DetectCurrentAccount("Main") Then
		checkMainScreen()
		$iSwCount = 0
		SwitchAccount("Main")
		checkMainScreen()
		DetectAccount()
		SetLog("Multy-farming Main Account Switch Completed", $COLOR_BLUE)
	Else
		SetLog("Multy-farming Account Switch Canceled", $COLOR_RED)
	EndIf
	$RunState = False
	UnLockGUI()
EndFunc
;Second Account
Func btnmultyAcc2()
	If $RunState Then Return
	LockGUI()
	SetLog("==================== Bot Start ====================", $COLOR_GREEN)
	Sleep(2000)
	SetLog("Multy-farming Second Account Switch Requested ...", $COLOR_BLUE)
	SetLog("PLEASE DO NOT STOP OR PAUSE BOT", $COLOR_RED)
		$RunState = True
	waitMainScreen()
	SetLog("Multy-farming Second Account Switch In Progress ...", $COLOR_BLUE)
	If IsMainPage() AND DetectCurrentAccount("Second") Then
		checkMainScreen()
		$iSwCount = 0
		SwitchAccount("Second")
		checkMainScreen()
		DetectAccount()
		SetLog("Multy-farming Second Account Switch Completed", $COLOR_BLUE)
	Else
		SetLog("Multy-farming Account Switch Canceled", $COLOR_RED)
	EndIf
	$RunState = False
	UnLockGUI()
EndFunc
;Third Account
Func btnmultyAcc3()
	If $RunState Then Return
	LockGUI()
	SetLog("==================== Bot Start ====================", $COLOR_GREEN)
	Sleep(2000)
	SetLog("Multy-farming Third Account Switch Requested ...", $COLOR_BLUE)
	SetLog("PLEASE DO NOT STOP OR PAUSE BOT", $COLOR_RED)
		$RunState = True
	waitMainScreen()
	SetLog("Multy-farming Third Account Switch In Progress ...", $COLOR_BLUE)
	If IsMainPage() AND DetectCurrentAccount("Third") Then
		checkMainScreen()
		$iSwCount = 0
		SwitchAccount("Third")
		checkMainScreen()
		DetectAccount()
		SetLog("Multy-farming Third Account Switch Completed", $COLOR_BLUE)
	Else
		SetLog("Multy-farming Account Switch Canceled", $COLOR_RED)
	EndIf
	$RunState = False
	UnLockGUI()
EndFunc
;Fourth Account
Func btnmultyAcc4()
	If $RunState Then Return
	LockGUI()
	SetLog("==================== Bot Start ====================", $COLOR_GREEN)
	Sleep(2000)
	SetLog("Multy-farming Fourth Account Switch Requested ...", $COLOR_BLUE)
	SetLog("PLEASE DO NOT STOP OR PAUSE BOT", $COLOR_RED)
		$RunState = True
	waitMainScreen()
	SetLog("Multy-farming Fourth Account Switch In Progress ...", $COLOR_BLUE)
	If IsMainPage() AND DetectCurrentAccount("Fourth") Then
		checkMainScreen()
		$iSwCount = 0
		SwitchAccount("Fourth")
		checkMainScreen()
		DetectAccount()
		SetLog("Multy-farming Fourth Account Switch Completed", $COLOR_BLUE)
	Else
		SetLog("Multy-farming Account Switch Canceled", $COLOR_RED)
	EndIf
	$RunState = False
	UnLockGUI()
EndFunc
;Fifth Account
Func btnmultyAcc5()
	If $RunState Then Return
	LockGUI()
	SetLog("==================== Bot Start ====================", $COLOR_GREEN)
	Sleep(2000)
	SetLog("Multy-farming Fifth Account Switch Requested ...", $COLOR_BLUE)
	SetLog("PLEASE DO NOT STOP OR PAUSE BOT", $COLOR_RED)
		$RunState = True
	waitMainScreen()
	SetLog("Multy-farming Fifth Account Switch In Progress ...", $COLOR_BLUE)
	If IsMainPage() AND DetectCurrentAccount("Fifth") Then
		checkMainScreen()
		$iSwCount = 0
		SwitchAccount("Fifth")
		checkMainScreen()
		DetectAccount()
		SetLog("Multy-farming Fifth Account Switch Completed", $COLOR_BLUE)
	Else
		SetLog("Multy-farming Account Switch Canceled", $COLOR_RED)
	EndIf
	$RunState = False
	UnLockGUI()
EndFunc
;Sixth Account
Func btnmultyAcc6()
	If $RunState Then Return
	LockGUI()
	SetLog("==================== Bot Start ====================", $COLOR_GREEN)
	Sleep(2000)
	SetLog("Multy-farming Sixth Account Switch Requested ...", $COLOR_BLUE)
	SetLog("PLEASE DO NOT STOP OR PAUSE BOT", $COLOR_RED)
		$RunState = True
	waitMainScreen()
	SetLog("Multy-farming Sixth Account Switch In Progress ...", $COLOR_BLUE)
	If IsMainPage() AND DetectCurrentAccount("Sixth") Then
		checkMainScreen()
		$iSwCount = 0
		SwitchAccount("Sixth")
		checkMainScreen()
		DetectAccount()
		SetLog("Multy-farming Sixth Account Switch Completed", $COLOR_BLUE)
	Else
		SetLog("Multy-farming Account Switch Canceled", $COLOR_RED)
	EndIf
	$RunState = False
	UnLockGUI()
EndFunc ;==> Smart Switch

;Lock GUI
Func LockGUI()
		;GUICtrlSetState($chkBackground, $GUI_DISABLE) ; will be disbaled after check if Android supports Background Mode
		GUICtrlSetState($btnStart, $GUI_HIDE)
		GUICtrlSetState($btnStop, $GUI_SHOW)
		GUICtrlSetState($btnPause, $GUI_SHOW)
		GUICtrlSetState($btnResume, $GUI_HIDE)
		GUICtrlSetState($btnSearchMode, $GUI_HIDE)
		;GUICtrlSetState($btnMakeScreenshot, $GUI_DISABLE)
		;$FirstAttack = 0

		$bTrainEnabled = True
		$bDonationEnabled = True
		$MeetCondStop = False
		$Is_ClientSyncError = False
		$bDisableBreakCheck = False ; reset flag to check for early warning message when bot start/restart in case user stopped in middle
		$bDisableDropTrophy = False ; Reset Disabled Drop Trophy because the user has no Tier 1 or 2 Troops

		If Not $bSearchMode Then
			CreateLogFile()
			CreateAttackLogFile()
			If $FirstRun = -1 Then $FirstRun = 1
		EndIf

		_GUICtrlEdit_SetText($txtLog, _PadStringCenter(" BOT LOG ", 71, "="))
		_GUICtrlRichEdit_SetFont($txtLog, 6, "Lucida Console")
		_GUICtrlRichEdit_AppendTextColor($txtLog, "" & @CRLF, _ColorConvert($Color_Black))

 		$GUIControl_Disabled = True
		For $i = $FirstControlToHide To $LastControlToHide ; Save state of all controls on tabs
			If IsTab($i) Or IsDebugControl($i) Then ContinueLoop
			If $PushBulletEnabled And $i = $btnDeletePBmessages Then ContinueLoop ; exclude the DeleteAllMesages button when PushBullet is enabled
			If $i = $btnMakeScreenshot Then ContinueLoop ; exclude
			If $i = $divider Then ContinueLoop ; exclude divider
			$iPrevState[$i] = GUICtrlGetState($i)
 			GUICtrlSetState($i, $GUI_DISABLE)
		Next
		For $i = $FirstControlToHideModAIO To $LastControlToHideModAIO ; Save state of all controls on tabs
			$iPrevState[$i] = GUICtrlGetState($i)
 			GUICtrlSetState($i, $GUI_DISABLE)
		Next
		$GUIControl_Disabled = False

		SetRedrawBotWindow(True)
EndFunc   ;==>LockGUI
;UnLock GUI
Func UnLockGUI()
		GUICtrlSetState($chkBackground, $GUI_ENABLE)
		GUICtrlSetState($btnStart, $GUI_SHOW)
		GUICtrlSetState($btnStop, $GUI_HIDE)
		GUICtrlSetState($btnPause, $GUI_HIDE)
		GUICtrlSetState($btnResume, $GUI_HIDE)
		If $iTownHallLevel > 2 Then GUICtrlSetState($btnSearchMode, $GUI_ENABLE)
		GUICtrlSetState($btnSearchMode, $GUI_SHOW)
		;GUICtrlSetState($btnMakeScreenshot, $GUI_ENABLE)

		; hide attack buttons if show
		GUICtrlSetState($btnAttackNowDB, $GUI_HIDE)
		GUICtrlSetState($btnAttackNowLB, $GUI_HIDE)
		GUICtrlSetState($btnAttackNowTS, $GUI_HIDE)
		GUICtrlSetState($pic2arrow, $GUI_SHOW)
		GUICtrlSetState($lblVersion, $GUI_SHOW)

		;$FirstStart = true

		SetDebugLog("Enable GUI Controls")
		SetRedrawBotWindow(False)

		$GUIControl_Disabled = True
		For $i = $FirstControlToHide To $LastControlToHide ; Restore previous state of controls
			If IsTab($i) Or IsDebugControl($i) Then ContinueLoop
			If $PushBulletEnabled And $i = $btnDeletePBmessages Then ContinueLoop ; exclude the DeleteAllMesages button when PushBullet is enabled
			If $i = $btnMakeScreenshot Then ContinueLoop ; exclude
			If $i = $divider Then ContinueLoop ; exclude divider
			GUICtrlSetState($i, $iPrevState[$i])
		Next
		For $i = $FirstControlToHideModAIO To $LastControlToHideModAIO ; Restore previous state of controls
			GUICtrlSetState($i, $iPrevState[$i])
		Next
		$GUIControl_Disabled = False

		AndroidBotStopEvent() ; signal android that bot is now stopping

		;_BlockInputEx(0, "", "", $HWnD)
		SetLog(_PadStringCenter(" Bot Stop ", 50, "="), $COLOR_ORANGE)
		SetRedrawBotWindow(True) ; must be here at bottom, after SetLog, so Log refreshes. You could also use SetRedrawBotWindow(True, False) and let the events handle the refresh.

EndFunc   ;==>UnLockGUI

; #FUNCTION# ====================================================================================================================
; Name ..........: Switch Account
; Description ...: Switch From 1st To 2nd Account Or More
; Syntax ........:
; Parameters ....:
; Return values .:
; Author ........: Lakereng (2016)
; Modified ......: TheRevenor (2016)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func SwitchAccount($bAccount)
	$iConfirm = 0
	$AccImg = @ScriptDir & "\images\Multyfarming\Acc" & $bAccount & ".bmp"
	If Not FileExists($AccImg) Then
		SetLog("Acc" & $bAccount & ".bmp Not Found ", $COLOR_RED)
		Return False
	EndIf
	checkMainScreen()
	Send("{CapsLock off}")
	Click(830, 590) ;Click Switch
	If _Sleep(2000) Then Return ;1000

	SelectAccount($bAccount)
	If $RunState = False Then Return

	If $iConfirm = 1 Then
		FileDelete((@ScriptDir & "\images\Multyfarming\" & $bAccount & ".bmp"))
	EndIf
	$fullArmy = False
	Local $iLoopCount = 0
	While 1
		Local $Message = _PixelSearch(487, 387, 492, 391, Hex(0xE8E8E0, 6), 0) ;load pixel
		If IsArray($Message) Then
			SetLog("Load " & $bAccount & " Account", $COLOR_blue)
			If _Sleep(1800) Then Return ;Not
			Click(512, 433) ;Click Load Button
			If _Sleep(1000) Then Return

			Local $Message = _PixelSearch(470, 249 + $midOffsetY, 478, 255 + $midOffsetY, Hex(0xE8E8E0, 6), 0)
			If IsArray($Message) Then
				$iConfirm = 1
				Click(521, 198) ;Click Confirm
				If _Sleep(1500) Then Return
				Click(339, 215) ;Click Confirm txtbox
				SetLog("Insert CONFIRM To Text Box ", $COLOR_blue)
				If _Sleep(1500) Then Return
				ControlSend($Title, "", "", "{LSHIFT DOWN}{C DOWN}{C UP}{O DOWN}{O UP}{N DOWN}{N UP}{F DOWN}{F UP}{I DOWN}{I UP}{R DOWN}{R UP}{M DOWN}{M UP}{LSHIFT UP}") ;Enter  Confirm  txt
				If _Sleep(2000) Then Return
				Click(521, 200) ;Click Confirm
			Else
				Click(521, 200) ;Click Confirm
			EndIf
			ExitLoop
		EndIf

		$iLoopCount += 1
		ConsoleWrite($iLoopCount & @CRLF)
		If $iLoopCount > 1000 Then
			ExitLoop
		EndIf
	WEnd
EndFunc

Func SelectAccount($bAccount)
	Local $iLoopCount = 0
	Click(437, 399 + $midOffsetY) ;Click  Disconn
	If _Sleep(500) Then Return ;1000
	Click(437, 399 + $midOffsetY) ;Click  Connect
	$iSwCount += 1
	If $iSwCount > 7 Then
		SetLog(" Exit Now ...Cancel change account")
		SetLog("PLease make sure image create From png", $COLOR_RED)
		Click(437, 399 + $midOffsetY) ;Click  Disconn
		ClickP($aAway, 2, 250, "#0291")
		Return
	ElseIf IsMainPage() Then
		Setlog("Change account cancel")
		Return True
	EndIf
		If _Sleep(5000) Then Return
	While 1
		Local $Message = _PixelSearch(230, 235 + $midOffsetY, 232, 455 + $midOffsetY, Hex(0xF5F5F5, 6), 0) ;(164, 45 + $midOffsetY, 166, 281 + $midOffsetY, Hex(0x689F38, 6), 0)
		Local $Message1 = _PixelSearch(230, 235 + $midOffsetY, 232, 455 + $midOffsetY, Hex(0xF5F5F5, 6), 0) ;(164, 45 + $midOffsetY, 166, 281 + $midOffsetY, Hex(0xF5F5F5, 6), 0)
		If IsArray($Message) Then
			SetLog("Searching " & $bAccount & " Account...", $COLOR_blue)
			If _Sleep(1500) Then Return
			CheckAccount($bAccount)
			CheckOK()
			ExitLoop
		ElseIf IsArray($Message1) Then
			CheckAccount($bAccount)
			ExitLoop
		EndIf
		If _Sleep(1200) Then Return

		$iLoopCount += 1
		ConsoleWrite($iLoopCount & @CRLF)
		If $iLoopCount > 1500 Then
			SelectAccount($bAccount)
			ExitLoop
		EndIf
	WEnd

	If $AccountLoc = 1 Then
		LoadAccount ($bAccount)
	EndIf

EndFunc

Func LoadAccount($bAccount)
	Local $iLoopCount = 0

	While 1
		Local $Message = _PixelSearch(487, 387, 492, 391, Hex(0xE8E8E0, 6), 0) ;load pixel
		If IsArray($Message) Then
			SetLog("Loading Account In Progress...", $COLOR_blue)
			If _Sleep(1800) Then Return ;Not
			Click(512, 433) ;Click Load Button
			If _Sleep(1000) Then Return

			Local $Message = _PixelSearch(470, 249 + $midOffsetY, 478, 255 + $midOffsetY, Hex(0xE8E8E0, 6), 0)
			If IsArray($Message) Then
				$iConfirm = 1
				Click(521, 198) ;Click Confirm
				If _Sleep(1500) Then Return
				Click(339, 215) ;Click Confirm txtbox
				SetLog("Insert CONFIRM To Text Box ", $COLOR_blue)
				If _Sleep(1500) Then Return
				ControlSend($Title, "", "", "{LSHIFT DOWN}{C DOWN}{C UP}{O DOWN}{O UP}{N DOWN}{N UP}{F DOWN}{F UP}{I DOWN}{I UP}{R DOWN}{R UP}{M DOWN}{M UP}{LSHIFT UP}") ;Enter  Confirm  txt
				If _Sleep(2000) Then Return
				Click(521, 200) ;Click Confirm
			Else
				Click(521, 200) ;Click Confirm
			EndIf
			ExitLoop
		EndIf

		$iLoopCount += 1
		ConsoleWrite($iLoopCount & @CRLF)
		If $iLoopCount > 1000 Then
			SelectAccount($bAccount)
			ExitLoop
		EndIf
	WEnd
EndFunc

Func CheckOK()

	Local $OkX, $OkY
	$Ok = @ScriptDir & "\images\Multyfarming\Ok.bmp"
	If Not FileExists($Ok) Then Return False
	$OkLoc = 0
	_CaptureRegion()
	If _Sleep(500) Then Return
	For $OkTol = 0 To 20
		If $OkLoc = 0 Then
			$OkX = 0
			$OkY = 0
			$OkLoc = _ImageSearch($Ok, 1, $OkX, $OkY, $OkTol)
			If $OkLoc = 1 Then
				SetLog("Found Ok Button ", $COLOR_GREEN)
				If $DebugSetLog = 1 Then SetLog("Ok Button found (" & $OkX & "," & $OkY & ") tolerance:" & $OkTol, $COLOR_PURPLE)
				Click($OkX, $OkY,1,0,"#0120")
				If _Sleep(500) Then Return
				Return True
			EndIf
		EndIf
	Next
	If $DebugSetLog = 1 Then SetLog("Cannot find OK Button", $COLOR_PURPLE)
	If _Sleep(500) Then Return
EndFunc   ;==>CheckOK Button

Func CheckAccount($bAccount)

	Local $AccountX, $AccountY
	$AccImg = @ScriptDir & "\images\Multyfarming\Acc" & $bAccount & ".bmp"
	If Not FileExists($AccImg) Then
		SetLog("Acc" & $bAccount & ".bmp Not Found ", $COLOR_RED)
		Return False
	EndIf
	$AccountLoc = 0
	_CaptureRegion()
	If _Sleep(500) Then Return
	For $AccountTol = 0 To 20
		If $AccountLoc = 0 Then
			$AccountX = 0
			$AccountY = 0
			$AccountLoc = _ImageSearch($AccImg, 1, $AccountX, $AccountY, $AccountTol)
			If $AccountLoc = 1 Then
				SetLog("Found " & $bAccount & " Account...", $COLOR_GREEN)
				If $DebugSetLog = 1 Then SetLog("Found " & $bAccount & " Account (" & $AccountX & "," & $AccountY & ") tolerance:" & $AccountTol, $COLOR_PURPLE)
				Click($AccountX, $AccountY,1,0,"#0120")
				If _Sleep(500) Then Return
				Return True
			EndIf
		EndIf
	Next
	If $DebugSetLog = 1 Then SetLog("Cannot Found " & $bAccount & " Account", $COLOR_PURPLE)
	If _Sleep(500) Then Return
EndFunc ; Switch Account

; #FUNCTION# ====================================================================================================================
; Name ..........: Switch Account And Donate
; Description ...: Switch Account & Donate Then Switch Back
; Syntax ........:
; Parameters ....:
; Return values .:
; Author ........: Lakereng (2016)
; Modified ......: TheRevenor (2016)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func SwitchDonate()
		;..............Switch Account & Donate Then Switch Back...................
	If $ichkSwitchDonate = 1 Then
		SetLog("Loading Switching Account For Donate...", $COLOR_BLUE)
		DetectAccount()
		If _Sleep(1000) Then Return
		If $sCurrProfile = "[01] Main" Then
			SwitchAccount("Second")
			$RunState = True
			While 1
				;Collect()
				ZoomOut()
				Sleep(1000)
				DonateCC()
				RequestCC()
				DetectAccount()
				Train()
				ExitLoop
			WEnd
			SwitchAccount("Main")
		ElseIf $sCurrProfile = "[02] Second" Then
			If $iAccount = "3" Or $iAccount = "4" Or $iAccount = "5" Or $iAccount = "6" Then
				SwitchAccount("Third")
			Else
				SwitchAccount("Main")
			EndIf
			$RunState = True
			While 1
				ZoomOut()
				Sleep(1000)
				DonateCC()
				RequestCC()
				DetectAccount()
				Train()
				ExitLoop
			WEnd
			SwitchAccount("Second")
		ElseIf $sCurrProfile = "[03] Third" Then
			If $iAccount = "4" Or $iAccount = "5" Or $iAccount = "6" Then
				SwitchAccount("Fourth")
			ElseIf $iAccount = "3" Then
				SwitchAccount("Main")
			EndIf
			$RunState = True
			While 1
				ZoomOut()
				DonateCC()
				RequestCC()
				DetectAccount()
				Train()
				ExitLoop
			WEnd
			SwitchAccount("Third")
		ElseIf $sCurrProfile = "[04] Fourth" Then
			If $iAccount = "5" Or $iAccount = "6" Then
				SwitchAccount("Fifth")
			ElseIf $iAccount = "4" Then
				SwitchAccount("Main")
			EndIf
			$RunState = True
			While 1
				ZoomOut()
				DonateCC()
				RequestCC()
				DetectAccount()
				Train()
				ExitLoop
			WEnd
			SwitchAccount("Fourth")
		ElseIf $sCurrProfile = "[05] Fifth" Then
			If $iAccount = "6" Then
				SwitchAccount("Fifth")
			ElseIf $iAccount = "5" Then
				SwitchAccount("Main")
			EndIf
			$RunState = True
			While 1
				ZoomOut()
				DonateCC()
				RequestCC()
				DetectAccount()
				Train()
				ExitLoop
			WEnd
			SwitchAccount("Fifth")
		ElseIf $sCurrProfile = "[06] Sixth" Then
			$RunState = True
			SwitchAccount("Main")
			While 1
				ZoomOut()
				DonateCC()
				RequestCC()
				DetectAccount()
				Train()
				ExitLoop
			WEnd
			SwitchAccount("Sixth")
		EndIf
		If _Sleep(1000) Then Return
		SetLog("Switching Account For Donate Completed", $COLOR_BLUE)
		DetectAccount()
	EndIf
EndFunc ; Switch Donate