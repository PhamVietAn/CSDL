create table orders (
    order_id int primary key,
    customer_id int,
    total_amount decimal(10,2),
    order_date date,
    status enum('pending', 'completed', 'cancelled')
);

insert into orders (order_id, customer_id, total_amount, order_date, status)
values
(1, 1, 3200000, '2024-01-01', 'completed'),
(2, 2, 7800000, '2024-01-02', 'pending'),
(3, 3, 12500000, '2024-01-03', 'completed'),
(4, 4, 4500000, '2024-01-04', 'cancelled'),
(5, 2, 9800000, '2024-01-05', 'completed'),
(6, 5, 1500000, '2024-01-06', 'pending'),
(7, 1, 6700000, '2024-01-07', 'completed'),
(8, 6, 2300000, '2024-01-08', 'completed'),
(9, 3, 5400000, '2024-01-09', 'pending'),
(10, 4, 8600000, '2024-01-10', 'completed'),
(11, 5, 2900000, '2024-01-11', 'pending'),
(12, 6, 13400000, '2024-01-12', 'completed'),
(13, 2, 4100000, '2024-01-13', 'completed'),
(14, 1, 7600000, '2024-01-14', 'pending'),
(15, 3, 9900000, '2024-01-15', 'completed');

-- lấy danh sách đơn hàng đã hoàn thành
select order_id 'mã đơn', customer_id 'mã khách hàng', total_amount 'tổng tiền', order_date 'ngày đặt', status 'trạng thái' from orders 
where status = 'completed';

-- lấy các đơn hàng có tổng tiền > 5.000.000
select order_id 'mã đơn', customer_id 'mã khách hàng', total_amount 'tổng tiền', order_date 'ngày đặt', status 'trạng thái' from orders 
where total_amount > 5000000;

-- hiển thị 5 đơn hàng mới nhất
select order_id 'mã đơn', customer_id 'mã khách hàng', total_amount 'tổng tiền', order_date 'ngày đặt', status 'trạng thái' from orders 
order by order_date desc 
limit 5;

-- hiển thị các đơn hàng đã hoàn thành, sắp xếp theo tổng tiền giảm dần
select order_id 'mã đơn', customer_id 'mã khách hàng', total_amount 'tổng tiền', order_date 'ngày đặt', status 'trạng thái' from orders 
where status = 'completed' 
order by total_amount desc;



