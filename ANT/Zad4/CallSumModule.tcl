package require antStandardChannels
package require antUtils

proc startup {} {
   antInstallHook "1 s"
   antStdInitializeChannel "called_sum" "Writable" "SignedInteger" "" "1" "1000"
}

proc shutdown {} {
   # Actions on module's shutdown
}

proc timerHook {hook_name timestamp} {
   if {$hook_name eq "1 s"} {
      antCallFunction p_sum sum_of_primes {3 5} -callback {apply { {status result} {antSetChannelValue "called_sum" $result} }}   
   }
}
