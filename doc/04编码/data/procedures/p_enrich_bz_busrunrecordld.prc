create or replace procedure p_enrich_bz_busrunrecordld
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_enrich_bz_busrunrecordld                                                     *
*                                                                                               *
*  File Name   : p_enrich_bz_busrunrecordld.prc                                                 *
*                                                                                               *
*  Description : p_enrich_bz_busrunrecordld                                                     *
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 1-Oct-16   1.0      Liu Mingshun      Initial release                                         *
************************************************************************************************/
	v_date 				date := getbusinessdate;	
	v_partition 		varchar2(20);
	v_date_immediate	varchar2(20);
	v_counter 			number;  
	v_standard			number;
	
	cursor cur_a is  
    select displandid, leavetime, arrivetime
	from bz_busdisplanld
	where rundate = getbusinessdate
	and isactive = '1'
	and rectype = '1';  
	
	/*
	cursor cur_b is 
	select busrrid,(leavetime-lag(leavetime,1,leavetime) over (partition by rundatadate, routeid, segmentid order by leavetime))*24*60 interval 
	from bz_busrunrecordld
	where rectype = '1'
	and isactive = '1'
	and rundatadate = getbusinessdate
	and to_char(leavetime, 'hh24:mi:ss') between '05:30:00' and '21:00:00';
  */
  
	cursor cur_c is
	select busrrid, 'F' flag
	from (	select busrrid, rundatadate, routeid, segmentid, leavetime, 
				row_number() over (partition by rundatadate, routeid, segmentid order by leavetime) num
			from bz_busrunrecordld
			where rectype = '1'
			and isactive = '1'
			and rundatadate = getbusinessdate
	) 
	where num = 1;
	
	cursor cur_d is
	select busrrid, 'L' flag
	from (	select busrrid, rundatadate, routeid, segmentid, leavetime, 
				row_number() over (partition by rundatadate, routeid, segmentid order by leavetime desc) num
			from bz_busrunrecordld
			where rectype = '1'
			and isactive = '1'
			and rundatadate = getbusinessdate
	) 
	where num = 1;
	 

	cursor cur_e is
	select busrrid, 'P' flag
	from (	select busrrid, rundatadate, routeid, segmentid, leavetime, 
				row_number() over (partition by rundatadate, routeid, segmentid order by leavetime desc) num
			from bz_busrunrecordld
			where rectype = '1'
			and isactive = '1'
			and rundatadate = getbusinessdate
	) 
	where num = 2;
	
begin
	v_partition 		:= 'p_'||to_char(v_date,'yyyymm');
	v_date_immediate 	:= to_char(v_date,'yyyymmdd');	
	
	
	begin  
		v_counter := 0;  
		for row_a in cur_a loop  
		
			update bz_busrunrecordld 
			set planstarttime = row_a.leavetime, planendtime = row_a.arrivetime
			where displanid = row_a.displandid
			and rundatadate = v_date;  

			v_counter := v_counter + 1;  
			
			if (v_counter >= 5000) then  
			  commit;  
			  v_counter := 0;  
			end if;  
		
		end loop;  
		commit;  
	end;  
	
	
/*	
	begin  
		v_counter := 0;  
		for row_b in cur_b loop  
		
			update bz_busrunrecordld a
			set intervalperiod = row_b.interval
			where a.busrrid = row_b.busrrid
			and a.rundatadate = v_date
			and a.isactive = '1'
			and a.rectype = '1';  

			v_counter := v_counter + 1;  
			
			if (v_counter >= 5000) then  
			  commit;  
			  v_counter := 0;  
			end if;  
		
		end loop;  
		commit;  
	end;  
		
	

	update bz_busrunrecordld a
	set intervalflag
			= (	select 	case when b.route_grade = '快线' and a.intervalperiod>9 	then 0
							 when b.route_grade = '干线' and a.intervalperiod>12 	then 0
							 when b.route_grade = '支线' and a.intervalperiod>15 	then 0
							 when b.route_grade = '微线' and a.intervalperiod>8 	then 0
							 else 1
						end
				from rpt_busiquery_route b
				where a.routeid = b.route_id
				and a.rundatadate = b.business_date
			)
	where a.rectype = '1'
	and a.isactive = '1'
	and to_char(a.leavetime, 'hh24:mi:ss') between '05:30:00' and '21:00:00'
	and a.rundatadate = v_date;
	commit;
*/
	
	begin  
		v_counter := 0;  
		for row_c in cur_c loop  
		
			update bz_busrunrecordld a
			set shifttype = row_c.flag
			where a.busrrid = row_c.busrrid
			and a.rundatadate = v_date
			and a.rectype = '1'
			and a.isactive = '1';  

			v_counter := v_counter + 1;  
			
			if (v_counter >= 5000) then  
			  commit;  
			  v_counter := 0;  
			end if;  
		
		end loop;  
		commit;  
	end;  
	

	begin  
		v_counter := 0;  
		for row_d in cur_d loop  
		
			update bz_busrunrecordld a
			set shifttype = row_d.flag
			where a.busrrid = row_d.busrrid
			and a.rundatadate = v_date
			and a.rectype = '1'
			and a.isactive = '1';  

			v_counter := v_counter + 1;  
			
			if (v_counter >= 5000) then  
			  commit;  
			  v_counter := 0;  
			end if;  
		
		end loop;  
		commit;  
	end;  
	
	
	begin  
		v_counter := 0;  
		for row_e in cur_e loop  
		
			update bz_busrunrecordld a
			set shifttype = row_e.flag
			where a.busrrid = row_e.busrrid
			and a.rundatadate = v_date
			and a.rectype = '1'
			and a.isactive = '1';  

			v_counter := v_counter + 1;  
			
			if (v_counter >= 5000) then  
			  commit;  
			  v_counter := 0;  
			end if;  
		
		end loop;  
		commit;  
	end; 
	
	
	update bz_busrunrecordld a
	set shifttype = 'M'
	where a.rectype = '1'
	and a.isactive = '1'
	and a.shifttype is null
	and a.rundatadate = v_date;
	commit;
	
	
	update bz_busrunrecordld a
	set buscardno = (
					select b.card_id
					from obj_businfo b
					where a.busid = b.bus_id
				)
	where a.rundatadate = v_date;
	commit;
	
	
end p_enrich_bz_busrunrecordld;
/

