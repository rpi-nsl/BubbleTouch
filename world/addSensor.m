function id = addSensor(sensor)

global world

%determine where to add object
id = length(world.sensors)+1;

%add object
world.sensors{id} = sensor;

%update object's id
if id > 1
    world.sensors{id}.id = world.sensors{id-1}.id+1;
else
    world.sensors{id}.id = id;
end

%return updated id
id = world.sensors{id}.id;

end