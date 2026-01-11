-- sử dụng lại database
use social_network_pro;

-- truy vấn tìm bài viết năm 2026 của user_id = 1
explain analyze
select post_id, content, created_at
from posts
where user_id = 1
  and created_at >= '2026-01-01'
  and created_at <  '2027-01-01';

-- tạo chỉ mục phức hợp idx_created_at_user_id
create index idx_created_at_user_id
on posts (created_at, user_id);

-- truy vấn tìm user có email = 'an@gmail.com
explain analyze
select user_id, username, email
from users
where email = 'an@gmail.com';

-- tạo unique index idx_email
create unique index idx_email
on users (email);

-- truy vấn lại sau khi tạo unique index
explain analyze
select user_id, username, email
from users
where email = 'an@gmail.com';

-- xóa composite index
drop index idx_created_at_user_id
on posts;

-- xóa unique index
drop index idx_email
on users;
