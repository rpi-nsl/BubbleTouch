function object = initCombObject(clength,cwidth,numTeeth,resolution)
%this function generates a rectangular prism shell out of spheres

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


radius = resolution/2;
%sphereSpacing = radius (distance between sphere centers

numL = round(clength/radius)-1;
numW = round(cwidth/radius)-1;

if min([numL,numW]) < 1
    warning('resolution too large to approximate shape');
    if numL < 1
        numL = 1;
    end
    if numW < 1
        numW = 1;
    end
end

L = radius*((1:numL)-(numL+1)/2);
W = radius*((1:numW)-(numW+1)/2);
T = clength/(numTeeth-1)*((1:numTeeth)-(numTeeth+1)/2);

%enforce dimensions
%length
shiftAmount = ((L(end)-L(1)+2*radius)-clength)/2;
L(1) = L(1) + shiftAmount;
L(end) = L(end) - shiftAmount;
%make even spacing for rest of layers
if length(L) > 2
    L(2:end-1) = (L(end)-L(1))/(2*shiftAmount+clength-2*radius)*L(2:end-1);
end
%width
shiftAmount = ((W(end)-W(1)+2*radius)-cwidth)/2;
W(1) = W(1) + shiftAmount;
W(end) = W(end) - shiftAmount;
%make even spacing for rest of layers
if length(W) > 2
    W(2:end-1) = (W(end)-W(1))/(2*shiftAmount+cwidth-2*radius)*W(2:end-1);
end
% %height
% shiftAmount = ((H(end)-H(1)+2*radius)-bheight)/2;
% H(1) = H(1) + shiftAmount;
% H(end) = H(end) - shiftAmount;
% %make even spacing for rest of layers
% if length(H) > 2
%     H(2:end-1) = (H(end)-H(1))/(2*shiftAmount+bheight-2*radius)*H(2:end-1);
% end

%back
back = [L',max(W)*ones(size(L')),zeros(size(L'))];

%teeth
teeth = zeros(length(W)*numTeeth,3);
for tooth = 0:(numTeeth-1)
    teeth(tooth*length(W)+1:(tooth+1)*length(W),:) = [T(tooth+1)*ones(size(W')),W',zeros(size(W'))];
end

object.shape = [[back,radius*ones(length(back),1)];[teeth,radius*ones(length(teeth),1)]];

%quasi-static variables
object.cog = [0;0;0];
object.mass = 1;
object.qsForceConstant = 1;
% object.inertia = [.25*(cwidth*cwidth+bheight*bheight)/3 0 0;
%                   0 .25*(clength*clength+bheight*bheight)/3 0;
%                   0 0 .25*(clength*clength+cwidth*cwidth)/3];
object.qsTorqueConstant = eye(3);

end