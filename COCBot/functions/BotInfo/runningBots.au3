; #CLASS# ====================================================================================================================
; Name ..........: runningBots
; Description ...: Contains functions for getting PIDs of active BOT instances.
; Author ........: LunaEclipse(May, 2016)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015
;                  MyBot is distributed under the terms of the GNU GPL
; ===============================================================================================================================

#include <Array.au3>
#include <WinAPIProc.au3>

Func existsPID($aList, $pID)
	; Assume the PID is not already stored
	Local $result = False

	; Check to make sure its a valid array
	If IsArray($aList) And UBound($aList) > 1 Then
		; Loop through all entries in the array looking for the PID
		For $counter = 1 To UBound($aList) - 1
			; Check to see if the entry is the pID
			If $aList[$counter][0] = $pID Then
				$result = True
				ExitLoop
			EndIf
		Next
	EndIf
	
	Return $result
EndFunc   ;==>existsPID

Func addPID(ByRef $aList, $pID, $hWnd, $title)	
	; Get the current UBound of the array as it will be the new index number
	Local $maxIndex = (IsArray($aList)) ? UBound($aList) : 0
	
	; Check to see if the PID exists
	If Not existsPID($aList, $pID) Then
		; Redimension the array to allow a new entry
		ReDim $aList[$maxIndex + 1][3]
		
		; Increase the count of found pIDs
		$aList[0][0] = Number($aList[0][0]) + 1

		; Store the info about the found pID
		$aList[$maxIndex][0] = $pID
		$aList[$maxIndex][1] = $hWnd
		$aList[$maxIndex][2] = $title
	EndIf
EndFunc   ;==>addPID

Func getPIDs(ByRef $aList, $exeFile, $botTitle)
	Local $aWindows, $pID, $hWnd, $title
	
	; Get the running AutoIt Processes
	Local $aProcessList = ProcessList($exeFile)

	; Make sure its a valid array and has at least one entry besides the result entry
	If IsArray($aProcessList) And UBound($aProcessList) > 1 Then
		; Loop through the found pIDs
		For $pIDCounter = 1 To UBound($aProcessList) - 1
			; Store the pID
			$pID = $aProcessList[$pIDCounter][1]
			; Get a list of all the windows associated with the pID
			$aWindows = _WinAPI_EnumProcessWindows($pID)
			
			; Make sure its a valid array and has at least one entry besides the result entry
			If IsArray($aWindows) And UBound($aWindows) > 1 Then
				; Loop through the found windows
				For $hWndCounter = 1 To UBound($aWindows) - 1
					; Store the hWnd
					$hWnd = $aWindows[$hWndCounter][0]
					; Store the windows title
					$title = WinGetTitle($hWnd)
					
					; Check to see the window title contains the needed bot title text
					If StringInStr($title, $botTitle) > 0 Then 
						addPID($aList, $pID, $hWnd, $title)
						ExitLoop
					EndIf
				Next
			EndIf
		Next
	EndIf
EndFunc   ;==>getPIDs

Func getActiveBotPIDs($botTitle = "My Bot")
	; Set up the results row of the array
	Local $aResult[1][3] = [[0, "", ""]]
	
	; Get pIDs for any bots running AU3 scripts
	getPIDs($aResult, "AutoIt3.exe", $botTitle)
	; Get pIDs for any bots running as EXE File
	getPIDs($aResult, "MyBot.run.exe", $botTitle)	
	
	Return $aResult	
EndFunc   ;==>getActiveBotPIDs