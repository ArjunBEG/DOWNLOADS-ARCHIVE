
DECLARE  @Tablenames VARCHAR(500)
DECLARE @SearchStr NVARCHAR(60)
DECLARE @GenerateSQLOnly Bit 

SELECT @Tablenames ='%'
SELECT @SearchStr  ='%5344e086%'
SELECT @GenerateSQLOnly = 0



/*
	Variables and usage

	@Tablenames		-- Provide a single table name or multiple table name with comma seperated. 
						If left blank , it will check for all the tables in the database
	@SearchStr		-- Provide the search string. Use the '%' to coin the search. 
						EX : X%--- will give data staring with X
							 %X--- will give data ending with X
							 %X%--- will give data containig  X
	@GenerateSQLOnly -- Provide 1 if you only want to generate the SQL statements without seraching the database. 
						By default it is 0 and it will search.

	Samples :

	1. To search data in a table

				 @Tablenames = 'T1'
				,@SearchStr  = '%TEST%'

		The above sample searches in table T1 with string containing TEST.

	2. To search in a multiple table

				 @Tablenames = 'T2'
				,@SearchStr  = '%TEST%'

		The above sample searches in tables T1 & T2 with string containing TEST.
	
	3. To search in a all table

				 @Tablenames = '%'
				,@SearchStr  = '%TEST%'

		The above sample searches in all table with string containing TEST.

	4. Generate the SQL for the Select statements

				 @Tablenames		= 'T1'
				,@SearchStr		= '%TEST%'
				,@GenerateSQLOnly	= 1

*/

	SET NOCOUNT ON

	DECLARE @CheckTableNames Table
	(
	Tablename sysname
	)

	DECLARE @SQLTbl TABLE
	(
	 Tablename		SYSNAME
	,WHEREClause    VARCHAR(MAX)
	,SQLStatement   VARCHAR(MAX)
	,Execstatus		BIT 
	)

	DECLARE @sql VARCHAR(MAX)
	DECLARE @tmpTblname sysname

	IF LTRIM(RTRIM(@Tablenames)) IN ('' ,'%')
	BEGIN

		INSERT INTO @CheckTableNames
		SELECT Name
		  FROM sys.tables
	END
	ELSE
	BEGIN

		SELECT @sql = 'SELECT ''' + REPLACE(@Tablenames,',',''' UNION SELECT ''') + ''''

		INSERT INTO @CheckTableNames
		EXEC(@sql)

	END
	
	INSERT INTO @SQLTbl
	( Tablename,WHEREClause)
	SELECT SCh.name + '.' + ST.NAME,
			(
				SELECT '[' + SC.name + ']' + ' LIKE ''' + @SearchStr + ''' OR ' + CHAR(10)
				  FROM SYS.columns SC
				  JOIN SYS.types STy
					ON STy.system_type_id = SC.system_type_id
				   AND STy.user_type_id =SC.user_type_id
				 WHERE STY.name in ('varchar','char','nvarchar','nchar')
				   AND SC.object_id = ST.object_id
				 ORDER BY SC.name
				FOR XML PATH('')
			)
	  FROM  SYS.tables ST
	  JOIN @CheckTableNames chktbls
				ON chktbls.Tablename = ST.name 
	  JOIN SYS.schemas SCh
	    ON ST.schema_id = SCh.schema_id
	 WHERE ST.name <> 'SearchTMP'
      GROUP BY ST.object_id, SCh.name + '.' + ST.NAME ;

	  UPDATE @SQLTbl
		 SET SQLStatement = 'SELECT * INTO SearchTMP FROM ' + Tablename + ' WHERE ' + substring(WHEREClause,1,len(WHEREClause)-5)

	  DELETE FROM @SQLTbl
	   WHERE WHEREClause IS NULL
	
	WHILE EXISTS (SELECT 1 FROM @SQLTbl WHERE ISNULL(Execstatus ,0) = 0)
	BEGIN

		SELECT TOP 1 @tmpTblname = Tablename , @sql = SQLStatement
		  FROM @SQLTbl 
		 WHERE ISNULL(Execstatus ,0) = 0

		 

		 IF @GenerateSQLOnly = 0
		 BEGIN

			IF OBJECT_ID('SearchTMP','U') IS NOT NULL
				DROP TABLE SearchTMP
			EXEC (@SQL)

			IF EXISTS(SELECT 1 FROM SearchTMP)
			BEGIN
				SELECT Tablename=@tmpTblname,* FROM SearchTMP
			END

		 END
		 ELSE
		 BEGIN
			 PRINT REPLICATE('-',100)
			 PRINT @tmpTblname
			 PRINT REPLICATE('-',100)
			 PRINT replace(@sql,'INTO SearchTMP','')
		 END

		 UPDATE @SQLTbl
		    SET Execstatus = 1
		  WHERE Tablename = @tmpTblname

	END
	
	SET NOCOUNT OFF

go
