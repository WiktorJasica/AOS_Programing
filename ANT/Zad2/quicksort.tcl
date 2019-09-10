proc startup {} {
  antInitializeChannels "unsorted_list" { Access "Writable" ValueType "signedInteger" }
  antInitializeChannels "sorted_list" { Access "Writable" ValueType "signedInteger" }
  
  antSetChannelValue "unsorted_list" [antGetModuleSetting unsorted_list]
  antSetChannelValue "sorted_list" [sort [antGetModuleSetting unsorted_list]] 
}

proc shutdown {} {
   
}


#Main sort procedure that takes as arguments unsorted list of values
#This procedure uses Quicksort algorithm
proc sort {un_list} {
   
   set left 0
   set right [expr {[llength $un_list] - 1}]
   
   if {[llength $un_list] == 0 || [llength $un_list] == 1 } {
      
      return $un_list 
      
   } else {
      
     return [quickSort $un_list $left $right]
   }     
}

#Recursive Quicksort algorithm  
proc quickSort {un_list left right} {
	
	if {$left >= $right} {
		return $un_list
	}
	
   set border [expr {$left-1}]
	set piv [lindex $un_list $right]
	
	for {set i $left} {$i <= $right} {incr i} {
		
		if {[lindex $un_list $i] < $piv} {
			
			incr border
			if {$border != $i} {
				set temp [lindex $un_list $border]
				lset un_list $border [lindex $un_list $i] 
				lset un_list $i $temp
				unset temp
			}
		}	
	}	
	
	incr border
		
		if {$border != $right} {
			set temp [lindex $un_list $border]
			lset un_list $border $piv 
			lset un_list $right $temp
			unset temp
		}
	
	
   set un_list [quickSort $un_list $left [expr {$border-1}]]
   set un_list [quickSort $un_list [expr {$border+1}] $right]
	
	return $un_list
}