create table products (
    id int primary key,
    name varchar(255),
    price decimal(10,2)
);

create table order_items (
    order_id int,
    product_id int,
    quantity int
);

insert into products (id, name, price)
values
(1, 'Laptop Dell', 20000000),
(2, 'Chuột Logitech', 500000),
(3, 'Bàn phím cơ', 1500000),
(4, 'Màn hình LG', 6000000),
(5, 'Tai nghe Sony', 2500000),
(6, 'USB Kingston', 300000),
(7, 'Ổ cứng SSD', 1800000);

insert into order_items (order_id, product_id, quantity)
values
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(3, 1, 1),
(4, 5, 2),
(5, 4, 1),
(6, 7, 1);

-- lấy danh sách sản phẩm đã từng được bán
select id `mã sản phẩm`, name `tên sản phẩm`, price `giá`
from products
where id in (
    select product_id
    from order_items
);
