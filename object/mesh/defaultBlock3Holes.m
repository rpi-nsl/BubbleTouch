function block3holes = defaultBlock3Holes()

block3holes = initPLYMeshObject('block3holes.ply');
block3holes = centerObj(block3holes);
% block3holes = setObjPosition(block3holes,[-.005;.01;0.079]);
block3holes = setObjPosition(block3holes,[0;0;0.0469]);
block3holes = setObjOrientation(block3holes,kth2R([0,0,1],-pi/8)*kth2R([0,1,0],pi));
block3holes = setObjMass(block3holes, 0.032);
end
