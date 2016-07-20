$hGUI_Chat = GUICreate("", $_GUI_MAIN_WIDTH - 28, $_GUI_MAIN_HEIGHT - 255 - 28, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $hGUI_MOD)
GUISetBkColor($COLOR_WHITE, $hGUI_Chat)

GUISwitch($hGUI_Chat)
   
   $chatIni = $sProfilePath & "\" & $sCurrProfile & "\chat.ini"
   ChatbotReadSettings()
   ;$tabChat = GUICtrlCreateTabItem(GetTranslated(106, 1,"Chat"))

	Local $x = 20, $y = 25

   GUICtrlCreateGroup(GetTranslated(106, 2,"Global Chat"), $x - 20, $y - 20, 215, 360)
    $y -= 5
   $chkGlobalChat = GUICtrlCreateCheckbox(GetTranslated(106, 3,"Advertise in global"), $x - 10, $y)
   GUICtrlSetTip($chkGlobalChat, GetTranslated(106,4,"Use global chat to send messages"))
   GUICtrlSetState($chkGlobalChat, $ChatbotChatGlobal)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   $y += 18
   $chkGlobalScramble = GUICtrlCreateCheckbox(GetTranslated(106,5,"Scramble global chats"), $x - 10, $y)
   GUICtrlSetTip($chkGlobalScramble, GetTranslated(106,6,"Scramble the message pieces defined in the textboxes below to be in a random order"))
   GUICtrlSetState($chkGlobalScramble, $ChatbotScrambleGlobal)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   $y += 18
   $chkSwitchLang = GUICtrlCreateCheckbox(GetTranslated(106,7,"Switch languages"), $x - 10, $y)
   GUICtrlSetTip($chkSwitchLang, GetTranslated(106,8,"Switch languages after spamming for a new global chatroom"))
   GUICtrlSetState($chkSwitchLang, $ChatbotSwitchLang)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   $y += 22
  $ChatbotChatDelayLabel = GUICtrlCreateLabel(GetTranslated(106,9,"Chat Delay"), $x - 10, $y)
   GUICtrlSetTip($ChatbotChatDelayLabel, GetTranslated(106,10,"Delay chat between number of bot cycles"))
   $chkchatdelay = GUICtrlCreateInput("0", $x + 50, $y - 1, 35, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
   GUICtrlSetLimit(-1, 2)
   $y += 20
   $editGlobalMessages1 = GUICtrlCreateEdit(_ArrayToString($GlobalMessages1, @CRLF), $x - 15, $y, 202, 65)
   GUICtrlSetTip($editGlobalMessages1, GetTranslated(106,11,"Take one item randomly from this list (one per line) and add it to create a message to send to global"))
   GUICtrlSetOnEvent(-1, "ChatGuiEditUpdate")
   $y += 65
   $editGlobalMessages2 = GUICtrlCreateEdit(_ArrayToString($GlobalMessages2, @CRLF), $x - 15, $y, 202, 65)
   GUICtrlSetTip($editGlobalMessages2, GetTranslated(106,12,"Take one item randomly from this list (one per line) and add it to create a message to send to global"))
   GUICtrlSetOnEvent(-1, "ChatGuiEditUpdate")
   $y += 65
   $editGlobalMessages3 = GUICtrlCreateEdit(_ArrayToString($GlobalMessages3, @CRLF), $x - 15, $y, 202, 65)
   GUICtrlSetTip($editGlobalMessages3, GetTranslated(106,13,"Take one item randomly from this list (one per line) and add it to create a message to send to global"))
   GUICtrlSetOnEvent(-1, "ChatGuiEditUpdate")
   $y += 65
   $editGlobalMessages4 = GUICtrlCreateEdit(_ArrayToString($GlobalMessages4, @CRLF), $x - 15, $y, 202, 65)
   GUICtrlSetTip($editGlobalMessages4, GetTranslated(106,14,"Take one item randomly from this list (one per line) and add it to create a message to send to global"))
   GUICtrlSetOnEvent(-1, "ChatGuiEditUpdate")
   $y += 65
   GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 240, $y = 25

   GUICtrlCreateGroup(GetTranslated(106,15,"Clan Chat"), $x - 20, $y - 20, 218, 360)
   $y -= 5
   $chkClanChat = GUICtrlCreateCheckbox(GetTranslated(106,16,"Chat in clan chat"), $x - 10, $y)
   GUICtrlSetTip($chkClanChat, GetTranslated(106,17,"Use clan chat to send messages"))
   GUICtrlSetState($chkClanChat, $ChatbotChatClan)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   $y += 22
   $chkUseResponses = GUICtrlCreateCheckbox(GetTranslated(106,18,"Use custom responses"), $x - 10, $y)
   GUICtrlSetTip($chkUseResponses, GetTranslated(106,19,"Use the keywords and responses defined below"))
   GUICtrlSetState($chkUseResponses, $ChatbotClanUseResponses)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   $y += 22
   $chkUseCleverbot = GUICtrlCreateCheckbox(GetTranslated(106,20,"Use cleverbot responses"), $x - 10, $y)
   GUICtrlSetTip($chkUseCleverbot, GetTranslated(106,21,"Get responses from cleverbot.com"))
   GUICtrlSetState($chkUseCleverbot, $ChatbotClanUseCleverbot)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   $y += 22
   $chkUseSimsimi = GUICtrlCreateCheckbox(GetTranslated(106,22,"Use simsimi responses"), $x - 10, $y)
   GUICtrlSetTip($chkUseSimsimi, GetTranslated(106,23,"Get responses from simsimi.com"))
   GUICtrlSetState($chkUseSimsimi, $ChatbotClanUseSimsimi)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   $y += 22
   $chkUseGeneric = GUICtrlCreateCheckbox(GetTranslated(106,24,"Use generic chats"), $x - 10, $y)
   GUICtrlSetTip($chkUseGeneric, GetTranslated(106,25,"Use generic chats if reading the latest chat failed or there are no new chats"))
   GUICtrlSetState($chkUseGeneric, $ChatbotClanAlwaysMsg)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   $y += 22
   $chkChatPushbullet = GUICtrlCreateCheckbox(GetTranslated(106,26,"Use remote for chatting"), $x - 10, $y)
   GUICtrlSetTip($chkChatPushbullet, GetTranslated(106,27,"Send and recieve chats via pushbullet or telegram. Use BOT <myvillage> GETCHATS <interval|NOW|STOP> to get the latest clan chat as an image, and BOT <myvillage> SENDCHAT <chat message> to send a chat to your clan"))
   GUICtrlSetState($chkChatPushbullet, $ChatbotUsePushbullet)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   $y += 22
   $chkPbSendNewChats = GUICtrlCreateCheckbox(GetTranslated(106,28,"Notify me new clan chat"), $x - 10, $y)
   GUICtrlSetTip($chkPbSendNewChats, GetTranslated(106,29,"Will send an image of your clan chat via pushbullet & telegram when a new chat is detected. Not guaranteed to be 100% accurate."))
   GUICtrlSetState($chkPbSendNewChats, $ChatbotPbSendNew)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   $y += 25

   $editResponses = GUICtrlCreateEdit(_ArrayToString($ClanResponses, ":", -1, -1, @CRLF), $x - 15, $y, 206, 90)
   GUICtrlSetTip($editResponses, GetTranslated(106,30,"Look for the specified keywords in clan messages and respond with the responses. One item per line, in the format keyword:response"))
   GUICtrlSetOnEvent(-1, "ChatGuiEditUpdate")
   $y += 92
   $editGeneric = GUICtrlCreateEdit(_ArrayToString($ClanMessages, @CRLF), $x - 15, $y, 206, 90)
   GUICtrlSetTip($editGeneric, GetTranslated(106,31,"Generic messages to send, one per line"))
   GUICtrlSetOnEvent(-1, "ChatGuiEditUpdate")

   ;GUICtrlCreateTabItem("")
   
   ChatGuicheckboxUpdateAT()