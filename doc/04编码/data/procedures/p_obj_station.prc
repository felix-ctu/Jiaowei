create or replace procedure p_obj_station
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_obj_station                                                            		*
*                                                                                               *
*  File Name   : p_obj_station.prc                                                        		*
*                                                                                               *
*  Description : p_obj_station                                                            		*
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 17-Dec-16   1.0      Liu Mingshun      Initial release                                        *
************************************************************************************************/
	v_date date := getbusinessdate;
begin

    execute immediate 'truncate table obj_station drop storage';


    dbms_output.put_line('insert into table obj_station');
    insert /*+append*/ into obj_station (
		station_id 		,
		station_no		,
		station_name 	,
		electronic_board,
		shelter 		,
		harbor_shaped 	,
		hange_station	,
		length 			,
		area_code 		,
		routes 			,
		longitude 		,
		latitude 		,
		org_id 			,
		org_group		,
		org_group_id	,
		parent_org_id
    )
    select
		a.stationid 							station_id 		,
		a.stationno								station_no		,
		a.stationname 							station_name 	,
		decode(a.haseleboard,'1','有','无') 	electronic_board,
		decode(a.haswaitingboisk,'1','有','无') shelter			,
		decode(a.isfleetstation,'1','是','否')	harbor_shaped 	,
		decode(a.ishangestation,'1','是','否')	hange_station 	,
		a.stationlength 						length 			,
		null 									area_code 		,
		null 									routes 			,
		a.longitude 							longitude 		,
		a.latitude 								latitude 		,
		null 									org_id 			,
		null									org_group		,
		null									org_group_id	,
		null 									parent_org_id
	from mcstationinfogs a
	where a.isactive = 1;	
    commit;

		
	dbms_output.put_line('update routes');
    update obj_station rpt
        set routes = (select wmsys.wm_concat(to_char(b.routename))
					  from mcrroutestationgs a, mcrouteinfogs b
					  where a.stationid = rpt.station_id
					  and a.routeid = b.routeid
					  and b.isactive = 1
					  )
	;
    commit;
      
	  
	dbms_output.put_line('update station_id');
    update obj_station rpt
        set station_id = station_no
	;
    commit;  
	
	dbms_output.put_line('update parent_org_id');
    update obj_station rpt
        set parent_org_id = (select b.parentorgid
							 from mcorginfogs b
							 where rpt.org_id = b.orgid
							 and b.isactive = 1
							 )
    where exists (select 1 from mcorginfogs c where rpt.org_id = c.orgid and c.isactive = 1);
    commit;
	
	dbms_output.put_line('update org_group, area_code');
    update obj_station rpt
        set (org_group, org_group_id, area_code) = (select b.orggroup, b.orggroupid, b.regional_category
									 from map_org_regional b
									 where rpt.org_id = b.orgid
									 )
    where exists (select 1 from map_org_regional c where rpt.org_id = c.orgid);
    commit;
	  
	
	update obj_station rpt set area_code = '中心城区', org_group = '成都市公共交通集团公司' ;
    commit;

	
	--更新历史记录表
	delete from obj_station_m where business_date = v_date;
	commit;
	insert into obj_station_m
	select v_date, a.*
	from obj_station a;
	commit;
	
    dbms_output.put_line('completed');

end p_obj_station;
/
