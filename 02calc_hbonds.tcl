# calc_hbonds.tcl
# Use VMD to determine find the number of times that the residues in "selection"
# are involved in h-bonds.  Write out every time this occurs.
#
#   vmd -dispdev text -e calc_hbonds.tcl my_psf my_dcd -args selection
#
#
set USAGE "vmd -dispdev text -e 02calc_hbonds.tcl -args resname UNL"
#
set dist 3.5
set angle 30.0
set other_sel "protein"
set sel "resname LIG"
#
# Parse command line
set obj1 [lindex $argv 0]
set stripped1 [string map {" " ""} $obj1 ]
set name "$stripped1.txt"

# Procedure to extract the residue numbers and atom names of each atom
# participating in a hydrogen bond.
proc extract_names {hbonds} {
	set m [llength [lindex $hbonds 0]]
	if { $m > 0} then {
		#
		set d_list [lindex $hbonds 0]
		set a_list [lindex $hbonds 1]
		#
		set d_out [list]
		set a_out [list]
		#
		for {set j 0} {$j < $m} {incr j} {
			set d [atomselect top "index [lindex $d_list $j]"]
			set a [atomselect top "index [lindex $a_list $j]"]
			lappend d_out [$d get {resid resname name}]
			lappend a_out [$a get {resid resname name}]
		}
		set out "$d_out\t$a_out"
	} else {
		set out "NA\tNA"
	}
	return $out
}
# Arithmetic Operators
proc sum {a b} {
	return [expr $a + $b]
}
#
#
#
# Create objects for hbond measurements
#
set obj1_sel [atomselect top "$sel"]
set obj2_sel [atomselect top "$other_sel"]
# Go through every frame
set n [molinfo top get numframes]
# Write to standard out
set outfile [open $name w]

puts $outfile "$stripped1"

for {set i 0} {$i < $n} {incr i} {
    # Advance the frame
    molinfo top set frame $i
    # Look for hydrogen bonds
    set hbonds_donor [measure hbonds $dist $angle $obj1_sel $obj2_sel]
    set hbonds_accept [measure hbonds $dist $angle $obj2_sel $obj1_sel]
		#
    # Extract residue names
		set out_donor  [extract_names $hbonds_donor]
		set out_accept [extract_names $hbonds_accept]
		#
		set indDonor  [lindex $hbonds_donor 0]
		set indAccept [lindex $hbonds_accept 0]
		#
		set num_donor  [ llength $indDonor  ]
		set num_accept [ llength $indAccept ]
  	# Print out
  	set result [sum $num_donor $num_accept]
  	#
    puts $outfile "$out_donor\t$out_accept = $result"
}
close $outfile
# Write to standard out
exit
