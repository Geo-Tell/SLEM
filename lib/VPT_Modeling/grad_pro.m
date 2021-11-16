function [x,res]=grad_pro(M_a, N_a, thres_a,  G_a,  lambda_a)

global M;
global N;
global thres;
global G;
global lambda;
global num;
global G_sparse
num=size(G_a,2);

M=M_a;
N=N_a;
thres=thres_a;
G=G_a;
lambda=lambda_a;

G_sparse = blkdiag(G,G,G,G,G,G,G,G);



big_M=cat(1, M, sqrt(lambda)*cat(2,G_sparse, zeros(8*num,8)));

big_N=cat(1, N, zeros(8*num,1));


xo=big_M\big_N;
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
global num;
global G_sparse;


e1=M*x-N;
e_sign1=sign(e1);
mask1=abs(e1)> thres;
e1(mask1)=sqrt(2*thres*abs(e1(mask1))-thres^2);
xx=reshape(x(1:8*num),num,8);
e2=G*xx;
e2=e2(:);


J1=M;
J1(mask1,:)=0.5*2*thres*diag(1./(e1(mask1).*e_sign1(mask1)))*M(mask1,:);

J2=sqrt(lambda)*cat(2,G_sparse, zeros(8*num,8));
e2=sqrt(lambda)*e2;


e=cat(1, e1, e2);

J=sparse(cat(1, J1, J2));
end