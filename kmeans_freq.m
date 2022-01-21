% A version of the Euclidean k-means algorithm where the several trials are
% ran and the most frequent result is chosen as the final clustering
%
% Input:
% data - row-instance data matrix
% k - number of clusters
% trials - number of trials to run before determining best clustering
% implementation - which specific k-means implementation to use
%
% implementation:
% 'm' - one that comes with matlab
% 'cl' - one by Chen & Lin (wychen@alumni.cs.ucsb.edu)
%
% Output:
% pred - predicted cluster labels
%
% Author: Frank Lin (frank@cs.cmu.edu)

function pred=kmeans_freq(data,k,trials,implementation)

fprintf('running %d k-means trials\n',trials);

% data size
n=size(data,1); %1250

% initialize prediction store
preds=zeros(n,trials);%trials=100

for i=1:trials %重复预测100次
    
    % run k-means
    if strcmp(implementation,'m') %implementation=m
        % MATLAB version
        IDX=kmeans(data,k,'emptyaction','singleton'); %singleton是防止出现空组
    elseif strcmp(implementation,'cl')
        % Chen & Lin version
        IDX=kmeans_cl(data,'random',k);
    else
        fprintf('implementation not recognized: %s\n',implementation)
    end

    % normalize labels
    preds(:,i)=normlabels(IDX); %1250*100
    
end

% find unique clusterings and their indices
[upreds,~,uinds]=unique(preds','rows'); %preds' 100*1250
%获取矩阵的不同行向量构成的矩阵。  uinds为矩阵preds'中的元素在矩阵upreds中的位置
% find clustering counts
predc=histc(uinds,1:size(upreds,1)); %统计在给定区间内的值的个数，范围为对左边取等号
%分别统计出不同预测的各个次数
% find most frequent index and count
[freqc,freqi]=max(predc);%找出出现次数最多的一次预测

fprintf('most frequent clustering: %d/%d (%f)\n',freqc,trials,freqc/trials);

pred=upreds(freqi,:)';   %统计出出现次数最多的一次预测 1250*1

end
