CREATE OR REPLACE FORCE VIEW rpt_first_last_run (
		business_date		,
		run_date			,
		route_id		    ,
		segment_id		    ,
		first_last_flag	    ,
		bus_id			    ,
		bus_self_id			,
		route_style			,
		actual_leavetime	,
		actual_arrivetime	,
		plan_leavetime		,
		plan_arrivetime		,
		leave_station		,
		arrive_station		,
		area_code			,
		org_group 	        ,
		org_group_id	
) AS 
select  
	rundatadate											business_date		,
	rundatadate 										run_date			,
	routeid												route_id			,
	segmentid											segment_id			,
	decode(shifttype,'F','FIRST_RUN','L','LAST_RUN','P','PRE_LAST_RUN')	first_last_flag,
	busid												bus_id				,
	bus_self_id											bus_self_id			,
	route_style											route_style			,
	leavetime											actual_leavetime	,
	arrivetime											actual_arrivetime	,
	planstarttime										plan_leavetime		,
	planendtime											plan_arrivetime		,
	startstationid										leave_station		,
	endstationid										arrive_station		,
	c.area_code											area_code			,
	c.org_group											org_group 	        ,
	c.org_group_id            							org_group_id
from bz_busrunrecordld a, obj_businfo b, obj_route c
where a.rundatadate = getbusinessdate
and a.routeid = c.route_id
and a.busid = b.bus_id
and a.rectype = '1'
and a.isactive = '1'
and a.shifttype in ('F','L','P');
 
COMMENT ON TABLE RPT_FIRST_LAST_RUN  IS '��������ĩ������';

COMMENT ON COLUMN RPT_FIRST_LAST_RUN.RUN_DATE			IS '��������';
COMMENT ON COLUMN RPT_FIRST_LAST_RUN.ROUTE_ID			IS '��·ID';
COMMENT ON COLUMN RPT_FIRST_LAST_RUN.SEGMENT_ID			IS '����ID';
COMMENT ON COLUMN RPT_FIRST_LAST_RUN.ROUTE_STYLE		IS '��·����';
COMMENT ON COLUMN RPT_FIRST_LAST_RUN.FIRST_LAST_FLAG	IS '��ĩ���־';
COMMENT ON COLUMN RPT_FIRST_LAST_RUN.BUS_ID				IS '������';
COMMENT ON COLUMN RPT_FIRST_LAST_RUN.BUS_SELF_ID		IS '�����Ա��';
COMMENT ON COLUMN RPT_FIRST_LAST_RUN.ACTUAL_LEAVETIME	IS 'ʵ�ʳ���ʱ��';
COMMENT ON COLUMN RPT_FIRST_LAST_RUN.ACTUAL_ARRIVETIME	IS 'ʵ�ʵ���ʱ��';
COMMENT ON COLUMN RPT_FIRST_LAST_RUN.PLAN_LEAVETIME		IS '�ƻ�����ʱ��';
COMMENT ON COLUMN RPT_FIRST_LAST_RUN.PLAN_ARRIVETIME	IS '�ƻ�����ʱ��';
COMMENT ON COLUMN RPT_FIRST_LAST_RUN.LEAVE_STATION		IS '����վ��';
COMMENT ON COLUMN RPT_FIRST_LAST_RUN.ARRIVE_STATION		IS '����վ��';
COMMENT ON COLUMN RPT_FIRST_LAST_RUN.AREA_CODE		    IS '��������';
COMMENT ON COLUMN RPT_FIRST_LAST_RUN.ORG_GROUP		    IS '��������';
COMMENT ON COLUMN RPT_FIRST_LAST_RUN.ORG_GROUP_ID		IS '����ID';

	