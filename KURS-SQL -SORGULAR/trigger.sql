--TRIGGERS

--Her trigger bir tabloya aittir.
--2 �e�it trigger vard�r:

--1)After  INSERT/UPDATE/DELETE
--2)Instead of INSERT/UPDATE/DELETE


/*
Order Details tablosunda yap�lacak her insert i�lemi 
i�in �al��acak trigger
*/
create trigger TG_StokTakip
on [Order Details]
after insert 
as 
begin
	Declare @PID int,@Adet int
	select @PID=ProductID,@Adet=Quantity from 
	inserted --en son eklenen sat�r� verir.(yani en son eklenen sat�rdan ProductID ve Quantity de�erlerini bizim belirtti�imiz de�i�kenlere at dedik.)
	update Products
	set UnitsInStock -=@Adet  --orderdetails(sipari� oldu�unda �r�nler tablosundan adeti azaltmam�z laz�m.)
	where ProductID=@PID
end

select*from [Order Details]
select*from Products where ProductID=1

insert into [Order Details] values(10248,1,12,9,0) --1 numaral� �r�nden sipari� ediyoruz o y�zden urunler tablosuna gidip sto�unu azaltmam�z laz�m.

go --birbirinden ay�r



--�nstead of kulan�m�
create trigger tg_Silinmez
on Products 
instead of Delete --silme i�lemi yerine 
as 
begin
Declare @PID int 
select @PID=ProductID from deleted --deleted edilen son kay�ttan ProductID bilgisini al @PID de�erine ata dedik.
update Products
set UnitsInStock=0  --�r�n� silmedik sadece sto�unu s�f�rlam�� olduk.
where ProductID=@PID
end


delete from Products where ProductID=2



--------------
create trigger TG_EMPLOYEE
on Employees
after insert 
as 
begin
	Declare @EID int,@UserName nvarchar(50)

	select @EID=EmployeeID,@UserName=LOWER(FirstName)+'.'+LOWER(LastName) from 
	inserted --en son eklenen sat�r�n bilgileri verir(bu bilgileride de�i�kenlere atar�z.)
	insert into  Users(EmployeeID,Username,[Password],CreatedDate) values(@EID,@UserName,NEWID(),GETDATE()) --newid rastgele say� �retir,getdate �uan�n zaman�n� al�r.

end

insert into Employees(FirstName,LastName) values('Ali','korkmaz')


select*from Employees
select*from Users
---------------------------
update Employees set RecordStatus=1 --t�m �al��anlar� RecordStatusunu 1 yapar.

--personle i�ten ��k�nca record status 2 olacak ve employenin user� silenecek

create trigger tg_Silinmez2
on Employees 
instead of Delete --silme i�lemi yerine 
as 
begin
Declare @EID int 
select @EID=EmployeeID from deleted --silinen kay�ttan bilgileri al de�i�kenlere ata.
update Employees
set RecordStatus=2
where EmployeeID=@EID

delete from Users where EmployeeID=@EID

end


delete from Employees where EmployeeID=12


select*from Employees
select*from Users
------------------------------
create trigger tg_Guncelleme
on Customers 
after update --for update de yaz�labilir
as
begin
	if UPDATE(CompanyName)--compnay name update olmu�sa
	begin
		Declare @CID varchar,
		@EskiAd nvarchar(50),
		@YeniAd nvarchar(50),
		@KayitAciklama nvarchar(500)
		--Not:update i�lemi �nce silme daha sonra ekleme i�lemidir .a�a��dada deleted ,inserted olaylar�n� bunun i�in yapt�k.
		select @EskiAd=CompanyName,@CID=CustomerID from deleted --updated olmad��� i�in deleted yapt�k

		select @YeniAd=CompanyName from inserted

		select @KayitAciklama=@CID +'ID''li '+'"'+@EskiAd+'"'+' isimli m��terinin ad� '+'"'+@YeniAd+'"'+' olarak de�i�tirildi.'

		insert into Logs values(@KayitAciklama,GETDATE())
   end
end

update Customers set CompanyName='Bili�im E�itim' where CustomerID='VINET'

select *from Logs


select*from Customers