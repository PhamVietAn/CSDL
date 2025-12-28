CREATE TABLE Teacher (
    teacher_id VARCHAR(10) PRIMARY KEY,   -- Mã giảng viên
    full_name VARCHAR(100) NOT NULL,      -- Họ tên
    email VARCHAR(100) UNIQUE NOT NULL    -- Email
);

ALTER TABLE Subject
ADD COLUMN teacher_id VARCHAR(10);

ALTER TABLE Subject
ADD CONSTRAINT fk_teacher
FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id);
