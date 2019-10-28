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
 

COMMENT ON TABLE RPT_POLICYPREFER_PREFERENTIAL  IS '�����Ż�-�Żݷ���';

COMMENT ON COLUMN RPT_POLICYPREFER_PREFERENTIAL.QUERY_DATE					IS '��ѯ����';
COMMENT ON COLUMN RPT_POLICYPREFER_PREFERENTIAL.PREFERENTIAL_AMOUNT	    	IS '���Żݽ��';
COMMENT ON COLUMN RPT_POLICYPREFER_PREFERENTIAL.OPER_AMOUNT			    	IS '��Ӫ������';
COMMENT ON COLUMN RPT_POLICYPREFER_PREFERENTIAL.PREFERENTIAL_COUNT	    	IS '���Ż��˴�';
COMMENT ON COLUMN RPT_POLICYPREFER_PREFERENTIAL.FLOW_COUNT			    	IS '�տ�����';
COMMENT ON COLUMN RPT_POLICYPREFER_PREFERENTIAL.AREA_CODE				    IS '��������';
COMMENT ON COLUMN RPT_POLICYPREFER_PREFERENTIAL.ORG_GROUP_ID			    IS '����ID';
COMMENT ON COLUMN RPT_POLICYPREFER_PREFERENTIAL.ORG_GROUP				    IS '��������';