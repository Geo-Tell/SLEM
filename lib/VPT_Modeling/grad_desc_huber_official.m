function [k, G_ori]=grad_desc_huber_official(x, y, dist_scale, s_scale, thres)



[G]=G_compute_fast(x', x', dist_scale);%计算论文中的G矩阵
G(G<0.1)=0; %makes it sparse (not utilized here though)
G_ori=G;

M=zeros(size(x,1), size(x,1));
N=zeros(size(x,1),1);

for i=1:size(x,1)
    M(i,:)=G(i,:);
    N(i)=y(i);
end;
M=M*s_scale;
N=N*s_scale;
n=size(M,2);

try
    [u,s,v]=svd(G);
catch
    
    
    G=G+0.00001*randn(size(G));
    [u,s,v]=svd(G); %sometimes svd goes crasy
end;

G_half=sqrt(s)*v';
G=G_half;

MM=M;
NN=N;
GG=G;

[k,res]=grad_1d(MM, NN, thres,  GG,  1);







