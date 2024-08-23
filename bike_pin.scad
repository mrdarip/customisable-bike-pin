$fn=100;
bike_pin(10,5,10,1,6);

module bike_pin(height, iD, oD, thickness, pins){
    difference(){
        union(){
            difference(){
                cylinder(h = height, d=oD);
                cylinder(h = height, d=oD-thickness);
            }
            
            difference(){
                cylinder(h = height, d=iD);
                cylinder(h = height, d=iD-thickness);
            }

            for (i=[0:pins-1]){
                rotate([0,0,i*360/pins+90])
                translate([-thickness/2,iD/2,0])
                cube([thickness,oD-iD,height]);
            }
        }
        
        translate([-thickness/2,0,0])
        cube([thickness,oD/2,height]);
    }
}