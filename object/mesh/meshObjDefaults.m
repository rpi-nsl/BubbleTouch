% %list of default positions and orientations for mesh objects
% 
% %drill
% drill = initPLYMeshObject('drill.ply');
% drill = setObjPosition(drill,[-.1;-.02;.04]);
% drill = setObjOrientation(drill,kth2R([0,1,0],pi/2)*kth2R([0,0,1],pi/4+pi/16));
% drill = setObjMass(drill,.858);
% 
% %banana
% banana = initPLYMeshObject('banana.ply');
% banana = setObjPosition(banana,[-.02;0;0]);
% banana = setObjOrientation(banana,kth2R([0,1,0],pi));
% banana = setObjMass(banana,0.072);
% 
% %block3holes
% block3holes = initPLYMeshObject('block3holes.ply');
% block3holes = setObjPosition(block3holes,[-.005;.01;0]);
% block3holes = setObjOrientation(block3holes,kth2R([0,0,1],-pi/8)*kth2R([0,1,0],pi));
% block3holes = setObjMass(block3holes, 0.032);
% 
% %cup
% cup = initPLYMeshObject('cup.ply');
% cup = setObjPosition(cup,[0.015;-0.01;0]);
% cup = setObjOrientation(cup,kth2R([0,1,0],pi));
% cup = setObjMass(cup, 0.038);
%
% %fruitbox
% fruitbox = initPLYMeshObject('fruitbox.ply');
% fruitbox = setObjPosition(fruitbox,[-.025;.125;0]);
% fruitbox = setObjOrientation(fruitbox,kth2R([1,0,0],pi/2));
% 
% %largeclamp
% largeclamp = initPLYMeshObject('largeclamp.ply');
% largeclamp = setObjPosition(largeclamp,[-.1;-.01;0]);
% largeclamp = setObjOrientation(largeclamp,kth2R([0,1,0],pi/2));
% largeclamp = setObjMass(largeclamp, 0.162);
%
% %medclamp
% medclamp = initPLYMeshObject('medclamp.ply');
% medclamp = setObjPosition(medclamp,[-.06;-.01;0]);
% medclamp = setObjOrientation(medclamp,kth2R([0,1,0],pi/2));
% medclamp = setObjMass(medclamp, 0.114);
%
% %mustard
% mustard = initPLYMeshObject('mustard.ply');
% mustard = setObjPosition(mustard,[-.08;.005;0]);
% mustard = setObjOrientation(mustard, kth2R([0,1,0],pi/2)*kth2R([0,0,1],pi/6));
% mustard = setObjMass(mustard,0.614) 
%
% %pear
% pear = initPLYMeshObject('pear.ply');
% pear = setObjPosition(pear, [-.05;0;0]);
% pear = setObjOrientation(pear, kth2R([0,1,0],pi/2));
% pear = setObjMass(pear, 0.042);
%
% %scissors
% scissors = initPLYMeshObject('scissors.ply');
% scissors = setObjPosition(scissors, [-.07;0;0]);
% scissors = setObjOrientation(scissors, kth2R([0,1,0],pi/2));
% scissors = setObjMass(scissors, 0.082);