[t,y] = ode45('vanderpol', 0:0.1:30, [0.1; -1]);
 plot(t,y(:,1),'b-')
title('Solution of van der Pol Equation c=20');
xlabel('time t');
ylabel('solution y');