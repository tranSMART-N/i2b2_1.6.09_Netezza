CREATE OR REPLACE PROCEDURE I2B2DEMODATA.CREATE_TEMP_TABLE(CHARACTER VARYING(ANY))
RETURNS CHARACTER VARYING(ANY)
LANGUAGE NZPLSQL AS
BEGIN_PROC

DECLARE
	tempTableName ALIAS FOR $1;
	
BEGIN

  execute IMMEDIATE 'create table ' ||  tempTableName || '  (		
		encounter_id 		VARCHAR(200) not null, 
        encounter_id_source VARCHAR(50) not null,
		encounter_num  		NUMERIC(38,0),
		concept_cd 	 		VARCHAR(50) not null, 
        patient_num 		NUMERIC(38,0), 
		patient_id  		VARCHAR(200) not null,
        patient_id_source  	VARCHAR(50) not null,
		provider_id   		VARCHAR(50),
 		start_date   		TIMESTAMP, 
		modifier_cd 		VARCHAR(100),
	    instance_num 		NUMERIC(18,0),
 		valtype_cd 			VARCHAR(50),
		tval_char 			VARCHAR(255),
 		nval_num 			NUMERIC(18,5),
		valueflag_cd 		CHAR(50),
 		quantity_num 		NUMERIC(18,5),
		confidence_num 		NUMERIC(18,0),
 		observation_blob 	varchar(60000),
		units_cd 			VARCHAR(50),
 		end_date    		TIMESTAMP,
		location_cd 		VARCHAR(50),
 		update_date  		TIMESTAMP,
		download_date 		TIMESTAMP,
 		import_date 		TIMESTAMP,
		sourcesystem_cd 	VARCHAR(50) ,
 		upload_id 			INTEGER
	)';

return 'table created' ;

EXCEPTION
	WHEN OTHERS THEN
		RAISE NOTICE 'Exception Raised: %', SQLERRM;
END;
END_PROC;

