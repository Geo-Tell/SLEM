function [lines1,linepairs1,lines2,linepairs2]=import_lines()
%lines: n*4 struct;endpoints of the line,k,b;
%linepairs: n*4 array ;(x,y,ind1,ind2);point of the intersection and the
%indexs of the two intersectant lines
t1=cputime;
global IO

lines1=importdata(strcat(IO.data_path,IO.img_name,'\','lsd1.txt'));
lines2=importdata(strcat(IO.data_path,IO.img_name,'\','lsd2.txt'));

[lines1,linepairs1]=getLinePairs(lines1);
[lines2,linepairs2]=getLinePairs(lines2);
t2=cputime-t1;
disp(strcat('The Line Segments Loading and LinePairs Calculation take :',num2str(t2),'s'))
end


