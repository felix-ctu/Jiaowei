DROP TABLE RPT_SPLYSECU_BUSUTILIZATION CASCADE CONSTRAINTS PURGE;
CREATE TABLE RPT_SPLYSECU_BUSUTILIZATION 
(	BUSINESS_DATE				DATE,
	OPER_DATE					DATE, 
	OPER_BUS_COUNT				NUMBER, 
	OWN_BUS_COUNT				NUMBER, 
	BUS_UTILIZATION				NUMBER, 
	AREA_CODE					VARCHAR2(60), 
	ORG_GROUP					VARCHAR2(60),
	ORG_GROUP_ID				VARCHAR2(60)
) 
TABLESPACE TBS_OSECDJW_RPT
NOLOGGING;

CREATE INDEX RPT_SPLYSECU_BUSUTIL_IDX1 ON RPT_SPLYSECU_BUSUTILIZATION (OPER_DATE) TABLESPACE TBS_OSECDJW_RPT NOLOGGING;

 
COMMENT ON TABLE RPT_SPLYSECU_BUSUTILIZATION  IS '供应保障-车辆利用率';

COMMENT ON COLUMN RPT_SPLYSECU_BUSUTILIZATION.OPER_DATE			IS '运营日期';
COMMENT ON COLUMN RPT_SPLYSECU_BUSUTILIZATION.OPER_BUS_COUNT	IS '投入车辆数';
COMMENT ON COLUMN RPT_SPLYSECU_BUSUTILIZATION.OWN_BUS_COUNT	    IS '拥有车辆数';
COMMENT ON COLUMN RPT_SPLYSECU_BUSUTILIZATION.BUS_UTILIZATION	IS '车辆利用率';
COMMENT ON COLUMN RPT_SPLYSECU_BUSUTILIZATION.AREA_CODE		    IS '区域类型';
COMMENT ON COLUMN RPT_SPLYSECU_BUSUTILIZATION.ORG_GROUP		    IS '区域名称';
COMMENT ON COLUMN RPT_SPLYSECU_BUSUTILIZATION.ORG_GROUP_ID		IS '区域ID';