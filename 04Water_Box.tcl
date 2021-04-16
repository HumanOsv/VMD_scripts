#############################################################
## Construir (adicionar) la Caja de Agua                   ##
#############################################################
#Estos parametros contruyen una caja de agua add-hoc al sistema
mol delete all
resetpsf
# solvate 1.1 has a bug, either 1.1.1 (downloaded) or 1.2 will work
package require solvate
# debes colocar en nombre de tu .psf y el .pdb, ademas el nombre de tu output(idronio_out_H2O)
solvate idronio_out_1.psf idronio_out_1.pdb -o idronio_out_H2O -s WT -b 1 -t 0 -z 10 +z 10 -y 10 +y 10 -x 10 +x 10
#Se elimina todo y se cargan los archivos generados
mol delete all
# carga el sistema con aguas
mol load psf idronio_out_H2O.psf pdb idronio_out_H2O.pdb


