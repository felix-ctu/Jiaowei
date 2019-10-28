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
 
comment on table rpt_busiquery_site  is '��վ���ݲ�ѯ';

comment on column rpt_busiquery_site.site_id			is 'վ����';
comment on column rpt_busiquery_site.org_id			    is '��֯';
comment on column rpt_busiquery_site.org_name		    is '��֯';
comment on column rpt_busiquery_site.site_name		    is '��վ����';
comment on column rpt_busiquery_site.site_type		    is '��վ����';
comment on column rpt_busiquery_site.longitude		    is '����';
comment on column rpt_busiquery_site.latitude		    is 'γ��';
comment on column rpt_busiquery_site.cctv			    is '��Ƶ���';
comment on column rpt_busiquery_site.site_from		    is '������Դ';
comment on column rpt_busiquery_site.site_used_for	    is '��Ҫ��;';
comment on column rpt_busiquery_site.route_name		    is ';����·';
comment on column rpt_busiquery_site.area_code		    is '��������';
comment on column rpt_busiquery_site.region_area	    is '';
comment on column rpt_busiquery_site.site_volume		is '��վ����';
comment on column rpt_busiquery_site.site_square	    is '��վ���';
comment on column rpt_busiquery_site.site_name	    	is '��վ����';

