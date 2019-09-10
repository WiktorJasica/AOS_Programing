package require antUtils
package require Thread

# This function sum prime numbers calculated in PrimeNumber module by "n_prime_number" function 
antFunction sum_of_primes {n1 n2} {
   
   antCallFunction prime n_prime_number $n1 -callback {apply { {status result} {tsv::set share num1 $result}}}
   antCallFunction prime n_prime_number $n2 -callback {apply { {status result} {tsv::set share num2 $result}}}
   
   return [expr {[tsv::get share num1] + [tsv::get share num2]}]
}
