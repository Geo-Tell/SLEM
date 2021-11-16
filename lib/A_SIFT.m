function [f1,d1,f2,d2,matches,matches_all] = A_SIFT()
t1=cputime;
global AS
global IO

I1rgb=imread(strcat(IO.data_path,IO.img_name,'\1.png'));

if size(I1rgb,3)==3
    I1 = single(rgb2gray(I1rgb));
else
    I1 = single(I1rgb);
end

I2rgb=imread(strcat(IO.data_path,IO.img_name,'\2.png'));
if size(I2rgb,3)==3
    I2 = single(rgb2gray(I2rgb));
else
    I2=single(I2rgb);
end

% d1 is the descritor
%f1= [x ,y scale, rotation, tilt(t), other_rot (phi)];
[f1, d1]=asift_tune_par(I1, AS.V);
[f2, d2]=asift_tune_par(I2, AS.V);

if strcmp(IO.img_name,'ubc')
    [f1, d1]=asift_tune_par_less(I1, AS.V);
    [f2, d2]=asift_tune_par_less(I2, AS.V);
end

d1 = truncateVLSIFT(d1, 0.2);
d2 = truncateVLSIFT(d2, 0.2);

if size(d2,2)==0
    matches=[];
    matches_all=[];
    D_o=[];
    return;
end
[matches, matches_all, D_o]=vl_match_complete(d1, d2, AS.ratio_test);
t2=cputime-t1;
disp(strcat('The A-SIFT matching takes :',num2str(t2),'s'))
end

