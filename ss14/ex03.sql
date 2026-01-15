alter table users
add column following_count int default 0,
add column followers_count int default 0;

create table followers (
    follower_id int not null,
    followed_id int not null,
    primary key (follower_id, followed_id),
    foreign key (follower_id) references users(user_id),
    foreign key (followed_id) references users(user_id)
);

delimiter $$

create procedure sp_follow_user (
    in p_follower_id int,
    in p_followed_id int
)
begin
    declare v_count int default 0;
    declare has_error boolean default false;

    -- bắt lỗi sql
    declare continue handler for sqlexception
    begin
        set has_error = true;
        rollback;
        insert into follow_log(follower_id, followed_id, message)
        values (p_follower_id, p_followed_id, 'lỗi sql khi follow');
    end;

    -- kiểm tra tự follow
    if p_follower_id = p_followed_id then
        insert into follow_log(follower_id, followed_id, message)
        values (p_follower_id, p_followed_id, 'không được tự follow chính mình');
        signal sqlstate '45000'
        set message_text = 'không được tự follow chính mình';
    end if;

    -- kiểm tra user tồn tại
    select count(*) into v_count
    from users
    where user_id in (p_follower_id, p_followed_id);

    if v_count < 2 then
        insert into follow_log(follower_id, followed_id, message)
        values (p_follower_id, p_followed_id, 'user không tồn tại');
        signal sqlstate '45000'
        set message_text = 'user không tồn tại';
    end if;

    -- kiểm tra đã follow chưa
    select count(*) into v_count
    from followers
    where follower_id = p_follower_id
      and followed_id = p_followed_id;

    if v_count > 0 then
        insert into follow_log(follower_id, followed_id, message)
        values (p_follower_id, p_followed_id, 'đã follow trước đó');
        signal sqlstate '45000'
        set message_text = 'đã follow user này trước đó';
    end if;

    -- transaction
    start transaction;

        insert into followers(follower_id, followed_id)
        values (p_follower_id, p_followed_id);

        update users
        set following_count = following_count + 1
        where user_id = p_follower_id;

        update users
        set followers_count = followers_count + 1
        where user_id = p_followed_id;

    if has_error = false then
        commit;
        select 'follow thành công' as message;
    end if;

end$$

delimiter ;

-- trường hợp 1 – follow thành công
call sp_follow_user(1, 2);
select * from followers;
select user_id, following_count, followers_count from users;

-- trường hợp 2 – follow trùng (rollback)
call sp_follow_user(1, 2);

-- trường hợp 3 – user không tồn tại
call sp_follow_user(1, 9999);
