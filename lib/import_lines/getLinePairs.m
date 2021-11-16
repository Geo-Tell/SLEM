function [llines,linepairs] = getLinePairs(lines)

for i=1:length(lines)
    llines(i).point1=[lines(i,1),lines(i,2)];
    llines(i).point2=[lines(i,3),lines(i,4)];
    
    if (llines(i).point2(1)~=llines(i).point1(1))
        llines(i).k=(llines(i).point2(2)-llines(i).point1(2))/(llines(i).point2(1)-llines(i).point1(1));
        llines(i).b=llines(i).point1(2)-llines(i).k*llines(i).point1(1);
    else
        llines(i).k=Inf;
        llines(i).b=Inf;
    end
end

pointlist=intspoints(llines);

for i=1:length(pointlist)
    linepairs(i,1:2)=pointlist(i).point;
    linepairs(i,3)=pointlist(i).lines(1);
    linepairs(i,4)=pointlist(i).lines(2);
end

end

