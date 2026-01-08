create database hackathon;
use hackathon;

create table patient (
	patient_id varchar(5) primary key,
    patient_full_name varchar(100) not null,
    patient_dob date,
    patient_gender varchar(10),
    patient_phone varchar(15) unique
);

create table doctor (
	doctor_id varchar(5) primary key,
    doctor_full_name varchar(100),
    doctor_specialty varchar(100),
    doctor_phone varchar(15) unique
);

create table department (
	department_id varchar(5) primary key,
    department_name varchar(100) unique,
    department_location varchar(100)
);

create table appointment (
	appointment_id int primary key auto_increment,
    patient_id varchar(5),
    doctor_id varchar(5),
    department_id varchar(5),
    appointment_date date,
    appointment_status varchar(20),
    foreign key (patient_id) references patient(patient_id),
    foreign key (doctor_id) references doctor(doctor_id),
    foreign key (department_id) references department(department_id)
);

insert into patient(patient_id,patient_full_name,patient_dob,patient_gender,patient_phone) values
("P001","Nguyễn Văn An","1995-03-15","Nam","0912345678"),
("P002","Trần Thị Bích","1998-07-22","Nữ","0923456789"),
("P003","Lê Hoàng Minh","1987-11-05","Nam","0934567890"),
("P004","Phạm Thu Hà","2000-01-18","Nữ","0945678901"),
("P005","Võ Quốc Huy","1992-09-30","Nam","0956789012");

insert into doctor(doctor_id,doctor_full_name,doctor_specialty,doctor_phone) values
("D001","BS. Nguyễn Thanh Tùng","Nội khoa","0901112222"),
("D002","BS. Trần Minh Đức","Ngoại khoa","0902223333"),
("D003","BS. Lê Thị Lan","Nhi khoa","0903334444"),
("D004","BS. Phạm Quốc Bảo","Tim mạch","0904445555"),
("D005","BS. Võ Hoàng Yến","Da liễu","0905556666");

insert into department(department_id,department_name,department_location) values
("DP01","Khoa Nội", "Tầng 1"),
("DP02","Khoa Ngoại", "Tầng 2"),
("DP03","Khoa Nhi", "Tầng 3"),
("DP04","Khoa Tim mạch", "Tầng 4"),
("DP05","Khoa Da liễu", "Tầng 5");

insert into appointment(appointment_id,patient_id,doctor_id,department_id,appointment_date,appointment_status) values
(1,"P001","D001","DP01","2025-10-01","Completed"),
(2,"P002","D002","DP02","2025-10-02","Completed"),
(3,"P003","D003","DP03","2025-10-03","Pending"),
(4,"P004","D004","DP04","2025-10-04","Cancelled"),
(5,"P005","D005","DP05","2025-10-05","Completed");

-- 3
update patient
set patient_phone = "096536868"
where patient_id = "P003";

-- 4
update appointment 
set appointment_status = "Cancelled"
where appointment_id = 3;

-- 5
delete from appointment
where appointment_status = "Cancelled" and appointment_date < "2025-10-04";

-- Phần 2

-- 6
select appointment_id,appointment_date,appointment_status from appointment
where appointment_status = "Completed" and appointment_date > "2025-10-01";

-- 7
select patient_full_name,patient_phone,patient_gender from patient
where patient_phone like "09%";

-- 8
select appointment_id,patient_id,appointment_date from appointment
order by appointment_date desc;

-- 9
select * from appointment
where appointment_status = "Completed"
limit 3;

-- 10
select patient_id,patient_full_name from patient
limit 3 offset 2;

-- Phần 3

-- 11