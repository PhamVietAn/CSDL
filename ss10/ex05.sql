-- sử dụng lại database
use social_network_pro;

-- truy vấn trước khi tạo index
explain analyze
select u.user_id, u.username, u.full_name, u.hometown, p.post_id, p.content
from users u
join posts p on u.user_id = p.user_id
where u.hometown = 'Hà Nội'
order by u.username desc
limit 10;


-- tạo chỉ mục idx_hometown
create index idx_hometown on users (hometown);

-- truy vấn lại sau khi tạo index
explain analyze
select u.user_id, u.username, u.full_name, u.hometown, p.post_id, p.content
from users u
join posts p on u.user_id = p.user_id
where u.hometown = 'Hà Nội'
order by u.username desc
limit 10;
