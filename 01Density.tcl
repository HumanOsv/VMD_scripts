






mol load psf Build_system.psf dcd system_complex.dcd

# Go through every frame
set n [molinfo top get numframes]
# Write to standard out
#set outfile [open $name w]

for {set i 0} {$i < $n} {incr i} {
  #
  set sel [atomselect top all frame $i]
  set minmax [measure minmax $sel]
  set min_x [lindex [lindex $minmax 0] 0]
  set max_x [lindex [lindex $minmax 1] 0]
  set min_y [lindex [lindex $minmax 0] 1]
  set max_y [lindex [lindex $minmax 1] 1]
  set min_z [lindex [lindex $minmax 0] 2]
  set max_z [lindex [lindex $minmax 1] 2]
  #
  set lenght_x [expr $max_x - $min_x]
  set lenght_y [expr $max_y - $min_y]
  set lenght_z [expr $max_z - $min_z]
  # Measure Volume (A3)
  set vol [expr $lenght_x * $lenght_y * $lenght_z ]
  # Measure Mass for all molecules
  set mol      [atomselect top "all" frame $i]
  set mass_mol [measure sumweights $mol weight mass ]
  #
  set density_1 [expr $mass_mol/$vol ]
  set density_2 [expr $density_1 * 1.66]
  set density_3 [expr $density_1 * 1660]

  puts "$density_1\t$density_2\t$density_3"

  $sel delete
  unset sel
  $mol delete
  unset mol
}

exit
