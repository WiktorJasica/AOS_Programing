#Initilize Hook and chanels
proc startup {} {
   antInstallHook "1 s"
   antInitializeChannels "Input_value" { Access "Writable" ValueType "signedInteger" }
}

# Actions on module's shutdown
proc shutdown {} {
   
}


proc timerHook {hook_name timestamp} {
   if {$hook_name eq "1 s"} {
      
      #Sets randomly generated number on channel "Input_value" 
      antSetChannelValue "Input_value" [expr int(rand()*10)]
   }
}