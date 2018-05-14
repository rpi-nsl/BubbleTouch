%% World
tic
% numSteps = 2; timestep = 1; sampleRate = 1;
numSteps = 50000; timestep = .001; sampleRate = .001;
initWorld(numSteps,timestep,sampleRate);
setWorldGraphicsResolution(5);

% object_list = {'banana','cup','drill','clamp_lg','mustard_up','mustard_side','cheezit','straw_jello','c
% object_list = {'cracker_box','sugar_box','tomato_soup_can','mustard_bottle','tuna_fish_can','pudding_box','gelatin_box','potted_meat_can','banana','strawberry','apple','lemon','peach','pear','orange','plum','pitcher_base','bleach_cleanser','bowl','mug','sponge','skillet','plate','fork','spoon','knife','spatula','power_drill','wood_block','scissors','padlock','large_marker','adjustable_wrench','phillips_screwdriver','flat_screwdriver','hammer','medium_clamp','51_large_clamp','extra_large_clamp','mini_soccer_ball','softball','baseball','tennis_ball','racquetball','golf_ball','foam_brick','dice','rubiks_cube'};
object_list = {'cracker_box','sugar_box','tomato_soup_can','mustard_bottle',...
    'tuna_fish_can','pudding_box','gelatin_box','potted_meat_can','banana',...
    'strawberry','apple','lemon','peach','pear','orange','plum','pitcher_base',...
    'bleach_cleanser','bowl','mug','sponge','plate','spatula','power_drill',...
    'wood_block','scissors','large_marker','adjustable_wrench',...
    'phillips_screwdriver','flat_screwdriver','hammer','medium_clamp',...
    '51_large_clamp','extra_large_clamp','mini_soccer_ball','softball',...
    'baseball','tennis_ball','racquetball','golf_ball','foam_brick','dice','rubiks_cube'};
% object_list = {'phillips_screwdriver','flat_screwdriver'};

obj_id = [9 7 8 12 14 15 20 21 22 23 26 28 29 30 32 35 36 37 39 40 41 43];

% resolution_radius = 0.003;

minT = 02; %millimeters
maxT = 10;  %millimeters
minAngle =  0; %degrees
maxAngle = 50; %degrees
stepSizeT = 2;
stepSizeA = 10;

xy = [0 2 0 4 2 0 6 4 2 0 2 6 4 6 6   4 8 0 10 8 2  0 10 8 4  2 10 8 6  4 10 8  6 10  8 10;
      0 0 2 0 2 4 0 2 4 6 6 2 6 4 6   4 0 8  0 2 8 10  2 4 8 10  4 6 8 10  6 8 10  8 10 10];
%     for translationX = minT:stepSizeT:maxT
%         for translationY = minT:stepSizeT:maxT
for xi = 1%29:36%:size(xy,2)
    translationX = xy(1,xi);
    translationY = xy(2,xi);
            for object_id = obj_id;%randperm(43)%length(object_list):-1:1
            for rotationAngle = minAngle%:stepSizeA:maxAngle
                for xAngle = 0%:5:5
                    for yAngle = 0%:5:5
%         rotationAngle = 0;
                        rotationMatrix = kth2R([0;0;1],rotationAngle*pi/180);
            
% tic

%             for comb_iter = 1:length(num_teeth)


                        clearWorld;
                        initWorld(numSteps,timestep,sampleRate);
                        setWorldGraphicsResolution(5);
                
                        filename = strcat(object_list{object_id},'_trajectory');
%                             '_upright_translationx',...
%                             num2str(translationX),'translationy',num2str(translationY),...
%                             'rotation',num2str(rotationAngle),'_planex',num2str(xAngle),...
%                             '_planey',num2str(yAngle),'_classification');
                        object = defaultYCB(object_list{object_id});
%                 switch object_id    
%                     case 1 %banana
%                         object = defaultBanana;
%                         object = setObjOrientation(object,kth2R([0,1,0],pi)*getObjOrientation(object));
%                     case 2 %Cup
%                         object = defaultCup;
%                         object = setObjOrientation(object,kth2R([0,1,0],pi)*getObjOrientation(object));
%                     case 3 %Drill
%                         object = defaultDrill;
%                         object = setObjOrientation(object,kth2R([0,1,0],pi)*getObjOrientation(object));
%                     case 4 %Large Clamp
%                         object = defaultLargeClamp;
%                         object = setObjOrientation(object,kth2R([0,1,0],pi)*getObjOrientation(object));
%                     case 5 %Mustard top
%                         object = defaultMustard;
%                         object = setObjOrientation(object,kth2R([0,1,0],pi)*getObjOrientation(object));
%                     case 6 %Mustard side
%                         object = defaultMustard;
%                         object = setObjOrientation(object,kth2R([0,1,0],pi)*getObjOrientation(object));
%                         object = setObjOrientation(object,kth2R([0,1,0],pi/2)*getObjOrientation(object));
%                     case 7 %cheezit
%                          object = initBoxObject(.158,.060,2*resolution_radius,resolution_radius);
%                     case 8 %cereal_thin 
%                          object = initBoxObject(.197,.051,2*resolution_radius,resolution_radius);
%                     case 9 %straw_jello
%                          object = initBoxObject(.085,.050,2*resolution_radius,resolution_radius);
%                     case 10 %zone_bars
%                          object = initBoxObject(.141,.100,2*resolution_radius,resolution_radius);
%                     otherwise %sphere
%                         continue
%                 end
                        RObj = getObjOrientation(object);
                        object = setObjOrientation(object,rotationMatrix*RObj);
                        object = setObjPosition(object,getObjPosition(object)+[0.001*translationX;0.001*translationY;0]);
%                 object = setObjMass(object,masses(comb_iter));
                        object = setObjectStatic(object);
%                 box = convertToGPUObject(box);
%                         addObject(object);
                        
                
                        %% Robot
                        objShape = object.orientation*(object.shape(:,1:3))';
                        
                        robotRot = kth2R([1;0;0],xAngle*pi/180)*kth2R([0;1;0],yAngle*pi/180);
                        [~,mind] = max((robotRot*[0;0;1])'*objShape);
                        
%                         maxObjHeight = max(objShape(3,:)+object.shape(:,4)')+object.position(3);
                        maxObjHeight = objShape(3,mind)+object.shape(mind,4)+object.position(3);
                        
%                         robotRot = kth2R([1;0;0],xAngle*pi/180)*kth2R([0;1;0],yAngle*pi/180);
                        
                        robot = initPlaneRobot(64,64,.001,0,.005);
                        robot = setRobotPosition(robot,[0;0;maxObjHeight+.006]);
                        robot = setRobotOrientation(robot,robotRot*kth2R([1;0;0],pi));
%                         times = [0];
%                         velocities = (robotRot*[0;0;-.2])';
                        times = [0;1;6;16;21;26;36;41];
                        velocities = [0,0,-.005,0,0,0;
                              0,0,-.001,1*pi/180,0,0;
                              0,0,-.001,-1*pi/180,0,0;
                              0,0,-.001,1*pi/180,0,0;
                              0,0,-.001,0,1*pi/180,0;
                              0,0,-.001,0,-1*pi/180,0;
                              0,0,-.001,0,1*pi/180,0;
                              0,0,-.001,0,0,-1*pi/180];
%                         times = [0;1;10;28];
%                         velocities = [0,0,-.005,0,0,0;
%                               0,0,-.001,0,0,5*pi/180;
%                               0,-.003,-.001,0,0,5*pi/180;
%                               0,0,-.001,1*pi/180,0,0];
                        robot = addRobotPlan(robot,times,velocities);
%                 robot = convertToGPURobot(robot);
                        addRobot(robot);

                        %%Add floor (not working)
%                         [~,mind] = min((robotRot*[0;0;1])'*objShape);
%                         floor_radius = 1;
%                         object.shape = [object.shape;
%                                 0,0,objShape(3,mind)-object.shape(mind,4)-floor_radius,floor_radius];
                        addObject(object);

                %start experiment
%                 setRecordOn(filename);
                        data = simStart(false);
                        disp(max(max(data)))
                
%                 waitmousebutton();

                %save data
                        disp(filename);
                        name = object_list{object_id};
                        label_num = object_id;
                        save(['/local/backup/bubbletouch_data/data/trajectory/',filename,'.mat'],'data','label_num','name');
                    end
                end
            end
            
%             toc
        end
    end   
% end
toc
