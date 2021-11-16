function [llines, pointlist]=paras(line_ends,img,f,matches_points,s)
I=imread(img);
imsize=size(I);
imsize=imsize(1:2);
for i=1:length(line_ends)
    llines(i).point1=[line_ends(i,1),line_ends(i,2)];
    llines(i).point2=[line_ends(i,3),line_ends(i,4)];
    
    if (llines(i).point2(1)~=llines(i).point1(1))
        llines(i).k=(llines(i).point2(2)-llines(i).point1(2))/(llines(i).point2(1)-llines(i).point1(1));
        llines(i).b=llines(i).point1(2)-llines(i).k*llines(i).point1(1);
    else
        llines(i).k=Inf;
        llines(i).b=Inf;
    end
end

    %llines=linegradient(I,llines);
    %for i=1:length(line_ends)
        %[llines(i).pleft, llines(i).pright,llines(i).line_cn]=addcharapsrect(llines(i),f(1:2,:),matches_points,1:length(matches_points),s);
    %end
    pointlist=intspoints(llines,imsize);
end

function  [pleft, pright,line_cn] = addcharapsrect(line,f,matches,inlier_all,s)
d2line=0.5;
d2midline=0.5;
pleft=[];ppleft=[];
pright=[]; ppright=[];
line_cn=zeros(1,6);
mid=(line.point1+line.point2)/2;
pg=mid+line.gradient;
linelen= norm(line.point1-line.point2);

midline=line;
midline.mid=mid;
if line.k ~=0
    midline.k = -1/line.k;
    if line.k == Inf
        midline.b=line.point1(1);
    else
        midline.b=(line.k * midline.mid(2) + midline.mid(1))/line.k;
    end
else
    midline.k=Inf;
    midline.b=Inf;
end

pointnum=length(inlier_all);

for i=1:pointnum
    p=f(:,matches(s,inlier_all(i)));
    if disp2line(p,line) < d2line * linelen && disp2line(p,midline) < d2midline * linelen
        if sameside(line,p,pg)
            pright=[ pright; inlier_all(i) ];
            ppright=[ppright;matches(s,inlier_all(i))];
        else
            pleft=[ pleft; inlier_all(i) ];
            ppleft=[ppleft; matches(s,inlier_all(i))];
        end 
    end 
end

if s==2
    
end
if ~isempty(ppleft)
    line_cn(1:2)=mean(f(:,ppleft),2)';
end
if ~isempty(ppright)
    line_cn(3:4)=mean(f(:,ppright),2)';
end
    line_cn(5:6)=mid;
end

function dis=disp2line(point,line)%特征点和线距离
k=line.k;
b=line.b;
if k~=Inf
    dis=abs(k*point(1)-point(2)+b)/sqrt(k*k+1);
else
    dis = abs(point(1)-line.point1(1));
end
end
