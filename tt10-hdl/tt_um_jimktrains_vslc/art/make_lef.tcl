set origlist [magic::cellname list top]
magic::gds read "my_logo.gds"
set newlist [magic::cellname list top]

# Find entries in newlist that are not in origlist.
# If there's only one, load it into the window.

set newtopcells {}
foreach n $newlist {
   if {[lsearch $origlist $n] < 0} {
      lappend newtopcells $n
   }
}
if {[llength $newtopcells] == 1} {
   magic::load [lindex $newtopcells 0]
} elseif {[llength $newtopcells] != 0} {
   puts stdout "Top-level cells read from GDS file: $newtopcells"
}

lef write my_logo.lef
quit -noprompt
