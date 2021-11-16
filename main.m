clear all;clc;
dbstop if error
addpath(genpath(pwd));
Config();
global IO

for i=1:length(IO.data_names)
    IO.img_name=IO.data_names{i};
    disp(['SLEM in ',IO.img_name])
    SLEM();
    
%     matches_lines=textread(strcat(IO.data_path,IO.img_name,'\our_result.txt'));
%     [correct_sample]=Evaluation(matches_lines);
end

result_write();




