clear all
close all

load CLIVE.mat

numberOfSplits = 100;

PLCC = zeros(1,numberOfSplits); SROCC = zeros(1,numberOfSplits);
KROCC = zeros(1,numberOfSplits);

numberOfImages = size(AllMOS_release,2);
Features = zeros(numberOfImages, 1680); 

path = 'C:\Users\Public\QualityAssessment\ChallengeDB_release\Images';

disp('Feature extraction');
parfor i=1:numberOfImages
    if(mod(i,50)==0)
        disp(i);
    end
    img = imread( strcat(path, filesep, AllImages_release{i}) );
    Features(i,:) = extractImageFeatures(img, 5, 3);
end

disp('Evaluation');
for i=1:numberOfSplits
    if(mod(i,10)==0)
        disp(i);
    end
    p = randperm(numberOfImages);
    
    Data = Features(p,:);
    Target = AllMOS_release(p);
    
    Train = Data(1:round(numberOfImages*0.8),:);
    TrainLabel = Target(1:round(numberOfImages*0.8));
    
    Test  = Data(round(numberOfImages*0.8)+1:end,:);
    TestLabel = Target(round(numberOfImages*0.8)+1:end);
    
    Mdl = fitrsvm(Train, TrainLabel', 'KernelFunction', 'Gaussian', 'KernelScale', 'auto', 'Standardize', true);
    %Mdl = fitrgp(Train, TrainLabel', 'KernelFunction', 'rationalquadratic', 'Standardize', true);
    
    Pred = predict(Mdl,Test);
    
    beta(1) = max(TestLabel); 
    beta(2) = min(TestLabel); 
    beta(3) = mean(TestLabel);
    beta(4) = 0.5;
    beta(5) = 0.1;
    
    [bayta,ehat,J] = nlinfit(Pred,TestLabel',@logistic,beta);
    [pred_test_mos_align, ~] = nlpredci(@logistic,Pred,bayta,ehat,J);
    
    PLCC(i) = corr(pred_test_mos_align,TestLabel');
    SROCC(i)= corr(Pred,TestLabel','Type','Spearman');
    KROCC(i)= corr(Pred,TestLabel','Type','Kendall');
end

disp(round(median(PLCC),3));
disp(round(median(SROCC),3));
disp(round(median(KROCC),3));
