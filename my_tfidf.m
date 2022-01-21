function fea2 = my_tfidf(fea,bNorm)
%  fea is a document-term frequency matrix, this function return the tfidf ([1+log(tf)]*log[N/df])
%  weighted document-term matrix.
%    
%     If bNorm == 1, each document verctor will be further normalized to
%                    have unit norm. (default)
%
%   version 2.0 --Jan/2012 
%   version 1.0 --Oct/2003 
%
%   Written by Deng Cai (dengcai AT gmail.com)
%
if ~exist('bNorm','var')
    bNorm = 1;
end


[nSmp,mFea] = size(fea);  %约为2500*5000
[idx,jdx,vv] = find(fea);  %find返回向量或者矩阵中不为0的元素的位置索引即对应的值
df = full(sum(sparse(idx,jdx,1),1)); %sparse(idx,jdx,1)生成一个稀疏矩阵 向量idx对应行
                                     %jdx对应列 对应的位置值为1，其余为0  df为1*mFea
df(df==0) = 1;    %df有值为0的就令它变为1 即若fea有某一列全为0则df对应位置为0
idf = log(nSmp./df); 

tffea = sparse(idx,jdx,log(vv)+1);

fea2 = tffea';  %mFea*nSmp 5000*2500
idf = idf';  % mFea*1

MAX_MATRIX_SIZE = 5000; % You can change this number based on your memory. ???
nBlock = ceil(MAX_MATRIX_SIZE*MAX_MATRIX_SIZE/mFea); %ceil朝正无穷大方向取整
for i = 1:ceil(nSmp/nBlock)  %ceil(nSmp/nBlock)=ceil(2500/5000)=1
    if i == ceil(nSmp/nBlock)
        smpIdx = (i-1)*nBlock+1:nSmp;
    else
        smpIdx = (i-1)*nBlock+1:i*nBlock;
    end
    fea2(:,smpIdx) = fea2(:,smpIdx) .* idf(:,ones(1,length(smpIdx)));
end                                    %  idf(:,ones(1,length(smpIdx)))为mFea*length(smpIdx)

%Now each column of fea2 is the tf-idf vector.
%One can further normalize each vector to unit by using following codes:
if bNorm ==1
   fea2 = NormalizeFea(fea2,0);  %fea2 mFea*nSmp 5000*2500
elseif bNorm == 2
    fea2 = NormalizeFea(fea2,1); 
end
fea2 = fea2';  %nSmp*mFea 2500*5000
% fea is the final document-term matrix.