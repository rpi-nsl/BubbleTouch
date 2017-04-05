function object = initCylinderObject(cradius,cheight,sphereRadius)
%this function generates a cylinder from a string of spheres
%sphereRadius determines the resolution, and is the radius size of the
%spheres making the cylinder.

%id is way of distiguishing grouped objects
object.id = 0; %zero indicates not added to world

object.position = [0;0;0];
object.orientation = [1,0,0;
                      0,1,0;
                      0,0,1];
object.velocity = [0;0;0];
object.angularVelocity = [0;0;0];

%if true, the object should not move not matter what (still need to
%implement resulting force analysis for this)
object.static = false;

%plan is a set of times (timestep t) when the velocity (future: acceration)
%changes and the new velocities (v)
object.plan = [];
%The current step of the plan being executed
object.planStep = 0;


numRingsSpheres = ceil(2*pi*cradius/sphereRadius);
%ring
ringY = cos(0:1/numRingsSpheres:2*pi)*(cradius-sphereRadius);
ringZ = sin(0:1/numRingsSpheres:2*pi)*(cradius-sphereRadius);

numRings = round(cheight/sphereRadius);
%sphereSpacing = radius (distance between sphere centers

H = sphereRadius*((1:numRings)-(numRings+1)/2);
shiftAmount = ((H(end)-H(1)+2*sphereRadius)-cheight)/2;
H(1) = H(1) + shiftAmount;
H(end) = H(end) - shiftAmount;
%make even spacing for rest of layers
if length(H) > 2
    H(2:end-1) = (H(end)-H(1))/(2*shiftAmount+cheight-2*sphereRadius)*H(2:end-1);
end
%side
sideH = repmat(H,[length(ringY),1]);
sideH = sideH(:);
sideY = repmat(ringY',[length(H),1]);
sideZ = repmat(ringZ',[length(H),1]);
side = [sideH,sideY,sideZ,sphereRadius*ones(size(sideH))];

%ends
ringY = ringY';
ringZ = ringZ';
for r = 0:sphereRadius:cradius-2*sphereRadius
    numRingsSpheres = ceil(2*pi*r/sphereRadius);
    %ring
    innerRingY = cos(0:1/numRingsSpheres:2*pi)*r;
    innerRingZ = sin(0:1/numRingsSpheres:2*pi)*r;
    ringY = [ringY;innerRingY'];
    ringZ = [ringZ;innerRingZ'];
end
end1 = [H(1)*ones(size(ringY)),ringY,ringZ,sphereRadius*ones(size(ringY))];
end2 = [H(end)*ones(size(ringY)),ringY,ringZ,sphereRadius*ones(size(ringY))];

object.shape = [side;end1;end2];

%quasi-static variables
object.cog = [0;0;0];
object.mass = 1;
object.qsForceConstant = eye(3);
object.inertia = [.5*(cradius*cradius) 0 0;
                  0 .25*(cradius*cradius + cheight*cheight/3) 0;
                  0 0 .25*(cradius*cradius + cheight*cheight/3)];
object.qsTorqueConstant = eye(3);

end