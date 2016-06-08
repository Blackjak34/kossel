module extrusion1515(length) {
    color("silver") rotate([90, 0, 0]) difference() {
        // main body
        hull() for(x=[6.5,-6.5],z=[6.5,-6.5]) {
            translate([x, 0, z]) rotate([-90, 0, 0]) cylinder(length,r=1,$fn=30);
        }
        // hole in center
        translate([0, -0.5, 0]) rotate([-90, 0, 0])
            cylinder(length+1, d=2.5, true, $fn=30);
        // slots
        for(r=[0,90,180,270]) rotate([0, r, 0]) translate([0, -0.5, 7.5]) {
            translate([-1.7, 0, -1.15]) cube([3.4,length+1,1.2]);
            translate([-2.85, 0, -3.7]) cube([5.7, length+1, 2.6]);
            translate([-2.85, 0, -3.7]) rotate([-90, 0, 0])
                linear_extrude(height=length+1,center=false)
                polygon([[0,-0.05],[0,0],[1.15,1],[4.55,1],[5.7,0],[5.7,-0.05]]);
            translate([0, 0, -4.7]) rotate([-90, 0, 0])
                linear_extrude(height=length+1,center=false)
                polygon([[0.35*sqrt(3),-0.05],[0,0.3],[-0.35*sqrt(3),-0.05]]);
        }
    }
}

extrusion1515(10);