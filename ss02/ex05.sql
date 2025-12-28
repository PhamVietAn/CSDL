CREATE TABLE Score (
    student_id VARCHAR(10) NOT NULL,     -- Sinh viên nào
    subject_id VARCHAR(10) NOT NULL,     -- Môn học nào
    process_score DECIMAL(4,2) CHECK (process_score BETWEEN 0 AND 10), -- Điểm quá trình
    final_score DECIMAL(4,2) CHECK (final_score BETWEEN 0 AND 10),     -- Điểm cuối kỳ

    PRIMARY KEY (student_id, subject_id), 

    FOREIGN KEY (student_id) REFERENCES Student(student_id),

    FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
   
);
