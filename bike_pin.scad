$fn=100;
bike_pin(10,5,10,1,6);

module bike_pin(height, iD, oD, thickness, pins){
    difference(){
        union(){
            //inner clip
            difference(){
                cylinder(h = height, d=oD);
                cylinder(h = height, d=oD-thickness*2);
            }
            
            //outer clip
            difference(){
                cylinder(h = height, d=iD+thickness*2);
                cylinder(h = height, d=iD);
            }

            //bridges
            for (i=[0:pins-1]){
                rotate([0,0,i*360/pins+90])
                translate([-thickness/2,iD/2,0])
                cube([thickness,oD-iD,height]);
            }
        }
        
        //insertion hole
        translate([-thickness/2,0,0])
        cube([thickness,oD/2,height]);
    }
}