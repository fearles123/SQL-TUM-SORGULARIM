--Having Deyimi:Sadece group by kullan�lan sorgularda kullan�labilir.Aggregate function kullan�larak where yazmay� sa�lar.
--Hesaplanarak �retilen bir s�tuna ko�ul koymak istedi�imizde kullanmam�z gereken komuttur.


--Sat�� fiyat� 1000 dolardan fazla olan hangi �r�nleri hangi personel satm��t�r?
select  p.Adi,u.UrunAdi,sum(sd.Fiyat*sd.Adet*(1-Indirim)) as [Toplam tutar]  from Personeller p left join Satislar s on p.PersonelID=s.PersonelID left join SatisDetay sd on s.SatisID=sd.SatisID left join Urunler u on sd.UrunID=u.UrunID group by p.Adi,u.UrunAdi having sum(sd.Fiyat*sd.Adet*(1-Indirim))>1000 