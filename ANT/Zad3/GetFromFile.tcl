#Channle opened to the file "ant_test.bin" 
#-antGetResourceFilePath function used for getting path to the file in Rsource of module
set file_channel [open [antGetResourceFilePath ant_test] rb]

#Setting file size to enviroment variable
antEnvSet file_size size [file size [antGetResourceFilePath ant_test]]

#variable used for counting bytes from string
set count 0

proc startup {} {
   antStdInitializeChannel "byte_data" "Writable" "String" "" "1" "1000"
   antInstallHook "0.1 s"
}

proc shutdown {} {
   close $::file_channel
}


#This procedure:
#-puts byts from "ant_test.bin" file on channel "byte_data" in evry 100ms
proc timerHook {hook_name timestamp} {
   
   if {$hook_name eq "0.1 s"} {
             
    incr ::count
       
     if {$::count <= [file size [antGetResourceFilePath ant_test]]} {
        
       antSetChannelValue "byte_data" [read $::file_channel 1]
     }
    
   }
}