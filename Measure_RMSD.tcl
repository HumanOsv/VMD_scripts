# Prints the RMSD of the protein atoms between each timestep
# and the first timestep for the given molecule id (default: top)

set outfile [open rmsd.agr w]
# Use frame 0 for the reference
set reference [atomselect top "noh resname LIG" frame 0]

set num_steps [molinfo top get numframes]
for {set frame 0} {$frame < $num_steps} {incr frame} {
  # get the correct frame
  # the frame being compared
  set compare [atomselect top "noh resname LIG" frame $frame]
  $compare frame $frame
  # compute the transformation
  set trans_mat [measure fit $compare $reference]
  # do the alignment
  $compare move $trans_mat
  # compute the RMSD
  set rmsd [measure rmsd $compare $reference]
  # print the RMSD
  set nanos_segundos [expr $frame/20.0]
  puts $outfile [format "%.2f\t%.4f" $nanos_segundos $rmsd]
  $compare delete
  unset compare
}
close $outfile
