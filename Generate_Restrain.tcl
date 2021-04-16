# Generate position Restrained files for namd simulations
# In VMD:
# source gen_pr
# gen_pr (# of restraint)
# The files are named #.pdb
# In the beta(B-factor) field a number is placed
# as a force restraint for each atom
# can be changed to CA by changing "set a.." line

# Example:

# In this file all atoms have a restraint of 5 kcal/mol. Restraint is in column 11.
# CRYST1    0.000    0.000    0.000  90.00  90.00  90.00 P 1           1
# ATOM  14263  N   ALA A   1      -5.572 -16.363   2.487  1.00  5.00      A    N
# ATOM  14264  HT1 ALA A   1      -4.660 -16.576   2.837  1.00  5.00      A    H


proc gen_pr { num } {
	set name Restrain_CA
	set ConstraintScaling $num
	set a [atomselect top "backbone"]
#	set c [atomselect top "backbone"]
	set b [atomselect top all]
	$a set beta $ConstraintScaling
#	$c set beta $ConstraintScaling
	$b writepdb $name.pdb
}

mol load pdb MaoBChC4_H2O_ion.pdb

# Numero de  kcal/mol/A^2
gen_pr 10

#for {set i $num } {$i >= 0} {incr i -1} {
#$a set beta $ConstraintScaling
#$b writepdb $i.pdb
#$b writepdb $name.pdb
#}
