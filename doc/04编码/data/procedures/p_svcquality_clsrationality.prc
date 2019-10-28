create or replace procedure p_svcquality_clsrationality
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_svcquality_clsrationality                                                    *
*                                                                                               *
*  File Name   : p_svcquality_clsrationality.prc                                                *
*                                                                                               *
*  Description : 服务质量 -  收车时间合理性分析                                                 *
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 25-Nov-16   1.0      Liu Mingshun      Initial release                                        *
************************************************************************************************/
	v_date 				date:= getbusinessdate;	
	v_partition			varchar2(20);
	v_date_immediate	varchar2(20);
	v_partition_day		varchar2(20);

begin

	v_partition := 'P_'||to_char(v_date,'yyyymm');
	v_partition_day := 'P_'||to_char(v_date,'yyyymmdd');
	v_date_immediate := to_char(v_date,'yyyymmdd');

	
    --delete from rpt_svcquality_clsrationality where business_date < v_date and business_date <> add_months(trunc(business_date,'mm'), +1)-1;
    delete from rpt_svcquality_clsrationality where business_date = v_date;
	commit;
	
    dbms_output.put_line('insert into table for 服务质量-收车时间合理性分析');
	execute immediate '
	insert into rpt_svcquality_clsrationality (
		business_date			,
		run_date				,
		route_id				,
		route_length			,
		card_consume_avg_count	,
		area_code				,
		org_group				,
		org_group_id			
    )
    select 
		b.run_date			business_date			,
		b.run_date 			run_date				, 
		a.lineno			route_id				,
		null				route_length			,
		sum(case when b.route_style = ''2'' then 1/2
				 else 1
			end) 			card_consume_avg_count	,
		b.area_code			area_code,
		b.org_group         org_group, 
		b.org_group_id      org_group_id
	from v_tbmonth_temp partition ('||v_partition_day||') a, rpt_first_last_run b 
	where a.busno = b.bus_self_id
	and a.lineno = b.route_id
	and a.consumedate >= b.actual_leavetime
	and a.consumedate <= b.actual_arrivetime
	and b.first_last_flag in (''LAST_RUN'',''PRE_LAST_RUN'')
	and to_char(b.run_date,''yyyymmdd'') = '||v_date_immediate||'
	group by b.run_date, a.lineno, b.org_group_id, b.org_group, b.area_code'
	;
    commit;
	

	update rpt_svcquality_clsrationality a
	set route_length = (select b.route_length
						from obj_route_m b
						where a.route_id = b.route_id
						and a.business_date = b.business_date
						)
	where a.business_date = v_date;
	commit;
	
	update rpt_svcquality_clsrationality a
	set rationality = (case when route_length <= 10 and card_consume_avg_count>20 then 'N'
							when route_length > 10 and route_length<=15 and card_consume_avg_count>25 then 'N'
							when route_length > 15 and route_length<=20 and card_consume_avg_count>35 then 'N'
							when route_length > 20 and card_consume_avg_count>40 then 'N'
							else 'Y'
						end)
	where a.business_date = v_date;
	commit;

    
	dbms_output.put_line('completed');

end p_svcquality_clsrationality;
/
