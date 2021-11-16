function [inlier]=inlier_estimate_reguess(T_a, T_b,  f1, f2,Ay2x, w, V2, thres, min_prob, max_v, flow_mag)

f1=cat(1, f1(1:2,:), ones(1,size(f1,2)));
f2=cat(1, f2(1:2,:), ones(1,size(f2,2)));

f1=T_a*f1;
f2=T_b*f2;%和之前相同的标准化处理

V1=cat(2, f1(1:2,:)', flow_mag*(f2(1:2,:)- f1(1:2,:))',Ay2x);

%V1==V2


[G]=G_compute_fast(V1', V2', 1);

G(G<thres)=0;



inlier=G*w>min_prob*max_v;
inlier=find(inlier);

