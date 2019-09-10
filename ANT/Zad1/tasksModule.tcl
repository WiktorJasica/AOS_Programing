#List used for storing input values
set list_of_values ""

#Min value of channel
set min 0

#Min value of channel
set max 0

#value used for counting integral
set integral_val 0

#value of previous channel input, used for counting differential
set prev_val 0

proc startup {} {
   antInstallHook "1 s"
   antInitializeChannels "Power" { Access "Writable" ValueType "signedInteger" Logging 1}
   antInitializeChannels "Sum_of_elements" { Access "Writable" ValueType "signedInteger" Logging 1}
   antInitializeChannels "Min_value" { Access "Writable" ValueType "signedInteger" Logging 1}
   antInitializeChannels "Max_value" { Access "Writable" ValueType "signedInteger" Logging 1}
   antInitializeChannels "Integral" { Access "Writable" ValueType "signedInteger" Logging 1}
   antInitializeChannels "Differential" { Access "Writable" ValueType "signedInteger" Logging 1}
}


proc shutdown {} {
   
}


proc timerHook {hook_name timestamp} {
      if {$hook_name eq "1 s"} {
      antGetChannelValue *Input_value {} tasks
   }
}


proc tasks {channel_name channel_time channel_value status} {
   
    antSetChannelValue "Power" [power_of_x $channel_value]
    
    antSetChannelValue "Sum_of_elements" [sum_of_inputs $channel_value] 
    
    min_max $channel_value
    
    antSetChannelValue "Integral" [integral $channel_value]
    
    antSetChannelValue "Differential" [differential $channel_value] 
}


#Calculates power of value from channel Input_value. 
proc power_of_x {channel_value} {
   
      set val [expr pow($channel_value,[antGetModuleSetting y_pow])]   
      
      return $val
}

#Counts sum of 10 inputs from channel Input_value.
proc sum_of_inputs {channel_value} {
   
     lappend ::list_of_values $channel_value
     
     if {[llength $::list_of_values ] == 10} {
        set sum  0
        
        foreach i $::list_of_values {
           set sum [expr {$sum + $i}]
        }
        
        set ::list_of_values ""
        
        return $sum
     } 
}

#Sets min and max value form channel Input_value to output channels
proc min_max {channel_value} {
   
   if {$channel_value < $::min} {
      set ::min $channel_value
   }
   
   if {$channel_value > $::max} {
      set ::max $channel_value
   }
   
   antSetChannelValue "Min_value" $::min
   antSetChannelValue "Max_value" $::max
  
}

################################
#Integral of Input_value channel 
################################
proc integral {channel_value} {
      
   set dt 1
   
   set ::integral_val [expr {$::integral_val + ($channel_value*$dt)}]
   
   return $::integral_val
}


####################################
#Differential of Input_value channel 
####################################
proc differential {channel_value} {
   
   set dt 1
    
    set diff_val [expr {($channel_value-$::prev_val)/$dt}]
   
   set ::prev_val $channel_value
   
   return $diff_val
}
