create or replace force view  rpt_busiquery_route_tjzd 
(	
	sn					,
	route_id			,
	sub_route_name 		,
	segment_id			,
	segment_name        ,
	run_direction		,
	station_no          ,
	station_name        ,
	station_type        ,
	electronic_board    ,
	shelter			    ,
	harbor_shaped 	    ,
	station_length      ,
	region_area         ,
	area_code 			,
	single_serial_id    ,
	dual_serial_id      ,
	longitude 		    ,
	latitude            
) 
AS
select
	sn					,
	route_id			,
	sub_route_name 		,
	segment_id			,
	segment_name        ,
	run_direction		,
	station_no          ,
	station_name        ,
	station_type        ,
	electronic_board    ,
	shelter			    ,
	harbor_shaped 	    ,
	station_length      ,
	region_area         ,
	area_code 			,
	single_serial_id    ,
	dual_serial_id      ,
	longitude 		    ,
	latitude        
from obj_route_tjzd;


comment on table rpt_busiquery_route_tjzd  is '线路查询-途径站点查询';
comment on column rpt_busiquery_route_tjzd.sn				is '序号';
comment on column rpt_busiquery_route_tjzd.route_id		    is '线路名称';
comment on column rpt_busiquery_route_tjzd.segment_name     is '单程名称';
comment on column rpt_busiquery_route_tjzd.run_direction    is '运行方向';
comment on column rpt_busiquery_route_tjzd.station_no       is '站点编号';
comment on column rpt_busiquery_route_tjzd.station_name     is '站点名称';
comment on column rpt_busiquery_route_tjzd.station_type     is '站点类型';
comment on column rpt_busiquery_route_tjzd.electronic_board is '电子站牌';
comment on column rpt_busiquery_route_tjzd.shelter			is '候车亭'; 
comment on column rpt_busiquery_route_tjzd.harbor_shaped 	is '港湾式站点'; 
comment on column rpt_busiquery_route_tjzd.station_length   is '站台长度(米）';
comment on column rpt_busiquery_route_tjzd.region_area      is '行政区域';
comment on column rpt_busiquery_route_tjzd.area_code 		is '区域类型';
comment on column rpt_busiquery_route_tjzd.single_serial_id is '单向序号';
comment on column rpt_busiquery_route_tjzd.dual_serial_id   is '双向序号';
comment on column rpt_busiquery_route_tjzd.longitude 		is '经度'; 
comment on column rpt_busiquery_route_tjzd.latitude         is '维度';
comment on column rpt_busiquery_route_tjzd.sub_route_name   is '子线路名称';
comment on column rpt_busiquery_route_tjzd.segment_id   	is '单程id';
