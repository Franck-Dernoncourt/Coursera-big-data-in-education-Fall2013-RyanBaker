addpath(genpath('lib'));

% Note: In bigdata-edu-Data-Sets-classifier-data-asgn2.csv you should
% replace every Y by 1 and N by 0 in the first column.
% 
% Requires:
%  - cohenskappa.m: http://www.tpingel.com/code/cohenskappa/cohenskappa.html
%  - getcm.m: http://people.cs.uchicago.edu/~dinoj/matlab/
%  - roundsd.m: http://www.mathworks.com/matlabcentral/fileexchange/26212-round-with-significant-digits
data_regressor = importdata('bigdata-edu-Data-Sets-regressor-data-asgn2.csv');
expected = data_regressor.data(:, 1);
predicted = data_regressor.data(:, 2);

% Q1: Using regressor-data-asgn2.csv, what is the Pearson correlation between data and predicted (model)? (Round to three significant digits; e.g. 0.24675 should be written as 0.247) (Hint: this is easy to compute in Excel)
roundsd(corr(expected, predicted, 'type', 'Pearson'), 3)

% Q2: Using regressor-data-asgn2.csv, what is the RMSE (root-mean-square error) between data and predicted (model)? (Round to three significant digits; e.g. 0.24675 should be written as 0.247) (Hint: this is easy to compute in Excel)
roundsd(sqrt(mean((predicted - expected).^2)), 3)

% Q3: Using regressor-data-asgn2.csv, what is the MAD (mean absolute deviation) between data and predicted (model)? (Round to three significant digits; e.g. 0.24675 should be written as 0.247) (Hint: this is easy to compute in Excel)
roundsd(mean(abs(predicted - expected)), 3)

% Q4: Using classifier-data-asgn2.csv, what is the accuracy of the predicted (model)? Assume a threshold of 0.5. (Just give a rounded value rather than including the decimal; e.g. write 57.213% as 57) (Hint: this is easy to compute in Excel)
data_classifier = importdata('bigdata-edu-Data-Sets-classifier-data-asgn2.csv');
expected_class = data_classifier.data(:, 1);
predicted_proba = data_classifier.data(:, 2);
predicted_class = (predicted_proba > 0.5);
roundsd(100*sum(expected_class == predicted_class) / length(expected_class), 2)

% Q5: Using classifier-data-asgn2.csv, how well would a detector perform (in terms of accuracy), if it always picked the majority (most common) class? (Just give a rounded value rather than including the decimal; e.g. write 57.213% as 57) (Hint: this is easy to compute in Excel)
most_common_class = length(find(expected_class == 0)) < length(find(expected_class == 1));
q5_answer = roundsd(100*length(find(expected_class == most_common_class)) / length(expected_class), 2)

% Q6: Is this detector’s performance better than chance, according to the accuracy and the frequency of the most common class?
q5_answer > 50

% Q7: What is this detector’s value for Cohen’s Kappa? Assume a threshold of 0.5. (Just round to the first two decimal places; e.g. write 0.74821 as 0.75).
roundsd(cohenskappa(predicted_class,expected_class), 2)

% Q8: What is this detector’s precision, assuming we are trying to predict “Y” and assuming a threshold of 0.5 (Just round to the first two decimal places; e.g. write 0.74821 as 0.75).
[confus,numcorrect,precision,recall,F] = getcm(expected_class,predicted_class, 0:1);
roundsd(precision, 2)

% Q9: What is this detector’s recall, assuming we are trying to predict “Y” and assuming a threshold of 0.5 (Just round to the first two decimal places; e.g. write 0.74821 as 0.75).
roundsd(recall, 2)

% Q10: Based on the precision and recall, should this detector be used for strong interventions that have a high cost if mis-applied, or fail-soft interventions with low benefit and a low cost if mis-applied?
% EITHER
% FAIL-SOFT
% STRONG
% NEITHER
% --> A: Strong

% Q11: What is this detector’s value for A’? (Hint: There are some data points with the exact same detector confidence, so it is probably preferable to use a tool that computes A’, such as http://www.columbia.edu/~rsb2162/computeAPrime.zip -- rather than a tool that computes the area under the ROC curve). Please round to two decimal places.
% Use http://radcliffe.github.io/Aprime.html





