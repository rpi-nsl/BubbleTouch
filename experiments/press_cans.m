%% World
numSteps = 200; timestep = 0.01; sampleRate = 0.01;
initWorld(numSteps,timestep,sampleRate);
setWorldGraphicsResolution(5);


resolution_radius = 0.005;

can_names = {'202x204', '211x109',...
        '300x109', '301x106', '303x406',...
        '307x113',...
        '401x411', '404x307', '603x405'};
        
diameters = 0.001*[ 54.0, 68.3,...
                   76.2,  77.8,  81.0,...
                   87.3,  ...
                   103.2, 108.0, 157.2];
                   
can_heights   = 0.001*[ 57.2,  39.7,...
                   39.7,  34.9, 111.1,...
                   46.0,...
                  119.1,  87.3, 109.5];

heights = 2*resolution_radius*ones(size(diameters));
                   
density = 1000;

rotationMatrix = kth2R([0;1;0],pi/2);

    

minT = 0; %millimeters
maxT = 10;  %millimeters
stepSizeT = 1;
for translationX = 2:stepSizeT:maxT
    for translationY = minT:stepSizeT:maxT

        for can_iter = 1:length(diameters)
%             display(sport{ball_iter});

            clearWorld;
            initWorld(numSteps,timestep,sampleRate);


            filename = strcat(can_names{can_iter},'upright_translationx',...
                num2str(translationX),'translationy',num2str(translationY),'_classification');
            can = initSmartCylinderObject(diameters(can_iter)/2,can_heights(can_iter),resolution_radius);
            RObj = getObjOrientation(can);
            can = setObjOrientation(can,rotationMatrix*RObj);
            can = setObjPosition(can,[0.001*translationX;0.001*translationY;can_heights(can_iter)/2+0.022]);
            can = setObjMass(can,density*can_heights(can_iter)*diameters(can_iter)^2/4*pi);
            can = setObjectStatic(can);
            addObject(can);
            
            %Robot
            objShape = can.orientation*(can.shape(:,1:3))';
            maxObjHeight = max(objShape(3,:)+can.shape(:,4)')+can.position(3);
            robot = initPlaneRobot(64,64,.002,0,.02);
            robot = setRobotPosition(robot,[0;0;maxObjHeight+.022]);
            robot = setRobotOrientation(robot,kth2R([1;0;0],pi));
            times = [0];
            velocities = [0,0,-.01];
            robot = addRobotPlan(robot,times,velocities);
            addRobot(robot);

            %start experiment
    %         setRecordOn(filename);
            data = simStart(false);

            %save data
            name = can_names{can_iter};
            label_num = can_iter;
            height = can_heights(can_iter);
            save(strcat('data/classification_data/press/cans/',filename,'.mat'),'data','label_num','name','height');
        end
    end   
end
