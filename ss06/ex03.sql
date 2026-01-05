-- Tính tổng doanh thu theo từng ngày
select order_date `ngày`, sum(total_amount) `tổng doanh thu`
from orders
where status = 'completed'
group by order_date;

-- Tính số lượng đơn hàng theo từng ngày
select order_date `ngày`, count(order_id) `số đơn hàng`
from orders
where status = 'completed'
group by order_date;

-- Chỉ hiển thị các ngày có doanh thu > 10.000.000
select order_date `ngày`, sum(total_amount) `tổng doanh thu`
from orders
where status = 'completed'
group by order_date
having sum(total_amount) > 10000000;
