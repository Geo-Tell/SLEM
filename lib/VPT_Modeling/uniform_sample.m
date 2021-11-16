function [ind3] = uniform_sample(ind1,f1_old)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
global IO

[h,w,~]=size(imread(strcat(IO.data_path,IO.img_name,'\1.png')));

x1_interval=0:50:w;
x2_interval=50:50:w;

if length(x1_interval)~=length(x2_interval)
    x2_interval=[x2_interval,w];
end

y1_interval=0:50:h;
y2_interval=50:50:h;

if length(y1_interval)~=length(y2_interval)
    y2_interval=[y2_interval,h];
end

ind2=cell(length(x1_interval),length(y1_interval));
ind_all=cell(length(x1_interval),length(y1_interval));
ind_remain=cell(length(x1_interval),length(y1_interval));

%%divide the matches_coordinates according to the regions
for m=1:length(x1_interval)
    for n=1:length(y1_interval)
        for k=1:length(f1_old)
            x_temp=f1_old(1,k);
            y_temp=f1_old(2,k);
            if x_temp>=x1_interval(m)&&x_temp<x2_interval(m)...
                    &&y_temp>=y1_interval(n)&&y_temp<y2_interval(n)
                ind_all{m,n}=[ind_all{m,n},k];
            end
        end
    end
end

%%divide the ind1 according to the regions
for m=1:length(x1_interval)
    for n=1:length(y1_interval)
        for k=1:length(ind1)
            x_temp=f1_old(1,ind1(k));
            y_temp=f1_old(2,ind1(k));
            if x_temp>=x1_interval(m)&&x_temp<x2_interval(m)...
                    &&y_temp>=y1_interval(n)&&y_temp<y2_interval(n)
                ind2{m,n}=[ind2{m,n},ind1(k)];
            end
        end
    end
end

for m=1:length(x1_interval)
    for n=1:length(y1_interval)
        ind_remain{m,n}=setdiff(ind_all{m,n},ind2{m,n});
    end
end
        
for m=1:length(x1_interval)
    for n=1:length(y1_interval)
        if length(ind2{m,n})>=4
            continue
        else
            num_need=4-length(ind2{m,n});
        end
        if length(ind_remain{m,n})<=num_need
            ind2{m,n}=[ind2{m,n},ind_remain{m,n}];
        else
            ind_temp=ind_remain{m,n};
            ind2{m,n}=[ind2{m,n},ind_temp(randsample(length(ind_temp),num_need))];
        end
    end
end

ind3=[];
for m=1:length(x1_interval)
    for n=1:length(y1_interval)
        for k=1:length(ind2{m,n})
            
        ind3=[ind3,ind2{m,n}(k)];
        end
    end
end


end

