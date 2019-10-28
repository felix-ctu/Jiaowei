create or replace force view  rpt_busiquery_route_xsbz 
(	
	sn					,
	route_id            ,
	effective_date      ,
	expire_date         ,
	start_section       ,
	end_section         ,
	begin_time          ,
	end_time            ,
	max_limit_speed     ,
	min_limit_speed     
) 
AS
select
	sn					,
	route_id            ,
	effective_date      ,
	expire_date         ,
	start_section       ,
	end_section         ,
	begin_time          ,
	end_time            ,
	max_limit_speed     ,
	min_limit_speed   
from obj_route_xsbz;


comment on table rpt_busiquery_route_xsbz  is '线路查询-限速标准';
comment on column rpt_busiquery_route_xsbz.sn				is '序号';
comment on column rpt_busiquery_route_xsbz.route_id         is '线路名称';
comment on column rpt_busiquery_route_xsbz.effective_date   is '生效日期';
comment on column rpt_busiquery_route_xsbz.expire_date      is '失效日期';
comment on column rpt_busiquery_route_xsbz.start_section    is '开始路段';
comment on column rpt_busiquery_route_xsbz.end_section      is '结束路段';
comment on column rpt_busiquery_route_xsbz.begin_time       is '开始时间';
comment on column rpt_busiquery_route_xsbz.end_time         is '结束时间';
comment on column rpt_busiquery_route_xsbz.max_limit_speed  is '最高限速';
comment on column rpt_busiquery_route_xsbz.min_limit_speed  is '最低限速';

