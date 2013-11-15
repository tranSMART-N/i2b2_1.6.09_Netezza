
 --------------------------------------------------------
--  DDL for Table ONT_DB_LOOKUP
--------------------------------------------------------
 
 CREATE TABLE ONT_DB_LOOKUP ( 
   C_DOMAIN_ID      VARCHAR(255)   NOT NULL,
   C_PROJECT_PATH    VARCHAR(255)   NOT NULL, 
   C_OWNER_ID        VARCHAR(255)   NOT NULL, 
   C_DB_FULLSCHEMA   VARCHAR(255)   NOT NULL, 
   C_DB_DATASOURCE   VARCHAR(255)   NOT NULL, 
   C_DB_SERVERTYPE   VARCHAR(255)   NOT NULL, 
   C_DB_NICENAME     VARCHAR(255)   NULL,
   C_DB_TOOLTIP      VARCHAR(255)   NULL, 
   C_COMMENT         VARCHAR(4000)   NULL,
   C_ENTRY_DATE      DATE   NULL,
   C_CHANGE_DATE     DATE   NULL,
   C_STATUS_CD       CHAR(1)    NULL ,
     CONSTRAINT ONT_DB_LOOKUP_PK PRIMARY KEY(C_DOMAIN_ID,C_PROJECT_PATH,C_OWNER_ID)
   ) ;
   
--------------------------------------------------------
--  DDL for Table WORK_DB_LOOKUP
--------------------------------------------------------
   CREATE TABLE WORK_DB_LOOKUP ( 
   C_DOMAIN_ID      VARCHAR(255)   NOT NULL,
   C_PROJECT_PATH    VARCHAR(255)   NOT NULL, 
   C_OWNER_ID        VARCHAR(255)   NOT NULL, 
   C_DB_FULLSCHEMA   VARCHAR(255)   NOT NULL, 
   C_DB_DATASOURCE   VARCHAR(255)   NOT NULL, 
   C_DB_SERVERTYPE   VARCHAR(255)   NOT NULL, 
   C_DB_NICENAME     VARCHAR(255)   NULL,
   C_DB_TOOLTIP      VARCHAR(255)   NULL, 
   C_COMMENT         VARCHAR(4000)   NULL,
   C_ENTRY_DATE      DATE   NULL,
   C_CHANGE_DATE     DATE   NULL,
   C_STATUS_CD       CHAR(1)    NULL ,
     CONSTRAINT WORK_DB_LOOKUP_PK PRIMARY KEY(C_DOMAIN_ID,C_PROJECT_PATH,C_OWNER_ID) 
   )   ;

--------------------------------------------------------
--  DDL for Table CRC_DB_LOOKUP
--------------------------------------------------------
   
 CREATE TABLE CRC_DB_LOOKUP ( 
   C_DOMAIN_ID      VARCHAR(255)   NOT NULL,
   C_PROJECT_PATH    VARCHAR(255)   NOT NULL, 
   C_OWNER_ID        VARCHAR(255)   NOT NULL, 
   C_DB_FULLSCHEMA   VARCHAR(255)   NOT NULL, 
   C_DB_DATASOURCE   VARCHAR(255)   NOT NULL, 
   C_DB_SERVERTYPE   VARCHAR(255)   NOT NULL, 
   C_DB_NICENAME     VARCHAR(255)   NULL,
   C_DB_TOOLTIP      VARCHAR(255)   NULL, 
   C_COMMENT         VARCHAR(4000)   NULL,
   C_ENTRY_DATE      DATE   NULL,
   C_CHANGE_DATE     DATE   NULL,
   C_STATUS_CD       CHAR(1) NULL,
     CONSTRAINT CRC_DB_LOOKUP_PK PRIMARY KEY(C_DOMAIN_ID,C_PROJECT_PATH,C_OWNER_ID)
   ) ;

create table CRC_ANALYSIS_JOB (
   job_id VARCHAR(10) ,
   queue_name VARCHAR(50),
   status_type_id int, 
   domain_id varchar(255), 
   project_id varchar(500), 
   user_id varchar(255), 
   request_xml VARCHAR(4000),
   create_date date, 
   update_date date,
   CONSTRAINT ANALSIS_JOB_PK PRIMARY KEY(JOB_ID) 
) ; 