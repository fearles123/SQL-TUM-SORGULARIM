--K�meleme fonksiyonlar�:Birle�tirme,kesi�im ve fark olmak �zere 3'e ayr�l�r
--Farkl� iki sorgu �zerinde yukar�da belirtilen i�lemleri yapar.
--�nemli bir kural vard�r.Yukar�da t�m i�lemlerde iki sorgudaki kolon say�s� ve kolon tipleri ayn� olmak zorundad�r.
--Birle�tirme-->Union 
--Fark -->Except 
--Kesi�im -->intersect


--Union:
--T�m carilerimizi listeleyen sorguyu yaz�n�z.(hem m��terilerimizi hem tedarik�ilerimizi  listeleyen sorguyu yaz�n�z. )

select SirketAdi,'Tedarikci' from Tedarikciler
union --iki sorguyu birle�tirdi.
select SirketAdi,'Musteri' from Musteriler

--intersect:
select SirketAdi from Tedarikciler 
intersect--iki sorgudaki kesi�imi al�r.iki sorgudaki ayn� olan �irketi getir.
select SirketAdi from Musteriler 

--except:iki sorgu aras�ndaki fark� al�r
select SirketAdi from Tedarikciler
except --yukar�daki sorgudan a�a��daki sorguyu ��kar.(ortak olan 1 kay�t vard�.o 1 kay�d� ��kar�r.)
select SirketAdi from musteriler