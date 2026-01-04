create table productsEx04 (
    product_id int primary key,
    product_name varchar(255),
    price decimal(10,2),
    stock int,
    sold_quantity int,
    status enum('active', 'inactive')
);

insert into productsEx04 (product_id, product_name, price, stock, sold_quantity, status)
values
(1, 'iphone 14', 18990000, 15, 120, 'active'),
(2, 'samsung galaxy s23', 16990000, 20, 95, 'active'),
(3, 'xiaomi redmi note 12', 5490000, 40, 150, 'active'),
(4, 'oppo a57', 3990000, 30, 80, 'active'),
(5, 'nokia c21', 1890000, 50, 60, 'active'),
(6, 'realme c55', 4290000, 25, 110, 'active'),
(7, 'itel a60', 1590000, 70, 45, 'active'),
(8, 'samsung a04', 2490000, 35, 90, 'active'),
(9, 'vivo y02', 2990000, 20, 55, 'active'),
(10, 'xiaomi poco m5', 3790000, 18, 130, 'active'),
(11, 'masstel izi', 1290000, 100, 40, 'active'),
(12, 'itel it217', 990000, 200, 25, 'active');

-- lấy 10 sản phẩm bán chạy nhất
select product_id 'mã sản phẩm', product_name 'tên sản phẩm', price 'giá tiền', sold_quantity 'đã bán' from productsEx04 
order by sold_quantity desc 
limit 10;

-- lấy 5 sản phẩm bán chạy tiếp theo
select product_id 'mã sản phẩm', product_name 'tên sản phẩm', price 'giá tiền', sold_quantity 'đã bán' from productsEx04 
order by sold_quantity desc 
limit 5 
offset 10;

-- hiển thị sản phẩm giá < 2.000.000, sắp xếp theo số lượng bán giảm dần
select product_id 'mã sản phẩm', product_name 'tên sản phẩm', price 'giá tiền', sold_quantity 'đã bán' from productsEx04 
where price < 2000000 
order by sold_quantity desc;




