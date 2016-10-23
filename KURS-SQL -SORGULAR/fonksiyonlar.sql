--FUNCT�ONS 
--amac� itibariyle spler ile ayn� g�revi g�r�r 
--sp ve fonksiyon aras�ndaki fark bir spden bir fonksyionu �a��rabiliriz 
--ancak bir fonksyiondan bir spyi �a��ramay�z
--fonksiyon ba��ms�z �al���r
--fonksiyonlar�n her zaman bir d�n�� tipi olmas� gerekir
--2 tip fonksiyon mevcut
--1)Scalar value functions
--2)table value functions 

--1)scalar value function

create function ToplamaIslemi(@sayi1 int,@sayi2 int)
returns int 
as
begin
	return @sayi1+@sayi2
end 

select [dbo].[ToplamaIslemi] (3,5)


-------------

create function MailOlusturucu(@Ad nvarchar(25),@Soyad nvarchar(50))
returns varchar(25)
as
begin
	declare @DonecekDeger nvarchar(100) --de�i�keni tan�mlad�k.
	set @DonecekDeger=@Ad+'.'+@Soyad+'@bilisimegitim.com'--de�er atad�k
	return lower(@DonecekDeger)
end

select FirstName,LastName,dbo.MailOlusturucu(Firstname,LastName)[Email] from Employees


-------table valued function
create function CalisanaGoreSiparis(@Ad nvarchar(50))
returns table  --geriye tablo d�nd�rd�k
as 
   return	
   select o.OrderID,o.OrderDate from Orders o
   inner join Employees E on o.EmployeeID=E.EmployeeID
   and E.FirstName=@Ad



select *from CalisanaGoreSiparis('Nancy')


