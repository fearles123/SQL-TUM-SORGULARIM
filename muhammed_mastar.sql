--select --> se�me sorgusu
--veri sorgulamak ve g�r�nt�lemek i�in kullan�l�r

select 5 as sayi

select 'Muhammed' as isim

select 12+24 as toplam

select 'Sql'+'Dersleri' as [G�rsel Dersler]

select 'Fatih' as Ad,'Terim' as Soyad,45 as Ya�

--selectin tablo sorgulama form�l�

--select [kolon adlar�] from [tablo ad�] 

/*
Employees:�al��anlar
Products:�r�nler
Customers:m��teriler
Orders:sipari�ler
suppliers:tedarik�i,firma,sat�c�
unitprice:birim fiyat
region:b�lge
shipvia:kargo
shipper:nakliyat��
freight:y�k ta��ma �creti
UnitsInStock:stok
ReportsTo:�al��an kime rapor veriyor 
ship:g�ndermek
ShipVia:kargo firmas�

*/
-- * girdi�imiz tablodaki t�m bilgileri g�sterir

--where yap�s�

--2 nolu �al��an� getir
select * from Employees where EmployeeID=2 

--2 nolu �al��an�n alm�� oldu�u sipari�leri getir
select *from Orders where EmployeeID=2

--birim fiyat� 50 dolardan az olan �r�nlerin fiyat�n� g�r�nt�le
select *from Products where UnitPrice<50

--ALFKI m��teri idli m��terinin sipari�lerini g�sterin
select*from Orders where CustomerID='ALFKI'

--stokta 10 taneden az olan �r�nleri g�steriniz
select*from Products where UnitsInStock<10

--Kategori idsi 2 olan ve 3 nolu tedarik�iden gelen �r�nlerin ad�n� g�steriniz
select*from Products where CategoryID=2 and SupplierID=3

--Londonda ya��yan �al��anlar(5 numaraya rapor veren)
select*from Employees where City='London' and ReportsTo=5

--1997 y�l�n�n sipari�lerini g�steriniz
select*from Orders where YEAR(OrderDate)=1997

--Nancy isimli �al��an�n adresi nedir
select Address from Employees where FirstName='Nancy'

--null i�in is null ,null olmayan i�in is not null
select*from Customers where Region is null
select *from Customers where Fax is not null

--g�nderilmemi� sipari�lerin listesi
select*from Orders where ShippedDate is null

--aras�nda ifadesi nedir?
--stokta 10 ile 30 aras�nda bulunan �r�nlerin listesi
select*from Products where UnitsInStock between 10 and 30 

--m��teri ismi k ile o aras�ndakileri listeleyin
select*from Customers where CompanyName between 'k' and 'o'

--veya ifadesi

--kategori idsi 3,5,8 olan �r�nleri g�sterin
select*from Products where  CategoryID=3 or CategoryID=5 or CategoryID=8   
--in kullanarak k�saltabiliriz
select*from Products where  CategoryID in(3,5,8)

--2,3,4 nolu �al��anlar�n 1997 y�l�nda alm�� olduklar� sipari�ler
select*from Orders where EmployeeID in(2,3,4) and Year(OrderDate)=1997

--like :belirli bir �ablona g�re verilerin filtrelenmesi i�in kullan�l�r
--like '�n �zel karakteri % karakteridir
--like where kriter yap�s� ile beraber kullan�l�r
--like her zaman where in sa��nda olur
select*from Customers


--sadece ismi k harfi ile ba�layanlar� g�ster
select*from Customers where CompanyName  like 'k%'
--%, sonras� beni ba�lamaz

--ismi k harfi ile bitenler
select*from Customers where CompanyName like '%k'

--isminde k harfi olanlar� g�ster
select*from Customers where CompanyName like '%k%'

--belirsiz demek alt tire demektir _
--ilk harfi belirsiz ikinci harfi e olanlar� g�ster
select*from Customers where CompanyName like '_e%'

--ilk harfi belirsiz olan,ikinci harfi e olan,son harfi s olan 
select*from Customers where CompanyName like '_e%s'

--[^s] s olmayan
--ilk harfi belirsiz ikinci harfi e olan son harfide s olmayan
select*from Customers where CompanyName like '_e%[^s]'

--ilk harfi l ve r olan �irketleri g�ster
select*from Customers where CompanyName like '[lr]%'

--ilk harfi l ve r aras�nda olanlar� g�ster
select*from Customers where CompanyName like '[l-r]%'



--AGGREGATE  fonksiyonlar

--Sorgu sonucuna bakarak i�lem yapabilen fonksiyonlard�r
--select ten hemen sonra yaz�l�rlar

-- => Count-sum-avg -min-max

--count :sat�rlar� sayar
--e�er s�tun ismi verirsek null de�er olanlar� saymaz

--ka� �e�it �r�n�m vard�r
select count(*) from Products

--ka� tane sipari� alm���m 
select count(*) from Orders   --e�er select count(OrderID) from Orders  dersek null olanlar� saymaz

select count(ShippedDate)  from Orders --sipari� gidenler

--ka� sipari� gitmemi�
select count(*)-count(ShippedDate) from Orders  --21 tane sipari� gitmemi�(null olanlar)


--SUM :TOPLAMI g�sterir
select * from Products  
--stoktaki �r�nlerin toplam� ka�t�r
select sum(UnitsInStock) from Products  

--�r�nlerin birim fiyat� toplam�
select sum(UnitPrice) from Products

--avg:ortalama al�r

--�r�nlerimizin fiyatlar�n�n ortalamas�
select avg(UnitPrice) from Products

--max ve min

--en pahal� �r�n
select max(UnitPrice) from Products

--category idsi 3 olan ka� �e�it �r�n�m�z vard�r
select count(*) from Products where CategoryID=3

--2 nolu �al��an�m�n alm�� oldu�u sipari� say�s� nedir?
select count(*) from Orders where EmployeeID=2

select*from Orders

--CASE VE ORDER BY 
--case :okunan kolondaki bilgiye g�re farkl� de�erler ��karmay� sa�layan yap�d�r

select*from Employees

--ekranda  �nvanlar� t�rk�e olarak de�i�ssin
select TitleOfCourtesy,Unvan=case TitleOfCourtesy
when 'Ms.' then 'Bay'
when 'Dr.' then 'Doktor'
when 'Mr.' then 'Bayan'
else 'Say�n'
end
 from Employees 


 --Order by => S�ralamak 
 --k���kten b�y��e s�ralamak i�in asc
 --b�y�kten k����e s�ralamak i�in desc

 --�r�n fiyatlar�n� s�rala 
 select*from Products order by UnitPrice     --order by dan sonra bir�ey yazmazsak default asc dir. 



 --Group by :sorgular�m�z� gruplamaya yard�mc� olur
 --group by,where den sonra yaz�l�r.

 --1 nolu �al��an�n alm�� oldu�u sipari� say�s�?
 select count(*) from Orders where EmployeeID=1

 select*from Orders

 --her �al��an�n toplamda alm�� oldu�u sipari� say�lar� ka�t�r
 select EmployeeID,count(*) as [Sipari� Say�s�]from Orders group by EmployeeID 


 --kargo firmalar� ka� tane sipari� alm��t�r
 select ShipVia,count(*) from Orders group by ShipVia

 select*from Products

 --hangi kategoride ka� �r�n oldu�unu g�steriniz.
 select CategoryID,count(*) as [�r�n adedi] from Products group by CategoryID

  select*from Orders

 --hangi �lkeye ka�  sat��(sipari�) yap�lm��
 select ShipCountry,count(*) from Orders group by ShipCountry 

 --nakliye �irketlerine(shipvia) toplam ne kadar �denmi� ( freight:ta��ma �ceti)
 select ShipVia,sum(Freight) from Orders group by ShipVia order by sum(Freight) desc

 --m��terilere 1997 y�l�nda ka� sipari� verilmi�tir 
 select CustomerID,count(*) from Orders where Year(OrderDate)=1997 group by CustomerID

  select*from Products

 --kategorilerdeki stok miktarlar� 
 select CategoryID,sum(UnitsInStock)from Products group by CategoryID

  select *from [Order Details]

 --sipari�lerden ne kadar kazan�lm��t�r
 select OrderID,sum(UnitPrice*Quantity) as [toplam kaza�] from [Order Details] group by OrderID order by [toplam kaza�] desc

 select*from Employees

 --�al��anlar�n ka�� bay ka�� bayan ka�� doktor
 select TitleOfCourtesy,count(*) as say�s� from Employees group by TitleOfCourtesy


 -----------JOINLER
--bazen iki  yada daha fazla tablodan veri �ekmemiz gerekebilir.
--yani joinler tablolar� birle�tirmeye yar�yor

select *from Orders
select * from [Order Details]

--sipari�ler ve sipari� detaylar�n� birle�tir
select *from Orders inner join [Order Details] on Orders.OrderID=[Order Details].OrderID

--�r�nler ile kategorileri birle�tir
select*from Categories inner join Products on Categories.CategoryID=Products.CategoryID

--kategorilerdeki �r�nlerin say�s�n� g�sterin
select * from Categories inner join Products on Categories.CategoryID=Products.CategoryID --birle�tirdik ve a�a��dada isteneni yapt�k.

select CategoryName,count(*) as [�r�n say�s�] from Categories inner join Products on Categories.CategoryID=Products.CategoryID group by CategoryName

--�al��anlar�n ald��� sipari�lerin say�s�n� g�sterin
select*from Employees inner join Orders on Employees.EmployeeID=Orders.EmployeeID

select Employees.FirstName,count(*) from Employees inner join Orders on Employees.EmployeeID=Orders.EmployeeID group by Employees.FirstName

--nakliye �irketlerine ne kadar �denece�ini listeleyiniz
select * from Shippers inner join Orders on Orders.ShipVia=ShipperID --birle�tirdik.

select Shippers.CompanyName,sum(Freight) from Shippers inner join Orders on Orders.ShipVia=ShipperID group by Shippers.CompanyName


--kategorilerden yap�lan sat��(sipari�) say�s�n� bulun..(categories->products-->order details--orders yolunu izledik diagramdan da bakabiliriz)
select  * from Categories inner join Products on Categories.CategoryID=Products.ProductID
inner join [Order Details] on Products.ProductID=[Order Details].ProductID inner join Orders on [Order Details].OrderID=Orders.OrderID --birle�tirdik a�a��dada bizden istenileni yapt�k.

select  Categories.CategoryID,count(*) as [sipari� say�s�] from Categories inner join Products on Categories.CategoryID=Products.ProductID
inner join [Order Details] on Products.ProductID=[Order Details].ProductID inner join Orders on [Order Details].OrderID=Orders.OrderID group by Categories.CategoryID


--m��terilerim hangi �r�nleri alm��(customers-->orders-->order details-->products yolunu izledik yine diagramdan bakt�k ve s�rayla birbirini ba�lad�k.)
--distinct benzer komutlar� yok ediyor
select*from Customers inner join Orders on Customers.CustomerID=Orders.CustomerID inner join [Order Details] on 
Orders.OrderID=[Order Details].OrderID inner join Products on [Order Details].ProductID=Products.ProductID--birle�tirdik a�a��dada bizden istenileni yapt�k.

select distinct Customers.CompanyName,Products.ProductName from Customers inner join Orders on Customers.CustomerID=Orders.CustomerID inner join [Order Details] on 
Orders.OrderID=[Order Details].OrderID inner join Products on [Order Details].ProductID=Products.ProductID

--�r�nlerimden ne kadar para kazanm��(her bir �r�n�m�n sat���ndan ne kadar kazan� sa�lam���m)
select * from Products inner join [Order Details] on Products.ProductID=[Order Details].ProductID 

select Products.ProductName,sum([Order Details].UnitPrice*[Order Details].Quantity) as kazan� from Products inner join [Order Details] on Products.ProductID=[Order Details].ProductID group by Products.ProductName order by kazan� desc


--en de�erli 3 m��terime tebrik kart� g�nderelim(bana en �ok para kazand�ran m��teridir)customers-->orders-->order details yolunu izleyece�iz
--top 3 demek en �stteki 3 sat�r� getir.
select * from Customers inner join Orders on Customers.CustomerID=Orders.CustomerID inner join [Order Details] on Orders.OrderID=[Order Details].OrderID

select top 3 Customers.CompanyName,sum([Order Details].UnitPrice*[Order Details].Quantity) as kazan� from Customers inner join Orders on Customers.CustomerID=Orders.CustomerID inner join [Order Details] on Orders.OrderID=[Order Details].OrderID group by Customers.CompanyName order by kazan� desc

--�al��anlar�ma prim �deyece�im.
--prim �demem gereken ilk 5 �al��an (employees-->orders-->order details yolunu izleyece�iz)
select*from Employees inner join Orders on Employees.EmployeeID=Orders.EmployeeID inner join [Order Details] on Orders.OrderID=[Order Details].OrderID --birle�imi yapt�k a�a��dada bizden istenileni yapt�k.

select top 5 Employees.FirstName,sum([Order Details].UnitPrice*[Order Details].Quantity) as kazan� from Employees inner join Orders on Employees.EmployeeID=Orders.EmployeeID inner join [Order Details] on Orders.OrderID=[Order Details].OrderID group by Employees.FirstName order by kazan� desc

--hangi �al��an hangi �al��ana ba�l�d�r
select e.EmployeeID,e.FirstName,em.FirstName from Employees e left join Employees em on e.EmployeeID=em.ReportsTo

--left join birle�menin solundaki null de�eri dikkate alarak i�lem yapar
--right join:sa� 
--full outer join 2 taraftan null u ekler


--m��terilerimin ald��� sipari�lerin say�s�
select*from Customers c inner join Orders o on c.CustomerID=o.CustomerID  

select c.CompanyName,count(o.OrderID) as [sipari� say�s�] from Customers c inner join Orders o on c.CustomerID=o.CustomerID  group by c.CompanyName order by [sipari� say�s�] desc




