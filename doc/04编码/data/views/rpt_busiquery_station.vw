create or replace force view  rpt_busiquery_station 
(	station_id 				,
	station_no 				,
	station_name 			, 
	electronic_board 		,
	shelter 				,
	harbor_shaped 			,
	hange_station			,
	length 					,
	area_code 				,
	routes 					, 
	longitude 				,
	latitude 				,
	org_id 					,
	org_name				,
	parent_org_id 			,
	org_group				,
	org_group_id			
) 
AS
select
	station_id 				,
	station_no 				,
	station_name 			, 
	electronic_board 		,
	shelter 				,
	harbor_shaped 			,
	hange_station			,
	length 					,
	area_code 				,
	routes 					, 
	longitude 				,
	latitude 				,
	org_id 					,
	org_name				,
	parent_org_id 			,
	org_group				,
	org_group_id			
from obj_station;


comment on table rpt_busiquery_station  is '站点数据查询';

comment on column rpt_busiquery_station.station_id 		  is '站点编号';
comment on column rpt_busiquery_station.station_no 		  is '站点自编号';
comment on column rpt_busiquery_station.station_name 	  is '站点名称';
comment on column rpt_busiquery_station.electronic_board  is '电子站牌';
comment on column rpt_busiquery_station.shelter 		  is '候车亭';
comment on column rpt_busiquery_station.harbor_shaped 	  is '港湾式站点';
comment on column rpt_busiquery_station.hange_station	  is '枢纽站点';
comment on column rpt_busiquery_station.length 			  is '站台长度（米）';
comment on column rpt_busiquery_station.area_code 		  is '所属区域';
comment on column rpt_busiquery_station.routes 			  is '途径线路';
comment on column rpt_busiquery_station.longitude 		  is '经度';
comment on column rpt_busiquery_station.latitude 		  is '纬度';
comment on column rpt_busiquery_station.org_id 			  is '企业代码';
comment on column rpt_busiquery_station.org_name		  is '企业名称';
comment on column rpt_busiquery_station.parent_org_id     is '上级企业代码';
comment on column rpt_busiquery_station.org_group     	  is '区域名称';
comment on column rpt_busiquery_station.org_group_id      is '区域id';

