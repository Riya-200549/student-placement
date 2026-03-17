DROP TABLE IF EXISTS student;

CREATE TABLE student (
school TEXT,
sex TEXT,
age INT,
address TEXT,
famsize TEXT,
Pstatus TEXT,
Medu INT,
Fedu INT,
Mjob TEXT,
Fjob TEXT,
reason TEXT,
guardian TEXT,
traveltime INT,
studytime INT,
failures INT,
schoolsup TEXT,
famsup TEXT,
paid TEXT,
activities TEXT,
nursery TEXT,
higher TEXT,
internet TEXT,
romantic TEXT,
famrel INT,
freetime INT,
goout INT,
Dalc INT,
Walc INT,
health INT,
absences INT,
G1 INT,
G2 INT,
G3 INT
);

COPY student
FROM 'C:/Math-Students.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*) FROM student;

SELECT * FROM student LIMIT 10;

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'student';

SELECT COUNT(*) 
FROM student
WHERE age IS NULL;

SELECT sex, COUNT(*)
FROM student
GROUP BY sex;

SELECT famsize, COUNT(*)
FROM student
GROUP BY famsize;

SELECT age, sex, G3
FROM student
ORDER BY G3 DESC
LIMIT 10;

SELECT AVG(G3)
FROM student;

SELECT studytime, AVG(G3)
FROM student
GROUP BY studytime
ORDER BY studytime;

DROP TABLE IF EXISTS placement_anxiety;

CREATE TABLE placement_anxiety (
Student_ID TEXT,
Branch TEXT,
CGPA FLOAT,
Intenship INT,
Mock_Test_Score INT,
Coding_Hours_Per_Week INT,
Resume_Score INT,
Anxiety_Level TEXT,
Expected_Package_LPA FLOAT,
Placement_Status TEXT
);

COPY placement_anxiety
FROM 'C:/student_placement_anxiety_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*) FROM placement_anxiety;

SELECT * FROM placement_anxiety LIMIT 5;

SELECT branch, COUNT(*) 
FROM placement_anxiety
GROUP BY branch
ORDER BY COUNT(*) DESC;

SELECT branch, AVG(mock_test_score)
FROM placement_anxiety
GROUP BY branch;

SELECT Anxiety_Level, COUNT(*)
FROM placement_anxiety
GROUP BY Anxiety_Level
ORDER BY COUNT(*) DESC;

SELECT branch, Anxiety_Level, COUNT(*)
FROM placement_anxiety
GROUP BY branch, Anxiety_Level
ORDER BY branch;

SELECT branch, Anxiety_Level, COUNT(*)
FROM placement_anxiety
GROUP BY branch, Anxiety_Level
ORDER BY branch LIMIT(6);

SELECT Anxiety_Level, AVG(Coding_Hours_Per_Week)
FROM placement_anxiety
GROUP BY Anxiety_Level;

SELECT branch, AVG(Coding_Hours_Per_Week)
FROM placement_anxiety
GROUP BY branch
ORDER BY AVG(Coding_Hours_Per_Week) DESC;

SELECT branch, AVG(mock_test_score)
FROM placement_anxiety
GROUP BY branch
ORDER BY AVG(mock_test_score) DESC;

SELECT Anxiety_Level, AVG(mock_test_score)
FROM placement_anxiety
GROUP BY Anxiety_Level;

SELECT student_id, branch, mock_test_score
FROM placement_anxiety
ORDER BY mock_test_score DESC
LIMIT 20;

DROP TABLE IF EXISTS student;

CREATE TABLE student (
school TEXT,
sex TEXT,
age INT,
address TEXT,
famsize TEXT,
Pstatus TEXT,
Medu INT,
Fedu INT,
Mjob TEXT,
Fjob TEXT,
reason TEXT,
guardian TEXT,
traveltime INT,
studytime INT,
failures INT,
schoolsup TEXT,
famsup TEXT,
paid TEXT,
activities TEXT,
nursery TEXT,
higher TEXT,
internet TEXT,
romantic TEXT,
famrel INT,
freetime INT,
goout INT,
Dalc INT,
Walc INT,
health INT,
absences INT,
G1 INT,
G2 INT,
G3 INT
);

COPY student
FROM 'C:/Math-Students.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*) FROM student;

SELECT * FROM student LIMIT 10;

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'student';

SELECT COUNT(*) 
FROM student
WHERE age IS NULL;

SELECT sex, COUNT(*)
FROM student
GROUP BY sex;

SELECT famsize, COUNT(*)
FROM student
GROUP BY famsize;

SELECT age, sex, G3
FROM student
ORDER BY G3 DESC
LIMIT 10;

SELECT AVG(G3)
FROM student;

SELECT studytime, AVG(G3)
FROM student
GROUP BY studytime
ORDER BY studytime;

DROP TABLE IF EXISTS placement_anxiety;

CREATE TABLE placement_anxiety (
Student_ID TEXT,
Branch TEXT,
CGPA FLOAT,
Intenship INT,
Mock_Test_Score INT,
Coding_Hours_Per_Week INT,
Resume_Score INT,
Anxiety_Level TEXT,
Expected_Package_LPA FLOAT,
Placement_Status TEXT
);

COPY placement_anxiety
FROM 'C:/student_placement_anxiety_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*) FROM placement_anxiety;

SELECT * FROM placement_anxiety LIMIT 5;

SELECT branch, COUNT(*) 
FROM placement_anxiety
GROUP BY branch
ORDER BY COUNT(*) DESC;

SELECT branch, AVG(mock_test_score)
FROM placement_anxiety
GROUP BY branch;

SELECT Anxiety_Level, COUNT(*)
FROM placement_anxiety
GROUP BY Anxiety_Level
ORDER BY COUNT(*) DESC;

SELECT branch, Anxiety_Level, COUNT(*)
FROM placement_anxiety
GROUP BY branch, Anxiety_Level
ORDER BY branch;

SELECT branch, Anxiety_Level, COUNT(*)
FROM placement_anxiety
GROUP BY branch, Anxiety_Level
ORDER BY branch LIMIT(6);

SELECT Anxiety_Level, AVG(Coding_Hours_Per_Week)
FROM placement_anxiety
GROUP BY Anxiety_Level;

SELECT branch, AVG(Coding_Hours_Per_Week)
FROM placement_anxiety
GROUP BY branch
ORDER BY AVG(Coding_Hours_Per_Week) DESC;

SELECT branch, AVG(mock_test_score)
FROM placement_anxiety
GROUP BY branch
ORDER BY AVG(mock_test_score) DESC;

SELECT Anxiety_Level, AVG(mock_test_score)
FROM placement_anxiety
GROUP BY Anxiety_Level;

SELECT student_id, branch, mock_test_score
FROM placement_anxiety
ORDER BY mock_test_score DESC
LIMIT 20;

SELECT branch, COUNT(*) AS total_students
FROM placement_anxiety
WHERE Anxiety_Level = 'High'
GROUP BY branch
ORDER BY total_students DESC;

DROP TABLE IF EXISTS  student_performance;

CREATE TABLE student_performance(
student_id INT,
weekly_self_study_hours FLOAT,
attendance_percentage FLOAT,
class_participation FLOAT,
total_score FLOAT,
grade TEXT
);

COPY student_performance
FROM 'C:/student_performance.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM student_performance LIMIT 10;

SELECT COUNT(*) FROM student_performance;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'student_performance';

SELECT *
FROM student_performance sp
JOIN placement_anxiety pa
ON sp.student_id = CAST(REPLACE(pa.Student_ID, 'S', '') AS INTEGER);

CREATE TABLE merged_data AS
SELECT sp.student_id,
       sp.weekly_self_study_hours,
       sp.attendance_percentage,
       sp.total_score,
       sp.grade,
       pa.Anxiety_Level,
       pa.Branch,
       pa.Coding_Hours_Per_Week
FROM student_performance sp
JOIN placement_anxiety pa
ON sp.student_id = CAST(REPLACE(pa.Student_ID, 'S', '') AS INTEGER);

SELECT COUNT(*) FROM merged_data;

SELECT * FROM merged_data LIMIT 10;

SELECT Anxiety_Level,
       AVG(total_score) AS avg_score
FROM merged_data
GROUP BY Anxiety_Level
ORDER BY avg_score DESC;

SELECT Anxiety_Level,
       AVG(weekly_self_study_hours) AS avg_study_hours
FROM merged_data
GROUP BY Anxiety_Level;

SELECT 
    AVG(attendance_percentage) AS avg_attendance,
    AVG(weekly_self_study_hours) AS avg_study_hours,
    AVG(total_score) AS avg_score
FROM merged_data;

SELECT grade,
       Anxiety_level,
       COUNT(*) AS student_count
FROM merged_data
GROUP BY grade, Anxiety_Level
ORDER BY grade;

SELECT branch,
       AVG(total_score) AS avg_score
FROM merged_data
GROUP BY branch
ORDER BY avg_score DESC;

SELECT CORR(weekly_self_study_hours, total_score) 
AS study_score_correlation
FROM merged_data;

SELECT CORR(attendance_percentage, total_score) 
AS attendance_score_correlation
FROM merged_data;

SELECT 
CASE 
   WHEN total_score >= 75 THEN 'High Performer'
   ELSE 'Low Performer'
END AS performance_level,
AVG(weekly_self_study_hours) AS avg_study_hours,
AVG(attendance_percentage) AS avg_attendance
FROM merged_data
GROUP BY performance_level;

SELECT 
    CORR(total_score, weekly_self_study_hours) AS corr_studytime,
    CORR(total_score, attendance_percentage) AS corr_attendance_percentage
FROM merged_data;