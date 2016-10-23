--�nsert,Update,Delete 
--�nsert:Bir tabloya kay�t eklemeyi sa�layan komuttur
--Yaz�m� Insert [into] TabloAdi(kolon,kolon,kolon) values(deger,deger,deger)

--�r�nler tablosuna �r�n ekleyen sorguyu yaz�n�z
insert  into Urunler(UrunAdi,Fiyat,Stok) values('Elma',2,120)
select*from Urunler

--Personeller tablosuna kendinizi personel olarak ekleyiniz
insert into Personeller(Adi,Soyadi) values('Ramazan','Aras')
select*from Personeller

insert into Bolge values(5,'Akdeniz B�lgesi') --Bolge tablosunda her kolona veri gireceksek kolonlar�n ad�n� yazmam�za gerek yoktur.
select*from Bolge

insert into Kategoriler values('Meyvelerr','Elma,armut, vs',null)
select*from Kategoriler
--------------------------------------------
--update:belli kay�t(lar�) g�ncellemeyi sa�layan komuttur.
--Yaz�m�:update TabloAdi set Kolon=deger,Kolon=deger,Kolon=deger (varsa where yaz�l�r)

begin tran
update Urunler set Fiyat=15 --bunu yazarsak t�m �r�nlerin fiyat�n� 15 yapar.
rollback tran

select*from Urunler

update Urunler set Fiyat=15 where UrunID=80

begin tran
update Urunler set Stok=15 where KategoriID=1  --Kategori Idsi 1 olan �r�nlerin hepsinin stok�unu 15 yap
rollback tran --i�lemleri geri al�r.


--Kategori Id'si 2 olan �r�nlerin sto�unu 5 art�ran komutu yaz�n�z
update Urunler set Stok=Stok+5 where KategoriID=2
select*from Urunler
---------------------------------------------------
--Delete:Belirli kay�t(lar�) tablodan silme i�lemini sa�layan komuttur
--Yaz�m�:Delete [from] TabloAd� (varsa where)  --from yazmak zorunda de�iliz 
begin tran 
delete from Kategoriler where KategoriID=12 --where kriteri uygulamazsak t�m kay�tlar� siler.
rollback tran --i�lemleri geri al�r.

select*from Kategoriler


--�r�nler tablosuna yeni bir �r�n ekleyip sonras�nda o �r�n�n fiyat�n�n ve sto�unu g�ncelleyip en son da o �r�n� silen sorgular� yaz�n�z.
insert into Urunler(UrunAdi) values('Muzz')
declare @id int=Scope_Identity()--en son eklenen  kayd�n identity de�erini verir
--select @id idyi ekrana yazabiliriz bu �ekilde
--set @id=Scope_Identity() --yukar�da de�i�keni tan�mlay�p daha sonrada de�er atayabiliriz.
update Urunler set Fiyat=10,Stok=5 where UrunID=@id
delete from Urunler where UrunID=@id

select*from Urunler



 --INSERT
 INSERT INTO Categories(CategoryName, Description, Picture)
 output inserted.* -- veriyi ekledikten sonra kay�t edilen veriyi g�sterir,
 VALUES('Unlu Mam�ller','Pasta,b�rek,��rek vs...',null)