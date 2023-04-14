alter table products
add primary key(product_id);

alter table sellers
add primary key(seller_id);

alter table customers
add primary key(customer_id);

alter table orders
add primary key(order_id);

alter table geolocation
add primary key(geolocation_zip_code_prefix);

-- remove duplicate data on geolocation_zip_code_prefix column
begin transaction
    DELETE FROM geolocation g1
    WHERE EXISTS(
            SELECT*FROM geolocation g2
            WHERE g1.geolocation_zip_code_prefix = g2.geolocation_zip_code_prefix
            AND g1.ctid < g2.ctid
            );
commit

alter table order_item
    add constraint fk_products
        foreign key(product_id)
            references products(product_id),
    add constraint fk_sellers
        foreign key(seller_id)
            references sellers(seller_id),
    add constraint fk_orders
        foreign key(order_id)
            references orders(order_id);
            
alter table orders
    add constraint fk_customers
        foreign key(customer_id)
            references customer(customer_id);
            
alter table payments
    add constraint fk_orders
        foreign key(order_id)
            references orders(order_id);
            
alter table reviews
    add constraint fk_orders
        foreign key(order_id)
            references orders(order_id);

begin transaction
    alter table sellers
        add constraint fk_geolocation
            foreign key(seller_zip_code_prefix)
                references geolocation(geolocation_zip_code_prefix)
commit

begin transaction
    alter table customers
        add constraint fk_geolocation
            foreign key(customer_zip_code_prefix)
                references geolocation(geolocation_zip_code_prefix)
commit
