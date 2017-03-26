function senh = drawSensor(sensor,detail)

if nargin < 2
    detail = 20;
end

[spherex,spherey,spherez] = sphere(detail);

t = ones(size(spherex));

centers = (sensor.orientation*sensor.taxels'+kron(sensor.position,ones(1,size(sensor.taxels,1))))';

x = kron(centers(:,1),t);
y = kron(centers(:,2),t);
z = kron(centers(:,3),t);



% x_ = centers(:,1);
% y_ = centers(:,2);
% z_ = centers(:,3);
% 
% bases = sensor.taxels;
% bases(:,3) = sensor.MINZ;
% bases = (sensor.orientation*bases'+kron(sensor.position,ones(1,size(bases,1))))';
% x_base = bases(:,1);
% y_base = bases(:,2);
% z_base = bases(:,3);
% 
% hold on;
% 
% 
% %spring (technically dependent on viewing position/orientation, but
% %currently assume view from y direction.  Now assuming springs are parallel
% %to z direction) goes from [x,y,z] -> [x,y,z-1/3(z-zbase)] ->
% %[x-offset,y,z-1/3(z-zbase)-1/5(z-zbase)] ->
% offset = 0.0005;
% x_s = x_-0.001;
% x_spring = [x_,x_s,x_s,x_s-offset,x_s+offset,x_s-offset,x_s+offset,x_s,x_s,x_base]'; %for x~=x_base, should linearly interpulate
% y_spring = [y_,y_,y_,y_,y_,y_,y_,y_,y_,y_base]'; %for y~=y_base, should linearly interpulate
% z_sixth = (sensor.MAXZ-sensor.MINZ)*ones(size(z_base))./6;%[z_-z_base]./6;
% z_third = [z_-z_base]./3;
% z_fifth = z_third./5;
% z_spring = [z_-z_sixth,z_-z_sixth,z_-z_third,z_-z_third-z_fifth,...
%     z_-z_third-2*z_fifth,z_-z_third-3*z_fifth,z_-z_third-4*z_fifth,...
%     z_base+z_third,z_base+z_sixth,z_base+z_sixth]';
% 
% plot3(x_spring,y_spring,z_spring,'k','LineWidth',2);
% 
% %damper
% % offset = 0.001;
% x_d = x_+0.001;
% x_damper_top = [x_,x_d,x_d,x_d-.5*offset,x_d+.5*offset]'; %for x~=x_base, should linearly interpulate
% y_damper_top = [y_,y_,y_,y_,y_]'; %for y~=y_base, should linearly interpulate
% z_top = 13*[z_-z_base]./24;
% z_damper_top = [z_-z_sixth,z_-z_sixth,z_-z_top,z_-z_top,z_-z_top]';
% 
% plot3(x_damper_top,y_damper_top,z_damper_top,'k','LineWidth',2);
% 
% x_damper_bottom = [x_d-offset,x_d-offset,x_d+offset,x_d+offset,x_d+offset,x_d,x_d,x_base]'; %for x~=x_base, should linearly interpulate
% y_damper_bottom = [y_base,y_base,y_base,y_base,y_base,y_base,y_base,y_base]'; %for y~=y_base, should linearly interpulate
% z_bbottom = 9*[z_-z_base]./24;
% z_btop = 3*(sensor.MAXZ-sensor.MINZ)*ones(size(z_base))./24;
% z_damper_bottom = [z_base+z_btop+z_bbottom,z_base+z_bbottom,...
%     z_base+z_bbottom,z_base+z_btop+z_bbottom, z_base+z_bbottom,...
%     z_base+z_bbottom,z_base+z_sixth,z_base+z_sixth]';
% 
% plot3(x_damper_bottom,y_damper_bottom,z_damper_bottom,'k','LineWidth',2);
% 
% %connectors
% plot3([x_,x_]',[y_,y_]',[z_,z_-z_sixth]','k','LineWidth',2);
% plot3([x_base,x_base]',[y_base,y_base]',[z_base+z_sixth,z_base]','k','LineWidth',2);
% hold on;


%spheres
spherex = repmat(sensor.RADIUS*spherex,size(sensor.taxels,1),1);
spherey = repmat(sensor.RADIUS*spherey,size(sensor.taxels,1),1);
spherez = repmat(sensor.RADIUS*spherez,size(sensor.taxels,1),1);

gx = spherex+x;
gy = spherey+y;
gz = spherez+z;

senh = surf(gx,gy,gz,'EdgeColor','none','LineStyle','none','FaceColor',[.6,0,0]);
% senh = surf(gx,gy,gz,'EdgeColor','none','LineStyle','none','FaceColor',[.6,0,0],'FaceLighting','phong');
% light('Position',[-1 -1 1],'Style','local')
% % view([1,-1,1]);
% % set(senh,'FaceColor',[1,0,0]);
axis equal;

end

