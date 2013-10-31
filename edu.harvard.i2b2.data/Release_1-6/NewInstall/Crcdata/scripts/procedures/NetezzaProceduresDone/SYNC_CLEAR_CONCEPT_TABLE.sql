CREATE OR REPLACE PROCEDURE I2B2DEMODATA.SYNC_CLEAR_CONCEPT_TABLE(CHARACTER VARYING(ANY), CHARACTER VARYING(ANY), NUMERIC(ANY))
RETURNS  CHARACTER VARYING(ANY)

LANGUAGE NZPLSQL AS
BEGIN_PROC
DECLARE
	tempConceptTableName ALIAS FOR $1;
	backupConceptTableName ALIAS FOR $2;
	uploadId ALIAS FOR $3;
	interConceptTableName  varchar(400);
	
BEGIN

	interConceptTableName := backupConceptTableName || '_inter';

	execute IMMEDIATE 'DELETE FROM ' || tempConceptTableName || ' t1 
	         WHERE ( rowid ) NOT IN  
					   (SELECT   max(rowid) FROM ' || tempConceptTableName || ' t2
					     GROUP BY  concept_path,concept_cd)';
						 
					 
	
 	execute IMMEDIATE 'create table ' ||  interConceptTableName || ' (
			CONCEPT_CD          VARCHAR(50) NOT NULL,
			CONCEPT_PATH    	VARCHAR(700) NOT NULL,
			NAME_CHAR       	VARCHAR(2000) NULL,
			CONCEPT_BLOB        VARCHAR (60000) NULL,
			UPDATE_DATE         TIMESTAMP NULL,
			DOWNLOAD_DATE       TIMESTAMP NULL,
			IMPORT_DATE         TIMESTAMP NULL,
			SOURCESYSTEM_CD     VARCHAR(50) NULL,
			UPLOAD_ID       	NUMERIC(38,0) NULL,
			CONSTRAINT '|| interConceptTableName ||'_pk  PRIMARY KEY(CONCEPT_PATH)
			)';
			
			
			execute immediate 'insert into '|| interConceptTableName ||'  (concept_cd,concept_path,name_char,concept_blob,update_date,download_date,import_date,sourcesystem_cd,upload_id)
			    select  concept_cd, substr(concept_path,1,700),
                        name_char,concept_blob,
                        update_date,download_date,
                        current_timestamp,sourcesystem_cd,
                         ' || uploadId || '  from ' || tempConceptTableName || '  temp ';
	
			
			
			
			execute immediate 'alter table  I2B2DEMODATA.concept_dimension rename to ' || backupConceptTableName  ||'' ;
			
			execute immediate  'alter table ' || interConceptTableName  || ' rename to concept_dimension' ;
	
			
return 'Data inserted' ;

EXCEPTION
	WHEN OTHERS THEN
		RAISE NOTICE 'Exception Raised: %', SQLERRM;
END;
END_PROC;
