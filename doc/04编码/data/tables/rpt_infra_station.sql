DROP TABLE RPT_INFRA_STATION CASCADE CONSTRAINTS PURGE;
CREATE TABLE RPT_INFRA_STATION
(	YEARMONTH					VARCHAR2(10), 
	STATION_COUNT				NUMBER,
	HARBOR_SHAPED_COUNT			NUMBER,
	HANGE_STATION_COUNT			NUMBER,
	SHELTER_COUNT				NUMBER,
	ELECTRONIC_BOARD_COUNT		NUMBER,
	AREA_CODE					VARCHAR2(60),
	ORG_GROUP 					VARCHAR2(100),
	ORG_GROUP_ID 				VARCHAR2(100)
) 
TABLESPACE TBS_OSECDJW_RPT
NOLOGGING;

CREATE INDEX RPT_INFRA_STATION_IDX1 ON RPT_INFRA_STATION (YEARMONTH) TABLESPACE TBS_OSECDJW_RPT NOLOGGING;

 
COMMENT ON TABLE RPT_INFRA_STATION  IS '基础设施-公交站点';

COMMENT ON COLUMN RPT_INFRA_STATION.YEARMONTH					IS '月份';
COMMENT ON COLUMN RPT_INFRA_STATION.STATION_COUNT			    IS '站点数量';
COMMENT ON COLUMN RPT_INFRA_STATION.HARBOR_SHAPED_COUNT			IS '港湾式站点数量';
COMMENT ON COLUMN RPT_INFRA_STATION.HANGE_STATION_COUNT			IS '枢纽站数量';
COMMENT ON COLUMN RPT_INFRA_STATION.SHELTER_COUNT			    IS '候车厅数量';
COMMENT ON COLUMN RPT_INFRA_STATION.ELECTRONIC_BOARD_COUNT		IS '电子站牌数量';
COMMENT ON COLUMN RPT_INFRA_STATION.AREA_CODE				    IS '区域类型';
COMMENT ON COLUMN RPT_INFRA_STATION.ORG_GROUP				    IS '区域名称';
COMMENT ON COLUMN RPT_INFRA_STATION.ORG_GROUP_ID				IS '区域ID';



	