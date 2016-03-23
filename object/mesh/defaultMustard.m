function mustard = defaultMustard()

mustard = initPLYMeshObject('mustard.ply');
mustard = setObjPosition(mustard,[-.08;.005;0.037]);
mustard = setObjOrientation(mustard, kth2R([0,1,0],pi/2)*kth2R([0,0,1],pi/6));
mustard = setObjMass(mustard,0.614);
end