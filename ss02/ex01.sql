CREATE TABLE Class (
    class_id VARCHAR(10) PRIMARY KEY,   -- Mã lớp (PK)
    class_name VARCHAR(50) NOT NULL,    -- Tên lớp
    school_year INT NOT NULL            -- Năm học
);

CREATE TABLE Student (
    student_id VARCHAR(10) PRIMARY KEY,     -- Mã sinh viên (PK)
    full_name VARCHAR(100) NOT NULL,        -- Họ tên
    birthday DATE NOT NULL,                 -- Ngày sinh
    class_id VARCHAR(10),                   -- Thuộc lớp nào
    FOREIGN KEY (class_id) REFERENCES Class(class_id) 
        ON UPDATE CASCADE
        ON DELETE SET NULL
);
