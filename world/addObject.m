function id = addObject(object)

global world;

%determine where to add object
id = length(world.objects)+1;

%add object
world.objects{id} = object;

%update object's id
if id > 1
    world.objects{id}.id = world.objects{id-1}.id+1;
else
    world.objects{id}.id = id;
end

%return updated id
id = world.objects{id}.id;

end