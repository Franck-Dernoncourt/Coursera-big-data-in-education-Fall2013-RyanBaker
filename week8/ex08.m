

clear all;
fileID = fopen('data-coursera-sn-asgn1-for-asgn8.txt');
d = textscan(fileID, '%f %f %f %f'); % Data deleted headers are: ID	poster	thread	response-to
d = [d{[1 2 3 4]}];

% Q1: How many possible connections are there between individuals in this graph, not counting self-connections, and assuming that link direction does not matter?
number_of_students = length(unique(d(:, 2)));
nchoosek(number_of_students, 2) % 5356

% My grade

1+1+1+1+7/11+9/10

% Q7: Which individual has the most posts?
mode(d(:, 2))

5/10