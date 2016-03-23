function banana = defaultBanana()

banana = initPLYMeshObject('banana.ply');
banana = setObjPosition(banana,[-.02;0;.065]);
banana = setObjOrientation(banana,kth2R([0,1,0],pi));
banana = setObjMass(banana,0.072);
end