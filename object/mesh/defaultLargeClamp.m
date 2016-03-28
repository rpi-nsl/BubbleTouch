function largeclamp = defaultLargeClamp()

largeclamp = initPLYMeshObject('largeclamp.ply');
largeclamp = centerObj(largeclamp);
% largeclamp = setObjPosition(largeclamp,[-.1;-.01;0.056]);
largeclamp = setObjPosition(largeclamp,[0;0;0.0451]);
largeclamp = setObjOrientation(largeclamp,kth2R([0,1,0],pi/2));
largeclamp = setObjMass(largeclamp, 0.162);
end