function [] = display_project_linepairs(img1_path,img2_path,project_verify,ff1,ff2,lines1,lines2,l1_index,l2_index,linepairs1,linepairs2,x_hat,y_hat,H,candidate_linepairs,T_a,T_b,i)
%DISPLAY_PROJECT_LINEPAIRS 此处显示有关此函数的摘要
%   此处显示详细说明
if ischar(img1_path)
    img1_path=imread(img1_path);img2_path=imread(img2_path);
end

llines1=linesGetEnd(lines1);
llines2=linesGetEnd(lines2);


imshow(cat(2, img1_path, img2_path)) ;
FigSize=get(0,'screensize');
set(gcf,'units','pixels','position',[0,0.5*FigSize(4),0.8*FigSize(3),0.3*FigSize(4)])



hold on

xy1 = [llines1(l1_index(1),1:2); llines1(l1_index(1),3:4)];
plot(xy1(:,1),xy1(:,2),'LineWidth',2,'Color','red');
text((xy1(1,1)+xy1(2,1))/2,(xy1(1,2)+xy1(2,2))/2,num2str(l1_index(1)),'color','white');
xy2 = [llines1(l1_index(2),1:2); llines1(l1_index(2),3:4)];
plot(xy2(:,1),xy2(:,2),'LineWidth',2,'Color','red');
text((xy2(1,1)+xy2(2,1))/2,(xy2(1,2)+xy2(2,2))/2,num2str(l1_index(2)),'color','white');
x1=linepairs1(i,1);y1=linepairs1(i,2);
plot(x1,y1,'+g','markersize',10);
text(x1,y1,num2str(i),'color','blue');
plot(x_hat+size(img1_path,2),y_hat,'r*','markersize',20);

for k = 1:length(project_verify)
    xy1 = [llines2(l2_index(k,1),1:2)+[size(img1_path,2),0]; llines2(l2_index(k,1),3:4)+[size(img1_path,2),0]];
    plot(xy1(:,1),xy1(:,2),'LineWidth',2,'Color','red');
    text((xy1(1,1)+xy1(2,1))/2,(xy1(1,2)+xy1(2,2))/2,num2str(l2_index(k,1)),'color','white');
    x1=ff2(1,project_verify(k))+size(img1_path,2);y1=ff2(2,project_verify(k));
    plot(x1,y1,'+g','markersize',10);
    text(x1,y1,num2str(k),'color','blue');
    xy2 = [llines2(l2_index(k,2),1:2)+[size(img1_path,2),0]; llines2(l2_index(k,2),3:4)+[size(img1_path,2),0]];
    plot(xy2(:,1),xy2(:,2),'LineWidth',2,'Color','red');
    text((xy2(1,1)+xy2(2,1))/2,(xy2(1,2)+xy2(2,2))/2,num2str(l2_index(k,2)),'color','white');
end

hold off

figure
handle_a=imshow(cat(2, img1_path, img2_path)) ;
hold on
set(gcf,'units','pixels','position',[0,0.2*FigSize(4),0.8*FigSize(3),0.3*FigSize(4)])


xy1 = [llines1(l1_index(1),1:2); llines1(l1_index(1),3:4)];
plot(xy1(:,1),xy1(:,2),'LineWidth',2,'Color','red');
text((xy1(1,1)+xy1(2,1))/2,(xy1(1,2)+xy1(2,2))/2,num2str(l1_index(1)),'color','white');
xy2 = [llines1(l1_index(2),1:2); llines1(l1_index(2),3:4)];
plot(xy2(:,1),xy2(:,2),'LineWidth',2,'Color','red');
text((xy2(1,1)+xy2(2,1))/2,(xy2(1,2)+xy2(2,2))/2,num2str(l1_index(2)),'color','white');
x1=linepairs1(i,1);y1=linepairs1(i,2);
plot(x1,y1,'+g','markersize',10);
text(x1,y1,num2str(i),'color','blue');

for k=1:length(project_verify)
    xyz3 = H{k}*T_a*[linepairs1(i,1:2),1]';
    xyz3 =[xyz3(1:2,1)/xyz3(3,1);1];
    xyz3 =inv(T_b)*xyz3;
    xy3 = xyz3(1:2,:)+[size(img1_path,2),0]';
    plot(xy3(1),xy3(2),'r*','markersize',20);
    text(xy3(1),xy3(2),num2str(k),'color','blue');
    
    xyz1 = H{k}*T_a*[llines1(l1_index(1),1:2),1; llines1(l1_index(1),3:4),1]';
    xyz1=cat(2,[xyz1(1:2,1)/xyz1(3,1);1],[xyz1(1:2,2)/xyz1(3,2);1]);
    xyz1=inv(T_b)*xyz1;
    xy1=xyz1(1:2,:)'+[size(img1_path,2),0;size(img1_path,2),0];
    plot(xy1(:,1),xy1(:,2),'LineWidth',3,'Color','yellow');
    text((xy1(1,1)+xy1(2,1))/2,(xy1(1,2)+xy1(2,2))/2,num2str(l1_index(1)),'color','white');
    xyz2 = H{k}*T_a*[llines1(l1_index(2),1:2),1; llines1(l1_index(2),3:4),1]';
    xyz2=cat(2,[xyz2(1:2,1)/xyz2(3,1);1],[xyz2(1:2,2)/xyz2(3,2);1]);
    xyz2=inv(T_b)*xyz2;
    xy2=xyz2(1:2,:)'+[size(img1_path,2),0;size(img1_path,2),0];
    plot(xy2(:,1),xy2(:,2),'LineWidth',3,'Color','yellow');
    text((xy2(1,1)+xy2(2,1))/2,(xy2(1,2)+xy2(2,2))/2,num2str(l1_index(2)),'color','white');
end

for i=1:length(lines2)
     xy4 = [lines2(i).point1; lines2(i).point2]+[size(img1_path,2),0;size(img1_path,2),0];
     plot(xy4(:,1),xy4(:,2),'LineWidth',1,'Color','red');
end

