addpath('.\ICFR\');
data1 = xlsread('codec.xlsx');
data2 = xlsread('collections.xlsx');
data3 = xlsread('io.xlsx');
data4 = xlsread('jsoup.xlsx');
data5 = xlsread('jsqlparser.xlsx');
data6 = xlsread('mango.xlsx');
data7 = xlsread('ormlite.xlsx');

data = cell(1,7);
data{1,1} = data1;
data{1,2} = data2;
data{1,3} = data3;
data{1,4} = data4;
data{1,5} = data5;
data{1,6} = data6;
data{1,7} = data7;

ttt = 0;
overall = [];
for ii = 1:7
    for jj = 1:7
        ii
        jj
        if ii~=jj
            target = [];
            source = [];
            target = cell2mat(data(1,ii));
            source = cell2mat(data(1,jj));
            
            Xs = source(:,1:end-1);
            Ys = source(:,end);
            Xt = target(:,1:end-1);
            Yt = target(:,end);

            [nt,d] = size(Xt);
            ns = size(Xs,1);
            Z = [Xs;Xt];  
            a = sum(Z);  
            i = (a>0);  
            Z = Z(:,i); 
            Xs = Z(1:ns,:); 
            Xt = Z(ns+1:end,:);

            Z = my_tfidf([Xs;Xt],1); 
            a = sum(Z); 
            i = (a>0);
            Z = Z(:,i);
            Xs = Z(1:ns,:);
            Xt = Z(ns+1:end,:);

            r = 0.1;  %parameter1 ¦Ë raning from [0.1-0.9,1-9]
            step = 1; 
            kt = max(Yt);
            ks = max(Ys);
            k = kt
            nei1 = 1; %%parameter2 range from [1-9]
            options1 = [];
            options1.NeighborMode = 'KNN';
            options1.k = nei1;
            options1.WeightMode = 'HeatKernel';

            W11 = constructW(Xt,options1);
            W22 = constructW(Xs,options1);

            [Ft, Fs,iter] = transferSpectralClustering(Xt,Xs,k,r,step,W11,W22); 
            kmtrials = 100; 

            pred1=kmeans_freq(Ft,kt,kmtrials,'m');  
            prdlabel1=divide_and_predict(pred1,Xt); 
            fin=[prdlabel1,Yt-1];

            overall(1 + ttt * 1, :) = performance(prdlabel1,Yt-1);
    
            ttt = ttt+1;
        end
    end
end

size(overall)
xlswrite('overall_0.1_1.xlsx',overall);