
$01 = 0.001;
$02 = 2*$01;
$03 = 3*$01;
$04 = 4*$01;

size = 50;
sphereSize = size/1.44;
dotSize = size * 0.18;
dotDepth = dotSize*0.3;
dotMove = sphereSize * 0.29;
dotDiff = 0.4;

numbers = [
// rotation, correcion, points ...
 [[0,0,0,   0,0],   [0,0]] // 1
,[[0,-90,0, -2,-2], [-1,-1],[1,1]] // 2
,[[-90,0,0, 0,0],   [-1,-1],[1,1],[0,0]] // 3
,[[90,0,0,  -1,-1], [-1,-1],[1,1],[-1,1],[1,-1]] // 4
,[[0,90,0,  0,0],   [-1,-1],[1,1],[-1,1],[1,-1],[0,0]] // 5
,[[0,180,0, -2,5],  [-1,-1],[1,1],[-1,1],[1,-1],[-1,0],[1,0]] // 6
];

module number(points, bcFlag) {
	def = points[0];
	xf = dotMove + (def[3] * dotDiff);
	yf = dotMove + (def[4] * dotDiff);
	rotate([def[0],def[1],def[2]])
	translate([0,0,-size/2])
	for (i = [1:len(points)-1]) {
		p = points[i];
		translate([p[0]*xf,p[1]*yf])
		dimple(dotSize, dotDepth, $fn=40, bcFlag=bcFlag);
		// translate([p[0]*xf,p[1]*yf])
		// sphere(dotSize, $fn=20);
	}
}

	bottomCorrection = 0;

translate([-size,-size,0]) {
	rotate([180,0,0]) dice();
	rotate([35.27,45,-90]) eyelet();
}

translate([size,-size,0]) {
	rotate([180,0,0]) dice();
}

translate([-size,size, 0]) {
	rotate([45,35.27,0]) dice();
	eyelet();
}

translate([size,size, 0]) {
	rotate([45,35.27,0]) dice();
}

supports();

module supports() {
	cd = size*0.97;
	translate([0,0,-sphereSize])
	linear_extrude(size/2)
	projection()
	intersection() {
		rotate([45,35.27,0]) difference() {
			cube(size, center=true);
			cylinder(d=cd, size+$01, center=true);
			rotate([90,0,0]) cylinder(d=cd, size+$01, center=true);
			rotate([0,90,0]) cylinder(d=cd, size+$01, center=true);
		};
		translate([0,0,-size]) cylinder(d=size*0.95, size);
	}
}

module eyelet() {
	$fn = 100;
	eyeletSize = sphereSize/4;
	eyeletHole = eyeletSize/2;

	echo("eyelet", eyeletSize, eyeletHole);

	translate([0,0,sphereSize+eyeletSize/2])
	difference() {
		union() {
			sphere(d=eyeletSize);
			translate([0,0,-eyeletSize]) cylinder(eyeletSize, d=eyeletSize);
		}
		rotate([90,0,0]) cylinder(eyeletSize*2+$02, d=eyeletHole, center=true);
	}
}



module dice() {
	difference() {
		intersection() {
			cube(size, center=true);
			sphere(sphereSize, $fn=140);
		}
		numbers();
	}
}

module numbers() {
	for (i=[1:len(numbers)]) {
		number(numbers[i-1], i==bottomCorrection);
	}
}

// $fn = 100;
// dimple(d=20, r=10, bottomCorrection = true);

module dimple(d=20, r=10, bcFlag=false) {
	scale([1,1,2*r/d]) sphere(d=d);
	// translate([0,0,-$01]) cylinder(d=d,r)
	if (bcFlag) {
		alfa = atan(2*r/d);
		x = cos(alfa) * d/2;
		y = sin(alfa) * r;
		h = r-y;
		r1 = x;
		r2 = r1 - h;
		echo(alfa,x,y);
		translate([0,0,y])
		cylinder(r1=r1, r2=r2, h);
	}
}
