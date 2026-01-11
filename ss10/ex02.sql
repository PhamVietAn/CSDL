-- 2. tạo view view_user_post
create view view_user_post as
select
    u.user_id,
    count(p.post_id) as total_user_post
from users u
left join posts p on u.user_id = p.user_id
group by u.user_id;

-- 3.hiển thị view view_user_post để kiểm chứng
select user_id, total_user_post
from view_user_post;

-- 4. kết hợp view view_user_post với bảng users
select u.full_name, v.total_user_post
from users u
join view_user_post v on u.user_id = v.user_id;
