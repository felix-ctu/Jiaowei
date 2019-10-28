create or replace function getbusinessdate (v_date date default NULL)
return date
as
/************************************************************************************************
*                                                                                               *
*  Module Name : getbusinessdate                                                            	*
*                                                                                               *
*  File Name   : getbusinessdate.sql                                                        	*
*                                                                                               *
*  Description : used for reports to get business_date                                         	*
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 23-Oct-16   1.0      Liu Mingshun      Initial release                                        *
************************************************************************************************/

	v_getbusinessdate  date;

begin
	
	if v_date is null
	then 
		select business_date into v_getbusinessdate
		from rpt_set_business_date;
	else 
		v_getbusinessdate := v_date;
	end if;
	
	return v_getbusinessdate;
end;
/
