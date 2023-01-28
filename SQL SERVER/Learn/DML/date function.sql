-- date function

-- datename
select DATENAME(WEEKDAY, transactionDate)
from HeaderSellTransaction

--datediff
select DATEDIFF(year, '1945/08/17', '2023/01/28')

--dateadd
select DATEADD(YEAR, 3, '1945/08/17')

select *
from HeaderSellTransaction