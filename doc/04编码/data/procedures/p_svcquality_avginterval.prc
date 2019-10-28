create or replace procedure p_svcquality_avginterval
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_svcquality_avginterval                                                       *
*                                                                                               *
*  File Name   : p_svcquality_avginterval.prc                                                   *
*                                                                                               *
*  Description : 服务质量 -  平均发车间隔分析				                                    *
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 27-Oct-16   1.0      Liu Mingshun      Initial release                                        *
************************************************************************************************/
	v_date 				date:= getbusinessdate;	
	v_partition			varchar2(20);
	v_date_immediate	varchar2(20);

begin

	v_partition := 'P_'||to_char(v_date,'yyyymm');
	v_date_immediate := to_char(v_date,'yyyymmdd');
	
    delete from rpt_svcquality_avginterval where business_date = v_date;
	commit;
	
	
    execute immediate '
	insert into rpt_svcquality_avginterval (
		business_date		 ,
		run_date			 ,
		route_id			 ,
		route_grade			 ,
		run_direction		 ,
		leavetime			 ,
		dispatch_interval	 ,
		time_section		 ,
		area_code			 ,
		org_group			 ,
		org_group_id		
    )
    select  
		m.rundatadate							business_date			,
		m.rundatadate 							run_date				,
		m.routeid								route_id				,
		m.route_grade							route_grade				,
		decode(m.rundirection,''1'',''上行'',''2'',''下行'',''环行'')	run_direction,
		m.leavetime								leavetime				,
		round(m.interval,0)						dispatch_interval		,
		m.time_section							time_section			,
		m.regional_category        				area_code				,
		m.orggroup								org_group				,
		m.orggroupid							org_group_id
	from (	
	select 	a.rundatadate, a.routeid, a.segmentid, d.rundirection, a.leavetime, 
			b.regional_category, b.orggroup, b.orggroupid, c.route_grade, e.remarks time_section,
			lag(a.leavetime,1,a.leavetime) over (partition by a.rundatadate, a.routeid, a.segmentid order by a.leavetime) pre_leavetime,
			(a.leavetime - lag(a.leavetime,1,a.leavetime) over 
				(partition by a.rundatadate, a.routeid, a.segmentid order by a.leavetime))*24*60 interval
	from bz_busrunrecordld partition ('||v_partition||') a, 
			map_org_regional b, 
			rpt_busiquery_route c, 
			mcsegmentinfogs d,
			map_code_master e
	where a.orgid = b.orgid
	and a.routeid = c.route_id
	and a.segmentid = d.segmentid
	and a.rectype = ''1''
	and a.isactive = ''1''
	and e.code_category =''AVG_INTERVAL''
	and to_char(a.leavetime,''hh24:mi:ss'') between code_value and code_desc
	and a.rundatadate = to_date('''||v_date_immediate||''',''yyyymmdd'')
	) m
	group by m.rundatadate, m.routeid, m.route_grade, m.rundirection,m.interval, 
		m.time_section, m.regional_category, m.orggroup, m.orggroupid, m.leavetime'
	;
	
	
	dbms_output.put_line('completed');

end p_svcquality_avginterval;
/
