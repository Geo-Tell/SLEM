function [] = result_write()
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
global IO
fileID = fopen(strcat(pwd,'\result\Result.txt'),'w');
formatSpec0 = '%s %s %s %s %s\n';
formatSpec = '%s %f %f %d %f\n';
[nrows,~]=size(IO.Evaluation);
fprintf(fileID,formatSpec0,IO.Evaluation{1,:});

for row = 2 : nrows
    fprintf(fileID,formatSpec,IO.Evaluation{row,:});
end

fclose(fileID)
