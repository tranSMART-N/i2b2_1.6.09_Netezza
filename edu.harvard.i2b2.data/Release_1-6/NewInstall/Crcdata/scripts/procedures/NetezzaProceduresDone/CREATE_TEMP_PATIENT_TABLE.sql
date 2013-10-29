CREATE OR REPLACE PROCEDURE I2B2DEMODATA.CREATE_TEMP_PATIENT_TABLE(CHARACTER VARYING(ANY))
RETURNS CHARACTER VARYING(ANY)
LANGUAGE NZPLSQL AS
BEGIN_PROC

DECLARE
	tempPatientDimensionTableName ALIAS FOR $1;
BEGIN

execute IMMEDIATE 'create table ' ||  tempPatientDimensionTableName || ' (
		PATIENT_ID VARCHAR(200), 
		PATIENT_ID_SOURCE VARCHAR(50),
		PATIENT_NUM NUMERIC(38,0),
	    VITAL_STATUS_CD VARCHAR(50), 
	    BIRTH_DATE TIMESTAMP, 
	    DEATH_DATE TIMESTAMP, 
	    SEX_CD CHAR(50), 
	    AGE_IN_YEARS_NUM NUMERIC(5,0), 
	    LANGUAGE_CD VARCHAR(50), 
		RACE_CD VARCHAR(50 ), 
		MARITAL_STATUS_CD VARCHAR(50), 
		RELIGION_CD VARCHAR(50), 
		ZIP_CD VARCHAR(50), 
		STATECITYZIP_PATH VARCHAR(700), 
		PATIENT_BLOB VARCHAR(60000), 
		UPDATE_DATE TIMESTAMP, 
		DOWNLOAD_DATE TIMESTAMP, 
		IMPORT_DATE TIMESTAMP, 
		SOURCESYSTEM_CD VARCHAR(50)
	)';
	
return 'table created' ;

EXCEPTION
	WHEN OTHERS THEN
		RAISE NOTICE 'Exception Raised: %', SQLERRM;
END;
END_PROC;
