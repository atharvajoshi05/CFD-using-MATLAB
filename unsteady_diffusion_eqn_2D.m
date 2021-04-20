close all
clc
%% Defining mesh
n_points = 51;
dom_size = 1;
h = dom_size/(n_points-1);
dt = 0.0001;
alpha = dt/(h*h); %refer pg.87 in notebook

%% Initializing the problem
T(n_points,n_points) = 0;
T(1,:) = 1; %as per the problem on pg.86

T_new(n_points,n_points) = 0;
T_new(1,:) = 1;

error_mag = 1;
error_req = 1e-6;
iterations = 0;

%Tracking the error magnitude
%error_track = 0;
%% Calculations
while error_mag > error_req
    for i = 2:(n_points-1) %indexing starts from second point to the second last point, since the first and last points are fixed 
        for j = 2:(n_points-1)
            T_new(i,j) = T(i,j) - alpha.*(T(i+1,j) + T(i-1,j) + T(i,j-1) + T(i,j+1) - 4*T(i,j));  
            iterations = iterations + 1;
        end
    end
    
    % Calculation of error magnitude
    error_mag = 0;
    for i = 2:(n_points-1)
        for j = 2:(n_points-1)
            error_mag = error_mag + abs(T(i,j) - T_new(i,j));
            %error_track(iterations) = error_mag; %tracking error with each iteration
        end
    end
%     if rem(iterations, 1000) == 0 %gives value of error after every 1000 iterations
%         iterations
%         error_mag
%     end
    
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

%Plotting error with time
%figure;
%time = dt.*(i:iterations);
%plot(time, error_track);