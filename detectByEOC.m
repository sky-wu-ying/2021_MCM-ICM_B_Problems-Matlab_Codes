function [ probability,distance ] = detectByEOC( xEOC,yEOC,xOBJ,yOBJ )
% ���뺯��Ϊe^(20-x)/5
% ����EOCС��20��λ����������Զ̽��ĵ�,����ֵΪ1
% ����50��λ����Զ̽�ⲻ��,����ȡֵΪe^-10
% �������߱ȽϺ���
distance = sqrt( (xEOC-xOBJ).^2 + (yEOC-yOBJ).^2) ;
probability = exp( (20-distance)/10 );
% probability( distance>50 ) = 0;
probability( probability>1 ) = 1;
end

