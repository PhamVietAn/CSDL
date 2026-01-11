-- 2. Tạo VIEW view_users_firstname (họ “Nguyễn”)
create view view_users_firstname as
select user_id, username, full_name, email, created_at
from users
where full_name like 'Nguyễn%';

-- 3.  Hiển thị view vừa tạo
select user_id, username, full_name, email, created_at
from view_users_firstname;

-- 4. Thêm một nhân viên mới có họ “Nguyễn”
insert into users(username, full_name, gender, email, password, birthdate, hometown) values
('nguyenvanlong', 'Nguyễn Văn Long', 'Nam', 'long@gmail.com', '123', '1996-08-20', 'Hà Nội');

-- 5. Xóa nhân viên vừa thêm
delete from users
where username = 'nguyenvanlong';
