// Customizable section



/* [Hidden] */

ikea_peg_depth = 6.39;
ikea_peg_diameter = 4.99;
ikea_peg_radius = ikea_peg_diameter / 2;
ikea_peg_thickness = 2.2;

arc_frags = 200;
ulp = 0.01; // openscad and thingiverse customizer both prefer a safety margin around floating point math boundaries

module ikea_peg(x, y, z) {
    translate([x,y,z]) {
        difference() {
            difference() {
            // main outer shell
            rotate_extrude($fn=arc_frags)
                polygon( points=[
                    [0, ikea_peg_depth],
                    [ikea_peg_radius*0.8, ikea_peg_depth],
                    [ikea_peg_radius, ikea_peg_depth*.85],
                    [ikea_peg_radius, ikea_peg_depth*.75],
                    [ikea_peg_radius*.8, ikea_peg_depth*.6],
                    [ikea_peg_radius, 0],
                    [0, 0]        
                  ]);
                
               //  hollow core
               translate([0, 0, -ulp]) {
                    cylinder(h = ikea_peg_depth+2*ulp, d = ikea_peg_diameter-ikea_peg_thickness, $fn=arc_frags);
               }
            }
            
            // nose cut-out
            translate([0, 0, ikea_peg_depth*.85]) {
                cube(size = [ikea_peg_depth, ikea_peg_radius/2, ikea_peg_depth], center= true);
                translate([0, 0, -ikea_peg_depth/2]) {
                    rotate([90,0,90]) {
                        // Rounding the bottom here distributes the clamping force over multiple 3d print layers;
                        // without it my test print failed in only 2 cycles of use, and with it I have yet to break the part
                        cylinder(h = ikea_peg_radius * 2 + ulp * 2, r = ikea_peg_radius / 4, $fn=arc_frags, center = true);
                    }
                }
            };
        }
    }
}

ikea_peg(0,0,0);
// test base to make it easy to hold while 
//translate([0,0,-1.5]) { cube([9,9,3], center=true); }
