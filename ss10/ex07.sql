-- sử dụng lại database
use social_network_pro;

-- tạo view view_user_activity_status
create view view_user_activity_status as
select u.user_id, u.username, u.gender, u.created_at,
    case
        when count(distinct p.post_id) > 0
          or count(distinct c.comment_id) > 0
        then 'Active'
        else 'Inactive'
    end as status
from users u
left join posts p
    on u.user_id = p.user_id
left join comments c
    on u.user_id = c.user_id
group by u.user_id, u.username, u.gender, u.created_at;

-- truy vấn view view_user_activity_status
select user_id, username, gender, created_at, status
from view_user_activity_status;

-- thống kê số lượng người dùng theo trạng thái
select status, count(user_id) as user_count
from view_user_activity_status
group by status
order by user_count desc;
