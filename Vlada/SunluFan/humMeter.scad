//https://www.thingiverse.com/thing:4729474
$fn=128;

difference()
{
    union()
    {
        cylinder(d=58,h=4+3);
        hull()
        {
            translate([0,0,0]) cylinder(d=2.8+8,h=4+3);
            translate([0,-30,0]) cylinder(d=2.8+8,h=4+3);
        }
        rotate ([0,0,120]) hull()
        {
            translate([0,0,0]) cylinder(d=2.8+8,h=4+3);
            translate([0,-30,0]) cylinder(d=2.8+8,h=4+3);
        }
        rotate ([0,0,-120]) hull()
        {
            translate([0,0,0]) cylinder(d=2.8+8,h=4+3);
            translate([0,-30,0]) cylinder(d=2.8+8,h=4+3);
        }
            
    }
    
    rotate([0,0,-60]) translate([43/-2,-3,-1]) cube([43,6,10]);
    translate([0,0,-1]) cylinder(d=41.2,h=20);
    translate([0,0,4]) cylinder(d=46,h=20);

    translate([0,-30,2]) cylinder(d=3.3,h=4+3);
    rotate ([0,0,120]) translate([0,-30,2]) cylinder(d=3.3,h=4+3);
    rotate ([0,0,-120]) translate([0,-30,2]) cylinder(d=3.3,h=4+3);
}