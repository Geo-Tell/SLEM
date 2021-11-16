function I_tr = asift_simulate_image(I, t, theta)

GaussTruncate1 = 4.0;


% rotate I
I_r = froted(I, theta);
% anti-aliasing filtering along vertical direction
sigma = 1.6 * t / 2;
ksize = round(2.0 * GaussTruncate1 * sigma + 1.0);
ksize = max(3, ksize);
if mod(ksize, 2) == 0
    ksize = ksize + 1;
end
X = -ksize/2:ksize/2;
GAUSS = exp(-0.5*X.^2/(sigma^2));
% normalize kernel values to sum to 1.0
GAUSS = GAUSS / sum(GAUSS);
for col = 1:size(I_r, 2)
    I_r(:, col) = conv(I_r(:, col), GAUSS, 'same');
end
% tilt I_r
I_t = fproj(I_r, t);

I_tr = I_t;