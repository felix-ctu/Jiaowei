create or replace force view  rpt_busiquery_route_smzd 
(	sn 					,
	route_id 			, 
	segment_name 		, 
	fst_station_no		,
	fst_station 		, 
	lst_station_no		,
	lst_station 		, 
	isactive 			
) 
AS
select
	sn 					,
	route_id 			, 
	segment_name 		, 
	fst_station_no		,
	fst_station 		, 
	lst_station_no		,
	lst_station 		, 
	isactive 
from obj_route_smzd;



comment on table rpt_busiquery_route_smzd  is '线路查询-首末站点查询';
comment on column rpt_busiquery_route_smzd.sn 				is '序号';
comment on column rpt_busiquery_route_smzd.route_id 		is '线路名称';
comment on column rpt_busiquery_route_smzd.segment_name 	is '单程名称';
comment on column rpt_busiquery_route_smzd.fst_station_no 	is '起始站点自编号';
comment on column rpt_busiquery_route_smzd.fst_station 		is '起始站点';
comment on column rpt_busiquery_route_smzd.fst_station_no 	is '终到站点自编号';
comment on column rpt_busiquery_route_smzd.lst_station 		is '终到站点';
comment on column rpt_busiquery_route_smzd.isactive 		is '是否有效';
