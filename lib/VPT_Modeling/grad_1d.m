function [x,res]=grad_1d(M_a, N_a, thres_a,  G_a,  lambda_a)
%M_a=G*s_scale;N_a=scale(Nx1);G_a=sqrt(s)*v'
global M;
global N;
global thres;
global G;
global lambda;

M=M_a;
N=N_a;
thres=thres_a;
G=G_a;
lambda=lambda_a;

big_M=cat(1, M, sqrt(lambda)*G);%按行合并

big_N=cat(1, N, zeros(size(G,1),1));


xo=big_M\big_N; %迭代初值



options = optimset('Jacobian','on', 'display', 'off');

x = lsqnonlin(@myfun,xo, [], [], options);

res=M*x-N;
end

function [e, J]=myfun(x)

global M;
global N;
global thres;
global G;
global lambda;

e1=M*x-N;
e_sign1=sign(e1);
mask1=abs(e1)> thres;
e1(mask1)=sqrt(2*thres*abs(e1(mask1))-thres^2);

e2=G*x;


J1=M;
J1(mask1,:)=thres*diag(1./(e1(mask1).*e_sign1(mask1)))*M(mask1,:);

J2=sqrt(lambda)*G;
e2=sqrt(lambda)*e2;


e=cat(1, e1, e2);

J=sparse(cat(1, J1, J2));
end


