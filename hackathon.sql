create database hackathon;

use hackathon;

-- tạo bảng
create table Users(
	user_id varchar(5) primary key,
    full_name varchar(100) not null,
    email varchar(100) not null unique,
    phone varchar(15) not null unique
);

create table Categories(
	category_id varchar(5) primary key,
    category_name varchar(100) not null unique
);

create table Books(
	book_id varchar(5) primary key,
    title varchar(100) not null unique,
    category_id varchar(5) not null,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    price decimal(10,2) not null,
    stock int not null
);

create table Borrows(
	borrow_id int primary key AUTO_INCREMENT,
    user_id varchar(5) not null,
    book_id varchar(5) not null,
    status varchar(20) check(status = 'Borrowing'or status = 'Returned'or status = 'Lost'),
    borrow_date date not null,
    FOREIGN KEY(user_id) REFERENCES Users(user_id),
    FOREIGN KEY(book_id) REFERENCES Books(book_id)
);

-- thêm dữ liệu vào bảng
insert into Users(user_id,full_name,email,phone)
values
('U01','Nguyễn Văn An','a@m.com','0912345678'),
('U02','Trần Thị Bích','b@m.com','0923456789'),
('U03','Lê Hoàng Minh','mi@m.com','0934567890'),
('U04','Phạm Thu Hà','h@m.com','0945678901'),
('U05','Võ Quốc Huy','hu@gmail.com','0956789012');

insert into Categories(category_id, category_name)
values
('C01','IT'),
('C02','Literature'),
('C03','Science'),
('C04','History');

insert into Books (book_id,title,category_id,price,stock)
values
('B01','Clean Code','C01',250000,10),
('B02','Desgin Pattern','C01',300000,5),
('B03','Tat Den','C02',50000,20),
('B04','Universe','C03',150000,8),
('B05','Sapiens','C04',200000,15);

insert into Borrows(borrow_id,user_id,book_id,status,borrow_date)
VALUE
(1,'U01','B01','Borrowing','2025-10-01'),
(2,'U02','B03','Returned','2025-10-02'),
(3,'U01','B02','Returned','2025-10-03'),
(4,'U04','B05','Lost','2025-10-04'),
(5,'U05','B01','Borrowing','2025-10-05');

-- cập nhật bảng
update Books
set stock = stock +10
where title = "Sapiens";

update Books
set price = price+price *0.5
where title = "Sapiens";

update Users
set phone = '0999999999'
where user_id = 'U03';

-- xóa phần tử
delete from Borrows
where status = 'Returned' AND borrow_date < '2025-10-03';

-- truy van du lieu co ban
-- cau 6
select 
	book_id,
	title,
	price
from Books
where (price>= 100000 and price <= 250000) and stock >0;

-- cau 7
select 
	full_name,
    email
from Users
where full_name = 'Nguyen';
-- cau 8
select 
	borrow_id,
    user_id,
    borrow_date
from Borrows
order by borrow_date desc;

-- cau 9
select
	price
from Books
ORDER BY price desc limit 3;

-- cau 10
select 
	title,
    stock
from Books
limit 2 offset 2;

-- truy van du lieu nang cao
-- cau 11
select 
	borrow_id,
    full_name,
    title,
    borrow_date
from Borrows, Users,Books
where status = 'Borrowing';	

-- cau 13
select count(status) as total_borrows
from Borrows;
select 
	status
where status in (
    select 
    status, 
    count(status)
from Borrows);
-- cau 15
select avg(price)
from Books;
select
	book_id,
    title,
    price
from Books
where price < (
	select avg(price)
    from Books
);