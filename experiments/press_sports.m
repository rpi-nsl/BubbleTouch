%% World
numSteps = 200; timestep = 0.01;
initWorld(numSteps,timestep);

%objects
sport = {'squash','golf','racquetball',...
    'lacrosse','tennis','cricket','baseball','croquet','softball',...
    'bocce','shot_put','team_handball','volleyball',...
    'soccer','netball','basketball'};
diameter = [0.0395, 0.04267, 0.057,...
    0.0635, 0.06541, 0.0713, 0.073, 0.092, 0.0971,...
    0.107, 0.110, 0.185, 0.207,...
    0.216, 0.226, 0.2388];
mass = [0.023, 0.04593, 0.040,...
    0.142, 0.056, 0.1559, 0.142, 0.4536, 0.178,...
    0.920, 7.260, 0.425, 0.260,...
    0.420, 0.397, 0.6237];
   

minT = 0; %millimeters
maxT = 10;  %millimeters
stepSizeT = 1;
for translationX = minT:stepSizeT:maxT
    for translationY = minT:stepSizeT:maxT
        for ball_iter = 1:length(sport)
%             display(sport{ball_iter});

            clearWorld;
            initWorld(200,0.01);

            filename = strcat(sport{ball_iter},'_translationx',...
                num2str(translationX),'translationy',num2str(translationY),'_planex0_planey0_classification');
            ball = initSphereObject(diameter(ball_iter)/2);
            ball = setObjPosition(ball,[translationX*.001;translationY*.001;diameter(ball_iter)/2+0.025]);
            ball = setObjMass(ball,mass(ball_iter));
            ball = setObjInertiaTensor(ball,mass(ball_iter)*eye(3)*diameter(ball_iter)^2/4*2/5);
            ball = setObjectStatic(ball);
            addObject(ball);
            
            %% Robot
            objShape = ball.orientation*(ball.shape(:,1:3))';
            maxObjHeight = max(objShape(3,:)+ball.shape(:,4)')+ball.position(3);
            robot = initPlaneRobot(64,64,.002,0,.02);
            robot = setRobotPosition(robot,[0;0;maxObjHeight+.022]);
            robot = setRobotOrientation(robot,kth2R([1;0;0],pi));
            times = [0];
            velocities = [0,0,-.01];
            robot = addRobotPlan(robot,times,velocities);
            addRobot(robot);

            %start experiment
    %         setRecordOn(filename);git 
            data = simStart(false);


            %save data
            label = sport{ball_iter};
            label_num = ball_iter;
            save(strcat('data/classification_data/press/sports/',filename,'.mat'),'data','label','label_num');
        end
    end
end
