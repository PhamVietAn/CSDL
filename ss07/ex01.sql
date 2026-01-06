create table customers (
    id int primary key,
    name varchar(255),
    email varchar(255)
);

create table orders (
    id int primary key,
    customer_id int,
    order_date date,
    total_amount decimal(10,2)
);

insert into customers (id, name, email)
values
(1, 'Nguyen Van A', 'a@gmail.com'),
(2, 'Tran Thi B', 'b@gmail.com'),
(3, 'Le Van C', 'c@gmail.com'),
(4, 'Pham Thi D', 'd@gmail.com'),
(5, 'Hoang Van E', 'e@gmail.com'),
(6, 'Do Thi F', 'f@gmail.com'),
(7, 'Vu Van G', 'g@gmail.com');

insert into orders (id, customer_id, order_date, total_amount)
values
(1, 1, '2024-01-01', 1500000),
(2, 2, '2024-01-02', 3200000),
(3, 1, '2024-01-03', 2700000),
(4, 3, '2024-01-04', 900000),
(5, 4, '2024-01-05', 5100000),
(6, 2, '2024-01-06', 1800000),
(7, 5, '2024-01-07', 2500000);

-- lấy danh sách khách hàng đã từng đặt đơn hàng
select id `mã khách hàng`, name `tên khách hàng`, email `email`
from customers
where id in (
    select customer_id
    from orders
);
