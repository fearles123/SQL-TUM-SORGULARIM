--functions(Fonksiyonlar):
--Fonksiyonlarda 3'e ayr�l�r.
--Bunlar;
--1:Scalar valued Functions 
--2:Table valued functions 
--3:Aggregate valued functions (sum,avg,count fonksiyonlar�)

--1:Scalar valued functions(geriye tek h�cre ��kt�s� verirler)
create function fncKdvHesapla(@fiyat money)
returns money --geriye d�nd�rece�i tipi belirtiyoruz.
as
begin

declare @kdv money --de�i�ken tan�mlad�k 
set @kdv=@fiyat*0.18  --de�eri atad�k
return  @kdv   --de�eri geriye d�nderdik


end

select UrunAdi,Fiyat,dbo.fncKdvHesapla(Fiyat) as KDV from Urunler 

go--yukar�daki kodla a�a��daki kodu ay�r�r.


--�r�n�n kdvli fiyat�n� hesaplayan functions'u yaz�n�z
create function fncKdvliFiyat(@fiyat money)
returns money
as
begin

declare @kdvli money
set @kdvli=@fiyat+(@fiyat*0.18)
return @kdvli 

end

select UrunAdi,Fiyat,dbo.fncKdvHesapla(Fiyat) as KDV,dbo.fncKdvliFiyat(Fiyat) as KDVL�F�YATI from Urunler 

go

--SATILAN �R�NLER�N ADETLER� VE �ND�R�MLER�DE BAZ ALINARAK HER �R�N�N KDVL� F�YATINI HESAPLAYAN FONKS�YONU YAZINIZ


create function fncGenelKdvliFiyat(@fiyat money,@adet int,@indirim float)
returns money
as 
begin

	declare @kdvli money
	set @kdvli=@fiyat*@adet
	set @kdvli=@kdvli+(@kdvli*0.18)
	set @kdvli=@kdvli*(1-@indirim)
	return @kdvli

end

select UrunID,Adet,Fiyat,Indirim,dbo.fncGenelKdvliFiyat(Fiyat,Adet,Indirim) as KDVL�F�YAT from SatisDetay

go 

--2:Table valued Functions:Geriye table tipinde de�er d�nd�ren fonksiyonlard�r.

create function KategoriyeGoreUrunler(@kId int)
returns table
as
return select*from Urunler where KategoriID=@kId



select*from dbo.KategoriyeGoreUrunler(6)


------------
declare @a int=10  --de�i�ken tan�mlama


--table tipinde de�i�ken tan�m�
declare @deneme table(b int) --i�erisinde tek bir kolon olan ve kolonun ad� b olan table tan�mlad�k.