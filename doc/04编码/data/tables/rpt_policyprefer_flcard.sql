DROP TABLE RPT_POLICYPREFER_FLCARD CASCADE CONSTRAINTS PURGE;
CREATE TABLE RPT_POLICYPREFER_FLCARD 
(	BUSINESS_DATE			DATE,
	QUERY_DATE				DATE,
	ROUTE_ID				VARCHAR2(60), 
	ROUTE_NAME				VARCHAR2(60), 
	LEAVE_STATION			VARCHAR2(60), 
	ARRIVE_STATION			VARCHAR2(60), 
	FIRST_LAST_FLAG			VARCHAR2(10), 
	LEAVE_TIME				VARCHAR2(20), 
	ARRIVE_TIME				VARCHAR2(20), 
	CARD_NO					VARCHAR2(20), 
	BUS_LENGTH				NUMBER, 
	COUNT_BY_CARD			NUMBER, 
	AREA_CODE				VARCHAR2(60), 
	ORG_GROUP_ID			VARCHAR2(60),
	ORG_GROUP				VARCHAR2(60)
) 
TABLESPACE TBS_OSECDJW_RPT
NOLOGGING;

CREATE INDEX RPT_POLICYPREFER_FLCARD_IDX1 ON RPT_POLICYPREFER_FLCARD (QUERY_DATE) TABLESPACE TBS_OSECDJW_RPT NOLOGGING;
CREATE INDEX RPT_POLICYPREFER_FLCARD_IDX2 ON RPT_POLICYPREFER_FLCARD (ROUTE_ID) TABLESPACE TBS_OSECDJW_RPT NOLOGGING;

 
COMMENT ON TABLE RPT_POLICYPREFER_FLCARD  IS '政策优惠-线路首末班刷卡';

COMMENT ON COLUMN RPT_POLICYPREFER_FLCARD.QUERY_DATE		IS '查询日期';
COMMENT ON COLUMN RPT_POLICYPREFER_FLCARD.ROUTE_ID		    IS '线路ID';
COMMENT ON COLUMN RPT_POLICYPREFER_FLCARD.ROUTE_NAME		IS '线路名称';
COMMENT ON COLUMN RPT_POLICYPREFER_FLCARD.LEAVE_STATION		IS '始发站点';
COMMENT ON COLUMN RPT_POLICYPREFER_FLCARD.ARRIVE_STATION	IS '终到站点';
COMMENT ON COLUMN RPT_POLICYPREFER_FLCARD.FIRST_LAST_FLAG	IS '首末班';
COMMENT ON COLUMN RPT_POLICYPREFER_FLCARD.LEAVE_TIME		IS '发车时间';
COMMENT ON COLUMN RPT_POLICYPREFER_FLCARD.ARRIVE_TIME		IS '终到时间';
COMMENT ON COLUMN RPT_POLICYPREFER_FLCARD.CARD_NO			IS '车牌号';
COMMENT ON COLUMN RPT_POLICYPREFER_FLCARD.BUS_LENGTH		IS '车辆长度';
COMMENT ON COLUMN RPT_POLICYPREFER_FLCARD.COUNT_BY_CARD		IS '刷卡人次';
COMMENT ON COLUMN RPT_POLICYPREFER_FLCARD.AREA_CODE			IS '区域类型';
COMMENT ON COLUMN RPT_POLICYPREFER_FLCARD.ORG_GROUP_ID		IS '区域ID';
COMMENT ON COLUMN RPT_POLICYPREFER_FLCARD.ORG_GROUP			IS '区域名称';



	