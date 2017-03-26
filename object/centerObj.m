function object = centerObj(object)

object.cog(1) = .5*(max(object.shape(:,1))+min(object.shape(:,1)));
object.cog(2) = .5*(max(object.shape(:,2))+min(object.shape(:,2)));
object.shape(:,1:3) = object.shape(:,1:3)-kron(object.cog',ones(size(object.shape,1),1));
object.cog = [0;0;0];

end