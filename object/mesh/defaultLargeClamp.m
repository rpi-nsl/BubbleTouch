function largeclamp = defaultLargeClamp()

largeclamp = initPLYMeshObject('largeclamp.ply');
largeclamp = setObjPosition(largeclamp,[-.1;-.01;0.056]);
largeclamp = setObjOrientation(largeclamp,kth2R([0,1,0],pi/2));
largeclamp = setObjMass(largeclamp, 0.162);
end