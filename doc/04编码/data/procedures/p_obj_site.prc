create or replace procedure p_obj_site
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_obj_site                                                            			*
*                                                                                               *
*  File Name   : p_obj_site.prc                                                        			*
*                                                                                               *
*  Description : p_obj_site                                                            			*
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 17-Dec-16   1.0      Liu Mingshun      Initial release                                        *
************************************************************************************************/
	v_date date := getbusinessdate;
begin

    execute immediate 'truncate table obj_site drop storage';


    dbms_output.put_line('insert into table obj_site');
    insert /*+append*/ into obj_site (
		site_id			,
		org_id			,
		site_name		,
		site_type		,
		longitude		,
		latitude		,
		cctv			,
		site_from		,
		site_used_for	,
		route_name		,
		area_code		,
		region_area		,
		site_volume 	,
		site_square		
    )
    select 
		null 		                 	 site_id		,
		null 		                 	 org_id			,
		a.site_name 		             site_name		,
		a.site_type_actual               site_type		,
		a.longitude                		 longitude		, 
		a.latitude	                 	 latitude		, 
		'有'							 cctv			,
		a.site_from						 site_from		,
		''			 					 site_used_for	,
		a.oper_route					 route_name		,
		a.area_code						 area_code		,
		a.region_area 					 region_area	,
		null			 				 site_volume	,
		a.site_square      				 site_square	
	from rpt_site_from_cdjw a;
    commit;

	--更新历史记录表
	delete from obj_site_m where business_date = v_date;
	commit;
	insert into obj_site_m
	select v_date, a.*
	from obj_site a;
	commit;
	
    dbms_output.put_line('completed');

end p_obj_site;
/
