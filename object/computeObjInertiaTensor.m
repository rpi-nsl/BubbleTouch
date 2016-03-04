function object = computeInertiaTensor(object)

%Ixx = sum((y_i^2+z_i^2)*m_i)
%Iyy = sum((x_i^2+z_i^2)*m_i)
%Izz = sum((x_i^2+y_9^2)*m_i)
%Ixy = Iyx = sum(x_i*y_i*m_i)
%Ixz = Iyx = sum(x_i*z_i*m_i)
%Iyz = Iyx = sum(y_i*z_i*m_i)

points = object.shape(:,1:3)-kron(object.cog',ones(size(object.shape,1),1));
masses = object.mass*object.shape(:,4).*object.shape(:,4)/sum(object.shape(:,4).*object.shape(:,4));
Ixx = sum((points(:,2).*points(:,2) + points(:,3).*points(:,3)).*masses);
Iyy = sum((points(:,1).*points(:,1) + points(:,3).*points(:,3)).*masses);
Izz = sum((points(:,1).*points(:,1) + points(:,2).*points(:,2)).*masses);
Ixy = sum(points(:,1).*points(:,2).*masses);
Ixz = sum(points(:,1).*points(:,3).*masses);
Iyz = sum(points(:,2).*points(:,3).*masses);

object.inertia = [ Ixx -Ixy -Ixz;
                  -Ixy  Iyy -Iyz;
                  -Ixz -Iyz  Izz];
              
end
