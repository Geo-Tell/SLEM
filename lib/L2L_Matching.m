function [I]=L2L_Matching(f1,lines1,linepairs1,f2,lines2,linepairs2,i_cor_linepairs,w,T_a,T_b,matches_points,basic_points)
%COR_LP_VERIFICATION 此处显示有关此函数的摘要
%   此处显示详细说明
t1=cputime;
global IO L2LM

vote_matrix1=zeros(size(lines1,2),size(lines2,2));
counting_matrix1=zeros(size(lines1,2),size(lines2,2));
vote_matrix2=zeros(size(lines1,2),size(lines2,2));
counting_matrix2=zeros(size(lines1,2),size(lines2,2));
llines1=linesGetEnd(lines1);
llines2=linesGetEnd(lines2);
Ia=imread(strcat(IO.data_path,IO.img_name,'\1.png'));
Ib=imread(strcat(IO.data_path,IO.img_name,'\2.png'));


for i=1:length(i_cor_linepairs)
    if isempty(i_cor_linepairs{i})
        continue
    end
    
    ff2=linepairs2(i_cor_linepairs{i},1:2)';
    l2_index=linepairs2(i_cor_linepairs{i},3:4);
    ff1=repmat(linepairs1(i,1:2)',1,size(ff2,2));
    [project_verify,~,H,invH]=project_intpoints_verification(f1(1:2, matches_points(1,:)),f2(1:2, matches_points(2,:)),T_a, T_b,ff1,ff2,w,basic_points);
    
    if isempty(project_verify)
        continue
    end
    
    l1_index=linepairs1(i,3:4);
    l2_index=l2_index(project_verify,:);
    
    %         display_project_linepairs(img1_path,img2_path,project_verify,ff1,ff2,lines1,lines2,l1_index,l2_index,linepairs1,linepairs2,x_hat,y_hat,H,i_cor_linepairs,T_a,T_b,i)
    %         close all
    
    
    for k=1:length(project_verify)
        xyz1 = H{k}*T_a*[llines1(l1_index(1),1:2),1; llines1(l1_index(1),3:4),1]';
        xyz1=cat(2,[xyz1(1:2,1)/xyz1(3,1);1],[xyz1(1:2,2)/xyz1(3,2);1]);
        xyz1=T_b\xyz1;
        over_lapping1=zeros(1,2);
        over_lapping2=zeros(1,2);
        dist1=zeros(1,2);
        dist2=zeros(1,2);
        for j=1:2
            [over_lapping1(j),dist1(j)]=cal_lines_overlapping_dist([xyz1(1:2,1);xyz1(1:2,2)]',llines2(l2_index(k,j),1:4));
        end
        xyz2 = H{k}*T_a*[llines1(l1_index(2),1:2),1; llines1(l1_index(2),3:4),1]';
        xyz2=cat(2,[xyz2(1:2,1)/xyz2(3,1);1],[xyz2(1:2,2)/xyz2(3,2);1]);
        xyz2=T_b\xyz2;
        for j=1:2
            
            [over_lapping2(j),dist2(j)]=cal_lines_overlapping_dist([xyz2(1:2,1);xyz2(1:2,2)]',llines2(l2_index(k,j),1:4));
            
        end
        dist1(over_lapping1<L2LM.o)=0;
        dist2(over_lapping2<L2LM.o)=0;
        dist1(dist1<L2LM.d)=0;
        dist2(dist2<L2LM.d)=0;
        
        
        if dist1(1)>dist2(1)&&dist1(1)>dist1(2)
            vote_matrix1(l1_index(1),l2_index(k,1))=vote_matrix1(l1_index(1),l2_index(k,1))+dist1(1);
            counting_matrix1(l1_index(1),l2_index(k,1))=counting_matrix1(l1_index(1),l2_index(k,1))+1;
        elseif dist1(2)>dist1(1)&&dist1(2)>dist2(2)
            vote_matrix1(l1_index(1),l2_index(k,2))=vote_matrix1(l1_index(1),l2_index(k,2))+dist1(2);
            counting_matrix1(l1_index(1),l2_index(k,2))= counting_matrix1(l1_index(1),l2_index(k,2))+1;
        elseif dist2(1)>dist1(1)&&dist2(1)>dist2(2)
            vote_matrix1(l1_index(2),l2_index(k,1))=vote_matrix1(l1_index(2),l2_index(k,1))+dist2(1);
            counting_matrix1(l1_index(2),l2_index(k,1))= counting_matrix1(l1_index(2),l2_index(k,1))+1;
        elseif dist2(2)>dist1(2)&&dist2(2)>dist2(1)
            vote_matrix1(l1_index(2),l2_index(k,2))=vote_matrix1(l1_index(2),l2_index(k,2))+dist2(2);
            counting_matrix1(l1_index(2),l2_index(k,2))= counting_matrix1(l1_index(2),l2_index(k,2))+1;
        end
        
        
        xyz1 = invH{k}*T_b*[llines2(l2_index(k,1),1:2),1; llines2(l2_index(k,1),3:4),1]';
        xyz1=cat(2,[xyz1(1:2,1)/xyz1(3,1);1],[xyz1(1:2,2)/xyz1(3,2);1]);
        xyz1=T_a\xyz1;
        over_lapping1=zeros(1,2);
        over_lapping2=zeros(1,2);
        dist1=zeros(1,2);
        dist2=zeros(1,2);
        for j=1:2
            [over_lapping1(j),dist1(j)]=cal_lines_overlapping_dist([xyz1(1:2,1);xyz1(1:2,2)]',llines1(l1_index(j),1:4));
        end
        xyz2 = invH{k}*T_b*[llines2(l2_index(k,2),1:2),1; llines2(l2_index(k,2),3:4),1]';
        xyz2=cat(2,[xyz2(1:2,1)/xyz2(3,1);1],[xyz2(1:2,2)/xyz2(3,2);1]);
        xyz2=T_a\xyz2;
        for j=1:2
            
            [over_lapping2(j),dist2(j)]=cal_lines_overlapping_dist([xyz2(1:2,1);xyz2(1:2,2)]',llines1(l1_index(j),1:4));
            
        end
        dist1(over_lapping1<L2LM.o)=0;
        dist2(over_lapping2<L2LM.o)=0;
        dist1(dist1<L2LM.d)=0;
        dist2(dist2<L2LM.d)=0;
        
        
        if dist1(1)>dist2(1)&&dist1(1)>dist1(2)
            vote_matrix2(l1_index(1),l2_index(k,1))=vote_matrix2(l1_index(1),l2_index(k,1))+dist1(1);
            counting_matrix2(l1_index(1),l2_index(k,1))=counting_matrix2(l1_index(1),l2_index(k,1))+1;
        elseif dist1(2)>dist1(1)&&dist1(2)>dist2(2)
            vote_matrix2(l1_index(2),l2_index(k,1))=vote_matrix2(l1_index(2),l2_index(k,1))+dist1(2);
            counting_matrix2(l1_index(2),l2_index(k,1))= counting_matrix2(l1_index(2),l2_index(k,1))+1;
        elseif dist2(1)>dist1(1)&&dist2(1)>dist2(2)
            vote_matrix2(l1_index(1),l2_index(k,2))=vote_matrix2(l1_index(1),l2_index(k,2))+dist2(1);
            counting_matrix2(l1_index(1),l2_index(k,2))= counting_matrix2(l1_index(1),l2_index(k,2))+1;
        elseif dist2(2)>dist1(2)&&dist2(2)>dist2(1)
            vote_matrix2(l1_index(2),l2_index(k,2))=vote_matrix2(l1_index(2),l2_index(k,2))+dist2(2);
            counting_matrix2(l1_index(2),l2_index(k,2))= counting_matrix2(l1_index(2),l2_index(k,2))+1;
        end
        
        
    end
end

I11=[];

llines1=linesGetEnd(lines1);
llines2=linesGetEnd(lines2);

for i=1:size(vote_matrix1,1)
  ind=find(vote_matrix1(i,:));
  if length(ind)>1
      I11=check_collinear(ind,lines2,llines2,vote_matrix1(i,ind),I11,i);
  elseif length(ind)==1
      I11=[I11;i,ind];
  end
end
I2=[];
for i=1:size(vote_matrix2,2)
  ind=find(vote_matrix2(:,i));
  if length(ind)>1
      I2=check_collinear(ind,lines1,llines1,vote_matrix2(ind,i),I2,i);
  elseif length(ind)==1
      I2=[I2;i,ind];
  end
end
I22=[I2(:,2),I2(:,1)];
%I=unique([I11;I22],'row');        
I=intersect(I11,I22,'rows');

t2=cputime-t1;
disp(['The L2L Matching takes :',num2str(t2),'s'])

