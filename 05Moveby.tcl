# Para centrar tu sistema en el origen
set mol [atomselect top all]
$mol moveby [vecinvert [measure center $mol weight mass]]
# nombre del archivo o output que ya se centro
$mol writepdb idronio_out_H2O_Center.pdb
# caragb archivo centrado
mol load pdb idronio_out_H2O_Center.pdb

