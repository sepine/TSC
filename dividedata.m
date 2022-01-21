function [c1,c2]=dividedata(pred,data)
%data=[1,2,3;4,5,6;7,8,9];
%pred=[1,2,1];
%[n,m]=size(data);
%s=sum(pred);
%x2=s-n; %pred值为2的数据数量
%x1=n-x2; %pred值为1的数据数量
%c1=zeros(x1,m);
%c2=zeros(x2,m);
c1=data(pred==1,:);
c2=data(pred==2,:);