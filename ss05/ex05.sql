-- hiển thị 5 đơn hàng mới nhất
select order_id 'mã đơn', customer_id 'mã khách hàng', total_amount 'tổng tiền', order_date 'ngày đặt', status 'trạng thái' from orders 
order by order_date desc 
limit 5;


-- hiển thị 5 đơn hàng tiếp theo
select order_id 'mã đơn', customer_id 'mã khách hàng', total_amount 'tổng tiền', order_date 'ngày đặt', status 'trạng thái' from orders 
order by order_date desc 
limit 5 
offset 5;


-- hiển thị 5 đơn hàng tiếp theo
select order_id 'mã đơn', customer_id 'mã khách hàng', total_amount 'tổng tiền', order_date 'ngày đặt', status 'trạng thái' from orders 
order by order_date desc 
limit 5 
offset 10;

-- chỉ hiển thị các đơn hàng chưa bị huỷ
select order_id 'mã đơn', customer_id 'mã khách hàng', total_amount 'tổng tiền', order_date 'ngày đặt', status 'trạng thái' from orders 
where status <> 'cancelled';
