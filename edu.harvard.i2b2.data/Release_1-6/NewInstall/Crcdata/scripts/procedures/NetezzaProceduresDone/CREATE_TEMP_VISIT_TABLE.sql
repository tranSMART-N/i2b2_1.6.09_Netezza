CREATE OR REPLACE PROCEDURE I2B2DEMODATA.CREATE_TEMP_VISIT_TABLE(CHARACTER VARYING(ANY))
RETURNS  CHARACTER VARYING(ANY)
 
LANGUAGE NZPLSQL AS
BEGIN_PROC

DECLARE
	tempTableName ALIAS FOR $1;
	
BEGIN

execute IMMEDIATE 'create table ' ||  tempTableName || ' (
		encounter_id 			VARCHAR(200) not null,
		encounter_id_source 	VARCHAR(50) not null, 
		patient_id  			VARCHAR(200) not null,
		patient_id_source 		VARCHAR(50) not null,
		encounter_num	 	    NUMERIC(38,0), 
		inout_cd   			    VARCHAR(50),
		location_cd 			VARCHAR(50),
		location_path 			VARCHAR(900),
 		start_date   			TIMESTAMP, 
 		end_date    			TIMESTAMP,
 		visit_blob 				varchar(60000),
 		update_date  			TIMESTAMP,
		download_date 			TIMESTAMP,
 		import_date 			TIMESTAMP,
		sourcesystem_cd 		VARCHAR(50)
	)';
  
return 'table created' ;

EXCEPTION
	WHEN OTHERS THEN
		RAISE NOTICE 'Exception Raised: %', SQLERRM;
END;
END_PROC;