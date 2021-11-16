function [V]=tilts_sample2(num_of_tilts)


t_min = 1;
t_k = sqrt(2.);

% calculate the number of simulations
t = t_min * t_k .^ ((1:num_of_tilts) - 1);
num_rot = round((5*t+1) / 2);
%num_rot = round((5*t+1)); % double the number to accomdate 360 turns

num_rot(1) = 1;
num_sim = sum(num_rot);

%disp([num2str(num_sim) ' simulations']);

V=zeros(num_sim,2);

runner=1;
% simulate tilts and rotations
for tt = 1:num_of_tilts
    % tilt
    t = t_min * t_k^(tt-1);
    delta_theta = pi / num_rot(tt); % note this is 360 instead of 180 in a-sift
    for rr = 1:num_rot(tt)
        V(runner,1)=t;
        V(runner,2)= delta_theta * (rr-1);
        runner=runner+1;
    end;
end;
