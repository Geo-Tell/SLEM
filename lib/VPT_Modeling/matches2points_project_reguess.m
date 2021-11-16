function [inlier1,inlier2,w,ind1] = matches2points_project_reguess(f1,f2,T_a, T_b,f11, f22)
global Modeling

s_scale=1;

f1_old=f1;
f2_old=f2;
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


matchesall_coordinates(1:2,:)=f11(1:2,:);
matchesall_coordinates(3:4,:)=f22(1:2,:);

if size(matches_coordinates,2)>Modeling.M
    ind1=randsample(size(matches_coordinates,2), Modeling.M);
    ind1=uniform_sample(ind1,f1_old);
%     ind1=1:Modeling.M;
    p=matches_coordinates(:,ind1);
else
    ind1=1:size(matches_coordinates,2);
    p=matches_coordinates;
end

if size(matches_coordinates,2)>Modeling.Nr
    ind2=randsample(size(matches_coordinates,2),Modeling.Nr);
    ind2=uniform_sample(ind2,f1_old);
    matches_coordinates=matches_coordinates(:,ind2);
else
    ind2=1:length(matches_coordinates);
end
lamda=Modeling.lambda_weight*size(matches_coordinates,2)/size(p,2);%光滑惩罚项的权重
   
[w,~]=grad_desc_projection(p, matches_coordinates, Modeling.gamma_radius, s_scale,lamda );

inlier1= project_points_verification(p,matches_coordinates,w,Modeling.epsilon_verification1);
inlier1=ind2(inlier1)';

inlier2= project_points_verification(p,matchesall_coordinates,w,Modeling.epsilon_verification1);

% display_match_trad_enum(uint8(image1), uint8(image2), temp(:,inlier2), temp1(1:2,:),temp2(1:2,:))

end

