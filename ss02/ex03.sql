CREATE TABLE Student (
    student_id VARCHAR(10) PRIMARY KEY,   -- Mã sinh viên 
    full_name VARCHAR(100) NOT NULL,      -- Họ tên
    UNIQUE (student_id)                   -- Mã sinh viên duy nhất
);

CREATE TABLE Subject (
    subject_id VARCHAR(10) PRIMARY KEY,   -- Mã môn học 
    subject_name VARCHAR(100) NOT NULL,   -- Tên môn học
    credit INT NOT NULL CHECK (credit > 0), -- Số tín chỉ phải 
    UNIQUE (subject_id)                    -- Mã môn học là duy nhất
);


CREATE TABLE Enrollment (
    student_id VARCHAR(10) NOT NULL,       -- Sinh viên nào
    subject_id VARCHAR(10) NOT NULL,       -- Đăng ký môn nào
    enroll_date DATE NOT NULL,             -- Ngày đăng ký
    
    PRIMARY KEY (student_id, subject_id), 
    
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
        
    FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

