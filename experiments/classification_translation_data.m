%% World
numSteps = 100; timestep = 0.01;
initWorld(numSteps,timestep);


%% Sensor
sensor = initRectangularSensor(64,64,.002,0,.02);
addSensor(sensor);

minT = -20; %millimeters
maxT = 20;  %millimeters
stepSizeT = 3;
for translationX = minT:stepSizeT:maxT
    for translationY = minT:stepSizeT:maxT

        meshNames = {'banana','block','cup','drill','largeclamp','medclamp',...
            'mustard','pear','scissors','sphere'};
        for mesh_iter = 5%1:length(meshNames)

            clearObjects;
            filename = strcat(meshNames{mesh_iter},'_translationx',...
                num2str(translationX),'translationy',num2str(translationY),'_classification');
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
            posObj = getObjPosition(object);
            object = setObjPosition(object,posObj+...
                [translationX/1000;translationY/1000;0]);
            object = setObjVelocity(object,[0,0,-.01]);
            addObject(object);

            %start experiment
            setRecordOn(filename);
            data = simStart(true);

            %save data
            save(strcat('data/classification_data/translation/',filename,'.mat'),'data');
        end
    end
end
