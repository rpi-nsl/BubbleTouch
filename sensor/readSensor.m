function values = readSensor(sensor)

%NOTE: Should sensor read delta-z or the force (i.e. should multiply by
%spring constant)?
values = sensor.MAXZ-sensor.taxels(:,3);

%NOTE: Realistically, should make it so one could apply only reading
%function, such as implement nonlinear readings.

end