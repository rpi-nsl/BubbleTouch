function object = computeObjQSConstants(object,timestep)
%use the mass, inertia tensor and timesteps to generate quasi-static
%constants

%TODO: force constant related to surface area
object.qsForceConstant = timestep/object.mass*eye(3);
object.qsTorqueConstant = timestep*inv(object.inertia);

end