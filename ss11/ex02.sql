-- Tạo stored procedure CalculatePostLikes
delimiter //
create procedure CalculatePostLikes(
    in p_post_id int,
    out total_likes int
)
begin
    select count(*) into total_likes
    from likes
    where post_id = p_post_id;
end//
delimiter ;

-- Gọi stored procedure để kiểm tra
set @total_likes = 0;
call CalculatePostLikes(1, @total_likes);
select @total_likes;

-- Xóa stored procedure
drop procedure CalculatePostLikes;

