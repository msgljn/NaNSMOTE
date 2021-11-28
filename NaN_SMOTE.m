function [Synthetic_samples,Synthetic_label,Minority_data,Minority_label]=NaN_SMOTE(Minority_data,Minority_label,N)
%%
% NaN_SMOTE
% parameter 1: oversample factor f 
%%
Synthetic_samples=[];
Synthetic_label=[];
%% (1) NaN_Search
NaNs=NaN_Search(Minority_data);
%% (2) Create synthetic and record outliers
Normal=[];
Outliers=[];
for i=1:size(Minority_data,1)
    [new_samples,new_label]=NaN_SMOTE_Populate(N,Minority_data,Minority_label,i,NaNs);
    Synthetic_samples=[Synthetic_samples;new_samples];
    Synthetic_label=[Synthetic_label;new_label];
    if length(NaNs{i})~=0
        Normal=[Normal;i];
    else
        Outliers=[Outliers;i];
    end
end
%% (3) Remove outliers
Minority_data=Minority_data(Normal,:);
Minority_label=Minority_label(Normal);
end

