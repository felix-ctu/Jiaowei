create or replace procedure p_svcquality_depcls
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_svcquality_depcls                                                            *
*                                                                                               *
*  File Name   : p_svcquality_depcls.prc                                                        *
*                                                                                               *
*  Description : 服务质量 -  发车收车时间分析                                                   *
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 27-Oct-16   1.0      Liu Mingshun      Initial release                                        *
************************************************************************************************/
	v_date 				date:= getbusinessdate;	
	v_partition			varchar2(20);
	v_standard			number;
	v_date_immediate	varchar2(20);
begin

	v_partition := 'P_'||to_char(v_date,'yyyymm');
	v_date_immediate := to_char(v_date,'yyyymmdd');
	
	select code_value into v_standard
	from map_code_master
	where code_category ='ONTIME_STANDARD';
	
    --delete from rpt_svcquality_depcls where business_date < v_date and business_date <> add_months(trunc(business_date,'mm'), +1)-1;
    delete from rpt_svcquality_depcls where business_date = v_date;
	commit;
	
    dbms_output.put_line('insert into table for 服务质量-收车发车时间分析');
    execute immediate '
	insert into rpt_svcquality_depcls (
		business_date		,
		run_date			,
		depcls_type			,
		start_time	        ,
		end_time	        ,
		route_count			,
		area_code	        ,
		org_group			,
		org_group_id
    )
    select  
		null       							business_date		,
		a.rundatadate 						run_date			,
		c.remarks							depcls_type			,
		substr(c.code_value,1,5)			start_time			,
		substr(c.code_desc,1,5)				end_date			,
		count(a.routeid)					dep_route_count		,
		b.regional_category        			area_code			,
		b.orggroup							org_group			,
		b.orggroupid						org_group_id
	from bz_busrunrecordld partition ('||v_partition||') a, map_org_regional b, map_code_master c
	where a.orgid = b.orgid
	and a.rectype = ''1''
	and a.isactive = ''1''
	and c.code_category =''DEP_CLS''
	and to_char(a.rundatadate,''yyyymmdd'') = '||v_date_immediate||'
	and to_char(a.leavetime, ''hh24:mi:ss'') between c.code_value and c.code_desc
	group by a.rundatadate, c.remarks, b.regional_category, b.orggroup, b.orggroupid, substr(c.code_value,1,5), substr(c.code_desc,1,5)'
	;
    commit;
	

	update rpt_svcquality_depcls set business_date = v_date where business_date is null;
	commit;

    
	dbms_output.put_line('completed');

end p_svcquality_depcls;
/
