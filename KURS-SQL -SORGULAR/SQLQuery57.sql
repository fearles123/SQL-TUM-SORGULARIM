--DML(DATA MANIPULATION LANGUAGE)
--CRUD (CREATE ,READ,UPDATE,DELETE)

--SELECT (vER� OKUMA)

SELECT * FROM Employees  --Employees tablosundan t�m verileri getir.

select *from customers 

select *from Products

--Kolonlara g�re veri �ekme
select CustomerID,CompanyName,ContactName,Phone from Customers

select FirstName,LastName,City,Country From Employees

--Alias(Tablo takma Adlar�/k�saltmalar�)

select P.ProductName,P.UnitPrice from products P

--kolon isimlendirmeleri

select P.ProductName AS [�r�n Ad�],P.UnitPrice AS [Birim Fiyat] from products P

--string birle�trime (string concatenation)

select E.TitleOfCourtesy+' '+E.FirstName+''+E.LastName As [Ad Soyad] from Employees E

--Genel Sorgular
select 'Ramazan Aras' AS [�smim]
select GETDATE() AS [BUG�N]

--COUNT
select count(*) AS [�r�n Adedi] from Products

--MAX
SELECT MAX(P.UnitPrice) AS [EN PAHALI �R�N] FROM Products P 

--M�N
SELECT MIN(P.UnitPrice) AS [EN D���K �R�N] FROM Products P

--4 ��LEM 


SELECT 4*5 AS [Toplam],8-4 AS [Fark],8*4 AS [�ARPIM]
SELECT 4+5 


--GENEL TOPLAM 
SELECT SUM(P.UnitsInStock) FROM Products P

--Stoklar�mda toplam ne kadar tutarda �r�n var?
select SUM(P.UnitsInStock*P.UnitPrice) AS [�R�NLER TOPLAMI] FROM Products P

--TOP
SELECT TOP 10 *FROM Products P

--ORDER BY
SELECT P.ProductName FROM Products P ORDER BY P.UnitPrice DESC

--en pahal� �r�n
select top 1 *from Products P order by P.UnitPrice desc

--ko�ullar(filtreleme)
select*from Employees E where E.Country='USA'

select P.ProductName,P.UnitPrice from Products P where P.CategoryID=8 order by P.UnitsInStock desc 


--ko�ullar(filtreleme)-�oklu ko�ul
select P.ProductName,P.UnitPrice from Products P where P.CategoryID=8 AND P.UnitsInStock > 0  AND P.UnitsInStock > 10  order by P.UnitsInStock desc 


select P.ProductName,P.UnitPrice from Products P where P.CategoryID=4 OR P.CategoryID=5    order by P.UnitsInStock desc 

--KO�ULLAR e�itsizlik
select P.ProductName,P.UnitPrice from Products P where P.CategoryID<>8    order by P.UnitsInStock desc 

--metinsel i�lemler
select UPPER('ahmet a��kg�z')
select LOWER('AHMET A�IKG�Z')

select REVERSE('istanbul')

select LEFT('istanbul',4)
select RIGHT('istanbul',4)

select SUBSTRING('istanbul',2,3)

--tarih fonksiyonlar�

select GETDATE()

select DAY('2012/10/11')
select DAY(GETDATE())--g�n� d�nd�r�r
select MONTH(getdate())--ay� d�nd�r�r
select YEAR(GETDATE())--y�l� d�nd�r�r

--VAROLAN bir tarihe belirli bir zaman eklemek
select DATEADD(Day,45,GETDATE())
select DATEADD(month,48,'1900/06/11')
select DATEDIFF(day,'1938/07/13',GETDATE())

select datename(WEEKDAY,'1983/07/13')

select datename(dayofyear,GETDATE())

select e.FirstName,e.LastName, DATEDIFF(YEAR,Birthdate,GETDATE()) as Ya� from Employees e

select e.FirstName+' '+e.LastName as [�Al��an ad soyad],YEAR(Hiredate) from Employees e where YEAR(Hiredate)>1993

select OrderID from Orders where MONTH(OrderDate)=9--eyl�l ay� 

select O.OrderID,O.CustomerID from Orders O where O.Freight>=25 and O.Freight<=100--freight:kargo �creti.

select O.OrderID,O.CustomerID from Orders O where O.Freight  between  25 and 100

--ya�� 50den b�y�k ve ingilterede oturmaya �al��anlar� adlar�n�n ilk �� harfi

select SUBSTRING(FirstName,2,3) as Ad,Country from Employees where Country!='UK' and DATEDIFF(YEAR,Birthdate,GETDATE())>50

--1997 dahil y�l�ndan sonra al�nm��,kargo �creti 20den b�y�k ve fransaya g�nderilmemi� sipari�lerin Idleri,kargo �cretleri,sipari� tarih,�lke bilgileri gelsin

select OrderID,OrderDate,ShipCountry from Orders where YEAR(OrderDate)>=1997 and Freight>20 and ShipCountry!='France'

--nul ifade kontrol�

select *from Customers where Region is null

select *from Customers where Region is not null

--kimseye rapor vermeyen �al��anlar
select * from Employees where ReportsTo is null

--category idsi 5 olan �r�n fiyat� 20 den b�y�k ve 300den k���k olan ve stok durumu null olmayan �r�nlerin bilgileri gelsin

select * from Products where CategoryID=5 and UnitPrice>20 and UnitPrice<300 and UnitsInStock is not null

--alfk� ve dumon idli m��terilerimin sat�n ald��� 1 nolu personelin onaylad��� 3 nolu kargo ifrmas�yla ta��nm�� ve shipregion kolonu null olan sipari�leri listeleyin

select *from Orders where (CustomerID='ALFKI' or CustomerID='DUMON') and EmployeeID=1 and ShipVia=3 and ShipRegion is null

select *from Orders where CustomerID in('ALFKI','DUMON') and EmployeeID=1 and ShipVia=3 and ShipRegion is null

--�r�nlerden stok miktar� 50den b�y�k olanlar�n �r�n adlar�n� ,birim fiyatlar�n� ve stok miktarlar�n� �r�n fiyat�na g�re azalan �ekilde listeleyin.

select ProductName,UnitPrice,UnitsInStock from Products where UnitsInStock>50 order by UnitPrice desc

--belirli kay�tlar� alma
--en ucuz 9 �r�n
select top 9 productName ,UnitPrice from Products order by UnitPrice

--with ties
select top 9 with ties productName ,UnitPrice from Products order by UnitPrice
 
 --en son teslim edilecek olan 5 sipari�i g�sterin
 select  top 5 with ties OrderID,RequiredDate from Orders order by RequiredDate desc

 --en falza kargo bedeli �denen sipari�in idsi ve kargo bedeli gelsin
 select top 1 OrderID,Freight from Orders order by Freight desc

 --ba� harfi C olan ,stokta bulunan 10-250 dolar �creti olan �r�nleri fiyatlar�na g�re artan s�ralay�n�z

 select *from Products P where SUBSTRING(P.ProductName,1,1)='C' and  P.UnitsInStock is not null and P.UnitPrice between 10 and 250 order by P.UnitPrice asc

 --�ar�amba g�n� al�anan kargo �creti 20-75 aras� olan shippeddate'i null olmayan sipari�lein bilgilerini raporlay�n�z ve order�dye g�re b�y�kten k���kten do�ru s�ralay�n

 select *from Orders O where datename(weekday,O.OrderDate)='Wednesday' and Freight between 20 and 75 and o.ShippedDate is not null order by o.OrderID desc 

 --arama i�lemleri 
 --company nameleri A ile ba�layan m��teriler gelsin 
 --a ile ba�layan
 select CompanyName from Customers where CompanyName like 'A%'--a ile ba�layan

 select CompanyName from Customers where CompanyName like '%A'--a ile biten

  select CompanyName from Customers where CompanyName like '%AB%'--i�inde ab ge�en

  --mon ile biten
  select CustomerID from Customers where CustomerID like '__MON'

  --customer idlerden ilk harfi A yada S olan 
  select CustomerID from Customers where CustomerID like '[AS]%'

  --�LK HARF� A ile k aras�nda olan		
    select CustomerID from Customers where CustomerID like '[A-K]%'

	  select CustomerID from Customers where CustomerID like '[A-K]%' AND CustomerID like '[^A]%' and CustomerID like '[^K]%'-- ^ ile ba�lamayan

select CustomerID from Customers where CustomerID like 'A_[^N]U%'--a ile ba�layan i�inde n olmayacak ama u olacak 



--aggregate functions

select count(*) from [Order Details]

select count(ProductID) from Products where UnitsInStock>30

--1996 y�l�ndan sonra al�nm�� toplam ka� adet sipari�im var
select count(O.OrderID) from Orders O where YEAR(O.OrderDate)>1996

--farkl� kay�tlar� getir.
select distinct Country from Customers

---Ka� farkl� �lkeden m��terim var
select count (distinct Country) from Customers

--sum(toplam alma)
--her bir �r�nden 1 adet alsam ne kadar �derim
select sum(UnitPrice) as [Toplam  tutar] from Products

--depoda toplam ka� liral�k �r�n var
select sum(unitprice*UnitsInStock) from Products

--1997 siprai�leri toplam ka� lira kargo bedeline sahip?
select sum(o.Freight) from Orders O where YEAR(o.OrderDate)=1997

--ortalama kargo bedeli
select sum(o.Freight)/count(Freight) from Orders O

--avg
select avg(freight) from orders

--�lke ba��na ortalama ka� dolar kargo �creti odedim?
select sum(o.Freight) /count(distinct ShipCountry) from orders o 

--CACTU ,dumon yada peric CustomerIDlerine sahip m��terilerden al�nm�� 2 nolu kargo firmas�yla ta��nmam�� �creti 20-200 dolar aras� olan sipari�lere toplam ne kadar kargo �creti �denmi�tir?
--shipvia:kargo �irketi
--freight:kargo �creti
select sum(o.Freight) from ORDERS o where o.CustomerID in('CACTU','DUMON','PERIC') and o.ShipVia!=2  and o.Freight between 20 and 200 


--case when yap�s�
select FirstName +' '+LastName as [Ad Soyad],Ulke=
case Country 
when 'USA' then 'Amerika'
when 'UK' then '�ngiltere'
when 'TR' then 'T�rkiye'
else 'Bilgi Yok'
end
from Employees

--�r�nler tablosunda stokadedi 50den az  olanlar i�in kritik stok adedi,50 ve 100 aras� olanlar i�in normal stok adedi,100den fazla olanlar ii�in stok fazlas� ibaresini yazd�r�n

select ProductName,UnitPrice,UnitsInStock,[Stok Durumu]=
case 
when UnitsInStock<50 then 'Kritik Durum'
when UnitsInStock between 50 and 100 then 'Normal Durum'
when UnitsInStock>100 then 'Stok fazlas�'
end
from Products
  
--group by 
--gropydan sonra gelen �ey select i�inede yaz�l�r
--�lkelere g�re personel say�s�
select country,count(country) as [Personel Say�s�]
 from Employees
 group by 
 Country

 --�r�nler tablosunda kategoriye g�re �r�n adedini getirin
 select CategoryID,count(ProductID) as [�r�n adedi] from Products 
 group by CategoryID 

 --her kategoride toplam ne kadarl�k �r�n var
 select p.CategoryID,sum(p.UnitPrice*UnitsInStock) as [toplam �r�n fiyat�] from Products p
 group by p.CategoryID 

 --�lkelere g�re en �ok sipari� veren ilk 3 �lkeyi sipari� say�lar� ile beraber raporlay�n
 select top 3 o.ShipCountry,count(o.OrderID) as [Toplam sipari�] from
orders o 
 group by o.ShipCountry order by [Toplam sipari�] desc


 --order details de hangi �r�ne toplam ka� adetlik sipari� verilmi�

 select o.ProductID,sum(o.Quantity) as [Toplam sipari� adeti] from  [Order Details] O group by o.ProductID order by o.ProductID

 --inner join
 select C.CategoryName ,p.ProductName,s.CompanyName from Products P
 inner join Categories C on C.CategoryID=p.CategoryID
 inner join Suppliers s on s.SupplierID=p.SupplierID
 order by 
 c.CategoryName

 --beverages kategosine ait �r�nleri listeleyin
 select c.CategoryName,p.ProductName from  Products p 
 inner join Categories c on c.CategoryID=p.CategoryID
 where c.CategoryName='Beverages'

 --federal shipping ile ta��nm�� nancynin alm�� oldu�u sipari�leri listelyein

 select o.OrderID,s.CompanyName,e.FirstName from Orders o 
 inner join Shippers s on s.ShipperID=o.ShipVia
 inner join Employees e on e.EmployeeID=o.EmployeeID
 where e.FirstName='Nancy' and s.CompanyName='Federal Shipping'

 --m��teri hangi �r�nden toplam ne kadar tutar�nda sipari� vermi�

 select c.CompanyName,p.ProductName,sum(o.UnitPrice*o.Quantity) as [toplam sipari� tutar�] from [Order Details] O
 inner join Products p on p.ProductID=o.ProductID
 inner join Orders ord on ord.OrderID=o.OrderID
 inner join Customers c on c.CustomerID=ord.CustomerID
 group by c.CompanyName,p.ProductName
 order by c.CompanyName 


 --companynameleri aras�nda a ge�en m��terilerin nancy,andrew yada janet taraf�nda al�nm�� speedy express ile ta��nmam�� sipari�lere toplam ne kadar kargo �creti �dedim

 select sum(o.Freight) as [�denen Toplam kargo �creti] from Orders O
 inner join Shippers s on s.ShipperID=o.ShipVia
 inner join Employees e on e.EmployeeID=o.EmployeeID
 inner join Customers c on c.CustomerID=o.CustomerID
 where c.CompanyName like '%a%' 
 and e.FirstName in ('Nancy','Andrew','Janet')
 and s.CompanyName!='Speedy express'

 --hangi �al��an�m kime rapor veriyor.
 select a.FirstName+' '+a.LastName [Personel],b.FirstName+' '+b.LastName[Sorumlu] from  Employees a
 inner join Employees b on b.EmployeeID=a.ReportsTo

 --�al��anlar ne kadarl�k sat�� yapt�lar
 select e.LastName,sum(OD.UnitPrice*OD.Quantity) as [toplam sat��i] from Employees e
 inner join Orders o on o.EmployeeID=e.EmployeeID
 inner join [Order Details] OD on OD.OrderID=o.OrderID
 group by e.LastName

 --kategorilere g�re sat�� toplamlar�
 select c.CategoryName,sum(o.UnitPrice*o.Quantity) as [sat�� toplamlar�] from [Order Details] o
 inner join Products p on o.ProductID=p.ProductID
 inner join Categories c on c.CategoryID=p.CategoryID
 group by c.CategoryName
 order by [sat�� toplamlar�]

 --hangi kargo �irketine ne kadarl�k toplam �deme yap�ld�
 select s.CompanyName,sum(Freight) as [Toplam �deme] from Shippers s 
 inner join Orders o on o.ShipVia=s.ShipperID
 group by s.CompanyName
 order by s.CompanyName

 --tedarik�ilerden ald���m �r�nlerin sat�� adedi ve sat�� toplam�
 select s.CompanyName,p.ProductName,sum(ord.Quantity) as [adet],sum(ord.Quantity*ord.UnitPrice) as [sat�� toplam�] from Suppliers s 
 inner join Products p on s.SupplierID=p.SupplierID
 inner join [Order Details] ord on ord.ProductID=p.ProductID
 group by s.CompanyName,p.ProductName



 --toplam sat�� tutar� 50000'in �zerinde olan kategoriler ve sat�� tutarlar�n� raporlay�n


  select c.CategoryName,p.productname,sum(od.UnitPrice*od.Quantity) as [sat�� miktar�] from Products p
 inner join Categories c on c.CategoryID=p.CategoryID
 inner join [Order Details] od on  od.ProductID=p.ProductID
 group by c.CategoryName,p.ProductName
 having sum(od.UnitPrice*od.Quantity)>50000
 order by [sat�� miktar�]

 --toplam sipari� miktar� 1200'�n �zerinde olan �r�nlerin adlar�n� ve sipari� miktarlar�n� g�sterin
 select p.ProductName,sum(ord.Quantity) as adet from Products P
 inner join [Order Details] ord on ord.ProductID=p.ProductID
group by p.ProductName
having sum(ord.Quantity)>1200 

--ta�INAN KARGO adeti 250in �zerinde olan kargo firmalar� ve kargo �cretleri
select s.CompanyName,COUNT(o.OrderID) as [kargo adeti] from Orders o
inner join Shippers s on s.ShipperID=o.ShipVia
group by s.CompanyName
having COUNT(o.OrderID)>250

--ald��� sipari�ler toplam� maliyeti 100000 in �zerinde olan personellerin ad soyad� ve sat�� toplamlar�
select e.FirstName,e.LastName,sum(ord.UnitPrice*ord.Quantity) as [sipari� toplam�] from Employees e 
inner join Orders o on o.EmployeeID=e.EmployeeID
inner join [Order Details] ord on ord.OrderID=o.OrderID
group by e.FirstName,e.LastName
having sum(ord.UnitPrice*ord.Quantity)>100000

--shipcountry si usa ve germany olan �lkelere yap�lan sat�� toplam� 3000 �zeri olan �r�nleri raporlay�n

select p.ProductName ,SUM(ord.UnitPrice*ord.Quantity) from Products p
inner join [Order Details] ord on 
ord.ProductID=p.ProductID 
inner join Orders o on o.OrderID=ord.OrderID
where o.ShipCountry='USA' or o.ShipCountry='Germany'
group by p.ProductName 
having SUM(ord.UnitPrice*ord.Quantity)>30000

--subquery 
--employee leri nancy olan sipari�leri getir.
select o.* from Orders o where o.EmployeeID IN(select e.EmployeeID from Employees e where e.FirstName='Nancy')

--ortalama �cretin �zerinde olan �r�nleri g�sterin
select ProductName,UnitPrice from Products where UnitPrice>(select AVG(UnitPrice) from Products)

--nancy,andrew yada janet�n alm�� oldu�u ve speedy express ile ta��nmam�� order �d 
select * from Orders o where o.EmployeeID in(select e.EmployeeID from Employees e where e.FirstName  in('Nancy', 'Andrew','Janet')) and o.ShipVia in (select s.ShipperID from Shippers s where s.CompanyName not like '%Speedy%')

--beverages kategorisine ait �r�nleri listeleyin
select *from Products p where p.CategoryID=(select c.CategoryID from Categories c where c.CategoryName='Beverages')

--company nameleri aras�nda a ge�en m��terilerin nancy,andrew yada janet taraf�ndan al�nm�� sppedy express ile ta��nmam�� sipari�lere toplam ne kadar kargo �creti �dedim
select sum(o.Freight) from Orders o 
where o.CustomerID in(select   c.CustomerID from Customers c where c.CompanyName like '%a%') 
and o.EmployeeID in(select e.EmployeeID  from  Employees e where e.FirstName in('Nancy','Andrew','Janet')) 
 and o.ShipVia in (select s.ShipperID from Shippers s where s.CompanyName not like '%Speedy%')


 --federal shipping ile ta��nm�� ve nancynin alm�� oldu�u sipari�leri listeleyin
 select *from Orders o where o.ShipVia in (select s.ShipperID from Shippers s where s.CompanyName='Federal Shipping') and o.EmployeeID in(select e.EmployeeID from Employees e where e.FirstName='Nancy')

 --m��teri hangi �r�nden toplam ne kadar tutar�nda sipari� vermi�
 select c.CompanyName,p.ProductName,SUM(od.Quantity*od.UnitPrice) from 
 Customers c,
 Products p,
 Orders o,
 [Order Details] od
 where 
 o.OrderID=od.OrderID 
 and o.CustomerID=c.CustomerID
 and p.ProductID=od.ProductID
 group by 
 c.CompanyName,
 p.ProductName
 order by c.CompanyName,p.ProductName


 --hangi �al��an�m kime rapor veriyor
 select b.FirstName,a.FirstName from  Employees a,Employees b 
  where
   a.EmployeeID=b.ReportsTo 


--�al��anlar ne kadarl�k sat�� yapt�lar
select e.LastName,sum(OD.UnitPrice*OD.Quantity) as [toplam sat��i] from 
Employees e,
Orders o,
[Order Details] OD
where
o.EmployeeID=e.EmployeeID and
OD.OrderID=o.OrderID
group by e.LastName

--kategorilere g�re sat�� toplamlar�
select c.CategoryName,sum(o.UnitPrice*o.Quantity) as [sat�� toplamlar�] from 
[Order Details] o,
Products p,
Categories c
where 
o.ProductID=p.ProductID and 
c.CategoryID=p.CategoryID
group by c.CategoryName
order by [sat�� toplamlar�]



--hangi kargo �irketine ne kadarl�k toplam �deme yap�ld�
select s.CompanyName,sum(Freight) as [Toplam �deme] from 
Shippers s,
Orders o
where 
o.ShipVia=s.ShipperID
group by s.CompanyName
order by s.CompanyName

--tedarik�ilerden ald���m �r�nlerin sat�� adedi ve sat�� toplam�
select s.CompanyName,p.ProductName,sum(ord.Quantity) as [adet],sum(ord.Quantity*ord.UnitPrice) as [sat�� toplam�] from
Suppliers s ,
Products p,
[Order Details] ord
where
s.SupplierID=p.SupplierID and 
ord.ProductID=p.ProductID
group by s.CompanyName,p.ProductName
 

 --union(birden fazla result seti birle�tirir..Sorgu sonucuna ayn� sat�r verileri uniq olarak ekler.union union all'a g�re daha yava� sonu� verir.)

 select o.OrderDate,o.Freight,o.ShipCountry from Orders o
 where YEAR(o.OrderDate)=1996

 union 

  select o.OrderDate,o.Freight,o.ShipCountry from Orders o
 where YEAR(o.OrderDate)=1997

 union 

   select o.OrderDate,o.Freight,o.ShipCountry from Orders o
 where YEAR(o.OrderDate)=1998

 --union all(birden fazla result seti birle�tirir)
  select o.OrderDate,o.Freight,o.ShipCountry from Orders o
 where YEAR(o.OrderDate)=1996

 union all

  select o.OrderDate,o.Freight,o.ShipCountry from Orders o
 where YEAR(o.OrderDate)=1997

 union all

   select o.OrderDate,o.Freight,o.ShipCountry from Orders o
 where YEAR(o.OrderDate)=1998


 --intersect(kesi�im k�mesini verir)

 select p.ProductName from [Order Details] od 
 inner join Products p on p.ProductID=od.ProductID
 where od.Quantity=10

 intersect

 select p.ProductName from [Order Details] od 
  inner join Products p on p.ProductID=od.ProductID
 where od.Quantity=12

 --
 select o.EmployeeID from Orders o 
 where o.ShipCountry='USA'

 intersect

  select o.EmployeeID  from Orders o 
 where o.ShipCountry='Germany'

  intersect

  select o.EmployeeID  from Orders o 
 where o.ShipCountry='France'


 --
  select o.EmployeeID from Orders o 
 where o.Freight=50

 intersect

  select o.EmployeeID  from Orders o 
 where o.Freight=100

  intersect

  select o.EmployeeID  from Orders o 
 where o.Freight=150


 -----EXCEPT(bir setin di�erinden fark�)
 select*from Orders o 

 except 

 select *from Orders o where o.EmployeeID in(1,2,3)   --1,2,3 olanlar� ��kar

  except 

 select *from Orders o where o.EmployeeID in(4,5) --4 ve 5ide ��kar
 ----------------------------------------------------

 --INSERT
 INSERT INTO Categories(CategoryName, Description, Picture)
 output inserted.* -- veriyi ekledikten sonra kay�t edilen veriyi g�sterir,(en son silinen kayd� tutar.)
 VALUES('Unlu Mam�ller','Pasta,b�rek,��rek vs...',null)

 select*from Categories

--UPDATE
--(update i�lemi �nce kayd� siler sonra insert eder.)
UPDATE Categories SET [Description]='Pasta,b�rek,��rek,po�a�a vs...' where CategoryID=10


--DELETE
DELETE FROM Categories WHERE CategoryID=9

-----------------

--hangi �r�nler hangi kategoriye ait
select c.CategoryName,p.ProductName from Products p 
inner join Categories c on c.CategoryID=p.CategoryID

--toplu insert tabloya veri aktard�k
INSERT INTO ProductCategories
select c.CategoryName,p.ProductName from Products p 
inner join Categories c on c.CategoryID=p.CategoryID

