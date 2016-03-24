function scissors = defaultScissors()

scissors = initPLYMeshObject('scissors.ply');
scissors = centerObj(scissors);
% scissors = setObjPosition(scissors, [-.07;0;0.0401]);
scissors = setObjPosition(scissors, [0;0;0.0399]);
scissors = setObjOrientation(scissors, kth2R([0,1,0],pi/2));
scissors = setObjMass(scissors, 0.082);
end