CREATE OR REPLACE PROCEDURE I2B2DEMODATA.INSERT_MODIFIER_FROMTEMP(CHARACTER VARYING(ANY), NUMERIC(ANY))
RETURNS  CHARACTER VARYING(ANY)
 
LANGUAGE NZPLSQL AS
BEGIN_PROC
DECLARE
	tempModifierTableName ALIAS FOR $1;
	upload_id ALIAS FOR $2;
BEGIN



	--CREATE TABLE MODDIM ( 
   --MODIFIER_PATH      VARCHAR(700) NOT NULL,
   --MODIFIER_CD        VARCHAR(50) NULL,
   --NAME_CHAR            VARCHAR(2000) NULL,
   --MODIFIER_BLOB      VARCHAR(4000) NULL,
   --UPDATE_DATE          DATE NULL,
   --DOWNLOAD_DATE        DATE NULL,
   --IMPORT_DATE          DATE NULL,
   --SOURCESYSTEM_CD      VARCHAR(50) NULL,
   -- UPLOAD_ID         NUMERIC (38,0) NULL,
    --CONSTRAINT MODIFIER_DIMENSION_PK PRIMARY KEY(modifier_path)   );
 
--EXECUTE I2B2DEMODATA.INSERT_MODIFIER_FROMTEMP('MODDIM',10);



execute IMMEDIATE  'DELETE FROM ' || tempModifierTableName || ' t1 WHERE ( rowid) NOT IN  
			   (SELECT   max(rowid) FROM ' || tempModifierTableName || ' t2
				GROUP BY  modifier_path,modifier_cd)';
					

execute IMMEDIATE 'UPDATE I2B2DEMODATA.modifier_dimension cd set 
			name_char= temp.name_char,
			modifier_blob= temp.modifier_blob,
			update_date= temp.update_date,
			import_date = now(),
			DOWNLOAD_DATE=temp.DOWNLOAD_DATE,
			SOURCESYSTEM_CD=temp.SOURCESYSTEM_CD,
			UPLOAD_ID = '|| upload_id || '
			from ' || tempModifierTableName || ' temp
			where cd.modifier_path = temp.modifier_path
			and temp.update_date >= cd.update_date';


execute  IMMEDIATE 'insert into I2B2DEMODATA.modifier_dimension  (modifier_cd,modifier_path,name_char,modifier_blob,update_date,download_date,import_date,sourcesystem_cd,upload_id)
			    select  modifier_cd, modifier_path, name_char,modifier_blob, update_date,download_date, current_timestamp, sourcesystem_cd,' || upload_id || '  
					from ' || tempModifierTableName || '  temp left outer join I2B2DEMODATA.modifier_dimension cd
					on cd.modifier_path = temp.modifier_path 
					where cd.modifier_path is null)';

return 'Data Inserted' ;

EXCEPTION
	WHEN OTHERS THEN
		RAISE NOTICE 'Exception Raised: %', SQLERRM;
END;
END_PROC;
