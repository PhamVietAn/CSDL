-- Tạo/cập nhật trigger trên likes:

-- BEFORE INSERT
delimiter $$

create trigger tg_before_insert_like_check_self
before insert on likes
for each row
begin
    declare post_owner int;

    -- lấy user_id của người đăng bài
    select user_id into post_owner
    from posts
    where post_id = new.post_id;

    -- nếu người like là chủ bài viết → báo lỗi
    if new.user_id = post_owner then
        signal sqlstate '45000'
        set message_text = 'Không được like bài viết của chính mình';
    end if;
end$$

delimiter ;

-- AFTER INSERT
delimiter $$

create trigger tg_after_insert_like_update_post
after insert on likes
for each row
begin
    update posts
    set like_count = like_count + 1
    where post_id = new.post_id;
end$$

delimiter ;

-- AFTER DELETE
delimiter $$

create trigger tg_after_delete_like_update_post
after delete on likes
for each row
begin
    update posts
    set like_count = like_count - 1
    where post_id = old.post_id;
end$$

delimiter ;

-- AFTER UPDATE
delimiter $$

create trigger tg_after_update_like_change_post
after update on likes
for each row
begin
    -- chỉ xử lý khi post_id thay đổi
    if old.post_id <> new.post_id then
        update posts
        set like_count = like_count - 1
        where post_id = old.post_id;

        update posts
        set like_count = like_count + 1
        where post_id = new.post_id;
    end if;
end$$

delimiter ;

-- 4) Thực hiện các thao tác kiểm thử:
-- Like bài của chính mình
-- giả sử post_id = 1 do user_id = 1 đăng
insert into likes (user_id, post_id, liked_at)
values (1, 1, now());

-- Like hợp lệ
insert into likes (user_id, post_id, liked_at)
values (2, 1, now());
select post_id, like_count from posts where post_id = 1;

-- UPDATE like sang bài khác
update likes
set post_id = 3
where user_id = 2 and post_id = 1;
select post_id, like_count from posts where post_id in (1,3);

-- DELETE like
delete from likes
where user_id = 2 and post_id = 3;
select post_id, like_count from posts where post_id = 3;

-- 5. KIỂM CHỨNG BẰNG VIEW
select * from posts;
select * from user_statistics;
