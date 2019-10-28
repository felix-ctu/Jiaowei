create or replace procedure p_obj_businfo
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_obj_businfo                                                            		*
*                                                                                               *
*  File Name   : p_obj_businfo.prc                                                        		*
*                                                                                               *
*  Description : p_obj_businfo                                                            		*
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 17-Dec-16   1.0      Liu Mingshun      Initial release                                        *
************************************************************************************************/
	v_date date := getbusinessdate;	
begin

    execute immediate 'truncate table obj_businfo drop storage';

    dbms_output.put_line('insert into table obj_businfo');
    insert /*+append*/ into obj_businfo (
		bus_id 				,
		card_id 			,
		bus_self_id 		,
		oil_type 			,
		bus_type 			,
		bus_length 			,
		buy_date 			,
		use_date 			,
		bus_status 			,
		bus_operate_type    ,
		seat_count 			,
		stand_count 		,
		route_id 			,
		org_id 				,
		org_group			,
		parent_org_id 		,
		area_code 			,
		is_active 			,
		bus_grade 			,
		body_light_led 		,
		head_light_led 		,
		air_conditioned 	,
		low_floor 			,
		ic_enabled 			,
		bus_machine_number  ,
		stdcoefficient		,
		approved_count		,
		standard_oil_num
    )
    select 
      a.busid									bus_id 				,
      a.cardid									card_id 			,
      a.busselfid								bus_self_id 		,
      decode(a.oiltype,'CNG','天然气(CNG)','LNG','液化天然气(LNG)',oiltype)	oil_type,
      a.bustype 								bus_type 			,
      a.buslength 								bus_length 			,
      a.buydate 								buy_date 			,
      a.usedate 								use_date 			,
      a.busstatus 								bus_status 			,
	  a.busoperatetype							bus_operate_type	,
      a.seatcount 								seat_count 			,
      a.standcount 								stand_count 		,
      null 										route_id 			,
      a.orgid 									org_id 				,
	  null  									org_group			,
      null 										parent_org_id 		,
      null 										area_code 			,  
      a.isactive 								is_active 			,
      a.busgrade 								bus_grade 			,
      decode(a.hasinbusled,'1','有','无') 		body_light_led 		,
      decode(a.hasheadbusled,'1','有','无') 	head_light_led 		,
      decode(a.hascondition,'1','是','否') 		air_conditioned 	,
      decode(a.islowfloor,'1','是','否') 		low_floor 			,
      decode(a.hasiccardeqmt,'1','有','无') 	ic_enabled 			,
      a.productid	 							bus_machine_number  ,
	  a.stdcoefficient							stdcoefficient		,
	  nvl(a.seatcount,0)+nvl(a.standcount,0)	approved_count		,
	  standardoilnum							standard_oil_num
	from mcbusinfogs a
	where a.isactive=1;
    commit;
    

    dbms_output.put_line('update route_id');
    update obj_businfo rpt
        set route_id = (select b.routeid
					    from mcrbusroutegs b
					    where rpt.bus_id = b.busid
                       )
    where exists (select 1 from mcrbusroutegs c where rpt.bus_id = c.busid)
	;
    commit;
    
	
	dbms_output.put_line('update parent_org_id');
    update obj_businfo rpt
        set (org_name,parent_org_id) = (select b.parentorgid,b.orgname
							 from mcorginfogs b
							 where rpt.org_id = b.orgid
							 and b.isactive = 1
							 )
    where exists (select 1 from mcorginfogs c where rpt.org_id = c.orgid and c.isactive = 1)
	;
    commit;
	
	
	dbms_output.put_line('update bus_status');
    update obj_businfo rpt
        set bus_status = (select m.code_desc
						  from map_code_master m
						  where rpt.bus_status = m.code_value
						  and m.code_category = 'BUS_STATUS'
						 )
	;
    commit;
	
	
	dbms_output.put_line('update bus_operate_type');
    update obj_businfo rpt
        set bus_operate_type = (select m.code_desc
								from map_code_master m
								where rpt.bus_operate_type = m.code_value
								and m.code_category = 'BUS_OPERATE_TYPE'
								)
	;
    commit;
    
	
	dbms_output.put_line('update org_group, area_code');
    update obj_businfo rpt
        set (org_group,org_group_id, area_code) = (select b.orggroup,b.orggroupid,b.regional_category
									 from map_org_regional b
									 where rpt.org_id = b.orgid
									 )
    where exists (select 1 from map_org_regional c where rpt.org_id = c.orgid)
	;
    commit;
	
	dbms_output.put_line('update years_in_use');
    update obj_businfo rpt
        set years_in_use = round((v_date - nvl(buy_date,v_date))/365,2)
    ;
    commit;
	
	
	
	--更新历史记录表
	delete from obj_businfo_m where business_date = v_date;
	commit;
	insert into obj_businfo_m
	select v_date, a.*
	from obj_businfo a;
	commit;
	
	dbms_output.put_line('completed');
	
	
end p_obj_businfo;
/

