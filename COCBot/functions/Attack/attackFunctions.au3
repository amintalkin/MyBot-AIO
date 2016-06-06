; #FUNCTION# ====================================================================================================================
; Name ..........: attackFunctions
; Description ...: Contains misc functions used by attack profiles, and other attack functions
; Syntax ........:
; Parameters ....:
; Return values .: None
; Author ........: LunaEclipse(March, 2016)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

; Returns whether the DE Storage is full when in battle
Func getDarkElixirStorageFull()
	Local $return = False
	Local $aDarkElixirStorageFull[4] = [743, 94, 0x1A0026, 10] ; DE Resource Bar when in combat

	If _CheckPixel($aDarkElixirStorageFull, $bCapturePixel) Then $return = True

	Return $return
EndFunc   ;==>getDarkElixirStorageFull