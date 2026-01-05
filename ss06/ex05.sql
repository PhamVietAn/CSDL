select c.customer_id `mã khách hàng`, c.full_name `tên khách hàng`, count(o.order_id) `tổng số đơn hàng`, sum(o.total_amount) `tổng tiền đã chi`, avg(o.total_amount) `giá trị đơn hàng trung bình`
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name
having count(o.order_id) >= 3
and sum(o.total_amount) > 10000000
order by sum(o.total_amount) desc;
