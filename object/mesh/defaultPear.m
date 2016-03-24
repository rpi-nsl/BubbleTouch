function pear = defaultPear()

pear = initPLYMeshObject('pear.ply');
pear = centerObj(pear);
% pear = setObjPosition(pear, [-.05;0;0.0589]);
pear = setObjPosition(pear, [0;0;0.0611]);
pear = setObjOrientation(pear, kth2R([0,1,0],pi/2));
pear = setObjMass(pear, 0.042);
end