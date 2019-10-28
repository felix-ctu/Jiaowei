create or replace force view  rpt_busiquery_route 
(	sub_route_id 			,
	route_id 				,
	route_name 				,
	bus_count 				,
	begin_date 				,
	linkman 				,
	route_grade 			,
	route_grade_manual		,
	route_style				,
	org_id 					,
	parent_org_id 			,
	area_code 				,
	end_date 				,
	isactive 				,
	route_type 				,
	is_end_with_alphabet 	,
	is_suburban 			,
	org_name 				,
	route_length 			,
	org_group 				,
	org_group_id			
) 
AS
select
	sub_route_id 			,
	route_id 				,
	route_name 				,
	bus_count 				,
	begin_date 				,
	linkman 				,
	route_grade 			,
	route_grade_manual		,
	route_style				,
	org_id 					,
	parent_org_id 			,
	area_code 				,
	end_date 				,
	isactive 				,
	route_type 				,
	is_end_with_alphabet 	,
	is_suburban 			,
	org_name 				,
	route_length 			,
	org_group 				,
	org_group_id	
from obj_route;


comment on table rpt_busiquery_route  is '线路数据查询';
comment on column rpt_busiquery_route.sub_route_id 		 	is '子线';
comment on column rpt_busiquery_route.route_id 			 	is '线路id';
comment on column rpt_busiquery_route.route_name 		 	is '线路名称';	
comment on column rpt_busiquery_route.bus_count 		 	is '运营车辆数';	
comment on column rpt_busiquery_route.begin_date 		 	is '开通日期';	
comment on column rpt_busiquery_route.linkman 			 	is '负责人';
comment on column rpt_busiquery_route.route_grade 		 	is '线路级别';
comment on column rpt_busiquery_route.route_grade_manual 	is '线路级别-原始数据';
comment on column rpt_busiquery_route.route_style 		 	is '线路类型（1上下行，2环行）';
comment on column rpt_busiquery_route.org_id 			 	is '所属组织';	
comment on column rpt_busiquery_route.parent_org_id 	 	is '';	
comment on column rpt_busiquery_route.area_code 		 	is '区域类型';	
comment on column rpt_busiquery_route.end_date 		 	 	is '注销日期';	
comment on column rpt_busiquery_route.isactive  		 	is '是否有效';	
comment on column rpt_busiquery_route.route_type 	 	 	is '线路类型';	
comment on column rpt_busiquery_route.is_end_with_alphabet 	is '是否字母结尾';	
comment on column rpt_busiquery_route.is_suburban 		 	is '是否二圈层进城线路';	
comment on column rpt_busiquery_route.org_name  		 	is '是否有效';	
