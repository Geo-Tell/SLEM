function [] = result_write()
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
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
