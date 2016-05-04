function index = findSensorInWorld(sensorID)

global world

for i = 1:length(world.sensors)
    if world.sensors{i}.id == sensorID
        index = i;
        return
    end
end