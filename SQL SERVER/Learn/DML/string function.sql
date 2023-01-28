--STRING FUNCTION

--LEFT
select [Jenis Kelamin] = LEFT(staffGender, 1)
from Staff

--RIGHT
SELECT [Test Right] = RIGHT(staffName,3)
FROM Staff

--REVERSE
SELECT [Balik Nama] = REVERSE(staffName)
FROM Staff

--CHARINDEX
SELECT [Index huruf s] = CHARINDEX('s', staffName)
FROM Staff
WHERE staffPhone = '080152852175' 

--SUBSTRING, mengambil nama pertama
SELECT [Nama Pertama] = SUBSTRING(staffName, 1, CHARINDEX(' ', staffName)-1)
FROM Staff

--gabungan string function
SELECT 
	[Nama Pertama] = SUBSTRING(staffName, 1, CHARINDEX(' ', staffName)-1),
	[Nama Terakhir] = SUBSTRING(staffName, CHARINDEX(' ', staffName)+1, CHARINDEX(RIGHT(staffName, 1), staffName)),
	[Nama Lengkap] = staffName
FROM Staff