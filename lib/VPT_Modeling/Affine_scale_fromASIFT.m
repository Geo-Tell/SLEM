% by right, affine should include a scale term lambda, but here we only
% compute a rotation without the scale factor, not really an affine
% the scale is computed seperately in S
function [A, S] = Affine_scale_fromASIFT(param4)

A = zeros(size(param4, 1), 4);  


% cos_psi = cos(param4(:, 2));% this is correct +
% sin_psi = sin(param4(:, 2));
% % param4(:, 3), param4(:, 4) are from simulated image to original image
% t = 1./param4(:, 3); % this is probably correct inverse
% cos_phi = cos(param4(:, 4)); % this have not checked +
% sin_phi = sin(param4(:, 4));

%ΪʲôҪ���ţ�
%param4�ڶ������������direction�ʹ����ʲô��ϵ������ȷ�ϣ�
%�����������ڰ�ģ�������ɢ�ֿ��ı�ţ�������Ϊ��б�Ⱥ�t����
%�йأ��������С���й�
% reverse��ΪʲôҪת�ã�
cos_psi = cos(-param4(:, 2));% this is correct -
sin_psi = sin(-param4(:, 2));
% param4(:, 3), param4(:, 4) are from simulated image to original image
t = param4(:, 3); % this is probably correct upright
cos_phi = cos(-param4(:, 4)); % this have not checked -
sin_phi = sin(-param4(:, 4));


A(:, 1) = cos_psi.*t.*cos_phi + (-sin_psi).*sin_phi;
A(:, 2) = cos_psi.*t.*(-sin_phi) + (-sin_psi).*cos_phi;
A(:, 3) = sin_psi.*t.*cos_phi + cos_psi.*sin_phi;
A(:, 4) = sin_psi.*t.*(-sin_phi) + cos_psi.*cos_phi;

% [A(1) A(2)
% A(3) A(4)]


S=param4(:,1); 
% put in the scale lambda
% A(:, 1) = A(:, 1) .* param4(:, 1);
% A(:, 2) = A(:, 2) .* param4(:, 1);
% A(:, 3) = A(:, 3) .* param4(:, 1);
% A(:, 4) = A(:, 4) .* param4(:, 1);