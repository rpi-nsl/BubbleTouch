function object = setObjCOG(object, cog)
%sets the object's center of gravity

object.cog = [cog(1); cog(2); cog(3)];

end