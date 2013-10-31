CREATE OR REPLACE PROCEDURE I2B2DEMODATA.INSERT_PROVIDER_FROMTEMP(CHARACTER VARYING(ANY), NUMERIC(ANY))
RETURNS  CHARACTER VARYING(ANY)
 
LANGUAGE NZPLSQL AS
BEGIN_PROC


DECLARE
	tempProviderTableName ALIAS FOR $1;
	upload_id ALIAS FOR $2;
	
BEGIN


	execute IMMEDIATE  'DELETE FROM ' || tempProviderTableName || ' t1 
			 WHERE ( rowid) NOT IN ( 
				SELECT  max(rowid)
				FROM ' || tempProviderTableName || ' t2
				GROUP BY  provider_path)';


  execute immediate 'UPDATE I2B2DEMODATA.patient_dimension set 
			IMPORT_DATE=now(),
			UPDATE_DATE=temp.UPDATE_DATE,
			DOWNLOAD_DATE=temp.DOWNLOAD_DATE,
			SOURCESYSTEM_CD=temp.SOURCESYSTEM_CD,
			UPLOAD_ID = '||  upload_id || '
			from I2B2DEMODATA.provider_dimension pd 
			inner join ' || tempProviderTableName || ' temp
			on  pd.provider_path = temp.provider_path
			where temp.update_date >= pd.update_date';



	execute immediate 'insert into I2B2DEMODATA.provider_dimension  (provider_id,provider_path,name_char,provider_blob,update_date,download_date,import_date,sourcesystem_cd,upload_id)
			    select  temp.provider_id,temp.provider_path, 
                        temp.name_char,temp.provider_blob,
                        temp.update_date,temp.download_date,
                        now(),temp.sourcesystem_cd, ' || upload_id || '	                    
                        from ' || tempProviderTableName || '  temp left outer join I2B2DEMODATA.provider_dimension pd 
						on pd.provider_path = temp.provider_path 
						where pd.provider_path is null';   
						


return 'Data inserted' ;

EXCEPTION
	WHEN OTHERS THEN
		RAISE NOTICE 'Exception Raised: %', SQLERRM;
END;
END_PROC;