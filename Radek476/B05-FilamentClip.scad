
// POZOR!!! Pracovní verze - po přepracování prážek ještě nebylo testováno při tisku

length = 22;
height = 6;
width = 15;

fd = 1.75; // Filament diameter

d3 = 1.0; // Vule nabehu
d2 = -0.01; // Vule zuzeni;
d2R = -0.01; // Vule zuzeni - Prava drazka;
d1 = 0.3; // Vule pro filament

h1 = 1.5; // Vyska pevne casti
h2 = h1+fd/2; // Vyska stredu drazky

ww = 4; // Roztec
w1 = (width-ww)/2;
w2 = (width+ww)/2;
w3 = w2 - d1*2;


// Helper variables ...

$01 = 0.001;
$02 = 2*$01;
$03 = 3*$01;
$04 = 4*$01;
$05 = 5*$01;

// Printing and printer settings ... 

$plh = 0.35; // Printing Layer Height
$pl1 = 0.2; // First Layer Height
$pnd = 0.4; // Printer Nozzle Diameter

main();

module main() {
	difference() {
		body();
		laxGroove();
		fixGroove();
	}
}

// 
module laxGroove() {
	linear_hull([w1,0,h2],[w1,length,h2]) {
		translate([d1/2,0,0]) grooveFilament();
		grooveLock(d2);
		grooveShape(d2);
	}
}

module fixGroove() {
	len1 = length/4;
	len2 = length/2;
	len3 = length - len1;
	linear_hull([w2,0,h2],[w2,len1,h2]) {
		translate([-d1/2,0,0]) grooveFilament();
		grooveLock(d2R);
		grooveShape(d2R);
	}
	linear_hull([w2,len1,h2],[w3,len2,h2]) {
		translate([-d1/2,0,0]) grooveFilament();
		grooveLock(d2R);
		grooveShape(d2R);
	}
	linear_hull([w3,len2,h2],[w2,len3,h2]) {
		translate([-d1/2,0,0]) grooveFilament();
		grooveLock(d2R);
		grooveShape(d2R);
	}
	linear_hull([w2,len3,h2],[w2,length,h2]) {
		translate([-d1/2,0,0]) grooveFilament();
		grooveLock(d2R);
		grooveShape(d2R);
	}

	linear_hull([w2,0,h2],[w3,len2,h2]) {
		translate([-d1/2,0,0]) grooveFilament();
		grooveLock(d2R);
		grooveShape(d2R);
	}
	linear_hull([w3,len2,h2],[w2,length,h2]) {
		translate([-d1/2,0,0]) grooveFilament();
		grooveLock(d2R);
		grooveShape(d2R);
	}
}

module linear_hull(a,b) {
	for (i = [0:$children-1]) {
		hull() {
			translate(a) children(i);
			translate(b) children(i);
		}
	}
}

module linear_translate(a,b,n=100) {
	d = (b-a)/n;
	for (i=[0:n]) {
		// echo("x",a+d*i);
		translate(a+d*i) children();
	}
}


module grooveFilament() {
	#sphere(d=fd+d1, $fn=50);
}
module grooveLock(d2) {
	translate([0,0,0])
	#cylinder(d=fd+d2, fd, $fn=40);
}
module grooveShape(d2) {
	shift = fd/2 + $plh;
	translate([0,0,shift])
	hull() {
		translate([0,0,0]) sphere(d=fd+d2, $fn=40);
		translate([0,0,height-shift-fd/2-h1+$01]) sphere(d=fd+d3, $fn=40);
	}
	// cylinder(d1=fd+d2, d2=fd+d3, height-shift-fd/2-h1+$01, $fn=4);
}


module body() {
	$fn=100;
	intersection() {
		cube([width,length,height]);
		scale([1,1,0.8]) translate([width/2,0,h1]) rotate([-90,0,0]) cylinder(d=width,length);
		translate([0,length/2,-length*0.26]) rotate([0,90,0]) cylinder(d=length*1.2,width);
	}
}
