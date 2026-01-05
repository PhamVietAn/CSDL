alter table orders
add total_amount decimal(10,2);

update orders
set total_amount = 1500000
where order_id = 1;

update orders
set total_amount = 800000
where order_id = 2;

update orders
set total_amount = 2300000
where order_id = 3;

update orders
set total_amount = 1200000
where order_id = 4;

update orders
set total_amount = 3000000
where order_id = 5;

-- hiển thị tổng tiền mà mỗi khách hàng đã chi tiêu
select c.customer_id `mã khách hàng`, c.full_name `tên khách hàng`, sum(o.total_amount) `tổng tiền đã chi`
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;


-- hiển thị giá trị đơn hàng cao nhất của từng khách
select c.customer_id `mã khách hàng`, c.full_name `tên khách hàng`, max(o.total_amount) `đơn hàng cao nhất`
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;

-- sắp xếp danh sách khách hàng theo tổng tiền giảm dần
select c.customer_id `mã khách hàng`, c.full_name `tên khách hàng`, sum(o.total_amount) `tổng tiền đã chi`
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.full_name
order by sum(o.total_amount) desc;
