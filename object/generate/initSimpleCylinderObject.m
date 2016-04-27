function object = initSimpleCylinderObject(cradius,cheight,resolution)
%this function generates a cylinder from a string of spheres
%resolution is distance between sphere centers, this does not strictly
%enforce cylinder height as cylinder height is ambiguous

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


numSpheres = round(cheight/resolution)+1;
%sphereSpacing = radius (distance between sphere centers

H = resolution*((1:numSpheres)-(numSpheres+1)/2);

object.shape = [H',zeros(size(H')),zeros(size(H')),cradius*ones(size(H'))];

%quasi-static variables
object.cog = [0;0;0];
object.mass = 1;
object.qsForceConstant = 1;
object.inertia = [.5*(cradius*cradius) 0 0;
                  0 .25*(cradius*cradius + cheight*cheight/3) 0;
                  0 0 .25*(cradius*cradius + cheight*cheight/3)];
object.qsTorqueConstant = eye(3);

end