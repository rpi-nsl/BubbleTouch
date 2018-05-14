function points = meshToPointCloud(faces,vertices,num_points)

xtri = cross(vertices(faces(:,2),:)-vertices(faces(:,1),:),vertices(faces(:,3),:)-vertices(faces(:,1),:),2);

areas = sqrt(sum(xtri.*xtri,2));

probs = areas/sum(areas);

faces_indices = randsample(1:size(faces,1),num_points,true,probs);

v1 = vertices(faces(faces_indices,1),:);
v2 = vertices(faces(faces_indices,2),:);
v3 = vertices(faces(faces_indices,3),:);

u = rand(num_points,1);
v = rand(num_points,1);

problem_inds = find(u+v > 1);
u(problem_inds) = 1 - u(problem_inds);
v(problem_inds) = 1 - v(problem_inds);

w = 1 - (u + v);

points = v1.*repmat(u,1,3) + v2.*repmat(v,1,3) + v3.*repmat(w,1,3);