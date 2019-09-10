set kanal [open ant_test.bin rb]

set r1 [read $kanal 6]
puts $r1

set r2 [read $kanal 1]
puts $r2

set r3 [read $kanal 8]
puts $r3
puts [binary encode base64 -maxlen 64 $r3]

set r4 [read $kanal 1]
puts $r4

set r5 [read $kanal 6]
puts $r5
puts [binary encode base64 -maxlen 64 $r5]

set r6 [read $kanal 1]
puts $r6

set r7 [read $kanal 11]
puts $r7
puts [binary encode base64 -maxlen 64 $r7]

set r8 [read $kanal 1]
puts $r8

set r9 [read $kanal 1]
puts $r9

set r10 [read $kanal 6]
puts $r10
puts [binary encode base64 -maxlen 64 $r10]

set r11 [read $kanal 1]
puts $r11

puts "$r1 $r2 $r3 $r4 $r5 $r6 $r7 $r8 $r9 $r10 $r11"

close $kanal