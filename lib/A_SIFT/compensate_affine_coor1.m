function [p1] = compensate_affine_coor1(p0, w1, h1, t1, t2, Rtheta)

Rtheta = Rtheta*pi/180;

% coordinate of origin in affine transformed frame
if Rtheta <= pi/2
    ori = [0 w1*sin(Rtheta)/t1];
else
    ori = [-w1*cos(Rtheta)/t2 (w1*sin(Rtheta) + h1*sin(Rtheta-pi/2))/t1];
end

% use origin as the "origin"
p1(:, 1) = p0(:, 1) - ori(1);
p1(:, 2) = p0(:, 2) - ori(2);
% invert tilt
p1(:, 1) = p1(:, 1) * t2;
p1(:, 2) = p1(:, 2) * t1;
% invert rotation
p1 = [cos(Rtheta) -sin(Rtheta); sin(Rtheta) cos(Rtheta)]*p1';
p1 = p1';