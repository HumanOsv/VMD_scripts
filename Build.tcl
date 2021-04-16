
package require psfgen
topology top_all27_prot_lipid_na.inp

segment A { 
      first NTER
      last CTER
      pdb sinHA.pdb
} 
patch ASPP A:69 
patch ASPP A:392
patch GLUP A:183

coordpdb sinHA.pdb A

segment B { 
      first NTER
      last CTER
      pdb sinHB.pdb
} 

patch GLUP B:182 
patch GLUP B:200

coordpdb sinHB.pdb B

guesscoord

writepsf salida.psf
writepdb salida.pdb



