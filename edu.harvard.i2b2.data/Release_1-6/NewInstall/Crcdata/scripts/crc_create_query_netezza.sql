--==============================================================
-- Database Script to create CRC query tables                   
--                                                            
-- This script will create tables, indexes and sequences.        
-- User should have permission to create VARRAY type                                                                 
--==============================================================

--===========================================================================
-- Table: QT_QUERY_MASTER                                            
--============================================================================
CREATE TABLE QT_QUERY_MASTER (
   QUERY_MASTER_ID      NUMERIC(5,0) PRIMARY KEY,
   NAME            VARCHAR(250) NOT NULL,
   USER_ID            VARCHAR(50) NOT NULL,
   GROUP_ID         VARCHAR(50) NOT NULL,
   MASTER_TYPE_CD      VARCHAR(2000),
   PLUGIN_ID         NUMERIC(10,0),
   CREATE_DATE         DATE NOT NULL,
   DELETE_DATE         DATE,
   DELETE_FLAG         VARCHAR(3),
   GENERATED_SQL      VARCHAR(12000),
   REQUEST_XML         VARCHAR(12000),
   I2B2_REQUEST_XML   VARCHAR(12000)
)
;



--============================================================================
-- Table: QT_QUERY_RESULT_TYPE                                        
--============================================================================
CREATE TABLE QT_QUERY_RESULT_TYPE (
   RESULT_TYPE_ID            NUMERIC(3,0) PRIMARY KEY,
   NAME                  VARCHAR(100),
   DESCRIPTION               VARCHAR(200),
   DISPLAY_TYPE_ID            VARCHAR(500),
   VISUAL_ATTRIBUTE_TYPE_ID   VARCHAR(3)   
)
;


--============================================================================
-- Table: QT_QUERY_STATUS_TYPE                                        
--============================================================================
CREATE TABLE QT_QUERY_STATUS_TYPE (
   STATUS_TYPE_ID   NUMERIC(3,0) PRIMARY KEY,
   NAME         VARCHAR(100),
   DESCRIPTION      VARCHAR(200)
)
;


--============================================================================
-- Table: QT_QUERY_INSTANCE                                         
--============================================================================
CREATE TABLE QT_QUERY_INSTANCE (
   QUERY_INSTANCE_ID   NUMERIC(5,0) PRIMARY KEY,
   QUERY_MASTER_ID      NUMERIC(5,0),
   USER_ID            VARCHAR(50) NOT NULL,
   GROUP_ID         VARCHAR(50) NOT NULL,
   BATCH_MODE         VARCHAR(50),
   START_DATE         DATE NOT NULL,
   END_DATE         DATE,
   DELETE_FLAG         VARCHAR(3),
   STATUS_TYPE_ID      NUMERIC(5,0),
   MESSAGE            VARCHAR(4000),
   CONSTRAINT QT_FK_QI_MID FOREIGN KEY (QUERY_MASTER_ID)
      REFERENCES QT_QUERY_MASTER (QUERY_MASTER_ID),
   CONSTRAINT QT_FK_QI_STID FOREIGN KEY (STATUS_TYPE_ID)
      REFERENCES QT_QUERY_STATUS_TYPE (STATUS_TYPE_ID)
)
;


--=============================================================================
-- Table: QT_QUERY_RESULT_INSTANCE                                   
--============================================================================
CREATE TABLE QT_QUERY_RESULT_INSTANCE (
   RESULT_INSTANCE_ID   NUMERIC(5,0) PRIMARY KEY,
   QUERY_INSTANCE_ID   NUMERIC(5,0),
   RESULT_TYPE_ID      NUMERIC(3,0) NOT NULL,
   SET_SIZE         NUMERIC(10,0),
   START_DATE         DATE NOT NULL,
   END_DATE         DATE,
   DELETE_FLAG         VARCHAR(3),
   STATUS_TYPE_ID      NUMERIC(3,0) NOT NULL,
   MESSAGE            VARCHAR(4000),
   DESCRIPTION         VARCHAR(200),
   REAL_SET_SIZE      NUMERIC(10,0),
   OBFUSC_METHOD      VARCHAR(500),
   CONSTRAINT QT_FK_QRI_RID FOREIGN KEY (QUERY_INSTANCE_ID)
      REFERENCES QT_QUERY_INSTANCE (QUERY_INSTANCE_ID),
   CONSTRAINT QT_FK_QRI_RTID FOREIGN KEY (RESULT_TYPE_ID)
      REFERENCES QT_QUERY_RESULT_TYPE (RESULT_TYPE_ID),
   CONSTRAINT QT_FK_QRI_STID FOREIGN KEY (STATUS_TYPE_ID)
      REFERENCES QT_QUERY_STATUS_TYPE (STATUS_TYPE_ID)
)
;


--============================================================================
-- Table: QT_PATIENT_SET_COLLECTION                                    
--============================================================================
CREATE TABLE QT_PATIENT_SET_COLLECTION ( 
   PATIENT_SET_COLL_ID      NUMERIC(10,0) PRIMARY KEY,
   RESULT_INSTANCE_ID      NUMERIC(5,0),
   SET_INDEX            NUMERIC(10,0),
   PATIENT_NUM            NUMERIC(10,0),
   CONSTRAINT QT_FK_PSC_RI FOREIGN KEY (RESULT_INSTANCE_ID)
      REFERENCES QT_QUERY_RESULT_INSTANCE (RESULT_INSTANCE_ID)
)
;


--============================================================================
-- Table: QT_PATIENT_ENC_COLLECTION                                    
--============================================================================
CREATE TABLE QT_PATIENT_ENC_COLLECTION (
   PATIENT_ENC_COLL_ID      NUMERIC(10,0) PRIMARY KEY,
   RESULT_INSTANCE_ID      NUMERIC(5,0),
   SET_INDEX            NUMERIC(10,0),
   PATIENT_NUM            NUMERIC(10,0),
   ENCOUNTER_NUM         NUMERIC(10,0),
   CONSTRAINT QT_FK_PESC_RI FOREIGN KEY (RESULT_INSTANCE_ID)
      REFERENCES QT_QUERY_RESULT_INSTANCE(RESULT_INSTANCE_ID)
)
;


--============================================================================
-- Table: QT_XML_RESULT                                              
--============================================================================
CREATE TABLE QT_XML_RESULT (
   XML_RESULT_ID      NUMERIC(5,0) PRIMARY KEY,
   RESULT_INSTANCE_ID   NUMERIC(5,0),
   XML_VALUE         VARCHAR(12000),
   CONSTRAINT QT_FK_XMLR_RIID FOREIGN KEY (RESULT_INSTANCE_ID)
      REFERENCES QT_QUERY_RESULT_INSTANCE (RESULT_INSTANCE_ID)
)
;


--============================================================================
-- Table: QT_ANALYSIS_PLUGIN                                              
--============================================================================
CREATE TABLE QT_ANALYSIS_PLUGIN (
   PLUGIN_ID         NUMERIC(10,0) NOT NULL,
   PLUGIN_NAME         VARCHAR(2000),
   DESCRIPTION         VARCHAR(2000),
   VERSION_CD         VARCHAR(50),         --support for version
   PARAMETER_INFO      VARCHAR(4000),               -- plugin parameter stored as xml
   PARAMETER_INFO_XSD   VARCHAR(4000),
   COMMAND_LINE      VARCHAR(4000),
   WORKING_FOLDER      VARCHAR(4000),
   COMMANDOPTION_CD   VARCHAR(4000),
   PLUGIN_ICON         VARCHAR(4000),
   STATUS_CD         VARCHAR(50),         -- active,deleted,..
   USER_ID            VARCHAR(50),
   GROUP_ID         VARCHAR(50),
   CREATE_DATE         DATE,
   UPDATE_DATE         DATE,
   CONSTRAINT ANALYSIS_PLUGIN_PK PRIMARY KEY(PLUGIN_ID)
)
;


--============================================================================
-- Table: QT_ANALYSIS_PLUGIN_RESULT_TYPE                                           
--============================================================================
CREATE TABLE QT_ANALYSIS_PLUGIN_RESULT_TYPE (
   PLUGIN_ID      NUMERIC(10,0),
   RESULT_TYPE_ID   NUMERIC(10,0),
   CONSTRAINT ANALYSIS_PLUGIN_RESULT_PK PRIMARY KEY(PLUGIN_ID,RESULT_TYPE_ID)
)
;


--============================================================================
-- Table: QT_PDO_QUERY_MASTER                                           
--============================================================================
CREATE TABLE QT_PDO_QUERY_MASTER (
   QUERY_MASTER_ID      NUMERIC(5,0) PRIMARY KEY,
   USER_ID            VARCHAR(50) NOT NULL,
   GROUP_ID         VARCHAR(50) NOT NULL,
   CREATE_DATE         DATE NOT NULL,
   REQUEST_XML         VARCHAR(12000),
   I2B2_REQUEST_XML   VARCHAR(12000)
)
;


--============================================================================
-- Table: QT_PRIVILEGE                                           
--============================================================================
CREATE TABLE QT_PRIVILEGE (
   PROTECTION_LABEL_CD      VARCHAR(1500),
   DATAPROT_CD            VARCHAR(1000),
   HIVEMGMT_CD            VARCHAR(1000),
   PLUGIN_ID            NUMERIC(10,0)
)
;


--============================================================================
-- Table: QT_BREAKDOWN_PATH                                           
--============================================================================
CREATE TABLE QT_BREAKDOWN_PATH ( 
   NAME         VARCHAR(100),
   VALUE         VARCHAR(2000),
   CREATE_DATE      DATE,
   UPDATE_DATE      DATE,
   USER_ID         VARCHAR(50)
)
;


--============================================================================
-- CREATE GLOBALS
--============================================================================

-- DX
CREATE TEMPORARY TABLE DX  (
   ENCOUNTER_NUM   NUMERIC(22,0),
   PATIENT_NUM      NUMERIC(22,0)
 ) on COMMIT PRESERVE ROWS
;

-- QUERY_GLOBAL_TEMP
CREATE   TEMPORARY TABLE QUERY_GLOBAL_TEMP   ( 
   ENCOUNTER_NUM   NUMERIC(22,0),
   PATIENT_NUM      NUMERIC(22,0),
   INSTANCE_NUM   NUMERIC(18,0) ,
   CONCEPT_CD      VARCHAR(50),
   START_DATE       DATE,
   PROVIDER_ID     VARCHAR(50),
   PANEL_COUNT      NUMERIC(5,0),
   FACT_COUNT      NUMERIC(22,0),
   FACT_PANELS      NUMERIC(5,0)
 ) on COMMIT PRESERVE ROWS
;

-- GLOBAL_TEMP_PARAM_TABLE
 CREATE   TEMPORARY TABLE GLOBAL_TEMP_PARAM_TABLE   (
   SET_INDEX   INT,
   CHAR_PARAM1   VARCHAR(500),
   CHAR_PARAM2   VARCHAR(500),
   NUM_PARAM1   INT,
   NUM_PARAM2   INT
) ON COMMIT PRESERVE ROWS
;

-- GLOBAL_TEMP_FACT_PARAM_TABLE
CREATE   TEMPORARY TABLE GLOBAL_TEMP_FACT_PARAM_TABLE   (
   SET_INDEX   INT,
   CHAR_PARAM1   VARCHAR(500),
   CHAR_PARAM2   VARCHAR(500),
   NUM_PARAM1   INT,
   NUM_PARAM2   INT
) ON COMMIT PRESERVE ROWS
;

-- MASTER_QUERY_GLOBAL_TEMP
CREATE   TEMPORARY TABLE MASTER_QUERY_GLOBAL_TEMP    ( 
   ENCOUNTER_NUM   NUMERIC(22,0),
   PATIENT_NUM      NUMERIC(22,0),
   INSTANCE_NUM   NUMERIC(18,0) ,
   CONCEPT_CD      VARCHAR(50),
   START_DATE       DATE,
   PROVIDER_ID     VARCHAR(50),
   MASTER_ID      VARCHAR(50),
   LEVEL_NO      NUMERIC(5,0)
 ) ON COMMIT PRESERVE ROWS
;


--------------------------------------------------------
--SEQUENCE CREATION
--------------------------------------------------------

--QUERY MASTER SEQUENCE
CREATE SEQUENCE QT_SQ_QM_QMID START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999
    NO CYCLE;

--QUERY RESULT 
CREATE SEQUENCE QT_SQ_QR_QRID START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999
    NO CYCLE;

CREATE SEQUENCE QT_SQ_QS_QSID START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999
    NO CYCLE;

--QUERY INSTANCE SEQUENCE
CREATE SEQUENCE QT_SQ_QI_QIID START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999
    NO CYCLE;

--QUERY RESULT INSTANCE ID
CREATE SEQUENCE QT_SQ_QRI_QRIID START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999
    NO CYCLE;

--QUERY PATIENT SET RESULT COLLECTION ID
CREATE SEQUENCE QT_SQ_QPR_PCID START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999
    NO CYCLE;

--QUERY PATIENT ENCOUNTER SET RESULT COLLECTION ID
CREATE SEQUENCE QT_SQ_QPER_PECID START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999
    NO CYCLE;

--QUERY XML RESULT INSTANCE ID
CREATE SEQUENCE QT_SQ_QXR_XRID START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999
    NO CYCLE;

--QUERY PDO MASTER SEQUENCE
CREATE SEQUENCE QT_SQ_PQM_QMID START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999
    NO CYCLE;



--------------------------------------------------------
--INIT WITH SEED DATA
--------------------------------------------------------
insert into QT_QUERY_STATUS_TYPE(STATUS_TYPE_ID,NAME,DESCRIPTION) values(1,'QUEUED',' WAITING IN QUEUE TO START PROCESS')
;
insert into QT_QUERY_STATUS_TYPE(STATUS_TYPE_ID,NAME,DESCRIPTION) values(2,'PROCESSING','PROCESSING')
;
insert into QT_QUERY_STATUS_TYPE(STATUS_TYPE_ID,NAME,DESCRIPTION) values(3,'FINISHED','FINISHED')
;
insert into QT_QUERY_STATUS_TYPE(STATUS_TYPE_ID,NAME,DESCRIPTION) values(4,'ERROR','ERROR')
;
insert into QT_QUERY_STATUS_TYPE(STATUS_TYPE_ID,NAME,DESCRIPTION) values(5,'INCOMPLETE','INCOMPLETE')
;
insert into QT_QUERY_STATUS_TYPE(STATUS_TYPE_ID,NAME,DESCRIPTION) values(6,'COMPLETED','COMPLETED')
;
insert into QT_QUERY_STATUS_TYPE(STATUS_TYPE_ID,NAME,DESCRIPTION) values(7,'MEDIUM_QUEUE','MEDIUM QUEUE')
;
insert into QT_QUERY_STATUS_TYPE(STATUS_TYPE_ID,NAME,DESCRIPTION) values(8,'LARGE_QUEUE','LARGE QUEUE')
;
insert into QT_QUERY_STATUS_TYPE(STATUS_TYPE_ID,NAME,DESCRIPTION) values(9,'CANCELLED','CANCELLED')
;
insert into QT_QUERY_STATUS_TYPE(STATUS_TYPE_ID,NAME,DESCRIPTION) values(10,'TIMEDOUT','TIMEDOUT')
;


insert into QT_QUERY_RESULT_TYPE(RESULT_TYPE_ID,NAME,DESCRIPTION,DISPLAY_TYPE_ID,VISUAL_ATTRIBUTE_TYPE_ID) values(1,'PATIENTSET','Patient set','LIST','LA')
;
insert into QT_QUERY_RESULT_TYPE(RESULT_TYPE_ID,NAME,DESCRIPTION,DISPLAY_TYPE_ID,VISUAL_ATTRIBUTE_TYPE_ID) values(2,'PATIENT_ENCOUNTER_SET','Encounter set','LIST','LA')
;
insert into QT_QUERY_RESULT_TYPE(RESULT_TYPE_ID,NAME,DESCRIPTION,DISPLAY_TYPE_ID,VISUAL_ATTRIBUTE_TYPE_ID) values(3,'XML','Generic query result','CATNUM','LH')
;
insert into QT_QUERY_RESULT_TYPE(RESULT_TYPE_ID,NAME,DESCRIPTION,DISPLAY_TYPE_ID,VISUAL_ATTRIBUTE_TYPE_ID) values(4,'PATIENT_COUNT_XML','NUMERIC of patients','CATNUM','LA')
;
insert into QT_QUERY_RESULT_TYPE(RESULT_TYPE_ID,NAME,DESCRIPTION,DISPLAY_TYPE_ID,VISUAL_ATTRIBUTE_TYPE_ID) values(5,'PATIENT_GENDER_COUNT_XML','Gender patient breakdown','CATNUM','LA')
;
insert into QT_QUERY_RESULT_TYPE(RESULT_TYPE_ID,NAME,DESCRIPTION,DISPLAY_TYPE_ID,VISUAL_ATTRIBUTE_TYPE_ID) values(6,'PATIENT_VITALSTATUS_COUNT_XML','Vital Status patient breakdown','CATNUM','LA')
;
insert into QT_QUERY_RESULT_TYPE(RESULT_TYPE_ID,NAME,DESCRIPTION,DISPLAY_TYPE_ID,VISUAL_ATTRIBUTE_TYPE_ID) values(7,'PATIENT_RACE_COUNT_XML','Race patient breakdown','CATNUM','LA')
;
insert into QT_QUERY_RESULT_TYPE(RESULT_TYPE_ID,NAME,DESCRIPTION,DISPLAY_TYPE_ID,VISUAL_ATTRIBUTE_TYPE_ID) values(8,'PATIENT_AGE_COUNT_XML','Age patient breakdown','CATNUM','LA')
;
insert into QT_QUERY_RESULT_TYPE(RESULT_TYPE_ID,NAME,DESCRIPTION,DISPLAY_TYPE_ID,VISUAL_ATTRIBUTE_TYPE_ID) values(9,'PATIENTSET','Timeline','LIST','LA')
;


insert into QT_PRIVILEGE(PROTECTION_LABEL_CD, DATAPROT_CD, HIVEMGMT_CD) values ('PDO_WITHOUT_BLOB','DATA_LDS','USER')
;
insert into QT_PRIVILEGE(PROTECTION_LABEL_CD, DATAPROT_CD, HIVEMGMT_CD) values ('PDO_WITH_BLOB','DATA_DEID','USER')
;
insert into QT_PRIVILEGE(PROTECTION_LABEL_CD, DATAPROT_CD, HIVEMGMT_CD) values ('SETFINDER_QRY_WITH_DATAOBFSC','DATA_OBFSC','USER')
;
insert into QT_PRIVILEGE(PROTECTION_LABEL_CD, DATAPROT_CD, HIVEMGMT_CD) values ('SETFINDER_QRY_WITHOUT_DATAOBFSC','DATA_AGG','USER')
;
insert into QT_PRIVILEGE(PROTECTION_LABEL_CD, DATAPROT_CD, HIVEMGMT_CD) values ('UPLOAD','DATA_OBFSC','MANAGER')
;
insert into QT_PRIVILEGE(PROTECTION_LABEL_CD, DATAPROT_CD, HIVEMGMT_CD) values ('SETFINDER_QRY_WITHOUT_LGTEXT','DATA_LDS','USER')
;
insert into QT_PRIVILEGE(PROTECTION_LABEL_CD, DATAPROT_CD, HIVEMGMT_CD) values ('SETFINDER_QRY_WITH_LGTEXT','DATA_DEID','USER')
;


















