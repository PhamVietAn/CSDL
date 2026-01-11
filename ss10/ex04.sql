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

-- chạy lại truy vấn sau khi tạo index
explain analyze
select post_id, content, created_at
from posts
where user_id = 1
  and created_at >= '2026-01-01'
  and created_at <  '2027-01-01';
