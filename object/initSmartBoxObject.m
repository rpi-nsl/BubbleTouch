function object = initSmartBoxObject(blength,bwidth,bheight,maxResolution)
%this function generates a rectangular prism shell out of spheres


object.position = [0;0;0];
object.orientation = [1,0,0;
                      0,1,0;
                      0,0,1];
object.velocity = [0;0;0];

%plan is a set of times (timestep t) when the velocity (future: acceration)
%changes and the new velocities (v)
object.plan = [];
%The current step of the plan being executed
object.planStep = 0;

minDim = min([blength,bwidth,bheight]);
relL = round(4*blength/minDim);
relW = round(4*bwidth/minDim);
relH = round(4*bheight/minDim);
radius = min([maxResolution,minDim/gcd(gcd(relL,relW),gcd(relL,relH))]);
%sphereSpacing = radius (distance between sphere centers

%may want to use ceil to better approximate corner if contact is in the
%plane
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

L = radius*((1:numL)-(numL-1)/2);
W = radius*((1:numW)-(numW-1)/2);
H = radius*((1:numH)-(numH-1)/2);

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
end