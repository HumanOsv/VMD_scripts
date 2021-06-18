







#mol load psf ions.psf dcd ions_peptide.dcd

set outfile1 [open Grafical_all.csv w]
set num_frames [molinfo top get numframes]

puts $outfile1 "Time (ns)\tDistance (A)"

for {set i 0} {$i < $num_frames} {incr i } {
	#
	set mol    [atomselect top "noh resname UNL" frame $i]
	set pocket [atomselect top "noh protein resid 100 128 140 139" frame $i]
	set center_mol    [measure center $mol    ]
	set center_pocket [measure center $pocket ]
	#
	set axis_x_mol    [lindex [lindex $center_mol 0] 0]
	set axis_y_mol    [lindex [lindex $center_mol 1] 0]
	set axis_z_mol    [lindex [lindex $center_mol 2] 0]

	set axis_x_pocket [lindex [lindex $center_pocket  0] 0]
	set axis_y_pocket [lindex [lindex $center_pocket  1] 0]
	set axis_z_pocket [lindex [lindex $center_pocket  2] 0]
	#
	set rest_x [ expr $axis_x_pocket - $axis_x_mol ]
	set rest_y [ expr $axis_y_pocket - $axis_y_mol ]
	set rest_z [ expr $axis_z_pocket - $axis_z_mol ]

	set pow_x [ expr pow($rest_x,2) ]
	set pow_y [ expr pow($rest_y,2) ]
	set pow_z [ expr pow($rest_z,2) ]
	set suma_total [expr $pow_x + $pow_y + $pow_z ]
	set valor [expr sqrt( $suma_total )]

	set nanos_segundos [expr ($i * 50000)/1000000.0 ]

	puts $outfile1 [format "%.2f\t%.4f" $nanos_segundos $valor]

	$mol delete
	unset mol
	$pocket delete
	unset pocket
}
close $outfile1
