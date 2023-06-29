
#Requires AutoHotkey v2.0
#SingleInstance Force
;   #HotIf !(winactive("csgo"))
;SetTitleMatchMode 2
;#HotIf (WinActive("ahk_exe Code.exe") && WinActive(".cs")) || WinActive("ahk_exe devenv.exe") ;only works for Vicual code / studio
switchMode := 1
direction := "left"
keyTime := 0.5








Capslock::
{
global switchMode
if (switchMode = 1)
    {  
            global direction 
        
        
            if (direction = "left") {
                direction := "right"
                comboKeySwitch()
                return
            } 
            else {
                direction := "left"
                comboKeySwitch()
                return
            }
            
    return
    } ;end of switch mode one
    
    
    
    
    else if (switchMode = 2) ;switch mode 2 start mode (long press mode
        {
            if !KeyWait("CapsLock",("T " . keyTime)) ; 0.4 second
                {
	
							; Toggle the direction between left and right
							if (direction = "left") 
							{
								;Send the keys for window + ctrl + direction
								direction := "right"
								SetCapsLockState("Off")
                                send ("{LWin down}{LCtrl down}{" direction "}{LWin up}{LCtrl up}")
                                KeyWait ("CapsLock")
                                return
							}
							else 
							{   
                                
								;Send the keys for window + ctrl + direction
								direction := "left"
                                send ("{LWin down}{LCtrl down}{" direction "}{LWin up}{LCtrl up}")
								SetCapsLockState("Off")
                                KeyWait ("CapsLock")
                                return
							}
					return
                }


    Return

        } ;end of mode 2 (long mode)
   
        else if (switchMode = 3)
            {
                global direction 
                            
                    ;MsgBox "mode 3"        
                if (direction = "left") {
                    send ("{Space}")
                    Sleep(50)
                    SetCapsLockState("Off")
                    Send("{LWin down}{LCtrl down}{" direction "}{LWin up}{LCtrl up}")
                    direction := "right"
                   ;  SoundBeep (11,2000)
                    return
                } 
                else {
                    SetCapsLockState("Off")
                    Send("{LWin down}{LCtrl down}{" direction "}{LWin up}{LCtrl up}")
                    direction := "left"
                   
                    
                    SoundBeep (100,4000)
                    Sleep(100) 
                    send ("{Space}")
                    return
                }

        
            }

        else if (switchMode = 4){
            global direction 
                            
                    ;MsgBox "mode 3"        
                if (direction = "left") {
                    send ("{Media_Play_Pause}")
                    Sleep(50)
                    
                    comboKeySwitch 
                    direction := "right"
                   ;  SoundBeep (11,2000)
                    return
                } 
                else {
                    
                    comboKeySwitch
                    direction := "left"
                   
                    
                    SoundBeep (100,4000)
                    Sleep(100) 
                    send ("{Media_Play_Pause}")
                    return
                }

        }
        


    
        else if (switchMode = 5) ;push to talk
                {  
                ;SendEvent "{r down} {r up}"
                Send "{p down}"
                KeyWait "CapsLock"
                Sleep(1000) ;smoth   
                Send "{p up}"
                return
                } ;end of switch mode one
                
   
   
   
   
   
   
   
   
        return ;for whole caps key
} ;end for caps key





F9:: 
{
    global direction := "left"
    SoundBeep (200 ,1000)
}








F5::doublepress_and_longpress() ; Function for single press, double press and long press (longpress longer than 0.2 seconds, double press within 0.2 seconds)

doublepress_and_longpress()
{
   if (KeyWait("F5", "T0.2")) 
   {
      if (KeyWait("F5", "D T0.2")) ; Double press
      {
         sendinput "b"
         return
      }
      else ; Single press
      {
         sendinput "a"
         return
      }
   }
   else ; Long press
   {
      sendinput "c"
      KeyWait ("F5")
      return
   }
   return
}


f3::w

;/////////////////////////////////////////////////GUI//////////////////////////////////////////////////
F6::welcomeGui_Create()
f7::gSettingsMenuModeGui()













;//////////////////////////////////////////////////////////////////////////////






gSettingsMenuModeGui(){

	gSettingsMenuModeGui := Gui(, "Mode Settings")
	gSettingsMenuModeGui.name := "s"
	gSettingsMenuModeGui.Opt("+AlwaysOnTop +Border -MaximizeBox -MinimizeBox")

    ;//items
	labelText := gSettingsMenuModeGui.AddText("x43 y19 w99 h12", "Chose switch mode:")
	ogSB := gSettingsMenuModeGui.AddStatusBar("x0 y249 w178 h24", "@xMaxrayx      @Unbreakable-Ray")
	btnOk := gSettingsMenuModeGui.AddButton("x11 y195 w169 h23", "&OK")
	DDL1 := gSettingsMenuModeGui.AddDropDownList("x18 y47 w147 h200",  ["Fast mode","Hold mode" ,"Youtube mode" , "Youtube mode new" , "Push to talk"])
    DDL1.text := "Fast mode"
    ;// event
    btnOK.OnEvent("Click", (GuiObj,Info)=>convertDropToMode())
	gSettingsMenuModeGui.Show("w188 h251")
                  

    ;//funiscrion
    convertDropToMode()  
    {   
      global switchMode 
      texTtoInt := (DDL1.Text)
      ;switchMode :=  (DDL1.Text)
      textModeToIntmod()
        
      Sleep(20)
      gSettingsMenuModeGui.Destroy()
    }

    ;/////////////////////////
    textModeToIntmod(){
        global switchMode
        ;texTtoInt := "1"
        texTtoInt := (DDL1.Text)
        if (texTtoInt = "Fast mode"){
        switchMode :=1
       }else if (texTtoInt = "Hold mode"){
        switchMode :=2
       }else if (texTtoInt = "Youtube mode"){
        switchMode :=3
       }else if (texTtoInt = "Youtube mode new"){
        switchMode := 4
       }else if (texTtoInt = "Push to talk"){
        switchMode := 5
       }else{
          
        switchMode :=1
        MsgBox "Not a voild Option!" 
            }
       
    } ;end of textModeToIntmod funiction
;///////////////

	Return

} ;end of siitings mode GUI













;/////////////////////////////////////////////////


welcomeGui_Create(){

	welcomeGui := Gui(, "welcom GUI")


	btnAbout := welcomeGui.AddButton("x26 y229 w251", "&OK")

	btnAbout.OnEvent("Click", (GuiObj,Info)=>(MyBtn_Click()))

	welcomeGui.Show("w300 h300")

	Return

}

MyBtn_Click() ;Function to be called when button pressed
{
    msgBox("Pressed Button")    
}   
;//////////////////////////////////Funiction//////////////////////////////////////////
;//////////combo switch//////////////
comboKeySwitch(){
    SetCapsLockState("Off")
    Send("{LWin down}{LCtrl down}{" direction "}{LWin up}{LCtrl up}")
    SetCapsLockState("Off")
}


;/////////
