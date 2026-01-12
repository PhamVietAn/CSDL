-- Tạo stored procedure có tham số IN nhận vào p_user_id:
delimiter //
create procedure sp_get_posts_by_user(
    in p_user_id int
)
begin
    select post_id, content, created_at
    from posts
    where user_id = p_user_id;
end//
delimiter ;

--  Gọi lại thủ tục vừa tạo với user cụ thể mà bạn muốn
call sp_get_posts_by_user(1);

--  Xóa thủ tục vừa tạo.
drop procedure sp_get_posts_by_user;
