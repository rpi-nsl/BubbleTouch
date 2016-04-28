%% World
numSteps = 25; timestep = 0.001; sampleRate = 0.001;
initWorld(numSteps,timestep,sampleRate);
setWorldGraphicsResolution(5);


%% Sensor
sensor = initRectangularSensor(64,64,.002,0,.02);
addSensor(sensor);

resolution_radius = 0.005;

can_names = {'202x204', '202x214', '211x109', '211x212', '211x304', '211x400',...
        '300x109', '300x400', '300x407', '301x106', '301x408', '303x406',...
        '307x113', '307x200', '307x306', '307x400', '307x409', '307x510',...
        '307x512', '401x411', '404x307', '404x700', '603x405', '603x408',...
        '303x509', '603x700', '603x812'};
        
diameters = 0.001*[ 54.0,  54.0,  68.3,  68.3,  68.3,  68.3,...
                   76.2,  76.2,  76.2,  77.8,  77.8,  81.0,...
                   87.3,  87.2,  87.3,  87.3,  87.3,  87.3,...
                   87.3, 103.2, 108.0, 108.0, 157.2, 157.2,...
                   81.0, 157.2, 157.2];
                   
can_heights   = 0.001*[ 57.2,  73.0,  39.7,  69.9,  82.6, 101.6,...
                   39.7, 101.6, 112.7,  34.9, 114.3, 111.1,...
                   46.0,  51.2,  85.7, 101.6, 115.9, 142.9,...
                  146.1, 119.1,  87.3, 177.8, 109.5, 114.3,...
                  141.3, 177.8, 222.0];

heights = 2*resolution_radius*ones(size(diameters));
                   
density = 1000;

rotationMatrix = kth2R([0;1;0],pi/2);

    

minT = 0; %millimeters
maxT = 20;  %millimeters
stepSizeT = 1;
for translationX = minT:stepSizeT:maxT
    for translationY = minT:stepSizeT:maxT

        for can_iter = 1:length(diameters)
%             display(sport{ball_iter});

            clearWorld;
            initWorld(numSteps,timestep,sampleRate);
            addSensor(sensor);


            filename = strcat(can_names{can_iter},'upright_translationx',...
                num2str(translationX),'translationy',num2str(translationY),'_classification');
            can = initSmartCylinderObject(diameters(can_iter)/2,heights(can_iter),resolution_radius);
            RObj = getObjOrientation(can);
            can = setObjOrientation(can,rotationMatrix*RObj);
            can = setObjPosition(can,[0.001*translationX;0.001*translationY;heights(can_iter)/2+0.022]);
            can = setObjMass(can,density*can_heights(can_iter)*diameters(can_iter)^2/4*pi);
            addObject(can);

            %start experiment
    %         setRecordOn(filename);
            data = simStart(false);

            %save data
            name = can_names{can_iter};
            label_num = can_iter;
            height = can_heights(can_iter);
            save(strcat('data/classification_data/tincans/',filename,'.mat'),'data','label_num','name','height');
        end
    end   
end
