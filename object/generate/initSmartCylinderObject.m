function object = initSmartCylinderObject(cradius,cheight,capRadius)
%this function generates a cylinder from a string of spheres
%sphereRadius determines the resolution, and is the radius size of the
%spheres making the cylinder.

if cheight <= 2*cradius
    object = initCylinderObject(cradius,cheight,capRadius);
    return
end

%id is way of distiguishing grouped objects
object.id = 0; %zero indicates not added to world

object.position = [0;0;0];
object.orientation = [1,0,0;
                      0,1,0;
                      0,0,1];
object.velocity = [0;0;0];
object.angularVelocity = [0;0;0];

%plan is a set of times (timestep t) when the velocity (future: acceration)
%changes and the new velocities (v)
object.plan = [];
%The current step of the plan being executed
object.planStep = 0;

%does the majority of the cylinder a string of spheres, but caps the
%cylinder with small spheres

%string of spheres

numSpheres = round((cheight-2*cradius)/capRadius)+1;
H = capRadius*((1:numSpheres)-(numSpheres+1)/2);
stringSpheres = [H',zeros(size(H')),zeros(size(H')),cradius*ones(size(H'))];
% else
%     stringSpheres = [];
%     H = [0];
% end

%cap sides
numRingSpheres = ceil(2*pi*cradius/capRadius);
%ring
ringY = cos(0:1/numRingSpheres:2*pi)*(cradius-capRadius);
ringZ = sin(0:1/numRingSpheres:2*pi)*(cradius-capRadius);

%side
numRings = round(cradius/capRadius);
Hcap1 = capRadius*(1:numRings)+H(end);
shiftAmount = cheight/2-capRadius-Hcap1(end); %makes exact height correct
Hcap1 = Hcap1+shiftAmount;
sideH = repmat(Hcap1,[length(ringY),1]);
sideH = sideH(:);
sideY = repmat(ringY',[length(Hcap1),1]);
sideZ = repmat(ringZ',[length(Hcap1),1]);
cap1 = [sideH,sideY,sideZ,capRadius*ones(size(sideH))];

Hcap2 = -capRadius*(1:numRings)+H(1);
shiftAmount = -cheight/2+capRadius-Hcap1(end); %makes exact height correct
Hcap1 = Hcap1+shiftAmount;
sideH = repmat(Hcap2,[length(ringY),1]);
sideH = sideH(:);
cap2 = [sideH,sideY,sideZ,capRadius*ones(size(sideH))];

%ends
ringY = ringY';
ringZ = ringZ';
for r = 0:capRadius:cradius-2*capRadius
    numRingSpheres = ceil(2*pi*r/capRadius);
    %ring
    innerRingY = cos(0:1/numRingSpheres:2*pi)*r;
    innerRingZ = sin(0:1/numRingSpheres:2*pi)*r;
    ringY = [ringY;innerRingY'];
    ringZ = [ringZ;innerRingZ'];
end
end1 = [Hcap1(end)*ones(size(ringY)),ringY,ringZ,capRadius*ones(size(ringY))];
end2 = [Hcap2(end)*ones(size(ringY)),ringY,ringZ,capRadius*ones(size(ringY))];

object.shape = [stringSpheres;cap1;cap2;end1;end2];

%quasi-static variables
object.cog = [0;0;0];
object.mass = 1;
object.qsForceConstant = 1;
object.inertia = [.5*(cradius*cradius) 0 0;
                  0 .25*(cradius*cradius + cheight*cheight/3) 0;
                  0 0 .25*(cradius*cradius + cheight*cheight/3)];
object.qsTorqueConstant = eye(3);

end