% wrapper to call mex_fproj

function I_t = fproj(I, t)

I_row_major = reshape(I', size(I));

I_t = mex_fproj(I_row_major, single(t));

% convert I_t back to column order
I_t = reshape(I_t, size(I_t, 2), size(I_t, 1))';