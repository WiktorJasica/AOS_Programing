################# Decode_Data

 if {$::count <= 43 } {
      
      if {($channel_value=="") && ([string length $::var]!=0)} {
		set ::var [binary encode base64 -maxlen 64 $::var]
		antSetChannelValue "frame_output" $::var
		set ::var ""
		continue
		}
      
		set ::var [string cat $::var $channel_value]
		set ::var [string trimleft $::var]
		
	}
	
###	
	if {($::count) >= 8 && ($::count <= 15)} {
      
   	set ::var [string cat $::var $channel_value]    
      
      if {$::count==15} {
         set ::var [binary encode base64 -maxlen 64 $::var]
         antSetChannelValue "frame_output" $::var
      }
   }
		


#####################Get_From_file

if {$hook_name eq "0.1 s"} {
     
     incr ::count
       
     if {$::count <= [file size C:/Users/Wiktor/Desktop/ANT_Solutions/ant_test.bin]} {
        
       antSetChannelValue "byte_data" [read $::file_channel 1]
     }

   }


#Wm1sc1pUSTFOakl6T1RBPQ
#file2562390
#AQIDBAUGACLCLVqK5Ip4ADaCLSLJ7QAJEhskLTY/ODg5OQAAabcd0123AA==
#16909060
#1000000100000001100000100

#1 2 3 4 5 6 /6
#0 /1
#34 -62 45 90 -118 -28 -118 120  /8
#0 /1
#54 -126 45 34 -55 -19 /6 
#0 /1
#39 18 27 36 45 54 63 56 56 57 57 /11
#0  /1
#0  /1
#105 -73 29 -45 93 -73  /7
#0  /1

#set bytesList ""
#set data [gets $kanal zmienna]

#for {set i 1} {$i<=43} {incr i} {
#	lappend bytesList [read $kanal 1]
#}

#foreach i $bytesList {
#	puts $i
#}