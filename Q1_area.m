clear
clc
load('point.mat');
P = point';
longitude = linspace(140,150,100);
latitude = linspace(-39,-34,100);
[x,y] = meshgrid(longitude,latitude);
surf(x,y,P,-(P>10)-(P>1000)-(P>10000));
grid on
set(gca,'Visible','off')
view(0,90)
colormap hot
shading flat
% grid on
% alpha(0.5)