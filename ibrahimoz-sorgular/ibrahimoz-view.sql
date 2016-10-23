--DDL(Data Definition language):i�erisinde create ,alter drop komutlar� bulunur 
--Bu komutlar sayesinde 
--yeni veritabani
--yeni tablo,view procedure,trigger,functions gibi elemanlar tan�mlanabilir,de�i�tirilebilir ve kald�r�labilir.


--Create:

Create table Kisiler(
KisiID int primary key identity(1,1),
KisiAdi nvarchar(50) not null, --bo� ge�ilemez
KisiSoyadi nvarchar(50) not null,
Sehir nvarchar(50),

)

alter table Kisiler --de�i�iklik yapmak i�in.
drop column KisiAdi

go--seperator(ay�r�c�) yukar�daki komut ile a�a��daki komutun birbirinden ayr� olmas�n� sa�lar

--drop:var olan bir nesneyi kald�rmay� sa�lar.
drop table Kisiler 

------------------------------------------------------
--View:Sanal tablo demektir.
---Sorgu kay�t esnas�nda bir kez derlenir. bu sayede performans art��� sa�lan�r.
--View her �a�r�ld���nda i�indeki sorgu yeniden �al��t�r�l�r.

create view UrunRaporu
as
select u.*,k.KategoriAdi,t.SirketAdi from Urunler u left join Tedarikciler t on u.TedarikciID=t.TedarikciID left join Kategoriler k on u.KategoriID=k.KategoriID

select*from UrunRaporu

--Hangi personelin hangi �r�nden toplamda ka� dolarl�k sat�� yapt���n� listeleyen view � yaz�n�z
create view PersonelSatisRaporu
as
select p.Adi,u.UrunAdi,sum(sd.Fiyat*sd.Adet*(1-sd.Indirim)) as ToplamTutar from Satislar s left join Personeller p on p.PersonelID=s.PersonelID left join SatisDetay sd on sd.SatisID=s.SatisID left join Urunler u on u.UrunID=sd.UrunID group by p.Adi,u.UrunAdi

--Not:view veya function olu�tururken kolonlar�n ismi olmak zorundad�r.yoksa hata verir

select*from PersonelSatisRaporu



create view MusteriSatisRaporu 
with encryption --bu viewi de�i�ikli�e kapat demek
as 
select m.SirketAdi,u.UrunAdi,sum(sd.Fiyat*sd.Adet*(1-sd.Indirim)) as Total from Satislar s left join Musteriler m on s.MusteriID=m.MusteriID left join SatisDetay sd on sd.SatisID=s.SatisID left join Urunler u on sd.UrunID=u.UrunID group by m.SirketAdi,u.UrunAdi

select*from MusteriSatisRaporu