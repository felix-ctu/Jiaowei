create or replace force view  rpt_busiquery_emp 
(	id						,
    emp_name				,
    position_type			,
    sex						,
    start_date				,
    lisence_type			,
    org_name				,
    route_id				, 
    emp_id					,
    designation				,
    ic_card					,
    drive_experience		,
    certificate_number		,
	diploma					,
	birthdate				,
	salary					,
    org_id					,
    parent_org_id			,
    area_code				,
	org_group 				,
	org_group_id 			
) 
AS
select
	id						,
    emp_name				,
    position_type			,
    sex						,
    start_date				,
    lisence_type			,
    org_name				,
    route_id				, 
    emp_id					,
    designation				,
    ic_card					,
    drive_experience		,
    certificate_number		,
	diploma					,
	birthdate				,
	salary					,
    org_id					,
    parent_org_id			,
    area_code				,
	org_group 				,
	org_group_id 	
from obj_employee;


comment on table rpt_busiquery_emp  is '人员数据查询';
comment on column rpt_busiquery_emp.id 					is 'primary key';
comment on column rpt_busiquery_emp.emp_name 			is '员工姓名';
comment on column rpt_busiquery_emp.position_type 		is '岗位类型';
comment on column rpt_busiquery_emp.sex 				is '性别';
comment on column rpt_busiquery_emp.start_date 			is '加入时间';
comment on column rpt_busiquery_emp.lisence_type 		is '驾驶证类型';
comment on column rpt_busiquery_emp.org_name 			is '所属公司id';
comment on column rpt_busiquery_emp.route_id 			is '所属线路';
comment on column rpt_busiquery_emp.emp_id 				is '员工编号';
comment on column rpt_busiquery_emp.designation 		is '职称';
comment on column rpt_busiquery_emp.ic_card 			is 'ic卡号';
comment on column rpt_busiquery_emp.drive_experience 	is '驾龄';
comment on column rpt_busiquery_emp.certificate_number	is '营运服务证号';
comment on column rpt_busiquery_emp.diploma				is '文化程度';
comment on column rpt_busiquery_emp.birthdate			is '出生日期';
comment on column rpt_busiquery_emp.salary				is '工资';
comment on column rpt_busiquery_emp.org_group 			is '区域名称';
comment on column rpt_busiquery_emp.org_group_id 		is '区域id';
