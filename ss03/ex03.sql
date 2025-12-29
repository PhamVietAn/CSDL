create table Subject (
    subject_id int primary key,
    subject_name varchar(100) not null,
    credit int check (credit > 0)   -- số tín chỉ phải lớn hơn 0
);

insert into Subject (subject_id,subject_name, credit)
values 
	(101, 'Toán Cao Cấp', 3),
	(102, 'Lập Trình Cơ Bản', 4),
    (103, 'Cơ Sở Dữ Liệu', 3),
    (104, 'Mạng Máy Tính', 3);
    
update Subject
set credit = 5
where subject_id = 102;

update Subject
set subject_name = 'Mạng Máy Tính Nâng Cao'
where subject_id = 104;
