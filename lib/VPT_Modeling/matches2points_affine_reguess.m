function [T_a, T_b, w, Vec]=matches2points_affine_reguess(fa, fb, aff, thres)

% spatial coordinates
xa = fa(:,1);
ya = fa(:,2);
xb = fb(:,1);
yb = fb(:,2);

%normalize points so constant parameters can be used
%将原来的点进行标准化x=x*s-s*xc（c是中心点，s是sqrt（2）/mean（d），d为点x，y到中心点xc,xy的距离，T是记录标准化运算的矩阵
[a_points, T_a]=normalise2dpts(cat(2, xa, ya, ones(length(xa),1))');
[b_points, T_b]=normalise2dpts(cat(2, xb, yb, ones(length(xa),1))');

a_points=a_points';
b_points=b_points';

matched=cat(2, xa, ya, xb, yb, aff);
y=ones(size(matched,1), 1);

Vec=cat(2, a_points(:,1:2), b_points(:,1:2)-a_points(:,1:2),aff);%标准化后图a中特征点的横纵坐标，与图b中对应特征点的运动，以及仿射矩阵
% compute the curve fit, thres is the threshold for the huber function
[w, ~]=grad_desc_huber_official(cat(2, a_points(:,1:2), (b_points(:,1:2)-a_points(:,1:2)),aff),y,1, 1, thres);%thres=0.1

