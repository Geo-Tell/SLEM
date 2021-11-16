function [candidate_linepairs] = Cor_LP_Initialization(linepairs1,linepairs2,matches_points_all,inlier2,f1,f2)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
t1=cputime;
global Modeling

[f1_n, T_a]=normalise2dpts(cat(2, f1(1,matches_points_all(1,inlier2))', f1(2,matches_points_all(1,inlier2))', ones(length(inlier2),1))');
[f2_n, T_b]=normalise2dpts(cat(2, f2(1,matches_points_all(2,inlier2))', f2(2,matches_points_all(2,inlier2))', ones(length(inlier2),1))');

[F,~,state]=estimateFundamentalMatrix(f1_n(1:2,:)',f2_n(1:2,:)','Method','RANSAC','NumTrials',4000,'DistanceThreshold',1e-4);

switch state
    case 1
        error('matchedPoints1 and matchedPoints2 do not contain enough points');
    case -2
        error('Not enough inliers found');
end


int_p1=zeros(length(linepairs1),5);%n*5：x,y,1,index of line1,index of line2
int_p1(:,3)=ones(length(linepairs1),1);
int_p2=zeros(length(linepairs2),5);
int_p2(:,3)=ones(length(linepairs2),1);

int_p1(:,1:2)=linepairs1(:,1:2);
int_p1(:,4:5)=linepairs1(:,3:4);
int_p2(:,1:2)=linepairs2(:,1:2);
int_p2(:,4:5)=linepairs2(:,3:4);

int_p1_n=T_a*int_p1(:,1:3)';
int_p2_n=T_b*int_p2(:,1:3)';


lines = cv.computeCorrespondEpilines(int_p1_n(1:2,:)', F)';%直线系数被标准化a^2+b^2+c^2=1;
dist=zeros(length(linepairs1),length(linepairs2));
if length(linepairs1)>5000
    interval1=1:5000:length(linepairs1);
    interval2=0:5000:length(linepairs1);
    if mod(length(linepairs1),5000)~=0
        interval2=[interval2,length(linepairs1)];
    end
    for i=1:length(interval1)
        dist(interval1(i):interval2(i+1),:)=abs(int_p2_n(1:3,:)'*lines(:,interval1(i):interval2(i+1)))';
    end
else
    dist=abs(int_p2_n(1:3,:)'*lines)';
end



mask=dist<Modeling.epsilon_verification2;
% matches_number=sum(mask,2);

candidate_linepairs=cell(length(linepairs1),1);

for i=1:length(candidate_linepairs)
    [a,b]=sort(dist(i,:),'ascend');
    c=find(a<Modeling.epsilon_verification2);
    if length(c)<=500
        candidate_linepairs{i}=b(c);
    else
        candidate_linepairs{i}=b(c(1:500));
    end
end
t2=cputime-t1;
disp(['The Initialization for Correspondence of LinePairs  takes :',num2str(t2),'s'])
end

