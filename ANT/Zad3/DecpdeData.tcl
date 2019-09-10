package require antStandardChannels
package require antUtils

#variable used for creating frames  
set var "";   

#variable used for counting bytes from channel  
set count 0;        

#variable used for excludeing first frame of data 
set first_frame 0

#size of the file from which data are receving
set size 0

antEnvGet file_size {apply { {status value} {set ::size $value}}}

proc startup {} {
   antInstallHook "0.1 s"
   antStdInitializeChannel "frame_output" "Writable" "String" "" "1" "1000"
}

proc shutdown {} {
   # Actions on module's shutdown
}

proc timerHook {hook_name timestamp} {
   
   if {$hook_name eq "0.1 s"} {
      
      antGetChannelValue *byte_data {} decode
   }
}

#This procedure: 
#-creates frames form received data,
#-encodes data to Base64 
#-sets encoded data on the "frame_output channel"
proc decode {channel_name channel_time channel_value status} {
   
   incr ::count
   
   if {$channel_value == "\x00"} {
      incr ::first_frame
   }
   
   if {$::count <= $::size } {
      
      if {($channel_value == "\x00")} {
         
         if {[string length $::var] == 0} {
            return
         }
                  
         if {$::first_frame > 1} { 
             
             set ::var [binary encode base64 -maxlen 64 $::var]
		       antSetChannelValue "frame_output" $::var
         }
         
		   set ::var ""
         
         return
		} 
        
      if {$::var == ""} {
         set ::var $channel_value 
      } else {
         set ::var [string cat $::var $channel_value]
      }       
	}
}   
   