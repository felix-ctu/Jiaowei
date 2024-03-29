DROP TABLE RPT_MONITOR_ONLINEDATA CASCADE CONSTRAINTS PURGE;
CREATE TABLE RPT_MONITOR_ONLINEDATA 
(	BUSINESS_DATE				DATE,
	OPER_DATETIME				TIMESTAMP,
	OPERATING_BUS_COUNT			NUMBER,
	NON_OPERATING_BUS_COUNT		NUMBER,
	ALL_BUS_COUNT				NUMBER,
	OPERATING_BUS_ONLINE_RATE	VARCHAR2(60),
	AREA_CODE					VARCHAR2(60),
	ORG_GROUP 					VARCHAR2(100),
	ORG_GROUP_ID				VARCHAR2(60)
) 
TABLESPACE TBS_OSECDJW_RPT
NOLOGGING;


CREATE INDEX RPT_MONITOR_ONLINEDATA_IDX1 ON RPT_MONITOR_ONLINEDATA (OPER_DATETIME) TABLESPACE TBS_OSECDJW_RPT NOLOGGING;

COMMENT ON TABLE RPT_MONITOR_ONLINEDATA  IS '车辆监控-GIS在线数历史查询';

COMMENT ON COLUMN RPT_MONITOR_ONLINEDATA.OPER_DATETIME				IS '时间范围';
COMMENT ON COLUMN RPT_MONITOR_ONLINEDATA.OPERATING_BUS_COUNT 		IS '运营车辆在线数';
COMMENT ON COLUMN RPT_MONITOR_ONLINEDATA.NON_OPERATING_BUS_COUNT 	IS '非运营车辆在线数';
COMMENT ON COLUMN RPT_MONITOR_ONLINEDATA.ALL_BUS_COUNT 		    	IS '总车辆在线数';
COMMENT ON COLUMN RPT_MONITOR_ONLINEDATA.OPERATING_BUS_ONLINE_RATE 	IS '车辆利用率';
COMMENT ON COLUMN RPT_MONITOR_ONLINEDATA.AREA_CODE		 			IS '区域类型';
COMMENT ON COLUMN RPT_MONITOR_ONLINEDATA.ORG_GROUP 		 			IS '区域名称';
COMMENT ON COLUMN RPT_MONITOR_ONLINEDATA.ORG_GROUP_ID	 			IS '区域ID';

