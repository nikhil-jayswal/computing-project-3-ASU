% clear console
clc;

% ask user for type of polygon
area_type = input('Polygon Type (Rectangle = 1, Hollow Rectangular Tube = 2, Equal-Angle L shape = 3) = ');
% get vertices vector
x = CP3_Input(area_type);

% calculate no of edges
[row, col] = size(x);
edges = row - 1; % last vertex is repeated

% intialize properties
Area = 0;
p = zeros(1,2); % centroid
R = [0 0; 0 0]; % tensor

% loop over the sides
for i = 1:edges
    % compute unit vectors n and m
    if norm(x(i,:)) == 0
        n = [0 0];
    else
        n = x(i,:)/norm(x(i,:));
    end
    m = (x(i+1,:) - x(i,:)) / norm(x(i+1,:) - x(i,:));
    
    % compute angle phi
    sin_phi = (n(1)*m(2) - n(2)*m(1));
    
    % compute part area
    height = norm(x(i,:));
    base = norm(x(i+1,:) - x(i,:));
    area = 0.5 * base * height * sin_phi;
    
    % compute p
    centroid = area * ((2/3)*height*n + (1/3)*base*m);
    
    % compute contribution to R
    a1 = n'*n;
    a2 = n'*m + m'*n;
    a3 = m'*m;
    inertia = area * (0.5*height*height*a1 + 0.25*base*height*a2 +  (1/6)*base*base*a3);
    
    % add contributions
    Area = Area + area;
    p = p + centroid;
    R = R + inertia;
    
end    

% compute c
c = p./Area;

% compute moment of inertia tensor
J =  R - Area*c'*c;

% polar moment of inertia
J_polar = J(1,1) + J(2,2);

% principal values of J
Jmax = max(eig(J));
Jmin = min(eig(J));

% plot polygon and centroid
plot(x(:,1), x(:,2), 'g', 'LineWidth', 1.5)
hold on
plot(c(1),c(2), 'Marker', '+', 'LineWidth', 1.5)
% print results
fprintf('\n');
fprintf('Area = %.3f\n', Area);
fprintf('Centroid = (%3f, %3f)\n', c(1), c(2));
fprintf('Moment of Inertia Tensor is: ');
J % outputs moment of inertia tensor
fprintf('Principal values of moment of inertia are: ')
Jmax
Jmin
fprintf('Polar Moment of Inertia = %.3f\n', J_polar)





    
    
    