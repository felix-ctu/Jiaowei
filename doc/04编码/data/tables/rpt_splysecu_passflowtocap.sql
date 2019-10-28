DROP TABLE RPT_SPLYSECU_PASSFLOWTOCAP CASCADE CONSTRAINTS PURGE;
CREATE TABLE RPT_SPLYSECU_PASSFLOWTOCAP 
(	BUSINESS_DATE			DATE,
	OPER_DATE				DATE,
	TIME_SECTION			VARCHAR2(60),
	ROUTE_NAME				VARCHAR2(2000), 
	ROUTE_ID				VARCHAR2(60),
	OPER_CAP				NUMBER,
	PASSENGER_FLOW			NUMBER,
	RATIO					NUMBER,
	AREA_CODE				VARCHAR2(60), 
	ORG_GROUP				VARCHAR2(60),
	ORG_GROUP_ID			VARCHAR2(60)

) 
TABLESPACE TBS_OSECDJW_RPT
NOLOGGING;

CREATE INDEX RPT_SPLYSECU_PFLOWCAP_IDX1 ON RPT_SPLYSECU_PASSFLOWTOCAP (OPER_DATE) TABLESPACE TBS_OSECDJW_RPT NOLOGGING;

 
COMMENT ON TABLE RPT_SPLYSECU_PASSFLOWTOCAP  IS '供应保障-客流与运力配置分析';

COMMENT ON COLUMN RPT_SPLYSECU_PASSFLOWTOCAP.OPER_DATE				IS '运营日期';
COMMENT ON COLUMN RPT_SPLYSECU_PASSFLOWTOCAP.TIME_SECTION			IS '时段范围';
COMMENT ON COLUMN RPT_SPLYSECU_PASSFLOWTOCAP.ROUTE_NAME			    IS '线路名称';
COMMENT ON COLUMN RPT_SPLYSECU_PASSFLOWTOCAP.ROUTE_ID			    IS '线路ID';
COMMENT ON COLUMN RPT_SPLYSECU_PASSFLOWTOCAP.OPER_CAP			    IS '运力配置';
COMMENT ON COLUMN RPT_SPLYSECU_PASSFLOWTOCAP.PASSENGER_FLOW		    IS '客流量';
COMMENT ON COLUMN RPT_SPLYSECU_PASSFLOWTOCAP.RATIO				    IS '客流量/运力配置比例';
COMMENT ON COLUMN RPT_SPLYSECU_PASSFLOWTOCAP.AREA_CODE			    IS '区域类型';
COMMENT ON COLUMN RPT_SPLYSECU_PASSFLOWTOCAP.ORG_GROUP			    IS '区域名称';
COMMENT ON COLUMN RPT_SPLYSECU_PASSFLOWTOCAP.ORG_GROUP_ID			IS '区域ID';