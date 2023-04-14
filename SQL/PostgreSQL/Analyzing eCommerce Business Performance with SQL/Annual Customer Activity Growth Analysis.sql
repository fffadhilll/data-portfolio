/*
    1. Menampilkan rata-rata jumlah customer aktif bulanan (monthly active user) untuk 
       setiap tahun
    2. Menampilkan jumlah customer baru pada masing-masing tahun 
    3. Menampilkan jumlah customer yang melakukan pembelian lebih dari satu kali 
       (repeat order) pada masing-masing tahun 
    4. Menampilkan rata-rata jumlah order yang dilakukan customer untuk masing-masing tahun
    5. Menggabungkan ketiga metrik yang telah berhasil ditampilkan menjadi satu tampilan 
       tabel
*/

-- No.1

select 
    year,
    round(avg(jumlah), 1) average_mua
from (
    select 
        date_part('year', o.order_purchase_timestamp) as year,
        date_part('month', o.order_purchase_timestamp) as month,
        count(distinct c.customer_unique_id) jumlah
    from orders o
    join customer c 
    on o.customer_id = c.customer_id
    group by 1,2
    order by 1,2
) subq
group by 1
order by average_mua desc;

--

--No.2
select
    date_part('year', first_purchased_item) as year,
    count(customer_unique_id) jumlah
from
    (select 
        c.customer_unique_id,
        min(o.order_purchase_timestamp) first_purchased_item
    from orders o
    join customer c
    on o.customer_id = c.customer_id
    group by 1) subq
group by 1
order by jumlah desc;

--

-- No.3 
select
    year,
    count(jumlah)   
from
    (select 
        date_part('year', o.order_purchase_timestamp) as year,
        c.customer_unique_id,
        count(customer_unique_id) jumlah
    from
        orders o
    join
        customer c
    on o.customer_id = c.customer_id
    group by 1,2
    having count(customer_unique_id) > 1) subq
group by 1
order by jumlah desc;

--

-- No.4
    
select 
    year,
    round(avg(jumlah), 3) rata2
from
    (select 
        date_part('year', o.order_purchase_timestamp) as year,
        c.customer_unique_id,
        count(c.customer_unique_id) jumlah
    from orders o
    join customer c
    on o.customer_id = c.customer_id
    group by 1,2) subq
group by 1;

--
