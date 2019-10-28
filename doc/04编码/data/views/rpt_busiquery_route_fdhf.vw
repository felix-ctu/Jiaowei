create or replace force view  rpt_busiquery_route_fdhf 
(	id 						, 
	route_id 				, 
	name    				, 
	week_start 				, 
	week_end 				, 
	start_time 				, 
	end_time 				, 
	departure_interval 		, 
	turnaround_time 		
) 
AS
select
	id 						, 
	route_id 				, 
	name    				, 
	week_start 				, 
	week_end 				, 
	start_time 				, 
	end_time 				, 
	departure_interval 		, 
	turnaround_time 
from obj_route_fdhf;


comment on table rpt_busiquery_route_fdhf  is '线路查询-峰段划分';
comment on column rpt_busiquery_route_fdhf.id 					is '序号';
comment on column rpt_busiquery_route_fdhf.route_id 			is '线路';
comment on column rpt_busiquery_route_fdhf.name		 			is '峰段名称';
comment on column rpt_busiquery_route_fdhf.week_start 			is '开始周';
comment on column rpt_busiquery_route_fdhf.week_end 			is '结束周';
comment on column rpt_busiquery_route_fdhf.start_time 			is '开始时间';
comment on column rpt_busiquery_route_fdhf.end_time 			is '结束时间';
comment on column rpt_busiquery_route_fdhf.departure_interval 	is '发车间隔标准';
comment on column rpt_busiquery_route_fdhf.turnaround_time 	    is '周转时间';

