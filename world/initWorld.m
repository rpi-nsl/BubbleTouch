function initWorld(maxIter,stepSize,sampleRate)

global world;
world.maxIter = maxIter;
world.stepSize = stepSize;
if nargin > 2
    world.sampleRate = sampleRate;
else
    world.sampleRate = stepSize;
end

world.sensors = [];
world.objects = [];
%world.addSensor(initRectangularSensor(10,10,1,0,2));
%addObject(initSphereObject(10));

world.scene = [];

%quasi-static variables
world.gravity = [0;0;-9.8];
%how much previous velocity is remembered
world.damper = 0;

%video
world.record = false;

%how pretty the graphics look
world.graphicsResolution = 20;

end