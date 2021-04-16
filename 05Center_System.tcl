set mol [atomselect top all]
$mol moveby [vecinvert [measure center $mol weight mass]]

$mol writepdb N264A_R3_hv1_ionized_c.pdb
#$mol writepdb center_r3_hv1_h.pdb

#mol delete all
mol load pdb N264A_R3_hv1_ionized_c.pdb
#mol load pdb center_r3_hv1_h.pdb
