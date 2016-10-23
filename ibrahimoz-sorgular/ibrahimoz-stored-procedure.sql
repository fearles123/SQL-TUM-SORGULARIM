--Procedure:Procedure'u view 'in parametre alan �ekli gibi d���nebiliriz.

create proc Urun
as
begin
select*from Urunler
end

exec Urun

go --alttaki kodu �stteki koddan ay�r�r

--�r�n ad�n�,fyat�n� ve sto�unu parametre olarak al�p �r�nler tablosuna ekleyen procedure yaz�n�z.
create proc UrunEkle
@urunAdi nvarchar(50),
@fiyat money,
@stok smallint
as
begin
insert into Urunler(UrunAdi,Fiyat,Stok) values(@urunAdi,@fiyat,@stok)
end

exec UrunEkle 'Ayva',4,99

select*from Urunler

go--alttaki kodu �stteki koddan ay�r�r.


alter proc UrunEkle
@urunAdi nvarchar(50),
@fiyat money,
@stok smallint
as
begin
declare @trimli nvarchar(50)=ltrim(rtrim(@urunAdi))--sa�dan ve soldan bo�lu�u al
if(exists(select*from Urunler where UrunAdi=@trimli))--sorgu true ve ya false d�nd�r�r.
begin
print 'Bu �r�n zaten eklidir'
end

else
begin
insert into Urunler(UrunAdi,Fiyat,Stok) values(@trimli,@fiyat,@stok)
end

end

exec UrunEkle '�eftali ',7,120
exec UrunEkle ' �eftali',7,120


go 


--�r�n ad� parametresi alarak o �r�n� silen procedure'u yaz�n�z
create proc UrunSil
@urunAdi nvarchar(50)
as
begin
delete from Urunler where UrunAdi=ltrim(rtrim(@urunAdi))
end

exec UrunSil 'Ayva '

select*from Urunler


go


--id parametresi al�p o id li �r�n�n sto�unu 10 art�ran procedure'u yaz�n�z.
create proc StokArttir
@urunID int
as 
begin
update Urunler set Stok+=10 where UrunID=@urunID

end

exec StokArttir 85

select*from Urunler