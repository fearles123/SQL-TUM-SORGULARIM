--Transaction :En k���k i�lem par�ac���d�r.
--Birden fazla i�lem par�ac���n�  tek bir i�lem par�ac��� haline getirip bu i�lem par�ac���n�n herhangi bir yerinde hata oldu�u zaman t�m i�lemi iptal etmeyi geri almay� sa�layan yap�d�r.

select*from Kategoriler

begin tran
delete from Kategoriler  where KategoriID=11

rollback tran --yukar�daki i�lemi geri al�r(veri geri gelir)

--------------------------------
--HAVALE ��LEM�
alter proc prc_HavaleYap
@aliciId int,
@gonderenId int,
@tutar money
as
begin

	begin try 

	begin tran havale--transaction ba�lay�yoruz
	update Hesaplar set Bakiye-=@tutar where Id=@gonderenId
	declare @a int=8/0--hata verdirdik(0'a b�l�nebilme hatas�)
	update Hesaplar set Bakiye+=@tutar where Id=@aliciId
	commit tran havale --a��lan transactionlar� onayl�yoruz.

	end try

	begin catch
	rollback tran havale--a��lan transaction'� geri al�yoruz.
	print 'Hata olu�tu'

	end catch



end

exec prc_HavaleYap 1,2,5000


select*from Hesaplar


--@TranCount:A��k olan transaction say�s�n� verir.
select @@TRANCOUNT