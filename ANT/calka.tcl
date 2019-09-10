set val 6
proc input_function {x} {
	return $x
}

proc integral {x} {

	set xp 0.0
	set xk $x
	set accuracy 10.0	
	set dx [expr {(($xk-$xp))/$accuracy}]
	set result 0

	for {set i 1} {$i < $accuracy} {incr i} {
	
	set result	[expr {$result + [input_function [expr {($xp+($i*$dx))}]]}]
	puts $result
	}
	
	set result [expr {($result + ((([input_function $xp]+[input_function $xk])/2)))*$dx}]
	
	return $result
}


puts [integral $val]


#########################
#Additional calculations
#########################

proc input_function {x} {
   return $x
}

#Calculate integral value of function by trapezoidal method
proc func_integral {x} {
   
   set xp 0.0
	set xk $x
	set accuracy 10.0	
	set dx [expr {($xk-$xp)/$accuracy}]
	set result 0
	
	for {set i 1} {$i < $accuracy} {incr i} {
	
	set result	[expr {$result + [input_function [expr {$xp+($i*$dx)}]]}]
	puts $result
	}
	
	set result [expr {($result + ((([input_function $xp]+[input_function $xk])/2)))*$dx}]
	
	return $result
}