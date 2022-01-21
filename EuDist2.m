function D = EuDist2(fea_a,fea_b,bSqrt)
%EUDIST2 Efficiently Compute the Euclidean Distance Matrix by Exploring the
%Matlab matrix operations.
%
%   D = EuDist(fea_a,fea_b)
%   fea_a:    nSample_a * nFeature
%   fea_b:    nSample_b * nFeature
%   D:      nSample_a * nSample_a
%       or  nSample_a * nSample_b
%
%    Examples:
%
%       a = rand(500,10);
%       b = rand(1000,10);
%
%       A = EuDist2(a); % A: 500*500
%       D = EuDist2(a,b); % D: 500*1000
%
%   version 2.1 --November/2011
%   version 2.0 --May/2009
%   version 1.0 --November/2005
%
%   Written by Deng Cai (dengcai AT gmail.com)


if ~exist('bSqrt','var')  %否
    bSqrt = 1;
end

if (~exist('fea_b','var')) || isempty(fea_b)  %否
    aa = sum(fea_a.*fea_a,2);
    ab = fea_a*fea_a';
    
    if issparse(aa)
        aa = full(aa);
    end
    
    D = bsxfun(@plus,aa,aa') - 2*ab;
    D(D<0) = 0;
    if bSqrt
        D = sqrt(D);
    end
    D = max(D,D');
else
    aa = sum(fea_a.*fea_a,2);  %行求和 1250*5000
    bb = sum(fea_b.*fea_b,2);
    ab = fea_a*fea_b'; %1250*1250 点之间的距离

    if issparse(aa)  %如果稀疏矩阵的存储方式是sparse storage organization，则返回逻辑1；否则返回逻辑0
        aa = full(aa);
        bb = full(bb);
    end

    D = bsxfun(@plus,aa,bb') - 2*ab; %bsxfun(@plus,aa,bb')为aa+bb'
    D(D<0) = 0;
    if bSqrt  %bSqrt=0
        D = sqrt(D);
    end
end

