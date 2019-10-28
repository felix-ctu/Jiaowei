create or replace procedure p_obj_corporate
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_obj_corporate                                                               	*
*                                                                                               *
*  File Name   : p_obj_corporate.prc                                                           	*
*                                                                                               *
*  Description : p_obj_corporate                                                               	*
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 17-Dec-16   1.0      Liu Mingshun      Initial release                                        *
************************************************************************************************/
	v_date date := getbusinessdate;	
begin

    execute immediate 'truncate table obj_corporate drop storage';

    dbms_output.put_line('insert into table obj_corporate');
    insert /*+append*/ into obj_corporate (
		org_id 			 ,
		org_name 		 ,
		linkman 		 ,
		principal 		 ,
		emp_count 		 ,
		bus_count 		 ,
		route_count 	 ,
		site_count 		 ,
		driver_count 	 ,
		address 		 ,
		register_date	 ,
		telephone 		 ,
		fax 			 ,
		post 			 ,
		parent_org_id 	 ,
		region_area 	 ,
		area_code 		 ,
		parent_org_name  ,
		org_grade 		 ,
		org_group		 ,
		org_group_id
    )
    select 
		org.orgid 			org_id 			 ,
		org.orgname         org_name 		 ,
		org.linkman         linkman 		 ,
		org.principal       principal 		 ,
		null  				emp_count 		 ,
		null  				bus_count 		 ,
		null  				route_count 	 ,
		null  				site_count 		 ,
		null  				driver_count 	 ,
		org.address         address 		 ,
		org.registerdate    register_date	 ,
		org.telephone       telephone 		 ,
		org.fax             fax 			 ,
		org.post            post 			 ,
		org.parentorgid     parent_org_id 	 ,
		org.regionarea      region_area 	 ,
		null				area_code 		 ,
		org.parentorgid     parent_org_name  ,
		org.orggrade        org_grade		 ,
		null				org_group		 ,
		null				org_group_id
	from mcorginfogs org
	where org.isactive=1
	and org.orgtype = 1 
	and exists (select 1 from mcorginfogs p where org.parentorgid = p.orgid and p.isactive = 1);
    commit;
	  
	
    dbms_output.put_line('update emp_count');
    update obj_corporate rpt
        set (emp_count,driver_count) = (select count(*),sum(decode(positiontype,'1',1,0))
					     from mcemployeeinfogs a
					     where a.orgid = rpt.org_id
					     and a.isactive = 1
                        )
    ;
    commit;

	update obj_corporate rpt
        set emp_count = nvl((select sum(emp_count)
					     from obj_corporate a
					     where a.parent_org_id = rpt.org_id
                        )+emp_count,0)
    where rpt.parent_org_id = '210000';
    commit;
	
	update obj_corporate rpt
        set driver_count = nvl((select sum(driver_count)
					     from obj_corporate a
					     where a.parent_org_id = rpt.org_id
                        )+driver_count,0)
    where rpt.parent_org_id = '210000';
    commit; 
	

    dbms_output.put_line('update bus_count');
    update obj_corporate rpt
        set bus_count = nvl((select count(*)
					     from mcbusinfogs a
					     where a.orgid = rpt.org_id
					     and a.isactive = 1
                        ),0)
    ;
    commit; 
	
	
	update obj_corporate rpt
        set bus_count = nvl((select sum(bus_count) bus
					     from obj_corporate a
					     where a.parent_org_id = rpt.org_id
                        )+bus_count,0)
    where rpt.parent_org_id = '210000';
    commit; 
	
	
	dbms_output.put_line('update route_count');
    update obj_corporate rpt
        set route_count = nvl((select count(*)
					     from mcrouteinfogs a
					     where a.orgid = rpt.org_id
					     and a.isactive = 1
						 and v_date between a.begindate and a.enddate
						 and exists (select 1 from mcsubrouteinfogs b 
									where a.routeid = b.routeid 
									and b.isactive=1 
									and v_date between b.begindate and b.enddate)
                        ),0)
    ;
    commit; 
	
	update obj_corporate rpt
        set route_count = nvl((select sum(route_count) route
					     from obj_corporate a
					     where a.parent_org_id = rpt.org_id
                        )+route_count,0)
    where rpt.parent_org_id = '210000';
    commit; 

	dbms_output.put_line('update site_count');
    update obj_corporate rpt
        set site_count = nvl((select count(*)
					     from mcsiteinfogs a
					     where a.orgid = rpt.org_id
					     and a.isactive = 1
						 and v_date between a.usedate and a.stopdate
                        ),0)
    ;
    commit; 

	update obj_corporate rpt
        set site_count = nvl((select sum(site_count) site
					     from obj_corporate a
					     where a.parent_org_id = rpt.org_id
                        )+site_count,0)
    where rpt.parent_org_id = '210000';
    commit; 
	
    dbms_output.put_line('update PARENT_ORG_NAME');
    update obj_corporate rpt
        set parent_org_name = (select a.orgname
							   from mcorginfogs a
							   where a.orgid = rpt.parent_org_id
							   and a.isactive = 1
                              )
    where exists (select 1 from mcorginfogs b where rpt.parent_org_id = b.orgid and b.isactive = 1);
    commit;
	
	
	dbms_output.put_line('update org_group, area_code');
    update obj_corporate rpt
        set (org_group,org_group_id,area_code) = (select b.orggroup,b.orggroupid, b.regional_category
									 from map_org_regional b
									 where rpt.org_id = b.orgid
									 )
    where exists (select 1 from map_org_regional c where rpt.org_id = c.orgid);
    commit;
	
	
	--更新历史记录表
	delete from obj_corporate_m where business_date = v_date;
	commit;
	insert into obj_corporate_m
	select v_date, a.*
	from obj_corporate a;
	commit;
	
	
    dbms_output.put_line('completed');

end p_obj_corporate;
/
