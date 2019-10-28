create or replace procedure p_obj_employee
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_obj_employee                                                            		*
*                                                                                               *
*  File Name   : p_obj_employee.prc                                                        		*
*                                                                                               *
*  Description : p_obj_employee                                                            		*
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 1-Oct-16   1.0      Liu Mingshun      Initial release                                         *
************************************************************************************************/
	v_date date := getbusinessdate;	
begin

    execute immediate 'truncate table obj_employee drop storage';

    dbms_output.put_line('insert into table obj_employee');
    insert /*+append*/ into obj_employee (
		id					,
		emp_name			,
		position_type		,
		sex					,
		start_date			,
		lisence_type		,
		org_name			,
		route_id			,
		emp_id				,
		designation			,
		ic_card				,
		drive_experience	,
		certificate_number	,
		diploma				,
		birthdate	        ,
		salary		        ,
		org_id				,
		parent_org_id		,
		org_group			,
		area_code			,
		org_group_id
    )
    select 
		a.cardid 		id					,
		a.empname 		emp_name			,
		a.positiontype 	position_type		,
		m.code_desc 	sex					,
		a.startdate 	start_date			,
		a.drivetype  	lisence_type		,       
		null 			org_name			,
		null 			route_id			,
		a.empid 		emp_id				,
		null 			designation			,
		a.iccardid 		ic_card				,
		round(months_between(v_date,a.getdrivedate)/12,1) drive_experience,
		a.opserviceid	certificate_number	,
		a.diploma		diploma				,
		a.birthdate		birthdate,
		null		    salary    			,
		a.orgid 		org_id				,
		null 			parent_org_id		,
		null			org_group			,
		null 			area_code			,
		null			org_group_id
    from mcemployeeinfogs a,  map_code_master m
	where a.sex = m.code_value
	and m.code_category = 'SEX'
	and a.isactive = 1
	and ascii(substr(a.empname,1,1)) not between 48 and 122 ;
    commit;
        
    dbms_output.put_line('update org_name, parent_org_id');
    update obj_employee rpt
        set (org_name, parent_org_id) = (select b.orgname, b.parentorgid
										from mcorginfogs b
										where rpt.org_id = b.orgid
										and b.isactive = 1
										)
    where exists (select 1 from mcorginfogs c where rpt.org_id = c.orgid and c.isactive = 1)
	;
    commit;
	
    
	dbms_output.put_line('update route_id');
    update obj_employee rpt
        set route_id = (select wmsys.wm_concat(c.routename)
					    from mcremproutegs b, mcrouteinfogs c
					    where rpt.emp_id = b.empid
						and b.routeid=c.routeid
						and c.isactive=1
                       )
    where exists (select 1 from mcremproutegs c where rpt.emp_id = c.empid)
	;
    commit;
	
	
	dbms_output.put_line('upupdate position_type');
    update obj_employee rpt
        set position_type = (select m.code_desc
							from map_code_master m
							where rpt.position_type = m.code_value
							and m.code_category = 'POSITIONTYPE'
							)
	;
    commit;
	
	dbms_output.put_line('update org_group, area_code');
    update obj_employee rpt
        set (org_group,org_group_id,area_code) = (select b.orggroup,b.orggroupid, b.regional_category
									 from map_org_regional b
									 where rpt.org_id = b.orgid
									 )
    where exists (select 1 from map_org_regional c where rpt.org_id = c.orgid)
	;
    commit;
	
	--更新历史记录表
	delete from obj_employee_m where business_date = v_date;
	commit;
	insert into obj_employee_m
	select v_date, a.*
	from obj_employee a;
	commit;
	
	dbms_output.put_line('completed');

end p_obj_employee;
/
