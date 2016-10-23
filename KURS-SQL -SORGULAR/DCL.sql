--	DCL(Data Credential LAnguage)

--GRANT 
--DENY

--Sql servera login i�in kullan�c� olu�turulmas�
CREATE LOGIN ramazan WITH PASSWORD='123Ab/' 

--login user i�in Northwinde DB'de kullan�c� olu�turulmas�
CREATE USER ramazan for LOGIN ramazan

GRANT SELECT ON Categories TO ramazan
GRANT INSERT ON Categories TO ramazan
GRANT UPDATE ON Categories TO ramazan
GRANT DELETE ON Categories TO ramazan

GRANT SELECT,INSERT,UPDATE,DELETE ON Categories TO ramazan
 
GRANT CREATE TABLE  TO ramazan
GRANT CREATE VIEW  TO ramazan
GRANT CREATE PROCEDURE  TO ramazan
--GRANT CREATE TRIGGER  TO ramazan
GRANT CREATE FUNCTION  TO ramazan

 --SP �al��t�rma yetkisi
 GRANT EXEC TO ramazan

 --ALTER yap�labilen t�m nesneleri d�zenleme yetkisi
 GRANT ALTER TO ramazan

 --deny
 DENY SELECT ON Categories TO ramazan
DENY INSERT ON Categories TO ramazan
DENY UPDATE ON Categories TO ramazan
DENY DELETE ON Categories TO ramazan

DENY SELECT,INSERT,UPDATE,DELETE ON Categories TO ramazan
 
 DENY CREATE TABLE  TO ramazan
DENY CREATE VIEW  TO ramazan
DENY CREATE PROCEDURE  TO ramazan
--DENY CREATE TRIGGER  TO ramazan
DENY CREATE FUNCTION  TO ramazan