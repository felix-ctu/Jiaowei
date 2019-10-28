create or replace procedure p_obj_route
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_obj_route                                                              		*
*                                                                                               *
*  File Name   : p_obj_route.prc                                                          		*
*                                                                                               *
*  Description : p_obj_route                                                              		*
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 17-Dec-16   1.0      Liu Mingshun      Initial release                                        *
************************************************************************************************/
	v_date date := getbusinessdate;	
begin

    execute immediate 'truncate table obj_route drop storage';

    dbms_output.put_line('insert into table obj_route');
    insert /*+append*/ into obj_route (
		sub_route_id 		,
		route_id 			,
		route_name 			,
		bus_count 			,
		begin_date 			,
		linkman 			,
		route_grade 		,
		route_style			,
		org_id 				,
		parent_org_id 		,
		area_code 			,
		end_date			,
		isactive			,
		route_type 			,
		is_end_with_alphabet,
		is_suburban 	    ,
		org_group 			,
		org_group_id
    )
    select 
		null 								sub_route_id        ,
		a.routeid 							route_id            ,
		a.routename 						route_name          ,
		null	 							bus_count           ,
		a.begindate 						begin_date          ,
		null 								linkman             ,
		a.routegrade 						route_grade         ,
		a.routestyle						route_style			,
		a.orgid 							org_id              ,
		null 								parent_org_id       ,
		null 								area_code 			,
		a.enddate							end_date			,
		decode(a.isactive,'1','是','否') 	isactive			,
		null								route_type			,
		case when ascii(substr(a.routename,-1,1)) between 65 and 122
			 then '是' else '否'
		end									is_end_with_alphabet,
		null								is_suburban			,
		null								org_group			,
		null								org_group_id
	from mcrouteinfogs a
	where a.isactive = 1
	and v_date between a.begindate and a.enddate
	and exists (select 1 from mcsubrouteinfogs b 
				where a.routeid = b.routeid 
				and b.isactive=1 
				and v_date between b.begindate and b.enddate)
	;
    commit;
		
    dbms_output.put_line('update sub_route_id');
    update obj_route rpt
        set sub_route_id = (select wmsys.wm_concat(a.subrouteid)
							   from mcsubrouteinfogs a
							   where rpt.route_id = a.routeid
							   and a.isactive = 1
							   and v_date between a.begindate and a.enddate
                              )
    where exists (select 1 from mcsubrouteinfogs b 
				  where rpt.route_id = b.routeid 
				  and b.isactive = 1
				  and v_date between b.begindate and b.enddate)
	;
    commit;
	
  
	dbms_output.put_line('update linkman, parent_org_id');
    update obj_route rpt
        set (linkman, parent_org_id, org_name) = (select b.linkman, b.parentorgid, b.orgname
										from mcorginfogs b
										where rpt.org_id = b.orgid
										and b.isactive = 1
										)
    where exists (select 1 from mcorginfogs c where rpt.org_id = c.orgid and c.isactive = 1)
	;
    commit;
	
	
	dbms_output.put_line('update bus_count');
    update obj_route rpt
        set bus_count = (select count(a.busid)
						from mcrbusroutegs a
						where rpt.route_id = a.routeid
						)
    where exists (select 1 from mcrbusroutegs c where rpt.route_id = c.routeid)
	;
    commit;
	

	
	dbms_output.put_line('update route_grade_manual');
    update obj_route rpt
        set route_grade_manual = 
					(select a.route_grade
					from map_route_grade a
					where rpt.route_id = a.route_id
					)
	;
    commit;
	
	dbms_output.put_line('update route_grade');
    update obj_route rpt
        set route_grade = (case when route_name in ('K1','K2') 			then '快线'
								when route_grade_manual = '支线' 		then '支线'
								when route_grade_manual = '社区巴士'　	then '微线'
								else '干线'
							end)
	;
    commit;
	
	
	dbms_output.put_line('update org_group, area_code');
    update obj_route rpt
        set (org_group,org_group_id, area_code) = (select b.orggroup,b.orggroupid, b.regional_category
									 from map_org_regional b
									 where rpt.org_id = b.orgid
									 )
    where exists (select 1 from map_org_regional c where rpt.org_id = c.orgid)
	;
    commit;
	
	
	dbms_output.put_line('update route_type');
	update obj_route rpt set route_type = area_code
	;
    commit;
	
	
	dbms_output.put_line('update route_length');
	update obj_route rpt 
		set route_length = (
							select sum(routelength)
							from (
							select a.routeid, a.subrouteid,'单程', sum(a.sngmile)/2 routelength
							from mcsegmentinfogs a, mcsubrouteinfogs b
							where rundirection in ('1','2')
							and a.subrouteid = b.subrouteid
							and ismainsub = 1
							and v_date between b.begindate and b.enddate
							group by a.routeid, a.subrouteid
							union all
							select a.routeid, a.subrouteid,'环线', sum(sngmile) routelength
							from mcsegmentinfogs a, mcsubrouteinfogs b
							where rundirection =3
							and b.ismainsub = 1
							and a.subrouteid = b.subrouteid
							and v_date between b.begindate and b.enddate
							group by a.routeid, a.subrouteid
							) a
							where a.routeid = rpt.route_id
						)
	;
	commit;
	
		
	--***********************************************************************************
	
	--首末站点

	execute immediate 'truncate table obj_route_smzd drop storage';
    

    dbms_output.put_line('insert into table obj_route_smzd');
    insert /*+append*/ into obj_route_smzd (
		sn 			   ,
		route_id 	   ,
		segment_name   ,
		fst_station_no ,
		fst_station    ,
		lst_station_no ,
		lst_station    ,
		isactive 	
    )
    select 
		rownum 								sn, 
		a.routeid							route_id, 
		a.segmentname						segment_name, 
		null								fst_station_no,
		a.fststationid						fst_station, 
		null								lst_station_no,
		a.lststationid						lst_station, 
		decode(a.isactive,'1','是','否')	isactive
	from mcsegmentinfogs a
	where exists (select 1 from obj_route b where a.routeid = b.route_id);
    commit;


	dbms_output.put_line('update fst_station');
    update obj_route_smzd rpt
        set (fst_station,fst_station_no) = (select a.stationname, a.stationno
											from mcstationinfogs a
											where a.stationid = rpt.fst_station
										)
	;
    commit;
    
	dbms_output.put_line('update lst_station');
    update obj_route_smzd rpt
        set (lst_station,lst_station_no) = (select a.stationname, a.stationno
										    from mcstationinfogs a
										    where a.stationid = rpt.lst_station
										  )
	;						  
    commit;

	
	--途径站点
	execute immediate 'truncate table obj_route_tjzd drop storage';
    

    dbms_output.put_line('insert into table obj_route_tjzd');
    insert /*+append*/ into obj_route_tjzd (
		sn				  ,
		route_id		  ,
		sub_route_name    ,
		segment_id		  ,
		segment_name      ,
		run_direction	  ,
		station_no        ,
		station_name      ,
		station_type      ,
		electronic_board  ,
		shelter			  ,
		harbor_shaped 	  ,
		station_length    ,
		region_area       ,
		area_code 		  ,
		single_serial_id  ,
		dual_serial_id    ,
		longitude 		  ,
		latitude          
    )
	select 
		rownum									sn				,
		a.routeid								route_id		,
		a.subrouteid 							sub_route_name	,
		a.segmentid								segment_id		,
		null									segment_name    ,
		null									run_direction	,
		c.stationno								station_no      ,
		c.stationname							station_name    ,
		a.stationtype							station_type    ,
		decode(c.haseleboard,'1','有','无') 	electronic_board,
		decode(c.haswaitingboisk,'1','有','无') shelter			,
		decode(c.isfleetstation,'1','是','否')	harbor_shaped 	,
		c.stationlength 						station_length  ,
		c.regionarea							region_area     ,
		null 									area_code 		,
		a.sngserialid 							single_serial_id,
		a.dualserialid 							dual_serial_id  ,
		c.longitude 							longitude 		,
		c.latitude 								latitude        
	from mcrsegmentstationgs a, mcstationinfogs c
	where a.isactive = 1
	and a.stationid = c.stationid
	and exists (select 1 from obj_route rpt where rpt.route_id = a.routeid)
	and exists (select 1 from mcsubrouteinfogs b 
				  where a.subrouteid = b.subrouteid
				  and b.isactive = 1
				  and v_date between b.begindate and b.enddate)
	order by a.segmentid, a.sngserialid
	;
	commit;

	
	dbms_output.put_line('update sub_route_name');
    update obj_route_tjzd rpt
        set sub_route_name = (select a.subroutename
					     from mcsubrouteinfogs a
					     where a.subrouteid = rpt.sub_route_name
                          )
	;
    commit;
	
	dbms_output.put_line('update station_type');
    update obj_route_tjzd rpt
        set station_type = (select a.code_desc
					     from map_code_master a
					     where a.code_value = rpt.station_type
						 and a.code_category = 'STATIONTYPE'
                          )
	;
    commit;
	
	
	dbms_output.put_line('update segment_name');
    update obj_route_tjzd rpt
        set (segment_name,run_direction)
						= (select a.segmentname, a.rundirection
							from mcsegmentinfogs a
							where a.segmentid = rpt.segment_id
                          )
	;
    commit;
	
	
	dbms_output.put_line('update area_code');
    update obj_route_tjzd rpt
        set area_code = (select a.area_code
					     from obj_route a
					     where a.route_id = rpt.route_id
                          )
	;
    commit;
	
	
	
	--峰段划分
	execute immediate 'truncate table obj_route_fdhf drop storage';
    

    dbms_output.put_line('insert into table obj_route_fdhf');
    insert /*+append*/ into obj_route_fdhf (
		id 					,
        route_id 			,
        name 			,
        week_start 			,
        week_end 			,
        start_time 			,
        end_time 			,
        departure_interval 	,
        turnaround_time 	
    )
	select 
		rownum 					id 					,
		routeid					route_id 			,
		timephasename			name 			,
		beginweek				week_start 			,
		endweek					week_end 			,
		starttime				start_time 			,
		endtime					end_time 			,
		timephaseinterval		departure_interval 	,
		timephasecircletime		turnaround_time 	
	from mcroutetimephasegs a
	where exists (	select 1 
					from obj_route rpt 
					where rpt.route_id = a.routeid
				);
	commit;

	--更新历史记录表
	delete from obj_route_m where business_date = v_date;
	commit;
	insert into obj_route_m
	select v_date, a.*
	from obj_route a;
	commit;
	
	delete from obj_route_smzd_m where business_date = v_date;
	commit;
	insert into obj_route_smzd_m
	select v_date, a.*
	from obj_route_smzd a;
	commit;
	
	delete from obj_route_tjzd_m where business_date = v_date;
	commit;
	insert into obj_route_tjzd_m
	select v_date, a.*
	from obj_route_tjzd a;
	commit;
	
	delete from obj_route_fdhf_m where business_date = v_date;
	commit;
	insert into obj_route_fdhf_m
	select v_date, a.*
	from obj_route_fdhf a;
	commit;
	
	
    dbms_output.put_line('completed');

end p_obj_route;
/
