function [overlapping_rate line_dist]=cal_lines_overlapping_dist(line1,line2)
length1=norm(line1(1:2)-line1(3:4));
length2=norm(line2(1:2)-line2(3:4));
if length2>length1
    temp=line2;
    line2=line1;
    line1=temp;
    temp1=length1;
    length1=length2;
    length2=temp1;
end
lambda1=((line2(1)-line1(1))*(line1(3)-line1(1))+(line2(2)-line1(2))*(line1(4)-line1(2)))/length1^2;
lambda2=((line2(3)-line1(1))*(line1(3)-line1(1))+(line2(4)-line1(2))*(line1(4)-line1(2)))/length1^2;
dist1=norm(line1(1:2)+lambda1*(line1(3:4)-line1(1:2))-line2(1:2));
dist2=norm(line1(1:2)+lambda2*(line1(3:4)-line1(1:2))-line2(3:4));
line_dist=exp(-min([dist1,dist2]));
if lambda1>lambda2
    temp=lambda1;
    lambda1=lambda2;
    lambda2=temp;
end    
if lambda1>=0&&lambda1<=1&&lambda2>=0&&lambda2<=1
    overlapping_rate=(lambda2-lambda1)*length1/length2;
elseif lambda1<=0&&lambda2<=1&&lambda2>=0  
     overlapping_rate=lambda2*length1/length2;
elseif lambda1<=1&&lambda2>=1&&lambda1>=0
    overlapping_rate=(1-lambda1)*length1/length2;
else
            overlapping_rate=0;
end
end