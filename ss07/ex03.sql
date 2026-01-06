insert into orders (id, customer_id, order_date, total_amount)
values
(1, 1, '2024-01-01', 1500000),
(2, 2, '2024-01-02', 3200000),
(3, 3, '2024-01-03', 5000000),
(4, 1, '2024-01-04', 8000000),
(5, 2, '2024-01-05', 1200000),
(6, 4, '2024-01-06', 9500000);


-- lấy danh sách đơn hàng có giá trị lớn hơn giá trị trung bình của tất cả đơn hàng
select id `mã đơn`, customer_id `mã khách hàng`, order_date `ngày đặt`, total_amount `tổng tiền`
from orders
where total_amount > (
    select avg(total_amount)
    from orders
);
