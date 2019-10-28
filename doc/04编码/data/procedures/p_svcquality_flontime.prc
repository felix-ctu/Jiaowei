create or replace procedure p_svcquality_flontime
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_svcquality_flontime                                                          *
*                                                                                               *
*  File Name   : p_svcquality_flontime.prc                                                      *
*                                                                                               *
*  Description : 服务质量                                                                       *
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 24-Oct-16   1.0      Liu Mingshun      Initial release                                        *
************************************************************************************************/
	v_date 				date:= getbusinessdate;	
	v_partition			varchar2(20);
	v_standard			number;
begin

	v_partition := 'P_'||to_char(v_date,'yyyymm');
	
	select code_value into v_standard
	from map_code_master
	where code_category ='ONTIME_STANDARD';
	
    delete from rpt_svcquality_flontime where business_date < v_date and business_date <> add_months(trunc(business_date,'mm'), +1)-1;
    delete from rpt_svcquality_flontime where business_date = v_date;
	commit;
	
    dbms_output.put_line('insert into table for 服务质量-首班');
	
    insert into rpt_svcquality_flontime (
		business_date		,
		fl_date				,
		flag				,
		route_id			,
		first_run_count		,
		frun_ontime_count	,
		frun_ontime_ratio	,
		area_code			,
		org_group			,
		org_group_id
    )
    select  
		v_date     							business_date		,
		run_date	 						fl_date				,
		'TMP_F'								flag				,
		route_id							route_id			,
	    count(*)							first_run_count		,
		sum(case when actual_leavetime < plan_leavetime or (actual_leavetime-plan_leavetime)*24*60<v_standard	
			 then 1 else 0 
		end) 								frun_ontime_count	,
		null								frun_ontime_ratio	,
		area_code	  			       		area_code			,
		org_group							org_group			,
		org_group_id						org_group_id
	from rpt_first_last_run
	where first_last_flag = 'FIRST_RUN'
	and business_date = v_date
	group by run_date, route_id, org_group_id, org_group, area_code
	;
    commit;
	

    dbms_output.put_line('insert into table for 服务质量-末班');
	
    insert into rpt_svcquality_flontime (
		business_date		,
		fl_date				,
		flag				,
		route_id			,
		last_run_count		,
		lrun_ontime_count	,
		lrun_ontime_ratio	,
		area_code			,
		org_group			,
		org_group_id
    )
    select  
		v_date     							business_date		,
		run_date	 						fl_date				,
		'TMP_L'								flag				,
		route_id							route_id			,
		count(*)							last_run_count		,
		sum(case when actual_leavetime > plan_leavetime or (plan_leavetime-actual_leavetime)*24*60<v_standard
			 then 1 else 0 
		end) 								lrun_ontime_count	,
		null								lrun_ontime_ratio	,
		area_code	  			       		area_code			,
		org_group							org_group			,
		org_group_id						org_group_id
	from rpt_first_last_run
	where first_last_flag = 'LAST_RUN'
	and business_date = v_date
	group by run_date, route_id, org_group_id, org_group, area_code
	;
    commit;

	dbms_output.put_line('insert into table for 服务质量-合并首末班');
	insert into rpt_svcquality_flontime(
		business_date		,
		fl_date				,
		flag				,
		route_id			,
		first_run_count		,
		frun_ontime_count	,
		frun_ontime_ratio	,
		last_run_count		,
		lrun_ontime_count	,
		lrun_ontime_ratio	,
		area_code			,
		org_group			,
		org_group_id
	)
	select 
		a.business_date			business_date		,
	    a.fl_date				fl_date				,
	    'RPT'					flag				,
		a.route_id				route_id			,
	    a.first_run_count		first_run_count		,
	    a.frun_ontime_count		frun_ontime_count	,
	    a.frun_ontime_ratio		frun_ontime_ratio	,
	    b.last_run_count		last_run_count		,
	    b.lrun_ontime_count		lrun_ontime_count	,
	    b.lrun_ontime_ratio		lrun_ontime_ratio	,
	    a.area_code				area_code			,
	    a.org_group				org_group			,
	    a.org_group_id	        org_group_id
	from rpt_svcquality_flontime a, rpt_svcquality_flontime b
	where a.business_date = b.business_date
	and a.fl_date = b.fl_date
	and a.route_id = b.route_id
	and a.flag = 'TMP_F'
	and b.flag = 'TMP_L'
	and a.org_group_id = b.org_group_id
	and a.business_date = v_date;
	commit;
	
	dbms_output.put_line('delete temporary data');
	delete from rpt_svcquality_flontime where business_date = v_date and flag like 'TMP%';
	commit;
	

	dbms_output.put_line('update route_grade');
    update rpt_svcquality_flontime rpt
        set route_grade = (	select c.route_grade
							from obj_route_m c
							where rpt.route_id = c.route_id
							and c.business_date = rpt.business_date
						)
    where rpt.business_date = v_date;
    commit;

	
	dbms_output.put_line('upupdate frun_ontime_ratio,lrun_ontime_ratio');
    update rpt_svcquality_flontime rpt
        set (frun_ontime_ratio,lrun_ontime_ratio) 
			= ( select round(frun_ontime_count/decode(first_run_count,0,1,first_run_count)*100,2), 
					   round(lrun_ontime_count/decode(last_run_count,0,1,last_run_count)*100,2)
				from dual
				)
	where rpt.business_date = v_date;
    commit;
	
	
	dbms_output.put_line('completed');

end p_svcquality_flontime;
/
