create table comments (
    comment_id int auto_increment primary key,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id)
);

-- stored procedure sp_post_comment
delimiter $$

create procedure sp_post_comment (
    in p_post_id int,
    in p_user_id int,
    in p_content text
)
begin
    declare has_error boolean default false;

    -- bắt lỗi sql
    declare continue handler for sqlexception
    begin
        set has_error = true;
        rollback to after_insert;
    end;

    -- kiểm tra nội dung bình luận
    if p_content is null or trim(p_content) = '' then
        signal sqlstate '45000'
        set message_text = 'nội dung bình luận không được để trống';
    end if;

    start transaction;

        -- thêm bình luận
        insert into comments(post_id, user_id, content)
        values (p_post_id, p_user_id, p_content);

        -- tạo savepoint
        savepoint after_insert;

        -- cập nhật số lượng bình luận
        update posts
        set comments_count = comments_count + 1
        where post_id = p_post_id;

    if has_error = false then
        commit;
        select 'đăng bình luận thành công' as message;
    else
        commit;
        select 'bình luận đã được lưu nhưng không cập nhật được số lượng' as message;
    end if;

end$$

delimiter ;

-- trường hợp 1 – thành công (commit toàn bộ)
call sp_post_comment(1, 1, 'bình luận đầu tiên cho bài viết');
select * from comments where post_id = 1;
select post_id, comments_count from posts where post_id = 1;

-- trường hợp 2 – gây lỗi ở bước update
call sp_post_comment(9999, 1, 'bình luận gây lỗi update');
select * from comments;
select * from posts;
