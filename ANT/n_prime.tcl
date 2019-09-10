proc n_prime {n} {

	set lp 0
	set p 2
			
	while {$lp < $n} {
	
		set t true
	
		for {set i 2} {$i < $p} {incr i} {
			
			if {[expr {$p % $i}] == 0} {
				set t false
				break
			}
		} 
		
		if {$t == true} {
			incr lp
		}
		
		if {$lp==$n} {
			return $p
		}
				
		incr p
	}
}  

puts [n_prime 5]

