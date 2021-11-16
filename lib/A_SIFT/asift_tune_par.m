  % f is 6xN, each column represents coordinates, scale, orientation, tilt,
% rotation.
% d is 128xN SIFT descriptor
% I must be single grayscale image.

function [f, d] = asift_tune_par(I, V, varargin)

F=struct('val', []);
D=struct('val', []);
parfor(i=1:size(V,1))
     t=V(i,1);
     theta=V(i,2)*180/pi;
     if i==1        
        [ft, dt]=vl_sift(I);
     else 
        I_t = asift_simulate_image(I, t, theta);
        [ft, dt]=vl_sift(I_t);
     end;
     BorderFact = 6*sqrt(2.);
     onboundary = IsOnParallelogramBoundary(ft(1:2, :)', ft(3, :)', size(I, 1), size(I, 2), t, theta*pi/180, BorderFact);
     ft = ft(:, ~onboundary);
     dt = dt(:, ~onboundary);
                % map coordinate back to image I
     tmp = compensate_affine_coor1(ft(1:2, :)', size(I, 2), size(I, 1), t, 1, theta);
     s=actual_trans(t, theta  , size(I,1), size(I,2));

                % filter out points outside image
     inside = tmp(:, 1) >= 1 & tmp(:, 1) <= size(I, 2) & tmp(:, 2) >= 1 & tmp(:, 2) <= size(I, 1);
     
     ft(1:2,:) = tmp';
     ft = ft(:, inside);
     ft(3,:)=s*ft(3, :);
     dt = dt(:, inside);
     F(i).val=ft;
     D(i).val=dt;
     
end;

total=0;
for i=1:size(V,1)
    total=total+size(F(i).val,2);
end;

f=zeros(6, total);
d=zeros(128, total);
starts=1;
for i=1:size(V,1)
    
    f(1:4,starts:starts+ size(F(i).val,2)-1)=F(i).val;
    f(5,starts:starts+ size(F(i).val,2)-1)=V(i,1);
    f(6,starts:starts+ size(F(i).val,2)-1)=V(i,2);
    
    d(:, starts:starts+ size(F(i).val,2)-1)=D(i).val;
    starts=starts+size(F(i).val,2);
    
    
end;
return;

N = length(varargin);

if N == 1       % compute ASIFT default samplings
    num_of_tilts = varargin{1};
    
    t_min = 1;
    t_k = sqrt(2.);
    
    % calculate the number of simulations
    t = t_min * t_k .^ ((1:num_of_tilts) - 1);
    num_rot = round((5*t+1) / 2);
    num_rot(1) = 1;
    num_sim = sum(num_rot);
    
    disp([num2str(num_sim) ' simulations']);
    
    [f1, d1] = vl_sift(I);
    f = zeros(6, num_sim*size(f1, 2));
    d = uint8(zeros(128, num_sim*size(d1, 2)));
    
    % sim_samples = zeros(2, num_sim);
    % ind = 0;
    % for i = 1:num_of_tilts
    %     delta_theta = 180 / num_rot(i);
    %     theta = delta_theta * ((1:num_rot(i)) - 1);
    %
    %     sim_samples(1, ind+1:ind+length(theta)) = t(i);
    %     sim_samples(2, ind+1:ind+length(theta)) = theta;
    %     ind = ind + length(theta);
    % end
    
    keypoint_counter = 0;
    % simulate tilts and rotations
    for tt = 1:num_of_tilts
        % tilt
        t = t_min * t_k^(tt-1);
        
        if t == 1   % no tilt, do not simulate rotation
            [f1, d1] = vl_sift(I);
            f(1:4, keypoint_counter+1:keypoint_counter+size(f1, 2)) = f1;
            d(:, keypoint_counter+1:keypoint_counter+size(d1, 2)) = d1;
            f(5, keypoint_counter+1:keypoint_counter+size(f1, 2)) = t;
            f(6, keypoint_counter+1:keypoint_counter+size(f1, 2)) = 0;
            keypoint_counter = keypoint_counter + size(f1, 2);
        else
            delta_theta = 180 / num_rot(tt);
            for rr = 1:num_rot(tt)
                theta = delta_theta * (rr-1);
                
                I_t = asift_simulate_image(I, t, theta);
                
                %             imwrite(uint8(I_t), ['tilt-' num2str(t) '-rotation-' num2str(theta) '.jpg']);
                % compute SIFT points on this tilted and rotated image
                [ft, dt] = vl_sift(I_t);
                % check boundary condition
                BorderFact = 6*sqrt(2.);
                onboundary = IsOnParallelogramBoundary(ft(1:2, :)', ft(3, :)', size(I, 1), size(I, 2), t, theta*pi/180, BorderFact);
                ft = ft(:, ~onboundary);
                dt = dt(:, ~onboundary);
                % map coordinate back to image I
                tmp = compensate_affine_coor1(ft(1:2, :)', size(I, 2), size(I, 1), t, 1, theta);
                s=actual_trans(t, theta  , size(I,1), size(I,2));

                % filter out points outside image
                inside = tmp(:, 1) >= 1 & tmp(:, 1) <= size(I, 2) & tmp(:, 2) >= 1 & tmp(:, 2) <= size(I, 1);
                tmp = tmp(inside, :);
                ft = ft(:, inside);
                dt = dt(:, inside);
                
                f(1:2, keypoint_counter+1:keypoint_counter+size(ft, 2)) = tmp';
                f(3, keypoint_counter+1:keypoint_counter+size(ft, 2)) = s*ft(3, :);
                f(4, keypoint_counter+1:keypoint_counter+size(ft, 2)) = ft(4, :);

                f(5, keypoint_counter+1:keypoint_counter+size(ft, 2)) = t;
                f(6, keypoint_counter+1:keypoint_counter+size(ft, 2)) = theta*pi/180;
                d(:, keypoint_counter+1:keypoint_counter+size(ft, 2)) = dt;
                keypoint_counter = keypoint_counter + size(ft, 2);
            end
        end
    end
    
    f = f(:, 1:keypoint_counter);
    d = d(:, 1:keypoint_counter);
    
else
    
    % this preserves the input frame order
    if strcmp(varargin{1}, 'frames')
        
        f = varargin{2};
        d = uint8(zeros(128, size(f, 2)));
        
        sim_samples = f(5:6, :);
        sim_samples = unique(sim_samples', 'rows')';
        
        for i = 1:size(sim_samples, 2)
            t = sim_samples(1, i);
            theta = sim_samples(2, i);
            
            I_tr = asift_simulate_image(I, t, theta);
            
            pick = f(5, :) == t & f(6, :) == theta;
            f_pick = f(1:4, pick);
            
            f_pick(1:2, :) = compensate_affine_coor1(f_pick(1:2, :)', size(I_tr, 2), size(I_tr, 1), 1/t, 1, -theta)';
            [ft, dt] = vl_sift(I_tr, 'frames', f_pick);
            [ft, dt] = preserve_vlsift_order(f_pick, ft, dt);
            
            d(:, pick) = dt;
        end
    else
        disp('invalid arguments.');
        assert(false);
    end
end

d = truncateVLSIFT(d, 0.2);