function [Synthetic_samples,Synthetic_label]=NaN_SMOTE_Populate(N,Minority_data,Minority_label,base,NaNs)
%%
numattrs=size(Minority_data,2);
Synthetic_samples=[];
Synthetic_label=[];
while N>0
    base_NNs=NaNs{base};
    if isempty(base_NNs)
         N=N-1;
        continue;
    end
    random_NN=ceil(rand*length(base_NNs));
    base_data=Minority_data(base,:);
    base_label=Minority_label(base,:);
    base_random_NN=base_NNs(random_NN);
    for i=1:numattrs
        dif=Minority_data(base_random_NN,i)-base_data(i);
        gap=rand;
        new_sample(i)=base_data(i)+gap*dif;
    end
    Synthetic_samples=[Synthetic_samples;new_sample];
    Synthetic_label=[Synthetic_label;base_label];
    N=N-1;
end

end

