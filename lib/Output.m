function [] = Output(I,correct_sample,lines1,lines2)
% display_block_matches(img1_path,img2_path,matches_points(:,basic_point),f1,f2)
% display_matches_points(img1_path,img2_path,matches_points(:,basic_point),f1,f2)
% display_matches_points(img1_path,img2_path,matches_points(:,basic_point),f1,f2)
% saveas(gcf,strcat('zubud\1to2_output\','points_matches_',data_name),'png');
% display_candidate_linepairs(img1_path,img2_path,linepairs1,linepairs2,candidate_linepairs,lines1,lines2)
% saveas(gcf,strcat('zubud\1to2_output\','epipolar_constraints_',data_name),'png');

global IO
if ~isempty(correct_sample)
I_error=setdiff(I,correct_sample,'row');
else
    I_error=I;
end

display_matches_lines(strcat(IO.data_path,IO.img_name,'\1.png'),...
    strcat(IO.data_path,IO.img_name,'\2.png'),lines1,lines2,correct_sample,I_error)
saveas(gcf,strcat('result\','line_matches_',IO.img_name),'png');
end

