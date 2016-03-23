function drill = defaultDrill()

drill = initPLYMeshObject('drill.ply');
drill = setObjPosition(drill,[-.1;-.02;.0407]);
drill = setObjOrientation(drill,kth2R([0,1,0],pi/2)*kth2R([0,0,1],pi/4+pi/16));
drill = setObjMass(drill,.858);
end