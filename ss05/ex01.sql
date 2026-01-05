CREATE DATABASE ss05;
USE ss05;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255),
    price DECIMAL(10,2),
    stock INT,
    status enum('active', 'inactive')
);

insert into products (product_id, product_name, price, stock, status)
values
(1, 'iphone 14', 18990000, 15, 'active'),
(2, 'samsung galaxy s23', 16990000, 20, 'active'),
(3, 'xiaomi redmi note 12', 5490000, 35, 'active'),
(4, 'oppo reno 8', 8990000, 10, 'inactive'),
(5, 'macbook air m1', 23990000, 5, 'active'),
(6, 'asus vivobook', 15990000, 8, 'inactive'),
(7, 'airpods pro', 6190000, 25, 'active'),
(8, 'logitech mx master 3', 2490000, 40, 'active');


-- lấy toàn bộ sản phẩm trong hệ thống
select product_id 'Mã sản phẩm',product_name 'Tên sản phẩm',price 'Giá tiền',stock 'Tồn kho',status 'Trạng thái' from products;

-- lấy danh sách sản phẩm đang bán
select product_id 'Mã sản phẩm',product_name 'Tên sản phẩm',price 'Giá tiền',stock 'Tồn kho',status 'Trạng thái' from products
where status = 'active';

-- lấy các sản phẩm có giá lớn hơn 1.000.000
select product_id 'Mã sản phẩm',product_name 'Tên sản phẩm',price 'Giá tiền',stock 'Tồn kho',status 'Trạng thái' from products
where price > 1000000;

-- hiển thị sản phẩm đang bán, sắp xếp theo giá tăng dần
select product_id 'Mã sản phẩm',product_name 'Tên sản phẩm',price 'Giá tiền',stock 'Tồn kho',status 'Trạng thái' from products
where status = 'active'
order by price asc;
