create or replace procedure p_route_info_tmp
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_route_info_tmp                                                            	*
*                                                                                               *
*  File Name   : p_route_info_tmp.prc                                                        	*
*                                                                                               *
*  Description : 线路信息查询		                                                            *
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 12-Nov-16   1.0      Liu Mingshun      Initial release                                        *
************************************************************************************************/
	v_date				date:=getbusinessdate;
	v_partition			varchar2(20);
	v_date_immediate	varchar2(20);
	out_file 			utl_file.file_type;

begin

	v_partition := 'P_'||to_char(v_date,'yyyymm');
	v_date_immediate := to_char(v_date,'yyyymmdd');

    delete from rpt_route_info_tmp where business_date = v_date;
	commit;
	
    insert into rpt_route_info_tmp (
		business_date		,
		area_code			,
		org_group			,
		org_group_id		,
		route_id			,
		route_name			,
		plan_dis_count		,
		act_dis_count		,
		bus_count 			,
		op_mile				,
		passflow			,
		first_dispatch		,
		last_dispatch		,
		fl_ontime_ratio		,
		route_ontime_ratio	,
		op_qty				,
		op_date				
    )
    select 
		a.business_date	business_date		,
		a.area_code		area_code			,
		a.org_group 	org_group			,
		a.org_group_id	org_group_id		,
		a.route_id		route_id			,
		a.route_name 	route_name			,
		null 			plan_dis_count		,
		null 			act_dis_count		,
		a.bus_count 	bus_count 			,
		null 			op_mile				,
		null 			passflow			,
		null			first_dispatch		,
		null			last_dispatch		,
		null 			fl_ontime_ratio		,
		null 			route_ontime_ratio	,
		null 			op_qty				,
		a.business_date	op_date				
	from obj_route_m a
	where a.business_date = v_date;
    commit;
	

	update rpt_route_info_tmp a
	set plan_dis_count = 
					(select count(*)
					from bz_busdisplanld b 
					where a.route_id = b.routeid
					and b.rundate = a.business_date
					and b.isactive = '1'
					and b.rectype = '1'
					)
	where a.business_date = v_date;
	commit;
	
	
	update rpt_route_info_tmp a
	set (act_dis_count,op_mile,op_qty) = 
					(select count(*), sum(decode(sign(b.gpsmile),1,b.gpsmile,b.milenum)), count(distinct busid)
					from bz_busrunrecordld b 
					where a.route_id = b.routeid
					and b.rundatadate = a.business_date
					and b.isactive = '1'
					and b.rectype = '1'
					)
	where a.business_date = v_date;
	commit;
	
	update rpt_route_info_tmp a
	set fl_ontime_ratio = 
					(select round((b.frun_ontime_count+b.lrun_ontime_count)/decode((b.first_run_count+b.last_run_count),0,1,(b.first_run_count+b.last_run_count))*100,2)
						from rpt_svcquality_flontime b
						where a.business_date = b.business_date
						and b.route_id = a.route_id
						and a.area_code = b.area_code
						and a.org_group = b.org_group
					)
	where a.business_date = v_date;
	commit;
	
	update rpt_route_info_tmp a
	set passflow = 
					(select sum(nvl(b.shuaka_cika_count,0) + nvl(b.toubi_count,0) + nvl(b.shuaka_dianziqianbao_count,0))
						from rpt_splysecu_flowandincome b
						where a.business_date = b.business_date
						and b.route_id = a.route_id
						and a.area_code = b.area_code
						and a.org_group = b.org_group
					)
	where a.business_date = v_date;
	commit;
	
	update rpt_route_info_tmp a
	set (first_dispatch, last_dispatch) = 
					(select min(case when b.first_last_flag='FIRST_RUN' then b.actual_leavetime end) first_dispatch,
							max(case when b.first_last_flag='LAST_RUN'  then b.actual_leavetime end) last_dispatch
						from rpt_first_last_run b
						where a.business_date = b.business_date
						and b.route_id = a.route_id
						and a.area_code = b.area_code
						and a.org_group = b.org_group
						and b.first_last_flag in ('FIRST_RUN','LAST_RUN')
					)
	where a.business_date = v_date;
	commit;
	
	
	dbms_output.put_line('completed'); 	
end p_route_info_tmp;
/
