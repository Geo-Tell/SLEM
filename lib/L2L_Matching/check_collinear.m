function [I]=check_collinear(ind,lines,llines,line_sim,I,row_num)
global L2LM
cond=zeros(1,length(ind));
num=1;
for i=1:length(ind)
    if cond(i)==1
        continue
    end
    class{1,num}=[i];
    if i==length(ind)
        break
    end
    for j=i+1:length(ind)
        [~,d]=cal_lines_overlapping_dist(llines(ind(i),:),llines(ind(j),:));
        if d>L2LM.Col_d&&not(isang(lines(ind(i)),lines(ind(j))))
            class{1,num}=[class{1,num},j];
            cond(j)=1;
        end
    end
    num=num+1;
end
sim=zeros(1,length(class));
for i=1:length(sim)
    temp=class{1,i};
    for j=1:length(class{1,i})
        sim(i)=sim(i)+line_sim(temp(j));
    end
end
[~,ind1]=max(sim);
for i=1:length(class{1,ind1})
    temp=class{1,ind1};
    I=[I;row_num,ind(temp(i))];
end
end
function isang_log=isang(line1,line2)
global L2LM
isang_log=false;
if line1.k==line2.k
    return
else
    ang=atan(abs((line1.k-line2.k)/(1+line1.k*line2.k)));
end

if ang>L2LM.Col_theta
    isang_log=true;
end
end