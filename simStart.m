function simStart

global world;

for currentStep = 1:world.maxIter;
    disp(currentStep*world.stepSize);
    updateObjects(currentStep);
    updateSensors;
    updateGraphics;
end
end

function loadSim

display('This function should load simulation parameters');
global world;
world.maxIter = 100;
world.stepSize = 1;

world.sensors = [];
world.objects = [];
%world.addSensor(initRectangularSensor(10,10,1,0,2));
addObject(initSphereObject(10));

world.scene = figure;

end

function updateObjects(currentStep)

display('This function should update object position');
global world;

for obj = 1:length(world.objects)
    world.objects{obj} = updateObject(world.objects{obj},world.stepSize,currentStep);
end

end

function updateSensors

display('This function should update sensor values');
global world;

for sen = 1:length(world.sensors);
    world.sensors{sen} = resetSensorValues(world.sensors{sen});
    for obj = 1:length(world.objects)
        world.sensors{sen} = updateTaxels(world.sensors{sen},world.objects{obj});
    end
end

end

function updateGraphics

display('This function should update graphics');
global world;

%access correct figure;
figure(world.scene);
%clear figure
cla;
hold on;

%draw object
for obj = 1:length(world.objects);
    drawObject(world.objects{obj});
end

%draw sensors
for sen = 1:length(world.sensors);
    drawSensor(world.sensors{sen});
end

%update figure;
drawnow limitrate

end