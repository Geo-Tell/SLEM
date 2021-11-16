function [w2,inlier1,inlier2,matches_v,matches_i_all,ind1,T_a,T_b] = VPT_Modeling(f1,f2,matches_points,matches_points_all)
%VPT_MODELING 此处显示有关此函数的摘要
%   此处显示详细说明
t1=cputime;
global Modeling
prob_t=0.6;
flow_mag=1;
max_prob=1;

[Ay2x] = getA_s_y2x_new(f1(3:6, matches_points(1,:))', f2(3:6, matches_points(2,:))'); %分别取两个图像中ration_test后特征点的后四项参数，然后计算特征点之间的仿射矩阵
discard=clean_Ay2x(Ay2x, 5); % remove badly scaled affine from consideration
Ay2x(discard,:)=[];
matches_points(:,discard)=[];

matches_points_old=matches_points;
Ay2x_old=Ay2x;
if size(matches_points,2) > Modeling.Nt %if there are two many potential matches, sub-sample
%     ind=1:Modeling.Nt;
    ind=randsample(size(matches_points,2), Modeling.Nt);
    matches_points=matches_points(:,ind);
    Ay2x=Ay2x(ind,:);
end

[T_a,T_b,w1, Vec]=matches2points_affine_reguess(f1(1:2,matches_points(1,:))' , f2(1:2,matches_points(2,:))', ...
    Ay2x, 0.1); 

[inlier]=inlier_estimate_reguess(T_a, T_b,  f1(1:2,matches_points_old(1,:)), f2(1:2, matches_points_old(2,:)),Ay2x_old, w1, Vec, 0.1,0.5, max_prob, flow_mag);

[Ay2x_a] = getA_s_y2x_new(f1(3:6, matches_points_all(1,:))', f2(3:6, matches_points_all(2,:))');
discard=clean_Ay2x(Ay2x_a, 5);
Ay2x_a(discard,:)=[];
matches_points_all(:,discard)=[];
[inlier_all]=inlier_estimate_reguess(T_a, T_b,  f1(1:2,matches_points_all(1,:)), f2(1:2, matches_points_all(2,:)),Ay2x_a, w1, Vec, 0.1,prob_t, max_prob, flow_mag);
matches_i_all=matches_points_all(:, inlier_all);

matches_i=matches_points_old(:, inlier);
matches_v=unique_match2(matches_i);

matches_i_all=cat(2, matches_i, matches_i_all);
matches_i_all=unique(matches_i_all', 'rows')';

[inlier1,inlier2,w2,ind1]=matches2points_project_reguess(f1(1:2, matches_v(1,:)),f2(1:2, matches_v(2,:)),T_a, T_b,f1(1:2, matches_i_all(1,:)),f2(1:2, matches_i_all(2,:)));
t2=cputime-t1;
disp(strcat('The Varying Projective Transformation Modeling takes :',num2str(t2),'s'))

end

