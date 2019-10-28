DROP TABLE OBJ_ROUTE CASCADE CONSTRAINTS PURGE;
CREATE TABLE OBJ_ROUTE 
(	SUB_ROUTE_ID 			VARCHAR2(60), 
	ROUTE_ID 				VARCHAR2(60), 
	ROUTE_NAME 				VARCHAR2(60), 
	BUS_COUNT 				NUMBER,
	BEGIN_DATE 				DATE,
	LINKMAN 				VARCHAR2(60), 
	ROUTE_GRADE 			VARCHAR2(60), 
	ROUTE_GRADE_MANUAL		VARCHAR2(60), 
	ROUTE_STYLE				VARCHAR2(20),
	ORG_ID 					VARCHAR2(60), 
	PARENT_ORG_ID 			VARCHAR2(60), 
	AREA_CODE 				VARCHAR2(60),
	END_DATE 				DATE,
	ISACTIVE 				VARCHAR2(10),
	ROUTE_TYPE 				VARCHAR2(60),
	IS_END_WITH_ALPHABET 	VARCHAR2(10),
	IS_SUBURBAN 			VARCHAR2(10),
	ORG_NAME 				VARCHAR2(200),
	ROUTE_LENGTH 			NUMBER,
	ORG_GROUP 				VARCHAR2(100),
	ORG_GROUP_ID			VARCHAR2(60)
) 
TABLESPACE TBS_OSECDJW_RPT
NOLOGGING;

CREATE INDEX OBJ_ROUTE_IDX1 ON OBJ_ROUTE (ROUTE_ID, SUB_ROUTE_ID) TABLESPACE TBS_OSECDJW_RPT NOLOGGING;


COMMENT ON TABLE OBJ_ROUTE  IS '线路数据查询';

COMMENT ON COLUMN OBJ_ROUTE.SUB_ROUTE_ID 		 	IS '子线';
COMMENT ON COLUMN OBJ_ROUTE.ROUTE_ID 			 	IS '线路ID';
COMMENT ON COLUMN OBJ_ROUTE.ROUTE_NAME 		 		IS '线路名称';	
COMMENT ON COLUMN OBJ_ROUTE.BUS_COUNT 		 		IS '运营车辆数';	
COMMENT ON COLUMN OBJ_ROUTE.BEGIN_DATE 		 		IS '开通日期';	
COMMENT ON COLUMN OBJ_ROUTE.LINKMAN 			 	IS '负责人';
COMMENT ON COLUMN OBJ_ROUTE.ROUTE_GRADE 		 	IS '线路级别';
COMMENT ON COLUMN OBJ_ROUTE.ROUTE_GRADE_MANUAL 		IS '线路级别-原始数据';
COMMENT ON COLUMN OBJ_ROUTE.ROUTE_STYLE 		 	IS '线路类型（1上下行，2环行）';
COMMENT ON COLUMN OBJ_ROUTE.ORG_ID 			 		IS '所属组织';	
COMMENT ON COLUMN OBJ_ROUTE.PARENT_ORG_ID 	 		IS '';	
COMMENT ON COLUMN OBJ_ROUTE.AREA_CODE 		 		IS '区域类型';	
COMMENT ON COLUMN OBJ_ROUTE.END_DATE 		 	 	IS '注销日期';	
COMMENT ON COLUMN OBJ_ROUTE.ISACTIVE  		 		IS '是否有效';	
COMMENT ON COLUMN OBJ_ROUTE.ROUTE_TYPE 	 	 		IS '线路类型';	
COMMENT ON COLUMN OBJ_ROUTE.IS_END_WITH_ALPHABET 	IS '是否字母结尾';	
COMMENT ON COLUMN OBJ_ROUTE.IS_SUBURBAN 		 	IS '是否二圈层进城线路';	
COMMENT ON COLUMN OBJ_ROUTE.ORG_NAME  		 		IS '是否有效';	




DROP TABLE OBJ_ROUTE_M CASCADE CONSTRAINTS PURGE;
CREATE TABLE OBJ_ROUTE_M
(	BUSINESS_DATE			DATE,
	SUB_ROUTE_ID 			VARCHAR2(60), 
	ROUTE_ID 				VARCHAR2(60), 
	ROUTE_NAME 				VARCHAR2(60), 
	BUS_COUNT 				NUMBER,
	BEGIN_DATE 				DATE,
	LINKMAN 				VARCHAR2(60), 
	ROUTE_GRADE 			VARCHAR2(60), 
	ROUTE_GRADE_MANUAL		VARCHAR2(60), 
	ROUTE_STYLE				VARCHAR2(20),
	ORG_ID 					VARCHAR2(60), 
	PARENT_ORG_ID 			VARCHAR2(60), 
	AREA_CODE 				VARCHAR2(60),
	END_DATE 				DATE,
	ISACTIVE 				VARCHAR2(10),
	ROUTE_TYPE 				VARCHAR2(60),
	IS_END_WITH_ALPHABET 	VARCHAR2(10),
	IS_SUBURBAN 			VARCHAR2(10),
	ORG_NAME 				VARCHAR2(200),
	ROUTE_LENGTH 			NUMBER,
	ORG_GROUP 				VARCHAR2(100),
	ORG_GROUP_ID			VARCHAR2(60)
) 
TABLESPACE TBS_OSECDJW_RPT
NOLOGGING;

CREATE INDEX OBJ_ROUTE_M_IDX1 ON OBJ_ROUTE_M (BUSINESS_DATE, ROUTE_ID, SUB_ROUTE_ID) TABLESPACE TBS_OSECDJW_RPT NOLOGGING;
