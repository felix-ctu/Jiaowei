CREATE OR REPLACE FORCE VIEW rpt_svcquality_depinterval (
		business_date		,
		run_date			,
		route_id			,
		route_grade			,
		dep_interval_failed	,
		total_dep			,
		working_day_flag	,
		area_code			,
		org_group			,
		org_group_id		,
		pass_flag			
) AS 
select a.*, (case when a.dep_interval_failed >= 2 then 'N' else 'Y' end) pass_flag
from (
select  
	m.business_date						business_date			,
	m.run_date	 						run_date				,
	m.route_id							route_id				,
	m.route_grade						route_grade				,
	sum(case when m.route_grade = '����' and m.dispatch_interval>9 		then 1
			 when m.route_grade = '����' and m.dispatch_interval>12 	then 1
			 when m.route_grade = '֧��' and m.dispatch_interval>15 	then 1
			 when m.route_grade = '΢��' and m.dispatch_interval>8 		then 1
		 else 0
		end) 							dep_interval_failed		,
	count(*)							total_dep				,	
	(case when to_char(m.run_date,'D') in (1,7) 
		  then 'H' 
		  else 'W' 
	end) 								working_day_flag		,
	m.area_code        					area_code				,
	m.org_group							org_group				,
	m.org_group_id						org_group_id
from rpt_svcquality_avginterval m
where substr(m.time_section,1,2) between '05' and '20'
group by m.business_date, m.run_date, m.route_id, m.route_grade, m.area_code, m.org_group, m.org_group_id
) a;
 

COMMENT ON TABLE rpt_svcquality_depinterval  IS '��������-�����ճ�ʱ�����';
COMMENT ON COLUMN RPT_SVCQUALITY_DEPINTERVAL.RUN_DATE				IS '��ѯ����';
COMMENT ON COLUMN RPT_SVCQUALITY_DEPINTERVAL.WORKING_DAY_FLAG		IS '�Ƿ����գ�W-�����գ�H-�ǹ�����';
COMMENT ON COLUMN RPT_SVCQUALITY_DEPINTERVAL.ROUTE_ID				IS '��·ID';
COMMENT ON COLUMN RPT_SVCQUALITY_DEPINTERVAL.ROUTE_GRADE			IS '��·��������֧΢��';
COMMENT ON COLUMN RPT_SVCQUALITY_DEPINTERVAL.DEP_INTERVAL_FAILED	IS '����������������';
COMMENT ON COLUMN RPT_SVCQUALITY_DEPINTERVAL.TOTAL_DEP				IS '����������';
COMMENT ON COLUMN RPT_SVCQUALITY_DEPINTERVAL.PASS_FLAG				IS '��������Ƿ���';
COMMENT ON COLUMN RPT_SVCQUALITY_DEPINTERVAL.AREA_CODE				IS '��������';
COMMENT ON COLUMN RPT_SVCQUALITY_DEPINTERVAL.ORG_GROUP				IS '��������';
COMMENT ON COLUMN RPT_SVCQUALITY_DEPINTERVAL.ORG_GROUP_ID			IS '����ID';