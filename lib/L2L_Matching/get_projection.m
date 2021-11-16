function H=get_projection(point,w,p)
num=length(p);
W=reshape(w(1:8*num),num,8);
a=w(8*num+1:8*num+8);
G1=G_compute_fast(point', p, 1);
h=zeros(1,8);

for i=1:8
    h(i)=a(i)+G1*W(:,i);
end
H=[h(1),h(2),h(3);h(4),h(5),h(6);h(7),h(8),1];

end