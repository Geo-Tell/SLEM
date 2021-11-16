function [] = display_matches_lines(img1_path,img2_path,lines1,lines2,matches1,matches2)
%DRAW_LINE 此处显示有关此函数的摘要
%   此处显示详细说明
figure,
if ischar(img2_path)
    Ia=imread(img1_path);
    Ib=imread(img2_path);
else
    Ia=img1_path;
    Ib=img2_path;
end

[h,w,~]=size(cat(1,Ia,Ib));
set(gcf,'position',[0 0 w h])
handle_a=imshow(cat(1, Ia, Ib),'border','tight','initialmagnification','fit');
if isstruct(lines1)
    lines1=linesGetEnd(lines1);
    lines2=linesGetEnd(lines2);
end

hold on


if ~isempty(matches1)
    for k = 1:size(matches1,1)
        %     color1=[rand,rand,rand];
        xy1 = [lines1(matches1(k,1),1:2); lines1(matches1(k,1),3:4)];
        plot(xy1(:,1),xy1(:,2),'LineWidth',0.8,'color','green');
        %     text((xy1(1,1)+xy1(2,1))/2,(xy1(1,2)+xy1(2,2))/2,num2str(k),'color','green');
        xy2 = [lines2(matches1(k,2),1:2)+[0,size(Ia,1)]; lines2(matches1(k,2),3:4)+[0,size(Ia,1)]];
        plot(xy2(:,1),xy2(:,2),'LineWidth',0.8,'color','green');
        %     text((xy2(1,1)+xy2(2,1))/2,(xy2(1,2)+xy2(2,2))/2,num2str(k),'color','green');
    end
end

if ~isempty(matches2)
    for k = 1:size(matches2,1)
        xy1 = [lines1(matches2(k,1),1:2); lines1(matches2(k,1),3:4)];
        plot(xy1(:,1),xy1(:,2),'LineWidth',0.8,'Color','red');
        %     text((xy1(1,1)+xy1(2,1))/2,(xy1(1,2)+xy1(2,2))/2,num2str(k),'color','red');
        xy2 = [lines2(matches2(k,2),1:2)+[0,size(Ia,1)]; lines2(matches2(k,2),3:4)+[0,size(Ia,1)]];
        plot(xy2(:,1),xy2(:,2),'LineWidth',0.8,'Color','red');
        %     text((xy2(1,1)+xy2(2,1))/2,(xy2(1,2)+xy2(2,2))/2,num2str(k),'color','red');
    end
    
    a=getframe(gcf);
    imm=frame2im(a);
    imm=imresize(imm,[h,w]);
    imwrite(imm,'test.png','png');
end
