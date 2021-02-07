function [ probability,distance ] = detectByEOC( xEOC,yEOC,xOBJ,yOBJ )
% 距离函数为e^(20-x)/5
% 距离EOC小于20的位置理论上永远探测的到,所以值为1
% 大于50的位置永远探测不到,这里取值为e^-10
% 而且曲线比较合理
distance = sqrt( (xEOC-xOBJ).^2 + (yEOC-yOBJ).^2) ;
probability = exp( (20-distance)/10 );
% probability( distance>50 ) = 0;
probability( probability>1 ) = 1;
end

