close all
clc
%% Defining mesh
n_points = 51;
dom_size = 1;
h = dom_size/(n_points-1);

%% Initializing the problem
T(n_points,n_points) = 0;
T(1,:) = 1; %as per the problem on pg.86

T_new(n_points,n_points) = 0;
T_new(1,:) = 1;

error_mag = 1;
error_req = 1e-6;
iterations = 0;

%% Calculations
while error_mag > error_req
    for i = 2:(n_points-1) %indexing starts from second point to the second last point, since the first and last points are fixed 
        for j = 2:(n_points-1)
            T_new(i,j) = 0.25.*(T(i+1,j) + T(i-1,j) + T(i,j-1) + T(i,j+1));
            iterations = iterations + 1;
        end
    end
    
    % Calculation of error magnitude
    error_mag = 0;
    for i = 2:(n_points-1)
        for j = 2:(n_points-1)
            error_mag = error_mag + abs(T(i,j) - T_new(i,j));
        end
    end
    
    % Assigning new variable to old
    T = T_new;
end

%% Plotting 
x_dom = ((1:n_points)-1).*h;
y_dom = 1-((1:n_points)-1).*h;
[X,Y] = meshgrid(x_dom,y_dom);
contourf(X,Y,T,12)
colorbar
xlabel('x')
ylabel('y')