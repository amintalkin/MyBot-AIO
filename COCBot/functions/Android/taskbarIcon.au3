; #FUNCTION# ====================================================================================================================
; Name ..........: taskbarIcon
; Description ...: Functions to control the Android Window Taskbar Icon visibility
; Syntax ........: 
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

; Simple API trick to hide the task bar icons, windows of type Tool Window don't display an icon.
Func hideTaskBarIcon($windowHandle)
	; Check if we should hide the task bar icon
	If $ichkHideTaskBar = 1 Then
		; Capture Existing Style
		$Style = _WinAPI_GetWindowLong($windowHandle, $GWL_STYLE)

		; Check to see if the task bar icon is visible, if it isn't visible don't make any changes
		If BitAND($Style, $WS_EX_APPWINDOW) = $WS_EX_APPWINDOW Then
			; You must hide the window before changing the style, as per Microsoft's instructions here
			; https://msdn.microsoft.com/en-us/library/windows/desktop/cc144179%28v=vs.85%29.aspx#Managing_Taskbar_But
			WinSetState($windowHandle, "", @SW_HIDE)
			; Check if window is type $WS_EX_APPWINDOW, and if it is remove it
			If BitAND($Style, $WS_EX_APPWINDOW) = $WS_EX_APPWINDOW Then
				_WinAPI_SetWindowLong($windowHandle, $GWL_STYLE, BitXOR($Style, $WS_EX_APPWINDOW))
			EndIf
			; Check if window is type not currently type $WS_EX_TOOLWINDOW, and if it isn't add it
			If BitAND($Style, $WS_EX_TOOLWINDOW) <> $WS_EX_TOOLWINDOW Then
				_WinAPI_SetWindowLong($windowHandle, $GWL_STYLE, BitOr($Style, $WS_EX_TOOLWINDOW))
			EndIf
			; Reshow the window so the changes take effect, this is required
			WinSetState($windowHandle, "", @SW_SHOW)
		EndIf
	EndIf
EndFunc

; Simple API trick to show the task bar icon again, change back to type App Window.
Func showTaskBarIcon($hWnd)
	; Capture Existing Style
	$Style = _WinAPI_GetWindowLong($HWnD, $GWL_STYLE)

	; Check to see if the task bar icon is hidden, if it isn't hidden don't make any changes
	If BitAND($Style, $WS_EX_APPWINDOW) <> $WS_EX_APPWINDOW Then
		; You must hide the window before changing the style, as per Microsoft's instructions here
		; https://msdn.microsoft.com/en-us/library/windows/desktop/cc144179%28v=vs.85%29.aspx#Managing_Taskbar_But
		WinSetState($HWnD, "", @SW_HIDE)
		; Check if window is type $WS_EX_TOOLWINDOW, and if it is remove it
		If BitAND($Style, $WS_EX_TOOLWINDOW) = $WS_EX_TOOLWINDOW Then
			_WinAPI_SetWindowLong($HWnD, $GWL_STYLE, BitXOR($Style, $WS_EX_TOOLWINDOW))
		EndIf
		; Check if window is type not currently type $WS_EX_APPWINDOW, and if it isn't add it
		If BitAND($Style, $WS_EX_APPWINDOW) <> $WS_EX_APPWINDOW Then
			_WinAPI_SetWindowLong($HWnD, $GWL_STYLE, BitOr($Style, $WS_EX_APPWINDOW))
		EndIf
		; Reshow the window so the changes take effect, this is required
		WinSetState($HWnD, "", @SW_SHOW)
	EndIf
EndFunc