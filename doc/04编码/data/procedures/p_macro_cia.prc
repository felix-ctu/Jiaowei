create or replace procedure p_macro_cia
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_macro_cia                                                            		*
*                                                                                               *
*  File Name   : p_macro_cia.prc                                                        		*
*                                                                                               *
*  Description : p_macro_cia                                                            		*
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 13-Oct-16   1.0      Liu Mingshun      Initial release                                         *
************************************************************************************************/
	v_date				date:=getbusinessdate;
	v_partition			varchar2(20);
	v_date_immediate	varchar2(20);
	v_train_punct_rate	number;
	v_standard			number;

begin

	v_partition := 'P_'||to_char(v_date,'yyyymm');
	v_date_immediate := to_char(v_date,'yyyymmdd');

	--***************************公交设施**********************
	delete from rpt_macro_cia_bus_inst where business_date = v_date;
	commit;
	
    dbms_output.put_line('insert into table for 公交设施');
    insert /*+append*/ into rpt_macro_cia_bus_inst (
		business_date	,
		cia_date 		,
		area_code		,
		org_group		,
		org_group_id	,
		route_count 	,
		route_length 	,
		subroute_count	,
		site_count 		,
		station_count 	,
		emp_count 		,
		driver_count 	
    )
    select distinct 
		v_date            business_date		,
		v_date			  cia_date 			,
		regional_category area_code			,
		orggroup		  org_group			,
		orggroupid		  org_group_id		,
		0				  route_count 		,
		0				  route_length 		,
		0				  subroute_count	,
		0				  site_count 		,
		0				  station_count 	,
		0				  emp_count 		,
		0	              driver_count 	
	from map_org_regional a
	;
    commit;
    
	dbms_output.put_line('update 线路条数');
	update rpt_macro_cia_bus_inst a
	set (route_count,subroute_count) = 
					(select count(*),sum(length(b.sub_route_id)-length(replace(b.sub_route_id,',',''))+1) subroute_count
					 from obj_route_m b 
					 where a.area_code = b.area_code 
					 and a.org_group_id = b.org_group_id
					 and a.business_date = b.business_date
					)
	where a.business_date = v_date;
	commit;
	
	
	dbms_output.put_line('update 线路长度');
	update rpt_macro_cia_bus_inst a
	set route_length = (select sum(b.route_length)
						from obj_route_m b 
						where a.area_code = b.area_code 
						and a.org_group_id = b.org_group_id
						and a.business_date = b.business_date
						)
	where a.business_date = v_date;
	commit;
	
	
	dbms_output.put_line('update 场站数量');
	update rpt_macro_cia_bus_inst a
	set site_count = (	select count(*) 
						from obj_site_m b 
						where b.business_date = a.business_date
						)
	where a.business_date = v_date
	and a.org_group = '成都市公共交通集团公司';
	commit;
	
	dbms_output.put_line('update 站点数量');
	update rpt_macro_cia_bus_inst a
	set station_count = (select count(*) 
						 from obj_station_m b
						 where b.business_date = a.business_date
						 and a.org_group = b.org_group
						)
	where a.area_code = '中心城区'
	and a.org_group = '成都市公共交通集团公司'
	and a.business_date = v_date;
	commit;
	
	
	dbms_output.put_line('update 从业人员数量');
	update rpt_macro_cia_bus_inst a
	set emp_count = (select count(*) 
					 from obj_employee_m b 
					 where a.area_code = b.area_code
					 and a.org_group_id = b.org_group_id
					 and a.business_date = b.business_date)
	where a.business_date = v_date;
	commit;
	
	dbms_output.put_line('update 驾驶员数量');
	update rpt_macro_cia_bus_inst a
	set driver_count = (select count(*) 
						from obj_employee_m b 
						where a.area_code = b.area_code 
						and a.org_group_id = b.org_group_id
						and b.position_type = '驾驶员'
						and a.business_date = b.business_date)
	where a.business_date = v_date;
	commit;

	dbms_output.put_line('insert into table for 全部');
    insert /*+append*/ into rpt_macro_cia_bus_inst (
		business_date	,
		cia_date 		,
		area_code		,
		org_group		,
		org_group_id	,
		route_count 	,
		route_length 	,
		subroute_count	,
		site_count 		,
		station_count 	,
		emp_count 		,
		driver_count 	
    )
    select  
		business_date     		business_date	,
		cia_date		  		cia_date 		,
		area_code			  	area_code		,
		'区域全部'			  	org_group		,
		null			  		org_group_id	,
		sum(route_count) 	  	route_count 	,
		sum(route_length) 	  	route_length 	,
		sum(subroute_count)  	subroute_count	,
		sum(site_count) 	  	site_count 		,
		sum(station_count)   	station_count 	,
		sum(emp_count) 	  		emp_count 		,
		sum(driver_count) 	  	driver_count 	
	from rpt_macro_cia_bus_inst a
	where a.business_date = v_date
	and a.area_code <> '全部'
	and nvl(a.org_group,'0') <> '区域全部'
	group by business_date, cia_date, area_code
	union all
	select  
		business_date     		business_date	,
		cia_date		  		cia_date 		,
		'全部' 			  		area_code		,
		null			  		org_group		,
		null			  		org_group_id	,
		sum(route_count) 	  	route_count 	,
		sum(route_length) 	  	route_length 	,
		sum(subroute_count)  	subroute_count	,
		sum(site_count) 	  	site_count 		,
		sum(station_count)   	station_count 	,
		sum(emp_count) 	  		emp_count 		,
		sum(driver_count) 	  	driver_count 	
	from rpt_macro_cia_bus_inst a
	where a.business_date = v_date
	and a.area_code <> '全部'
	and nvl(a.org_group,'0') <> '区域全部'
	group by business_date, cia_date
	;
    commit;

	--***************************车辆投入**********************
	delete from rpt_macro_cia_bus_invest where business_date = v_date;
	commit;
	
    dbms_output.put_line('insert into table for 车辆投入');
    insert /*+append*/ into rpt_macro_cia_bus_invest (
		business_date			,
		cia_date 				,
		area_code				,
		org_group				,
		org_group_id			,
		owned_qty 				,
		actual_op_qty 			,
		op_qty 					,
		standard_qty 			,
		aircond_qty				,
		oper_mile			    ,
		total_mile			    ,
		oper_invest_time	    ,
		total_invest_time	    ,
		air_cond_scale 			,
		invest_qty_util_ratio 	,
		invest_mil_util_ratio 	,
		invest_time_util_ratio 		
    )
    select distinct 
		v_date            		business_date			,
		v_date			  		cia_date 				,
		regional_category 		area_code				,
		orggroup				org_group				,
		orggroupid				org_group_id			,
		0						owned_qty 				,
		0						actual_op_qty 			,
		0						op_qty 					,
		0						standard_qty 			,
		0						aircond_qty				,
		0						oper_mile			    ,
		0						total_mile			    ,
		0						oper_invest_time	    ,
		0						total_invest_time	    ,
		0						air_cond_scale 			,
		0						invest_qty_util_ratio 	,
		0						invest_mil_util_ratio 	,
		0						invest_time_util_ratio 	
	from map_org_regional a
	;
    commit;
	

	
	dbms_output.put_line('update 车辆保有量');
	update rpt_macro_cia_bus_invest a
	set owned_qty = (select count(*) 
					 from obj_businfo_m b 
					 where a.area_code = b.area_code
					 and a.org_group_id = b.org_group_id
					 and a.business_date = b.business_date)
	where a.business_date = v_date;
	commit;
	

	dbms_output.put_line('update 实际运营车辆数');
	execute immediate '
	update rpt_macro_cia_bus_invest a
	set actual_op_qty = (
						select count(*) 
						from obj_businfo_m b
						where exists (select 1 from bz_busrunrecordld partition ('||v_partition||') c 
									  where b.bus_id = c.busid
									  and c.isactive = ''1''
									  and c.rectype = ''1''
									  )
						and a.area_code = b.area_code
						and a.org_group_id = b.org_group_id
						and a.business_date = b.business_date
	)
	where to_char(a.business_date,''yyyymmdd'') = '||v_date_immediate;
	commit;
	
	
	dbms_output.put_line('update 可运营车辆');
	update rpt_macro_cia_bus_invest a
	set op_qty = (	select count(*) 
					from obj_businfo_m b 
					where b.bus_operate_type = '运营车辆' 
					and a.area_code = b.area_code
					and a.org_group_id = b.org_group_id
					and a.business_date = b.business_date
				)
	where a.business_date = v_date;
	commit;
	
	dbms_output.put_line('update 车辆标台');
	update rpt_macro_cia_bus_invest a
	set standard_qty = (select sum(stdcoefficient) 
						from obj_businfo_m b 
						where b.area_code = a.area_code
						and a.org_group_id = b.org_group_id
						and a.business_date = b.business_date
						)
	where a.business_date = v_date;
	commit;

	
	dbms_output.put_line('update 空调车数量');
	update rpt_macro_cia_bus_invest r
	set aircond_qty = (select count(bus_id) 
						from obj_businfo_m a
						where a.air_conditioned='是'
						and a.business_date = r.business_date
						and a.area_code = r.area_code
						and a.org_group_id = r.org_group_id
					)
	where r.business_date = v_date;
	commit;



	dbms_output.put_line('update 运营里程数，总里程数||运营投入时间，总投入时间');

	update rpt_macro_cia_bus_invest rpt
	set (oper_mile,total_mile,oper_invest_time,total_invest_time) = 
						(
							select sum(decode(a.rectype, '1', decode(sign(a.gpsmile),1,a.gpsmile,a.milenum), 0)) omile, 
								   sum(decode(sign(a.gpsmile),1,a.gpsmile,a.milenum)) tmile,
								   round(sum(case when a.rectype = '1' then (a.arrivetime-a.leavetime)*24 else 0 end),2) otime,
								   round(sum((a.arrivetime-a.leavetime)*24),2) ttime
							from bz_busrunrecordld a, obj_businfo_m b
							where a.busid = b.bus_id
							and a.isactive = '1'
							and b.business_date = rpt.business_date
							and rpt.area_code = b.area_code
							and rpt.org_group_id = b.org_group_id
						)
	where rpt.business_date = v_date;
	commit;

	 
	
	dbms_output.put_line('insert into table for 全部');
	insert into rpt_macro_cia_bus_invest (
		business_date			,
		cia_date 				,
		area_code				,
		org_group				,
		org_group_id			,
		owned_qty 				,
		actual_op_qty 			,
		op_qty 					,
		standard_qty 			,
		aircond_qty				,
		oper_mile			    ,
		total_mile			    ,
		oper_invest_time	    ,
		total_invest_time	    ,
		air_cond_scale 			,
		invest_qty_util_ratio 	,
		invest_mil_util_ratio 	,
		invest_time_util_ratio 		
    )
    select  
		business_date           business_date			,
		cia_date			  	cia_date 				,
		area_code				area_code				,
		'区域全部'				org_group				,
		null					org_group_id			,
		sum(owned_qty) 			owned_qty 				,
		sum(actual_op_qty)		actual_op_qty 			,
		sum(op_qty) 			op_qty 					,
		sum(standard_qty) 		standard_qty 			,
		sum(aircond_qty) 		aircond_qty				,
		sum(oper_mile)			oper_mile			    ,
		sum(total_mile)			total_mile			    ,
		sum(oper_invest_time)	oper_invest_time	    ,
		sum(total_invest_time)	total_invest_time	    ,
		0						air_cond_scale 			,
		0						invest_qty_util_ratio 	,
		0						invest_mil_util_ratio 	,
		0						invest_time_util_ratio 	
	from rpt_macro_cia_bus_invest a
	where a.business_date = v_date
	and a.area_code <> '全部'
	and nvl(a.org_group,'0') <> '区域全部'
	group by business_date, cia_date, area_code
	union all
	select  
		business_date           business_date			,
		cia_date			  	cia_date 				,
		'全部' 					area_code				,
		null					org_group				,
		null					org_group_id			,
		sum(owned_qty) 			owned_qty 				,
		sum(actual_op_qty)		actual_op_qty 			,
		sum(op_qty) 			op_qty 					,
		sum(standard_qty) 		standard_qty 			,
		sum(aircond_qty) 		aircond_qty				,
		sum(oper_mile)			oper_mile			    ,
		sum(total_mile)			total_mile			    ,
		sum(oper_invest_time)	oper_invest_time	    ,
		sum(total_invest_time)	total_invest_time	    ,
		0						air_cond_scale 			,
		0						invest_qty_util_ratio 	,
		0						invest_mil_util_ratio 	,
		0						invest_time_util_ratio 	
	from rpt_macro_cia_bus_invest a
	where a.business_date = v_date
	and a.area_code <> '全部'
	and nvl(a.org_group,'0') <> '区域全部'
	group by business_date, cia_date;
    commit;
   

	dbms_output.put_line('update 空调车比例');
	update rpt_macro_cia_bus_invest r
	set air_cond_scale = aircond_qty/decode(owned_qty,0,1,owned_qty) *100
	where r.business_date = v_date;
	commit;

	dbms_output.put_line('update 车辆投入数量利用率：');
	update rpt_macro_cia_bus_invest a
	set invest_qty_util_ratio = (actual_op_qty/decode(owned_qty,0,1,owned_qty))*100
	where a.business_date = v_date;
	commit;

	dbms_output.put_line('update 车辆投入里程利用率');
	update rpt_macro_cia_bus_invest a
	set invest_mil_util_ratio = oper_mile/decode(total_mile,0,1,total_mile)*100
	where a.business_date = v_date;
	commit;
	
	dbms_output.put_line('update 车辆投入时间利用率');
	update rpt_macro_cia_bus_invest a
	set invest_time_util_ratio = oper_invest_time/decode(total_invest_time,0,1,total_invest_time)*100
	where a.business_date = v_date;
	commit;
	
	--******************************运能投入-当天**********************************
	delete from rpt_macro_cia_cap_invest where business_date = v_date;
	commit;
	
    dbms_output.put_line('insert into table for 运能投入');
    insert /*+append*/ into rpt_macro_cia_cap_invest (
		business_date			,
		cia_date 				,
		area_code				,
		org_group				,
		org_group_id			,
		depa_freq				,
		op_mil 					,
		op_hours 				,
		op_qty
    )
    select distinct 
		v_date            		business_date	,
		v_date			  		cia_date 		,
		regional_category 		area_code		,
		orggroup				org_group		,
		orggroupid				org_group_id	,
		0						depa_freq 		,
		0						op_mil 			,
		0						op_hours		,
		0						op_qty
	from map_org_regional a
	;
    commit;
	

	dbms_output.put_line('update 发车班次,运营里程,运营时间');
	
	update rpt_macro_cia_cap_invest a
	set (depa_freq,op_mil,op_hours,op_qty) = (
					select count(*), sum(decode(sign(b.gpsmile),1,b.gpsmile,b.milenum)),round(sum((b.arrivetime-b.leavetime)*24),2),count(distinct b.busid)
					from bz_busrunrecordld b, obj_businfo_m c
					where b.busid = c.bus_id
					and b.rundatadate = a.business_date
					and b.isactive = 1
					and b.rectype = 1
					and a.area_code = c.area_code
					and a.org_group_id = c.org_group_id
					and c.business_date = a.business_date
				)
	where a.business_date = v_date;
	commit;

	
	
	dbms_output.put_line('insert into table for 全部');
    insert /*+append*/ into rpt_macro_cia_cap_invest (
		business_date			,
		cia_date 				,
		area_code				,
		org_group				,
		org_group_id			,
		depa_freq				,
		op_mil 					,
		op_hours 				,
		op_qty
    )
    select  
		business_date       business_date	,
		cia_date			cia_date 		,
		area_code			area_code		,
		'区域全部'			org_group		,
		null				org_group_id	,
		sum(depa_freq) 		depa_freq 		,
		sum(op_mil) 		op_mil 			,
		sum(op_hours)		op_hours		,
		sum(op_qty)			op_qty			
	from rpt_macro_cia_cap_invest a
	where a.business_date = v_date
	and a.area_code <> '全部'
	and nvl(a.org_group,'0') <> '区域全部'
	group by business_date, cia_date, area_code
	union all
	select  
		business_date       business_date	,
		cia_date			cia_date 		,
		'全部' 				area_code		,
		null				org_group		,
		null				org_group_id	,
		sum(depa_freq) 		depa_freq 		,
		sum(op_mil) 		op_mil 			,
		sum(op_hours)		op_hours		,
		sum(op_qty)			op_qty			
	from rpt_macro_cia_cap_invest a
	where a.business_date = v_date
	and a.area_code <> '全部'
	and nvl(a.org_group,'0') <> '区域全部'
	group by business_date, cia_date
	;
    commit;
	
	
	--******************************服务质量**********************************
	delete from rpt_macro_cia_sve_quty where business_date = v_date;
	commit;
	
	
    dbms_output.put_line('insert into table for 服务质量');
    insert /*+append*/ into rpt_macro_cia_sve_quty (
		business_date				,
		cia_date 					,
		first_last_punct_rate 		,
		train_punct_rate 			,
		ontime_train_count	 		,
		total_train_count	 		,
		shift_fulfilled_rate 		,
		depa_inte_fulfilled_rate 	,
		area_code 					,
		org_group					,
		org_group_id
    )
    select distinct 
		v_date            		business_date				,
		v_date			  		cia_date 					,
		0				 		first_last_punct_rate		,		
		0						train_punct_rate 			,
		0						ontime_train_count	 		,
		0						total_train_count	 		,
		0						shift_fulfilled_rate 		,
		0						depa_inte_fulfilled_rate	,
		regional_category		area_code					,
		orggroup				org_group					,
		orggroupid				org_group_id
	from map_org_regional a
	;
    commit;
	
	
	dbms_output.put_line('update 首末班准点率(不含全部)');
	update rpt_macro_cia_sve_quty a
	set first_last_punct_rate = (
					select round(sum(frun_ontime_count+lrun_ontime_count)
						/decode(sum(first_run_count+last_run_count),0,1,sum(first_run_count+last_run_count))*100,0)
					from rpt_svcquality_flontime b
					where b.business_date = a.business_date
					and a.area_code = b.area_code
					and a.org_group_id = b.org_group_id
				)
	where a.business_date = v_date
	and a.area_code <> '全部'
	and nvl(a.org_group,'0') <> '区域全部';
	commit;

	dbms_output.put_line('update 车次准点数，车次总数');
	select code_value into v_standard
	from map_code_master
	where code_category ='ONTIME_STANDARD';
	

	execute immediate '
	update rpt_macro_cia_sve_quty rpt
	set (ontime_train_count,total_train_count) = 
						(select sum(case when a.leavetime < a.planstarttime or (a.planstarttime-a.leavetime)*24*60<'||v_standard||'
										 then 1 else 0 
									end) ontime, count(1) total
							from bz_busrunrecordld partition ('||v_partition||') a, map_org_regional c 
							where a.displanid = b.displandid
							and a.orgid = c.orgid
							and a.rectype = ''1''
							and a.isactive = ''1''
							and rpt.area_code = c.regional_category
							and rpt.org_group_id = c.orggroupid
						)
	where rpt.area_code <> ''全部''
	and rpt.org_group <> ''区域全部''
	and to_char(rpt.business_date,''yyyymmdd'') = '||v_date_immediate;
	commit;
	

	dbms_output.put_line('insert into table for 全部');
    insert /*+append*/ into rpt_macro_cia_sve_quty (
		business_date				,
		cia_date 					,
		first_last_punct_rate 		,
		train_punct_rate 			,
		ontime_train_count	 		,
		total_train_count	 		,
		shift_fulfilled_rate 		,
		depa_inte_fulfilled_rate 	,
		area_code 					,
		org_group					,
		org_group_id
    )
    select 
		business_date      			business_date				,
		cia_date					cia_date 					,
		0				 			first_last_punct_rate		,		
		0							train_punct_rate 			,
		sum(ontime_train_count)	 	ontime_train_count			,
		sum(total_train_count)	 	total_train_count			,
		0							shift_fulfilled_rate 		,
		0							depa_inte_fulfilled_rate	,
		area_code					area_code					,
		'区域全部'					org_group					,
		null						org_group_id
	from rpt_macro_cia_sve_quty a
	where a.business_date = v_date
	and a.area_code <> '全部'
	and nvl(a.org_group,'0') <> '区域全部'
	group by business_date, cia_date, area_code
	union all
	select 
		business_date      			business_date				,
		cia_date					cia_date 					,
		0				 			first_last_punct_rate		,		
		0							train_punct_rate 			,
		sum(ontime_train_count)	 	ontime_train_count			,
		sum(total_train_count)	 	total_train_count			,
		0							shift_fulfilled_rate 		,
		0							depa_inte_fulfilled_rate	,
		'全部'						area_code					,
		null						org_group					,
		null						org_group_id
	from rpt_macro_cia_sve_quty a
	where a.business_date = v_date
	and a.area_code <> '全部'
	and nvl(a.org_group,'0') <> '区域全部'
	group by business_date, cia_date
	;
    commit;
	
	dbms_output.put_line('update 首末班准点率-区域全部');
	update rpt_macro_cia_sve_quty a
	set first_last_punct_rate = (
					select round(sum(frun_ontime_count+lrun_ontime_count)
						/decode(sum(first_run_count+last_run_count),0,1,sum(first_run_count+last_run_count))*100,0)
					from rpt_svcquality_flontime b
					where a.area_code = b.area_code
					and b.business_date = a.business_date
				)
	where a.business_date = v_date
	and a.org_group = '区域全部'
	and a.area_code <> '全部';
	commit;
	
	dbms_output.put_line('update 首末班准点率-全部');
	update rpt_macro_cia_sve_quty a
	set first_last_punct_rate = (
					select round(sum(frun_ontime_count+lrun_ontime_count)
						/decode(sum(first_run_count+last_run_count),0,1,sum(first_run_count+last_run_count))*100,0)
					from rpt_svcquality_flontime b
					where b.business_date = a.business_date
				)
	where a.business_date = v_date
	and nvl(a.org_group,'0') <> '区域全部'
	and a.area_code = '全部';
	commit;
	
	
	dbms_output.put_line('update for 车次准点率(包含全部)');
	update rpt_macro_cia_sve_quty a
	set train_punct_rate = round(ontime_train_count/decode(total_train_count,0,1,total_train_count)*100,2)
	where a.business_date = v_date;
	commit;
	
	dbms_output.put_line('update for 发车间隔兑现率(不包含全部)');
	update rpt_macro_cia_sve_quty a
	set depa_inte_fulfilled_rate = 
					   (select round((total_train_count-sum(b.dep_interval_failed))/decode(total_train_count,0,1,total_train_count)*100,2)
						from rpt_svcquality_depinterval b
						where a.business_date = b.business_date
						and a.org_group_id = b.org_group_id
						and a.area_code = b.area_code
						)
	where a.business_date = v_date
	and a.area_code <> '全部'
	and nvl(a.org_group,'0') <> '区域全部';
	commit;
	
	dbms_output.put_line('update for 发车间隔兑现率(区域全部)');
	update rpt_macro_cia_sve_quty a
	set depa_inte_fulfilled_rate = 
					   (select round((total_train_count-sum(b.dep_interval_failed))/decode(total_train_count,0,1,total_train_count)*100,2)
						from rpt_svcquality_depinterval b
						where a.business_date = b.business_date
						and a.area_code = b.area_code
						)
	where a.business_date = v_date
	and a.area_code <> '全部'
	and a.org_group = '区域全部';
	commit;
	
	
	dbms_output.put_line('update for 发车间隔兑现率(全部)');
	update rpt_macro_cia_sve_quty a
	set depa_inte_fulfilled_rate = 
					   (select round((total_train_count-sum(b.dep_interval_failed))/decode(total_train_count,0,1,total_train_count)*100,2)
						from rpt_svcquality_depinterval b
						where a.business_date = b.business_date
						)
	where a.business_date = v_date
	and a.area_code = '全部'
	and nvl(a.org_group,'0') <> '区域全部';
	commit;
	
	
	
	--******************************公交收入和客流分析**********************************
	delete from rpt_macro_cia_bus_income where business_date = v_date;
	commit;
	
    dbms_output.put_line('insert into table for 公交收入和客流');
    insert /*+append*/ into rpt_macro_cia_bus_income (
		business_date		,
		cia_date			,
		coin_income   		,
		ic_income     		,
		op_income     		,
		dis_amount    		,
		ths_income    		,
		sgl_avg_income		,
		coin_pt 			,
		ic_pt 				,
		psg_flow_pt 		,
		dis_pt 				,
		ths_trfc_volume 	,
		sgl_avg_trfc_volume ,
		area_code           ,
		org_group           ,
		org_group_id
    )
    select distinct 
		v_date            		business_date		,
		v_date			  		cia_date			,
		0				 		coin_income   		,		
		0						ic_income     		,
		0						op_income     		,
		0						dis_amount    		,
		0						ths_income    		,
		0						sgl_avg_income		,
		0						coin_pt 			,
		0						ic_pt 				,
		0						psg_flow_pt 		,
		0						dis_pt 				,
		0						ths_trfc_volume 	,
		0						sgl_avg_trfc_volume ,
		regional_category		area_code     		,
		orggroup				org_group     		,
		orggroupid				org_group_id
	from map_org_regional a
	;
    commit;
	
	
	dbms_output.put_line('update for 收入和客流');
	update rpt_macro_cia_bus_income a
	set (coin_income,
		 ic_income,
		 op_income,
		 dis_amount,
		 coin_pt,
		 ic_pt,
		 psg_flow_pt,
		 dis_pt
		 ) = (
				select 	sum(b.toubi_amount), 
						sum(nvl(b.shuaka_cika_amt,0)+nvl(b.shuaka_dianziqianbao_amt,0)),
						sum(nvl(b.toubi_amount,0)+nvl(b.shuaka_cika_amt,0)+nvl(b.shuaka_dianziqianbao_amt,0)),
						sum(nvl(b.shuaka_cika_youhui_amt,0)+nvl(b.shuaka_dzqb_youhui_amt,0)),
						sum(nvl(b.toubi_count,0)),
						sum(nvl(b.shuaka_cika_count,0)+nvl(b.shuaka_dianziqianbao_count,0)),
						sum(nvl(b.toubi_count,0)+nvl(b.shuaka_cika_count,0)+nvl(b.shuaka_dianziqianbao_count,0)),
						sum(nvl(b.shuaka_cika_youhui_count,0)+nvl(b.shuaka_dzqb_youhui_count,0))
				from rpt_splysecu_flowandincome b
				where a.area_code = b.area_code
				and a.org_group_id = b.org_group_id
				and a.business_date = b.business_date
				and a.cia_date = b.oper_date
			)
	where a.business_date = v_date
	and a.area_code <> '全部'
	and nvl(a.org_group,'0') <> '区域全部';
	commit;
	
	dbms_output.put_line('update for 千车单车收入和客运量(不含全部)');
	update rpt_macro_cia_bus_income a
	set (ths_income, sgl_avg_income, ths_trfc_volume ,sgl_avg_trfc_volume)
					= (
						select 	
							round(a.op_income*1000/decode((b.op_mil*b.op_qty),0,1,(b.op_mil*b.op_qty)),2),
							round(a.op_income/decode(op_qty,0,1,op_qty),2),
							round(a.psg_flow_pt*1000/decode((b.op_mil*b.op_qty),0,1,(b.op_mil*b.op_qty)),2),
							round(a.psg_flow_pt/decode(b.op_qty,0,1,b.op_qty),2)
						from rpt_macro_cia_cap_invest b
						where a.area_code = b.area_code
						and a.org_group_id = b.org_group_id
						and a.business_date = b.business_date
						and a.cia_date = b.cia_date
					)
	where a.business_date = v_date
	and a.area_code <> '全部'
	and nvl(a.org_group,'0') <> '区域全部';
	commit;
	

	dbms_output.put_line('insert into table for 全部');
    insert /*+append*/ into rpt_macro_cia_bus_income (
		business_date		,
		cia_date			,
		coin_income   		,
		ic_income     		,
		op_income     		,
		dis_amount    		,
		ths_income    		,
		sgl_avg_income		,
		coin_pt 			,
		ic_pt 				,
		psg_flow_pt 		,
		dis_pt 				,
		ths_trfc_volume 	,
		sgl_avg_trfc_volume ,
		area_code           ,
		org_group           ,
		org_group_id
    )
    select   
		business_date           business_date		,
		cia_date			  	cia_date			,
		sum(coin_income)   		coin_income   		,		
		sum(ic_income)     		ic_income     		,
		sum(op_income)     		op_income     		,
		sum(dis_amount)    		dis_amount    		,
		0    					ths_income    		,
		0						sgl_avg_income		,
		sum(coin_pt) 			coin_pt 			,
		sum(ic_pt) 				ic_pt 				,
		sum(psg_flow_pt) 		psg_flow_pt 		,
		sum(dis_pt) 			dis_pt 				,
		0 						ths_trfc_volume 	,
		0						sgl_avg_trfc_volume ,
		area_code				area_code     		,
		'区域全部'				org_group     		,
		null					org_group_id
	from rpt_macro_cia_bus_income a
	where a.business_date = v_date
	and a.area_code <> '全部'
	and nvl(a.org_group,'0') <> '区域全部'
	group by business_date, cia_date, area_code
	union all
	select 
		business_date           business_date		,
		cia_date			  	cia_date			,
		sum(coin_income)   		coin_income   		,		
		sum(ic_income)     		ic_income     		,
		sum(op_income)     		op_income     		,
		sum(dis_amount)    		dis_amount    		,
		0    					ths_income    		,
		0						sgl_avg_income		,
		sum(coin_pt) 			coin_pt 			,
		sum(ic_pt) 				ic_pt 				,
		sum(psg_flow_pt) 		psg_flow_pt 		,
		sum(dis_pt) 			dis_pt 				,
		0 						ths_trfc_volume 	,
		0						sgl_avg_trfc_volume ,
		'全部'					area_code     		,
		null					org_group     		,
		null					org_group_id
	from rpt_macro_cia_bus_income a
	where a.business_date = v_date
	and a.area_code <> '全部'
	and nvl(a.org_group,'0') <> '区域全部'
	group by business_date, cia_date
	;
    commit;
	
	dbms_output.put_line('update for 千车单车收入和客运量(区域全部)');
	update rpt_macro_cia_bus_income a
	set (ths_income, sgl_avg_income, ths_trfc_volume ,sgl_avg_trfc_volume)
					= (
						select 	
							round(a.op_income*1000/decode((sum(b.op_mil)*sum(b.op_qty)),0,1,(sum(b.op_mil)*sum(b.op_qty))),2),
							round(a.op_income/decode(sum(b.op_qty),0,1,sum(op_qty)),2),
							round(a.psg_flow_pt*1000/decode((sum(b.op_mil)*sum(b.op_qty)),0,1,(sum(b.op_mil)*sum(b.op_qty))),2),
							round(a.psg_flow_pt/decode(sum(b.op_qty),0,1,sum(b.op_qty)),2)
						from rpt_macro_cia_cap_invest b
						where a.area_code = b.area_code
						and a.business_date = b.business_date
						and a.cia_date = b.cia_date
					)
	where a.business_date = v_date
	and a.area_code <> '全部'
	and a.org_group = '区域全部';
	commit;
	
	dbms_output.put_line('update for 千车单车收入和客运量(全部)');
	update rpt_macro_cia_bus_income a
	set (ths_income, sgl_avg_income, ths_trfc_volume ,sgl_avg_trfc_volume)
					= (
						select 	
							round(a.op_income*1000/decode((sum(b.op_mil)*sum(b.op_qty)),0,1,(sum(b.op_mil)*sum(b.op_qty))),2),
							round(a.op_income/decode(sum(b.op_qty),0,1,sum(op_qty)),2),
							round(a.psg_flow_pt*1000/decode((sum(b.op_mil)*sum(b.op_qty)),0,1,(sum(b.op_mil)*sum(b.op_qty))),2),
							round(a.psg_flow_pt/decode(sum(b.op_qty),0,1,sum(b.op_qty)),2)
						from rpt_macro_cia_cap_invest b
						where a.business_date = b.business_date
						and a.cia_date = b.cia_date
					)
	where a.business_date = v_date
	and a.area_code = '全部'
	and nvl(a.org_group,'0') <> '区域全部';
	commit;
	
	
	
	
	dbms_output.put_line('completed'); 	
end p_macro_cia;
/
