%% World
numSteps = 200; timestep = 0.01; sampleRate = 0.01;
initWorld(numSteps,timestep,sampleRate);
setWorldGraphicsResolution(5);


resolution_radius = 0.003;

box_names = {'cheezit', 'sugar', 'choco_jello', 'straw_jello', 'cereal_thin',...
             'cereal_thick', 'zone_bars', 'tapioca', 'baking_soda', 'corn_meal',...
             'cream_wheat', 'baking_choco', 'micro_popcorn', 'graham_crackers', 'cake_mix',...
             'tea'};
        
lengths = 0.001*[158,  89, 110,  85, 197,...
                 197, 141,  82,  80, 152,...
                 135, 154, 158, 133, 143,...
                 168];
                   
widths  = 0.001*[ 60,  38,  28,  50,  51,...
                  63, 100,  33,  49,  57,...
                  44,  16,  51,  63,  38,...
                  65];
                   
heights = 0.001*[210, 175,  89,  73, 304,...
                 304, 252, 140, 116, 195,...
                 197,  78, 108, 196, 193,...
                 144];
             
sim_heights = 2*resolution_radius*ones(size(heights));
                 
masses  = 0.001*[411, 514, 187,  97, 363,...
                 363,1200, 226, 454,1130,...
                 794, 113, 234, 408, 453,...
                 142];

minT = 0; %millimeters
maxT = 0;  %millimeters
minAngle =  0; %degrees
maxAngle = 0; %degrees
stepSizeT = 1;
for translationX = minT:stepSizeT:maxT
    for translationY = minT:stepSizeT:maxT
        for rotationAngle = 0%minAngle:maxAngle
%         rotationAngle = 0;
            rotationMatrix = kth2R([0;0;1],rotationAngle*pi/180);
            
% tic

            for box_iter = 1:1%length(box_names)


                clearWorld;
                initWorld(numSteps,timestep,sampleRate);
                setWorldGraphicsResolution(5);


                filename = strcat(box_names{box_iter},'upright_translationx',...
                    num2str(translationX),'translationy',num2str(translationY),...
                    'rotation',num2str(rotationAngle),'_planex0_planey0_classification');
                box = initBoxObject(lengths(box_iter),widths(box_iter),heights(box_iter),resolution_radius);
                RObj = getObjOrientation(box);
                box = setObjOrientation(box,rotationMatrix*RObj);
                box = setObjPosition(box,[0.001*translationX;0.001*translationY;heights(box_iter)/2+0.022]);
                box = setObjMass(box,masses(box_iter));
                box = setObjectStatic(box);
%                 box = convertToGPUObject(box);
                addObject(box);
                
                %% Robot
                objShape = box.orientation*(box.shape(:,1:3))';
                maxObjHeight = max(objShape(3,:)+box.shape(:,4)')+box.position(3);
                robot = initPlaneRobot(64,64,.002,0,.02);
                robot = setRobotPosition(robot,[0;0;maxObjHeight+.022]);
                robot = setRobotOrientation(robot,kth2R([1;0;0],pi));
                times = [0];
                velocities = [0,0,-.01];
                robot = addRobotPlan(robot,times,velocities);
%                 robot = convertToGPURobot(robot);
                addRobot(robot);

                %start experiment
        %         setRecordOn(filename);
                data = simStart(false);

                %save data
                name = box_names{box_iter};
                label_num = box_iter;
                height = heights(box_iter);
                save(strcat('data/classification_data/press/boxes/',filename,'.mat'),'data','label_num','name','height');
            end
            
%             toc
        end
    end   
end
