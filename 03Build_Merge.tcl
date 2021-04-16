#############################################################
## Fijar el fluoroforo a la Membrana                         ##
#############################################################

# vmd -dispdev text -e 03Build_Merge.tcl -args

# set echo on for debugging
echo on
mol delete all

# need psfgen module and topology
package require psfgen

#set files "F2-Gly-Gln-Aib-Cys1-Aib-Amp-Cys1_out"
set all [lindex $argv 0]
set parts [split $all .]
set files [lindex $parts 0]

set name "protein_FMN"
set final_file "Protein_peptide"

# load structures
resetpsf

readpsf  $name.psf
coordpdb $name.pdb

readpsf  $files.psf
coordpdb $files.pdb

# write full structure
writepsf $final_file.psf
writepdb $final_file.pdb

mol delete all
mol load psf $final_file.psf pdb $final_file.pdb

set mol [atomselect top all]
$mol moveby [vecinvert [measure center $mol weight mass]]
$mol writepdb $final_file.pdb


#############################################################
## Construir (adicionar) la Caja de Agua                   ##
#############################################################
#Estos parametros contruyen una caja de agua add-hoc al sistema
mol delete all
resetpsf

# solvate 1.1 has a bug, either 1.1.1 (downloaded) or 1.2 will work
package require solvate

# debes colocar en nombre de tu .psf y el .pdb, ademas el nombre de tu output(idronio_out_H2O)
solvate Protein_peptide.psf Protein_peptide.pdb -o solvate -s WT -b 1 -t 1 -z 10 +z 10 -y 10 +y 10 -x 10 +x 10

#Se elimina todo y se cargan los archivos generados
mol delete all


#############################################################
## Construir (adicionar) iones                             ##
#############################################################

package require autoionize

mol load psf solvate.psf pdb solvate.pdb
set all1 [atomselect top all]
set xchar [eval vecadd [$all1 get charge]]
puts "# Formal Charge"
puts "Carga Total antes= $xchar"

#autoionize -psf solvate.psf -pdb solvate.pdb -o ions  -sc 0.15 -cation SOD
autoionize -psf solvate.psf -pdb solvate.pdb -o ions  -neutralize -cation SOD
#
mol delete all
mol load psf ions.psf pdb ions.pdb
set all2 [atomselect top all]
set ychar [eval vecadd [$all2 get charge]]
puts "# Formal Charge"
puts "Carga Total despues= $ychar"


#############################################################
## Centrar                                                 ##
#############################################################
mol delete all
mol load psf ions.psf pdb ions.pdb
set mol [atomselect top all]
$mol moveby [vecinvert [measure center $mol weight mass]]
$mol writepdb ions.pdb


##############################################################################
## Calcula el centro del sistema y las dimensiones en las coordenas (X,Y,Z) ##
##############################################################################
mol delete all
mol load psf ions.psf pdb ions.pdb

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

exit
