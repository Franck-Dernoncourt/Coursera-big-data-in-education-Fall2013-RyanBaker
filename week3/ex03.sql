-- Q1: Aggregate the data to develop detectors at the student-level. Which student has the highest percentage of gaming? (Hint: One way to do this is to create a dummy variable for each observation, 1 if gaming, 0 if not gaming, and then make a pivot table)
-- A: Open bigdata-edu-Data-Sets-Data-Subset-Pardos-et-al-2013-observations
-- Week 3B.csv with Excel, sort by double-anon-userID and you'll see that the 
-- student 39769525 has just one row, wwhich is flagged as GAMING, which
-- means this student has a 100% of gaming. So 39769525 is the answer.

-- http://stackoverflow.com/q/9998596/395857 (Create mysql table directly from CSV file using the CSV Storage engine?)
-- http://stackoverflow.com/q/3070094/395857 (Generate table schema inspecting Excel(CSV) and import data)
-- --> Use http://www.convertcsvtomysql.com/

-- Q2: Aggregate the data to develop detectors at the student-level. How many students were never bored in any observation?
SELECT 
    COUNT(*)
FROM
    (SELECT 
        bdw03observations.double_anon_userid
    FROM
        bdw03observations
    WHERE
        bdw03observations.double_anon_userid NOT IN (SELECT 
                bdw03observations.double_anon_userid
            FROM
                bdw03observations
            WHERE
                bdw03observations.affect = 'BORED'
            GROUP BY bdw03observations.double_anon_userid)
GROUP BY bdw03observations.double_anon_userid) t1;

-- Q3: Aggregate the data to develop detectors at the day-level. What percentage of the time was student 30314880 gaming on 10/15? (Give just the first four digits, rounding down -- e.g. for 22.33%, type 22.33)
-- A: Just count manually
SELECT 1 / 6;

-- Q4: Why are problem-level detectors not useful for this data set?
-- 1. There’s usually only one observation per student per problem
-- 2. There aren’t enough distinct problems in the data set
-- 3. Problem-level detection is always a bad idea
-- 4. There aren’t enough repeated problems in the data set
-- A: 4 (you can see in the data that each problem has very few observations)
-- Q5: On the average, how many actions occur in an observation? (Each action is a row in the actions data set) (Give just the first four digits, rounding down)
SELECT 
    AVG(t1.cnt)
FROM
    (SELECT 
        COUNT(*) cnt
    FROM
        bdw03actions
    GROUP BY bdw03actions.observationid_fullanon) t1;

-- Q6: Note that there are two observations with way more actions than other observations. These might be logging errors, but they also might be a student repeatedly hitting enter really, really fast. If you eliminate these two observations, then on the average, how many actions occur in an observation? (Each action is a row in the actions data set) (Give just the first four digits, rounding down)
-- FYI: http://stackoverflow.com/q/255517/395857 (in short, you cannot use OFFSET without LIMIT in MySQL... that's a pretty crazy limitation)
-- Note that 18446744073709551615 is 2^64-1
SELECT 
    AVG(t1.cnt)
FROM
    (SELECT 
        COUNT(*) cnt
    FROM
        bdw03actions
    GROUP BY bdw03actions.observationid_fullanon
    ORDER BY cnt DESC
    LIMIT 2 , 18446744073709551615) t1;

-- Q7: Aggregate the data to develop detectors at the observation-level. If you create a feature of the average timeTaken during an observation, what is the average timeTaken for MFDTT-mathasst-9-at_12:58:03-79? (Give just the first four digits, rounding down)
SELECT 
    COUNT(*) cnt, AVG(bdw03actions.timetaken)
FROM
    bdw03actions
WHERE
    bdw03actions.observationid_fullanon = 'MFDTT-mathasst-9-at_12:58:03-79';

-- Q8: Aggregate the data to develop detectors at the observation-level. If you create a feature of the maximum timeTaken during an observation, what is the maximum timeTaken for EGMDH-math_assistments-4-at_10:34:30-9? (Give just the first four digits, rounding down)
SELECT 
    COUNT(*) cnt, MAX(bdw03actions.timetaken)
FROM
    bdw03actions
WHERE
    bdw03actions.observationid_fullanon = 'EGMDH-math_assistments-4-at_10:34:30-9';