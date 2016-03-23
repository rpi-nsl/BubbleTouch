function scissors = defaultScissors()

scissors = initPLYMeshObject('scissors.ply');
scissors = setObjPosition(scissors, [-.07;0;0.0401]);
scissors = setObjOrientation(scissors, kth2R([0,1,0],pi/2));
scissors = setObjMass(scissors, 0.082);
end