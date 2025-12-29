create database btth_ss3;

use btth_ss3;

create table Student (
	student_id char(10) not null primary key,
    full_name varchar(50) not null,
    date_of_birth date,
    gender enum('nam','nu','khac'),
    email varchar(50) unique,
    class_name varchar(10)
);

create table Subject (
	subject_id char(10) not null primary key,
    credit_hours int,
    subject_name varchar(20) not null,
    
    check (credit_hours >0)
);

create table enrollment (
	student_id char(10) not null,
    subject_id char(10) not null,
    regist date,
    semester varchar(20),
    
    primary key (student_id,subject_id),
    
    foreign key (student_id) references Student(student_id),
    foreign key (subject_id) references Subject(subject_id)
);

insert into student()
values
("ptit-001", "Nguyễn Văn A","2006-04-24","nam","nguyenvana@gmail.com","cntt01"),
("ptit-002", "Nguyễn Thị B","2006-04-24","nu","nguyenvanb@gmail.com","cntt01"),
("ptit-003", "Nguyễn Thị C","2006-04-24","nu","nguyenvanc@gmail.com","cntt01"),
("ptit-004", "Nguyễn Văn D","2006-04-24","nam","nguyenvand@gmail.com","cntt03"),
("ptit-005", "Nguyễn Thị E","2006-04-24","nu","nguyenvane@gmail.com","cntt02"),
("ptit-006","Lê Văn F","2006-05-10","nam","f@gmail.com","cntt02"),
("ptit-007","Lê Thị G","2006-05-11","nu","g@gmail.com","cntt02"),
("ptit-008","Hoàng Văn H","2006-05-12","nam","h@gmail.com","cntt03"),
("ptit-009","Phạm Thị I","2006-05-13","nu","i@gmail.com","cntt03"),
("ptit-010","Bùi Văn K","2006-05-14","nam","k@gmail.com","cntt01");

insert into subject()
values
("IT001", 3, "Cơ sở dữ liệu"),
("IT002", 4, "Lập trình Java"),
("IT003", 2, "Mạng máy tính"),
("IT004", 3, "Hệ điều hành"),
("IT005", 3, "Web cơ bản"),
("IT006", 2, "Python cơ bản"),
("IT007", 3, "Trí tuệ nhân tạo"),
("IT008", 4, "Cấu trúc dữ liệu"),
("IT009", 3, "Thuật toán"),
("IT010", 2, "OOP nâng cao");

insert into enrollment()
values
("ptit-001", "IT001", "2025-01-10", "Spring 2025"),
("ptit-002", "IT002", "2025-01-11", "Spring 2025"),
("ptit-003", "IT003", "2025-01-12", "Spring 2025"),
("ptit-004", "IT004", "2025-01-13", "Spring 2025"),
("ptit-005", "IT005", "2025-01-14", "Spring 2025"),
("ptit-006","IT006","2025-02-01","Spring 2025"),
("ptit-007","IT007","2025-02-02","Spring 2025"),
("ptit-008","IT008","2025-02-03","Spring 2025"),
("ptit-009","IT009","2025-02-04","Spring 2025"),
("ptit-010","IT010","2025-02-05","Spring 2025");

SELECT student_id, full_name
FROM Student;

SELECT subject_name, credit_hours
FROM Subject;

SELECT student_id, subject_id
FROM Enrollment;


UPDATE Student
SET email = 'vana_update@gmail.com'
WHERE student_id = 'ptit-001';
-- Giải thích: Chỉ sửa email của sinh viên ptit-001 nên không ảnh hưởng người khác.


UPDATE Subject
SET credit_hours = 5
WHERE subject_id = 'IT002';
-- Giải thích: Thay đổi tín chỉ môn Lập trình Java (IT002), không ảnh hưởng môn khác.


UPDATE Enrollment
SET semester = 'Fall 2025'
WHERE student_id = 'ptit-010' AND subject_id = 'IT010';
-- Giải thích: Dùng đủ 2 khóa chính để tránh sửa nhầm các dòng còn lại.

-- xoá 1 dòng đăng ký
DELETE FROM Enrollment
WHERE student_id = 'ptit-010' AND subject_id = 'IT010';
-- Giải thích: Đây là dòng con (bảng Enrollment) nên xóa trước không gây lỗi FK.


-- xoá 1 sinh viên an toàn
DELETE FROM Enrollment
WHERE student_id = 'ptit-010';

DELETE FROM Student
WHERE student_id = 'ptit-010';
-- Giải thích: Xóa trong Enrollment trước để không còn dòng phụ thuộc → tránh vi phạm khóa ngoại.

-- Phần 5 Nhận xét ngắn
-- 1. SELECT maSV, hoTen FROM SinhVien; dùng để làm gì?
-- dùng để truy xuất dữ liệu từ cột maSV, hoTen trong bảng SinhVien

-- 2. Vì sao không nên chỉ dùng SELECT * trong thực tế?
-- vì không phải lúc nào cũng lấy tất cả dữ liệu, lúc đó sẽ không kiểm soát được dữ liệu trả về

-- 3. Trong DML, lệnh nào nguy hiểm nhất nếu thiếu WHERE?
-- DELETE