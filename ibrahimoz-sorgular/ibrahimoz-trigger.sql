--Trigger(Tetikleyici):Bir i�lemden sonra ba�ka bir i�lem yapabilmeyi veya bir i�lemin yerine ba�ka bir i�lem yapabilmeyi sa�layan yap�d�r.
--Kullan�c� elle trigger'� tetikleyemeyiz.
--Trigger'�n di�er yap�lardan fark� �al��aca�� zaman� kendisi belirler.

--2 tane trigger vard�r 
--Bunlar;
--After(Sonra) trigger ve instead of(Yerine) Trigger
--Trigger i�lemlerinde kullan�lan 2 tane sanal tablo vard�r
--Bunlar;inserted ve deleted tablolar�
--Eklenmeye �al���lan kay�t inserted tablosunda tutulur
--Silinmeye �al���lan kay�tta deleted tablosunda tutulur.

--�r�nler tablosuna delete komutu g�nderildi�inde delete komutu yerine update komutu �al��t�ran trigger� yaz�yoruz.
create trigger tg_UrunSil 
on Urunler --Hangi tabloda �al��aca��n� belirtiyoruz
instead of --Hangi trigger tipini kullanaca��m�z� belirtiyoruz
Delete   --hangi i�lem i�in bu trigger�n �al��aca��n� belirttik
as
begin
declare @id int 
select @id=UrunID from deleted  --1.Atama Y�ntemi
--set @id=(select UrunID from deleted)  --2.Atama y�ntemi

update Urunler set Sonlandi=1 where UrunID=@id
end

delete from Urunler where UrunID=1  --�r�n idsi 1 olan �r�n�n sonlandi alan� 1 oluyor

--instead of trigger:belirli bir tablo �zerinde belirli bir i�lemin yerine ba�ka bir i�lem �al��t�rmay� sa�layan trigger i�lemidir.

select*from Urunler

go
--------------------------

--After Trigger:Belirli bir tablo �zerinde belirli bir i�lemden sonra ba�ka bir i�lem daha yapabilmeyi sa�layan trigger �e�ididir.

--Sat�� detay tablosuna kay�t girildi�inde sat�lan urun adedi kadar o �r�n�n sto�undan d��en trigger'� yaz�n�z.

create trigger trg_StokDus
on SatisDetay
after 
insert 
as
begin

	declare @id int,@adet smallint
	select @id=UrunID,@adet=Adet from inserted 
	
	update Urunler set Stok-=@adet where UrunID=@id 

end

insert into SatisDetay(SatisID,UrunID,Fiyat,Adet,Indirim) values(10248,1,12,9,0)--1 numaral� �r�nden sipari� ediyoruz o y�zden urunler tablosuna gidip sto�unu azaltmam�z laz�m.

select*from SatisDetay
select*from Urunler


go--yukar�daki  kodla a�a��daki kodu birbirinden ay�r�r

--Sat�� detay tablosundan kay�t silindi�inde o �r�n�n sto�unu sat�� adedi kadar art�ran trigger� yaz�n�z.

create trigger trg_SatisSil
on SatisDetay
after 
delete 
as 
begin

declare @id int,@adet smallint 
select @id=UrunID,@adet=Adet from deleted 
update Urunler set Stok+=@adet where UrunID=@id


end

delete from SatisDetay where SatisID=10248 and UrunID=1 and Fiyat=12 and Adet=9 and Indirim=0


select*from SatisDetay
select*from Urunler