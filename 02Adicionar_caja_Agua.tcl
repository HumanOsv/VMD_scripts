package require solvate

solvate ubqp.psf ubqp.pdb -t 15 -o ubq_wb

mol delete all
mol load psf ubq_wb.psf pdb ubq_wb.pdb
