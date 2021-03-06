DROP TABLE RPT_SPLYSECU_FLOWANDINCOME CASCADE CONSTRAINTS PURGE;
CREATE TABLE RPT_SPLYSECU_FLOWANDINCOME 
(	BUSINESS_DATE				DATE,
	OPER_DATE					DATE,
	ROUTE_ID					VARCHAR2(60),
	SHUAKA_CIKA_COUNT			NUMBER, 
	SHUAKA_CIKA_AMT				NUMBER,
	SHUAKA_CIKA_YOUHUI_COUNT	NUMBER,
	SHUAKA_CIKA_YOUHUI_AMT		NUMBER,
	SHUAKA_DIANZIQIANBAO_COUNT	NUMBER, 
	SHUAKA_DIANZIQIANBAO_AMT	NUMBER,
	SHUAKA_DZQB_YOUHUI_COUNT	NUMBER,
	SHUAKA_DZQB_YOUHUI_AMT		NUMBER,
	TOUBI_COUNT					NUMBER, 
	TOUBI_AMOUNT				NUMBER,
	AREA_CODE					VARCHAR2(60), 
	ORG_GROUP					VARCHAR2(60),
	ORG_GROUP_ID				VARCHAR2(60)

) 
TABLESPACE TBS_OSECDJW_RPT
NOLOGGING;

CREATE INDEX RPT_SPLYSECU_FLOWINCOME_IDX1 ON RPT_SPLYSECU_FLOWANDINCOME (OPER_DATE) TABLESPACE TBS_OSECDJW_RPT NOLOGGING;

 
COMMENT ON TABLE RPT_SPLYSECU_FLOWANDINCOME  IS '供应保障-报表用人流量和收入统计';

COMMENT ON COLUMN RPT_SPLYSECU_FLOWANDINCOME.OPER_DATE						IS '统计日期';
COMMENT ON COLUMN RPT_SPLYSECU_FLOWANDINCOME.ROUTE_ID						IS '线路ID';
COMMENT ON COLUMN RPT_SPLYSECU_FLOWANDINCOME.SHUAKA_CIKA_COUNT				IS '刷卡次卡人次';
COMMENT ON COLUMN RPT_SPLYSECU_FLOWANDINCOME.SHUAKA_CIKA_AMT				IS '刷卡次卡金额';
COMMENT ON COLUMN RPT_SPLYSECU_FLOWANDINCOME.SHUAKA_CIKA_YOUHUI_COUNT		IS '刷卡次卡优惠数量';
COMMENT ON COLUMN RPT_SPLYSECU_FLOWANDINCOME.SHUAKA_CIKA_YOUHUI_AMT			IS '刷卡次卡优惠金额';
COMMENT ON COLUMN RPT_SPLYSECU_FLOWANDINCOME.SHUAKA_DIANZIQIANBAO_COUNT		IS '刷卡电子钱包人次';
COMMENT ON COLUMN RPT_SPLYSECU_FLOWANDINCOME.SHUAKA_DIANZIQIANBAO_AMT		IS '刷卡电子钱包金额';
COMMENT ON COLUMN RPT_SPLYSECU_FLOWANDINCOME.SHUAKA_DZQB_YOUHUI_COUNT		IS '刷卡电子钱包优惠人次';
COMMENT ON COLUMN RPT_SPLYSECU_FLOWANDINCOME.SHUAKA_DZQB_YOUHUI_AMT			IS '刷卡电子钱包优惠金额';
COMMENT ON COLUMN RPT_SPLYSECU_FLOWANDINCOME.TOUBI_COUNT					IS '投币人次';
COMMENT ON COLUMN RPT_SPLYSECU_FLOWANDINCOME.TOUBI_AMOUNT				    IS '投币金额';
COMMENT ON COLUMN RPT_SPLYSECU_FLOWANDINCOME.AREA_CODE						IS '区域类型';
COMMENT ON COLUMN RPT_SPLYSECU_FLOWANDINCOME.ORG_GROUP						IS '区域名称';
COMMENT ON COLUMN RPT_SPLYSECU_FLOWANDINCOME.ORG_GROUP_ID					IS '区域ID';