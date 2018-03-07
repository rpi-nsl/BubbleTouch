function sensor = initRectangularSensor(sizeX,sizeY,elementRadius,minZ,maxZ)
%This function generates a default sensor rectangular array of
%sizeX-by-sizeY taxels.

%id is way of distiguishing grouped sensors
sensor.id = 0; %zero indicates not added to world

sensor.position = [0;0;0];
sensor.orientation = [1,0,0;
                      0,1,0;
                      0,0,1];
sensor.MAXZ = maxZ;
sensor.MINZ = minZ;

sensor.RADIUS = elementRadius;
sensor.taxels = sensor.MAXZ*ones(sizeX*sizeY,3);
i = 1:sizeX*sizeY;
sensor.taxels(:,1) = (mod(i-1,sizeX)-.5*(sizeX-1))*2*sensor.RADIUS;
sensor.taxels(:,2) = (floor((i-1)/sizeX)-.5*(sizeY-1))*2*sensor.RADIUS;

%quasi-static variables
sensor.springConstant = 1;
sensor.taxelsContact = -ones(sizeX*sizeY,2); %col 1: object, col 2: sphere

sensor.readForce = false;

end
