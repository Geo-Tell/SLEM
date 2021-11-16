function [llines]=linesGetEnd(lines)
if isstruct(lines)
    llines=zeros(length(lines),4);
    for i=1:length(lines)
        llines(i,1:2)=lines(i).point1;
        llines(i,3:4)=lines(i).point2;
    end
else
    llines=lines;
end

end