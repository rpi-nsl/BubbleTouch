function object = updateObject(object,stepSize,currentStep)

%static objects do not move (this check maybe should be in the main
%function?
if isfield(object,'static') && object.static
    return
end

%update position
object.position = object.velocity*stepSize+object.position;

%update orientation
if norm(object.angularVelocity) > 0
    object.orientation = object.orientation * kth2R(object.angularVelocity/norm(object.angularVelocity),...
        norm(object.angularVelocity)*stepSize);
end

%next plan step - currently no angular acceleration
if object.planStep < size(object.plan,1) && ...
        currentStep*stepSize >= object.plan(object.planStep+1,1)
    object.planStep = object.planStep+1;
    object.velocity = object.plan(object.planStep,2:4)';
    object.angularVelocity = object.plan(object.planStep,5:7)';
end

%should add acceleration?

%need to add more complicated motion plans

end