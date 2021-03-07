l=50;  // Length of channel
d=5;  // Depth (outside), 3 mm min
cR=1;  // Radius for Rounding of corners
slop=0.1;  // Not too tight
w=0.01;  // Line width for initial drawing. We then widen it to 2 times nozzle diameter
nz=0.5 - w/2; // Nozzle diameter for vase mode
tT=1.8+slop; // Tslot thickness of lip
lC=2.2; // Length of retainer
t=0.1;  // Extra width for tension
tG=6-slop+2*t; // Tslot gap
endL=10+1;
endH=d+1;
$fn=256;
rotate([180,0,0])
render(convexity = 6)
difference() {
linear_extrude(height=l) cablehouse();
rotate([0,90,0])
translate([-l/2,endH/2,-endL-d])
cylinder(h = 2*endL, r = d,center = true/false);    
    
}
module cablehouse()
{
    minkowski()
    {
        union()
        {
            channelb();
            clip();
            mirror([1,0,0]) clip();
        }
        circle(r=nz,$fn=24);
    }
}

module channelb()
{
    translate([0,-d/2]) difference()
    {
        channela();
        scale([1-2*w/20,1-2*w/d]) channela();
        translate([0,d/2]) square([tG+tT+2*nz*1.41428,4*nz],center=true);
    }
}

module channela()
{
    translate([0,d/2]) hull()
    {
        translate([10-nz+t,-nz]) square([w,w]);
        translate([-(10-nz+t),-nz]) square([w,w]);
        translate([-(10-nz-cR),-d+nz+cR]) circle(r=cR,$fn=24);
        translate([(10-nz-cR),-d+nz+cR]) circle(r=cR,$fn=24);
    }
}

module clip()
{
    l1 = (tT+2*nz)*1.41428;
    translate([tG/2+tT-nz*1.41428,0]) rotate([0,0,45]) translate([0,-nz*1.41428]) square([w,l1]);
    translate([tG/2-2.41428*nz,(tT+nz)]) rotate([0,0,15])square([lC,w]);
}