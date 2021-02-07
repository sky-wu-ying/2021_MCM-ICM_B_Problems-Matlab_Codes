clear
clc
load('point.mat');
Square = 237629;
P = point(:);
lowF = sum(P<10);
midF = sum((P>10) .* (P<1000));
highF = sum((P>1000) .* (P<10000));
extremeF = sum(P>10000);

F = [lowF;midF;highF;extremeF];
pie(F)
legend('low Size&Frequency','mid Size&Frequency','high Size&Frequency','extreme high Size&Frequency')
colormap summer

lowS = Square*lowF/10000
midS = Square*midF/10000
highS = Square*highF/10000
extremeS = Square*extremeF/10000
