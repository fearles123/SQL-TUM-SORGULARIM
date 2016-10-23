--transactions

--i�lemlerin b�t�nl���n�n sa�lanmas�na transaction denir.
--bir ve ya birden fazla i�lemin b�t�n i�inde �al��mas�
--i�lemlerin herhangi bir hata durumunda geri al�nmas�na rollback(geri alma) denir.
--transaction blo�u try/catch bloklar� i�erisinde kullan�lmal�d�r.


alter PROC HAVALEYAP
@GONDEREN INT,
@ALICI INT,
@TUTAR money 
as
begin
	declare @BAKIYE MONEY
	select @BAKIYE=Bakiye from Musteriler where MusteriID=@GONDEREN  --de�eri atad�k.

	IF(@BAKIYE>@TUTAR)
	begin
		begin try 
			begin tran 
				update Musteriler SET Bakiye-=@TUTAR
				WHERE MusteriID=@GONDEREN
				SELECT 1/0 --HATA KISMI 
				UPDATE Musteriler set Bakiye+=@TUTAR
				where MusteriID=@ALICI

			commit
		end try
		begin catch
		    SELECT '��LEM GER� ALINDI ' +ERROR_MESSAGE()
			ROLLBACK  TRANSACTION        --TRAN 'da diyebiliriz
		end catch
	end
	else
	begin
	print 'yetersiz bakiye!'
	end

end

select*from Musteriler

exec HAVALEYAP 1,2,2000


go--yukar�daki kodla a�a��daki kodu birbirinden ay�r�r.
----------------------------------------
--Employee tablosuna veri eklenirken user tablosunada veriyi ekliyoruz.bir hata durumunda transaction kullanarak user i�lemleri geri al�yoruz
alter PROC TRANSAC_EMPLOYEE
@EMPLOYEENAME varchar(50),
@EMPLOYEELASTNAME varchar(50)
AS
begin
	begin try 
	
			begin tran 
			INSERT INTO Employees(FirstName,LastName)
	values(@EMPLOYEENAME,@EMPLOYEELASTNAME)
	   select 1/0 --hata k�sm�
		declare @EmployeID int

	select @EmployeID=SCOPE_IDENTITY()--eklenen kayd�n idsi

	insert into Users values(@EmployeID,LOWER(@EMPLOYEENAME+'.'+@EMPLOYEELASTNAME),NEWID(),GETDATE())
			commit
		end try
		begin catch
		SELECT '��LEM GER� ALINDI ' +ERROR_MESSAGE()
			ROLLBACK  TRANSACTION        --TRAN 'da diyebiliriz
		end catch
end

exec TRANSAC_EMPLOYEE 'nedim','sad'

-------------------

