#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; Variables
Increments 			:= 10 ; < lower for a more granular change, higher for larger jump in brightness 
CurrentBrightness 	:= GetCurrentBrightNess()

>^a::     ChangeBrightness( CurrentBrightness -= Increments ) ; decrease brightness
>^s::     ChangeBrightness( CurrentBrightness += Increments ) ; increase brightness


ChangeBrightness( ByRef brightness := 50, timeout = 1 )
{
	if ( brightness >= 0 && brightness <= 100 )
	{
		For property in ComObjGet( "winmgmts:\\.\root\WMI" ).ExecQuery( "SELECT * FROM WmiMonitorBrightnessMethods" )
			property.WmiSetBrightness( timeout, brightness )	
	}
 	else if ( brightness > 100 )
 	{
 		brightness := 100
 	}
 	else if ( brightness < 0 )
 	{
 		brightness := 0
 	}
}

GetCurrentBrightNess()
{
	For property in ComObjGet( "winmgmts:\\.\root\WMI" ).ExecQuery( "SELECT * FROM WmiMonitorBrightness" )
		currentBrightness := property.CurrentBrightness	

	return currentBrightness
}

<!h::Send, {Left}
<!j::Send, {Down}
<!k::Send, {Up}
<!l::Send, {Right}

<!1::Send, {Volume_Mute}
<!2::Send, {Volume_Down}
<!3::Send, {Volume_Up}
Capslock::Ctrl
^+::Capslock