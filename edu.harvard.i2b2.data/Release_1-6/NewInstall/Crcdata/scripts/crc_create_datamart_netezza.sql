--*********************************************************
--         ORACLE SCRIPT TO CREATE DATA TABLES
--           SNM - 8/19/2008
--**********************************************************

-----------------------------------------------------------------------------------------
-- create ENCOUNTER_MAPPING table with clustered PK on ENCOUNTER_IDE, ENCOUNTER_IDE_SOURCE 
-----------------------------------------------------------------------------------------

CREATE TABLE ENCOUNTER_MAPPING ( 
    ENCOUNTER_IDE          VARCHAR(200) NOT NULL,
    ENCOUNTER_IDE_SOURCE   VARCHAR(50) NOT NULL,
    ENCOUNTER_NUM          NUMERIC(38,0) NOT NULL,
    PATIENT_IDE            VARCHAR(200),
    PATIENT_IDE_SOURCE     VARCHAR(50),
    ENCOUNTER_IDE_STATUS   VARCHAR(50),
    UPLOAD_DATE            DATE,
    UPDATE_DATE             DATE,
    DOWNLOAD_DATE          DATE,
   IMPORT_DATE             DATE,
    SOURCESYSTEM_CD        VARCHAR(50),
   UPLOAD_ID              NUMERIC(38,0),
    CONSTRAINT ENCOUNTER_MAPPING_PK PRIMARY KEY(ENCOUNTER_IDE,ENCOUNTER_IDE_SOURCE)
 )
;


-------------------------------------------------------------------------------------
-- create PATIENT_MAPPING table with clustered PK on PATIENT_IDE, PATIENT_IDE_SOURCE
-------------------------------------------------------------------------------------

CREATE TABLE PATIENT_MAPPING ( 
    PATIENT_IDE          VARCHAR(200) NOT NULL,
    PATIENT_IDE_SOURCE   VARCHAR(50) NOT NULL,
    PATIENT_NUM          NUMERIC(38,0) NOT NULL,
    PATIENT_IDE_STATUS   VARCHAR(50),
    UPLOAD_DATE          DATE,
    UPDATE_DATE         DATE,
    DOWNLOAD_DATE        DATE,
    IMPORT_DATE         DATE,
    SOURCESYSTEM_CD      VARCHAR(50),
    UPLOAD_ID            NUMERIC(38,0),
    CONSTRAINT PATIENT_MAPPING_PK PRIMARY KEY(PATIENT_IDE,PATIENT_IDE_SOURCE)
 )
;


------------------------------------------------------------------------------
-- create CODE_LOOKUP table with clustered PK on TABLE_CD, COLUMN_CD, CODE_CD 
------------------------------------------------------------------------------

CREATE TABLE CODE_LOOKUP ( 
   TABLE_CD            VARCHAR(100) NOT NULL,
   COLUMN_CD           VARCHAR(100) NOT NULL,
   CODE_CD             VARCHAR(50) NOT NULL,
   NAME_CHAR           VARCHAR(650) NULL,
   LOOKUP_BLOB         VARCHAR(4000),
    UPLOAD_DATE          DATE NULL,
    UPDATE_DATE        DATE NULL,
   DOWNLOAD_DATE      DATE NULL,
   IMPORT_DATE        DATE NULL,
   SOURCESYSTEM_CD    VARCHAR(50) NULL,
   UPLOAD_ID          NUMERIC(38,0) NULL,
    CONSTRAINT CODE_LOOKUP_PK PRIMARY KEY(TABLE_CD,COLUMN_CD,CODE_CD)
   )
;



--------------------------------------------------------------------
-- create CONCEPT_DIMENSION table with clustered PK on CONCEPT_PATH 
--------------------------------------------------------------------

CREATE TABLE CONCEPT_DIMENSION ( 
   CONCEPT_PATH       VARCHAR(700) NOT NULL,
   CONCEPT_CD          VARCHAR(50) NOT NULL,
   NAME_CHAR          VARCHAR(2000) NULL,
   CONCEPT_BLOB        VARCHAR(4000) NULL,
   UPDATE_DATE         DATE NULL,
   DOWNLOAD_DATE       DATE NULL,
   IMPORT_DATE         DATE NULL,
   SOURCESYSTEM_CD     VARCHAR(50) NULL,
   UPLOAD_ID          NUMERIC(38,0) NULL,
    CONSTRAINT CONCEPT_DIMENSION_PK PRIMARY KEY(CONCEPT_PATH)
   )
;   


----------------------------------------------------------------------------------
--        create OBSERVATION_FACT table with NONclustered PK on
-- ENCOUNTER_NUM, CONCEPT_CD, PROVIDER_ID, START_DATE, MODIFIER_CD, INSTANCE_NUM 
----------------------------------------------------------------------------------

CREATE TABLE OBSERVATION_FACT (
   ENCOUNTER_NUM      NUMERIC(38,0) NOT NULL,
   PATIENT_NUM        NUMERIC(38,0) NOT NULL,
   CONCEPT_CD         VARCHAR(50) NOT NULL,
   PROVIDER_ID        VARCHAR(50) NOT NULL,
   START_DATE         DATE NOT NULL,
   MODIFIER_CD        VARCHAR(100) NOT NULL,
   INSTANCE_NUM       NUMERIC(18,0) NOT NULL,
   VALTYPE_CD         VARCHAR(50) NULL,
   TVAL_CHAR          VARCHAR(255) NULL,
   NVAL_NUM           NUMERIC(18,5) NULL,
   VALUEFLAG_CD       VARCHAR(50) NULL,
   QUANTITY_NUM       NUMERIC(18,5) NULL,
   UNITS_CD           VARCHAR(50) NULL,
   END_DATE           DATE NULL,
   LOCATION_CD        VARCHAR(50) NULL,
   OBSERVATION_BLOB   VARCHAR(4000) NULL,
   CONFIDENCE_NUM     NUMERIC(18,5) NULL,
   UPDATE_DATE        DATE NULL,
   DOWNLOAD_DATE      DATE NULL,
   IMPORT_DATE        DATE NULL,
   SOURCESYSTEM_CD    VARCHAR(50) NULL,
   UPLOAD_ID          NUMERIC(38,0) NULL, 
    CONSTRAINT OBSERVATION_FACT_PK PRIMARY KEY(ENCOUNTER_NUM,CONCEPT_CD,PROVIDER_ID,START_DATE,MODIFIER_CD,INSTANCE_NUM)
)
;




-------------------------------------------------------------------
-- create PATIENT_DIMENSION table with clustered PK on PATIENT_NUM 
-------------------------------------------------------------------

CREATE TABLE PATIENT_DIMENSION ( 
   PATIENT_NUM         NUMERIC(38,0) NOT NULL,
   VITAL_STATUS_CD     VARCHAR(50) NULL,
   BIRTH_DATE          DATE NULL,
   DEATH_DATE          DATE NULL,
   SEX_CD              VARCHAR(50) NULL,
   AGE_IN_YEARS_NUM    NUMERIC(38,0) NULL,
   LANGUAGE_CD         VARCHAR(50) NULL,
   RACE_CD             VARCHAR(50) NULL,
   MARITAL_STATUS_CD   VARCHAR(50) NULL,
   RELIGION_CD         VARCHAR(50) NULL,
   ZIP_CD              VARCHAR(10) NULL,
   STATECITYZIP_PATH   VARCHAR(700) NULL,
   INCOME_CD         VARCHAR(50) NULL,
   PATIENT_BLOB        VARCHAR(4000) NULL,
   UPDATE_DATE         DATE NULL,
   DOWNLOAD_DATE       DATE NULL,
   IMPORT_DATE         DATE NULL,
   SOURCESYSTEM_CD     VARCHAR(50) NULL,
   UPLOAD_ID           NUMERIC(38,0) NULL,
    CONSTRAINT PATIENT_DIMENSION_PK PRIMARY KEY(PATIENT_NUM)
   )
;


-----------------------------------------------------------------------------------
-- create PROVIDER_DIMENSION table with clustered PK on PROVIDER_PATH, PROVIDER_ID 
-----------------------------------------------------------------------------------

CREATE TABLE PROVIDER_DIMENSION ( 
   PROVIDER_ID         VARCHAR(50) NOT NULL,
   PROVIDER_PATH       VARCHAR(700) NOT NULL,
   NAME_CHAR          VARCHAR(850) NULL,
   PROVIDER_BLOB       VARCHAR(4000) NULL,
   UPDATE_DATE        DATE NULL,
   DOWNLOAD_DATE       DATE NULL,
   IMPORT_DATE         DATE NULL,
   SOURCESYSTEM_CD     VARCHAR(50) NULL,
   UPLOAD_ID           NUMERIC(38,0) NULL,
    CONSTRAINT  PROVIDER_DIMENSION_PK PRIMARY KEY(PROVIDER_PATH,PROVIDER_ID)
   )
;


-------------------------------------------------------------------
-- create VISIT_DIMENSION table with clustered PK on ENCOUNTER_NUM 
-------------------------------------------------------------------

CREATE TABLE VISIT_DIMENSION ( 
   ENCOUNTER_NUM       NUMERIC(38,0) NOT NULL,
   PATIENT_NUM         NUMERIC(38,0) NOT NULL,
    ACTIVE_STATUS_CD    VARCHAR(50) NULL,
   START_DATE          DATE NULL,
   END_DATE            DATE NULL,
   INOUT_CD            VARCHAR(50) NULL,
   LOCATION_CD         VARCHAR(50) NULL,
   LOCATION_PATH         VARCHAR(900) NULL,
   LENGTH_OF_STAY      NUMERIC(38,0) NULL,
   VISIT_BLOB         VARCHAR(4000) NULL,
   UPDATE_DATE         DATE NULL,
   DOWNLOAD_DATE       DATE NULL,
   IMPORT_DATE         DATE NULL,
   SOURCESYSTEM_CD     VARCHAR(50) NULL,
   UPLOAD_ID          NUMERIC(38,0) NULL, 
    CONSTRAINT  VISIT_DIMENSION_PK PRIMARY KEY(ENCOUNTER_NUM,PATIENT_NUM)
   )
;



------------------------------------------------------------
-- create MODIFIER_DIMENSION table with PK on MODIFIER_PATH 
------------------------------------------------------------

CREATE TABLE MODIFIER_DIMENSION ( 
   MODIFIER_PATH      VARCHAR(700) NOT NULL,
   MODIFIER_CD        VARCHAR(50) NULL,
   NAME_CHAR            VARCHAR(2000) NULL,
   MODIFIER_BLOB      VARCHAR(4000) NULL,
   UPDATE_DATE          DATE NULL,
   DOWNLOAD_DATE        DATE NULL,
   IMPORT_DATE          DATE NULL,
   SOURCESYSTEM_CD      VARCHAR(50) NULL,
    UPLOAD_ID         NUMERIC (38,0) NULL,
    CONSTRAINT MODIFIER_DIMENSION_PK PRIMARY KEY(modifier_path)
   )
;
