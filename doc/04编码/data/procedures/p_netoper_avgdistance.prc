create or replace procedure p_netoper_avgdistance
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_netoper_avgdistance                                                  		*
*                                                                                               *
*  File Name   : p_netoper_avgdistance.prc                                              		*
*                                                                                               *
*  Description : 线网分析 - 平均站距分析                                                        *
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 27-Oct-16   1.0      Liu Mingshun      Initial release                                        *
************************************************************************************************/
	v_date 				date:= getbusinessdate;	
	v_partition			varchar2(20);
begin

	v_partition := 'P_'||to_char(v_date,'yyyymm');
	
    --delete from rpt_netoper_avgdistance where business_date < v_date and business_date <> add_months(trunc(business_date,'mm'), +1)-1;
    delete from rpt_netoper_avgdistance where business_date = v_date;
	commit;
	
    dbms_output.put_line('insert into table for 线网分析-平均站距分析');
    insert into rpt_netoper_avgdistance (
		business_date		,
		yearmonth			,
        route_id			,
        route_name			,
        avg_station_distance,
        area_code			,
        org_group_id		,
        org_group			
	)
    select  
		v_date     							business_date		,
		to_char(v_date, 'yyyymm')			yearmonth			,
		a.route_id							route_id			,
		b.route_name						route_name			,
		round(b.route_length/(count(a.station_no)-1)*1000,0)	avg_station_distance,
		b.area_code							area_code			,
		b.org_group_id       				org_group_id		,
		b.org_group							org_group			
	from rpt_busiquery_route_tjzd a, rpt_busiquery_route b
	where a.route_id = b.route_id
	and a.run_direction in ('3','1')
	group by a.route_id, b.route_name, b.route_length, b.area_code, b.org_group_id, b.org_group
	;
    commit;
	
    
	dbms_output.put_line('completed');

end p_netoper_avgdistance;
/
