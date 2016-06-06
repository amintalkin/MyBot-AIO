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
$hGUI_ModAndroid = GUICreate("", $_GUI_MAIN_WIDTH - 28, $_GUI_MAIN_HEIGHT - 255 - 28, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $hGUI_MOD)
;GUISetBkColor($COLOR_WHITE, $hGUI_BotOptions)

GUISwitch($hGUI_ModAndroid)
Local $x = 375, $y = 0
$btnResetSddtats = GUICtrlCreateButton("sss", $x, $y, 60, 20)
GUICtrlSetOnEvent(-1, "btnResetStats")
GUICtrlSetState(-1, $GUI_DISABLE)