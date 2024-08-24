use <src/voxel/vx_gray.scad>

$fn=4;
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
    [00,10,20,30],
    [40,50,60,70],
    [80,90,100,110],
    [120,130,140,150]
];
    /*dots = vx_gray(levels, center = true);

    translate([0,0,height/2])
    rotate([0, 0, 180]) 
    
    for (dot = dots) {
        rotate([0,0,dot[0][0]*180/len(levels[0])])
        translate([0,oD/2,dot[0][1]/len(levels)*height])
        rotate([0,90,90])
        cylinder(h = dot[1]/255, d=0.5);
    }*/

    roundMeshFromPoints(levels, height, oD/2);
}

a = function (map, j, i) i*90/(len(map[0])+1);
y = function (map, j, height) j * height / (len(map)-1);
function h(map, i, j, height) = 1 + map[j][i] / 255 * 1.03;

module roundMeshFromPoints(levels, height, radius) {
    /*for (i = [0:len(levels)-2]) {
        for (j = [0:len(levels[i])-2]) {
            echo(i, j);

            polyhedron(points=[
            [
                cos(a(levels, j, i)) * h(levels, i, j, height) * radius,
                sin(a(levels, j, i)) * h(levels, i, j, height) * radius,
                y(levels, j, height)
            ],[
                cos(a(levels, j+1, i)) * h(levels, i, j+1, height) * radius,
                sin(a(levels, j+1, i)) * h(levels, i, j+1, height) * radius,
                y(levels, j+1, height)
            ],[
                cos(a(levels, j, i+1)) * h(levels, i+1, j, height) * radius,
                sin(a(levels, j, i+1)) * h(levels, i+1, j, height) * radius,
                y(levels, j, height)
            ],[
                cos(a(levels, j+1, i+1)) * h(levels, i+1, j+1, height) * radius,
                sin(a(levels, j+1, i+1)) * h(levels, i+1, j+1, height) * radius,
                y(levels, j+1, height)
            ],
            
            
            
            [
                cos(a(levels, j, i)) * radius,
                sin(a(levels, j, i)) * radius,
                y(levels, j, height)
            ],[
                cos(a(levels, j+1, i)) * radius,
                sin(a(levels, j+1, i)) * radius,
                y(levels, j+1, height)
            ],[
                cos(a(levels, j, i+1)) * radius,
                sin(a(levels, j, i+1)) * radius,
                y(levels, j, height)
            ],[
                cos(a(levels, j+1, i+1)) * radius,
                sin(a(levels, j+1, i+1)) * radius,
                y(levels, j+1, height)
            ]
            ], faces=[
                [0,1,2],
                [1,3,2],
                [1,5,3],
                [5,7,3],
                [5,4,7],
                [4,6,7],
                [4,0,6],
                [0,2,6],
                [2,3,6],
                [3,7,6],
                [4,5,0],
                [5,1,0]
                ]
            );
        }
    }*/
    echo(
        [
            for (i = [0:len(levels)-2]) 
                for (j = [0:len(levels[i])-2]) 
                [
                    j + i * len(levels[0]),
                    j+1 + i * len(levels[0]),
                    j+len(levels[0])+1 + i * len(levels[0]),
                    j+len(levels[0]) + i * len(levels[0])
                ]
        ]
    );
    polyhedron(points=[
            for (i = [0:len(levels)-1]) 
                for (j = [0:len(levels[i])-1]) [
                    cos(a(levels, j, i)) * h(levels, i, j, height) * radius,
                    sin(a(levels, j, i)) * h(levels, i, j, height) * radius,
                    y(levels, j, height)
                ]
        ], faces=[
            for (i = [0:len(levels)-2]) 
                for (j = [0:len(levels[i])-2]) 
                [
                    j                      + i * len(levels[0]),
                    j                  + 1 + i * len(levels[0]),
                    j + len(levels[0]) + 1 + i * len(levels[0]),
                    j + len(levels[0])     + i * len(levels[0])
                ]
        ]);
}

