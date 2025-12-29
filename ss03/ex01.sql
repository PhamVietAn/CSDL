create table Student(
	student_id int primary key,
    full_name varchar(30) not null,
    date_of_birth date,
    email varchar(100) unique
);

insert into Student()
values
(1,"Nguyễn Văn A","2000-12-20","nva@gmail.com"),
(2,"Nguyễn Thị B","2001-11-19","ntb@gmail.com"),
(3,"Trần Thị C","2002-10-18","ttc@gmail.com"),
(3,"Hoàng Văn H","2003-09-17","hvh@gmail.com"),
(3,"Phạm Thị I","2004-08-16","pti@gmail.com");

select * from Student;

select student_id,full_name from Student;