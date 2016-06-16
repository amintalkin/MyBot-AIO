; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design Splash
; Description ...: This file Includes GUI Design
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: mikemikemikecoc (2016
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================


Local $sSplashImg = @ScriptDir & "\Images\banner.jpg"
Local $hImage, $iX, $iY

If $ichkDisableSplash = 0 Then
    _GDIPlus_Startup()

    ; Determine dimensions of splash image
    $hImage = _GDIPlus_ImageLoadFromFile($sSplashImg)
    $iX = _GDIPlus_ImageGetWidth($hImage)
    $iY = _GDIPlus_ImageGetHeight($hImage)

    ; Cleanup GDI resources
    _GDIPlus_ImageDispose($hImage)
    _GDIPlus_Shutdown()

    ; Create Splash container
    $hSplash = GUICreate("", $iX, $iY + 60, -1, -1, BitOR($WS_POPUP, $WS_BORDER), BitOR($WS_EX_TOPMOST, $WS_EX_WINDOWEDGE, $WS_EX_TOOLWINDOW))

    GUICtrlCreatePic($sSplashImg, 0, 0, $iX, $iY) ; Splash Image
    $lSplashTitle = GUICtrlCreateLabel($sBotTitle, 15, $iY + 3, $iX - 30, 15, $SS_CENTER) ; Splash Title
    $hSplashProgress = GUICtrlCreateProgress(15, $iY + 20, $iX - 30, 10, $PBS_SMOOTH, BitOR($WS_EX_TOPMOST, $WS_EX_WINDOWEDGE, $WS_EX_TOOLWINDOW)) ; Splash Progress
    $lSplashStatus = GUICtrlCreateLabel("", 15, $iY + 38, $iX - 30, 15, $SS_CENTER) ; Splash Title

    ; Show Splash
    GUISetState(@SW_SHOW, $hSplash)
EndIf