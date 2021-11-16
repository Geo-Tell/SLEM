function [Ay2x]= getA_s_y2x_new(param1, param2)


%Affine_scale_fromASIFT����ͨ��Asift������
%3.3�Ĺ�ʽ���������A�ͳ߶�s����zoom �ˣ���
[A1, S1] = Affine_scale_fromASIFT(param1);
[A2, S2]= Affine_scale_fromASIFT(param2);
Ay2x = zeros(size(A1, 1), 4);
S=zeros(size(A1,1),1);
for i = 1:size(Ay2x)
    %Asift 3.4��ʽ�����һ��ͼƬ����һ��ͼƬ�ı任����Ainv(B)�����߶ȹ�һ
    Ay2x(i, :) = reshape((inv(reshape(A1(i, :), 2, 2)')*(reshape(A2(i, :), 2, 2)'))', 1, 4);
    S(i)=S2(i)/S1(i); % inverse scale
end

for i=1:size(Ay2x,1);
    Ay2x(i,:)=Ay2x(i,:)/S(i);
end;