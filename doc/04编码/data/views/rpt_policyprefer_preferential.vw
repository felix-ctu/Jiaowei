CREATE OR REPLACE FORCE VIEW rpt_policyprefer_preferential (
		business_date			, 
		query_date				,
		preferential_amount	    ,
		oper_amount			    ,
		preferential_count	    ,
		flow_count			    ,
		area_code			    ,
		org_group_id		    ,
		org_group			
) AS 
select 
	business_date						business_date		,
	oper_date							query_date			,
	(nvl(shuaka_cika_youhui_amt,0) + nvl(shuaka_dzqb_youhui_amt,0)) 					preferential_amount	,
	(nvl(shuaka_cika_amt,0) + nvl(shuaka_dianziqianbao_amt,0) + nvl(toubi_amount,0))  	oper_amount,
	(nvl(shuaka_cika_youhui_count,0) + nvl(shuaka_dzqb_youhui_count,0))		 			preferential_count	,
	(nvl(shuaka_cika_count,0) + nvl(shuaka_dianziqianbao_count,0) + nvl(toubi_count,0))	flow_count,
	area_code							area_code			,
	org_group_id						org_group_id		,
	org_group							org_group					
from rpt_splysecu_flowandincome;
 

COMMENT ON TABLE RPT_POLICYPREFER_PREFERENTIAL  IS '政策优惠-优惠分析';

COMMENT ON COLUMN RPT_POLICYPREFER_PREFERENTIAL.QUERY_DATE					IS '查询日期';
COMMENT ON COLUMN RPT_POLICYPREFER_PREFERENTIAL.PREFERENTIAL_AMOUNT	    	IS '日优惠金额';
COMMENT ON COLUMN RPT_POLICYPREFER_PREFERENTIAL.OPER_AMOUNT			    	IS '日营运收入';
COMMENT ON COLUMN RPT_POLICYPREFER_PREFERENTIAL.PREFERENTIAL_COUNT	    	IS '日优惠人次';
COMMENT ON COLUMN RPT_POLICYPREFER_PREFERENTIAL.FLOW_COUNT			    	IS '日客流量';
COMMENT ON COLUMN RPT_POLICYPREFER_PREFERENTIAL.AREA_CODE				    IS '区域类型';
COMMENT ON COLUMN RPT_POLICYPREFER_PREFERENTIAL.ORG_GROUP_ID			    IS '区域ID';
COMMENT ON COLUMN RPT_POLICYPREFER_PREFERENTIAL.ORG_GROUP				    IS '区域名称';