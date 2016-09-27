%% World
numSteps = 100; timestep = 0.01; sampleRate = 0.01;
initWorld(numSteps,timestep,sampleRate);
setWorldGraphicsResolution(5);

object_list = {'banana','cup','drill','clamp_lg','mustard_up','mustard_side','cheezit','straw_jello','cereal_thin','zone_bars'};


resolution_radius = 0.003;

minT = 00; %millimeters
maxT = 00;  %millimeters
minAngle =  0; %degrees
maxAngle = 0; %degrees
stepSizeT = 2;
stepSizeA = 10;
for object_id = 1:length(object_list)
    for translationX = minT:stepSizeT:maxT
        for translationY = minT:stepSizeT:maxT
            for rotationAngle = minAngle:stepSizeA:maxAngle
%         rotationAngle = 0;
                rotationMatrix = kth2R([0;0;1],rotationAngle*pi/180);
            
% tic

%             for comb_iter = 1:length(num_teeth)


                clearWorld;
                initWorld(numSteps,timestep,sampleRate);
                setWorldGraphicsResolution(5);
                
                filename = strcat(object_list{object_id},'_upright_translationx',...
                    num2str(translationX),'translationy',num2str(translationY),...
                    'rotation',num2str(rotationAngle),'_planex0_planey0_classification');
                switch object_id    
                    case 1 %banana
                        object = defaultBanana;
                        object = setObjOrientation(object,kth2R([0,1,0],pi)*getObjOrientation(object));
                    case 2 %Cup
                        object = defaultCup;
                        object = setObjOrientation(object,kth2R([0,1,0],pi)*getObjOrientation(object));
                    case 3 %Drill
                        object = defaultDrill;
                        object = setObjOrientation(object,kth2R([0,1,0],pi)*getObjOrientation(object));
                    case 4 %Large Clamp
                        object = defaultLargeClamp;
                        object = setObjOrientation(object,kth2R([0,1,0],pi)*getObjOrientation(object));
                    case 5 %Mustard top
                        object = defaultMustard;
                        object = setObjOrientation(object,kth2R([0,1,0],pi)*getObjOrientation(object));
                    case 6 %Mustard side
                        object = defaultMustard;
                        object = setObjOrientation(object,kth2R([0,1,0],pi)*getObjOrientation(object));
                        object = setObjOrientation(object,kth2R([0,1,0],pi/2)*getObjOrientation(object));
                    case 7 %cheezit
                         object = initBoxObject(.158,.060,2*resolution_radius,resolution_radius);
                    case 8 %cereal_thin 
                         object = initBoxObject(.197,.051,2*resolution_radius,resolution_radius);
                    case 9 %straw_jello
                         object = initBoxObject(.085,.050,2*resolution_radius,resolution_radius);
                    case 10 %zone_bars
                         object = initBoxObject(.141,.100,2*resolution_radius,resolution_radius);
                    otherwise %sphere
                        continue
                end
                RObj = getObjOrientation(object);
                object = setObjOrientation(object,rotationMatrix*RObj);
                object = setObjPosition(object,[0.001*translationX;0.001*translationY;0.027]);
%                 object = setObjMass(object,masses(comb_iter));
                object = setObjectStatic(object);
%                 box = convertToGPUObject(box);
                addObject(object);
                
                %% Robot
                objShape = object.orientation*(object.shape(:,1:3))';
                maxObjHeight = max(objShape(3,:)+object.shape(:,4)')+object.position(3);
                robot = initPlaneRobot(64,64,.002,0,.02);
                robot = setRobotPosition(robot,[0;0;maxObjHeight+.022]);
                robot = setRobotOrientation(robot,kth2R([1;0;0],pi));
                times = [0];
                velocities = [0,0,-.01];
                robot = addRobotPlan(robot,times,velocities);
%                 robot = convertToGPURobot(robot);
                addRobot(robot);

                %start experiment
                setRecordOn(filename);
                data = simStart(true);
                
%                 waitmousebutton();

                %save data
                name = object_list{object_id};
                label_num = object_id;
%                 save(strcat('data/ICRA_more/',filename,'.mat'),'data','label_num','name');
            end
            
%             toc
        end
    end   
end
