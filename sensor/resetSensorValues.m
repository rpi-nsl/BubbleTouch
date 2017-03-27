function sensor = resetSensorValues(sensor)

sensor.taxelsContact = zeros(size(sensor.taxelsContact));
sensor.taxels(:,3) = sensor.MAXZ;

end