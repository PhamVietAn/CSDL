create table products (
    product_id int primary key,
    product_name varchar(255),
    price decimal(10,2)
);

create table order_items (
    order_id int,
    product_id int,
    quantity int,
    primary key (order_id, product_id),
    foreign key (product_id) references products(product_id)
);

insert into products (product_id, product_name, price)
values
(1, 'Laptop Dell', 20000000),
(2, 'Chuột Logitech', 500000),
(3, 'Bàn phím cơ', 1500000),
(4, 'Màn hình LG', 6000000),
(5, 'Tai nghe Sony', 2500000);

insert into order_items (order_id, product_id, quantity)
values
(1, 1, 1),
(1, 2, 2),
(2, 3, 3),
(3, 4, 1),
(4, 5, 2),
(5, 1, 1),
(5, 4, 1);

-- hiển thị mỗi sản phẩm đã bán được bao nhiêu sản phẩm
select p.product_id `mã sản phẩm`, p.product_name `tên sản phẩm`, sum(oi.quantity) `số lượng đã bán`
from products p
join order_items oi
on p.product_id = oi.product_id
group by p.product_id, p.product_name;

-- tính doanh thu của từng sản phẩm
select p.product_id `mã sản phẩm`, p.product_name `tên sản phẩm`, sum(oi.quantity * p.price) `doanh thu`
from products p
join order_items oi
on p.product_id = oi.product_id
group by p.product_id, p.product_name;

-- chỉ hiển thị các sản phẩm có doanh thu > 5.000.000
select p.product_id `mã sản phẩm`, p.product_name `tên sản phẩm`, sum(oi.quantity * p.price) `doanh thu`
from products p
join order_items oi
on p.product_id = oi.product_id
group by p.product_id, p.product_name
having sum(oi.quantity * p.price) > 5000000;
