insert into customers (id, name, email)
values
(1, 'Nguyen Van A', 'a@gmail.com'),
(2, 'Tran Thi B', 'b@gmail.com'),
(3, 'Le Van C', 'c@gmail.com'),
(4, 'Pham Thi D', 'd@gmail.com'),
(5, 'Hoang Van E', 'e@gmail.com');

insert into orders (id, customer_id, order_date, total_amount)
values
(1, 1, '2024-01-01', 1500000),
(2, 1, '2024-01-03', 3200000),
(3, 2, '2024-01-04', 2800000),
(4, 3, '2024-01-05', 500000),
(5, 3, '2024-01-06', 4200000),
(6, 5, '2024-01-07', 1800000);


-- hiển thị tên khách hàng và số lượng đơn hàng của từng khách
select name `tên khách hàng`,
	(
		select count(o.id)
		from orders o
		where o.customer_id = customers.id
	) `số lượng đơn hàng`
from customers;
