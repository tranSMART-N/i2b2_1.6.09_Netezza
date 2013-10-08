
--------------------------------------------------------
--  DDL for Table I2B2
--------------------------------------------------------

CREATE TABLE I2B2 (
      C_HLEVEL            NUMERIC(22,0)   NOT NULL, 
      C_FULLNAME         VARCHAR(700)   NOT NULL, 
      C_NAME            VARCHAR(2000)   NOT NULL, 
      C_SYNONYM_CD         CHAR(1)   NOT NULL, 
      C_VISUALATTRIBUTES   CHAR(3)   NOT NULL, 
      C_TOTALNUM         NUMERIC(22,0)   NULL, 
      C_BASECODE         VARCHAR(50)   NULL, 
      C_METADATAXML         VARCHAR(4000)   NULL, 
      C_FACTTABLECOLUMN      VARCHAR(50)   NOT NULL, 
      C_TABLENAME         VARCHAR(50)   NOT NULL, 
      C_COLUMNNAME         VARCHAR(50)   NOT NULL, 
      C_COLUMNDATATYPE      VARCHAR(50)   NOT NULL, 
      C_OPERATOR         VARCHAR(10)   NOT NULL, 
      C_DIMCODE            VARCHAR(700)   NOT NULL, 
      C_COMMENT            VARCHAR(4000)   NULL, 
      C_TOOLTIP            VARCHAR(900)   NULL, 
      M_APPLIED_PATH      VARCHAR(700)   NOT NULL, 
      UPDATE_DATE         DATE   NOT NULL, 
      DOWNLOAD_DATE         DATE   NULL, 
      IMPORT_DATE         DATE   NULL, 
      SOURCESYSTEM_CD      VARCHAR(50)   NULL, 
      VALUETYPE_CD         VARCHAR(50)   NULL,
      M_EXCLUSION_CD         VARCHAR(25) NULL,
      C_PATH            VARCHAR(700)   NULL,
      C_SYMBOL            VARCHAR(50)   NULL
)
;
CREATE INDEX META_FULLNAME_I2B2_IDX ON I2B2(C_FULLNAME)
;
CREATE INDEX META_APPLIED_PATH_I2B2_IDX ON I2B2(M_APPLIED_PATH)
;

--------------------------------------------------------
--  DDL for Table BIRN
--------------------------------------------------------

CREATE TABLE BIRN (
      C_HLEVEL            NUMERIC(22,0)   NOT NULL, 
      C_FULLNAME         VARCHAR(700)   NOT NULL, 
      C_NAME            VARCHAR(2000)   NOT NULL, 
      C_SYNONYM_CD         CHAR(1)   NOT NULL, 
      C_VISUALATTRIBUTES   CHAR(3)   NOT NULL, 
      C_TOTALNUM         NUMERIC(22,0)   NULL, 
      C_BASECODE         VARCHAR(50)   NULL, 
      C_METADATAXML         VARCHAR(4000)   NULL, 
      C_FACTTABLECOLUMN      VARCHAR(50)   NOT NULL, 
      C_TABLENAME         VARCHAR(50)   NOT NULL, 
      C_COLUMNNAME         VARCHAR(50)   NOT NULL, 
      C_COLUMNDATATYPE      VARCHAR(50)   NOT NULL, 
      C_OPERATOR         VARCHAR(10)   NOT NULL, 
      C_DIMCODE            VARCHAR(700)   NOT NULL, 
      C_COMMENT            VARCHAR(4000)   NULL, 
      C_TOOLTIP            VARCHAR(900)   NULL, 
      M_APPLIED_PATH      VARCHAR(700)   NOT NULL, 
      UPDATE_DATE         DATE   NOT NULL, 
      DOWNLOAD_DATE         DATE   NULL, 
      IMPORT_DATE         DATE   NULL, 
      SOURCESYSTEM_CD      VARCHAR(50)   NULL, 
      VALUETYPE_CD         VARCHAR(50)   NULL,
      M_EXCLUSION_CD         VARCHAR(25) NULL,
      C_PATH            VARCHAR(700)   NULL,
      C_SYMBOL            VARCHAR(50)   NULL
)
;
CREATE INDEX META_FULLNAME_BIRN_IDX ON BIRN(C_FULLNAME)
;
CREATE INDEX META_APPLIED_PATH_BIRN_IDX ON BIRN(M_APPLIED_PATH)
;

--------------------------------------------------------
--  DDL for Table SCHEMES
--------------------------------------------------------

CREATE TABLE SCHEMES (
         C_KEY         VARCHAR(50) NOT NULL,
      C_NAME      VARCHAR(50)   NOT NULL,
      C_DESCRIPTION   VARCHAR(100)   NULL,
    CONSTRAINT SCHEMES_PK PRIMARY KEY(C_KEY)
)
;


--------------------------------------------------------
--  DDL for Table TABLE_ACCESS
--------------------------------------------------------

CREATE TABLE TABLE_ACCESS (
      C_TABLE_CD         VARCHAR(50)   NOT NULL, 
      C_TABLE_NAME         VARCHAR(50)   NOT NULL, 
      C_PROTECTED_ACCESS   CHAR(1)   NULL,
      C_HLEVEL            NUMERIC(22,0)   NOT NULL, 
      C_FULLNAME         VARCHAR(700)   NOT NULL, 
      C_NAME            VARCHAR(2000)      NOT NULL, 
      C_SYNONYM_CD         CHAR(1)   NOT NULL, 
      C_VISUALATTRIBUTES   CHAR(3)   NOT NULL, 
      C_TOTALNUM         NUMERIC(22,0)   NULL, 
      C_BASECODE         VARCHAR(50)   NULL, 
      C_METADATAXML         VARCHAR(4000)   NULL, 
      C_FACTTABLECOLUMN      VARCHAR(50)   NOT NULL, 
      C_DIMTABLENAME      VARCHAR(50)   NOT NULL, 
      C_COLUMNNAME         VARCHAR(50)   NOT NULL, 
      C_COLUMNDATATYPE      VARCHAR(50)   NOT NULL, 
      C_OPERATOR         VARCHAR(10)   NOT NULL, 
      C_DIMCODE            VARCHAR(700)   NOT NULL, 
      C_COMMENT            VARCHAR(4000)   NULL, 
      C_TOOLTIP            VARCHAR(900)   NULL, 
      C_ENTRY_DATE         DATE   NULL, 
      C_CHANGE_DATE         DATE   NULL, 
      C_STATUS_CD         CHAR(1)   NULL,
      VALUETYPE_CD         VARCHAR(50)   NULL
   )
;


--------------------------------------------------------
--  DDL for Table CUSTOM_META
--------------------------------------------------------

CREATE TABLE CUSTOM_META ( 
      C_HLEVEL            NUMERIC(22,0)   NOT NULL, 
      C_FULLNAME         VARCHAR(700)   NOT NULL, 
      C_NAME            VARCHAR(2000)   NOT NULL, 
      C_SYNONYM_CD         CHAR(1)   NOT NULL, 
      C_VISUALATTRIBUTES   CHAR(3)   NOT NULL, 
      C_TOTALNUM         NUMERIC(22,0)   NULL, 
      C_BASECODE         VARCHAR(50)   NULL, 
      C_METADATAXML         VARCHAR(4000)   NULL, 
      C_FACTTABLECOLUMN      VARCHAR(50)   NOT NULL, 
      C_TABLENAME         VARCHAR(50)   NOT NULL, 
      C_COLUMNNAME         VARCHAR(50)   NOT NULL, 
      C_COLUMNDATATYPE      VARCHAR(50)   NOT NULL, 
      C_OPERATOR         VARCHAR(10)   NOT NULL, 
      C_DIMCODE            VARCHAR(700)   NOT NULL, 
      C_COMMENT            VARCHAR(4000)   NULL, 
      C_TOOLTIP            VARCHAR(900)   NULL, 
      M_APPLIED_PATH      VARCHAR(700)   NOT NULL, 
      UPDATE_DATE         DATE   NOT NULL, 
      DOWNLOAD_DATE         DATE   NULL, 
      IMPORT_DATE         DATE   NULL, 
      SOURCESYSTEM_CD      VARCHAR(50)   NULL, 
      VALUETYPE_CD         VARCHAR(50)   NULL,
      M_EXCLUSION_CD         VARCHAR(25) NULL,
      C_PATH            VARCHAR(700)   NULL,
      C_SYMBOL            VARCHAR(50)   NULL
)
;

CREATE INDEX META_FULLNAME_CUSTOM_IDX ON CUSTOM_META(C_FULLNAME)
;
CREATE INDEX META_APPLIED_PATH_CUSTOM_IDX ON CUSTOM_META(M_APPLIED_PATH)
;
--------------------------------------------------------
--  DDL for Table ONT_PROCESS_STATUS
--------------------------------------------------------
   
CREATE TABLE ONT_PROCESS_STATUS 
(
    PROCESS_ID         NUMERIC(5,0) , --PRIMARY KEY, 
    PROCESS_TYPE_CD      VARCHAR(50),
    START_DATE         DATE, 
    END_DATE         DATE,
    PROCESS_STEP_CD      VARCHAR(50),
    PROCESS_STATUS_CD   VARCHAR(50),
    CRC_UPLOAD_ID      NUMERIC(30,0),
    STATUS_CD         VARCHAR(50),
    MESSAGE         VARCHAR(4000),
    ENTRY_DATE         DATE,
    CHANGE_DATE         DATE,
    CHANGEDBY_CHAR      VARCHAR(50)
)
;

create sequence ONT_SQ_PS_PRID start with 1
; 

 