create or replace force view  rpt_busiquery_corp 
(	org_id 					,
	org_name 				,
	linkman 				,
	principal 				,
	emp_count 				,
	bus_count 				,
	route_count 			,
	site_count 				,
	driver_count 			,
	address 				,
	register_date			,
	telephone 				,
	fax 					,
	post 					,
	parent_org_id 			,
	region_area 			,
	area_code 				,
	parent_org_name 		,
	org_grade 				,
	org_group 				,
	org_group_id 			
)
AS
select
	org_id 					,
	org_name 				,
	linkman 				,
	principal 				,
	emp_count 				,
	bus_count 				,
	route_count 			,
	site_count 				,
	driver_count 			,
	address 				,
	register_date			,
	telephone 				,
	fax 					,
	post 					,
	parent_org_id 			,
	region_area 			,
	area_code 				,
	parent_org_name 		,
	org_grade 				,
	org_group 				,
	org_group_id 	
from obj_corporate;

comment on table rpt_busiquery_corp  is '企业数据查询';
comment on column rpt_busiquery_corp.org_id 			is '组织id';
comment on column rpt_busiquery_corp.org_name 		    is '组织名称';
comment on column rpt_busiquery_corp.linkman 		    is '联系人';
comment on column rpt_busiquery_corp.principal 		    is '负责人';
comment on column rpt_busiquery_corp.emp_count 		    is '人员数量';
comment on column rpt_busiquery_corp.bus_count 		    is '车辆数量';
comment on column rpt_busiquery_corp.route_count 	    is '线路数量';
comment on column rpt_busiquery_corp.site_count 		is '场站数量';
comment on column rpt_busiquery_corp.driver_count 	    is '驾驶员数量';
comment on column rpt_busiquery_corp.address 		    is '组织地址';
comment on column rpt_busiquery_corp.register_date	    is '注册时间';
comment on column rpt_busiquery_corp.telephone 		    is '电话';
comment on column rpt_busiquery_corp.fax 			    is '传真';
comment on column rpt_busiquery_corp.post 			    is '邮编';
comment on column rpt_busiquery_corp.parent_org_id 	    is '上级组织';
comment on column rpt_busiquery_corp.region_area 	    is '区域类型';
comment on column rpt_busiquery_corp.area_code 		    is '所属区域';
comment on column rpt_busiquery_corp.parent_org_name    is '上级组织';
comment on column rpt_busiquery_corp.org_grade 		    is '组织级别';
comment on column rpt_busiquery_corp.org_group 		    is '区域名称';
comment on column rpt_busiquery_corp.org_group_id 		is '区域id';
