function [] = SLEM()
%A-SIFT Matching
[f1,~,f2,~,matches_points,matches_points_all]=A_SIFT();
% display_matches_points(strcat(IO.data_path,IO.img_name,'\1.png'),...
%     strcat(IO.data_path,IO.img_name,'\2.png'),matches_points(:,basic_points),f1,f2)

%Line Segments Loading and LinePairs Calculation
[lines1,linepairs1,lines2,linepairs2]=import_lines();

%Varying Projective Transformation Modeling
%Part of the code is from the citation ¡¶Code: Coherence based decision
%boundaries for feature correspondence¡·
%w:parameters of the VPT model£»
%matches,matches_all: the filtered correspondences by the coherent model
%inlier£¬inlier_all: the filtered correspondeces by the VPT model
%basic_point: the indexes of the basic points for the VPT model
%T_a,T_b: the transformation matrix of the normalization for the point
%coordinates
[w,~,inlier_all,matches_points,matches_points_all,basic_points,T_a,T_b]=VPT_Modeling(f1,f2,matches_points,matches_points_all);

%Initialization for Correspondence of LinePairs 
[i_cor_linepairs]=Cor_LP_Initialization(linepairs1,linepairs2,matches_points_all,inlier_all,f1,f2);

%L2L Matching
[matches_lines]=L2L_Matching(f1,lines1,linepairs1,f2,lines2,linepairs2,i_cor_linepairs,w,T_a,T_b,matches_points,basic_points);

%Evaluation and Output
[correct_sample]=Evaluation(matches_lines);
Output(matches_lines,correct_sample,lines1,lines2)
end

