# Prints the RMSD of the protein atoms between each timestep
# and the first timestep for the given molecule id (default: top)


mol load psf ions.psf dcd ions_peptide.dcd

set outfile [open RMSD_protein.txt w]
# Use frame 10 for the reference
set reference [atomselect top "backbone" frame 10]

set num_steps [molinfo top get numframes]
for {set frame 10} {$frame < $num_steps} {incr frame} {
  # get the correct frame
  # the frame being compared
  set compare [atomselect top "backbone" frame $frame]
  $compare frame $frame
  # compute the transformation
  set trans_mat [measure fit $compare $reference]
  # do the alignment
  $compare move $trans_mat
  # compute the RMSD
  set rmsd [measure rmsd $compare $reference]
  # print the RMSD
  set nanos_segundos [expr ($frame * 50000)/1000000.0]
  puts $outfile [format "%.2f\t%.4f" $nanos_segundos $rmsd]
  $compare delete
  unset compare
}
close $outfile

exit
