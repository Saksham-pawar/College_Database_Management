CREATE DATABASE college_db;

use college_db;

-- creating tables 
-- 1. DEPARTMENTS
CREATE TABLE departments (
    department_id   INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    department_code VARCHAR(10)  NOT NULL UNIQUE
);

-- 2. FACULTY
CREATE TABLE faculty (
    faculty_id    INT AUTO_INCREMENT PRIMARY KEY,
    first_name    VARCHAR(50)  NOT NULL,
    last_name     VARCHAR(50)  NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    designation   VARCHAR(50)  NOT NULL DEFAULT 'Assistant Professor',
    department_id INT          NOT NULL,
    CONSTRAINT fk_faculty_department
        FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- 3. STUDENTS
CREATE TABLE students (
    student_id    INT AUTO_INCREMENT PRIMARY KEY,
    roll_number   VARCHAR(20)  NOT NULL UNIQUE,
    first_name    VARCHAR(50)  NOT NULL,
    last_name     VARCHAR(50)  NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    gender        ENUM('Male','Female','Other') NOT NULL,
    cgpa          DECIMAL(4,2) NOT NULL DEFAULT 0.00,
    department_id INT          NOT NULL,
    CONSTRAINT chk_student_cgpa CHECK (cgpa BETWEEN 0 AND 10),
    CONSTRAINT fk_student_department
        FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- 4. SUBJECTS
CREATE TABLE subjects (
    subject_id    INT AUTO_INCREMENT PRIMARY KEY,
    subject_code  VARCHAR(15)  NOT NULL UNIQUE,
    subject_name  VARCHAR(100) NOT NULL,
    department_id INT          NOT NULL,
    faculty_id    INT          NOT NULL,
    CONSTRAINT fk_subject_department
        FOREIGN KEY (department_id) REFERENCES departments(department_id),
    CONSTRAINT fk_subject_faculty
        FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);

-- 5. ENROLLMENTS
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id    INT NOT NULL,
    subject_id    INT NOT NULL,
    CONSTRAINT uq_student_subject UNIQUE (student_id, subject_id),
    CONSTRAINT fk_enroll_student FOREIGN KEY (student_id) REFERENCES students(student_id),
    CONSTRAINT fk_enroll_subject FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- 6. MARKS
CREATE TABLE marks (
    mark_id        INT AUTO_INCREMENT PRIMARY KEY,
    student_id     INT          NOT NULL,
    subject_id     INT          NOT NULL,
    marks_obtained DECIMAL(5,2) NOT NULL,
    CONSTRAINT uq_student_subject_mark UNIQUE (student_id, subject_id),
    CONSTRAINT fk_marks_student FOREIGN KEY (student_id) REFERENCES students(student_id),
    CONSTRAINT fk_marks_subject FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- 7. FEES
CREATE TABLE fees (
    fee_id       INT AUTO_INCREMENT PRIMARY KEY,
    student_id   INT           NOT NULL UNIQUE,
    total_amount DECIMAL(10,2) NOT NULL,
    amount_paid  DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    due_date     DATE          NOT NULL,
    fee_status   ENUM('Unpaid','Partial','Paid') NOT NULL DEFAULT 'Unpaid',
    CONSTRAINT chk_fee_total CHECK (total_amount > 0),
    CONSTRAINT chk_fee_paid  CHECK (amount_paid >= 0 AND amount_paid <= total_amount),
    CONSTRAINT fk_fee_student FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Inserting values in tables
-- 1. DEPARTMENTS
INSERT INTO departments (department_id, department_name, department_code) VALUES
(1, 'Computer Science and Engineering', 'CSE'),
(2, 'Information Technology', 'IT'),
(3, 'Mechanical Engineering', 'MECH');

-- 2. FACULTY
INSERT INTO faculty (faculty_id, first_name, last_name, email, designation, department_id) VALUES
(1, 'Meera', 'Kulkarni', 'meera.kulkarni@demo-college.edu', 'Professor', 1),
(2, 'Rajesh', 'Patil', 'rajesh.patil@demo-college.edu', 'Associate Professor', 1),
(3, 'Anita', 'Deshpande', 'anita.deshpande@demo-college.edu', 'Assistant Professor', 1),
(4, 'Sanjay', 'Kelkar', 'sanjay.kelkar@demo-college.edu', 'Assistant Professor', 1),
(5, 'Suresh', 'Iyer', 'suresh.iyer@demo-college.edu', 'Professor', 2),
(6, 'Pallavi', 'Joshi', 'pallavi.joshi@demo-college.edu', 'Associate Professor', 2),
(7, 'Amit', 'Bhatt', 'amit.bhatt@demo-college.edu', 'Assistant Professor', 2),
(8, 'Vinod', 'Shinde', 'vinod.shinde@demo-college.edu', 'Professor', 3),
(9, 'Kavita', 'Gokhale', 'kavita.gokhale@demo-college.edu', 'Assistant Professor', 3),
(10, 'Nitin', 'Phadke', 'nitin.phadke@demo-college.edu', 'Assistant Professor', 3);

-- 3. STUDENTS
INSERT INTO students (student_id, roll_number, first_name, last_name, email, gender, cgpa, department_id) VALUES
(1, 'CSE25001', 'Aarav', 'Sharma', 'aarav.sharma@student.demo-college.edu', 'Male', 8.72, 1),
(2, 'CSE25002', 'Ananya', 'Iyer', 'ananya.iyer@student.demo-college.edu', 'Female', 9.41, 1),
(3, 'CSE25003', 'Rohan', 'Deshmukh', 'rohan.deshmukh@student.demo-college.edu', 'Male', 7.35, 1),
(4, 'CSE25004', 'Karan', 'Mehta', 'karan.mehta@student.demo-college.edu', 'Male', 5.92, 1),
(5, 'IT25001', 'Kavya', 'Menon', 'kavya.menon@student.demo-college.edu', 'Female', 9.56, 2),
(6, 'IT25002', 'Siddharth', 'Rao', 'siddharth.rao@student.demo-college.edu', 'Male', 6.45, 2),
(7, 'IT25003', 'Pranav', 'Jadhav', 'pranav.jadhav@student.demo-college.edu', 'Male', 5.55, 2),
(8, 'IT25004', 'Neha', 'Singh', 'neha.singh@student.demo-college.edu', 'Female', 7.23, 2),
(9, 'MECH25001', 'Yash', 'Chavan', 'yash.chavan@student.demo-college.edu', 'Male', 7.12, 3),
(10, 'MECH25002', 'Shreya', 'Bhosale', 'shreya.bhosale@student.demo-college.edu', 'Female', 8.65, 3),
(11, 'MECH25003', 'Rahul', 'Yadav', 'rahul.yadav@student.demo-college.edu', 'Male', 5.8, 3),
(12, 'MECH25004', 'Sakshi', 'Gaikwad', 'sakshi.gaikwad@student.demo-college.edu', 'Female', 8.95, 3);

-- 4. SUBJECTS
INSERT INTO subjects (subject_id, subject_code, subject_name, department_id, faculty_id) VALUES
(1, 'CS301', 'Data Structures', 1, 1),
(2, 'CS302', 'Database Management Systems', 1, 2),
(3, 'CS303', 'Operating Systems', 1, 3),
(4, 'IT301', 'Web Technologies', 2, 6),
(5, 'IT302', 'Computer Networks', 2, 5),
(6, 'IT303', 'Python Programming', 2, 5),
(7, 'ME301', 'Thermodynamics', 3, 8),
(8, 'ME302', 'Strength of Materials', 3, 9),
(9, 'ME303', 'Manufacturing Processes', 3, 10);

-- 5. ENROLLMENTS
INSERT INTO enrollments (student_id, subject_id)
SELECT st.student_id, sb.subject_id
FROM students st
JOIN subjects sb ON sb.department_id = st.department_id
ORDER BY st.student_id, sb.subject_id;

-- 6. MARKS
INSERT INTO marks (student_id, subject_id, marks_obtained) VALUES
(1, 1, 92.5),
(1, 2, 92.0),
(1, 3, 75.5),
(2, 1, 93.0),
(2, 2, 97.5),
(2, 3, 96.5),
(3, 1, 67.5),
(3, 2, 69.0),
(3, 3, 75.0),
(4, 1, 52.0),
(4, 2, 58.0),
(4, 3, 34.0),
(5, 4, 85.5),
(5, 5, 95.5),
(5, 6, 87.5),
(6, 4, 65.0),
(6, 5, 73.0),
(6, 6, 38.0),
(7, 4, 36.0),
(7, 5, 32.5),
(7, 6, 64.0),
(8, 4, 79.5),
(8, 5, 62.0),
(8, 6, 75.5),
(9, 7, 67.5),
(9, 8, 63.0),
(9, 9, 72.5),
(10, 7, 91.0),
(10, 8, 99.0),
(10, 9, 85.0),
(11, 7, 66.0),
(11, 8, 29.0),
(11, 9, 42.0),
(12, 7, 87.0),
(12, 8, 89.5),
(12, 9, 85.5);

-- 7. FEES
INSERT INTO fees (student_id, total_amount, amount_paid, due_date, fee_status) VALUES
(1, 125000, 125000, '2026-08-31', 'Paid'),
(2, 125000, 125000, '2026-08-31', 'Paid'),
(3, 125000, 60000, '2026-08-31', 'Partial'),
(4, 125000, 0, '2026-08-31', 'Unpaid'),
(5, 120000, 120000, '2026-08-31', 'Paid'),
(6, 120000, 60000, '2026-08-31', 'Partial'),
(7, 120000, 0, '2026-08-31', 'Unpaid'),
(8, 120000, 120000, '2026-08-31', 'Paid'),
(9, 105000, 105000, '2026-08-31', 'Paid'),
(10, 105000, 105000, '2026-08-31', 'Paid'),
(11, 105000, 50000, '2026-08-31', 'Partial'),
(12, 105000, 105000, '2026-08-31', 'Paid');

-- view data 

select * from students;
select * from faculty;
select * from students;
select * from subjects;
select * from enrollments;
select * from marks;
select * from fees;

-- basic operations

-- Students of one department
SELECT roll_number, first_name, last_name, cgpa
FROM students
WHERE department_id = 1;

-- Students above a CGPA of 8
SELECT roll_number, first_name, last_name, cgpa
FROM students
WHERE cgpa > 8;

-- Names starting with 'A'
SELECT roll_number, first_name, last_name
FROM students
WHERE first_name LIKE 'A%';

-- Names ending with 'a'
SELECT roll_number, first_name, last_name
FROM students
WHERE first_name LIKE '%a';

-- Sort students by CGPA, highest first
SELECT roll_number, first_name, last_name, cgpa
FROM students
ORDER BY cgpa DESC;

-- Top 3 students only
SELECT roll_number, first_name, last_name, cgpa
FROM students
ORDER BY cgpa DESC
LIMIT 3;

-- Count students per department
SELECT department_id, COUNT(*) AS total_students
FROM students
GROUP BY department_id
ORDER BY department_id;

-- Count students by gender
SELECT gender, COUNT(*) AS total_students
FROM students
GROUP BY gender
ORDER BY gender;

-- Average CGPA per department
SELECT department_id, ROUND(AVG(cgpa), 2) AS avg_cgpa
FROM students
GROUP BY department_id
ORDER BY department_id;

-- Only departments whose average CGPA is above 7.5 
SELECT department_id, ROUND(AVG(cgpa), 2) AS avg_cgpa
FROM students
GROUP BY department_id
HAVING AVG(cgpa) > 7.5
ORDER BY department_id;

-- Highest, lowest and average marks
SELECT MAX(marks_obtained) AS highest_marks,
       MIN(marks_obtained) AS lowest_marks,
       ROUND(AVG(marks_obtained), 2) AS average_marks
FROM marks;

-- Failing marks: below 40 out of 100
SELECT student_id, subject_id, marks_obtained
FROM marks
WHERE marks_obtained < 40
ORDER BY marks_obtained;

-- Students who have not paid their fees in full 
SELECT student_id, total_amount, amount_paid,
       total_amount - amount_paid AS outstanding,
       fee_status
FROM fees
WHERE fee_status <> 'Paid'
ORDER BY outstanding DESC;

-- CGPA from 7 to 8, in departments 1 or 3 
SELECT roll_number, first_name, last_name, cgpa, department_id
FROM students
WHERE cgpa BETWEEN 7 AND 8
  AND department_id IN (1, 3);

-- the different designations in the faculty table
SELECT DISTINCT designation
FROM faculty
ORDER BY designation;

-- Joins

-- INNER JOIN: student + department
SELECT s.roll_number, s.first_name, s.last_name, d.department_name
FROM students s
INNER JOIN departments d ON d.department_id = s.department_id
ORDER BY s.student_id;

-- Join Three tables: student + enrollments + subject
SELECT s.first_name, s.last_name, sb.subject_code, sb.subject_name
FROM students s
INNER JOIN enrollments e ON e.student_id = s.student_id
INNER JOIN subjects sb   ON sb.subject_id = e.subject_id
WHERE s.student_id = 1
ORDER BY sb.subject_code;

-- Student + marks + subject 
SELECT s.first_name, s.last_name, sb.subject_name, m.marks_obtained
FROM students s
INNER JOIN marks m     ON m.student_id = s.student_id
INNER JOIN subjects sb ON sb.subject_id = m.subject_id
WHERE s.student_id = 7
ORDER BY sb.subject_code;

-- Subject + faculty + department
SELECT sb.subject_code, sb.subject_name,
       CONCAT(f.first_name, ' ', f.last_name) AS teacher,
       d.department_code
FROM subjects sb
INNER JOIN faculty f      ON f.faculty_id = sb.faculty_id
INNER JOIN departments d  ON d.department_id = sb.department_id
ORDER BY sb.subject_id;

-- LEFT JOIN: ALL faculty, with their subjects if they have any 
SELECT f.faculty_id, f.first_name, f.last_name, sb.subject_code, sb.subject_name
FROM faculty f
LEFT JOIN subjects sb ON sb.faculty_id = f.faculty_id
ORDER BY f.faculty_id, sb.subject_id;

-- LEFT JOIN + IS NULL: faculty who teach NO subject
SELECT f.faculty_id, f.first_name, f.last_name, f.designation
FROM faculty f
LEFT JOIN subjects sb ON sb.faculty_id = f.faculty_id
WHERE sb.subject_id IS NULL;

-- Student + fees: student with pending fees
SELECT s.roll_number, s.first_name, s.last_name,
       f.total_amount, f.amount_paid,
       f.total_amount - f.amount_paid AS outstanding,
       f.fee_status
FROM students s
INNER JOIN fees f ON f.student_id = s.student_id
WHERE f.fee_status <> 'Paid'
ORDER BY outstanding DESC;

-- Five-table JOIN: failing marks with full details 
SELECT s.roll_number,
       CONCAT(s.first_name, ' ', s.last_name) AS student,
       d.department_code,
       sb.subject_name,
       CONCAT(fa.first_name, ' ', fa.last_name) AS teacher,
       m.marks_obtained
FROM marks m
INNER JOIN students s     ON s.student_id = m.student_id
INNER JOIN subjects sb    ON sb.subject_id = m.subject_id
INNER JOIN departments d  ON d.department_id = s.department_id
INNER JOIN faculty fa     ON fa.faculty_id = sb.faculty_id
WHERE m.marks_obtained < 40
ORDER BY m.marks_obtained;

-- JOIN + GROUP BY: students and average CGPA per department NAME
SELECT d.department_name,
       COUNT(s.student_id) AS total_students,
       ROUND(AVG(s.cgpa), 2) AS avg_cgpa
FROM departments d
INNER JOIN students s ON s.department_id = d.department_id
GROUP BY d.department_id, d.department_name
ORDER BY avg_cgpa DESC;

-- ADVANCED ANALYTICAL QUERIES

-- 1. Students above overall average CGPA
SELECT
    s.roll_number,
    CONCAT(s.first_name, ' ', s.last_name) AS student,
    d.department_name,
    s.cgpa
FROM students s
JOIN departments d ON d.department_id = s.department_id
WHERE s.cgpa > (SELECT AVG(cgpa) FROM students)
ORDER BY s.cgpa DESC;

-- 2. Students above their department average
SELECT
    s.roll_number,
    CONCAT(s.first_name, ' ', s.last_name) AS student,
    d.department_name,
    s.cgpa,
    ROUND(dept_avg.avg_cgpa, 2) AS department_average
FROM students s
JOIN departments d ON d.department_id = s.department_id
JOIN (
    SELECT department_id, AVG(cgpa) AS avg_cgpa
    FROM students
    GROUP BY department_id
) dept_avg ON dept_avg.department_id = s.department_id
WHERE s.cgpa > dept_avg.avg_cgpa
ORDER BY d.department_name, s.cgpa DESC;

-- 3. Average marks for every subject
SELECT
    sb.subject_code,
    sb.subject_name,
    ROUND(AVG(m.marks_obtained), 2) AS average_marks,
    COUNT(m.student_id) AS students
FROM subjects sb
JOIN marks m ON m.subject_id = sb.subject_id
GROUP BY sb.subject_id, sb.subject_code, sb.subject_name
ORDER BY average_marks DESC;

-- 4. Subjects with average above 70
SELECT
    sb.subject_code,
    sb.subject_name,
    ROUND(AVG(m.marks_obtained), 2) AS average_marks
FROM subjects sb
JOIN marks m ON m.subject_id = sb.subject_id
GROUP BY sb.subject_id, sb.subject_code, sb.subject_name
HAVING AVG(m.marks_obtained) > 70
ORDER BY average_marks DESC;

-- 5. Student performance categories
SELECT
    roll_number,
    CONCAT(first_name, ' ', last_name) AS student,
    cgpa,
    CASE
        WHEN cgpa >= 9.0 THEN 'Excellent'
        WHEN cgpa >= 8.0 THEN 'Very Good'
        WHEN cgpa >= 7.0 THEN 'Good'
        WHEN cgpa >= 6.0 THEN 'Average'
        ELSE 'Needs Improvement'
    END AS performance_category
FROM students
ORDER BY cgpa DESC;

-- 6. Marks and grades
SELECT
    s.roll_number,
    CONCAT(s.first_name, ' ', s.last_name) AS student,
    sb.subject_name,
    m.marks_obtained,
    CASE
        WHEN m.marks_obtained >= 90 THEN 'A+'
        WHEN m.marks_obtained >= 80 THEN 'A'
        WHEN m.marks_obtained >= 70 THEN 'B'
        WHEN m.marks_obtained >= 60 THEN 'C'
        WHEN m.marks_obtained >= 40 THEN 'D'
        ELSE 'F'
    END AS grade
FROM marks m
JOIN students s ON s.student_id = m.student_id
JOIN subjects sb ON sb.subject_id = m.subject_id
ORDER BY s.student_id, m.marks_obtained DESC;

-- 7. Students who failed at least one subject
SELECT
    s.roll_number,
    CONCAT(s.first_name, ' ', s.last_name) AS student,
    COUNT(*) AS failed_subjects
FROM students s
JOIN marks m ON m.student_id = s.student_id
WHERE m.marks_obtained < 40
GROUP BY s.student_id, s.roll_number, s.first_name, s.last_name
ORDER BY failed_subjects DESC;

-- 8. Students who passed all subjects
SELECT
    s.roll_number,
    CONCAT(s.first_name, ' ', s.last_name) AS student,
    s.cgpa
FROM students s
WHERE NOT EXISTS (
    SELECT 1
    FROM marks m
    WHERE m.student_id = s.student_id
    AND m.marks_obtained < 40
)
ORDER BY s.cgpa DESC;

-- 9. Department with highest average CGPA
SELECT
    d.department_name,
    ROUND(AVG(s.cgpa), 2) AS average_cgpa
FROM departments d
JOIN students s ON s.department_id = d.department_id
GROUP BY d.department_id, d.department_name
ORDER BY average_cgpa DESC
LIMIT 1;

-- 10. Students with outstanding fees
SELECT
    s.roll_number,
    CONCAT(s.first_name, ' ', s.last_name) AS student,
    d.department_code,
    f.total_amount,
    f.amount_paid,
    f.total_amount - f.amount_paid AS outstanding_amount,
    CASE
        WHEN f.amount_paid = 0 THEN 'No Payment'
        WHEN f.amount_paid < f.total_amount THEN 'Partially Paid'
        ELSE 'Fully Paid'
    END AS payment_category
FROM students s
JOIN departments d ON d.department_id = s.department_id
JOIN fees f ON f.student_id = s.student_id
WHERE f.amount_paid < f.total_amount
ORDER BY outstanding_amount DESC;

-- 11. Faculty teaching most students
SELECT
    CONCAT(f.first_name, ' ', f.last_name) AS faculty_member,
    COUNT(DISTINCT e.student_id) AS students_taught
FROM faculty f
JOIN subjects sb ON sb.faculty_id = f.faculty_id
JOIN enrollments e ON e.subject_id = sb.subject_id
GROUP BY f.faculty_id, f.first_name, f.last_name
ORDER BY students_taught DESC
LIMIT 1;

-- 12. Marks above overall average
SELECT
    s.roll_number,
    CONCAT(s.first_name, ' ', s.last_name) AS student,
    sb.subject_name,
    m.marks_obtained
FROM marks m
JOIN students s ON s.student_id = m.student_id
JOIN subjects sb ON sb.subject_id = m.subject_id
WHERE m.marks_obtained > (SELECT AVG(marks_obtained) FROM marks)
ORDER BY m.marks_obtained DESC;


-- VIEWS

CREATE OR REPLACE VIEW student_academic_performance AS
SELECT
    s.student_id,
    s.roll_number,
    CONCAT(s.first_name, ' ', s.last_name) AS student,
    d.department_name,
    s.cgpa,
    ROUND(AVG(m.marks_obtained), 2) AS average_marks,
    MAX(m.marks_obtained) AS highest_mark,
    MIN(m.marks_obtained) AS lowest_mark
FROM students s
JOIN departments d ON d.department_id = s.department_id
LEFT JOIN marks m ON m.student_id = s.student_id
GROUP BY
    s.student_id,
    s.roll_number,
    s.first_name,
    s.last_name,
    d.department_name,
    s.cgpa;


CREATE OR REPLACE VIEW student_fee_summary AS
SELECT
    s.roll_number,
    CONCAT(s.first_name, ' ', s.last_name) AS student,
    d.department_name,
    f.total_amount,
    f.amount_paid,
    f.total_amount - f.amount_paid AS outstanding_amount,
    f.fee_status,
    f.due_date
FROM students s
JOIN departments d ON d.department_id = s.department_id
JOIN fees f ON f.student_id = s.student_id;


CREATE OR REPLACE VIEW faculty_subject_load AS
SELECT
    f.faculty_id,
    CONCAT(f.first_name, ' ', f.last_name) AS faculty_member,
    f.designation,
    d.department_name,
    COUNT(DISTINCT sb.subject_id) AS subjects_taught,
    COUNT(DISTINCT e.student_id) AS students_taught
FROM faculty f
JOIN departments d ON d.department_id = f.department_id
LEFT JOIN subjects sb ON sb.faculty_id = f.faculty_id
LEFT JOIN enrollments e ON e.subject_id = sb.subject_id
GROUP BY
    f.faculty_id,
    f.first_name,
    f.last_name,
    f.designation,
    d.department_name;

SELECT * FROM student_academic_performance;
SELECT * FROM student_fee_summary;
SELECT * FROM faculty_subject_load;

SELECT * FROM student_academic_performance
WHERE cgpa >= 8.0;

SELECT *
FROM student_fee_summary
WHERE fee_status = 'Paid';

-- STORED PROCEDURES
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_add_student$$
CREATE PROCEDURE sp_add_student(
    IN p_roll_number   VARCHAR(20),
    IN p_first_name    VARCHAR(50),
    IN p_last_name     VARCHAR(50),
    IN p_email         VARCHAR(100),
    IN p_gender        VARCHAR(10),
    IN p_department_id INT,
    IN p_total_fee     DECIMAL(10,2),
    IN p_due_date      DATE
)
BEGIN
    DECLARE v_student_id INT;

    INSERT INTO students (roll_number, first_name, last_name, email, gender, department_id)
    VALUES (p_roll_number, p_first_name, p_last_name, p_email, p_gender, p_department_id);

    SET v_student_id = LAST_INSERT_ID();

    INSERT INTO fees (student_id, total_amount, amount_paid, due_date)
    VALUES (v_student_id, p_total_fee, 0, p_due_date);

    SELECT v_student_id AS new_student_id, 'Student added successfully' AS message;
END$$

DROP PROCEDURE IF EXISTS sp_student_report$$
CREATE PROCEDURE sp_student_report(IN p_student_id INT)
BEGIN
    SELECT s.roll_number,
           CONCAT(s.first_name, ' ', s.last_name) AS student,
           d.department_name,
           s.cgpa
    FROM students s
    JOIN departments d ON d.department_id = s.department_id
    WHERE s.student_id = p_student_id;

    SELECT sb.subject_code,
           sb.subject_name,
           m.marks_obtained,
           fn_get_grade(m.marks_obtained) AS grade
    FROM marks m
    JOIN subjects sb ON sb.subject_id = m.subject_id
    WHERE m.student_id = p_student_id
    ORDER BY sb.subject_code;

    SELECT total_amount, amount_paid,
           total_amount - amount_paid AS outstanding,
           fee_status, due_date
    FROM fees
    WHERE student_id = p_student_id;
END$$

DROP PROCEDURE IF EXISTS sp_department_summary$$
CREATE PROCEDURE sp_department_summary(IN p_department_id INT)
BEGIN
    SELECT d.department_name,
           COUNT(DISTINCT s.student_id)  AS total_students,
           ROUND(AVG(s.cgpa), 2)         AS avg_cgpa,
           MAX(s.cgpa)                   AS highest_cgpa,
           MIN(s.cgpa)                   AS lowest_cgpa
    FROM departments d
    LEFT JOIN students s ON s.department_id = d.department_id
    WHERE d.department_id = p_department_id
    GROUP BY d.department_id, d.department_name;
END$$

DROP PROCEDURE IF EXISTS sp_update_marks$$
CREATE PROCEDURE sp_update_marks(
    IN p_student_id INT,
    IN p_subject_id INT,
    IN p_marks      DECIMAL(5,2)
)
BEGIN
    INSERT INTO marks (student_id, subject_id, marks_obtained)
    VALUES (p_student_id, p_subject_id, p_marks)
    ON DUPLICATE KEY UPDATE marks_obtained = p_marks;

    SELECT 'Marks saved' AS message;
END$$

DROP PROCEDURE IF EXISTS sp_students_by_cgpa_range$$
CREATE PROCEDURE sp_students_by_cgpa_range(
    IN p_min DECIMAL(4,2),
    IN p_max DECIMAL(4,2)
)
BEGIN
    SELECT roll_number,
           CONCAT(first_name, ' ', last_name) AS student,
           cgpa
    FROM students
    WHERE cgpa BETWEEN p_min AND p_max
    ORDER BY cgpa DESC;
END$$

-- STORED FUNCTIONS
DROP FUNCTION IF EXISTS fn_get_grade$$
CREATE FUNCTION fn_get_grade(p_marks DECIMAL(5,2))
RETURNS VARCHAR(2)
DETERMINISTIC
BEGIN
    RETURN CASE
        WHEN p_marks >= 90 THEN 'A+'
        WHEN p_marks >= 80 THEN 'A'
        WHEN p_marks >= 70 THEN 'B'
        WHEN p_marks >= 60 THEN 'C'
        WHEN p_marks >= 40 THEN 'D'
        ELSE 'F'
    END;
END$$

DROP FUNCTION IF EXISTS fn_cgpa_category$$
CREATE FUNCTION fn_cgpa_category(p_cgpa DECIMAL(4,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    RETURN CASE
        WHEN p_cgpa >= 9.0 THEN 'Excellent'
        WHEN p_cgpa >= 8.0 THEN 'Very Good'
        WHEN p_cgpa >= 7.0 THEN 'Good'
        WHEN p_cgpa >= 6.0 THEN 'Average'
        ELSE 'Needs Improvement'
    END;
END$$

DROP FUNCTION IF EXISTS fn_outstanding_fees$$
CREATE FUNCTION fn_outstanding_fees(p_student_id INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE v_outstanding DECIMAL(10,2);

    SELECT total_amount - amount_paid
    INTO v_outstanding
    FROM fees
    WHERE student_id = p_student_id;

    RETURN IFNULL(v_outstanding, 0);
END$$

DROP FUNCTION IF EXISTS fn_student_avg_marks$$
CREATE FUNCTION fn_student_avg_marks(p_student_id INT)
RETURNS DECIMAL(5,2)
READS SQL DATA
BEGIN
    DECLARE v_avg DECIMAL(5,2);

    SELECT ROUND(AVG(marks_obtained), 2)
    INTO v_avg
    FROM marks
    WHERE student_id = p_student_id;

    RETURN IFNULL(v_avg, 0);
END$$

DROP FUNCTION IF EXISTS fn_failed_subjects$$
CREATE FUNCTION fn_failed_subjects(p_student_id INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_failed INT;

    SELECT COUNT(*)
    INTO v_failed
    FROM marks
    WHERE student_id = p_student_id
      AND marks_obtained < 40;

    RETURN v_failed;
END$$

DELIMITER ;

-- TRIGGERS

CREATE TABLE IF NOT EXISTS marks_audit (
    audit_id    INT AUTO_INCREMENT PRIMARY KEY,
    mark_id     INT          NOT NULL,
    student_id  INT          NOT NULL,
    subject_id  INT          NOT NULL,
    old_marks   DECIMAL(5,2) NOT NULL,
    new_marks   DECIMAL(5,2) NOT NULL,
    changed_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

DROP TRIGGER IF EXISTS trg_marks_before_insert$$
CREATE TRIGGER trg_marks_before_insert
BEFORE INSERT ON marks
FOR EACH ROW
BEGIN
    IF NEW.marks_obtained < 0 OR NEW.marks_obtained > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Marks must be between 0 and 100';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM enrollments
                   WHERE student_id = NEW.student_id
                     AND subject_id = NEW.subject_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student is not enrolled in this subject';
    END IF;
END$$

DROP TRIGGER IF EXISTS trg_marks_before_update$$
CREATE TRIGGER trg_marks_before_update
BEFORE UPDATE ON marks
FOR EACH ROW
BEGIN
    IF NEW.marks_obtained < 0 OR NEW.marks_obtained > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Marks must be between 0 and 100';
    END IF;
END$$

DROP TRIGGER IF EXISTS trg_marks_after_update$$
CREATE TRIGGER trg_marks_after_update
AFTER UPDATE ON marks
FOR EACH ROW
BEGIN
    IF OLD.marks_obtained <> NEW.marks_obtained THEN
        INSERT INTO marks_audit (mark_id, student_id, subject_id, old_marks, new_marks)
        VALUES (OLD.mark_id, OLD.student_id, OLD.subject_id,
                OLD.marks_obtained, NEW.marks_obtained);
    END IF;
END$$

DROP TRIGGER IF EXISTS trg_fees_before_insert$$
CREATE TRIGGER trg_fees_before_insert
BEFORE INSERT ON fees
FOR EACH ROW
BEGIN
    IF NEW.amount_paid = 0 THEN
        SET NEW.fee_status = 'Unpaid';
    ELSEIF NEW.amount_paid < NEW.total_amount THEN
        SET NEW.fee_status = 'Partial';
    ELSE
        SET NEW.fee_status = 'Paid';
    END IF;
END$$

DROP TRIGGER IF EXISTS trg_fees_before_update$$
CREATE TRIGGER trg_fees_before_update
BEFORE UPDATE ON fees
FOR EACH ROW
BEGIN
    IF NEW.amount_paid = 0 THEN
        SET NEW.fee_status = 'Unpaid';
    ELSEIF NEW.amount_paid < NEW.total_amount THEN
        SET NEW.fee_status = 'Partial';
    ELSE
        SET NEW.fee_status = 'Paid';
    END IF;
END$$

DROP TRIGGER IF EXISTS trg_students_after_insert$$
CREATE TRIGGER trg_students_after_insert
AFTER INSERT ON students
FOR EACH ROW
BEGIN
    INSERT INTO enrollments (student_id, subject_id)
    SELECT NEW.student_id, subject_id
    FROM subjects
    WHERE department_id = NEW.department_id;
END$$

--  SAFE FEE PAYMENT TRANSACTION

DROP PROCEDURE IF EXISTS sp_pay_fees_safe$$
CREATE PROCEDURE sp_pay_fees_safe(
    IN p_student_id INT,
    IN p_amount     DECIMAL(10,2)
)
BEGIN
    DECLARE v_total DECIMAL(10,2);
    DECLARE v_paid  DECIMAL(10,2);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT total_amount, amount_paid
    INTO v_total, v_paid
    FROM fees
    WHERE student_id = p_student_id
    FOR UPDATE;

    IF v_total IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No fee record for this student';
    END IF;

    IF p_amount <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Payment must be greater than zero';
    END IF;

    IF v_paid + p_amount > v_total THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Payment exceeds outstanding amount';
    END IF;

    UPDATE fees
    SET amount_paid = amount_paid + p_amount
    WHERE student_id = p_student_id;

    COMMIT;

    SELECT student_id, total_amount, amount_paid, fee_status
    FROM fees
    WHERE student_id = p_student_id;
END$$

DELIMITER ;

-- INDEXES (Run only once)

SHOW INDEX FROM students;
SHOW INDEX FROM marks;

CREATE INDEX idx_students_cgpa      ON students(cgpa);
CREATE INDEX idx_students_name      ON students(last_name, first_name);
CREATE INDEX idx_fees_status_due    ON fees(fee_status, due_date);
CREATE INDEX idx_marks_obtained     ON marks(marks_obtained);
CREATE INDEX idx_faculty_designation ON faculty(designation);

EXPLAIN SELECT * FROM students WHERE cgpa > 8;
EXPLAIN SELECT * FROM students WHERE last_name = 'Sharma' AND first_name = 'Aarav';
EXPLAIN SELECT * FROM fees WHERE fee_status = 'Unpaid';
EXPLAIN SELECT * FROM marks WHERE marks_obtained < 40;

-- TEST: FUNCTIONS

SELECT fn_get_grade(92.5) AS grade, fn_cgpa_category(8.72) AS category;

SELECT roll_number,
       CONCAT(first_name, ' ', last_name) AS student,
       cgpa,
       fn_cgpa_category(cgpa)           AS category,
       fn_student_avg_marks(student_id) AS avg_marks,
       fn_failed_subjects(student_id)   AS failed_subjects,
       fn_outstanding_fees(student_id)  AS outstanding_fees
FROM students
ORDER BY cgpa DESC;

-- TEST: PROCEDURES

CALL sp_department_summary(1);
CALL sp_students_by_cgpa_range(7, 9);
CALL sp_student_report(1);

-- TEST: TRIGGERS

-- These should FAIL.
-- INSERT INTO marks (student_id, subject_id, marks_obtained) VALUES (1, 1, 150);
-- INSERT INTO marks (student_id, subject_id, marks_obtained) VALUES (1, 4, 50);

-- Marks change gets logged in marks_audit
UPDATE marks SET marks_obtained = 95 WHERE student_id = 1 AND subject_id = 1;
SELECT * FROM marks_audit;

-- Fee status changes automatically to 'Partial'
UPDATE fees SET amount_paid = 30000 WHERE student_id = 4;
SELECT student_id, amount_paid, fee_status FROM fees WHERE student_id = 4;

-- Undo changes
UPDATE marks SET marks_obtained = 92.5 WHERE student_id = 1 AND subject_id = 1;
UPDATE fees  SET amount_paid = 0 WHERE student_id = 4;

-- sp_update_marks test
CALL sp_update_marks(1, 3, 80);

-- Undo changes
UPDATE marks SET marks_obtained = 75.5 WHERE student_id = 1 AND subject_id = 3;
SELECT * FROM marks_audit;

-- Add a student via procedure; check auto-enrollment and fee row; then roll back
START TRANSACTION;
CALL sp_add_student('CSE25005', 'Test', 'Student', 'test.student@student.demo-college.edu',
                    'Male', 1, 125000, '2026-08-31');
SELECT * FROM enrollments WHERE student_id = (SELECT MAX(student_id) FROM students);
SELECT * FROM fees        WHERE student_id = (SELECT MAX(student_id) FROM students);
ROLLBACK;

-- TRANSACTIONS

-- COMMIT
START TRANSACTION;
UPDATE fees SET amount_paid = 125000 WHERE student_id = 4;
SELECT student_id, amount_paid, fee_status FROM fees WHERE student_id = 4;
COMMIT;

-- ROLLBACK
START TRANSACTION;
UPDATE fees SET amount_paid = 0 WHERE student_id = 4;
SELECT student_id, amount_paid, fee_status FROM fees WHERE student_id = 4;
ROLLBACK;
-- Check rollback
SELECT student_id, amount_paid, fee_status FROM fees WHERE student_id = 4;

-- Restore original value for student 4
UPDATE fees SET amount_paid = 0 WHERE student_id = 4;

-- SAVEPOINT
START TRANSACTION;
UPDATE marks SET marks_obtained = 60 WHERE student_id = 4 AND subject_id = 3;
SAVEPOINT after_first_update;
UPDATE marks SET marks_obtained = 10 WHERE student_id = 4 AND subject_id = 1;
SELECT student_id, subject_id, marks_obtained FROM marks WHERE student_id = 4;
ROLLBACK TO after_first_update;
SELECT student_id, subject_id, marks_obtained FROM marks WHERE student_id = 4;
ROLLBACK;

-- Safe payment procedure
CALL sp_pay_fees_safe(4, 25000);

-- These should FAIL.
-- CALL sp_pay_fees_safe(4, 999999);
-- CALL sp_pay_fees_safe(4, -5);

-- Reset
UPDATE fees SET amount_paid = 0 WHERE student_id = 4;