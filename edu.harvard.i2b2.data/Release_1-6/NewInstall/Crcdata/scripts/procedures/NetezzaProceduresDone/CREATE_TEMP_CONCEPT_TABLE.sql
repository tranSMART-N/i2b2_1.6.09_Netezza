CREATE OR REPLACE PROCEDURE I2B2DEMODATA.CREATE_TEMP_CONCEPT_TABLE(CHARACTER VARYING(ANY))
RETURNS CHARACTER VARYING(ANY)
LANGUAGE NZPLSQL AS
BEGIN_PROC
DECLARE
	tempconcepttablename ALIAS FOR $1;
BEGIN

execute immediate 'create table ' ||  tempConceptTableName || ' (
    CONCEPT_CD VARCHAR(50) NOT NULL, 
	CONCEPT_PATH VARCHAR(900) NOT NULL , 
	NAME_CHAR VARCHAR(2000),
	CONCEPT_BLOB varchar(60000),
	UPDATE_DATE timestamp, 
	DOWNLOAD_DATE timestamp, 
	IMPORT_DATE timestamp, 
	SOURCESYSTEM_CD VARCHAR(50)
	 )';	


/*execute immediate 'create table i2b2demodata.' ||  tempConceptTableName || ' (
        CONCEPT_CD VARCHAR(50) NOT NULL, 
	CONCEPT_PATH VARCHAR(900) NOT NULL , 
	NAME_CHAR VARCHAR(2000), 
	CONCEPT_BLOB varchar(64000), 
	UPDATE_DATE timestamp, 
	DOWNLOAD_DATE timestamp, 
	IMPORT_DATE timestamp, 
	SOURCESYSTEM_CD VARCHAR(50)
	 )';
*/

 -- execute 'CREATE INDEX idx_' || tempConceptTableName || '_pat_id ON ' || tempConceptTableName || '  (CONCEPT_PATH)';
return 'table created' ;

EXCEPTION
	WHEN OTHERS THEN
		RAISE NOTICE 'Exception Raised: %', SQLERRM;
END;
END_PROC;

