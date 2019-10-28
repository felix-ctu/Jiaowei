create or replace force view rpt_busiquery_businfo (
	bus_id 				 ,
	card_id 			 ,
	bus_self_id 		 ,
	oil_type 			 ,
	bus_type 			 ,
	bus_length 			 ,
	buy_date 			 ,
	use_date 			 ,
	years_in_use		 ,
	bus_status 			 ,
	bus_operate_type 	 ,
	seat_count 			 ,
	stand_count 		 ,
	route_id 			 ,
	org_id 				 ,
	org_name			 ,
	parent_org_id 		 ,
	area_code 			 ,
	is_active 			 ,
	bus_grade 			 ,
	body_light_led 		 ,
	head_light_led 		 ,
	air_conditioned 	 ,
	low_floor 			 ,
	ic_enabled 			 ,
	bus_machine_number 	 ,
	stdcoefficient		 ,
	approved_count 		 ,
	standard_oil_num 	 ,
	org_group			 ,
	org_group_id			
) as 
select 
	bus_id 				 ,
	card_id 			 ,
	bus_self_id 		 ,
	oil_type 			 ,
	bus_type 			 ,
	bus_length 			 ,
	buy_date 			 ,
	use_date 			 ,
	years_in_use		 ,
	bus_status 			 ,
	bus_operate_type 	 ,
	seat_count 			 ,
	stand_count 		 ,
	route_id 			 ,
	org_id 				 ,
	org_name			 ,
	parent_org_id 		 ,
	area_code 			 ,
	is_active 			 ,
	bus_grade 			 ,
	body_light_led 		 ,
	head_light_led 		 ,
	air_conditioned 	 ,
	low_floor 			 ,
	ic_enabled 			 ,
	bus_machine_number 	 ,
	stdcoefficient		 ,
	approved_count 		 ,
	standard_oil_num 	 ,
	org_group			 ,
	org_group_id	
from obj_businfo a
;
 
COMMENT ON TABLE rpt_busiquery_businfo  IS '车辆数据查询';
COMMENT ON COLUMN rpt_busiquery_businfo.BUS_ID 					IS '车辆编号';
COMMENT ON COLUMN rpt_busiquery_businfo.CARD_ID 				IS '车牌号';
COMMENT ON COLUMN rpt_busiquery_businfo.BUS_SELF_ID 			IS '车辆自编号';
COMMENT ON COLUMN rpt_busiquery_businfo.OIL_TYPE 				IS '燃料类型';
COMMENT ON COLUMN rpt_busiquery_businfo.BUS_TYPE 				IS '车辆类型';
COMMENT ON COLUMN rpt_busiquery_businfo.BUS_LENGTH 				IS '车辆长度';
COMMENT ON COLUMN rpt_busiquery_businfo.BUY_DATE 				IS '购买时间';
COMMENT ON COLUMN rpt_busiquery_businfo.USE_DATE 				IS '使用时间';
COMMENT ON COLUMN rpt_busiquery_businfo.YEARS_IN_USE 			IS '使用年限';
COMMENT ON COLUMN rpt_busiquery_businfo.BUS_STATUS 				IS '车辆状态';
COMMENT ON COLUMN rpt_busiquery_businfo.BUS_OPERATE_TYPE 		IS '车辆分类';
COMMENT ON COLUMN rpt_busiquery_businfo.SEAT_COUNT 				IS '座位数';
COMMENT ON COLUMN rpt_busiquery_businfo.STAND_COUNT 			IS '站立数';
COMMENT ON COLUMN rpt_busiquery_businfo.ROUTE_ID 				IS '线路名称';
COMMENT ON COLUMN rpt_busiquery_businfo.ORG_ID 					IS '';
COMMENT ON COLUMN rpt_busiquery_businfo.ORG_NAME 				IS '';
COMMENT ON COLUMN rpt_busiquery_businfo.PARENT_ORG_ID 			IS '';
COMMENT ON COLUMN rpt_busiquery_businfo.AREA_CODE 				IS '区域类别';
COMMENT ON COLUMN rpt_busiquery_businfo.IS_ACTIVE 				IS '';
COMMENT ON COLUMN rpt_busiquery_businfo.BUS_GRADE 				IS '车辆型号';
COMMENT ON COLUMN rpt_busiquery_businfo.BODY_LIGHT_LED 			IS '车内LED';
COMMENT ON COLUMN rpt_busiquery_businfo.HEAD_LIGHT_LED 			IS '车头LED';
COMMENT ON COLUMN rpt_busiquery_businfo.AIR_CONDITIONED 		IS '空调车';
COMMENT ON COLUMN rpt_busiquery_businfo.LOW_FLOOR 				IS '低地板车';
COMMENT ON COLUMN rpt_busiquery_businfo.IC_ENABLED 				IS 'IC卡设备';
COMMENT ON COLUMN rpt_busiquery_businfo.BUS_MACHINE_NUMBER 		IS '车载机编号';
COMMENT ON COLUMN rpt_busiquery_businfo.STDCOEFFICIENT			IS '标台系数';
COMMENT ON COLUMN rpt_busiquery_businfo.APPROVED_COUNT			IS '核定载客数';
COMMENT ON COLUMN rpt_busiquery_businfo.STANDARD_OIL_NUM		IS '百公里油耗';
COMMENT ON COLUMN rpt_busiquery_businfo.ORG_GROUP				IS '区域名称';
COMMENT ON COLUMN rpt_busiquery_businfo.ORG_GROUP_ID			IS '区域ID';
