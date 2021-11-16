function [proj_verify,E,H,invH] = project_intpoints_verification(f1,f2,T_a, T_b,f11, f22,w,ind)

%PROJ_VERIFICATION_MATLAB 此处显示有关此函数的摘要
%   此处显示详细说明


f1=cat(1, f1(1:2,:), ones(1,size(f1,2)));
f2=cat(1, f2(1:2,:), ones(1,size(f2,2)));

f1=T_a*f1;
f2=T_b*f2;

f11=cat(1, f11(1:2,:), ones(1,size(f11,2)));
f22=cat(1, f22(1:2,:), ones(1,size(f22,2)));

f11=T_a*f11;
f22=T_b*f22;



matches_coordinates(1:2,:)=f1(1:2,:);
matches_coordinates(3:4,:)=f2(1:2,:);

p=matches_coordinates(:,ind);


matchesall_coordinates(1:2,:)=f11(1:2,:);
matchesall_coordinates(3:4,:)=f22(1:2,:);


% ind1=randsample(size(matches_coordinates,2), 300);
% p=matches_coordinates(:,ind1);

% temp1=inv(T_a)*f11(:,:);
% temp2=inv(T_b)*f22(:,:);

[proj_verify,E,H,invH]=project_intpoints_inliers(p,matchesall_coordinates,w);
if isempty(H)
    return
end




end

