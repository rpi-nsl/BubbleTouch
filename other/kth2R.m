function R = kth2R(k, th)

k = k./norm(k);
R = Euler_Rodrigus(k,th);