CREATE OR REPLACE PROCEDURE I2B2DEMODATA.INSERT_ENCOUNTERVISIT_FROMTEMP(CHARACTER VARYING(ANY), NUMERIC(ANY))
RETURNS CHARACTER VARYING(ANY)
LANGUAGE NZPLSQL AS
BEGIN_PROC
DECLARE
	tempTableName ALIAS FOR $1;
	upload_id ALIAS FOR $2;
BEGIN

--EXECUTE I2B2DEMODATA.CREATE_TEMP_VISIT_TABLE('VISTABLE');

execute IMMEDIATE  'DELETE FROM ' || tempTableName || ' t1 
			  WHERE (rowid) NOT IN (
					SELECT  max(rowid) FROM ' || tempTableName || ' t2
					GROUP BY  encounter_id,encounter_id_source)';

LOCK TABLE  I2B2DEMODATA.encounter_mapping IN EXCLUSIVE MODE NOWAIT;


execute IMMEDIATE ' insert into I2B2DEMODATA.encounter_mapping (encounter_ide,encounter_ide_source,encounter_num,patient_ide,patient_ide_source,encounter_ide_status, upload_id) (
					select distinctTemp.encounter_id, distinctTemp.encounter_id_source, distinctTemp.encounter_id::numeric,  distinctTemp.patient_id,distinctTemp.patient_id_source,''A'',  '|| upload_id ||'
					from (
						select distinct encounter_id, encounter_id_source,patient_id,patient_id_source 
						from ' || tempTableName || ' temp left outer join I2B2DEMODATA.encounter_mapping em
						on em.encounter_ide = temp.encounter_id and em.encounter_ide_source = temp.encounter_id_source
						where em.encounter_ide_source is null
						and  em.encounter_ide is null
						and encounter_id_source = ''HIVE'' )   distinctTemp) ' ;



execute IMMEDIATE ' UPDATE ' ||  tempTableName || ' SET encounter_num = em.encounter_num
		     FROM I2B2DEMODATA.encounter_mapping em
		     WHERE em.encounter_ide = '|| tempTableName ||'.encounter_id
             and em.encounter_ide_source = '|| tempTableName ||'.encounter_id_source 
		     and coalesce(em.patient_ide_source,'''') = coalesce('|| tempTableName ||'.patient_id_source,'''')
		     and coalesce(em.patient_ide,'''')= coalesce('|| tempTableName ||'.patient_id,'''')
		     and EXISTS (
				SELECT em.encounter_num
				FROM I2B2DEMODATA.encounter_mapping em
				WHERE em.encounter_ide = '|| tempTableName ||'.encounter_id
				and em.encounter_ide_source = '||tempTableName||'.encounter_id_source
				and coalesce(em.patient_ide_source,'''') = coalesce('|| tempTableName ||'.patient_id_source,'''')
				and coalesce(em.patient_ide,'''')= coalesce('|| tempTableName ||'.patient_id,''''))';	
				
				
 execute IMMEDIATE 'UPDATE I2B2DEMODATA.visit_dimension vd set 
				inout_cd = temp.inout_cd,
				location_cd = temp.location_cd,
				location_path = temp.location_path,
				start_date = temp.start_date,
				end_date = temp.end_date,
				visit_blob = temp.visit_blob,
				update_date = temp.update_date,
				download_date = temp.download_date,
				import_date = now(),
				sourcesystem_cd = temp.sourcesystem_cd
				from ' || tempTableName || ' temp
				where vd.encounter_num = temp.encounter_num
				and temp.update_date >= vd.update_date';
			

execute IMMEDIATE 'insert into I2B2DEMODATA.visit_dimension (encounter_num,patient_num,START_DATE,END_DATE,INOUT_CD,LOCATION_CD,VISIT_BLOB,UPDATE_DATE,DOWNLOAD_DATE,IMPORT_DATE,SOURCESYSTEM_CD, UPLOAD_ID)
				select temp.encounter_num, pm.patient_num, temp.START_DATE,temp.END_DATE,temp.INOUT_CD,temp.LOCATION_CD,temp.VISIT_BLOB,
				temp.update_date, temp.download_date, current_timestamp,'|| upload_id ||'
				from ' || tempTableName || '  temp left outer join I2B2DEMODATA.patient_mapping pm  
				on	pm.patient_ide = temp.patient_id and pm.patient_ide_source = temp.patient_id_source
				left outer join I2B2DEMODATA.visit_dimension vd 
				on vd.encounter_num = temp.encounter_num
				where temp.encounter_num is not null 				
				and vd.encounter_num  is null'; 
		 
   		
return 'Data Inserted' ;

EXCEPTION
	WHEN OTHERS THEN
		RAISE NOTICE 'Exception Raised: %', SQLERRM;
END;
END_PROC;

