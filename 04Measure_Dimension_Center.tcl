##############################################################################
## Calcula el centro del sistema y las dimensiones en las coordenas (X,Y,Z) ##
##############################################################################

set sel [atomselect top all]
set minmax [measure minmax $sel]
set min_x [lindex [lindex $minmax 0] 0]
set max_x [lindex [lindex $minmax 1] 0]
set min_y [lindex [lindex $minmax 0] 1]
set max_y [lindex [lindex $minmax 1] 1]
set min_z [lindex [lindex $minmax 0] 2]
set max_z [lindex [lindex $minmax 1] 2]

###  Resultado
set lenght_x [expr $max_x - $min_x] 
set lenght_y [expr $max_y - $min_y] 
set lenght_z [expr $max_z - $min_z] 

puts "$lenght_x\t$lenght_y\t$lenght_z\n"
set center [measure center $sel]
puts "$center\n"

