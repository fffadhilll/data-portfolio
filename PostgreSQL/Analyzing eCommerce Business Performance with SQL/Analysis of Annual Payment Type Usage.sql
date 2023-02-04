/*
    1. Menampilkan jumlah penggunaan masing-masing tipe pembayaran secara all time diurutkan 
       dari yang terfavorit 
    2. Menampilkan detail informasi jumlah penggunaan masing-masing tipe pembayaran untuk 
       setiap tahun
*/

-- No.1
    
select 
    p.payment_type,
    count(1) as jumlah_pengguna
from 
    orders o
join
    payments p
on
    o.order_id = p.order_id
group by 1
order by 2 desc;
    
--

-- No.2

select
    *,
    case
        when year_2016 = 0 or year_2017 = 0 then NULL
    else
        round( (( year_2018 - year_2017 ) / year_2017), 2 ) 
    end as percent_change_2017_2018
from    
    (select
        payment_type,
        sum(case when year = '2016' then jumlah_pengguna else 0 end) as year_2016,
        sum(case when year = '2017' then jumlah_pengguna else 0 end) as year_2017,
        sum(case when year = '2018' then jumlah_pengguna else 0 end) as year_2018
    from
        (select 
                date_part('year', o.order_purchase_timestamp) as year,
                p.payment_type,
                count(1) as jumlah_pengguna
            from
                orders as o
            join
                payments as p
            on 
                o.order_id = p.order_id
            group by 1,2) subq    
    group by 1) subq2
order by 5 desc;

--
