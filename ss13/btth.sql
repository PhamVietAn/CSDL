create database SocialNetworkDB;
use SocialNetworkDB;

create table users (
    user_id int auto_increment primary key,
    username varchar(50) not null,
    total_posts int default 0
);

insert into users(username) values
('an'),
('binh'),
('chi'),
('dung'),
('hoa'),
('khanh'),
('linh'),
('minh'),
('nam'),
('phuong');

create table posts (
    post_id int auto_increment primary key,
    user_id int not null,
    content text,
    created_at datetime,
    foreign key (user_id) references users(user_id)
);

insert into posts(user_id, content, created_at) values
(1, 'Bài viết đầu tiên của An', now()),
(2, 'Bình đang học MySQL', now()),
(3, 'Chia sẻ kiến thức SQL', now()),
(4, 'Trigger giúp tự động hóa xử lý', now()),
(5, 'Hoa rất thích lập trình', now()),
(6, 'Khánh bắt đầu học CSDL', now()),
(7, 'Linh đang làm bài thực hành', now()),
(8, 'Minh tìm hiểu về trigger', now()),
(9, 'Nam học SQL nâng cao', now()),
(10, 'Phương mới tham gia hệ thống', now());

create table post_audits (
    audit_id int auto_increment primary key,
    post_id int,
    old_content text,
    new_content text,
    changed_at datetime
);

-- Task 1 – BEFORE INSERT: kiểm tra nội dung bài viết
delimiter $$

create trigger tg_CheckPostContent
before insert on posts
for each row
begin
    -- kiểm tra nội dung bài viết không được rỗng
    if trim(new.content) = '' then
        signal sqlstate '45000'	 set message_text = 'Nội dung bài viết không được để trống!';
    end if;
end$$

delimiter ;

-- Task 2 – AFTER INSERT: tăng total_posts
delimiter $$

create trigger tg_UpdatePostCountAfterInsert
after insert on posts
for each row
begin
    update users
    set total_posts = total_posts + 1
    where user_id = new.user_id;
end$$

delimiter ;

-- Task 3 – AFTER UPDATE: ghi log chỉnh sửa bài viết
delimiter $$

create trigger tg_LogPostChanges
after update on posts
for each row
begin
    -- chỉ ghi log khi nội dung thay đổi
    if old.content <> new.content then
        insert into post_audits(post_id, old_content, new_content, changed_at)
        values (
            old.post_id,
            old.content,
            new.content,
            now()
        );
    end if;
end$$

delimiter ;

-- Task 4 - AFTER DELETE: giảm total_posts
delimiter $$

create trigger tg_UpdatePostCountAfterDelete
after delete on posts
for each row
begin
    update users
    set total_posts = total_posts - 1
    where user_id = old.user_id;
end$$

delimiter ;
