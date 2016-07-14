
; #FUNCTION# ====================================================================================================================
; Name ..........: DonateStats
; Description ...: GUICreateDStat(), GetTroopColumn(), InitDonateStats, CompareBitmaps(), part of DonateStats, for collecting total counts of Troops donated
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Cutidudz (2016)
; Modified ......: TheRevenor (2016)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func GetTroopColumn($iTroopName)
	Local $startIndex = 1
	$ColCount = _GUICtrlListView_GetColumnCount($lvDonatedTroops)
	If StringRight($iTroopName, 6) = "Spells" Then
		$startIndex = $ColCount - 3
		If $debugSetlog = 1 Then SetLog("DonateStats: Donating Spells $startIndex=" & $startIndex, $COLOR_PURPLE)
	Else
		$ColCount -= 3
	EndIf

	For $ColIndex = $startIndex To $ColCount
		$ColInfo = _GUICtrlListView_GetColumn($lvDonatedTroops, $ColIndex)
		If Not @error And IsArray($ColInfo) Then
			If $debugSetlog = 1 Then SetLog("Donatestats: Column match for TroopName: " & $iTroopName & " = " & $ColInfo[5] & " at column: " & $ColIndex, $COLOR_PURPLE)
			If $iTroopName = $ColInfo[5] Then
				Return $ColIndex
			EndIf

		EndIf
	Next
EndFunc

Func InitDonateStats()

	_GUICtrlListView_DeleteAllItems ($lvDonatedTroops)
	If Not FileExists($dirTemp & "DonateStats\") Then DirCreate($dirTemp & "DonateStats\")
	FileDelete($dirTemp & "DonateStats\*.bmp")

	;_GUIImageList_Destroy($hImage)
	$ImageList = _GUIImageList_Create(139, 25) ;20
	_GUIImageList_AddBitmap($ImageList, @ScriptDir & "\images\Totals.bmp")
	_GUICtrlListView_AddItem($lvDonatedTroops, "Totals", 0)

	_GUICtrlListView_SetImageList($lvDonatedTroops, $ImageList, 1)

	#cs
	$aFileList = _FileListToArrayRec($dirTemp & "DonateStats\", "*.bmp", 1, 0, 1)
	If Not @error And IsArray($aFileList) Then
		For $x = 1 To $aFileList[0]
			_GUIImageList_AddBitmap($ImageList, $dirTemp & "DonateStats\" & $aFileList[$x])
			_GUICtrlListView_AddItem($lvDonatedTroops, $aFileList[$x], $x)
		Next
		_GUICtrlListView_SetImageList($lvDonatedTroops, $ImageList, 1)
	EndIf
	#ce

EndFunc

Func CompareDBitmaps($File1, $File2)

	$pBitmap1 = _GDIPlus_BitmapCreateFromFile($dirTemp & $File1)
	If $pBitmap1 = 0 Then SetLog("DonateStats: Error loading first Image to compare", $COLOR_RED)

	$pBitmap2 = _GDIPlus_BitmapCreateFromFile($dirTemp & "DonateStats\" & $File2)
	If $pBitmap2 = 0 Then SetLog("DonateStats: Error loading second Image to compare", $COLOR_RED)

	If $pBitmap1 = 0 Or $pBitmap2 = 0 Then Return 0
	Local $BitmapData1 = _GDIPlus_BitmapLockBits($pBitmap1, 0, 0, _GDIPlus_ImageGetWidth($pBitmap1), _GDIPlus_ImageGetHeight($pBitmap1), $GDIP_ILMWRITE, $GDIP_PXF32RGB)
	Local $BitmapData2= _GDIPlus_BitmapLockBits($pBitmap2, 0, 0, _GDIPlus_ImageGetWidth($pBitmap2), _GDIPlus_ImageGetHeight($pBitmap2), $GDIP_ILMWRITE, $GDIP_PXF32RGB)

	Local $Stride1 = DllStructGetData($BitmapData1, "Stride")
	Local $Stride2 = DllStructGetData($BitmapData2, "Stride")

	Local $Width1 = DllStructGetData($BitmapData1, "Width")
	Local $Width2 = DllStructGetData($BitmapData2, "Width")

	Local $Height1 = DllStructGetData($BitmapData1, "Height")
	Local $Height2 = DllStructGetData($BitmapData2, "Height")

	Local $PixelFormat1 = DllStructGetData($BitmapData1, "PixelFormat")
	Local $PixelFormat2 = DllStructGetData($BitmapData2, "PixelFormat")

	Local $Scan01 = DllStructGetData($BitmapData1, "Scan0")
	Local $Scan02 = DllStructGetData($BitmapData2, "Scan0")

	Local $TotalPixels = $Width1 * $Height1
	Local $RemainingPixels = $TotalPixels

	For $row = 0 To $Height1 - 1
		For $col = 0 To $Width1 - 1
			$pixel1 = DllStructCreate("dword", $Scan01 + $row * $Stride1 + $col*4)
			$color1 = Hex(DllStructGetData($pixel1, 1))

			$pixel2 = DllStructCreate("dword", $Scan02 + $row * $Stride2 + $col*4)
			$color2 = Hex(DllStructGetData($pixel2, 1))

			If $color1 <> $color2 Then $RemainingPixels -= 1

			;ConsoleWrite($color1 & ", " & $color2 & @CRLF)
		Next
		;ConsoleWrite("-------" & @CRLF)
	Next

	$Difference = $RemainingPixels / $TotalPixels

	;ConsoleWrite("$TotalPixels: " & $TotalPixels & @CRLF)
	;ConsoleWrite("$RemainingPixels: " & $RemainingPixels & @CRLF)

	;MsgBox(0,"Percent difference", Round($Difference,2) * 100 & "%")

	;Unlock region previously locked for writing
	_GDIPlus_BitmapUnlockBits($pBitmap1, $BitmapData1)
	_GDIPlus_BitmapUnlockBits($pBitmap2, $BitmapData2)

	_GDIPlus_ImageDispose ($pBitmap1)
	_GDIPlus_ImageDispose ($pBitmap2)

	_WinAPI_DeleteObject ($pBitmap1)
	_WinAPI_DeleteObject ($pBitmap2)

	Return (Round($Difference,2) * 100)

EndFunc  ;==>CompareBitmaps

