function id = addSensor(sensor)

global world

%determine where to add sensor
id = length(world.sensors)+1;

%add sensor
world.sensors{id} = sensor;

%update sensor's id
if id > 1
    world.sensors{id}.id = world.sensors{id-1}.id+1;
else
    world.sensors{id}.id = id;
end

%return updated id
id = world.sensors{id}.id;

end