function object = updateObject(object,stepSize,currentStep)

%static objects do not move (this check maybe should be in the main
%function?
if isfield(object.static) && object.static
    return
end

object.position = object.velocity*stepSize+object.position;

if object.planStep < size(object.plan,1) && ...
        currentStep*stepSize >= object.plan(object.planStep+1,1)
    object.planStep = object.planStep+1;
    object.velocity = object.plan(object.planStep,2:4)';
end

%need to add more complicated motion (angular motion) (acceleration?)

%need to add more complicated motion plans

end