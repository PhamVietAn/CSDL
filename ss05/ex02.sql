create table customers (
    customer_id int primary key,
    full_name varchar(255),
    email varchar(255),
    city varchar(255),
    status enum('active', 'inactive')
);

insert into customers (customer_id, full_name, email, city, status)
values
(1, 'pham viet an', 'an.pham@gmail.com', 'tp.hcm', 'active'),
(2, 'nguyen thi mai', 'mai.nguyen@gmail.com', 'ha noi', 'active'),
(3, 'tran van binh', 'binh.tran@gmail.com', 'da nang', 'inactive'),
(4, 'le hoang nam', 'nam.le@gmail.com', 'tp.hcm', 'active'),
(5, 'do thi lan', 'lan.do@gmail.com', 'ha noi', 'inactive'),
(6, 'vu quoc huy', 'huy.vu@gmail.com', 'ha noi', 'active'),
(7, 'bui minh chau', 'chau.bui@gmail.com', 'can tho', 'active'),
(8, 'pham thanh tung', 'tung.pham@gmail.com', 'tp.hcm', 'inactive');

-- lấy danh sách tất cả khách hàng
select customer_id 'mã khách hàng', full_name 'tên khách hàng', email 'email', city 'thành phố', status 'trạng thái' from customers;

-- lấy khách hàng ở tp.hcm
select customer_id 'mã khách hàng', full_name 'tên khách hàng', email 'email', city 'thành phố', status 'trạng thái' from customers 
where city = 'tp.hcm';

-- lấy khách hàng đang hoạt động và ở hà nội
select customer_id 'mã khách hàng', full_name 'tên khách hàng', email 'email', city 'thành phố', status 'trạng thái' from customers 
where status = 'active' and city = 'ha noi';

-- sắp xếp danh sách khách hàng theo tên
select customer_id 'mã khách hàng', full_name 'tên khách hàng', email 'email', city 'thành phố', status 'trạng thái' from customers 
order by full_name asc;
