DROP TABLE RPT_NETOPER_AVGDISTANCE CASCADE CONSTRAINTS PURGE;
CREATE TABLE RPT_NETOPER_AVGDISTANCE 
(	BUSINESS_DATE			DATE,
	YEARMONTH				VARCHAR2(10), 
	ROUTE_ID				VARCHAR2(60), 
	ROUTE_NAME				VARCHAR2(200), 
	AVG_STATION_DISTANCE	NUMBER, 
	AREA_CODE				VARCHAR2(60), 
	ORG_GROUP_ID			VARCHAR2(60),
	ORG_GROUP				VARCHAR2(60)
) 
TABLESPACE TBS_OSECDJW_RPT
NOLOGGING;

CREATE INDEX RPT_NETOPER_AVGDISTANCE_IDX1 ON RPT_NETOPER_AVGDISTANCE (YEARMONTH) TABLESPACE TBS_OSECDJW_RPT NOLOGGING;

 
COMMENT ON TABLE RPT_NETOPER_AVGDISTANCE  IS '线网运行-平均站距';

COMMENT ON COLUMN RPT_NETOPER_AVGDISTANCE.YEARMONTH				IS '查询月份';
COMMENT ON COLUMN RPT_NETOPER_AVGDISTANCE.ROUTE_ID				IS '线路ID';
COMMENT ON COLUMN RPT_NETOPER_AVGDISTANCE.ROUTE_NAME			IS '线路名称';
COMMENT ON COLUMN RPT_NETOPER_AVGDISTANCE.AVG_STATION_DISTANCE  IS '平均站距';
COMMENT ON COLUMN RPT_NETOPER_AVGDISTANCE.AREA_CODE			    IS '区域类型';
COMMENT ON COLUMN RPT_NETOPER_AVGDISTANCE.ORG_GROUP_ID		    IS '区域ID';
COMMENT ON COLUMN RPT_NETOPER_AVGDISTANCE.ORG_GROUP			    IS '区域名称';