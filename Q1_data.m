clear
clc
data1 = xlsread('D:\study\math\model\2021\资料\archive\fire_archive_M6_96619.csv');
data1 = [data1(:,1),data1(:,2),data1(:,13)];
data1(data1(:,1)>-34,:) = [];
data1(data1(:,1)<-39,:) = [];
data1(data1(:,2)<141,:) = [];
data = data1;
data2 = xlsread('D:\study\math\model\2021\资料\archive\fire_archive_V1_96617.csv');
data2 = [data2(:,1),data2(:,2),data2(:,13)];
data2(data2(:,1)>-34,:) = [];
data2(data2(:,1)<-39,:) = [];
data2(data2(:,2)<141,:) = [];
data = [data;data2];
data3 = xlsread('D:\study\math\model\2021\资料\archive\fire_nrt_M6_96619.csv');
data3 = [data3(:,1),data3(:,2),data3(:,13)];
data3(data3(:,1)>-34,:) = [];
data3(data3(:,1)<-39,:) = [];
data3(data3(:,2)<141,:) = [];
data = [data;data3];




