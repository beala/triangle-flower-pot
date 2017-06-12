$fn = 50;

include <2dshapes.scad>

// Thickness of all sides
wallThickness = 4;

// Length of the two legs of the triangle
xLen = 180;
yLen = 180;

// Height of the pot (not including the tray)
height = 85;

// Radius of the drainage holes
holeRadius = 5;

// Height of the lip on the bottom of the pot that keeps the
// tray in place.
trayLip = 2;

// X and Y distance between each half of the pot
sep = 5;

// Tolerance of the tray lip
tol = 0.5;

// Module for drawing one side of the pot
module trianglePot() {
     difference() {

	  // Calculate the dimensions for the inside of the pot.
	  diff = wallThickness +
	       sqrt(2 * wallThickness * wallThickness) +
	       wallThickness;

	  innerXLen = xLen - diff;
	  innerYLen = yLen - diff;
	  
	  union() {
	       linear_extrude(height) rightTriangle(xLen, yLen);

	       // Tray lip
	       translate([wallThickness + tol, wallThickness + tol, -trayLip])
		    linear_extrude(height) rightTriangle(innerXLen, innerYLen);
	  }

	  // Subtract out the inside of the pot
	  translate([wallThickness, wallThickness, wallThickness]) {
	       linear_extrude(height) {
		    rightTriangle(innerXLen , innerYLen);
	       }
	  }

	  // Drainage holes 
	  translate([wallThickness + (2*holeRadius), wallThickness + (2*holeRadius), -height/2]) {
	       linear_extrude(height)
		    circle(holeRadius);
	  }

	  translate([wallThickness + innerXLen - (5 * holeRadius), wallThickness + 2*holeRadius, -height/2]) {
	       linear_extrude(height)
		    circle(holeRadius);
	  }

	  translate([wallThickness + 2*holeRadius, wallThickness + innerYLen - (5 * holeRadius), -height/2]) {
	       linear_extrude(height)
		    circle(holeRadius);
	  }

	  translate([xLen/3, yLen/3, -height/2]) {
	       linear_extrude(height)
		    circle(holeRadius);
	  }
     }
}


// Height of the tray
trayHeight = 10;

// Module for drawing the drip tray.
module dripTray() {
     difference() {
	  cube([xLen + sep, yLen + sep, trayHeight], center = true);
	  translate([0,0,wallThickness]) cube([xLen + sep - (wallThickness * 2), yLen + sep - (wallThickness * 2), trayHeight], center=true);
     }
}

