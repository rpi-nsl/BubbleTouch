function object = convertToGPUObject(object)

object.position = gpuArray(object.position);
object.orientation = gpuArray(object.orientation);
object.velocity = gpuArray(object.velocity);
object.angularVelocity = gpuArray(object.angularVelocity);
object.shape = gpuArray(object.shape);
object.cog = gpuArray(object.cog);
object.inertia = gpuArray(object.inertia);
object.qsTorqueConstant = gpuArray(object.qsTorqueConstant);

end