%从txt中获取直线段匹配真值
%直线段检测方式为LSD和ED
%Gtm1为n对n的元胞数组
%Gtm2为将Gtm1华为

clear;clc;
Gt_M_o1=importdata('lsd_GroundTruthMatches.txt');
%Gt_M_o2=importdata('ed_GroundTruthMatches.txt');
Lsd_N_Total1=0;
Lsd_N_Total2=0;
%Ed_N_Total=0;

len1=length(Gt_M_o1);
%len3=length(Gt_M_o2);

lsd_Gt_M=cell(len1,2);
%ed_Gt_M=cell(len3,2);

for i=1:len1
    x=Gt_M_o1{i};
    len2=length(x);
    x1=1;x2=find(x=='(', 1, 'last' );
    y1=find(x==')',1,'first');
    y2=find(x==')',1,'last' );
    z1=find(x(1:y1)==',');
    z2=find(x(x2:y2)==',')+x2-1;
    z1=[x1,z1,y1];z2=[x2,z2,y2];
    for j=1:length(z1)-1
        lsd_Gt_M{i,1}=[lsd_Gt_M{i,1},str2double(x(z1(j)+1:z1(j+1)-1))+1];
    end
    
    for j=1:length(z2)-1
        lsd_Gt_M{i,2}=[lsd_Gt_M{i,2},str2double(x(z2(j)+1:z2(j+1)-1))+1];
    end
end

lsd_Gt_M_new=lsd_Gt_M;

for i=1:length(lsd_Gt_M_new)
    if i>length(lsd_Gt_M_new)
        break
    end
    x1=lsd_Gt_M_new{i,1};
    y1=lsd_Gt_M_new{i,2};
    for j=i+1:length(lsd_Gt_M_new)
        if j>length(lsd_Gt_M_new)
            continue
        end
        x2=lsd_Gt_M_new{j,1};
        y2=lsd_Gt_M_new{j,2};
        if isempty(intersect(x1,x2))&&isempty(intersect(y1,y2))
            continue;
        else
            temp1=unique([x1,x2]);
            temp2=unique([y1,y2]);
            lsd_Gt_M_new{i,1}=temp1;
            lsd_Gt_M_new{i,2}=temp2;
            lsd_Gt_M_new(j,:)=[];
        end
    end
end

lsd_Gt_M_old=lsd_Gt_M;
lsd_Gt_M=lsd_Gt_M_new;

% for i=1:len3
%     x=Gt_M_o2{i};
%     len4=length(x);
%     x1=1;x2=find(x=='(', 1, 'last' );
%     y1=find(x==')',1,'first');
%     y2=find(x==')',1,'last' );
%     z1=find(x(1:y1)==',');
%     z2=find(x(x2:y2)==',')+x2-1;
%     z1=[x1,z1,y1];z2=[x2,z2,y2];
%     for j=1:length(z1)-1
%         ed_Gt_M{i,1}=[ed_Gt_M{i,1},str2double(x(z1(j)+1:z1(j+1)-1))];
%     end
%     
%     for j=1:length(z2)-1
%         ed_Gt_M{i,2}=[ed_Gt_M{i,2},str2double(x(z2(j)+1:z2(j+1)-1))];
%     end
% end

lsd_matches_g=[];
%ed_matches_g=[];

for i=1:length(lsd_Gt_M)
    Lsd_N_Total1=Lsd_N_Total1+length(lsd_Gt_M{i,1});
   Lsd_N_Total2=Lsd_N_Total2+length(lsd_Gt_M{i,2});
    for m=1:length(lsd_Gt_M{i,1})
        for n=1:length(lsd_Gt_M{i,2})
            lsd_matches_g=[lsd_matches_g;lsd_Gt_M{i,1}(m),lsd_Gt_M{i,2}(n)];
        end
    end
end

% for i=1:length(ed_Gt_M)
%     Ed_N_Total=Ed_N_Total+min(length(ed_Gt_M{i,1}),length(ed_Gt_M{i,2}));
%     for m=1:length(ed_Gt_M{i,1})
%         for n=1:length(ed_Gt_M{i,2})
%             ed_matches_g=[ed_matches_g;ed_Gt_M{i,1}(m),ed_Gt_M{i,2}(n)];
%         end
%     end
% end
Lsd_Gtm1=lsd_Gt_M;
%Ed_Gtm1=ed_Gt_M;
Lsd_Gtm2=lsd_matches_g;
%Ed_Gtm2=ed_matches_g;

save('Lsd_Gtm1.mat','Lsd_Gtm1');
%save('Ed_Gtm1.mat','Ed_Gtm1');

save('Lsd_Gtm2.mat','Lsd_Gtm2');
%save('Ed_Gtm2.mat','Ed_Gtm2');

save('Lsd_N_Total1.mat','Lsd_N_Total1')
save('Lsd_N_Total2.mat','Lsd_N_Total2')
%save('Ed_N_Total.mat','Ed_N_Total')

