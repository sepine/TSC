function label=divide_and_predict(pred,data)

data1=data(pred==1,:);
data2=data(pred==2,:);

[n1,m1]=size(data1);
[n2,m2]=size(data2);
x1=sum(sum(data1))./(n1*m1);

% x2=sum(sum(data2))./(n2*m2);
% if(x1>x2)
%     label1=1; %data1 defective
%     label2=0;
% else 
%     label1=0;
%     label2=1; %data2 defective
% end

x2=sum(sum(data2))./(n2*m2);
if(x1>x2)
    label1=0; %data1 defective
    label2=1;
else 
    label1=1;
    label2=0; %data2 defective
end

if(label1==0 && label2==1)
    label=pred-1;
elseif(label1==1 && label2==0) 
    label=zeros(length(pred),1);
    for i=1:length(pred)
        if(pred(i)==1)
            label(i)=1;
        else label(i)=0;
        end
    end
else error('label is wrong!');
end