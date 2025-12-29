UPDATE Student
SET email = 'ttc_updated@gmail.com'
WHERE student_id = 3;

UPDATE Student
SET date_of_birth = '2006-01-19'
WHERE student_id = 2;

DELETE FROM Student
WHERE student_id = 5;

SELECT * FROM Student;