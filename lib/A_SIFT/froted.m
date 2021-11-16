% wrapper to call mex_frot

function I_r = froted(I, theta)

% convert I to row major order which is used by asift
I_row_major = reshape(I', size(I));

I_r = mex_frot(I_row_major, single(theta));


% convert I_t back to column order
I_r = reshape(I_r, size(I_r, 2), size(I_r, 1))';