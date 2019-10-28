create or replace procedure p_busiquery_dispatch_record
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_busiquery_dispatch_record                                                    *
*                                                                                               *
*  File Name   : p_busiquery_dispatch_record.prc                                                *
*                                                                                               *
*  Description : 服务质量 -  发车记录查询					                                    *
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
	
	delete from rpt_busiquery_dispatch_record where business_date = v_date;
	commit;
	
	
	insert into rpt_busiquery_dispatch_record (
		business_date		,
	    run_date			,
	    route_id			,
	    bussid				,
	    bus_id				,
	    bus_card			,
	    shifttype			,
	    driver_name			,
	    leave_station		,
	    arrive_station		,
	    actual_leavetime	,
	    actual_arrivetime	,
	    actual_op_miles		,
	    area_code			,
	    org_group			,
	    org_group_id		
	)
    select 
		rundatadate													business_date		,
		rundatadate													run_date			,
		routeid														route_id			,
		null														bussid				,
		busid														bus_id				,
		buscardno													bus_card			,
		decode(shifttype,'F','首班','L','末班','中间班')			shifttype			,
		driverid													driver_name			,
		startstationid												leave_station		,
		endstationid												arrive_station		,
		leavetime													actual_leavetime	,
		arrivetime													actual_arrivetime	,
		decode(sign(a.gpsmile),1,a.gpsmile,a.milenum) 				actual_op_miles		,
		b.area_code													area_code			,
		b.org_group													org_group			,
		b.org_group_id												org_group_id		
	from bz_busrunrecordld a, obj_route_m b
	where a.isactive = '1'
	and a.rectype = '1'
	and a.routeid = b.route_id
	and exists (select 1 from obj_businfo_m c where a.busid = c.bus_id and c.business_date = a.rundatadate)
	and a.rundatadate = b.business_date
	and a.rundatadate = v_date;
    commit;
	
	update rpt_busiquery_dispatch_record a
	set bussid = (	select bus_self_id 
					from obj_businfo_m b
					where a.bus_id = b.bus_id
					and b.business_date = a.business_date
				)
	where a.business_date = v_date;
	commit;

	update rpt_busiquery_dispatch_record a
	set driver_name = (	select emp_name
					from obj_employee_m b
					where a.driver_name = b.emp_id
					and b.business_date = a.business_date
				)
	where a.business_date = v_date;
	commit;
	
	update rpt_busiquery_dispatch_record a
	set leave_station = (	select station_name 
							from obj_station_m b
							where a.leave_station = b.station_id
							and b.business_date = a.business_date
						)
	where a.business_date = v_date;
	commit;
	
	update rpt_busiquery_dispatch_record a
	set arrive_station = (	select station_name 
							from obj_station_m b
							where a.arrive_station = b.station_id
							and b.business_date = a.business_date
						)
	where a.business_date = v_date;
	commit;
	
	
	dbms_output.put_line('completed');

end p_busiquery_dispatch_record;
/
