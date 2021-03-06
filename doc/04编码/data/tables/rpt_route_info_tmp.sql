DROP TABLE RPT_ROUTE_INFO_TMP CASCADE CONSTRAINTS PURGE;
CREATE TABLE RPT_ROUTE_INFO_TMP 
(	BUSINESS_DATE		DATE,
	AREA_CODE			VARCHAR2(60),
	ORG_GROUP			VARCHAR2(60),
	ORG_GROUP_ID		VARCHAR2(60),
	ROUTE_ID			VARCHAR2(60),
	ROUTE_NAME			VARCHAR2(300),
	PLAN_DIS_COUNT		NUMBER, 
	ACT_DIS_COUNT		NUMBER, 
	BUS_COUNT 			NUMBER, 
	OP_MILE				NUMBER, 
	PASSFLOW			NUMBER, 
	FIRST_DISPATCH		DATE,
	LAST_DISPATCH		DATE,
	FL_ONTIME_RATIO		NUMBER, 
	ROUTE_ONTIME_RATIO	NUMBER, 
	OP_QTY				NUMBER, 
	OP_DATE				DATE
) 
TABLESPACE TBS_OSECDJW_RPT
NOLOGGING;

CREATE INDEX RPT_ROUTE_INFO_TMP_IDX1 ON RPT_ROUTE_INFO_TMP (BUSINESS_DATE) TABLESPACE TBS_OSECDJW_RPT NOLOGGING;

 
COMMENT ON TABLE RPT_ROUTE_INFO_TMP  IS '线路信息查询-临时用';

COMMENT ON COLUMN RPT_ROUTE_INFO_TMP.BUSINESS_DATE		IS '日期时间';
COMMENT ON COLUMN RPT_ROUTE_INFO_TMP.AREA_CODE			IS '区域';
COMMENT ON COLUMN RPT_ROUTE_INFO_TMP.ORG_GROUP			IS '公司';
COMMENT ON COLUMN RPT_ROUTE_INFO_TMP.ORG_GROUP_ID		IS '公司id';
COMMENT ON COLUMN RPT_ROUTE_INFO_TMP.ROUTE_ID			IS '线路ID';
COMMENT ON COLUMN RPT_ROUTE_INFO_TMP.ROUTE_NAME			IS '线路名称';
COMMENT ON COLUMN RPT_ROUTE_INFO_TMP.PLAN_DIS_COUNT		IS '计划班次';
COMMENT ON COLUMN RPT_ROUTE_INFO_TMP.ACT_DIS_COUNT		IS '配车数';
COMMENT ON COLUMN RPT_ROUTE_INFO_TMP.BUS_COUNT 			IS '实际班次';
COMMENT ON COLUMN RPT_ROUTE_INFO_TMP.OP_MILE			IS '运营里程';
COMMENT ON COLUMN RPT_ROUTE_INFO_TMP.PASSFLOW			IS '客运量';
COMMENT ON COLUMN RPT_ROUTE_INFO_TMP.FIRST_DISPATCH		IS '发车时间';
COMMENT ON COLUMN RPT_ROUTE_INFO_TMP.LAST_DISPATCH		IS '收车时间';
COMMENT ON COLUMN RPT_ROUTE_INFO_TMP.FL_ONTIME_RATIO	IS '首末班准点率';
COMMENT ON COLUMN RPT_ROUTE_INFO_TMP.ROUTE_ONTIME_RATIO	IS '线路准点率';
COMMENT ON COLUMN RPT_ROUTE_INFO_TMP.OP_QTY				IS '运营车辆数';
COMMENT ON COLUMN RPT_ROUTE_INFO_TMP.OP_DATE	        IS '日期';

