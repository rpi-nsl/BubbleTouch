function drill = defaultDrill()

drill = initPLYMeshObject('drill.ply');
drill = centerObj(drill);
% drill = setObjPosition(drill,[-.1;-.02;.0407]);
drill = setObjPosition(drill,[0;0;.0532]);
drill = setObjOrientation(drill,kth2R([0,1,0],pi/2)*kth2R([0,0,1],pi/4+pi/16));
drill = setObjMass(drill,.858);
drill = computeObjInertiaTensor(drill);
end