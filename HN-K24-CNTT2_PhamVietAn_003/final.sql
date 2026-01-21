use final;

-- PHẦN 1: THIẾT KẾ CSDL & CHÈN DỮ LIỆU (25 ĐIỂM)

-- Thiết kế CSDL
create table Guests(
	guest_id int primary key,
    full_name varchar(50),
    email varchar(50) unique,
    phone varchar(11) ,
    loyalty_points int default 0 check(loyalty_points >= 0)
);

create table Guest_Profiles(
	profile_id int primary key,
    guest_id int,
    address varchar(255),
    birthday date,
    national_id int unique,
    foreign key (guest_id) references Guests(guest_id)
);

create table Rooms(
	room_id int primary key,
    room_name varchar(100),
    room_type enum('Standard', 'Deluxe', 'Suite'),
	price_per_night int check (price_per_night >= 0),
    room_status enum('Available', 'Occupied', 'Maintenance')
);

create table Bookings (
    booking_id int primary key,
    guest_id int,
    room_id int,
    check_in_date datetime,
    check_out_date datetime,
    total_charge decimal(14,2),
    booking_status enum('pending','completed','cancelled'),
    created_at datetime default now(),
    foreign key (guest_id) references guests(guest_id),
    foreign key (room_id) references rooms(room_id)
);

create table Room_Log(
	log_id int, 
    room_id int, 
    action_type enum('Check-in', 'Check-out', 'Maintenance', 'Cancelled'),
	change_note varchar(100),
    logged_at datetime,
    foreign key (room_id) references Rooms(room_id)
);

-- INSERT dữ liệu theo bảng dữ liệu mẫu
insert into guests(guest_id,full_name,email,phone,points) values
(1,'Nguyen Van A', 'anv@gmail.com', '901234567', 150),
(2,'Tran Thi B','btt@gmail.com','912345678',500),
(3,'Le Van C','cle@yahoo.com','922334455',0),
(4,'Pham Minh D','dpham@hotmail.com','933445566',1000),
(5,'Hoang Anh E','ehoang@gmail.com','944556677',20);

insert into guest_profiles(profile_id,guest_id,address,birthday,national_id) values
(101,1,'123 Le Loi, Q1, HCM','1990-5-15','12345'),
(102,2,'456 Nguyen Hue, Q1, HCM','1985-10-20',23456),
(103,3,'789 Phan Chu Trinh, Da Nang','1995-12-1',34567),
(104,4,'101 Hoang Hoa Tham, Ha Noi','1988-3-25',45678),
(105,5,'202 Tran Hung Dao, Can Tho','2000-7-10',56789);

insert into rooms(room_id,room_name,room_type,price_per_night,room_status) values
(1,'Room 101','Standard',10,'Available'),
(2,'Room 202','Deluxe',	5,'Occupied'),
(3,'Room 303','Suite',50,'Available'),
(4,'Room 104','Standard',0,'Occupied'),
(5,'Room 205','Deluxe',20,'Maintenance');

insert into bookings(booking_id,guest_id,check_in_date,check_out_date,total_charge,booking_status) values
(1001,1,'2023-11-15 10:30','2023-11-18 12:00',35500000,'Completed'),
(1002,2,'2023-1-12 14:20','2023-4-12 12:00',28000000,'Completed'),
(1003,1,'2024-1-10 9:15','2024-1-11 12:00',500000,'Pending'),
(1004,3,'2023-5-20 16:45','2023-5-22 12:00',7000000,'Cancelled'),
(1005,4,'2024-1-18 11:00','2024-1-20 12:00',1200000,'Completed');

insert into room_log(log_id,room_id,action_type,change_note,logged_at) values
(1,1,'Check-in','Guest checked in','10/1/2023 8:00'),
(2,1,'Check-out','Guest checked out','11/15/2023 10:35'),
(3,4,'Maintenance','Room reported as damaged','11/20/2023 15:00'),
(4,2,'Check-in','New guest arrival','11/25/2023 9:00'),
(5,3,'Maintenance','Schedule maintenance','12/1/2023 13:00');

-- UPDATE cộng 200 điểm tích lũy cho các khách hàng có email là đuôi '@gmail.com'
update guests
set loyalty_points = loyalty_points + 200
where email like '%@gmail.com';

-- DELETE xóa các bản ghi trong Room_Log có logged_at trước ngày 10/11/2023.
delete from room_log
where logged_at < '2023-11-10';

-- PHẦN 2: TRUY VẤN DỮ LIỆU CƠ BẢN (15 ĐIỂM)

-- câu 1
select room_name, price_per_night, room_status from rooms
where price_per_night > 1000000 or room_status = 'maintenance' or room_type = 'suite';

-- câu 2
select full_name,email,points from guests
where email like '%@gmail.com' and loyalty_points between 50 and 300;

-- câu 3
select booking_id,total_charge from bookings
order by total_charge desc 
limit 3 offset 1;

-- PHẦN 3: TRUY VẤN DỮ LIỆU NÂNG CAO (20 ĐIỂM)
-- câu 1
select g.full_name, gp.national_id, b.booking_id, b.check_in_date, b.total_charge
from bookings b
join guests g on b.guest_id = g.guest_id
join guest_profiles gp on g.guest_id = gp.guest_id;

-- câu 2
select g.full_name, sum(b.total_charge) as total_charge
from bookings b
join guests g on b.guest_id = g.guest_id
where b.booking_status = 'Completed'
group by g.guest_id
having total_charge > 20000000;

-- câu 3
select r.room_id, r.room_name, r.room_type, r.price_per_night, r.room_status from rooms r
join bookings b on r.room_id = b.room_id
where b.booking_status = 'completed'
order by r.price_per_night desc
limit 1;

-- PHẦN 4: INDEX VÀ VIEW (10 ĐIỂM)
-- câu 1
create index idx_booking_status_date on bookings (booking_status, created_at);

-- câu 2
create view vw_guest_booking_stats as
select g.full_name as guest_name, count(b.booking_id) as total_bookings, sum(b.total_charge) as total_paid from guests g
left join bookings b on g.guest_id = b.guest_id and b.booking_status <> 'cancelled'
group by g.guest_id;

-- PHẦN 5: TRIGGER (10 ĐIỂM)
delimiter $$
-- câu 1
create trigger trg_after_update_booking_status
after update on bookings
for each row
begin
    if new.booking_status = 'completed'
       and old.booking_status <> 'completed' then
        insert into room_log (room_id,action_type,change_note,logged_at)
        values (new.room_id,'check-out','booking completed',now());
    end if;
end$$

-- câu 2
create trigger trg_update_loyalty_points
after insert on bookings
for each row
begin
    if new.booking_status = 'completed' then
        update guests
        set loyalty_points = loyalty_points
            + floor(new.total_charge / 1000000) * 2
        where guest_id = new.guest_id;
    end if;
end$$

delimiter ;
-- PHẦN 6: STORED PROCEDURE (20 ĐIỂM)
-- câu 1
delimiter $$

create procedure sp_get_room_status(in p_room_id int)
begin
    declare rs varchar(20);
    select room_status into rs
    from rooms
    where room_id = p_room_id;

    if rs = 'available' then
        select 'phòng trống' as message;
    elseif rs = 'occupied' then
        select 'đang có khách' as message;
    else
        select 'bảo trì' as message;
    end if;
end$$

-- câu 2
delimiter ;

