function object = initBoxObject(blength,bwidth,bheight,resolution)
%this function generates a rectangular prism shell out of spheres

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


radius = resolution/2;
%sphereSpacing = radius (distance between sphere centers

numL = round(blength/radius)-1;
numW = round(bwidth/radius)-1;
numH = round(bheight/radius)-1;

if min([numL,numW,numH]) < 1
    warning('resolution too large to approximate shape');
    if numL < 1
        numL = 1;
    end
    if numW < 1
        numW = 1;
    end
    if numH < 1
        numH = 1;
    end
end

L = radius*((1:numL)-(numL+1)/2);
W = radius*((1:numW)-(numW+1)/2);
H = radius*((1:numH)-(numH+1)/2);

%enforce dimensions
%length
shiftAmount = ((L(end)-L(1)+2*radius)-blength)/2;
L(1) = L(1) + shiftAmount;
L(end) = L(end) - shiftAmount;
%make even spacing for rest of layers
if length(L) > 2
    L(2:end-1) = (L(end)-L(1))/(2*shiftAmount+blength-2*radius)*L(2:end-1);
end
%width
shiftAmount = ((W(end)-W(1)+2*radius)-bwidth)/2;
W(1) = W(1) + shiftAmount;
W(end) = W(end) - shiftAmount;
%make even spacing for rest of layers
if length(W) > 2
    W(2:end-1) = (W(end)-W(1))/(2*shiftAmount+bwidth-2*radius)*W(2:end-1);
end
%height
shiftAmount = ((H(end)-H(1)+2*radius)-bheight)/2;
H(1) = H(1) + shiftAmount;
H(end) = H(end) - shiftAmount;
%make even spacing for rest of layers
if length(H) > 2
    H(2:end-1) = (H(end)-H(1))/(2*shiftAmount+bheight-2*radius)*H(2:end-1);
end

%top
topL = repmat(L,[length(W),1]);
topL = topL(:);
topW = repmat(W',[length(L),1]);
top = [topL,topW,max(H)*ones(size(topL)),radius*ones(size(topL))];
bottom = [topL,topW,min(H)*ones(size(topL)),radius*ones(size(topL))];

%front
frontL = repmat(L,[length(H),1]);
frontL = frontL(:);
frontH = repmat(H',[length(L),1]);
front = [frontL,max(W)*ones(size(frontL)),frontH,radius*ones(size(frontL))];
back = [frontL,min(W)*ones(size(frontL)),frontH,radius*ones(size(frontL))];

%left
leftW  = repmat(W,[length(H),1]);
leftW = leftW(:);
leftH = repmat(H',[length(W),1]);
left = [max(L)*ones(size(leftW)),leftW,leftH,radius*ones(size(leftW))];
right = [min(L)*ones(size(leftW)),leftW,leftH,radius*ones(size(leftW))];

object.shape = [top;bottom;left;right;front;back];

%quasi-static variables
object.cog = [0;0;0];
object.mass = 1;
object.qsForceConstant = 1;
object.inertia = [.25*(bwidth*bwidth+bheight*bheight)/3 0 0;
                  0 .25*(blength*blength+bheight*bheight)/3 0;
                  0 0 .25*(blength*blength+bwidth*bwidth)/3];
object.qsTorqueConstant = eye(3);

end