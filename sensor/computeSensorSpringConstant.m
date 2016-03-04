function sensor = computeSensorSpringConstant(sensor,maxPressure)
%this function computes the spring constant for an array from a desired max
%pressure measureable by an individual taxel. Pressure is given in
%Netwons/meter^2 (Nm^-2) or Pascals (Pa)

%convert max pressure to max force by individual taxel
%assumes taxel is circular
taxelArea = pi*sensor.RADIUS*sensor.RADIUS;
%assumes taxel is square
%taxelArea = 4*sensor.RADIUS*sensor.RADIUS
maxTaxelForce = maxPressure*taxelArea;

%convert max force to spring constant f = kx
maxDisplacement = sensor.MAXZ-sensor.MINZ;
sensor.springConstant = maxTaxelForce/maxDisplacement;

end