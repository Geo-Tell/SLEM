% boundary condition check for ASIFT, rotation, scale follows ASIFT's
% convention

function [flag x1 y1 x2 y2 x3 y3 x4 y4] = IsOnParallelogramBoundary(p, scale, height, width, tilt, theta, BorderFact)

sin_theta = sin(theta);
cos_theta = cos(theta);

t2 = 1 / tilt;

% compute the 4 corners of the parallelogram in the tilted and rotated
% image

if theta <= pi/2
    x1 = height * sin_theta;
    y1 = 0;
    y2 = width * sin_theta;
    x3 = width * cos_theta;
    x4 = 0;
    y4 = height * cos_theta;
    x2 = x1 + x3;
    y3 = y2 + y4;
    
    % reverse y direction
    y1 = y3 - y1;
    y2 = y3 - y2;
    y4 = y3 - y4;
    y3 = 0;
    
    y1 = y1 * t2;
    y2 = y2 * t2;
    y3 = y3 * t2;
    y4 = y4 * t2;
else
    y1 = -height * cos_theta;
    x2 = height * sin_theta;
    x3 = 0;
    y3 = width * sin_theta;
    x4 = -width * cos_theta;
    y4 = 0;
    x1 = x2 + x4;
    y2 = y1 + y3;
    
    % reverse y direction
    y1 = y2 - y1;
    y3 = y2 - y3;
    y4 = y2 - y4;
    y2 = 0;
    
    y1 = y1 * t2;
    y2 = y2 * t2;
    y3 = y3 * t2;
    y4 = y4 * t2;
end

% distance to 4 sides of the parallelogram
d1 = abs((x2-x1)*(y1-p(:, 2))-(x1-p(:, 1))*(y2-y1)) / sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1));
d2 = abs((x3-x2)*(y2-p(:, 2))-(x2-p(:, 1))*(y3-y2)) / sqrt((x3-x2)*(x3-x2)+(y3-y2)*(y3-y2));
d3 = abs((x4-x3)*(y3-p(:, 2))-(x3-p(:, 1))*(y4-y3)) / sqrt((x4-x3)*(x4-x3)+(y4-y3)*(y4-y3));
d4 = abs((x1-x4)*(y4-p(:, 2))-(x4-p(:, 1))*(y1-y4)) / sqrt((x1-x4)*(x1-x4)+(y1-y4)*(y1-y4));

BorderTh = BorderFact * scale;

flag = d1 < BorderTh | d2 < BorderTh | d3 < BorderTh | d4 < BorderTh;