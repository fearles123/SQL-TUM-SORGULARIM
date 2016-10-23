--CROSS JO�N:Tablolardaki t�m kay�tlar� birbiri ile kartezyen �arp�m yaparak birbiri ile ili�kilendirir

select*from Urunler u cross join Kategoriler --yani Urunler tablosundaki her bir sat�r� di�er tablodaki sat�rla birle�tir demek.


--hangi personel hangi �r�nlerden sat�� yapmam��t�r?
select p.Adi,u.UrunAdi from Personeller p  cross join Urunler u--t�m personele t�m �r�nleri atad�k.daha sonra bu sorgudan her bir personelin satm�� oldu�u �r�nleri ��kar�rsak hangi personelin hangi �r�nden satmad���n� buluruz.

select p.Adi,u.UrunAdi from Personeller p left join Satislar s on p.PersonelID=s.PersonelID left join SatisDetay sd on s.SatisID=sd.SatisID left join Urunler u on sd.UrunID=u.UrunID group by p.Adi,u.UrunAdi --her bir personelin satt��� �r�nleri g�sterir

--
--a�a��daki sorgu bize hangi �r�nlerden sat�� yapmam��t�r onu bize verir.
select p.Adi,u.UrunAdi from Personeller p  cross join Urunler u
except--yukar�daki sorgudan a�a��daki sorguyu ��kar demektir.
select p.Adi,u.UrunAdi from Personeller p left join Satislar s on p.PersonelID=s.PersonelID left join SatisDetay sd on s.SatisID=sd.SatisID left join Urunler u on sd.UrunID=u.UrunID group by p.Adi,u.UrunAdi 


--HANG� TEDAR�K��DEN HANG� �R�N H�� TEDAR�K ED�LMEM��T�R?
select SirketAdi,UrunAdi from Urunler cross join Tedarikciler --her bir tedarik�iyi her bir �r�nle e�le�tirdik.Daha sonra hangi tedarik�i hangi �r�n� tedarik etmi� onu buluruz.ve bunu ��kart�rsak hangi tedarik�i hangi �r�nleri hi� tedarik etmemi� bunu buluruz. 

select SirketAdi,UrunAdi from Urunler u left  join Tedarikciler t on u.TedarikciID=t.TedarikciID group by SirketAdi,UrunAdi --hangi tedarik�i hangi �r�n� tedarik etmi� onu bulduk .daha sonra yukar�daki sorgudan ��kart�rsak istenileni bulmu� oluruz

---
select SirketAdi,UrunAdi from Urunler cross join Tedarikciler 
except--yukar�daki sorgudan a�a��daki sorguyu ��kar demektir.
select SirketAdi,UrunAdi from Urunler u left  join Tedarikciler t on u.TedarikciID=t.TedarikciID group by SirketAdi,UrunAdi


--HANG� �R�N HANG� M��TER�YE H�� SATILMAMI�TIR?
select m.SirketAdi,u.UrunAdi from Urunler u  cross join Musteriler m  --her bir m��teriyle her bir �r�n� e�le�tirdik.daha sonra bunu a�a��daki sorgudan ��kart�rsak istenileni bulmu� oluruz.

select m.SirketAdi,u.UrunAdi from Musteriler m left join Satislar s on m.MusteriID=s.MusteriID left join SatisDetay sd on sd.SatisID=s.SatisID left join Urunler u on sd.UrunID=u.UrunID  group by m.SirketAdi,u.UrunAdi--hangi m��teriye hangi �r�n sat�lm�� bulduk.

--
select m.SirketAdi,u.UrunAdi from Urunler u cross join Musteriler m
except
select m.SirketAdi,u.UrunAdi from Musteriler m left join Satislar s on m.MusteriID=s.MusteriID left join SatisDetay sd on sd.SatisID=s.SatisID left join Urunler u on sd.UrunID=u.UrunID  group by m.SirketAdi,u.UrunAdi

