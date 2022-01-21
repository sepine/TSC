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

for i=1:trials %�ظ�Ԥ��100��
    
    % run k-means
    if strcmp(implementation,'m') %implementation=m
        % MATLAB version
        IDX=kmeans(data,k,'emptyaction','singleton'); %singleton�Ƿ�ֹ���ֿ���
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
%��ȡ����Ĳ�ͬ���������ɵľ���  uindsΪ����preds'�е�Ԫ���ھ���upreds�е�λ��
% find clustering counts
predc=histc(uinds,1:size(upreds,1)); %ͳ���ڸ��������ڵ�ֵ�ĸ�������ΧΪ�����ȡ�Ⱥ�
%�ֱ�ͳ�Ƴ���ͬԤ��ĸ�������
% find most frequent index and count
[freqc,freqi]=max(predc);%�ҳ����ִ�������һ��Ԥ��

fprintf('most frequent clustering: %d/%d (%f)\n',freqc,trials,freqc/trials);

pred=upreds(freqi,:)';   %ͳ�Ƴ����ִ�������һ��Ԥ�� 1250*1

end
