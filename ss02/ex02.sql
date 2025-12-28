CREATE TABLE Student (
    student_id VARCHAR(10) PRIMARY KEY,   -- Mã sinh viên
    full_name VARCHAR(100) NOT NULL,      -- Họ tên
    UNIQUE (student_id)                   -- Mã sinh viên duy nhất
);

CREATE TABLE Subject (
    subject_id VARCHAR(10) PRIMARY KEY,   -- Mã môn học 
    subject_name VARCHAR(100) NOT NULL,   -- Tên môn học
    credit INT NOT NULL CHECK (credit > 0), -- Số tín chỉ 
    UNIQUE (subject_id)                    -- Mã môn học
);
