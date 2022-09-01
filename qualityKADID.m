clear all
close all

warning off

load KADID_Data2.mat

path = 'C:\Users\Public\QualityAssessment\KADID-10k\kadid10k\images';

numberOfImages = size(dmos, 1);
Scores = zeros(numberOfImages, 1);

Features = zeros(numberOfImages, 1680);

parfor i=9258:numberOfImages
    if(mod(i,50)==0)
        disp(i);
    end
    img  = imread( char(strcat(path, filesep, string(dist_img(i)))) );
    Features(i,:) = extractImageFeatures(img, 45, 3);
end

PLCC = zeros(1,100);
SROCC= zeros(1,100);
KROCC= zeros(1,100);

for i=1:100
    disp(i);
    rng(i);
    [Train, Test] = splitTrainTest(dist_img);

    TrainFeatures = Features(Train,:);
    TestFeatures  = Features(Test,:);
    
    YTest = dmos(Test);
    YTrain= dmos(Train);

    %Mdl = fitrgp(TrainFeatures,YTrain,'KernelFunction','rationalquadratic','Standardize',true);
    Mdl = fitrsvm(TrainFeatures,YTrain,'KernelFunction','gaussian','KernelScale','auto','Standardize',true);
    Pred= predict(Mdl,TestFeatures);
    
    beta(1) = max(YTest); 
    beta(2) = min(YTest); 
    beta(3) = mean(YTest);
    beta(4) = 0.5;
    beta(5) = 0.1;
    
    [bayta,ehat,J] = nlinfit(Pred,YTest,@logistic,beta);
    [pred_test_mos_align, ~] = nlpredci(@logistic,Pred,bayta,ehat,J);
    
    PLCC(i) = corr(pred_test_mos_align, YTest);
    SROCC(i)= corr(Pred, YTest, 'Type', 'Spearman');
    KROCC(i)= corr(Pred, YTest, 'Type', 'Kendall');
end

disp('----------------------------------');
X = ['Median PLCC after 100 random train-test splits: ', num2str(round(median(PLCC(:)),3))];
disp(X);
X = ['Median SROCC after 100 random train-test splits: ', num2str(round(median(SROCC(:)),3))];
disp(X);
X = ['Median KROCC after 100 random train-test splits: ', num2str(round(median(KROCC(:)),3))];
disp(X);