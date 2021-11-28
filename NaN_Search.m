function  [NaN,r]=NaN_Search(data)
%% Search NaN  By  NaN_search
%% initialize paramters
n=size(data,1);
r=1;
tag=1;
NaN=cell(n,1)';
RN=zeros(n,1);
KNN=cell(n,1)';
RNN=cell(n,1)';
%%
kdtree=KDTreeSearcher(data,'bucketsize',1); 
index = knnsearch(kdtree,data,'k',n);%
index(:,1)=[];
while tag
    KNN_idx=index(:,r);
    %%  Compute KNN and RNN
    for i=1:n
        RNN{KNN_idx(i)}=[RNN{KNN_idx(i)};i];
        KNN{i}=[KNN{i};KNN_idx(i)];
    end
    %% 
    pos=[];
    for i=1:n
        if length(RNN{i})~=0  
           pos=[pos;i];
        end
    end
    RN(pos)=1;
    %% Stopping condition
    cnt(r)=length(find(RN==0));
    if r>2 && cnt(r)==cnt(r-1)
       tag=0;
       r=r-1;
    end
    r=r+1;
end
for i=1:n
    NaN{i}=intersect(RNN{i},KNN{i});
end

end