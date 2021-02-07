clear
clc

init_x = linspace(-12,12,200);
init_y = linspace(-12,12,200);
[picx,picy] = meshgrid(init_x,init_y);
% z = 1+ cos(2*pi*picx/12).*cos(2*pi*picy/12);
% z = picx.*picy;
z = sin(2*pi*picy/20).*cos(2*pi*picx/20);
surf(picx,picy,z,z)
colormap copper
shading flat
view(0,90)
hold on
axis off

syms x y
% f = 1+ cos(2*pi*x/12).*cos(2*pi*y/12);
% f = x*y;
f = sin(2*pi*y/20)*cos(2*pi*x/20);
gradient = jacobian(f,[x,y]);

numberOfP = 40;
RR = [];
numberOfRR = 0;
P = [16*rand(numberOfP,2)-8,zeros(numberOfP,1)];
plot3(P(:,1),P(:,2),100*ones(numberOfP,1),'co');
for countOfP = 1:numberOfP
    lowestP = find(P(:,3) == min(P(:,3)));
    lowestP = lowestP(1);
    if(P(lowestP,3) > 0.9)
        break;
    end
    RR = [RR;[P(lowestP,1),P(lowestP,2)]];
    numberOfRR = numberOfRR +1;
    distance_x = P(:,1) - P(lowestP,1);
    distance_y = P(:,2) - P(lowestP,2);
    distance = sqrt(distance_x.^2 + distance_y.^2);
    
    for i = 1:numberOfP
        x = P(i,1);
        y = P(i,2);
        dp = eval(gradient);
        dx = dp(1);
        dy = dp(2);
        u = distance_x(i)*dx/distance(i) + distance_y(i)*dy/distance(i);
        if (u>0) u=0; end
        if (distance(i) ==0) u=0;end
        P(i,3) = P(i,3) + exp(2+10*sin(atan(u))*distance(i));
    end
    P((P(:,3)>1),3) = 1;
end
axis equal

plot3(RR(:,1),RR(:,2),100*ones(numberOfRR,1),'wo','MarkerSize',80);
plot3(RR(:,1),RR(:,2),100*ones(numberOfRR,1),'w*');




