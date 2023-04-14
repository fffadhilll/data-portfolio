-- query membuat database eCommerce
create database eCommerce

-- query menggunakan database eCommerce
use eCommerce

-- query membuat table customer
create table Customer (
	customerID char(5) primary key not null,
	constraint checkCustomerID CHECK(customerID = 'CU[0-9][0-9][0-9]'),

	customerName varchar(50) not null,
	
	customerGender varchar(10),
	constraint checkCustomerGender CHECK(customerGender = 'Male' or customerGender = 'Female'),

	customerPhone varchar(13),
	customerAddress varchar(100)
)

-- query membuat table staff
create table Staff (
	staffID char(5) primary key not null,
	constraint checkStaffID CHECK(staffID = 'SF[0-9][0-9][0-9]'),

	staffName varchar(50) not null,

	staffGender varchar(10),
	constraint checkStaffGender CHECK(staffGender = 'Male' or staffGender = 'Female'),

	staffPhone varchar(13),
	staffAddress varchar(100),
	staffSalary numeric(11,2),
	staffPosition varchar(20)
)

-- query membuat table item
create table Item (
	itemID char(5) not null primary key,
	constraint checkItemID CHECK(itemID = 'IM[0-9][0-9][0-9]'),

	itemTypeID char(5) not null,
	itemName varchar(10) not null,
	price numeric(11,2),
	quantity integer
)

-- query membuat table itemType
create table ItemType (
	itemTypeID char(5) not null primary key,
	constraint checkItemTypeID CHECK(itemTypeID = 'IT[0-9][0-9][0-9]'),

	itemTypeName varchar(10) not null,
)

--query membuat table HeaderSellTransaction 
create table HeaderSellTransaction (
	transactionID char(5) not null primary key,
	constraint checkTransactionID CHECK(transactionID = 'CU[0-9][0-9][0-9]'),

	customerID char(50) not null,
	staffID char(10) not null,
	transactionDate date,
	paymentType varchar(20)
)

-- query membuat table DetailSellTransaction
create table DetailSellTransaction (
	transactionID char(5) references HeaderSellTransaction on update cascade on delete cascade,
	itemID char(5) references Item on update cascade on delete cascade,
	primary key(transactionID, itemID)
)