function Performance = performance(predictlabel,targetlabel)

AUC = calculate_roc(predictlabel, targetlabel);

predictlabel_zhuanzhi = predictlabel';
targetlabel_zhuanzhi = targetlabel';

TN = 0;
FP = 0;
FN = 0;
TP = 0;
for i = 1:size(targetlabel_zhuanzhi,2)
    if (targetlabel_zhuanzhi(i)== 0 && predictlabel_zhuanzhi(i) == 0)
	    TN = TN + 1;
	elseif (targetlabel_zhuanzhi(i) == 0 && predictlabel_zhuanzhi(i) == 1)
        FP = FP + 1;
	elseif (targetlabel_zhuanzhi(i) == 1 && predictlabel_zhuanzhi(i) == 0)
        FN = FN + 1;
    else
        TP = TP + 1;
    end
end

TN
FP
FN
TP

%求基本指标
Accuracy = (TN + TP) / (TN + FP + FN + TP);
Recall = TP / (TP + FN);
Pd = Recall;
Precision = TP / (TP + FP);
False_Positive = FP / (FP + TN);
Pf = False_Positive;
F_measure = 2 * Precision * Recall / (Precision + Recall);
%F_2 = 5 * Precision * Recall / (4 * Precision + Recall);
G_measure = 2 * Recall * (1 - False_Positive) / (Recall + (1 - False_Positive));
g_mean = sqrt((TN / (TN + FP)) * (TP / (TP + FN)));
Bal = 1- sqrt((0-Pf)^2+(1-Pd)^2)/sqrt(2);
MCC = (TP * TN - FN * FP) / sqrt((TP + FN) * (TP + FP) * (FN + TN) * (FP + TN));
%[~,~,~,AUC] = perfcurve(targetlabel,logitFit,1);

Performance_in = [Precision, Recall, Pf, F_measure, G_measure, g_mean, Bal, MCC];

TN2 = 0;
FP2 = 0;
FN2 = 0;
TP2 = 0;
for i = 1:size(targetlabel_zhuanzhi,2)
    if (targetlabel_zhuanzhi(i)== 1 && predictlabel_zhuanzhi(i) == 1)
	    TN2 = TN2 + 1;
	elseif (targetlabel_zhuanzhi(i) == 1 && predictlabel_zhuanzhi(i) == 0)
        FP2 = FP2 + 1;
	elseif (targetlabel_zhuanzhi(i) == 0 && predictlabel_zhuanzhi(i) == 1)
        FN2 = FN2 + 1;
    else
        TP2 = TP2 + 1;
    end
end

%求基本指标
Accuracy2 = (TN2 + TP2) / (TN2 + FP2 + FN2 + TP2);
Recall2 = TP2 / (TP2 + FN2);
Pd2 = Recall2;
Precision2 = TP2 / (TP2 + FP2);
False_Positive2 = FP2 / (FP2 + TN2);
Pf2 = False_Positive2;
F_measure2 = 2 * Precision2 * Recall2 / (Precision2 + Recall2);
% F_2 = 5 * Precision * Recall / (4 * Precision + Recall);
G_measure2 = 2 * Recall2 * (1 - False_Positive2) / (Recall2 + (1 - False_Positive2));
g_mean2 = sqrt((TN2 / (TN2 + FP2)) * (TP2 / (TP2 + FN2)));
Bal2 = 1- sqrt((0-Pf2)^2+(1-Pd2)^2)/sqrt(2);
MCC2 = (TP2 * TN2 - FN2 * FP2) / sqrt((TP2 + FN2) * (TP2 + FP2) * (FN2 + TN2) * (FP2 + TN2));
Performance_out = [Accuracy2, Precision2, Recall2, F_measure2, G_measure2, g_mean2, Bal2, MCC2, AUC];
test = [F_measure F_measure2 MCC AUC]
Performance = [Performance_in, Performance_out];