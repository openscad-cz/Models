/*
https://www.thingiverse.com/thing:4133885
remixed from
https://www.thingiverse.com/thing:1341482
*/

/* [Box Sections] */
//Amount of sections in the length
sectionsl=1;
//Amount of sections in the width
sectionsw=6;
//Size of single section in the width
sectionw=18;
//Size of single section in the length
sectionl=176;
//Section height
sectionsh=12;

/* [Box] */
//Inner walls thickness
inwalls=0.8;
//Radius for corners (minimum 2)
cornerrad=4;
//Wall thickness
outwalls=1.2;
//Box thickness for floor
thickness=1.2;

//Box height
height=14;
//Box length, based on section count, dimensions etc.
length=(sectionsl*sectionl)+(2*outwalls)+((sectionsl-1)*inwalls);
//Box width, , based on section count, dimensions etc.
width=(sectionsw*sectionw)+(2*outwalls)+((sectionsw-1)*inwalls);

/* [Lid] */
//Tolerance for lid
tol=0.1; 
//Lid thickness for top
lidthickness=1.2;
//Lid height
lidheight=10;

l=length-(cornerrad*2);
w=width-(cornerrad*2);

/* [Text] */
// Text on lid (leave empty for none)
yourText="Your Text";
textFont="Times New Roman:style=Regular"; 
textSize=18;
//rotate text by 90 degrees to fit more
rotationAngle = 0;
textDepth=thickness/3;


module boxWithLid(){
translate([cornerrad, cornerrad, 0]){
    union(){
        difference() {


            hull() {
                h = (height/2);
                translate([0,0,h]) cylinder(h=height, r=cornerrad, $fn=80, center = true);
                translate([0,l,h]) cylinder(h=height, r=cornerrad, $fn=80, center = true);
                translate([w,l,h]) cylinder(h=height, r=cornerrad, $fn=80, center = true);
                translate([w,0,h]) cylinder(h=height, r=cornerrad, $fn=80, center = true);
            }
            hull() {
                h = (height/2) + thickness;
                translate([0,0,h]) cylinder(h=height, r=cornerrad-outwalls, $fn=80, center = true);
                translate([0,l,h]) cylinder(h=height, r=cornerrad-outwalls, $fn=80, center = true);
                translate([w,l,h]) cylinder(h=height, r=cornerrad-outwalls, $fn=80, center = true);
                translate([w,0,h]) cylinder(h=height, r=cornerrad-outwalls, $fn=80, center = true);
            }
        }
        
        if( sectionsl > 0 ){
            cutl = ((length) - (outwalls*2))/sectionsl;
            for(i = [cutl : cutl : length-cutl]) {
                translate([w/2,i+outwalls-cornerrad,sectionsh/2]) cube([width,inwalls,sectionsh], center=true);
            }
        }
        
        if( sectionsw > 0 ){
            cutw = ((width) - (outwalls*2))/sectionsw;
            for(i = [cutw : cutw : width-cutw]) {
                translate([i+outwalls-cornerrad,l/2,sectionsh/2]) cube([inwalls,length,sectionsh], center=true);
            }
        }
        
    }
    
  

    translate([w + (cornerrad*2) + 6, outwalls, 0]){
        difference() {
            hull() {
                h = (lidheight/2);
                translate([0,0,h]) cylinder(h=lidheight, r=cornerrad+tol+outwalls, $fn=80, center = true);
                translate([0,l,h]) cylinder(h=lidheight, r=cornerrad+tol+outwalls, $fn=80, center = true);
                translate([w,l,h]) cylinder(h=lidheight, r=cornerrad+tol+outwalls, $fn=80, center = true);
                translate([w,0,h]) cylinder(h=lidheight, r=cornerrad+tol+outwalls, $fn=80, center = true);
            }           
            hull() {
                h = (lidheight/2) + lidthickness;
                translate([0,0,h]) cylinder(h=lidheight, r=(cornerrad)+tol, $fn=80, center = true);
                translate([0,l,h]) cylinder(h=lidheight, r=(cornerrad)+tol, $fn=80, center = true);
                translate([w,l,h]) cylinder(h=lidheight, r=(cornerrad)+tol, $fn=80, center = true);
                translate([w,0,h]) cylinder(h=lidheight, r=(cornerrad)+tol, $fn=80, center = true);
                
        }
    }}
}
}

module yourText(){

translate([width*1.5+2*cornerrad,length/2,0])
mirror([1,0,0])
linear_extrude(height = textDepth)
{
    rotate([0,0,rotationAngle])
    text(yourText, valign="center", halign="center", font=textFont, size=textSize);
}
}
difference() {
boxWithLid();
yourText();
     }