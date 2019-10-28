create or replace procedure p_pre_batch(p_date IN date default null)
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_pre_batch                                                               		*
*                                                                                               *
*  File Name   : p_pre_batch.prc                                                           		*
*                                                                                               *
*  Description : this is to set the business date for reports, the first execute job for reports*
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 23-Oct-16   1.0      Liu Mingshun      Initial release                                         *
************************************************************************************************/
		v_date 		date;
		v_monthend 	date;
		v_pre_date	date;
begin

	execute immediate 'truncate table rpt_set_business_date drop storage';
	
	if p_date is not null
	then 
		v_date := p_date;
	else
	
		begin
			select max(rundatadate) into v_date
			from bz_busrunrecordld;
			
		exception when others then
			v_date := trunc(sysdate-1);
		end;

	end if;
	
	v_monthend := trunc(add_months(v_date,1),'mm')-1;
	v_pre_date := v_date -1;
	
	insert into rpt_set_business_date values (v_date, v_monthend, v_pre_date);
    commit;
    
    dbms_output.put_line('completed');

end p_pre_batch;
/
