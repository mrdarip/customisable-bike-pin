use <src/voxel/vx_gray.scad>

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

    
levels = [
    [0,128,255],
    [128,255,0],
    [255,0,128]
];

    dots = vx_gray(levels, center = true);

    translate([0,0,height/2])
    rotate([0, 0, 180]) 
    
    /*for (dot = dots) {
        rotate([0,0,dot[0][0]*180/len(levels[0])])
        translate([0,oD/2,dot[0][1]/len(levels)*height])
        rotate([0,90,90])
        cylinder(h = dot[1]/255, d=0.5);
    }*/

    roundMeshFromPoints(levels, height, oD/2);
}

a = function (map, j, i) j*360/len(map[i]);
y = function (map, i, height) i * height / len(map);
h = function (map, i, j, height) map[i][j] * height / 255;

module roundMeshFromPoints(levels, height, radius) {
    for (i = [0:len(levels)-1]) {
        for (j = [0:len(levels[i])-1]) {
            if (levels[i][j] == 0) {
                polyhedron(points=
                [
                    [
                        cos(a(levels,i,j)) * radius + h(levels,i,j,height),
                        sin(a(levels,i,j)) * radius + h(levels,i,j,height),
                        y(levels,i,height)
                    ],
                    [
                        cos(a(levels,i,j+1)) * radius + h(levels,i,j+1,height),
                        sin(a(levels,i,j+1)) * radius + h(levels,i,j+1,height),
                        y(levels,i,height)
                    ],
                    [
                        cos(a(levels,i+1,j)) * radius + h(levels,i+1,j,height),
                        sin(a(levels,i+1,j)) * radius + h(levels,i+1,j,height),
                        y(levels,i+1,height)
                    ],
                    [
                        cos(a(levels,i+1,j+1)) * radius + h(levels,i+1,j+1,height),
                        sin(a(levels,i+1,j+1)) * radius + h(levels,i+1,j+1,height),
                        y(levels,i+1,height)
                    ]
                ]
                , faces=[[0,1,2],[1,2,3]]);
            }
        }
    }
}

