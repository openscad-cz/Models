// logo.scad - Basic example of module, top-level variable and $fn usage

Logo(50, text="CZ");

// The $fn parameter will influence all objects inside this module
// It can, optionally, be overridden when instantiating the module
module Logo(size=50, $fn=100, text="") {
    // Temporary variables
    hole = size/2;
    cylinderHeight = size * 1.25;

    // One positive object (sphere) and three negative objects (cylinders)
    difference() {
        sphere(d=size);
        
        cylinder(d=hole, h=cylinderHeight, center=true);
        // The '#' operator highlights the object
        #rotate([90, 0, 0]) cylinder(d=hole, h=cylinderHeight, center=true);
        rotate([0, 90, 0]) cylinder(d=hole, h=cylinderHeight, center=true);
    }
		if (text>"") {
			textHeight = size * 0.03;
			textDelta = size * 0.05;
			color("RoyalBlue") rotate([50,0,45]) translate([0,0,size/2 - textDelta])
			linear_extrude(textHeight + textDelta)
			text(text, font="style:bold", halign="center", valign="center");
		}
}


echo(version=version());
// Written by Clifford Wolf <clifford@clifford.at> and Marius
// Kintel <marius@kintel.net>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

