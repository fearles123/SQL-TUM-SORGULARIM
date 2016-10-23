--Join:Aralar�nda ili�ki bulunan tablolar�n birbiri ile ba�lant�s�n� kurarak tek sorguda tek tablo ��kt�s� vermeyi sa�layan yap�d�r.
--3 �e�it join vard�r.
--Bunlar; inner join,outer join,cross join
--1:inner join:ili�kili tablolarda ki null olmayan kay�tlar� listeler

--kategoriler ile �r�nleri birle�tir.
select *from Urunler u inner join Kategoriler k on u.KategoriID=k.KategoriID

select UrunAdi,Fiyat,Stok,KategoriAdi from Urunler u inner join Kategoriler k on u.KategoriID=k.KategoriID

--�r�nleri tedarik�i firma isimleri ile birlikte listeleyiniz.
select*from Urunler u inner join Tedarikciler t on u.TedarikciID=t.TedarikciID --birle�im yapt�k.a�a��dada bizden istenileni yapt�k.

select u.UrunAdi,t.SirketAdi from Urunler u inner join Tedarikciler t on u.TedarikciID=t.TedarikciID

select u.*,t.SirketAdi from Urunler u inner join Tedarikciler t on u.TedarikciID=t.TedarikciID--u.* demek urunler tablosunun t�m kolonlar�n� getir ve yan�na Sirket Adini getir.


--Yap�lan sat��lar� m��teri ad� soyad� ve personel ad� soyad� ile birlikte listeleyiniz.
select*from Musteriler m inner join Satislar s on s.MusteriID=m.MusteriID inner join Personeller p on p.PersonelID=s.PersonelID --birle�imi yapt�k ve a�a��dada bizden istenileni yapt�k.

select m.MusteriAdi,p.Adi+' '+p.SoyAdi as [Personel Ad� Soyad�],s.* from Musteriler m inner join Satislar s on s.MusteriID=m.MusteriID inner join Personeller p on p.PersonelID=s.PersonelID --s.* demek Satislar tablosundaki b�t�n kolonlar� getir demek.


--hangi personel hangi �r�nden toplamda ka� dolarl�k sat�� yapm��t�r.(hangi dedi�i i�in group by kullanacaz.)(Personel,Urunler,SatisDetay,Satis tablolar�)
select*from Personeller p inner join Satislar s on p.PersonelID=s.PersonelID inner join SatisDetay sd on s.SatisID=sd.SatisID inner join Urunler u on sd.UrunID=u.UrunID--birle�imi yapt�k.bizden istenilenide a�a��da yapt�k.

select p.Adi,u.UrunAdi,sum(sd.Fiyat*sd.Adet*(1-sd.Indirim)) as [Toplam SAt�� Tutar�] from Personeller p inner join Satislar s on p.PersonelID=s.PersonelID inner join SatisDetay sd on s.SatisID=sd.SatisID inner join Urunler u on sd.UrunID=u.UrunID group by p.Adi,u.UrunAdi order by p.Adi  --burada ikili gruplama var(ikisinin ayn� anda oldu�u grup )


--hangi personel hangi kategoriden toplamda ka� adet �r�n sat��� yapm��t�r.(Personel,Sati�,Sat��Detay,Urunler,Kategori)
select*from Personeller p inner join Satislar s on p.PersonelID=s.PersonelID inner join SatisDetay sd on s.SatisID=sd.SatisID inner join Urunler u on sd.UrunID=u.UrunID inner join Kategoriler k on u.KategoriID=k.KategoriID --birle�imi yapt�k a�a��dada bizden istenileni yapt�k

select p.Adi+' '+p.SoyAdi  as [Personel Ad� Soyad�],k.KategoriAdi,sum(Adet) as [Adet] from Personeller p inner join Satislar s on p.PersonelID=s.PersonelID inner join SatisDetay sd on s.SatisID=sd.SatisID inner join Urunler u on sd.UrunID=u.UrunID inner join Kategoriler k on u.KategoriID=k.KategoriID group by p.Adi+' '+p.SoyAdi,k.KategoriAdi order by [Personel Ad� Soyad�]

--Nakliyeci �irket ad� 'Speedy Express' olan nakliyeci sat�� fiyat� 15 dolardan y�ksek ka� adet �r�n ta��m��t�r.
select*from Nakliyeciler n inner join Satislar s on n.NakliyeciID=s.ShipVia inner join SatisDetay sd on sd.SatisID=s.SatisID 

select n.SirketAdi,sum(sd.Adet) from Nakliyeciler n inner join Satislar s on n.NakliyeciID=s.ShipVia inner join SatisDetay sd on sd.SatisID=s.SatisID  where n.SirketAdi='Speedy Express' and sd.Fiyat>15 group by n.SirketAdi  --Not:group by where 'den sonra yaz�l�r.