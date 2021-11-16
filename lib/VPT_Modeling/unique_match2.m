function [matches]=unique_match2(matches)


% 
% 
% V = M(:);                           % flatten
% [Vs, Vi] = sort(V);                 % sort, Vi are indices into V
% delta = Vs(2:end) - Vs(1:end-1);    % delta==0 means duplicate
% dup1 = Vi(find(delta == 0));        % dup1 has indices of duplicates in V
% dup2 = Vi(find(delta == 0) + 1);    % dup2 has the corresponding other 
%                                     % rewrite to [row col]
% [dup1(:,1) dup1(:,2)] = ind2sub(size(M), dup1);
% [dup2(:,1) dup2(:,2)] = ind2sub(size(M), dup2);

% matches= unique(matches','rows','stable');
% matches=matches';
%

V=matches(2,:)';
[Vs, Vi] = sort(V);                 % sort, Vi are indices into V
delta = Vs(2:end) - Vs(1:end-1);    % delta==0 means duplicate
dup1 = Vi(find(delta == 0));        % dup1 has indices of duplicates in V
dup2 = Vi(find(delta == 0) + 1);    % dup2 has the corresponding other
% rewrite to [row col]

if ~isempty(dup1)
    [dup1(:,1) dup1(:,2)] = ind2sub(size(V), dup1);
    [dup2(:,1) dup2(:,2)] = ind2sub(size(V), dup2);    
    dup=cat(1,dup1, dup2);    
    matches(:,dup(:,1))=[];
    
end;


V=matches(1,:)';
[Vs, Vi] = sort(V);                 % sort, Vi are indices into V
delta = Vs(2:end) - Vs(1:end-1);    % delta==0 means duplicate
dup1 = Vi(find(delta == 0));        % dup1 has indices of duplicates in V
dup2 = Vi(find(delta == 0) + 1);    % dup2 has the corresponding other
% rewrite to [row col]

if ~isempty(dup1)
    [dup1(:,1) dup1(:,2)] = ind2sub(size(V), dup1);
    [dup2(:,1) dup2(:,2)] = ind2sub(size(V), dup2);   
    dup=cat(1,dup1, dup2);
    matches(:,dup(:,1))=[];
    
end;

%
% [discard1]=find_non_unique(matches(2,:));
% [discard2]=find_non_unique(matches(1,:));
% discard=cat(2, discard1,discard2);
%
% matches(:,discard)=[];