function object = initSphereObject(radius)
%this function generates a default object sphere.

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

object.shape = [0,0,0,radius]; %[x,y,z,r]

%quasi-static variables
object.cog = [0;0;0];
object.mass = 1;
object.qsForceConstant = 1;
object.inertia = eye(3)*radius*radius*2/5;

end


