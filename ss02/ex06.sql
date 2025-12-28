-- 1. LỚP HỌC (Class)
CREATE TABLE Class (
    class_id VARCHAR(10) PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL,
    school_year INT NOT NULL CHECK (school_year > 2000)
);

-- 2. SINH VIÊN (Student)
CREATE TABLE Student (
    student_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birthday DATE NOT NULL,
    class_id VARCHAR(10),
    FOREIGN KEY (class_id) REFERENCES Class(class_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- 3. GIẢNG VIÊN (Teacher)
CREATE TABLE Teacher (
    teacher_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- 4. MÔN HỌC (Subject)
CREATE TABLE Subject (
    subject_id VARCHAR(10) PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    credit INT NOT NULL CHECK (credit > 0),
    teacher_id VARCHAR(10),
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- 5. ĐĂNG KÝ MÔN HỌC (Enrollment)
CREATE TABLE Enrollment (
    student_id VARCHAR(10) NOT NULL,
    subject_id VARCHAR(10) NOT NULL,
    enroll_date DATE NOT NULL,
    PRIMARY KEY (student_id, subject_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 6. KẾT QUẢ HỌC TẬP (Score)
CREATE TABLE Score (
    student_id VARCHAR(10) NOT NULL,
    subject_id VARCHAR(10) NOT NULL,
    process_score DECIMAL(4,2) CHECK (process_score BETWEEN 0 AND 10),
    final_score DECIMAL(4,2) CHECK (final_score BETWEEN 0 AND 10),
    PRIMARY KEY (student_id, subject_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
