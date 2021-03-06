function medclamp = defaultMedClamp()

medclamp = initPLYMeshObject('medclamp.ply');
medclamp = centerObj(medclamp);
% medclamp = setObjPosition(medclamp,[-.06;-.01;0.0365]);
medclamp = setObjPosition(medclamp,[0;0;0.0411]);
medclamp = setObjOrientation(medclamp,kth2R([0,1,0],pi/2));
medclamp = setObjMass(medclamp, 0.114);
end