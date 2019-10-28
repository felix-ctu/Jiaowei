create or replace force view rpt_busiquery_site (
	site_id			,
	org_id			,
	site_name		,
	site_type		,
	longitude		,
	latitude		,
	cctv			,
	site_from		,
	site_used_for	,
	route_name		,
	area_code		,
	region_area		,
	site_volume 	,
	site_square		
) as 
select 
	site_id			,
	org_id			,
	site_name		,
	site_type		,
	longitude		,
	latitude		,
	cctv			,
	site_from		,
	site_used_for	,
	route_name		,
	area_code		,
	region_area		,
	site_volume 	,
	site_square	
from obj_site a
;
 
comment on table rpt_busiquery_site  is '场站数据查询';

comment on column rpt_busiquery_site.site_id			is '站点编号';
comment on column rpt_busiquery_site.org_id			    is '组织';
comment on column rpt_busiquery_site.org_name		    is '组织';
comment on column rpt_busiquery_site.site_name		    is '场站名称';
comment on column rpt_busiquery_site.site_type		    is '场站类型';
comment on column rpt_busiquery_site.longitude		    is '经度';
comment on column rpt_busiquery_site.latitude		    is '纬度';
comment on column rpt_busiquery_site.cctv			    is '视频监控';
comment on column rpt_busiquery_site.site_from		    is '场所来源';
comment on column rpt_busiquery_site.site_used_for	    is '主要用途';
comment on column rpt_busiquery_site.route_name		    is '途径线路';
comment on column rpt_busiquery_site.area_code		    is '所属区域';
comment on column rpt_busiquery_site.region_area	    is '';
comment on column rpt_busiquery_site.site_volume		is '场站容量';
comment on column rpt_busiquery_site.site_square	    is '场站面积';
comment on column rpt_busiquery_site.site_name	    	is '场站名称';

