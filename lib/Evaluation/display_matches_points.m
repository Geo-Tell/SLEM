function [handle_a, handle_b]=  display_matches_points(Ia, Ib, matches, fa, fb, saveTheFigure)

if ischar(Ia)
    Ia=imread(Ia);
    Ib=imread(Ib);
end

if size(Ia,1)> size(Ib,1)
    Ib(size(Ia,1), size(Ib,2), size(Ib,3))=0;
else
    Ia(size(Ib,1), size(Ia,2), size(Ia,3))=0;
end
figure,
handle_a=imshow(cat(1, Ia, Ib)) ;

xa = fa(1,matches(1,:)) ;
xb = fb(1,matches(2,:))  ;
ya = fa(2,matches(1,:)) ;
yb = fb(2,matches(2,:)) + size(Ia,1);


hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 0.1, 'color', 'b') ;
% for i=1:size(matches,2)
%     figure,
%     handle_a=imshow(cat(2, Ia, Ib)) ;
%     hold on
%     h=line([xa(i) ; xb(i)], [ya(i) ; yb(i)]);
%     set(h,'linewidth',0.1,'color','b');
%     close 
% end

vl_plotframe(fa(1:2,matches(1,:))) ;
fb_s=fb;
offset=zeros(2,length(matches));
offset(2,:)=size(Ia,1);
vl_plotframe(fb_s(1:2,matches(2,:))+offset) ;
axis image off ;

% figure;
% handle_b=imshow(cat(1, Ia, Ib)) ;
% 
% xa = fa(1,matches(1,:)) ;
% xb = fb(1,matches(2,:))  ;
% ya = fa(2,matches(1,:)) ;
% yb = fb(2,matches(2,:)) + size(Ia,1);
% 
% lbl = strtrim(cellstr(num2str((1:size(matches,2))')));
% text(xa, ya, lbl(:),'color','w');
% text(xb, yb, lbl(:),'color','w');

if exist('saveTheFigure', 'var')
    saveas(handle_a,'result\all','jpg');
end

   % 'HorizontalAlignment','center','VerticalAlignment','middle');
% vl_plotframe(fa(:,matches(1,:))) ;
% fb_s=fb;
% fb_s(1,:) = fb(1,:) + size(Ia,2) ;
% vl_plotframe(fb_s(:,matches(2,:))) ;
axis image off ;
