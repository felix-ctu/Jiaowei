create or replace procedure p_enrich_map_org_regional
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_enrich_map_org_regional                                                      *
*                                                                                               *
*  File Name   : p_enrich_map_org_regional.prc                                                  *
*                                                                                               *
*  Description : p_enrich_map_org_regional                                                      *
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 1-Oct-16   1.0      Liu Mingshun      Initial release                                         *
************************************************************************************************/
	--v_date date := getbusinessdate;	
begin

    execute immediate 'truncate table map_org_regional drop storage';

	insert into map_org_regional (orgid, orgname)
	select orgid, orgname
	from mcorginfogs
	where orgid like '2%'
	and orgid not in ('2120','2199')
	and parentorgid not in ('2120','2199');
	commit;

	update map_org_regional a
	set (orggroupid, orggroup, regional_category) = 
		(select p.orgid, p.orgname, '中心城区'
		 from mcorginfogs b, mcorginfogs p
		 where a.orgid = b.orgid
		 and b.parentorgid = p.orgid
		 and p.orgid in ('2101','2104','2102','2103','2105','2106')
		);
	commit;

	update map_org_regional a
	set (orggroupid, orggroup, regional_category) = 
		(select b.orgid, b.orgname, '中心城区'
		 from mcorginfogs b
		 where a.orgid = b.orgid
		 and b.orgid in ('210000','2101','2104','2102','2103','2105','2106')
		)
	where a.orgid in ('210000','2101','2104','2102','2103','2105','2106');
	commit;


	update map_org_regional a
	set (orggroupid, orggroup, regional_category) = 
		(select p.orgid, p.orgname, '空港'
		 from mcorginfogs b, mcorginfogs p
		 where a.orgid = b.orgid
		 and b.parentorgid = p.orgid
		 and p.orgid in ('2108')
		)
	where a.orggroup is null;
	commit;

	update map_org_regional a
	set (orggroupid, orggroup, regional_category) = 
		(select b.orgid, b.orgname, '空港'
		 from mcorginfogs b
		 where a.orgid = b.orgid
		 and b.orgid in ('2108')
		)
	where a.orggroup is null;
	commit;


	update map_org_regional a
	set regional_category = '近郊区'
	where a.orggroup is null;
	commit;
	
	
	update map_org_regional a
	set (orggroupid, orggroup) = 
		(select b.orgid, b.orgname
		 from mcorginfogs b
		 where a.orgid = b.orgid
		 and b.parentorgid = '210000'
		)
	where a.regional_category = '近郊区'
	and a.orggroup is null;
	commit;
	
	update map_org_regional a
	set (orggroupid, orggroup) = 
		(select p.orgid, p.orgname
		 from mcorginfogs b, mcorginfogs p
		 where a.orgid = b.orgid
		 and b.parentorgid = p.orgid
		)
	where a.regional_category = '近郊区'
	and a.orggroup is null;
	commit;
	

	insert into map_org_regional (orgid,orgname,orggroupid,orggroup,regional_category) 
	values ('远郊区','远郊区','远郊区','远郊区','远郊区');
	commit;
	
	dbms_output.put_line('completed');
	
	
end p_enrich_map_org_regional;
/

