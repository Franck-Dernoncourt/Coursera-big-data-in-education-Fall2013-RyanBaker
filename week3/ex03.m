clear all
close all

% filename = 'bigdata-edu-Data-Sets-Data-Subset-Pardos-et-al-2013-observations Week 3B.csv';
% delimiterIn = ',';
% headerlinesIn = 10;
% data_observations = importdata(filename,delimiterIn,headerlinesIn)
% data_observations.data

% filename = 'bigdata-edu-Data-Sets-Data-Subset-Pardos-et-al-2013-observations Week 3B - no header.csv'
% delimiterIn = ',';
% data_observations = importdata(filename,delimiterIn)

filename = 'bigdata-edu-Data-Sets-Data-Subset-Pardos-et-al-2013-observations Week 3B - no header.csv';
fileID = fopen(filename);
C = textscan(fileID,'%s %d %d %s %s %s %s','delimiter',',');
fclose(fileID);
C

% Q1: Aggregate the data to develop detectors at the student-level. Which student has the highest percentage of gaming? (Hint: One way to do this is to create a dummy variable for each observation, 1 if gaming, 0 if not gaming, and then make a pivot table)
% A: Open bigdata-edu-Data-Sets-Data-Subset-Pardos-et-al-2013-observations
% Week 3B.csv with Excel, sort by double-anon-userID and you'll see that the 
% student 39769525 has just one row, wwhich is flagged as GAMING, which
% means this student has a 100% of gaming. So 39769525 is the answer.

% http://stackoverflow.com/q/9998596/395857 (Create mysql table directly from CSV file using the CSV Storage engine?)
% http://stackoverflow.com/q/3070094/395857 (Generate table schema inspecting Excel(CSV) and import data)


