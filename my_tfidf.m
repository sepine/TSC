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


[nSmp,mFea] = size(fea);  %ԼΪ2500*5000
[idx,jdx,vv] = find(fea);  %find�����������߾����в�Ϊ0��Ԫ�ص�λ����������Ӧ��ֵ
df = full(sum(sparse(idx,jdx,1),1)); %sparse(idx,jdx,1)����һ��ϡ����� ����idx��Ӧ��
                                     %jdx��Ӧ�� ��Ӧ��λ��ֵΪ1������Ϊ0  dfΪ1*mFea
df(df==0) = 1;    %df��ֵΪ0�ľ�������Ϊ1 ����fea��ĳһ��ȫΪ0��df��Ӧλ��Ϊ0
idf = log(nSmp./df); 

tffea = sparse(idx,jdx,log(vv)+1);

fea2 = tffea';  %mFea*nSmp 5000*2500
idf = idf';  % mFea*1

MAX_MATRIX_SIZE = 5000; % You can change this number based on your memory. ???
nBlock = ceil(MAX_MATRIX_SIZE*MAX_MATRIX_SIZE/mFea); %ceil�����������ȡ��
for i = 1:ceil(nSmp/nBlock)  %ceil(nSmp/nBlock)=ceil(2500/5000)=1
    if i == ceil(nSmp/nBlock)
        smpIdx = (i-1)*nBlock+1:nSmp;
    else
        smpIdx = (i-1)*nBlock+1:i*nBlock;
    end
    fea2(:,smpIdx) = fea2(:,smpIdx) .* idf(:,ones(1,length(smpIdx)));
end                                    %  idf(:,ones(1,length(smpIdx)))ΪmFea*length(smpIdx)

%Now each column of fea2 is the tf-idf vector.
%One can further normalize each vector to unit by using following codes:
if bNorm ==1
   fea2 = NormalizeFea(fea2,0);  %fea2 mFea*nSmp 5000*2500
elseif bNorm == 2
    fea2 = NormalizeFea(fea2,1); 
end
fea2 = fea2';  %nSmp*mFea 2500*5000
% fea is the final document-term matrix.