function objh = drawObject(object,detail)

if nargin < 2
    detail = 20;
end

[spherex,spherey,spherez] = sphere(detail);

t = ones(size(spherex));

centers = (object.orientation*(object.shape(:,1:3))'+kron(object.position,ones(1,size(object.shape,1))))';

x = kron(centers(:,1),t);
y = kron(centers(:,2),t);
z = kron(centers(:,3),t);
r = kron(object.shape(:,4),t);

spherex = repmat(spherex,size(object.shape,1),1);
spherey = repmat(spherey,size(object.shape,1),1);
spherez = repmat(spherez,size(object.shape,1),1);

gx = spherex.*r+x;
gy = spherey.*r+y;
gz = spherez.*r+z;

objh = surf(gx,gy,gz,'EdgeColor','none','LineStyle','none','FaceColor',[0,0,.6]);
objh = surf(gx,gy,gz,'EdgeColor','none','LineStyle','none','FaceColor',[0,0,.6],'FaceLighting','phong');
light('Position',[-1 -1 1],'Style','local')
light('Position',[1 1 -1],'Style','local')
% view([.7,0,-1]);
set(objh,'FaceColor',[0,0,1]);
axis equal;

end