CREATE OR REPLACE PROCEDURE I2B2DEMODATA.INSERT_PATIENT_MAP_FROMTEMP(CHARACTER VARYING(ANY), NUMERIC(ANY))
RETURNS  CHARACTER VARYING(ANY)
 
LANGUAGE NZPLSQL AS
BEGIN_PROC
DECLARE
	tempPatientTableName ALIAS FOR $1;
	upload_id ALIAS FOR $2;
	
BEGIN
 
 
	--EXECUTE I2B2DEMODATA.INSERT_PATIENT_MAP_FROMTEMP('PATIENTMAP',10);
	--EXECUTE I2B2DEMODATA.INSERT_PATIENT_MAP_FROMTEMP('PATDIM',10);

 execute IMMEDIATE  'insert into I2B2DEMODATA.patient_mapping (patient_ide, patient_ide_source, patient_ide_status, patient_num, upload_id) (
				select distinct temp.patient_ide, temp.patient_ide_source,''A'',temp.patient_ide::numeric ,' || upload_id || '
				from ' || tempPatientTableName ||'  temp left outer join I2B2DEMODATA.patient_mapping pm
				on pm.patient_num = temp.patient_ide and pm.patient_ide_source = temp.patient_ide_source			
				where temp.patient_ide_source = ''HIVE'' 
				and pm.patient_num is null 
				and pm.patient_ide_source is null)'; 
	
	
  execute IMMEDIATE  'UPDATE I2B2DEMODATA.patient_dimension pd set 
			 VITAL_STATUS_CD= temp.VITAL_STATUS_CD,
			 BIRTH_DATE= temp.BIRTH_DATE,
			 DEATH_DATE= temp.DEATH_DATE,
			 SEX_CD= temp.SEX_CD,
			 AGE_IN_YEARS_NUM=temp.AGE_IN_YEARS_NUM,
			 LANGUAGE_CD=temp.LANGUAGE_CD,
			 RACE_CD=temp.RACE_CD,
			 MARITAL_STATUS_CD=temp.MARITAL_STATUS_CD,
			 RELIGION_CD=temp.RELIGION_CD,
			 ZIP_CD=temp.ZIP_CD,
			 STATECITYZIP_PATH =temp.STATECITYZIP_PATH,
			 PATIENT_BLOB=temp.PATIENT_BLOB,
			 UPDATE_DATE=temp.UPDATE_DATE,
			 DOWNLOAD_DATE=temp.DOWNLOAD_DATE,
			 SOURCESYSTEM_CD=temp.SOURCESYSTEM_CD,
			 UPLOAD_ID = '|| upload_id || '
			 from ' || tempPatientTableName || ' temp
			 where pd.patient_num = temp.patient_num
			 and temp.update_date > pd.update_date';
	
	
return 'Data inserted' ;

EXCEPTION
	WHEN OTHERS THEN
		RAISE NOTICE 'Exception Raised: %', SQLERRM;
END;
END_PROC;