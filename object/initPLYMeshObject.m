function object = initPLYMeshObject(filename)
%this function generates a default object using a ply mesh for the shape

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

c = read_ply(filename);
%c = c;

r = pdist2(c,c,'euclidean','Smallest',2);
r = r(2,:)';
% r = .001*ones(size(r));
r = 2*mean(r)*ones(size(r));
object.shape = [c,r]; %[x,y,z,r]

end