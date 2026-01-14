-- 1)Tạo Stored Procedure add_user
delimiter $$

create procedure add_user(
    in p_username varchar(50),
    in p_email varchar(100),
    in p_created_at date
)
begin
    insert into users(username, email, created_at)
    values (p_username, p_email, p_created_at);
end$$

delimiter ;

-- 2) Tạo trigger BEFORE INSERT trên users:
delimiter $$

create trigger tg_before_insert_users_validate
before insert on users
for each row
begin
    -- 1. Kiểm tra email hợp lệ (chứa @ và .)
    if new.email not like '%@%' or new.email not like '%.%' then
        signal sqlstate '45000'
        set message_text = 'Email không hợp lệ';
    end if;

    -- 2. Kiểm tra username chỉ chứa chữ, số và underscore
    if new.username not regexp '^[A-Za-z0-9_]+$' then
        signal sqlstate '45000'
        set message_text = 'Username chứa ký tự không hợp lệ';
    end if;
end$$

delimiter ;

-- 3) Gọi procedure với dữ liệu hợp lệ và không hợp lệ để kiểm thử.
-- 3.1 Gọi procedure với dữ liệu hợp lệ
call add_user('user_01', 'user01@example.com', '2025-01-01');

-- 3.2 Email không hợp lệ
call add_user('user_02', 'user02example.com', '2025-01-02');

-- 4) SELECT * FROM users để xem kết quả.
select * from users;
