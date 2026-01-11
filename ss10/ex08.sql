-- sử dụng lại database
use social_network_pro;

-- tạo index idx_user_gender trên cột gender
create index idx_user_gender on users (gender);

-- tạo view view_popular_posts
create view view_popular_posts as
select p.post_id, u.username, p.content,
       count(distinct l.like_id) as total_likes,
       count(distinct c.comment_id) as total_comments
from posts p
join users u on p.user_id = u.user_id
left join likes l on p.post_id = l.post_id
left join comments c on p.post_id = c.post_id
group by
    p.post_id,
    u.username,
    p.content;

-- truy vấn view view_popular_posts
select post_id, username, content, total_likes, total_comments
from view_popular_posts;

-- liệt kê các bài viết có tổng tương tác > 10
select post_id, username, content, total_likes, total_comments,
       (total_likes + total_comments) as total_interactions
from view_popular_posts
where (total_likes + total_comments) > 10
order by total_interactions desc;
