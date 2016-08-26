function sensor = convertToGPUSensor(sensor)

sensor.position = gpuArray(sensor.position);
sensor.orientation = gpuArray(sensor.orientation);
sensor.taxels = gpuArray(sensor.taxels);
sensor.taxelsContact = gpuArray(sensor.taxelsContact);