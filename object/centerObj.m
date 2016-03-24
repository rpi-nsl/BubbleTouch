function object = centerObj(object)

object.shape(:,1:3) = object.shape(:,1:3)-kron(object.cog',ones(size(object.shape,1),1));
object.cog = [0;0;0];

end