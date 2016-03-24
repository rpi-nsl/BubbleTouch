%% World
numSteps = 1; timestep = 0.01;
initWorld(numSteps,timestep);


%% Sensor
sensor = initRectangularSensor(64,64,.002,0,.02);
addSensor(sensor);

for rotationAngle = 0:10:350

    rotationMatrix = kth2R([0;0;1],rotationAngle*pi/180);

    meshNames = {'banana','block','cup','drill','largeclamp','medclamp',...
        'mustard','pear','scissors','sphere'};
    for mesh_iter = 1:length(meshNames)

        clearObjects;
        filename = strcat(meshNames{mesh_iter},'_rotation',...
            num2str(rotationAngle),'_classification');
        switch mesh_iter    
            case 1 %banana
                object = defaultBanana;
            case 2 %Block3Holes
                object = defaultBlock3Holes;
            case 3 %Cup
                object = defaultCup;
            case 4 %Drill
                object = defaultDrill;
            case 5 %Large Clamp
                object = defaultLargeClamp;
            case 6 %Medium Clamp
                object = defaultMedClamp;
            case 7 %Mustard
                object = defaultMustard;
            case 8 %Pear
                object = defaultPear;
            case 9
                object = defaultScissors;
            otherwise %sphere
                object = initSphereObject(.1);
                object = setObjPosition(object, [0;0;0.1221]);
        end
        RObj = getObjOrientation(object);
        object = setObjOrientation(object,rotationMatrix*RObj);
        object = setObjVelocity(object,[0,0,-.01]);
        addObject(object);

        %start experiment
        setRecordOn(filename);
        data = simStart(true);

        %save data
        save(strcat('data/',filename,'.mat'),'data');
    end
end
