function [matches, matches_c, D_o]=vl_match_complete(d1, d2, thres)

D_o = vl_alldist(d1,d2) ;
D=D_o;
[dist1, best] = min(D, [], 2) ;%按行返回最小值，dist1为最小值，best为索引
D((1:size(D,1))+(best-1).'*size(D,1)) = Inf;
dist2=min(D,[],2);

mask=thres*dist1<dist2;

a=find(mask);
b=best(mask);
matches=cat(1, a', b');

mask=1*dist1<dist2;

a=find(mask);
b=best(mask);
matches_c=cat(1, a', b');
 