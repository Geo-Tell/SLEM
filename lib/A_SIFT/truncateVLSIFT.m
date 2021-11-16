function des_t = truncateVLSIFT(des, thresh)

des = double(des);
des = des ./ repmat(sqrt(sum(des.^2, 1)), 128, 1);
des(des > thresh) = thresh;
des = des ./ repmat(sqrt(sum(des.^2, 1)), 128, 1);

des_t = single(des);