create or replace procedure p_busiquery_arrlft
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_busiquery_arrlft                                                    			*
*                                                                                               *
*  File Name   : p_busiquery_arrlft.prc                                                			*
*                                                                                               *
*  Description : 服务质量 -  到离站数据查询					                                    *
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

	v_partition := 'P_'||to_char(v_date,'yyyymmdd');
	v_date_immediate := to_char(v_date,'yyyymmdd');
	
	delete from rpt_busiquery_arrlft where business_date = v_date;
	commit;
	
	for cur in 0 .. 23 loop

	
	insert /*+append*/ into rpt_busiquery_arrlft (
		business_date	,
		run_date		,
		route_id		,
	    bus_self_id		,
	    bus_id			,
	    bus_card		,
	    ismanulopt		,
	    isappend		,
	    arrlft_flag		,
	    station_id		,
	    station_name	,
	    actdatetime		,
	    recdatetime		,
	    site_name		,
	    area_code		,
	    org_group		,
	    org_group_id	
	)
    select 
		trunc(actdatetime)									business_date	,
		trunc(actdatetime)  								run_date		,
		a.routeid                    						route_id		,
		c.bus_self_id       								bus_self_id		,
		c.bus_id                							bus_id			,
		c.card_id          									bus_card		,
		decode(a.ismanulopt,'A','自动','手动')        		ismanulopt		,
		decode(a.isappend,'0','直接上传','1','GPRS补发','3','场站DSRC补发','5','站台上报到离站')   isappend		,
		decode(a.isarrlft,'1','到站','2','离站')			arrlft_flag		,
		a.stationnum	     								station_id		,
		d.station_name         								station_name	,
		a.actdatetime          								actdatetime		,
		a.recdatetime      									recdatetime		,
		null                    							site_name		,
		b.area_code	   										area_code		,
		b.org_group	   										org_group		,
		b.org_group_id   									org_group_id	
	from bsvcbusarrlftld5 a, 
			obj_route_m b, 
			obj_businfo_m c, 
			obj_station_m d
	where a.datatype = '4'
	and a.isarrlft in ('1','2')
	and a.routeid = b.route_id
	and a.productid = c.bus_machine_number
	and a.stationnum = d.station_no
	and b.business_date = c.business_date
	and c.business_date = d.business_date
	and b.business_date = v_date
	and a.actdatetime >= v_date + cur / 24
	and a.actdatetime < v_date + (cur + 1) / 24;
	
    commit;

	end loop;	
	dbms_output.put_line('completed');

end p_busiquery_arrlft;
/
