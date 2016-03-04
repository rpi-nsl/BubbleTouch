function object = computeObjQSConstants(object,timestep)
%use the mass, inertia tensor and timesteps to generate quasi-static
%constants

object.qsForceConstant = timestep/object.mass;
object.qsTorqueConstant = timestep*inv(object.inertia);

end