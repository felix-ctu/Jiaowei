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
 
COMMENT ON TABLE rpt_busiquery_businfo  IS '�������ݲ�ѯ';
COMMENT ON COLUMN rpt_busiquery_businfo.BUS_ID 					IS '�������';
COMMENT ON COLUMN rpt_busiquery_businfo.CARD_ID 				IS '���ƺ�';
COMMENT ON COLUMN rpt_busiquery_businfo.BUS_SELF_ID 			IS '�����Ա��';
COMMENT ON COLUMN rpt_busiquery_businfo.OIL_TYPE 				IS 'ȼ������';
COMMENT ON COLUMN rpt_busiquery_businfo.BUS_TYPE 				IS '��������';
COMMENT ON COLUMN rpt_busiquery_businfo.BUS_LENGTH 				IS '��������';
COMMENT ON COLUMN rpt_busiquery_businfo.BUY_DATE 				IS '����ʱ��';
COMMENT ON COLUMN rpt_busiquery_businfo.USE_DATE 				IS 'ʹ��ʱ��';
COMMENT ON COLUMN rpt_busiquery_businfo.YEARS_IN_USE 			IS 'ʹ������';
COMMENT ON COLUMN rpt_busiquery_businfo.BUS_STATUS 				IS '����״̬';
COMMENT ON COLUMN rpt_busiquery_businfo.BUS_OPERATE_TYPE 		IS '��������';
COMMENT ON COLUMN rpt_busiquery_businfo.SEAT_COUNT 				IS '��λ��';
COMMENT ON COLUMN rpt_busiquery_businfo.STAND_COUNT 			IS 'վ����';
COMMENT ON COLUMN rpt_busiquery_businfo.ROUTE_ID 				IS '��·����';
COMMENT ON COLUMN rpt_busiquery_businfo.ORG_ID 					IS '';
COMMENT ON COLUMN rpt_busiquery_businfo.ORG_NAME 				IS '';
COMMENT ON COLUMN rpt_busiquery_businfo.PARENT_ORG_ID 			IS '';
COMMENT ON COLUMN rpt_busiquery_businfo.AREA_CODE 				IS '�������';
COMMENT ON COLUMN rpt_busiquery_businfo.IS_ACTIVE 				IS '';
COMMENT ON COLUMN rpt_busiquery_businfo.BUS_GRADE 				IS '�����ͺ�';
COMMENT ON COLUMN rpt_busiquery_businfo.BODY_LIGHT_LED 			IS '����LED';
COMMENT ON COLUMN rpt_busiquery_businfo.HEAD_LIGHT_LED 			IS '��ͷLED';
COMMENT ON COLUMN rpt_busiquery_businfo.AIR_CONDITIONED 		IS '�յ���';
COMMENT ON COLUMN rpt_busiquery_businfo.LOW_FLOOR 				IS '�͵ذ峵';
COMMENT ON COLUMN rpt_busiquery_businfo.IC_ENABLED 				IS 'IC���豸';
COMMENT ON COLUMN rpt_busiquery_businfo.BUS_MACHINE_NUMBER 		IS '���ػ����';
COMMENT ON COLUMN rpt_busiquery_businfo.STDCOEFFICIENT			IS '��̨ϵ��';
COMMENT ON COLUMN rpt_busiquery_businfo.APPROVED_COUNT			IS '�˶��ؿ���';
COMMENT ON COLUMN rpt_busiquery_businfo.STANDARD_OIL_NUM		IS '�ٹ����ͺ�';
COMMENT ON COLUMN rpt_busiquery_businfo.ORG_GROUP				IS '��������';
COMMENT ON COLUMN rpt_busiquery_businfo.ORG_GROUP_ID			IS '����ID';
