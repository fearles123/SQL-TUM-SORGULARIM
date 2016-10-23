--DDL(Data Definition Language)
--CREATE ,ALTER,DROP,TRUNCATE 

--CREATE
CREATE TABLE YeniTablo 
(
KayitID int not null identity(1,1) primary key,
KayitAdi nvarchar(50) not null,
KayitTarihi datetime null

)

--ALTER(DE���T�RMEK)
ALTER TABLE YeniTablo
ADD �cerik nvarchar(250) not null

--
ALTER TABLE YeniTablo
ALTER COLUMN KayitAdi nvarchar(100)  null

--DROP(tabloyu kald�r�r)
DROP TABLE YeniTablo 


--KayitTarihi kolonunu siler
ALTER TABLE YeniTablo
DROP COLUMN KayitTarihi 


--views
--s�k kullan�lan sorgular� sanal olarak dbde  tutan yap�lard�r.

create VIEW VW_Urunler
as 
select p.ProductName,c.CategoryName,p.UnitPrice from Products p
inner join Categories c on c.CategoryID=p.CategoryID 
-----
select * from VW_Urunler 
select a.ProductName from VW_Urunler a


--�r�n fiyat� ortalaman�n alt�nda olan �r�nleri listele
CREATE VIEW vw_ProductsBelowAveragePrice 
with encryption --bu viewi de�i�ikli�e kapat demek
as
select p.ProductName,p.UnitPrice,p.UnitsInStock from Products p where p.UnitPrice <(select avg(UnitPrice) from Products )

--sadece kategorileri d�nd�ren view
create view vw_Categories 
as 
	select c.CategoryName from Categories c


insert into vw_Categories  values('Sebze-meyve')


------------
alter view vw_Categories
as
	select c.CategoryName from Categories c  where c.CategoryID in(5,6,7)
	


--
drop view vw_Categories


