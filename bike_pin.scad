bike_pin(10,5,10,1);

module bike_pin(height, iD, oD, thickness){
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
        }
        
        translate([-thickness/2,0,0])
        cube([thickness,oD/2,height]);
    }
}