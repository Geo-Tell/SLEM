function []=Config()
%IO
global IO
global AS
global LPG
global Modeling
global L2LM

IO.data_path=strcat(pwd,'\img\');

IO.output_path=strcat(pwd,'\result\');
list=dir(fullfile(IO.data_path));
list=list(3:end);
IO.data_names=cell(length(list),1);
IO.Evaluation={'Img','Precsion','Recall','Total_Number','F_score'};

for i=1:length(list)
    IO.data_names{i}=list(i).name;
end

%parameters in a-sift
AS.ratio_test=1.5;
[AS.V]=tilts_sample2(7); 

%parameters in generation of linepairs
LPG.d = 0.2;
LPG.theta = pi/18;

%parameters in modeling
Modeling.Nt=1000;
Modeling.Nr=2000;
Modeling.M=300;
Modeling.lambda_weight=1.1;
Modeling.gamma_radius=1;
Modeling.epsilon_likelyhood=0.01;
Modeling.epsilon_verification1=0.01;
Modeling.epsilon_verification2=0.05;

%parameters in L2L Matching
L2LM.d=0.1;
L2LM.o=0.5;
L2LM.Col_d=0.5;
L2LM.Col_theta=pi/18;
end