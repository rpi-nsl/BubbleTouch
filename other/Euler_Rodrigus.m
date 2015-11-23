function R = Euler_Rodrigus(k,theta);

k=k./norm(k);
kcross = matcross(k);
R = eye(3) + sin(theta)*kcross + (1-cos(theta))*kcross*kcross;