function initWorld(maxIter,stepSize,sampleRate,updateModel)

%sampleRate is optional, defaults to stepSize (taking a sample every step)
%updateModel is optional, defaults to 'quasistatic' (other option is
% 'kinematic')

global world;
world.maxIter = maxIter;
world.stepSize = stepSize;
if nargin > 2
    world.sampleRate = sampleRate;
else
    world.sampleRate = stepSize;
end
if nargin > 3
    world.type = updateModel
else
    world.type = 'quasistatic';
end

world.sensors = [];
world.objects = [];
world.robots = [];
%world.addSensor(initRectangularSensor(10,10,1,0,2));
%addObject(initSphereObject(10));

world.scene = [];

%quasi-static variables
world.gravity = [0;0;-9.8];
%how much previous velocity is remembered (nonzero is no-longer technically quasi-static)
world.damper = 0;

%video
world.record = false;

%how pretty the graphics look
world.graphicsResolution = 20;

end