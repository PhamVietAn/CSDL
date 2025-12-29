create table Enrollment (
    student_id int,
    subject_id int,
    enroll_date date,
    
    -- Ràng buộc khóa chính kết hợp (một sinh viên không được đăng ký trùng cùng một môn)
    primary key (student_id, subject_id),

    -- Khóa ngoại liên kết đến bảng Student
    foreign key (student_id) references Student(student_id),

    -- Khóa ngoại liên kết đến bảng Subject
    foreign key (subject_id) references Subject(subject_id)
);

insert into Enrollment (student_id, subject_id, enroll_date)
values
    (1, 101, '2025-01-10'),
    (1, 102, '2025-01-10'),
    (2, 103, '2025-01-11'),
    (3, 101, '2025-01-12');

select * from Enrollment;

select *
from Enrollment
where student_id = 1;

