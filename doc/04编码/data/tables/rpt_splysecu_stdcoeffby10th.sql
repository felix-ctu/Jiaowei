DROP TABLE RPT_SPLYSECU_STDCOEFFBY10TH CASCADE CONSTRAINTS PURGE;
CREATE TABLE RPT_SPLYSECU_STDCOEFFBY10TH 
(	BUSINESS_DATE			DATE,
	QUERY_YEAR				VARCHAR2(10), 
	POPULATION_TYPE			VARCHAR2(20), 
	STD_COUNT				NUMBER, 
	POPULATION_NUMBER		NUMBER, 
	STD_COUNT_BY_10THOUSAND	NUMBER, 
	AREA_CODE				VARCHAR2(60), 
	ORG_GROUP				VARCHAR2(60),
	ORG_GROUP_ID			VARCHAR2(60)
) 
TABLESPACE TBS_OSECDJW_RPT
NOLOGGING;

--CREATE INDEX RPT_SPLYSECU_STDCOEFFBY10TH_IDX1 ON RPT_SPLYSECU_STDCOEFFBY10TH (QUERY_YEAR) TABLESPACE TBS_OSECDJW_RPT NOLOGGING;

 
COMMENT ON TABLE RPT_SPLYSECU_STDCOEFFBY10TH  IS '供应保障-万人拥有公交标台数';

COMMENT ON COLUMN RPT_SPLYSECU_STDCOEFFBY10TH.QUERY_YEAR				IS '年份';
COMMENT ON COLUMN RPT_SPLYSECU_STDCOEFFBY10TH.POPULATION_TYPE			IS '人口类型';
COMMENT ON COLUMN RPT_SPLYSECU_STDCOEFFBY10TH.STD_COUNT				   	IS '车辆标台数';
COMMENT ON COLUMN RPT_SPLYSECU_STDCOEFFBY10TH.POPULATION_NUMBER		   	IS '人口数';
COMMENT ON COLUMN RPT_SPLYSECU_STDCOEFFBY10TH.STD_COUNT_BY_10THOUSAND	IS '万人拥有公交标台数';
COMMENT ON COLUMN RPT_SPLYSECU_STDCOEFFBY10TH.AREA_CODE				   	IS '区域类型';
COMMENT ON COLUMN RPT_SPLYSECU_STDCOEFFBY10TH.ORG_GROUP				   	IS '区域名称';
COMMENT ON COLUMN RPT_SPLYSECU_STDCOEFFBY10TH.ORG_GROUP_ID				IS '区域ID';