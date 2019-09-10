
#############################################
set kanal1 [open ant_test.bin rb]
set bytesList ""
set tab ""
set var ""
set frame 0


for {set i 1} {$i <= [file size ant_test.bin]} {incr i} {
	
		set byte [read $kanal1 1]
		
	   
		if {$byte == "\x00"} {
			incr ::first_frame
		}
   
      
		if {($byte == "\x00")} {
			
         
			if {[string length $::var] == 0} {
				continue
			}
                  
			if {$::first_frame > 1} { 
				
				set ::var [binary encode base64 -maxlen 64 $::var]
				puts $::var
			}
			
			set ::var ""
		 
			continue
		} 
         
		 if {$::var == ""} {
			set ::var $byte
		 } else {
			set ::var [string cat $::var $byte]
		 }
}

puts [binary encode base64 -maxlen 64 $var]
#foreach i $tab {
	#puts $i
#}

close $kanal1








