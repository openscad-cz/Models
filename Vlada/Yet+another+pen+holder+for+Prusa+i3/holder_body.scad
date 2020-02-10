$fn=100;
nema = 41.82;
wall = 4;

/**
 * Holder for nema17 stepper motor body.
*/
module nema17() {
  union() {
    difference() {
    //outer shell
    rotate([180,-90,0]) translate([0,0,5]) cube ([nema+wall,nema+wall,20], center=true);
    //nema
    rotate([180,-90,0]) cube ([nema,nema,nema], center=true);
    //relief
    rotate([180,-90,0])  translate([0,-(nema+wall)/2,0]) cube([10, 7, 60], center=true);
    }
    //cover
    translate([13,0,0]) cube ([wall+1,nema+wall,nema+wall], center=true);
  }
}
/**
 * Nut traps for pen holder.
*/
module trap() {
 rotate([180,-90,0]) cylinder (d=6.25, h=4.5,Center=true, $fn=6);
}
/**
 * Screw for pen holder.
*/
module screw() {
     rotate([180,-90,0]) cylinder (d=3.2, h=30,Center=true);
}
/**
 * Screw and nut traps for pen holder.
*/
module holes() {
    //screw holes
    //top right
    translate([0,-15,-7.5]) screw();
    //bottom right
    translate([0,15,-7.5]) screw();
    //top left
    translate([0,-15,7.5]) screw();
     //bottom left
    translate([0,15,7.5]) screw();
    //nut traps
    //top right
    translate([8,-15,-7.5]) trap();
    //bottom right
    translate([8,15,-7.5]) trap();
    //top left
    translate([8,-15,7.5]) trap();
    //bottom left
    translate([8,15,7.5]) trap();
    }
/**
 * Relatively universal tool holder.
*/
module assembly() {
difference() {
      nema17();
      holes();
}
    }
/**
 * Alignment for printing.
*/
 translate([0,0,20.5]) rotate([0,90,0]) assembly();
