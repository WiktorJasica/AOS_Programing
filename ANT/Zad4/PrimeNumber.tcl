#Function that calculates n-prime number
#"n" - the argument that indicates n-prime number  
antFunction n_prime_number n {

set call_id [antGetFunctionCallId]

set t1_id [thread::create {
   
   #Procedure that counts the n-prime number
	proc n_prime {n} {

      #prime number counter
      set lp 0 
      
      #checked number
      set p 2

      while {$lp < $n} {
         
         #prime number flag
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
   
   thread::wait
  
}] 


tsv::set share Val $n

thread::send $t1_id {return [n_prime [tsv::get share Val]]} 


[list callback $call_id]

antSuspendFunction 
}


proc callback {call_id data} {
  antReturnFunction $call_id $data 
}