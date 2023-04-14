create table customer (
    customer_id varchar(250),
    customer_unique_id varchar(250),
    customer_zip_code_prefix varchar(250),
    customer_city varchar(100),
    customer_state char(5)
);

create table geolocation (
    geolocation_zip_code_prefix varchar(250),
    geolocation_lat varchar(250),
    geolocation_lng varchar(250),
    geolocation_city varchar(100),
    geolocation_state char(5)
);

create table order_item (
    order_id varchar(250),
    order_item_id varchar(250),
    product_id varchar(250),
    seller_id varchar(250),
    shipping_limit_date timestamp,
    price float,
    freight_value float
);

create table payments (
    order_id varchar(250),
    payment_sequential smallint,
    payment_type varchar(25),
    payment_installments smallint,
    payment_value float
);

create table reviews (
    review_id varchar(250),
    order_id varchar(250),
    review_score smallint,
    review_comment_title varchar(250),
    review_comment_message text,
    review_creation_date timestamp,
    review_answer_timestamp timestamp
);

create table orders (
    order_id varchar(250),
    customer_id varchar(250),
    order_status varchar(50),
    order_purchase_timestamp timestamp,
    order_approved_at timestamp,
    order_delivered_carrier_date timestamp,
    order_delivered_customer_date timestamp,
    order_estimated_delivery_date timestamp
);

create table products (
    index_no integer,
    product_id varchar(250),
    product_category_name varchar(250),
    product_name_lenght varchar(250),
    product_description_lenght float,
    product_photos_qty float,
    product_weight_g float,
    product_length_cm float,
    product_height_cm float,
    product_width_cm float
);

create table sellers (
    seller_id varchar(250),
    seller_zip_code_prefix varchar(250),
    seller_city varchar(100),
    seller_state char(5)
);
