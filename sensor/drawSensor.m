function senh = drawSensor(sensor)

[spherex,spherey,spherez] = sphere;

t = ones(size(spherex));

centers = (sensor.orientation*sensor.taxels'+kron(sensor.position,ones(1,size(sensor.taxels,1))))';

x = kron(centers(:,1),t);
y = kron(centers(:,2),t);
z = kron(centers(:,3),t);

spherex = repmat(sensor.RADIUS*spherex,size(sensor.taxels,1),1);
spherey = repmat(sensor.RADIUS*spherey,size(sensor.taxels,1),1);
spherez = repmat(sensor.RADIUS*spherez,size(sensor.taxels,1),1);

gx = spherex+x;
gy = spherey+y;
gz = spherez+z;

senh = surf(gx,gy,gz,ones(size(gz)));
set(senh,'FaceColor',[1,0,0]);
axis equal;

end

