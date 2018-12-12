clear all, close all, clc
L = 240;
H = 240;
u = zeros(L,H);
% u(1:L/2,1:H)=1;
% u(L/2:L,1:H)=-1;
Bu = zeros(L,H);
for x=1:L
        for y=1:H
            if((floor((abs(x-L/2))^2+(abs(y-H/2))^2))<(floor(240/2*1/1.2))^2),
                Bu(x, y) = 1;
            end
        end
end
iteration = 0;
while (iteration<1000),
    iteration = iteration + 1         
      for theta = 0:0.01:2*pi
        u(floor(L/2+L/2*1/1.2*cos(theta)), floor(H/2+H/2*1/1.2*sin(theta))) = cos(theta);
      end
    % Plot every 100 iterations
    if (mod(iteration,100)==0),        
        imagesc(Fu);
        colorbar;
        drawnow;
    end
    %% OPTION 1, B:  Use a 5-point stencil
    Lu = u;
    for i=2:L-1
        for j=2:H-1
            Lu(i,j) = (1)*(-4*u(i,j)+u(i,j+1)+u(i-1,j)+u(i+1,j)+u(i,j-1));
        end
    end
    u(2:L-1,2:H-1) = u(2:L-1,2:H-1)+.25*Lu(2:L-1,2:H-1); 
%     % less numerically stable... need a smaller dt.
    Fu=u(2:L-1,2:H-1).*Bu(2:L-1,2:H-1);
end