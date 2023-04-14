-- query menggunakan database eCommerce
use eCommerce

-- query add foreign key HeaderSellTransaction table
alter table HeaderSellTransaction
	add constraint fk_customer
		foreign key (customerID) references Customer(customerID)
			on delete cascade on update cascade

alter table HeaderSellTransaction
	add constraint fk_staff
		foreign key (staffID) references Staff(staffID)
			on delete cascade on update cascade

-- query add foreign key Item table
alter table Item
	add constraint fk_itemType
		foreign key (itemTypeID) references ItemType(itemTypeID)
			on delete cascade on update cascade

--change column size in HeaderSellTransaction table
alter table HeaderSellTransaction
alter column customerID char(5)

alter table HeaderSellTransaction
alter column staffID char(5)

--add column in DetailSellTransaction table
alter table DetailSellTransaction
add 
	sellQuantity integer