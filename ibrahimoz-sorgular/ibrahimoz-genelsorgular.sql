--RDMBS :�li�kisel veritaban� y�netim sistemi
--T-SQL Dili:Transact Structurer Query Language
--master:veritabanlar�n�n ve ayarlar�n�n tutuldu�u database'dir.
--model:Veritaban� �emalar�n�n tutuldu�u databasedir.
--msdb:Server ile ilgili ayarlar�n tutuldu�u database'dir.
--tempdb:Ge�ici database veya tablolar�n tutuldu��u database'dir.

--VER� T�PLER�
--bigint --- c# ta long (en b�y�k tam say�)
--bit -->c# ta bool 
--char -->karakter
--image -->resmin kendisini tutar. 
--money -->c# ta decimal (para ile ilgili i�lemler)
--smallint -->c# ta short
--tinyint -->c# ta byte(en k���k tamsay�)
--char,nchar,ntext,text,varchar,nvarchar --> string tutarlar
--char(10) -->10 karakter tutar.i�erisine 5 karakterde koysan�z 10 karakterlik yer kaplar.
--nchar(10)-->universal (�,�,� gibi karakterlerde var) yani t�m karakterlerin i�erisinde bar�nmas�n� sa�lar. 
--varchar(50)-->i�inde bulunan karakter kadar yer kaplar.karakter say�m� yapar
--nvarchar(50)-->hem karakter say�m� yapar hemde universal karakterleri destekler.t�m karakterleri destekler.
--varchar(max)-->karakter say�m� yaparak s�n�rs�z kay�t tutmay� sa�lar.(veritaban� dolana kadar.)
--nvarchar(max)-->s�n�rs�z kay�t tutar.em karakter say�m� yapar hemde universal karakterleri destekler.t�m karakterleri destekler.
--text:direk metin tutmay� sa�lar.
--ntext-->universal destekli metin tutmay� sa�lar.
--en �ok kullan�lan nvarchar(50)'dir.

--iki tane primary key varsa bir tabloda o composit key dir.Yani birle�imleri benzersizdir.Birden fazla kolonun birle�iminin benzersizli�ini sa�lar.

--foreign key bir tabloda olan verilerin di�er tablodada olmas�n� sa�lamakt�r.yani farkl� bir de�er girilemez o tabloda ne varsa di�er tablodada ayn�s� olmas� laz�m.��renci tablosundaki Ders k�sm�na Ders tablosunda olmayan bir veri girilemez.bunun kontrol�n� yapar.

--bir tabloda sadece bir tane primary key olur.ama birden fazla unique key bulunabilir.unique key o kolonun benzersiz olmas�n� sa�lar.ayn� kolonda ayn� veriler olmaz.

--bir tabloya kay�t ekleme an�nda bir kuraldan ge�irme i�lemine check constraint denir.
--DogumTarihi<getdate() gibi ko�ul ekleyebiliriz.DogumTarihi bug�n�n tarihinden b�y�k girilemez.

--DML:Data Manipulation Language
---select,insert,update,delete

--DDL:Data definition language
--create ,alter,drop


----------------------------------------------------------------------------------------
--DML:Data Manipulation Language
--1-Select:Veri listeleme komutudur.
--Yaz�m�:select kolonIsimleri from TabloAdi

select * from Urunler --�r�nler tablosunu t�m kolonlar� ile listele

select*from Kategoriler

select SirketAdi,MusteriAdi,MusteriUnvani from Tedarikciler

--where:kriter uygulamak i�in kullan�lan komuttur
select*from Urunler where UrunID=5
--Fiyat� 50den b�y�k olan �r�nlerin listesi
select*from Urunler where Fiyat>50

--kategoriIdsi 6 olan �r�nleri listeleyin
select*from Urunler where KategoriID=6

--Sto�u 20'den k���k olan �r�nleri listeleyiniz
select*from Urunler where Stok<20

-----------------------------------
--�r�n Ad� Chang olan �r�n� listeleyin.
select *from Urunler where UrunAdi='Chang' 

--like:

--�r�n ad�n�n ilk harfi c ile ba�layan devam�nda herhangi bir �ey gelen �r�nleri listeleyin.
select*from Urunler where UrunAdi like 'c%'

-- alt �izgi bir karakter demek.
--ilk harfleri herhangi bir�eyler olabilir sondan bir �nceki karakteri C olacak sonda bir harf olacak
select*from Urunler where UrunAdi like '%C_'

--�r�n ad�nda herhangi bir yerde c ge�en �r�nleri listeleyiniz
select*from Urunler where UrunAdi like '%C%'

--�r�n ad�n�n ilk harfi c veya a veya b ile ba�layan �r�nleri listeleyiniz.
select*from Urunler where UrunAdi like '[_c,a,b]%'


--�r�n ad�nda sos ge�en �r�nleri listeleyin
select*from Urunler where UrunAdi like '%sos%'

--�r�n ad� s ile ba�lay�p e ile biten �r�nleri listeleyiniz.
select*from Urunler where UrunAdi like 's%e'

--�r�n ad�n�n ikinci harfi a veya e olan �r�nleri listeleyiniz
select*from Urunler where UrunAdi like '_[_a,e]%'

--�r�n ad�n�n sondan ikinci harfi t veya l olan ve c ile ba�layan �r�nleri listeleyiniz
select*from Urunler where UrunAdi like 'c%[_t,l]_'
select*from Urunler where UrunAdi like 'c%[t,l]_'
----------------------------------------------------------------------
--in :birden fazla kriteri ayn� anda uygulamam�z� sa�layan komuttur

--�r�n Idsi 5,7,9,11 olan �r�nleri listeleyin
select*from Urunler where UrunID in(5,7,9,11)

--�r�n Ad� Chai ve Chang olan �r�nleri listeleyiniz
select*from Urunler where UrunAdi in('Chai','Chang')

---------------------------------
--between:aras�nda anlam�ndad�r.

select*from  Urunler where UrunID between 5 and 11

--fiyat� 25.50 ile 74.50 aras�nda olan �r�nleri listeleyiniz
select*from Urunler where Fiyat between 24.50 and 74.50
------------------------------------------
--Top 
--�r�nler tablosundan ilk n kayd� listeleyiniz
select Top 10 *from Urunler --ilk 10 kay�t

--�r�n ad� c ile ba�lay�p sondon ikinci harfi n veya a olan ve fiyat� 25 ile 75 aras�nda olan �r�nlerden ilk ���n� getiren sorguyu yaz�n�z
select Top 3 *from Urunler where UrunAdi like 'C%[n,a]_' and Fiyat between 15 and 75

--------------------------------------------------------
--order by:kay�tlarda s�ralama i�lemini sa�lar.
--asc:0-9 veya a-z
--desc:9-0 veyaz z-a

--�r�nleri fiyatlar� �oktan aza do�ru olacak �ekilde listeleyiniz
select*from Urunler order by Fiyat desc

--Kategori Id 'si 5 olmayan ve �r�n ad�n�n ikinci harfi i olan �r�nleri sto�una g�re tersten s�ralayan sorguyu yaz�n
select*from Urunler where KategoriID!=5 and UrunAdi like '_i%' order by Stok desc

select*from Satislar

--Personel Id si 4 olan ve Nakliye �creti 15 ile 45 aras�nda olan SevkTarihine g�re tersten s�ralayarak son 3 kayd� getiren sat��lar� getirin.
select top 3* from Satislar where PersonelID=4 and NakliyeUcreti between 15 and 45 order by SevkTarihi desc

--�r�n idsi 5,14,17,25,34 olmayan �r�nleri listeleyin
select*from Urunler where UrunID not in(5,14,17,25,34)

--�r�n ad�nda c ge�meyen �r�nleri listeleyiniz.
select*from Urunler where UrunAdi not like '%c%'

--Tanimi null olmayan kategorileri getir.
select*from Kategoriler where Tanimi is not null   
select*from Kategoriler where Tanimi not like ''
--Tanimi null olmayan ve Resimide null olmayan olan kay�tlar� getir.
select*from Kategoriler where Tanimi is not null and Resim is not null

----------------------------------------------------
--aggregate functions:5 tane fonksiyon t�r� vard�r.
--max,min,count,avg,sum
--Aggregate fonksyionlar select ile from aras�na yaz�l�r
--Aggregate fonksiyon kullan�l�rken yan�na herhangi bir kolon getirilemez.(�uan i�in)
--1)count():Sat�r adedini veren fonksiyondur.

select *from Urunler
select count(*) from Urunler

select * from Kategoriler 
select count(Tanimi) from Kategoriler --i�ine sutun ismi verirsek null olanlar� saymaz

--2)sum:toplama  i�lemi yapmay� sa�layan fonksiyondur.
--stokta ka� adet �r�n bulunmaktad�r.
select*from Urunler
select sum(Stok) from Urunler

--stokta bulunan �r�nlerin toplam fiyat�n� bulunuz
select sum(Fiyat*Stok) from Urunler 

--3)Avg:Ortalama alan fonksiyondur.

--Sto�umuzda ortalama ka� adet �r�n vard�r.
select avg(Stok) from Urunler 

--sto�umuzda ortalama ne kadarl�k �r�n vard�r.
select avg(Fiyat*Stok) from Urunler 

--4)Max-->Belirtilen kolon i�inden de�eri max olan veriyi getirir.

--Sto�u en y�ksek olan �r�n� getiriniz.
select max(Stok) from Urunler 
select top 1* from Urunler  order by Stok desc

--5)Min:belirtilen kolon i�erisinden de�eri en d���k olan veriyi getirir

--Fiyat� en az olan �r�n�n fiyat�n� bulunuz
select MIN(fiyat) as [En D���k fiyat] from Urunler 

select UrunAdi as [�r�n Ad�] from Urunler --ismi olan kolonun ismini de�i�tirebiliriz.

--Toplam fiyat olarak ne kadarl�k sat�� yap�lm��t�r.
select *from SatisDetay
select sum(Fiyat*Adet*(1-Indirim)) as [Toplam Tutar] from SatisDetay

---------------------------------------------------------------------
--Group by:Tablo i�erisindeki veerileri gruplamay� sa�lar.
--Anahtar s�zc�k :Hangi .Bu kelime ge�iyorsa group by kullan
--Not:group by'dan sonra yaz�lan kolon select ile from aras�nada yaz�lmal�d�r.

--Hangi kategoriden ka� tane �r�n vard�r.
select*from Urunler
select KategoriID,count(*) from Urunler group by KategoriID

--Stokta hangi kategoriden ka� dolarl�k �r�n vard�r
select KategoriID,sum(Fiyat*Stok) as [Toplam Tutar] from Urunler group by KategoriID

--Hangi kategoriden stokta ka� adet �r�n vard�r.
select KategoriID,sum(Stok) from Urunler group by KategoriID

--Hangi tedarik�iden ka� adet �r�n tedarik edilmi�tir.
select TedarikciID,count(*) from Urunler group by TedarikciID

--hangi tedarik�iden stokta toplamda ka� dolarl�k �r�n vard�r.
select*from Urunler
select TedarikciID,sum(Fiyat*Stok) from Urunler group by TedarikciID

select*from Satislar

--Hangi personel hangi m��teriye ka� adet  sat�� yapm��t�r(Sat��lar tablosu)
select PersonelID,MusteriID,count(*) as [Sat�� miktar� ] from Satislar group by PersonelID,MusteriID
--not:group by dan sonra yazd�klar�m�z� select ile from aras�na da yazmal�y�z.

--hangi m��teri hangi nakliyeciden ka� adet sipari�de bulunmu�tur.(Nakliyeci kolonu ShipVia)
select MusteriID,ShipVia,count(*) from Satislar group by MusteriID,ShipVia 


--hangi �r�nden toplamda ka� dolarl�k sat�� yap�lm��t�r ve toplam sat�� miktar�n� b�y�kten k����e do�ru s�ralay�n�z..(SatisDetay)
select*from SatisDetay
select UrunID,sum(Fiyat*Adet*(1-Indirim)) as [Toplam Tutar] from SatisDetay group by UrunID order by [Toplam Tutar] desc
----------------------------------------------------------------------------------------
--ALT SORGULAR(i� i�e sorgular)
--1)Kullan�m �ekli:select ile from aras�na bi sorgu yaz�l�r.Bu sorguda �nemli nokta sorgunun tek kolonu olmas� gerekir.(select KategoriAdi  from Kategoriler where KategoriID=Urunler.KategoriID 'sorgusunda sadece KategoriAdi kolonunu yazd�k ba�ka yaz�lmaz.)
select *,(select KategoriAdi  from Kategoriler where KategoriID=Urunler.KategoriID ) as [Kategori Ad�] from Urunler 
--alttaki gibide yaz�labilir.
select *,(select KategoriAdi  from Kategoriler as k where k.KategoriID=u.KategoriID ) as [Kategori Ad�] from Urunler  as u

--�r�nler tablosunu tedarik�i ad� ile birlikte listeleyiniz.
select *,(select SirketAdi from Tedarikciler t where t.TedarikciID=u.TedarikciID) as [�irket Ad�] from Urunler u

--�r�nler tablosunu tedarik�i ad� ve kategori ad�,�r�n ad�,Fiyat ve stok bilgileri ile birlikte listeleyiniz.
select UrunAdi,Fiyat,Stok,(select KategoriAdi from Kategoriler k where k.KategoriID=u.KategoriID) as [Kategorisi],(select SirketAdi from Tedarikciler t where t.TedarikciID=u.TedarikciID ) as [Tedarik�isi] from Urunler u  

--sat��lar tablosunu m��teri ad� �nvan� ,personel ad� soyad� ile birlikte listeleyiniz.
select*from Satislar
select*from Musteriler
select*from Personeller

select *,(select MusteriAdi+' '+MusteriUnvani from Musteriler m where m.MusteriID=s.MusteriID),(select Adi+SoyAdi from Personeller p where p.PersonelID=s.PersonelID) from Satislar s 


--�r�nlerle birlikte �r�n�n toplam sat�� adedi bilginide g�steren sorguyu yaz�n�z
select*from Urunler 
select*from SatisDetay

select *,(select sum(Adet) from SatisDetay s where s.UrunID=u.UrunID)from Urunler u

--Yap�lan sat��lar� maximum sat�� fiyat� bilgisiyle listeleyiniz.(Satislar)
select *from Satislar
select *from SatisDetay

select *,(select max(Fiyat) from SatisDetay d where d.SatisID=s.SatisID) from Satislar s

--�r�nleri �r�ne uygulanan maximum indirim y�zdesi ile birlikte listeleyen sorguyu yaz�n�z.
select *from Urunler 
select *from SatisDetay

select *,(select max(Indirim) from SatisDetay d where d.UrunID=u.UrunID) as [Maximum Indirim y�zdesi] from Urunler u 

--Yap�lan sat��lar� toplam sat�� tutarlar� ile birlikte listeleyen sorguyu yaz�n�z.
select *from Satislar
select *from SatisDetay

select *,(select sum(adet*fiyat*(1-Indirim))  from SatisDetay sd where sd.SatisID=s.SatisID)from Satislar s 
----------------------------------------------
--Alt SorgularDA 2.KISIM
--Alt sorguyu kullanarak kriter �retmek
--Bu alt sorgular where k�sm�nda kullan�l�r.
--Burdada select ile from aras�na bir kolon yaz�l�r(select PersonelID from Personeller where Adi='Nancy'  tekbir kolon var PersonelID)

select*from Personeller
select*from Satislar

--Ad� Nancy  olan personelin yapt��� sat��lar� listeleyiniz.
select *from Satislar where PersonelID=(select PersonelID from Personeller where Adi='Nancy')

--Ad� Nancy olan ve Janet olan personellerin yapt��� sat��lar� listeleyiniz.
select *from Satislar where PersonelID in(select PersonelID from Personeller where Adi='Nancy' or Adi='Janet')
--a�a��daki gibide yapabiliriz ayn� �ey ama idleri bilmemiz gerekir.
select *from Satislar where PersonelID in(1,3)
--ad�n�da g�stermek istersek a�a��daki gibi yapar�z
select *,(select Adi from Personeller p where p.PersonelID=s.PersonelID)from Satislar s where PersonelID in(select PersonelID from Personeller where Adi='Nancy' or Adi='Janet')


--Personel ad� nancy veya Janet  olan ve nakliyecisi Speedy Express olan sat��lar� listeleyiniz
select*from Personeller
select*from Satislar
select*from Nakliyeciler

select*from Satislar where PersonelID in(select PersonelID from Personeller where Adi='Nancy' or Adi='Janet') and ShipVia=(select NakliyeciID from Nakliyeciler where SirketAdi='Speedy Express')

--�r�n ad� chai olan �r�n�n toplam sat�� tutar�n� g�steren sorguyu yaz�n�z.
select*from SatisDetay
select*from Urunler

select sum(Adet*Fiyat*(1-Indirim)) from SatisDetay where UrunID=(select UrunID from Urunler where UrunAdi='chai')

--�dsi 5 olan kategorideki �r�nleri toplam sat�� tutar�n� bulan sorguyu bulun.
select*from SatisDetay
select*from Urunler
select*from Kategoriler

select sum(Fiyat*Adet*(1-Indirim)) from SatisDetay where UrunID in(select UrunID from Urunler where KategoriID=5)

--1997 y�l�nda yap�lan sat��larda ne kadar ciro(toplam tutar) elde edildi�ini bulan sorguyu yaz�n�z.
select*from Satislar
select*from SatisDetay

select sum(Fiyat*Adet*(1-Indirim))  from SatisDetay where SatisID in(select SatisID from Satislar where Year(SatisTarihi)=1997)

--yada a�a��daki gibi yap�labilir
select sum(sd.Fiyat*sd.Adet*(1-sd.Indirim)) as [Toplam SAt��]  from SatisDetay  sd where sd.SatisID in(select s.SatisID from Satislar s where s.SatisTarihi between '1997.01.01' and '1997.12.31')

--Idsi Alfk� m��terisinin yapt��� toplam sat�� tutar�n� bulan sorguyu yaz�n�z.
select*from Musteriler
select*from SatisDetay
select*from Satislar

select sum(Adet*Fiyat*(1-Indirim)) as [Toplam sat��] from SatisDetay where SatisID in(select SatisID from Satislar where MusteriID='ALFKI')

--Speedy Express isimli nakliyeci bug�ne kadar ka� adet �r�n ta��m��t�r
select*from Satislar
select*from SatisDetay
select*from Nakliyeciler

select sum(Adet) from SatisDetay where SatisID in(select  SatisID from Satislar where ShipVia=(select NakliyeciID from Nakliyeciler  where SirketAdi='Speedy Express'))

--Alfk� isimli m��teri hangi kategorilerde �r�n sat�n alm��t�r.(hangi dedi�imiz i�in group by yap�caz)
select*from SatisDetay
select*from Kategoriler
select*from Urunler

--burda kategorinin idlerini getirdik.
select KategoriID from Urunler where UrunID in(select UrunID from SatisDetay where SatisID in(select SatisID from Satislar where MusteriID='ALFKI')) group by KategoriID


--a�a��daki gibide yap�labilir.isminide getirdim ben 
select KategoriAdi from Kategoriler where KategoriID in(select KategoriID from Urunler where UrunID in(select UrunID from SatisDetay where SatisID in(select SatisID from Satislar where MusteriID='ALFKI') ))