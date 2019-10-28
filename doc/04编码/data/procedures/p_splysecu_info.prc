create or replace procedure p_splysecu_info
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_splysecu_info                                                            	*
*                                                                                               *
*  File Name   : p_splysecu_info.prc                                                        	*
*                                                                                               *
*  Description : 供应保障		                                                            	*
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 11-Nov-16   1.0      Liu Mingshun      Initial release                                        *
************************************************************************************************/
	v_date				date:= getbusinessdate;
	v_month				varchar2(20);
	v_partition			varchar2(20);
	v_partition_day		varchar2(20);
	v_date_immediate 	varchar2(20);

begin

	v_partition 		:= 'P_'||to_char(v_date,'yyyymm');
	v_date_immediate 	:= to_char(v_date,'yyyymmdd');
	v_partition_day 	:= 'P_'||to_char(v_date,'yyyymmdd');
	v_month				:= to_char(v_date,'yyyymm');
	
	--***************************报表用投币和收入信息**********************
    delete from rpt_splysecu_flowandincome where business_date = v_date;
	commit;
	
    dbms_output.put_line('insert into table for 刷卡电子钱包');
    insert /*+append*/ into rpt_splysecu_flowandincome (
		business_date				,
		oper_date					,
		route_id					,
		shuaka_cika_count			,
		shuaka_cika_amt				,
		shuaka_cika_youhui_count	,
		shuaka_cika_youhui_amt		,
		shuaka_dianziqianbao_count	,
		shuaka_dianziqianbao_amt	,
		shuaka_dzqb_youhui_count	,
		shuaka_dzqb_youhui_amt		,
		toubi_count					,
		toubi_amount				,
		area_code		          	,
		org_group		          	,
		org_group_id
    )
    select  
		v_date						business_date				,
		trunc(a.riqi) 				oper_date					,
		c.route_id					route_id					,
		null						shuaka_cika_count			,
		null						shuaka_cika_amt				,
		null						shuaka_cika_youhui_count	,
		null						shuaka_cika_youhui_amt		,
		sum(a.dianziqianbaorenci)	shuaka_dianziqianbao_count	,
		sum(a.dianziqianbao)		shuaka_dianziqianbao_amt	,
		sum(a.dianziqianbaorenci)	shuaka_dzqb_youhui_count	,
		sum(a.dianziqianbaorenci*2-a.dianziqianbao) shuaka_dzqb_youhui_amt,
		null						toubi_count					,
		null						toubi_amount				,
		c.area_code 				area_code					,
		c.org_group 				org_group					,
		c.org_group_id	 			org_group_id	
	from as_sc_icincome a, obj_businfo_m c
	where a.chehao = c.bus_self_id
	and a.riqi >= trunc(v_date)
	and a.riqi <  trunc(v_date+1)
	and c.business_date = v_date
	group by trunc(a.riqi) ,c.route_id, c.area_code, c.org_group, c.org_group_id
	;
	commit;
	
	
	dbms_output.put_line('update 客运能力-刷卡次卡');
	execute immediate '
	update rpt_splysecu_flowandincome a
	set (shuaka_cika_count,
		 shuaka_cika_amt,
		 shuaka_cika_youhui_count,
		 shuaka_cika_youhui_amt
		 ) = 
				(select count(b.cardno), 
						sum(b.consume/2), 
						count(b.cardno), 					
						count(b.cardno)*2-sum(b.consume/2)	
				 from v_tbmonth_temp partition ('||v_partition_day||') b
				 where  a.oper_date = trunc(b.consumedate)
				 and b.lineno = a.route_id
				 )
	where to_char(business_date,''yyyymmdd'') = '||v_date_immediate;
	commit;
	
	
	dbms_output.put_line('update 客运能力-投币');
	update rpt_splysecu_flowandincome a
	set (toubi_count,toubi_amount) = 
				(select sum(b.xianjin)/2, sum(b.xianjin)
				 from as_sc_cashincome b, obj_businfo_m c
				 where a.oper_date = trunc(b.riqi)
				 and b.chehao = c.bus_self_id
				 and c.route_id = a.route_id
				 and c.org_group_id = a.org_group_id
				 and a.business_date = c.business_date
				 )
	where business_date = v_date;
	commit;
	
	
	--***************************线路投入**********************
    delete from rpt_splysecu_routeinvest where yearmonth = v_month;
	commit;
	
    dbms_output.put_line('insert into table for 线路投入');
    insert /*+append*/ into rpt_splysecu_routeinvest (
		yearmonth				,
		route_count		        ,
		route_length	        ,
		sys_coverage	        ,
		area_code		        ,
		org_group		        ,
		org_group_id	
    )
    select  
		v_month 							yearmonth		,
		count(route_id)						route_count		,
		sum(route_length)					route_length	,
		100									sys_coverage	,
		area_code 							area_code		,
		org_group 							org_group		,
		org_group_id	 					org_group_id	
	from obj_route_m a
	where business_date = v_date
	group by area_code,org_group,org_group_id
	;
    commit;
	
	--***************************线网投入????**********************
    delete from rpt_splysecu_netinvest where yearmonth = v_month;
	commit;
	
    dbms_output.put_line('insert into table for 线网投入');
    insert /*+append*/ into rpt_splysecu_netinvest (
		yearmonth				,
		routenet_length		    ,
		route_length		    ,
		route_count			    ,
		route_repeat_ratio	    ,
		area_code			    ,
		org_group			    ,
		org_group_id		    ,
		routenet_density	    ,
		route_density		
	)	
	select 
		v_month							 	yearmonth			,
	    null								routenet_length		,
	    null								route_length		,
	    null								route_count			,
	    null								route_repeat_ratio	,
	    area_code							area_code			,
	    org_group							org_group			,
	    org_group_id						org_group_id		,
	    null								routenet_density	,
	    null								route_density			
	from obj_route_m a
	where a.business_date = v_date
	group by area_code,org_group,org_group_id
	;
    commit;	
	
	--***************************运能投入**********************
    delete from rpt_splysecu_capacity_invest where business_date = v_date;
	commit;
	
    dbms_output.put_line('insert into table for 运能投入');
    execute immediate '
	insert into rpt_splysecu_capacity_invest (
		business_date			, 
		oper_date				,
        dep_shift_count		    ,
        oper_mileage		    ,
        trans_capacity		    ,
        trans_count_per_km	    ,
        trans_count_per_bus	    ,
        area_code			    ,
        org_group			    ,
        org_group_id		
	)	
	select 
		a.rundatadate		business_date			,
		a.rundatadate		oper_date				,
		count(a.busrrid)	dep_shift_count		    ,
		sum(decode(sign(a.gpsmile),1,a.gpsmile,a.milenum))		oper_mileage		    ,
		null				trans_capacity		    ,
		null				trans_count_per_km	    ,
		null				trans_count_per_bus	    ,
		c.regional_category	area_code			    ,
		c.orggroup			org_group			    ,
		c.orggroupid		org_group_id			 
	from bz_busrunrecordld partition ('||v_partition||') a, map_org_regional c
	where a.orgid = c.orgid
	and a.rectype = ''1''
	and a.isactive = ''1''
	and to_char(a.rundatadate,''yyyymmdd'') = '||v_date_immediate||'
	group by a.rundatadate, c.regional_category, c.orggroup, c.orggroupid'
	;
    commit;	
	
	
	dbms_output.put_line('update 客运能力-刷卡投币人次');
	update rpt_splysecu_capacity_invest a
	set trans_capacity = 
				(select sum(b.shuaka_cika_count + b.shuaka_dianziqianbao_count + b.toubi_count)
				 from rpt_splysecu_flowandincome b
				 where a.oper_date = b.oper_date
				 and a.org_group_id = b.org_group_id
				 and a.business_date = b.business_date
				 )
	where business_date = v_date;
	commit;
	
	
	dbms_output.put_line('update 客运能力-单位营运公里载客数');
	update rpt_splysecu_capacity_invest a
	set trans_count_per_km = round(decode(oper_mileage,0,0,trans_capacity/oper_mileage),2)
	where business_date = v_date;
	commit;
	
	
	dbms_output.put_line('update 客运能力-日平均载客量');
	update rpt_splysecu_capacity_invest a
	set trans_count_per_bus = round(decode(dep_shift_count,0,0,trans_capacity/dep_shift_count),2)
	where business_date = v_date;
	commit;
	
	
	--***************************车辆投入**********************
    delete from rpt_splysecu_businvest where yearmonth = v_month;
	commit;
	
    dbms_output.put_line('insert into table for 车辆投入');
	execute immediate '
    insert into rpt_splysecu_businvest(
		yearmonth				,
        own_bus_count		    ,
        std_bus_count		    ,
        advanced_bus_count	    ,
        aircon_bus_count	    ,
        lowfloor_bus_count	    ,
        gas_bus_count		    ,
        diesel_bus_count	    ,
        cng_bus_count		    ,
        mix_bus_count		    ,
        area_code			    ,
        org_group			    ,
        org_group_id		
	)	
	select 
		to_char(a.business_date,''yyyymm'')							yearmonth				,			
		count(*)													own_bus_count		    ,
		sum(stdcoefficient)											std_bus_count		    ,
		null														advanced_bus_count	    ,
		sum(case when air_conditioned =''是'' then 1 else 0 end)	aircon_bus_count	    ,
		sum(case when low_floor  =''是'' then 1 else 0 end)			lowfloor_bus_count	    ,
		sum(case when oil_type=''汽油'' then 1 else 0 end)			gas_bus_count		    ,
		sum(case when oil_type=''柴油'' then 1 else 0 end)			diesel_bus_count	    ,
		sum(case when oil_type like ''%天然气%'' then 1 else 0 end)	cng_bus_count		    ,
		sum(case when oil_type like ''%/%'' or oil_type like ''%混合%'' 
				 then 1 else 0 end)									mix_bus_count		    ,
		area_code 													area_code				,
		org_group 													org_group 				,
	    org_group_id												org_group_id 										 							 	
	from obj_businfo_m a
	where a.bus_status = ''正常''
	and to_char(a.business_date,''yyyymmdd'') = '||v_date_immediate||'
	and exists (select 1 from bz_busrunrecordld partition ('||v_partition||') b where a.bus_id = b.busid)
	group by to_char(business_date,''yyyymm''),area_code,org_group,org_group_id'
	;
    commit;	

	--***************************车辆利用率**********************
    delete from rpt_splysecu_busutilization where business_date = v_date;
	commit;
	
    dbms_output.put_line('insert into table for 车辆利用率');
 	execute immediate '
	insert into rpt_splysecu_busutilization (
		business_date			, 
		oper_date				,
		oper_bus_count		    ,
		own_bus_count		    ,
		bus_utilization		    ,
		area_code			    ,
		org_group			    ,
		org_group_id		
	)	
	select 
		a.business_date												business_date			,
	    b.rundatadate 												oper_date				,		
		count(distinct b.busid)										oper_bus_count		    ,
		null														own_bus_count		    ,
		null														bus_utilization		    ,
		a.area_code 												area_code				,
		a.org_group 												org_group 				,
	    a.org_group_id												org_group_id 										 							 	
	from obj_businfo_m a, bz_busrunrecordld partition ('||v_partition||') b
	where a.bus_status = ''正常''
	and a.bus_id = b.busid
	and a.business_date = b.rundatadate
	and to_char(a.business_date,''yyyymmdd'') = '||v_date_immediate||'
	group by a.business_date, b.rundatadate,a.area_code,a.org_group,a.org_group_id'
	;
    commit;	


	update rpt_splysecu_busutilization rpt
	set (own_bus_count, bus_utilization) 
					= (select b.own_bus_count, decode(b.own_bus_count,null,0,round(rpt.oper_bus_count/b.own_bus_count,2))
					   from rpt_infra_bus b
					   where rpt.org_group_id = b.org_group_id
					   and b.yearmonth = v_month
					)
	where rpt.business_date = v_date
	;
	commit;

	
	--***************************万人拥有公交标台数**********************
    delete from rpt_splysecu_stdcoeffby10th where query_year = to_char(v_date,'yyyy');
	commit;
	
    dbms_output.put_line('insert into table for 万人拥有公交标台数');
	insert into rpt_splysecu_stdcoeffby10th (
		query_year				,
		population_type			,
		std_count				,
		population_number		,
		std_count_by_10thousand	,
		area_code				,
		org_group				,
		org_group_id			
	)	
	select 
		substr(a.yearmonth,1,4)										query_year				,	
		'常住人口'													population_type			,
		a.std_bus_count												std_count				,
		b.code_value												population_number		,
		round(a.std_bus_count*10000/b.code_value,2)                 std_count_by_10thousand	,
		a.area_code 												area_code				,
		a.org_group 												org_group				,
	    a.org_group_id												org_group_id									 							 	
	from rpt_infra_bus a, map_code_master b
	where a.yearmonth = v_month
	and a.area_code = b.code_desc
	and b.code_category = 'POPULATION'
	;
    commit;	

	
	--***************************客流与运力配置分析**********************
    delete from rpt_splysecu_passflowtocap where business_date = v_date;
	commit;
	
    dbms_output.put_line('insert into table for 客流与运力配置分析');
	execute immediate '
	insert into rpt_splysecu_passflowtocap (
		business_date			, 
		oper_date				,
        time_section	        ,
        route_name		        ,
        route_id		        ,
        oper_cap		        ,
        passenger_flow	        ,
        ratio			        ,
        area_code		        ,
        org_group		        ,
        org_group_id	
	)	
	select 
		a.rundatadate			business_date			,
	    a.rundatadate			oper_date				,
		m.remarks				time_section	        ,
		b.route_name			route_name		        ,
		a.routeid				route_id		        ,
		sum(d.approved_count)   oper_cap		        ,
		0		                passenger_flow	        ,
		0	                    ratio			        ,
		b.area_code				area_code		        ,
		b.org_group				org_group		        ,
	    b.org_group_id			org_group_id				 	
	from bz_busrunrecordld partition ('||v_partition||') a, obj_route_m b, map_code_master m, obj_businfo_m d
	where a.routeid = b.route_id
	and a.rectype = ''1''
	and a.isactive = ''1''
	and a.rundatadate = b.business_date
	and a.busid = d.bus_id
	and b.business_date = d.business_date
	and m.code_category =''TIME_SECTION''
	and to_char(a.leavetime,''hh24:mi:ss'') between m.code_value and m.code_desc
	and to_char(b.business_date,''yyyymmdd'') = '||v_date_immediate||'
	group by a.rundatadate, b.route_name, a.routeid, b.area_code, b.org_group, b.org_group_id, m.remarks'
	;
    commit;	
	
    dbms_output.put_line('update 客流量???');
	execute immediate '
	update rpt_splysecu_passflowtocap a
	set passenger_flow = (select count(*)
						 from v_tbmonth_temp partition ('||v_partition_day||') b, map_code_master m
						 where a.route_id = b.lineno
						 and a.time_section = m.remarks
						 and to_char(b.consumedate,''hh24:mi:ss'') between m.code_value and m.code_desc
						 )
	where to_char(business_date,''yyyymmdd'') = '||v_date_immediate;
	commit;
	
	dbms_output.put_line('update 客流量/运力配置比例');
	update rpt_splysecu_passflowtocap
	set ratio = decode(oper_cap, 0, 0, round(passenger_flow/oper_cap,2))
	where business_date = v_date;
	commit;

	--***************************优先设施分析???**********************
    delete from rpt_splysecu_piorfacility where yearmonth = v_month;
	commit;
	
    dbms_output.put_line('insert into table for 优先设施分析');
	insert into rpt_splysecu_piorfacility (
		yearmonth					,
		bus_lane_length				,
		priority_intersection_count	,
		area_code					,
		org_group					,
		org_group_id				
	)	
	select 
		v_month					yearmonth						,	
		sum(bus_lane_length)	bus_lane_length				    ,	
		null					priority_intersection_count	    ,	--'优先路口个数';
		'中心城区'				area_code					    ,	
		null                    org_group					    ,	
		null                    org_group_id				    	
	from map_bus_lane
	;
    commit;	
	
	dbms_output.put_line('completed'); 	
end p_splysecu_info;
/
