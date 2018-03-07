function object = defaultYCB(object_name)
ycb_loc = '/home/bdhollis/Downloads/ycb/';
names = dir([ycb_loc,'*',object_name,'/']);
names = names.name;
object = initPLYMeshObject([ycb_loc,names,'/google_16k/nontextured.ply']);
object = centerObj(object);
% banana = setObjPosition(banana,[-.02;0;.065]);
object = setObjPosition(object,[0;0;max(object.shape(:,3))]);
%object = setObjOrientation(object,kth2R([0,1,0],pi));
object = setObjMass(object,0.072);
end