CREATE OR REPLACE PROCEDURE I2B2DEMODATA.INSERT_CONCEPT_FROMTEMP(CHARACTER VARYING(ANY), NUMERIC(ANY))
RETURNS CHARACTER VARYING(ANY)
LANGUAGE NZPLSQL AS
BEGIN_PROC

DECLARE
	tempConceptTableName ALIAS FOR $1;
	upload_id ALIAS FOR $2;
	
BEGIN
		--CREATE TABLE BY RUNNING THE SCRIPT BELOW
		--EXECUTE I2B2DEMODATA.CREATE_TEMP_CONCEPT_TABLE('TESTDB123');

  execute IMMEDIATE 'DELETE FROM ' || tempConceptTableName || ' t1 WHERE ( rowid) not in ( 
			       SELECT   max(rowid) FROM ' || tempConceptTableName || ' t2
			       group by concept_path,concept_cd)';
	 
  execute IMMEDIATE 'UPDATE I2B2DEMODATA.concept_dimension cd set 
				name_char= temp.name_char,
				concept_blob= temp.concept_blob,
				update_date= temp.update_date,
				import_date = now(),
				DOWNLOAD_DATE=temp.DOWNLOAD_DATE,
				SOURCESYSTEM_CD=temp.SOURCESYSTEM_CD,
				UPLOAD_ID = '|| upload_id || '
				from ' || tempConceptTableName || ' temp
				where cd.concept_path = temp.concept_path
				and temp.update_date >= cd.update_date';
				
  execute IMMEDIATE 'insert into I2B2DEMODATA.concept_dimension  (concept_cd,concept_path,name_char,concept_blob,update_date,download_date,import_date,sourcesystem_cd,upload_id)
			    select  temp.concept_cd, temp.concept_path, temp.name_char,temp.concept_blob, temp.update_date,temp.download_date, current_timestamp,temp.sourcesystem_cd, ' || upload_id || '  
				from ' || tempConceptTableName || '  temp left outer join I2B2DEMODATA.concept_dimension cd
				on cd.concept_path = temp.concept_path
				where cd.concept_path is null';
				
				
return 'Data Inserted' ;

EXCEPTION
	WHEN OTHERS THEN
		RAISE NOTICE 'Exception Raised: %', SQLERRM;
END;
END_PROC;

