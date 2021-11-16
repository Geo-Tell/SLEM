function [handle_a, handle_b]=  display_matches_block(Ia, Ib, matches, fa, fb, saveTheFigure)

if ischar(Ia)
    Ia=imread(Ia);
    Ib=imread(Ib);
end

if size(Ia,1)> size(Ib,1)
    Ib(size(Ia,1), size(Ib,2), size(Ib,3))=0;
else
    Ia(size(Ib,1), size(Ia,2), size(Ia,3))=0;
end;


ey=0:80:size(Ia,1);
ey=[ey,size(Ia,1)];
ex=0:160:size(Ia,2);
ex=[ex,size(Ia,2)];

xa = fa(1,matches(1,:)) ;
xb = fb(1,matches(2,:))  ;
ya = fa(2,matches(1,:)) ;
yb = fb(2,matches(2,:)) + size(Ia,1);

for i=1:(length(ey)-1)
    for j=1:(length(ex)-1)
        if ~isempty(find(xa>ex(j)&xa<=ex(j+1)&ya>ey(i)&ya<=ey(i+1)))
            figure,
            handle_a=imshow(cat(1, Ia, Ib)) ;
            xxa = xa(find(xa>ex(j)&xa<=ex(j+1)&ya>ey(i)&ya<=ey(i+1)));
            xxb = xb(find(xa>ex(j)&xa<=ex(j+1)&ya>ey(i)&ya<=ey(i+1))) ;
            yya = ya(find(xa>ex(j)&xa<=ex(j+1)&ya>ey(i)&ya<=ey(i+1))) ;
            yyb = yb(find(xa>ex(j)&xa<=ex(j+1)&ya>ey(i)&ya<=ey(i+1))) ;
            hold on ;
            h = line([xxa ; xxb], [yya ; yyb]) ;
            set(h,'linewidth', 0.1, 'color', 'b') ;
            title([num2str(j),' ',num2str(i)])


        vl_plotframe([xxa;yya]) ;
        vl_plotframe([xxb;yyb]) ;
        axis image off ;
        
%         figure;
%         handle_b=imshow(cat(1, Ia, Ib)) ;
%         
% %         xa = fa(1,matches(1,:)) ;
% %         xb = fb(1,matches(2,:))  ;
% %         ya = fa(2,matches(1,:)) ;
% %         yb = fb(2,matches(2,:)) + size(Ia,1);
%         
%         lbl = strtrim(cellstr(num2str((1:length(find(xa>ex(j)&xa<=ex(j+1)&ya>ey(i)&ya<=ey(i+1))))')));
%         text(xxa, yya, lbl(:),'color','w');
%         text(xxb, yyb, lbl(:),'color','w');
        
        if exist('saveTheFigure', 'var')
            saveas(handle_a,strcat('result\',num2str(i),'_',num2str(j),'_a'),'jpg');
            saveas(handle_b,strcat('result\',num2str(i),'_',num2str(j),'_b'),'jpg');
        end
        end
        close all
    end
end

