include <triangle_flower_pot.scad>

/* Render an exploded view illustrating how the pot fits together */

translate([0,0,trayLip]) trianglePot();
translate([xLen + sep, yLen + sep, trayLip]) rotate([0,0,180]) trianglePot();

translate([(xLen+2)/2, (yLen+2)/2, -trayHeight * 2]){
     dripTray();
}
