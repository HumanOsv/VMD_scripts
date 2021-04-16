
##actually, rmsf over CA atoms can be done in vmd Tk console:
##load trajectory

##mol load psf protein.psf
##mol addfile protein.dcd waitfor all

set outfile [open rmsf.agr w]

#select CA atoms
set sel [atomselect top "protein and name CA"]
set rmsf [measure rmsf $sel first 0 last -1 step 1]

for {set i 0} {$i < [$sel num]} {incr i} {
  puts $outfile "[expr {$i+1}] [lindex $rmsf $i]"
}
close $outfile
