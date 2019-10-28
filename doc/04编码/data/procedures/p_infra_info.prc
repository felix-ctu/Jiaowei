create or replace procedure p_infra_info
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_infra_info                                                            		*
*                                                                                               *
*  File Name   : p_infra_info.prc                                                        		*
*                                                                                               *
*  Description : p_infra_info                                                            		*
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 11-Nov-16   1.0      Liu Mingshun      Initial release                                         *
************************************************************************************************/
	v_date				date:=getbusinessdate;
	v_partition			varchar2(20);
	v_month				varchar2(10);
begin

	v_partition := 'P_'||to_char(v_date,'yyyymm');
	v_month := to_char(v_date,'yyyymm');
	
	--***************************公交车辆**********************
    delete from rpt_infra_bus where yearmonth = v_month;
	commit;
	
    dbms_output.put_line('insert into table for 公交车辆');
    insert /*+append*/ into rpt_infra_bus (
		yearmonth				,
		own_bus_count			,
        oper_bus_count			,
        std_bus_count			,
        gas_bus_count			,
        diesel_bus_count		,
        cng_bus_count			,
        ele_bus_count			,
        mix_bus_count			,
        other_bus_count			,
        aircon_bus_count		,
        non_aircon_bus_count	,
        luxury_bus_count		,
        advanced_bus_count		,
        medium_bus_count		,
        normal_bus_count		,
        lowfloor_bus_count		,
        non_lowfloor_bus_count	,
        non_oper_bus_count		,
        less_than_1year_count	,
        oneto3year_count		,
        threeto5year_count		,
        fiveto7year_count		,
        area_code 				,
        org_group 				,
        org_group_id	 		
    )
    select  
		v_month							 												yearmonth				,
		count(*)																		own_bus_count			,
		sum(case when bus_operate_type = '运营车辆' then 1 else 0 end)					oper_bus_count			,
		sum(stdcoefficient)																std_bus_count			,
		sum(case when oil_type='汽油' then 1 else 0 end)								gas_bus_count			,
		sum(case when oil_type='柴油' then 1 else 0 end)								diesel_bus_count		,
		sum(case when oil_type like '%天然气%' then 1 else 0 end)						cng_bus_count			,
		sum(case when oil_type like '电%' then 1 else 0 end)							ele_bus_count			,
		sum(case when oil_type like '%/%' or oil_type like '%混合%' then 1 else 0 end) 	mix_bus_count			,
		null 																			other_bus_count			,
		sum(case when air_conditioned ='是' then 1 else 0 end)							aircon_bus_count		,
		sum(case when air_conditioned ='否' then 1 else 0 end)							non_aircon_bus_count	,
		null																			luxury_bus_count		,
		null																			advanced_bus_count		,
		null																			medium_bus_count		,
		null																			normal_bus_count		,
		sum(case when low_floor  ='是' then 1 else 0 end)								lowfloor_bus_count		,
		sum(case when low_floor  ='否' then 1 else 0 end)								non_lowfloor_bus_count	,
		sum(case when bus_operate_type <> '运营车辆' then 1 else 0 end)					non_oper_bus_count		,
		null																			less_than_1year_count	,
		null																			oneto3year_count		,
		null																			threeto5year_count		,
		null																			fiveto7year_count		,
		area_code 																		area_code 				,
		org_group 																		org_group 				,
		org_group_id	 																org_group_id			 	
	from obj_businfo_m a
	where a.bus_status = '正常'
	and a.business_date = v_date
	group by area_code,org_group,org_group_id
	;
    commit;
    
	dbms_output.put_line('update other_bus_count');
	update rpt_infra_bus a
	set other_bus_count = nvl(oper_bus_count,0)
						+ nvl(non_oper_bus_count,0)
						- nvl(gas_bus_count,0)
						- nvl(diesel_bus_count,0)
						- nvl(cng_bus_count,0)
						- nvl(ele_bus_count,0)
						- nvl(mix_bus_count,0)
	where a.yearmonth = v_month;
	commit;
	
	
	--***************************从业人员**********************
    delete from rpt_infra_employee where yearmonth = v_month;
	commit;
	
    dbms_output.put_line('insert into table for 从业人员');
    insert /*+append*/ into rpt_infra_employee (
		yearmonth				,
		emp_count				,
		driver_count			,
		steward_count			,
		dispatcher_count		,
		ticket_supervisor_count	,
		clerk_count				,
		section_chief_count		,
		others_count			,
		male_count				,
		female_count			,
		area_code				,
		org_group				,
		org_group_id			 
	)	
	select 
		v_month							 							yearmonth				,
	    count(*)													emp_count				,
	    sum(case when position_type = '驾驶员' then 1 else 0 end) 	driver_count			,
	    sum(case when position_type = '乘务员' then 1 else 0 end) 	steward_count			,
	    sum(case when position_type = '调度员' then 1 else 0 end) 	dispatcher_count		,
	    sum(case when position_type = '票务主管' then 1 else 0 end) ticket_supervisor_count	,
	    sum(case when position_type = '科员' then 1 else 0 end) 	clerk_count				,
	    sum(case when position_type = '科长' then 1 else 0 end) 	section_chief_count		,
	    null 														others_count			,
	    sum(case when sex = '男' then 1 else 0 end) 				male_count				,
	    sum(case when sex = '女' then 1 else 0 end) 				female_count			,
	    area_code													area_code				,
	    org_group													org_group				,
	    org_group_id												org_group_id			
	from obj_employee_m a
	where a.business_date = v_date
	group by area_code,org_group,org_group_id
	;
    commit;	
	
	
	dbms_output.put_line('update others_count');
	update rpt_infra_employee a
	set others_count = nvl(emp_count,0)
						- nvl(driver_count,0)
						- nvl(steward_count,0)
						- nvl(dispatcher_count,0)
						- nvl(ticket_supervisor_count,0)
						- nvl(clerk_count,0)
						- nvl(section_chief_count,0)
	where a.yearmonth = v_month;
	commit;
	
	--***************************公交场站**********************
    delete from rpt_infra_site where yearmonth = v_month;
	commit;
	
    dbms_output.put_line('insert into table for 公交场站');
    insert /*+append*/ into rpt_infra_site (
		yearmonth				,
		site_count		        ,
		site_square		        ,
		site_volume		        ,
		demand_ablity	        ,
		site_owned_count		,
		site_rent_count			,
		site_borrow_count		,
		area_code		        ,
		org_group 		        ,
		org_group_id 	
	)	
	select 
		v_month														yearmonth				,
	    count(*)													site_count		        ,
	    sum(site_square) 											site_square		        ,
	    sum(site_volume) 											site_volume		        ,
	    null													 	demand_ablity	        ,
	    sum(case when site_from like '自有%' then 1 else 0 end) 	site_owned_count		,
	    sum(case when site_from like '租用%' then 1 else 0 end) 	site_rent_count			,
		sum(case when site_from like '借用%' then 1 else 0 end) 	site_rent_count			,
	    area_code												 	area_code		        ,
	    org_group													org_group 		        ,
	    org_group_id								 				org_group_id		
	from obj_site_m a
	where a.business_date = v_date
	group by area_code,org_group,org_group_id
	;
    commit;	
	
	
	--***************************公交站点**********************
    delete from rpt_infra_station where yearmonth = v_month;
	commit;
	
    dbms_output.put_line('insert into table for 公交场站');
    insert /*+append*/ into rpt_infra_station (
		yearmonth				,
		station_count			,
		harbor_shaped_count		,
		hange_station_count		,
		shelter_count			,
		electronic_board_count	,
		area_code				,
		org_group 				,
		org_group_id 					
	)	
	select 
		v_month							 							yearmonth				,
	    count(*)													station_count			,
	    sum(case when harbor_shaped='是' then 1 else 0 end)			harbor_shaped_count		,
	    sum(case when hange_station='是' then 1 else 0 end)			hange_station_count		,
	    sum(case when shelter='有' then 1 else 0 end)		 		shelter_count			,
	    sum(case when electronic_board='有' then 1 else 0 end)		electronic_board_count	,
	    area_code 													area_code				,
		org_group 													org_group 				,
	    org_group_id												org_group_id 										 				
	from obj_station_m a
	where a.business_date = v_date
	group by area_code,org_group,org_group_id
	;
    commit;	

	
	dbms_output.put_line('completed'); 	
end p_infra_info;
/
