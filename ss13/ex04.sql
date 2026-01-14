-- 1) Tạo bảng post_history
create table post_history (
    history_id int auto_increment primary key,
    post_id int,
    old_content text,
    new_content text,
    changed_at datetime,
    changed_by_user_id int,
    foreign key (post_id) references posts(post_id)
        on delete cascade
);

-- 2) Thêm dữ liệu mẫu nếu cần.

-- 3) Tạo trigger:
-- BEFORE UPDATE trên posts
delimiter $$

create trigger tg_before_update_post_history
before update on posts
for each row
begin
    -- Chỉ ghi lịch sử khi nội dung thực sự thay đổi
    if old.content <> new.content then
        insert into post_history(
            post_id,
            old_content,
            new_content,
            changed_at,
            changed_by_user_id
        )
        values (
            old.post_id,
            old.content,
            new.content,
            now(),
            old.user_id   -- giả sử người sửa là chủ bài viết
        );
    end if;
end$$

delimiter ;

-- AFTER DELETE trên posts
-- sử dụng ON DELETE CASCADE nên không dùng trigger

-- 4) Thực hiện UPDATE nội dung một số bài đăng, sau đó SELECT từ post_history để xem lịch sử.
-- Update nội dung bài viết
update posts
set content = 'Nội dung bài viết đã được chỉnh sửa lần 1'
where post_id = 1;

update posts
set content = 'Chỉnh sửa nội dung bài viết lần 2'
where post_id = 2;

-- Xem lịch sử chỉnh sửa
select * from post_history;

-- 5) Kiểm tra kết hợp với trigger like_count từ bài trước vẫn hoạt động khi UPDATE post.
select post_id, content, like_count from posts;
