create table if not exists delete_log (
    log_id int auto_increment primary key,
    post_id int not null,
    deleted_by int not null,
    deleted_at datetime default current_timestamp
);

-- stored procedure sp_delete_post
delimiter $$

create procedure sp_delete_post (
    in p_post_id int,
    in p_user_id int
)
begin
    declare v_owner_id int;
    declare has_error boolean default false;

    -- bắt lỗi sql
    declare continue handler for sqlexception
    begin
        set has_error = true;
        rollback;
    end;

    -- kiểm tra bài viết tồn tại và đúng chủ sở hữu
    select user_id into v_owner_id
    from posts
    where post_id = p_post_id;

    if v_owner_id is null then
        signal sqlstate '45000'
        set message_text = 'bài viết không tồn tại';
    end if;

    if v_owner_id <> p_user_id then
        signal sqlstate '45000'
        set message_text = 'không có quyền xóa bài viết này';
    end if;

    start transaction;

        -- xóa likes
        delete from likes
        where post_id = p_post_id;

        -- xóa comments
        delete from comments
        where post_id = p_post_id;

        -- xóa bài viết
        delete from posts
        where post_id = p_post_id;

        -- giảm số lượng bài viết của user
        update users
        set posts_count = posts_count - 1
        where user_id = p_user_id;

        -- ghi log xóa
        insert into delete_log(post_id, deleted_by)
        values (p_post_id, p_user_id);

    if has_error = false then
        commit;
        select 'xóa bài viết thành công' as message;
    end if;

end$$

delimiter ;

-- trường hợp 1 – xóa hợp lệ
call sp_delete_post(1, 1);
select * from posts where post_id = 1;
select * from likes where post_id = 1;
select * from comments where post_id = 1;
select user_id, posts_count from users where user_id = 1;
select * from delete_log order by deleted_at desc;

-- trường hợp 2 – user không phải chủ bài viết
call sp_delete_post(2, 1);
select * from posts where post_id = 2;
select * from delete_log;

-- trường hợp 3 – bài viết không tồn tại
call sp_delete_post(9999, 1);
