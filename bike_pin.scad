$fn=100;
bike_pin(10,5,10,1,6);

module bike_pin(height, iD, oD, thickness, pins){
    difference(){
        //clip
        difference(){
            cylinder(h = height, d=oD);
            cylinder(h = height, d=iD);
        }
            
        
        //insertion hole
        translate([-thickness/2,0,0])
        cube([thickness,oD/2,height]);
    }
}