/*
    1. Membuat tabel yang berisi informasi pendapatan/revenue perusahaan total untuk 
       masing-masing tahun 
    2. Membuat tabel yang berisi informasi jumlah cancel order total untuk masing-masing 
       tahun 
    3. Membuat tabel yang berisi nama kategori produk yang memberikan pendapatan total 
       tertinggi untuk masing-masing tahun 
    4. Membuat tabel yang berisi nama kategori produk yang memiliki jumlah cancel order 
       terbanyak untuk masing-masing tahun 
    5. Menggabungkan informasi-informasi yang telah didapatkan ke dalam satu tampilan tabel 
*/

select 
    distinct order_status
from orders;

select *
from order_item
limit 5;

-- No.1
/*
    "shipped"
    "unavailable"
    "invoiced"
    "created"
    "approved"
    "processing"
    "delivered"
    "canceled"
*/
create table revenue_per_year as
    select 
        date_part('year', o.order_purchase_timestamp) as year,
        sum(revenue) revenue
    from    
        (
            select
                order_id,
                sum(price + freight_value) revenue
            from 
                order_item
            group by 1
        ) r
    join 
        orders o
    on r.order_id = o.order_id
    where o.order_status = 'delivered'
    group by 1;

--

-- No.2

create table total_cancel_per_year as
    select
       date_part('year', order_purchase_timestamp) as year,
       count(order_status) total_canceled
    from
        orders
    where 
        order_status = 'canceled'
    group by 1;
    
--

-- No.3

create table top_category_product_per_year as
    select
        year,
        product_category_name,
        revenue
    from
        (select
            date_part('year', o.order_purchase_timestamp) as year,
            p.product_category_name,
            sum(oi.price + oi.freight_value) revenue,
            rank() over(
                            partition by
                                date_part('year', o.order_purchase_timestamp)
                            order by 
                                sum(oi.price + oi.freight_value) desc
                        ) as rank
        from 
            order_item oi
        join 
            orders o
        on
            oi.order_id = o.order_id
        join
            products p
        on
            oi.product_id = p.product_id
        where o.order_status = 'delivered'
        group by 1,2) subq
    where rank = 1;
    
--

-- No.4
create table most_category_product_canceled_per_year as
    select
        year,
        product_category_name,
        total_cancel
    from
        (select 
            date_part('year', o.order_purchase_timestamp) as year,
            p.product_category_name,
            count(p.product_category_name) total_cancel,
            rank() over(
                            partition by
                                date_part('year', o.order_purchase_timestamp)
                            order by
                                count(p.product_category_name) desc
                        ) as rank
        from
            order_item oi
        join
            orders o
        on 
            oi.order_id = o.order_id
        join
            products p
        on
            oi.product_id = p.product_id
        where o.order_status = 'canceled'
        group by 1,2) c 
    where rank = 1;
    
--

-- No.5
select
    r.year,
    r.revenue revenue_per_year,
    total_cancel.total_canceled total_canceled_per_year,
    top.product_category_name top_revenue_by_category_product_name,
    top.revenue top_revenue_by_category_product_name,
    cancel.product_category_name most_canceled_category_product_name,
    cancel.total_cancel number_category_product_name_canceled
from 
    revenue_per_year r
join
    total_cancel_per_year total_cancel
on 
    r.year = total_cancel.year
join
    top_category_product_per_year top
on 
    total_cancel.year = top.year
join 
    most_category_product_canceled_per_year cancel
on
    top.year = cancel.year;
