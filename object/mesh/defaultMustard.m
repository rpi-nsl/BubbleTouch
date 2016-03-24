function mustard = defaultMustard()

mustard = initPLYMeshObject('mustard.ply');
mustard = centerObj(mustard);
% mustard = setObjPosition(mustard,[-.08;.005;0.037]);
mustard = setObjPosition(mustard,[0;0;0.0516]);
mustard = setObjOrientation(mustard, kth2R([0,1,0],pi/2)*kth2R([0,0,1],pi/6));
mustard = setObjMass(mustard,0.614);
end