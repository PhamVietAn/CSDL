-- Tạo stored procedure CalculateUserActivityScore
delimiter //
create procedure CalculateUserActivityScore(
    in p_user_id int,
    out activity_score int,
    out activity_level varchar(50)
)
begin
    declare v_post_count int default 0;
    declare v_comment_count int default 0;
    declare v_like_count int default 0;

    -- đếm số bài viết
    select count(*) into v_post_count
    from posts
    where user_id = p_user_id;

    -- đếm số bình luận
    select count(*) into v_comment_count
    from comments
    where user_id = p_user_id;

    -- đếm số lượt like nhận được trên bài viết của user
    select count(*) into v_like_count
    from likes l
    join posts p on l.post_id = p.post_id
    where p.user_id = p_user_id;

    -- tính tổng điểm
    set activity_score = v_post_count * 10
                        + v_comment_count * 5
                        + v_like_count * 3;

    -- phân loại mức hoạt động
    set activity_level = case
        when activity_score > 500 then 'Rất tích cực'
        when activity_score >= 200 then 'Tích cực'
        else 'Bình thường'
    end;
end//
delimiter ;

-- Gọi stored procedure để kiểm tra
set @score = 0;
set @level = '';
call CalculateUserActivityScore(1, @score, @level);
select @score, @level;

-- Xóa stored procedure
drop procedure CalculateUserActivityScore;
