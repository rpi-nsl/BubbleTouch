%% World
numSteps = 35; timestep = 0.01;
initWorld(numSteps,timestep);


%% Sensor
sensor = initRectangularSensor(64,64,.002,0,.02);
addSensor(sensor);

diameter = [2.4,3.2,4,5.5,7.1,7.9,9.5,11.9,14.25,17.5]./1000;
density = .0017/(.019*pi*.003*.003);
l = .19;
numSteps = 10*ones(size(diameter));
timestep = [0.02, 0.015, 0.01, 0.01, 0.01, 0.01, 0.005, 0.005, 0.005, 0.005];
    

minT = 2; %millimeters
maxT = 20;  %millimeters
stepSizeT = 1;
for translationX = minT:stepSizeT:maxT
    for translationY = minT:stepSizeT:maxT


        for brush_iter = 1:length(diameter)
%             display(sport{ball_iter});

            clearWorld;
            initWorld(numSteps(brush_iter),timestep(brush_iter));
            addSensor(sensor);


            filename = strcat('paintbrush',num2str(diameter(brush_iter)),'_translationx',...
                num2str(translationX),'translationy',num2str(translationY),'_saturated_classification');
            brush = initSimpleCylinderObject(diameter(brush_iter)/2,l,0.0005);
            brush = setObjPosition(brush,[translationX*.001;translationY*.001;diameter(brush_iter)/2+0.022]);
            brush = setObjMass(brush,density*l*diameter(brush_iter)*diameter(brush_iter)*pi/4);
            addObject(brush);

            %start experiment
    %         setRecordOn(filename);
            data = simStart(true);

            %save data
            label_num = brush_iter;
            save(strcat('data/classification_data/paintbrushes/',filename,'.mat'),'data','label_num');
        end
    end
end
