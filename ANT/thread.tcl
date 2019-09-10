package require Thread 
set value1 4
set inputArg1 5
set inputArg2 6

set threadId [::thread::create {
   package require Thread
   proc proc1 {arg1 arg2 tid} {
         antLog arg1 $arg1
         antLog arg2 $arg2
         # call main thread
         ::thread::send -async $tid {
            proc2 {input1 input2} {
               antLog mainThread_input1 $input1
               antLog mainThread_input2 $input2
            }
         }
         ::thread::send -async $tid [list proc2 $arg1 $arg2]
         antLog after send        
      }
#       Waiting for upcoming events
      thread::wait
   }

]

thread::send -async $threadId [subst {proc1 $inputArg1 $inputArg2 [::thread::id]}]
   




