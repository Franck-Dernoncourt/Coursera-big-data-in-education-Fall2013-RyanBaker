% Requires:
%  - fdr_bh.m: http://www.mathworks.us/matlabcentral/fileexchange/27418-benjamini-hochbergyekutieli-procedure-for-controlling-false-discovery-rate

% Initializations
clear all
addpath(genpath('fdr_bh'));
data1 = importdata('bigdata-edu-Data-Sets-Asgn5-posthoc-data-v2-set1.csv');
data1 = data1.data;
pvals1 = data1(:, end);
correlation_column = 3;
p_column = 5;

% Q1: Data set 1 represents a set of distinct studies conducted on small populations of students – you might see these types of results if you administered a survey to the students of just one classroom teacher. Within data set 1, how many correlations are statistically significant (according to the customary p
sum(data1(:, p_column)<0.05) % 10

% Q2: If you apply a post-hoc Bonferroni control to these results, how many correlations remain statistically significant?
% https://www.quora.com/Statistics-academic-discipline/What-is-the-Bonferroni-correction
n = size(data1, 1);
bonf1 = (data1(:, p_column))<0.05/n;
sum(bonf1) % 5

% Q3: If you apply Benjamini & Hochberg’s FDR Correction to these results, how many correlations remain statistically significant?
% fdr_bh(pvals1)
fdr_bh_values1 = fdr_bh(pvals1, 0.05);
sum(fdr_bh_values1) % 9

% Q4: What is the correlation with the lowest p-value that comes up significant for B&H but not for Bonferroni?
temp = (bonf1 == 0 & fdr_bh_values1 == 1).*pvals1;
temp(~temp) = nan;
[~, idx] = min(temp);
data1(idx, correlation_column) % 0.237749612

% Q5: Data set 2 represents a larger set of correlations within data from a larger population of students – for example, the entire population of students using a medium-sized online learning environment. Within data set 2, how many of the 1,112 correlations are NOT statistically significant (according to the customary p
data2 = importdata('bigdata-edu-Data-Sets-Asgn5-posthoc-data-v2-set2.csv');
data2 = data2.data;
pvals2 = data2(:, end);
sum(data2(:, p_column)>0.05) % 19

% Q6: If you apply a post-hoc Bonferroni control to these results, how many correlations are now NOT statistically significant?
n = size(data2, 1);
bonf2 = (data2(:, p_column))<0.05/n;
sum(~bonf2) % 28

% Q7: If you apply Benjamini & Hochberg’s FDR Correction to these results, how many correlations are now NOT statistically significant?
fdr_bh_values2 = fdr_bh(pvals2, 0.05);
sum(~fdr_bh_values2) % 19

% Q8: What is the lowest correlation that is still statistically significant, according to Bonferroni’s test?
% temp = ().*pvals2;
% temp(~temp) = nan;
% [~, idx] = min(temp);
min(data2(bonf2 == 1, correlation_column)) % 0.01609085

% Q9: Now do you see why Professor Baker says that statistical significance doesn’t matter much for really big data sets? (and this is NOT a big data set by reckoning in other fields)
%  - No. Big data is a FAD. No one should ever expect to work with a data set over 150 data points, after the societal collapse predicted by James Howard Kunstler occurs.
%  - No. I think the answer to Question 8 is a fine correlation, perfectly likely to represent a large effect size.
%  - Yes – Bonferroni is ridiculously conservative with 1,112 tests, and yet correlations that are absurdly small still come up statistically significant.



