

source gyr_radius.tcl
source center_of_mass.tcl

set outfile [open radius_of_gyration.txt w]
puts $outfile "i rad_of_gyr"

set nf [molinfo top get numframes]
set i 0
set prot [atomselect top "noh resname LIG"]
while {$i < $nf} {
  $prot frame $i
  $prot update
  set i [expr {$i + 1}]
  set rog [gyr_radius $prot]
  puts $outfile "$i $rog"
}
close $outfile
