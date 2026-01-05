create database ss06;
use ss06;

create table customers (
    customer_id int primary key,
    full_name varchar(255),
    city varchar(255)
);

create table orders (
    order_id int primary key,
    customer_id int,
    order_date date,
    status enum('pending', 'completed', 'cancelled')
);

insert into customers (customer_id, full_name, city)
values
(1, 'pham viet an', 'tp.hcm'),
(2, 'nguyen thi mai', 'ha noi'),
(3, 'tran van binh', 'da nang'),
(4, 'le hoang nam', 'tp.hcm'),
(5, 'do thi lan', 'ha noi');

insert into orders (order_id, customer_id, order_date, status)
values
(1, 1, '2024-01-01', 'completed'),
(2, 1, '2024-01-05', 'pending'),
(3, 2, '2024-01-03', 'completed'),
(4, 3, '2024-01-04', 'cancelled'),
(5, 4, '2024-01-06', 'completed');

-- hiển thị danh sách đơn hàng kèm tên khách hàng
select o.order_id `mã đơn`, c.full_name `tên khách hàng`, o.order_date `ngày đặt`, o.status `trạng thái`
from orders o
join customers c
on o.customer_id = c.customer_id;

-- hiển thị mỗi khách hàng đã đặt bao nhiêu đơn hàng
select c.customer_id `mã khách hàng`, c.full_name `tên khách hàng`, count(o.order_id) `số đơn hàng`
from customers c
left join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;

-- chỉ hiển thị các khách hàng có ít nhất 1 đơn hàng
select c.customer_id `mã khách hàng`, c.full_name `tên khách hàng`, count(o.order_id) `số đơn hàng`
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.full_name
having count(o.order_id) >= 1;


