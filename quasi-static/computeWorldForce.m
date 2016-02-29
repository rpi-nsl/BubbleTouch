function force = computeWorldForce(object)

global world;

%compute force of gravity
force = world.gravity*object.mass;

%convert to object frame
force = object.orientation'*force;


end
