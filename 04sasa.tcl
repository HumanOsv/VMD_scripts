#Script que mide SASA paca cada frame de una trayectoria

#   vmd -dispdev text -e 03sasa.tcl output.pdb

set n [molinfo top get numframes]
set outfile [open sasa.dat a]

for { set i 0 } { $i < $n } { incr i } {
   set all [atomselect top "resname GL1 GL2 GL3" frame $i]
  set r [measure sasa 1.4 $all]
  #puts [list $i $r]
  puts $outfile [format " %d\t%.4f" $i $r]


}

puts "Revisar archivo sasa.dat"
close $outfile
