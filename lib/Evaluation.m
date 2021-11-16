function [correct_sample]=Evaluation(matches_lines)
%EVALUATION 此处显示有关此函数的摘要
%   此处显示详细说明
global IO
load(strcat(IO.data_path,IO.img_name,'\','Lsd_Gtm1.mat'));
load(strcat(IO.data_path,IO.img_name,'\','Lsd_N_Total.mat'));

g_t=Lsd_Gtm1;
ntotal=Lsd_N_Total;

TP=zeros(length(g_t)+1,1);
correct_sample=[];
for i=1:length(g_t)
    tp=0;
    t1=g_t{i,1};
    t2=g_t{i,2};
    for j=1:size(matches_lines,1)
        l1=matches_lines(j,1);
        l2=matches_lines(j,2);
        switch 10*sum(l1==t1)+sum(l2==t2)
            case 11
                tp=tp+1;
                correct_sample=[correct_sample;matches_lines(j,:)];
        end
    end  
    TP(i+1)=tp;
end

T=length(matches_lines);
P=size(correct_sample,1)/length(matches_lines);
R=size(correct_sample,1)/ntotal;
F_score=2*P*R/(P+R);

IO.Evaluation=[IO.Evaluation;{IO.img_name,P,R,T,F_score}];
disp({IO.img_name,P,R,T,F_score})
end

