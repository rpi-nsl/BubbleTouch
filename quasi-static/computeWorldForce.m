function force = computeWorldForce(object)

global world;

%do I need force in object frame (object cog frame)?
force = world.gravity*object.mass;

end
