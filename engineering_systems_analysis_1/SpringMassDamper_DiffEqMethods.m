clear all; close all
% play around with different 'd' and 'dt' to see various behavior!

w = 2*pi; % natural frequency
d = .25;  % damping ratio

% spring-mass-damper system
A = [0 1; -w^2 -2*d*w];  % \dot{x} = Ax

dt = 0.01;  % time step
T = 10;     % amount of time to integrate

x0 = [2; 0]; % initial condition (x=2, v=0)

% iterate forward Euler
xF(:,1) = x0;
tF(1) = 0;
for k=1:T/dt
    tF(k+1) = k*dt;
    xF(:,k+1) = (eye(2) + dt*A)*xF(:,k);
end

plot(tF,xF(1,:),'k')

% iterate backward Euler
xB(:,1) = x0;
tB(1) = 0;
for k=1:T/dt
   tB(k+1) = k*dt;
   xB(:,k+1) = inv(eye(2) - A*dt)*xB(:,k); % should probably pre-compute inverse for efficiency sake
end
hold on
plot(tB,xB(1,:),'b')

% compute better integral using built-in Matlab code
% 4th-order Runge Kutta 
% [TOUT,YOUT] = ODE45(ODEFUN,TSPAN,Y0)
[t,xGood] = ode45( @(t,x) A*x, 0:dt:T, x0); % 
% using function handle to define @(t,x) A*x... right-hand side
% of \dot{x} = Ax... ode45 wants us to include time in @(t,x), in 
% case there is time dependence.
hold on
plot(t,xGood(:,1),'r')
legend('Forward Euler','Backward Euler','ODE45 (RK4)')