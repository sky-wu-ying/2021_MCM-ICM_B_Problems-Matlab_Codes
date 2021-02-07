close all

hold on
for countOFire = 1:numberOFire
    plot(firePlace(countOFire,1),firePlace(countOFire,2),'r.','MarkerSize',20*firePlace(countOFire,3));
end
axis equal
for countOfEOC = 1:numberOfEOC
    plot(EOC(countOfEOC,1),EOC(countOfEOC,2),'*','Color',[0,0,0]);
end
%构建邻接矩阵
Edge = zeros(numberOfEOC,numberOfEOC);
for countOfEOC = 1:numberOfEOC
    distance_x = EOC(:,1) - EOC(countOfEOC,1);
    distance_y = EOC(:,2) - EOC(countOfEOC,2);
    distance = distance_x.^2 + distance_y.^2;
    distance(distance==0) = 1700;
    for countEdge = 1:3
        near = find(distance == min(distance));
        near = near(1);
        if(distance(near) < 1600)
            Edge(countOfEOC,near) = 1;
            distance(near) = 1700;
        end
    end
end
gplot(Edge,EOC,'c-');


% for x = 0:0.2:mapsize
%     for y = 0:0.2:mapsize
%         distance_x = EOC(:,1) - x;
%         distance_y = EOC(:,2) - y;
%         distance = distance_x.^2 + distance_y.^2;
%         near = find(distance == min(distance));
%         near = near(1);
%         d1 = distance(near);
%         if(abs(d1-400) < 8)
%             plot(x,y,'.','Color',[0,1,0],'MarkerSize',3);
%             continue;
%         else if (d1>400)
%                 continue;
%             end
%         end
%         distance(near) = 500;
%         near = find(distance == min(distance));
%         near = near(1);
%         d2 = distance(near);
%         if(d2-d1 < 10 && d2<400)
%             plot(x,y,'.','Color',[0,1,0],'MarkerSize',3);
%         end
%     end
% end
xlabel('km')
ylabel('km')


%无人机数量
tofRR = zeros(numberOfEOC,1);
for countOFire = 1:numberOFire
    distance_x = EOC(:,1) - firePlace(countOFire,1);
    distance_y = EOC(:,2) - firePlace(countOFire,2);
    distance = distance_x.^2 + distance_y.^2;
    inside = 0;
    for countOfEOC = 1:numberOfEOC
        if(distance(countOfEOC)<400)
            tofRR(countOfEOC) = max(tofRR(countOfEOC),firePlace(countOFire,3));
            inside = 1;
        end
    end
    if(inside==0 && min(distance)<1600)
        near = find(distance == min(distance));
        near = near(1);
        tofRR(near) = max(tofRR(near), firePlace(countOFire,3)/exp((20-sqrt(distance(near)))/10));
    end
end
numberOfRR = ceil(sum(tofRR)*(2.5+1.75)/2.5)

tofSSA = 0;
fire = firePlace;
for countOFire = 1:numberOFire
    if(max(fire(:,3))~=0)
        first = find( fire(:,3) == max(fire(:,3)));
        first = first(1);
        tofSSA = tofSSA + fire(first,3);
        fire(first,3) = 0;
        distance_x = fire(:,1) - fire(first,1);
        distance_y = fire(:,2) - fire(first,2);
        distance = distance_x.^2 + distance_y.^2;
        fire(distance<25,3) = 0;
    else
        break;
    end
end
numberOfSSA = ceil(tofSSA*(2.5+1.75)/2.5)