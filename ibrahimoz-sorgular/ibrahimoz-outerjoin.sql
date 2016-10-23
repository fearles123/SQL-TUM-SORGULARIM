--Outer join:ili�kili tablolardaki null olan kay�tlarda dahil t�m kay�tlar� getirir.
--3 �e�it outer join vard�r
--Bunlar;left outer join,right outer join,full outer join
--1)Left outer join: left tablo ilk yaz�lan yani soldaki tablodur.Sol tablodaki t�m kay�tlar getirilir.null olsa bile ve sa� tablodan sol tablonun ili�kili kay�tlar� getirilir.Yani k�sacas� soldaki tabloda bulunup sa�daki tabloda kar��l��� olmayan kay�tlar�da getirir.

select*from Urunler u left outer  join  Kategoriler k on u.KategoriID=k.KategoriID

--2)Right outer join:Sa�daki tablodaki null kay�tlar dahil t�m kay�tlar getirilir.Soldaki tablodan ili�kili kay�tlar getirilir.

select*from Urunler u right outer join Kategoriler k on u.KategoriID=k.KategoriID

--3)Full outer join:Hem sa�daki tablodan hem soldaki tablodan null kay�tlarda dahil t�m kay�tlar� getirir.

select*from Urunler u full outer join  Kategoriler k on u.KategoriID=k.KategoriID --hem kategori bilgisi olmayan �r�nler ve �r�n bilgisi olmayan kategorilerde listelenmi� odlu.

--�r�nler tablos�ndaki kategoriid 'si null olan kayd� getir.Yani �r�n bilgisi olan ama kategori bilgisi olmayan verileri getir.
select*from Urunler u left outer join Kategoriler k on u.KategoriID=k.KategoriID where u.KategoriID is null

--kategorisi bilgisi olan ama �r�n bilgisi olmayan kay�tlar� getir.
select*from Urunler u right outer join Kategoriler k on u.KategoriID=k.KategoriID where u.KategoriID is null

select*from Urunler u full outer join Kategoriler k on u.KategoriID=k.KategoriID where u.KategoriID is null or k.KategoriID is null --hem �r�n bilgisi olup kategori bilgisi olmayan kay�tlar hemde kategori bilgisi olup �r�n bilgisi olmayan kay�tlar gelir.

--hangi tedarik�iden toplamda ka� dolarl�k �r�n tedarik edilmi�tir.(T�m tedarik�iler gelmelidir.)
select t.TedarikciID,SUM(u.Fiyat*u.Stok) from Tedarikciler t right outer join Urunler u on u.TedarikciID=t.TedarikciID group by t.TedarikciID

--hi� sat�� yapmayan m��terilerimizi listeleyen sorguyu yaz�n�z
select*from Musteriler m left outer join Satislar s on s.MusteriID=m.MusteriID  where s.SatisID is null


--nakliye edilemeyen sipari�leri listeleyiniz.
select*from Satislar s  left outer join Nakliyeciler n  on n.NakliyeciID=s.ShipVia
 where s.ShipVia is null
 
 
 --hi� nakliye yapmayan nakliyecilerimizi listeleyen sorguyu yaz�n�z
 select*from Satislar s right join Nakliyeciler n on s.ShipVia=n.NakliyeciID where s.ShipVia is null 

 --hangi personel hangi �r�nden hi� sat�� yapmam��t�r.
 select u.UrunAdi,p.Adi from Personeller p left join Satislar s on p.PersonelID=s.PersonelID left join SatisDetay sd on s.SatisID=sd.SatisID left join Urunler u on sd.UrunID=u.UrunID group by u.UrunAdi,p.Adi
 except 
 select UrunAdi,p.Adi from Urunler u left join SatisDetay sd on u.UrunID=sd.UrunID left join Satislar s on sd.SatisID=s.SatisID left join Personeller p on s.PersonelID=p.PersonelID


