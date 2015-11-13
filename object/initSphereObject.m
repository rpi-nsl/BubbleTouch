function object = initSphereObject(radius)
%this function generates a default object sphere.

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

object.shape = [0,0,0,radius]; %[x,y,z,r]

end


