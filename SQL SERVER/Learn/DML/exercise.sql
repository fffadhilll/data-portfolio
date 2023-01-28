/*
	1. Ubahlah CustomerName menjadi nama pertama dari CustomerName pada table Customer dimana Customer tersebut pernah melakukan transaksi pada tanggal 21.
	Kemudian tampilkan seluar data dari Customer.
	jika sudah berhasil kembalikan datanya seperti semula !

	2. Ubahlah PaymentType menjadi “Hutang” untuk setiap transaksi yang di lakukan oleh Customer CU001.
	jika sudah berhasil kembalikan datanya seperti semula !

	3. Hapus data staff yang memiliki Salary di bawah Rp.7.000.000. Kemudian Tampilkan Seluruh data dari table Staff
	jika sudah berhasil kembalikan datanya seperti semula !

	4. Tamplikan TransactionData,CustomerName,itemName,Discount(didapat dari 20% Price) dan PaymentType dimana transaksi terjadi pada tanggal 22.
	jika sudah berhasil kembalikan datanya seperti semula !
*/

--1 SUBSTRING(customerName, 1, CHARINDEX(' ', customerName))
BEGIN TRANSACTION
	update 
		Customer
	set 
		customerName = SUBSTRING(customerName, 1, CHARINDEX(' ', customerName)-1)
	from 
		Customer c
	join 
		HeaderSellTransaction h
	on
		c.customerID = h.customerID
	where
		DATENAME(day, h.transactionDate) = 21
rollback

--2
BEGIN TRANSACTION
	UPDATE 
		HeaderSellTransaction
	SET
		paymentType = 'Hutang'
	WHERE 
		customerID = 'CU001'
ROLLBACK

--3
BEGIN TRAN
	DELETE 
	FROM 
		Staff
	WHERE
		staffSalary < 7000000
ROLLBACK

--4
BEGIN TRAN
	SELECT
		h.transactionDate,
		c.customerName,
		i.itemName,
		[discount] = i.price * 0.2,
		h.paymentType
	FROM 
		Customer c
	join 
		HeaderSellTransaction h
	on
		c.customerID = h.customerID
	join 
		DetailSellTransaction d
	on
		h.transactionID = d.transactionID
	join 
		Item i
	on
		d.itemID = i.itemID
	where
		DATENAME(day, h.transactionDate) = 22
ROLLBACK

select *
from Staff