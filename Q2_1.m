clear
clc

% 火灾参数
numberOFire = 30;
mapsize = 100;
% 生成火灾地点和地图
firePlace = [mapsize*(0.8*rand(numberOFire,2)+0.1),rand(numberOFire,1)];
efirePlace = firePlace;
efirePlace(1:10,3) = 1;
hold on
for countOFire = 1:numberOFire
    plot(firePlace(countOFire,1),firePlace(countOFire,2),'r.','MarkerSize',20*firePlace(countOFire,3));
end
xlabel('km')
ylabel('km')
legend('fire')
axis([0,mapsize,0,mapsize]);
axis equal
fire = firePlace;
pause()
for countOFire = 1:numberOFire
    plot(efirePlace(countOFire,1),efirePlace(countOFire,2),'r.','MarkerSize',20*efirePlace(countOFire,3));
end

while(1)

inputn = input('input number of EOC\n');
if(inputn == 0)
    break;
else
    numberOfEOC = inputn;
end
close all
hold on
for countOFire = 1:numberOFire
    picOfFire = plot(firePlace(countOFire,1),firePlace(countOFire,2),'r.','MarkerSize',20*firePlace(countOFire,3));
end
xlabel('km')
ylabel('km')
axis([0,mapsize,0,mapsize]);
axis equal
fire = firePlace;

%生成EOC
EOC = mapsize*rand(numberOfEOC,2);
%更新EOC
i = 1;
while(1)
    i = i+1;
    newEOC = EOC;
    for countOfEOC = 1:numberOfEOC
        
        sumUtility = 0;
        for countOFire =1:numberOFire
            [probability,distance] = detectByEOC(EOC(countOfEOC,1),EOC(countOfEOC,2),fire(countOFire,1),fire(countOFire,2));
            sumUtility = sumUtility + probability*fire(countOFire,3);
            if(probability~=1)
                newEOC(countOfEOC,1) = newEOC(countOfEOC,1) +...
                    (fire(countOFire,1)-EOC(countOfEOC,1))/distance *...
                    probability*fire(countOFire,3)*2;
                newEOC(countOfEOC,2) = newEOC(countOfEOC,2) +...
                    (fire(countOFire,2)-EOC(countOfEOC,2))/distance *...
                    probability*fire(countOFire,3)*2;
            end
        end
        if(sumUtility < sum(fire(:,3))/numberOFire/2)
            maxf = find(fire(:,3) == max(fire(:,3)));
            maxf = maxf(1);
            newEOC(countOfEOC,:) = [fire(maxf,1)+10*randn(),fire(maxf,2)+10*randn()];
        end
        
        for otherEOC = 1:numberOfEOC
            if(otherEOC~=countOfEOC)
                [~,distance] = detectByEOC(newEOC(countOfEOC,1),newEOC(countOfEOC,2),EOC(otherEOC,1),EOC(otherEOC,2));
                newEOC(countOfEOC,1) = newEOC(countOfEOC,1) +...
                    (EOC(countOfEOC,1)-EOC(otherEOC,1))/distance * exp((20-distance)/5);
                newEOC(countOfEOC,2) = newEOC(countOfEOC,2) +...
                    (EOC(countOfEOC,2)-EOC(otherEOC,2))/distance * exp((20-distance)/5);
            end
        end
    end
    
    newEOC(newEOC<0) = -newEOC(newEOC<0);
    newEOC(newEOC>mapsize) = 2*mapsize - newEOC(newEOC>mapsize);
    
    distanceChange = sum((newEOC'-EOC').^2);
    if(sum(distanceChange)<0.03*(numberOfEOC+numberOFire))
        break;
    end
    EOC = newEOC;
    
    fire = firePlace;
    for countOFire = 1:numberOFire
        for countOfEOC = 1:numberOfEOC
            [probability,~] = detectByEOC(EOC(countOfEOC,1),EOC(countOfEOC,2),fire(countOFire,1),fire(countOFire,2));
            fire(countOFire,3) = fire(countOFire,3) * (1-probability);
        end
    end
    if(i>10000)
        break;
    end
end

for countOfEOC = 1:numberOfEOC
    picOfEOC = plot(EOC(countOfEOC,1),EOC(countOfEOC,2),'*','Color',[0,0,0]);
    rectangle('Position',[EOC(countOfEOC,1)-20,EOC(countOfEOC,2)-20,40,40],'Curvature',[1,1],'EdgeColor','b');
end
legend([picOfFire,picOfEOC],'Fire','EOC')
axis equal

% 计算分数
danger = 0;
for countOFire = 1:numberOFire
    [probability,~] = detectByEOC(EOC(:,1),EOC(:,2),firePlace(countOFire,1),firePlace(countOFire,2));
    probability = sum(probability);
    if(firePlace(countOFire,3)-probability>0)
        danger = danger + firePlace(countOFire,3)-probability;
    end
end
danger
end








