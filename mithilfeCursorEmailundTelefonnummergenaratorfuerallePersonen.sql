USE [Schule]
GO
DECLARE @PersonID bigint;
DECLARE @emailteil1 VARCHAR(43);
DECLARE @emailteil2 VARCHAR(43);
DECLARE @endteil VARCHAR(4);
DECLARE @email VARCHAR(100);
DECLARE @telefonInt bigint;
DECLARE @telefonString Varchar(20);

DECLARE mein_cursor CURSOR FOR
	SELECT id, Nachname, Vorname, DATEPART(Year,Geburtsdatum)
	FROM [dbo].[tb_personen];

OPEN mein_cursor;
	FETCH NEXT FROM mein_cursor 
	INTO @PersonID, @emailteil1, @emailteil2, @endteil;
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		SET @email = @emailteil1+@emailteil2+@endteil+'@gmail.com';
		SET @email = Lower(@email);
		SET @telefonInt = 150000+(Rand()*25555);
		SET @telefonString=CONCAT('0',@telefonInt,@endteil);
		INSERT INTO [dbo].[tb_kontakt]([personID],[kontakttypeID],[adresse],[Kommentar])
		Values  (@PersonID,4,@email,'von meinem Cursor generiert')
		INSERT INTO [dbo].[tb_kontakt]([personID],[kontakttypeID],[adresse],[Kommentar])
		Values  (@PersonID,1,@telefonString,'von meinem Cursor generiert')

		FETCH NEXT FROM mein_cursor
			INTO @PersonID, @emailteil1, @emailteil2, @endteil;
	END
PRINT 'Eine email und eine Telefonnummer für jede Personen wurden generiert und in der tb_Kontakt tabelle addiert'
CLOSE mein_cursor  
DEALLOCATE mein_cursor