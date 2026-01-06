insert into customers (id, name, email)
values
(1, 'Nguyen Van A', 'a@gmail.com'),
(2, 'Tran Thi B', 'b@gmail.com'),
(3, 'Le Van C', 'c@gmail.com'),
(4, 'Pham Thi D', 'd@gmail.com'),
(5, 'Hoang Van E', 'e@gmail.com');

insert into orders (id, customer_id, order_date, total_amount)
values
(1, 1, '2024-01-01', 2000000),
(2, 1, '2024-01-03', 3500000),
(3, 2, '2024-01-04', 4200000),
(4, 3, '2024-01-05', 1500000),
(5, 3, '2024-01-06', 2800000),
(6, 4, '2024-01-07', 9000000),
(7, 5, '2024-01-08', 1200000);

-- tìm khách hàng có tổng số tiền mua hàng lớn nhất
select id `mã khách hàng`, name `tên khách hàng`, email `email`
from customers
where id = (
    select customer_id
    from orders
    group by customer_id
    having sum(total_amount) = (
        select max(t.total_spent)
        from (
            select sum(total_amount) total_spent
            from orders
            group by customer_id
        ) t
    )
);
