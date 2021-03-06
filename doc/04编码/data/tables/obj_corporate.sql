DROP TABLE OBJ_CORPORATE CASCADE CONSTRAINTS PURGE;
CREATE TABLE OBJ_CORPORATE 
(	ORG_ID 					VARCHAR2(20), 
	ORG_NAME 				VARCHAR2(60), 
	LINKMAN 				VARCHAR2(20), 
	PRINCIPAL 				VARCHAR2(20), 
	EMP_COUNT 				NUMBER, 
	BUS_COUNT 				NUMBER, 
	ROUTE_COUNT 			NUMBER, 
	SITE_COUNT 				NUMBER, 
	DRIVER_COUNT 			NUMBER, 
	ADDRESS 				VARCHAR2(50),
	REGISTER_DATE			DATE,
	TELEPHONE 				VARCHAR2(20), 
	FAX 					VARCHAR2(20), 
	POST 					VARCHAR2(20), 
	PARENT_ORG_ID 			VARCHAR2(20), 
	REGION_AREA 			VARCHAR2(20), 
	AREA_CODE 				VARCHAR2(20), 
	PARENT_ORG_NAME 		VARCHAR2(60), 
	ORG_GRADE 				NUMBER,
	ORG_GROUP 				VARCHAR2(100),
	ORG_GROUP_ID 			VARCHAR2(60)
) 
TABLESPACE TBS_OSECDJW_RPT
NOLOGGING;


CREATE INDEX OBJ_CORPORATE_IDX1 ON OBJ_CORPORATE (ORG_ID) TABLESPACE TBS_OSECDJW_RPT NOLOGGING;

COMMENT ON TABLE OBJ_CORPORATE  IS '企业数据查询';

COMMENT ON COLUMN OBJ_CORPORATE.ORG_ID 			IS '组织ID';
COMMENT ON COLUMN OBJ_CORPORATE.ORG_NAME 		    IS '组织名称';
COMMENT ON COLUMN OBJ_CORPORATE.LINKMAN 		    IS '联系人';
COMMENT ON COLUMN OBJ_CORPORATE.PRINCIPAL 		    IS '负责人';
COMMENT ON COLUMN OBJ_CORPORATE.EMP_COUNT 		    IS '人员数量';
COMMENT ON COLUMN OBJ_CORPORATE.BUS_COUNT 		    IS '车辆数量';
COMMENT ON COLUMN OBJ_CORPORATE.ROUTE_COUNT 	    IS '线路数量';
COMMENT ON COLUMN OBJ_CORPORATE.SITE_COUNT 		IS '场站数量';
COMMENT ON COLUMN OBJ_CORPORATE.DRIVER_COUNT 	    IS '驾驶员数量';
COMMENT ON COLUMN OBJ_CORPORATE.ADDRESS 		    IS '组织地址';
COMMENT ON COLUMN OBJ_CORPORATE.REGISTER_DATE	    IS '注册时间';
COMMENT ON COLUMN OBJ_CORPORATE.TELEPHONE 		    IS '电话';
COMMENT ON COLUMN OBJ_CORPORATE.FAX 			    IS '传真';
COMMENT ON COLUMN OBJ_CORPORATE.POST 			    IS '邮编';
COMMENT ON COLUMN OBJ_CORPORATE.PARENT_ORG_ID 	    IS '上级组织';
COMMENT ON COLUMN OBJ_CORPORATE.REGION_AREA 	    IS '区域类型';
COMMENT ON COLUMN OBJ_CORPORATE.AREA_CODE 		    IS '所属区域';
COMMENT ON COLUMN OBJ_CORPORATE.PARENT_ORG_NAME    IS '上级组织';
COMMENT ON COLUMN OBJ_CORPORATE.ORG_GRADE 		    IS '组织级别';
COMMENT ON COLUMN OBJ_CORPORATE.ORG_GROUP 		    IS '区域名称';
COMMENT ON COLUMN OBJ_CORPORATE.ORG_GROUP_ID 		IS '区域ID';



DROP TABLE OBJ_CORPORATE_M CASCADE CONSTRAINTS PURGE;
CREATE TABLE OBJ_CORPORATE_M
(	BUSINESS_DATE			DATE,
	ORG_ID 					VARCHAR2(20), 
	ORG_NAME 				VARCHAR2(60), 
	LINKMAN 				VARCHAR2(20), 
	PRINCIPAL 				VARCHAR2(20), 
	EMP_COUNT 				NUMBER, 
	BUS_COUNT 				NUMBER, 
	ROUTE_COUNT 			NUMBER, 
	SITE_COUNT 				NUMBER, 
	DRIVER_COUNT 			NUMBER, 
	ADDRESS 				VARCHAR2(50),
	REGISTER_DATE			DATE,
	TELEPHONE 				VARCHAR2(20), 
	FAX 					VARCHAR2(20), 
	POST 					VARCHAR2(20), 
	PARENT_ORG_ID 			VARCHAR2(20), 
	REGION_AREA 			VARCHAR2(20), 
	AREA_CODE 				VARCHAR2(20), 
	PARENT_ORG_NAME 		VARCHAR2(60), 
	ORG_GRADE 				NUMBER,
	ORG_GROUP 				VARCHAR2(100),
	ORG_GROUP_ID 			VARCHAR2(60)
) 
TABLESPACE TBS_OSECDJW_RPT
NOLOGGING;


CREATE INDEX OBJ_CORPORATE_M_IDX1 ON OBJ_CORPORATE_M (BUSINESS_DATE,ORG_ID) TABLESPACE TBS_OSECDJW_RPT NOLOGGING;
