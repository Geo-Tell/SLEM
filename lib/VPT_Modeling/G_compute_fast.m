function [G]=G_compute_fast(X, Y, dist_scale)

G = vl_alldist(X,Y);
%G=G.^2;
G=exp(-dist_scale*G);