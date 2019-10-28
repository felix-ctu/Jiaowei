create or replace procedure p_monitor_info
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_monitor_info                                                            		*
*                                                                                               *
*  File Name   : p_monitor_info.prc                                                        		*
*                                                                                               *
*  Description : p_monitor_info                                                            		*
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 11-Nov-16   1.0      Liu Mingshun      Initial release                                         *
************************************************************************************************/
	v_date				date:=getbusinessdate;
	v_date_immediate	varchar2(20);
	v_partition			varchar2(20);
begin

	v_partition := 'P_'||to_char(v_date,'yyyymm');
	v_date_immediate := to_char(v_date,'yyyymmdd');
	
	--***************************早高峰车辆数统计**********************
    delete from rpt_monitor_ampmpeak where business_date = v_date;
	commit;
	
    dbms_output.put_line('insert into table for 早高峰车辆数统计');
    
	insert into rpt_monitor_ampmpeak (
		business_date			,
		oper_date				,
		oper_time_section		, 
		owned_count		        , 
        online_count	        , 
        oper_count		        , 
        non_oper_count	        , 
        area_code		        , 
        org_group 		        , 
        org_group_id 	          
    )
    select  
		null					business_date			,
		a.rundatadate			oper_date				,
		'07:10-07:40'			oper_time_section		,
		null 					owned_count		        ,
		count(*) 				online_count	        ,
		sum(case when a.rectype = '1'
				then 1
				else 0
			end)				oper_count		        ,
		sum(case when a.rectype <> '1'
				then 1
				else 0
			end) 				non_oper_count	        ,
		b.regional_category     area_code				,
		b.orggroup				org_group				,
		b.orggroupid			org_group_id
	from bz_busrunrecordld  a, map_org_regional b
	where a.orgid = b.orgid
	and a.isactive = '1'
	and a.rundatadate = v_date
	and ((to_char(a.leavetime, 'hh24:mi:ss') <= '07:10:00' and to_char(a.arrivetime, 'hh24:mi:ss') > '07:10:00')
	 or to_char(a.leavetime, 'hh24:mi:ss') between '07:10:01' and '07:40:00')
	group by a.rundatadate, b.regional_category, b.orggroup, b.orggroupid
	union all
	select  
		null					business_date			,
		a.rundatadate			oper_date				,
		'07:40-08:10'			oper_time_section		,
		null 					owned_count		        ,
		count(*) 				online_count	        ,
		sum(case when a.rectype = '1'
				then 1
				else 0
			end)				oper_count		        ,
		sum(case when a.rectype <> '1'
				then 1
				else 0
			end) 				non_oper_count	        ,
		b.regional_category     area_code				,
		b.orggroup				org_group				,
		b.orggroupid			org_group_id
	from bz_busrunrecordld  a, map_org_regional b
	where a.orgid = b.orgid
	and a.isactive = '1'
	and a.rundatadate = v_date
	and ((to_char(a.leavetime, 'hh24:mi:ss') <= '07:40:00' and to_char(a.arrivetime, 'hh24:mi:ss') > '07:40:00')
	 or to_char(a.leavetime, 'hh24:mi:ss') between '07:40:01' and '08:10:00')
	group by a.rundatadate, b.regional_category, b.orggroup, b.orggroupid
	union all
	select  
		null					business_date			,
		a.rundatadate			oper_date				,
		'08:10-08:40'			oper_time_section		,
		null 					owned_count		        ,
		count(*) 				online_count	        ,
		sum(case when a.rectype = '1'
				then 1
				else 0
			end)				oper_count		        ,
		sum(case when a.rectype <> '1'
				then 1
				else 0
			end) 				non_oper_count	        ,
		b.regional_category     area_code				,
		b.orggroup				org_group				,
		b.orggroupid			org_group_id
	from bz_busrunrecordld  a, map_org_regional b
	where a.orgid = b.orgid
	and a.isactive = '1'
	and a.rundatadate = v_date
	and ((to_char(a.leavetime, 'hh24:mi:ss') <= '08:10:00' and to_char(a.arrivetime, 'hh24:mi:ss') > '08:10:00')
	 or to_char(a.leavetime, 'hh24:mi:ss') between '08:10:01' and '08:40:00')
	group by a.rundatadate, b.regional_category, b.orggroup, b.orggroupid
	union all
	select  
		null					business_date			,
		a.rundatadate			oper_date				,
		'08:40-09:10'			oper_time_section		,
		null 					owned_count		        ,
		count(*) 				online_count	        ,
		sum(case when a.rectype = '1'
				then 1
				else 0
			end)				oper_count		        ,
		sum(case when a.rectype <> '1'
				then 1
				else 0
			end) 				non_oper_count	        ,
		b.regional_category     area_code				,
		b.orggroup				org_group				,
		b.orggroupid			org_group_id
	from bz_busrunrecordld  a, map_org_regional b
	where a.orgid = b.orgid
	and a.isactive = '1'
	and a.rundatadate = v_date
	and ((to_char(a.leavetime, 'hh24:mi:ss') <= '08:40:00' and to_char(a.arrivetime, 'hh24:mi:ss') > '08:40:00')
	 or to_char(a.leavetime, 'hh24:mi:ss') between '08:40:01' and '09:10:00')
	group by a.rundatadate, b.regional_category, b.orggroup, b.orggroupid
	;
	commit;
	
	update rpt_monitor_ampmpeak
	set business_date = v_date
	where business_date is null;
	commit;
	
	update rpt_monitor_ampmpeak rpt
	set owned_count = 
		(select a.own_bus_count
		 from rpt_infra_bus a
		 where rpt.area_code = a.area_code
		 and rpt.org_group_id = a.org_group_id
		 and a.yearmonth = to_char(rpt.business_date,'yyyymm')
		)
	where business_date = v_date;
	commit;
	
	
	--***************************固定时段车辆在线数量**********************
    delete from rpt_monitor_fixtimeonline where business_date = v_date;
	commit;
	
	
    dbms_output.put_line('insert into table for 固定时段车辆在线数量');
    
	insert into rpt_monitor_fixtimeonline (
		business_date			, 
		oper_date				,
		fixed_time_section		,
		weekday					,
		gps_online_count		,
		oper_online_count		,
		non_oper_online_count	,
		area_code				,
		org_group 				,
		org_group_id 			
	)	
	select 
		c.business_date						business_date			,
	    a.rundatadate 						oper_date,
		d.code_value						fixed_time_section,
        to_char(a.rundatadate-1,'D') 		weekday					,
        sum(case when c.bus_machine_number is not null 
				 then 1
				 else 0
			end) 							gps_online_count		,
        sum(case when a.rectype ='1'
				 then 1
				 else 0
			end) 							oper_online_count		,
        sum(case when a.rectype <>'1'
				 then 1
				 else 0
			end)  							non_oper_online_count	,
        b.regional_category     			area_code				,
		b.orggroup							org_group				,
		b.orggroupid						org_group_id
	from bz_busrunrecordld  a, map_org_regional b, obj_businfo_m c, map_code_master d
	where a.orgid = b.orgid
	and a.busid = c.bus_id
	and c.business_date = a.rundatadate
	and a.isactive = '1'
	and d.code_category = 'RPT_MONITOR_FIXTIMEONLINE'
	and a.leavetime <= to_date(v_date_immediate||' '||d.code_value,'yyyymmdd hh24:mi:ss')
	and a.arrivetime > to_date(v_date_immediate||' '||d.code_value,'yyyymmdd hh24:mi:ss')
	and c.business_date = v_date
	group by c.business_date, a.rundatadate, b.regional_category, b.orggroup, b.orggroupid, d.code_value
	;
	commit;	
	
	
	--***************************GIS在线数历史查询**********************
    delete from rpt_monitor_onlinedata where business_date = v_date;
	commit;
	
    dbms_output.put_line('insert into table for GIS在线数历史查询');
	insert into rpt_monitor_onlinedata (
		business_date				, 
		oper_datetime				,
		operating_bus_count			,
		non_operating_bus_count		,
		all_bus_count				,
		operating_bus_online_rate	,
		area_code					,
		org_group 					,
		org_group_id				
	)	
	select 
		a.rundatadate						business_date				,
	    to_date(to_char(a.rundatadate,'yyyymmdd')||' '||c.minutes,'yyyymmdd hh24:mi:ss') oper_datetime,
	    sum(case when a.rectype ='1'
				 then 1
				 else 0
			end) 							operating_bus_count			,
        sum(case when a.rectype <>'1'
				 then 1
				 else 0
			end)  							non_operating_bus_count		,
		count(*) 							all_bus_count				,
	    null 								operating_bus_online_rate	,
	    b.regional_category     			area_code					,
	    b.orggroup							org_group 					,
		b.orggroupid						org_group_id				 				
	from bz_busrunrecordld  a, map_org_regional b, map_day_minutes c
	where a.orgid = b.orgid
	and a.isactive = '1'
	and a.rundatadate = v_date
	and a.leavetime <= to_date(v_date_immediate||' '||c.minutes,'yyyymmdd hh24:mi:ss')
	and a.arrivetime > to_date(v_date_immediate||' '||c.minutes,'yyyymmdd hh24:mi:ss')
	group by a.rundatadate,c.minutes, b.regional_category, b.orggroup, b.orggroupid
	;
	
	
	update rpt_monitor_onlinedata
	set operating_bus_online_rate = decode(all_bus_count,0,0,round(operating_bus_count/all_bus_count*100,2))
	where business_date = v_date;
	commit;
	
	dbms_output.put_line('completed'); 	
end p_monitor_info;
/
