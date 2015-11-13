function object = updateObject(object,stepSize,currentStep)

if object.planStep < size(object.plan,1) && ...
        currentStep*stepSize >= object.plan(object.planStep+1,1)
    object.planStep = object.planStep+1;
    object.velocity = object.plan(object.planStep,2:4)';
end

object.position = object.velocity*stepSize+object.position;

%need to add more complicated motion (angular motion) (acceleration?)

%need to add more complicated motion plans

end