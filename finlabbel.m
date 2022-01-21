function label=finlabbel(label1,label2,pred)
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