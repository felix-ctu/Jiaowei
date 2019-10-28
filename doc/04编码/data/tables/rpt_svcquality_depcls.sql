DROP TABLE RPT_SVCQUALITY_DEPCLS CASCADE CONSTRAINTS PURGE;
CREATE TABLE RPT_SVCQUALITY_DEPCLS 
(	BUSINESS_DATE			DATE,
	RUN_DATE				DATE, 
	DEPCLS_TYPE				VARCHAR2(20),
	START_TIME				VARCHAR2(30), 
	END_TIME				VARCHAR2(30), 
	ROUTE_COUNT				NUMBER, 
	AREA_CODE				VARCHAR2(60), 
	ORG_GROUP				VARCHAR2(60),
	ORG_GROUP_ID			VARCHAR2(60)
) 
TABLESPACE TBS_OSECDJW_RPT
NOLOGGING;

CREATE INDEX RPT_SVCQUALITY_DEPCLS_IDX1 ON RPT_SVCQUALITY_DEPCLS (RUN_DATE) TABLESPACE TBS_OSECDJW_RPT NOLOGGING;

 
COMMENT ON TABLE RPT_SVCQUALITY_DEPCLS  IS '服务质量-发车收车时间分析';

COMMENT ON COLUMN RPT_SVCQUALITY_DEPCLS.RUN_DATE			IS '查询日期';
COMMENT ON COLUMN RPT_SVCQUALITY_DEPCLS.DEPCLS_TYPE			IS '发车/收车类型';
COMMENT ON COLUMN RPT_SVCQUALITY_DEPCLS.START_TIME			IS '时段开始时间';
COMMENT ON COLUMN RPT_SVCQUALITY_DEPCLS.END_TIME			IS '时段结束时间';
COMMENT ON COLUMN RPT_SVCQUALITY_DEPCLS.ROUTE_COUNT			IS '线路条数';
COMMENT ON COLUMN RPT_SVCQUALITY_DEPCLS.AREA_CODE			IS '区域类型';
COMMENT ON COLUMN RPT_SVCQUALITY_DEPCLS.ORG_GROUP			IS '区域名称';
COMMENT ON COLUMN RPT_SVCQUALITY_DEPCLS.ORG_GROUP_ID		IS '区域ID';