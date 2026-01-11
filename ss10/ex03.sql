-- sử dụng lại database
use social_network_pro;

-- 1. truy vấn user ở Hà Nội
explain analyze 
select user_id, username, full_name, email, hometown 
from users 
where hometown = 'Hà Nội';

-- 2. tạo index cho hometown 
create index idx_hometown on users (hometown);

-- 3. truy vấn lại
explain analyze 
select user_id, username, full_name, email, hometown 
from users 
where hometown = 'Hà Nội';

-- 4. xóa index
drop index idx_hometown on users;
