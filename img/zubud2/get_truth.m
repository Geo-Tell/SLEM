
Ia='1.png';
Ib='2.png';

if ischar(Ia)
    Ia=imread(Ia);
    Ib=imread(Ib);
end

lines1=importdata('lsd1.txt');
lines2=importdata('lsd2.txt');


FigSize=get(0,'screensize');

fig2=figure;
imshow(Ib);
set(gcf,'units','pixels','position',[0,0.2*FigSize(4),0.8*FigSize(3),0.3*FigSize(4)])
hold on
for p=1:length(lines2)
    xy1 = [lines2(p,1:2); lines2(p,3:4)];
    plot(xy1(:,1),xy1(:,2),'LineWidth',2,'Color','red');
    text((xy1(1,1)+xy1(2,1))/2,(xy1(1,2)+xy1(2,2))/2,num2str(p-1),'color','white');
end
hold off

for i=402:length(lines1)
    fig1=figure;
    imshow(Ia) ;
    set(gcf,'units','pixels','position',[0,0.5*FigSize(4),0.8*FigSize(3),0.3*FigSize(4)])
    hold on
    xy1 = [lines1(i,1:2); lines1(i,3:4)];
    plot(xy1(:,1),xy1(:,2),'LineWidth',2,'Color','red');
    text((xy1(1,1)+xy1(2,1))/2,(xy1(1,2)+xy1(2,2))/2,num2str(i-1),'color','white');
    hold off
    close(fig1)
end
         
            

            