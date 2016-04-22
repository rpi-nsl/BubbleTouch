%% World
numSteps = 35; timestep = 0.01;
initWorld(numSteps,timestep);


%% Sensor
sensor = initRectangularSensor(64,64,.002,0,.02);
addSensor(sensor);

sport = {'squash','table_tennis','golf','racquetball','pool',...
    'lacrosse','tennis','cricket','field_hockey','baseball','croquet','softball',...
    'bocce','shot_put','team_handball','volleyball','bowling',...
    'soccer','water_polo','netball','basketball'};
diameter = [0.0395, 0.040, 0.04267, 0.057, 0.05715,...
    0.0635, 0.06541, 0.0713, 0.0713, 0.073, 0.092, 0.0971,...
    0.107, 0.110, 0.185, 0.207, 0.2159,...
    0.216, 0.2165, 0.226, 0.2388];
mass = [0.023, 0.0027, 0.04593, 0.040, 0.156,...
    0.142, 0.056, 0.1559, 0.156, 0.142, 0.4536, 0.178,...
    0.920, 7.260, 0.425, 0.260, 7.260,...
    0.420, 0.400, 0.397, 0.6237];
numSteps = [20,35,15,15,10,...
    10,10,10,15,15,20,10,...
    10,15,10,10,15,...
    10,10,10,15];
timestep = [0.01,0.015,0.01,0.01,0.01,...
    0.01,0.01,0.01,0.005,0.005,0.0025,0.005,...
    0.0025,0.0025,0.002,0.0025,0.0005,...
    0.002,0.002,0.002,0.001];
    

minT = 0; %millimeters
maxT = 1;  %millimeters
stepSizeT = 1;
for translationX = minT:stepSizeT:maxT
    for translationY = minT:stepSizeT:maxT


        for ball_iter = 1:length(sport)
%             display(sport{ball_iter});

            clearWorld;
            initWorld(numSteps(ball_iter),timestep(ball_iter));
            addSensor(sensor);


            filename = strcat(sport{ball_iter},'_translationx',...
                num2str(translationX),'translationy',num2str(translationY),'_saturated_classification');
            ball = initSphereObject(diameter(ball_iter)/2);
            ball = setObjPosition(ball,[0;0;diameter(ball_iter)/2+0.025]);
            ball = setObjMass(ball,mass(ball_iter));
            ball = setObjInertiaTensor(ball,mass(ball_iter)*eye(3)*diameter(ball_iter)^2/4*2/5);
            addObject(ball);

            %start experiment
    %         setRecordOn(filename);
            data = simStart(false);

            %save data
            label = sport{ball_iter};
            label_num = ball_iter;
            save(strcat('data/classification_data/sport_balls/',filename,'.mat'),'data','label','label_num');
        end
    end
end
