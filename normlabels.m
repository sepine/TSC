% Normalizes labels so that the same clustering would obtain the exact same
% labels
%
% Input:
% labels - vector of integer labels from 1 to the number of labels
%
% Output:
% nlabels - normalized version
%
% Author: Frank Lin (frank@cs.cmu.edu)

function [nlabels]=normlabels(labels)
%labels=[1,2,1,3,2,4,7,5,8,2,5,6];
% initialize normalized labels
nlabels=zeros(size(labels));

% make a map from labels to normalized labels
[~,fi]=unique(labels,'first'); %ÉýÐò
[~,map]=sort(labels(sort(fi)));

% normalize the labels
for i=1:length(map)
    nlabels(labels==i)=map(i);
end

end
