package require psfgen
topology top_all27_prot_lipid_na.inp

pdbalias residue HIS HSD
pdbalias atom SER HG HG1
pdbalias atom ILE CD1 CD
pdbalias atom CYS HG HG1
pdbalias atom ILE 1HD1 HD1
pdbalias atom ILE 2HD1 HD2
pdbalias atom ILE 3HD1 HD3

segment A {first NTER; last CTER; pdb ubqp.pdb;}
coordpdb ubqp.pdb A
guesscoord

writepdb ubqp.pdb
writepsf ubqp.psf

mol delete all
mol load psf ubqp.psf pdb ubqp.pdb
