set num 44

proc proba {x} {

return [expr {$x+$x}]
}

set y [apply {{val} {
	set result [proba $val] 
	return $result}} $num]
 
puts $y