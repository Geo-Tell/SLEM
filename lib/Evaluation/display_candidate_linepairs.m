%展示F矩阵约束交点的候选点对
function []=display_candidate_linepairs(img1_path,img2_path,linepairs1,linepairs2,candidate_linepairs,lines1,lines2)

if ischar(img1_path)
    Ia=imread(img1_path);Ib=imread(img2_path);
end

    llines1=linesGetEnd(lines1);
    llines2=linesGetEnd(lines2);
    
for i=1:length(candidate_linepairs)
    if ~isempty(candidate_linepairs{i})
    aff_verify=candidate_linepairs{i};
    
    l1_index=linepairs1(i,3:4);
    l2_index=linepairs2(aff_verify,3:4);
    
    
    
    figure,
    handle_a=imshow(cat(2, Ia, Ib)) ;
    
    
    
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
%     plot(x_hat+size(Ia,2),y_hat,'r*','markersize',20);
    
    for k = 1:length(aff_verify)
        xy1 = [llines2(l2_index(k,1),1:2)+[size(Ia,2),0]; llines2(l2_index(k,1),3:4)+[size(Ia,2),0]];
        plot(xy1(:,1),xy1(:,2),'LineWidth',2,'Color','red');
        text((xy1(1,1)+xy1(2,1))/2,(xy1(1,2)+xy1(2,2))/2,num2str(l2_index(k,1)),'color','white');
        x1=linepairs2(aff_verify(k),1)+size(Ia,2);y1=linepairs2(aff_verify(k),2);
        plot(x1,y1,'+g','markersize',10);
        text(x1,y1,num2str(k),'color','blue');
        xy2 = [llines2(l2_index(k,2),1:2)+[size(Ia,2),0]; llines2(l2_index(k,2),3:4)+[size(Ia,2),0]];
        plot(xy2(:,1),xy2(:,2),'LineWidth',2,'Color','red');
        text((xy2(1,1)+xy2(2,1))/2,(xy2(1,2)+xy2(2,2))/2,num2str(l2_index(k,2)),'color','white');
    end
    break
    end


end

