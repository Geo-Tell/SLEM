function [s]=actual_trans(t, theta, row, col)
% additional scale that must be multiplied to compensate and get the true
% affine
pts=[1 1
    col row
    1 row
    col 1];

tmp = compensate_affine_coor1(pts, col, row, t, 1, theta);



  a_c = cp2tform(pts,tmp,'affine');
  a=a_c.tdata.Tinv';
  %a=a_c.tdata.T'
  
  K=[t 0
      0 1];
  R2=[cosd(theta) sind(theta)
      -sind(theta) cosd(theta)];
  a_true=K*R2;
  
  a=a(1:2,1:2);
  
  
s=sum(abs(a_true))/sum(abs(a));

