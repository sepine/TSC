function [label1,label2]=labeldata(data1,data2)

[n1,m1]=size(data1);
[n2,m2]=size(data2);
x1=sum(sum(data1))./(n1*m1);

x2=sum(sum(data2))./(n2*m2);
if(x1>x2)
    label1=1; %data1 defective
    label2=0;
else 
    label1=0;
    label2=1; %data2 defective
end