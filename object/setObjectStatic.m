function object = setObjectStatic(object)
%this flag means the object should not move no matter what
%(this 'not moving' function still needs to be implemented in
%updateTaxels')

object.static = true;
end