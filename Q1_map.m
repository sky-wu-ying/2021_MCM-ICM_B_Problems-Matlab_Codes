clear
clc
load('data.mat')
hold on
plot(data(:,1),data(:,2),'r.','MarkerSize',1);
axis([140,151,-40,-31]);
xlabel('longitude');
ylabel('latitude');
grid on
% set(gca,'Visible','off')
% imshow(map)

longitude = linspace(140,151,101);
latitude = linspace(-39,-34,101);
point = zeros(100,100);
for i = 1:100
    for j = 1:100
        fire = data;
        fire = fire(fire(:,1)<longitude(i+1),:);
        fire = fire(fire(:,1)>longitude(i),:);
        fire = fire(fire(:,2)<latitude(j+1),:);
        fire = fire(fire(:,2)>latitude(j),:);
        fire = fire(:,3);
        point(i,j) = sum(fire);
    end
end


frequency = zeros(100,100);
for i = 1:100
    for j = 1:100
        fire = data;
        fire = fire(fire(:,1)<longitude(i+1),:);
        fire = fire(fire(:,1)>longitude(i),:);
        fire = fire(fire(:,2)<latitude(j+1),:);
        fire = fire(fire(:,2)>latitude(j),:);
        fire = fire(:,3)>0;
        frequency(i,j) = sum(fire);
    end
end









