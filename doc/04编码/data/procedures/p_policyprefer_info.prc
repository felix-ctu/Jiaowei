create or replace procedure p_policyprefer_info
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_policyprefer_info                                                            *
*                                                                                               *
*  File Name   : p_policyprefer_info.prc                                                        *
*                                                                                               *
*  Description : 政策优惠		                                                            	*
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

begin

	v_partition := 'P_'||to_char(v_date,'yyyymmdd');
	v_date_immediate := to_char(v_date,'yyyymmdd');

	--***************************站点时段刷卡客流分析????**********************
    delete from rpt_policyprefer_passflow where business_date = v_date;
	commit;
	
    dbms_output.put_line('insert into table for 站点时段刷卡客流分析');
 	execute immediate '	
    insert into rpt_policyprefer_passflow (
		business_date			,
		query_date				,
		route_id		        ,
		route_name		        ,
		station_no		        ,
		station_name	        ,
		holiday_flag	        ,
		time_section	        ,
		flow_count		        ,
		area_code		        ,
		org_group_id	        ,
		org_group		
    )
    select  
		a.run_date							business_date	,
		a.run_date							query_date		,
		a.route_id							route_id		,
		null								route_name		,
		a.station_id						station_no		,
		a.station_name					    station_name	,
		null							    holiday_flag	,
		m.remarks				    		time_section	,
		count(*)							flow_count		,
		a.area_code							area_code		,
		a.org_group_id						org_group_id	,
		a.org_group							org_group		
	from rpt_busiquery_arrlft a, v_tbmonth_temp partition ('||v_partition||') c, map_code_master m
	where a.arrlft_flag = ''到站''
	and a.bus_self_id = c.busno
	and to_char(a.route_id) = c.lineno
	and m.code_category =''TIME_SECTION''
	and to_char(c.consumedate,''hh24:mi:ss'') between m.code_value and m.code_desc
	and (c.consumedate - a.actdatetime) >= 0 
	and (c.consumedate - a.actdatetime) <= 1/2/60/24
	and trunc(c.consumedate) = a.business_date
	and to_char(a.business_date,''yyyymmdd'') = '||v_date_immediate||'
	group by a.run_date,a.route_id,a.station_id,a.station_name, a.area_code,a.org_group_id,a.org_group,m.remarks'
	;
    commit;
	
	
	update rpt_policyprefer_passflow a
	set route_name = (select route_name
						from obj_route_m b
						where a.route_id = b.route_id
						and b.business_date = a.business_date
					)
	where a.business_date = v_date;
	commit;
	
	
	update rpt_policyprefer_passflow a
	set holiday_flag = (case when to_char(query_date,'D') in (1,7) then 'H' else 'W' end)
	where a.business_date = v_date;
	commit;
	
	--***************************线路首末班刷卡**********************
    delete from rpt_policyprefer_flcard where business_date = v_date;
	commit;
	
    dbms_output.put_line('insert into table for 线路首末班刷卡-缺电子钱包');
	execute immediate '
    insert into rpt_policyprefer_flcard (
		business_date			, 
		query_date				,
		route_id			    ,
		route_name			    ,
		leave_station		    ,
		arrive_station		    ,
		first_last_flag		    ,
		leave_time			    ,
		arrive_time			    ,
		card_no				    ,
		bus_length			    ,
		count_by_card		    ,
		area_code			    ,
		org_group_id		    ,
		org_group					
	)	
	select 
		a.run_date			business_date	,
		a.run_date			query_date		,
        a.route_id			route_id		,
        null				route_name		,
        a.leave_station		leave_station	,
        a.arrive_station	arrive_station	,
        a.first_last_flag	first_last_flag	,
        a.actual_leavetime	leave_time		,
        a.actual_arrivetime	arrive_time		,
        b.card_id			card_no			,
        b.bus_length		bus_length		,
        count(d.cardno)		count_by_card	, 
        a.area_code			area_code		,
        a.org_group_id		org_group_id	,
        a.org_group			org_group		
	from rpt_first_last_run a, obj_businfo_m b, v_tbmonth_temp partition ('||v_partition||') d 
	where a.bus_id = b.bus_id
	and a.business_date = b.business_date
	and d.consumedate between a.actual_leavetime and a.actual_arrivetime
	and a.route_id = d.lineno
	and a.bus_self_id = d.busno
	and a.first_last_flag in (''FIRST_RUN'',''LAST_RUN'')
	and a.business_date = to_date('''||v_date_immediate||''',''yyyymmdd'')
	group by a.run_date,
			 a.route_id,
	         a.leave_station,
	         a.arrive_station,
	         a.first_last_flag,
	         a.actual_leavetime,
	         a.actual_arrivetime,
	         b.card_id,
	         b.bus_length,	
	         a.area_code,
	         a.org_group_id,
	         a.org_group'
	;
    commit;	

	
    update rpt_policyprefer_flcard a
	set route_name = (select b.route_name 
						 from obj_route_m b
						 where a.route_id = b.route_id
						 and a.business_date = b.business_date
						 )
	where a.business_date = v_date;
	commit;
	
	
    update rpt_policyprefer_flcard a
	set leave_station = (select b.station_name 
						 from obj_station_m b
						 where a.leave_station = b.station_id
						 and a.business_date = b.business_date
						 )
	where a.business_date = v_date;
	commit;
	
	update rpt_policyprefer_flcard a
	set arrive_station = (select b.station_name 
						 from obj_station_m b
						 where a.arrive_station = b.station_id
						 and a.business_date = b.business_date
						 )
	where a.business_date = v_date;
	commit;
		
	dbms_output.put_line('completed'); 	
end p_policyprefer_info;
/
