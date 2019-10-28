delete from map_code_master where code_category = 'AREA_CODE'; 
commit;
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AREA_CODE',1,'1','中心城区','区域类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AREA_CODE',2,'2','空港','区域类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AREA_CODE',3,'3','近郊区','区域类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AREA_CODE',4,'4','远郊区','区域类型');
commit;

delete from map_code_master where code_category = 'SEX'; 
commit;
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('SEX',1,'1','男','性别');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('SEX',2,'2','女','性别');
commit;

delete from map_code_master where code_category = 'SITETYPE'; 
commit;
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('SITETYPE',1,'0','','场站类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('SITETYPE',2,'1','','场站类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('SITETYPE',3,'3','','场站类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('SITETYPE',4,'5','','场站类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('SITETYPE',5,'6','','场站类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('SITETYPE',6,'7','','场站类型');
commit;

delete from map_code_master where code_category = 'BUS_STATUS'; 
commit;
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('BUS_STATUS',1,'0','','车辆状态');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('BUS_STATUS',2,'1','正常','车辆状态');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('BUS_STATUS',3,'2','报废','车辆状态');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('BUS_STATUS',4,'3','封存','车辆状态');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('BUS_STATUS',5,'5','其它','车辆状态');
commit;

delete from map_code_master where code_category = 'BUS_USEDFOR'; 
commit;
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('BUS_USEDFOR',1,'0','运营车','车辆用途');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('BUS_USEDFOR',2,'1','公务车','车辆用途');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('BUS_USEDFOR',3,'2','保修车','车辆用途');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('BUS_USEDFOR',4,'3','加油车','车辆用途');
commit;


delete from map_code_master where code_category = 'BUS_OPERATE_TYPE'; 
commit;
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('BUS_OPERATE_TYPE',1,'1','运营车辆','车辆类别');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('BUS_OPERATE_TYPE',2,'2','摆停车'	 ,'车辆类别');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('BUS_OPERATE_TYPE',3,'3','外租车'	 ,'车辆类别');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('BUS_OPERATE_TYPE',4,'4','包车'	 ,'车辆类别');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('BUS_OPERATE_TYPE',5,'5','其它'	 ,'车辆类别');
commit;



delete from map_code_master where code_category ='ROUTEGRADE';
commit;
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('ROUTEGRADE',1,'1','快线','线路级别');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('ROUTEGRADE',2,'2','干线','线路级别');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('ROUTEGRADE',3,'3','支线','线路级别');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('ROUTEGRADE',4,'4','微线','线路级别');
commit;




delete from map_code_master where code_category ='SITEFROM';
commit;
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('SITEFROM',1,'1','自有','场站来源');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('SITEFROM',2,'2','租赁','场站来源');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('SITEFROM',3,'3','共建','场站来源');
commit;



delete from map_code_master where code_category ='SITETYPE';
commit;
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('SITETYPE',1,'1','停车场','场站类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('SITETYPE',2,'0','未知'  ,'场站类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('SITETYPE',3,'3','加油站','场站类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('SITETYPE',4,'5','维修厂','场站类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('SITETYPE',5,'6','主站'  ,'场站类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('SITETYPE',6,'7','副站'  ,'场站类型');
commit;


delete from map_code_master where code_category ='POSITIONTYPE';
commit;
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',1,'4','路队总调','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',2,'7','发票员','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',3,'3','调度员','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',4,'1','驾驶员','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',5,'2','乘务员','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',6,'20','分公司副经理','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',7,'21','副科长','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',8,'19','科长','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',9,'17','维修工','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',10,'18','安保','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',11,'26','主任','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',12,'27','副主任','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',13,'25','保洁员','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',14,'23','总经理','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',15,'24','副总经理','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',16,'16','后勤人员','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',17,'9','票务员','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',18,'10','系统管理员','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',19,'8','收款员','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',20,'5','票务主管','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',21,'6','审票员','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',22,'14','审计','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',23,'15','科员','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',24,'13','维修员','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',25,'11','经理','岗位类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POSITIONTYPE',26,'12','技术员','岗位类型');
commit;


delete from map_code_master where code_category ='STATIONTYPE';
commit;
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('STATIONTYPE',1 ,'13','维修厂'	,'站点类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('STATIONTYPE',2 ,'3' ,'中间站'	,'站点类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('STATIONTYPE',3 ,'4' ,'虚站'		,'站点类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('STATIONTYPE',4 ,'5' ,'拐弯'		,'站点类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('STATIONTYPE',5 ,'6' ,'主站上客站','站点类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('STATIONTYPE',6 ,'7' ,'主站下客站','站点类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('STATIONTYPE',7 ,'9' ,'副站下客站','站点类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('STATIONTYPE',8 ,'8' ,'副站上客站','站点类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('STATIONTYPE',9 ,'10','出库'		,'站点类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('STATIONTYPE',10,'11','入库'		,'站点类型');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('STATIONTYPE',11,'12','返回站'	,'站点类型');
commit;

delete from map_code_master where code_category ='ONTIME_STANDARD';
commit;
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('ONTIME_STANDARD',1 ,'3','准点时间偏差','');
commit;


delete from map_code_master where code_category ='RPT_MONITOR_FIXTIMEONLINE';
commit;
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('RPT_MONITOR_FIXTIMEONLINE',1 ,'08:00:00','固定时段','');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('RPT_MONITOR_FIXTIMEONLINE',2 ,'09:00:00','固定时段','');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('RPT_MONITOR_FIXTIMEONLINE',3 ,'11:00:00','固定时段','');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('RPT_MONITOR_FIXTIMEONLINE',4 ,'14:00:00','固定时段','');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('RPT_MONITOR_FIXTIMEONLINE',5 ,'18:00:00','固定时段','');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('RPT_MONITOR_FIXTIMEONLINE',6 ,'21:00:00','固定时段','');
commit;

delete from map_code_master where code_category ='POPULATION';
commit;
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POPULATION',1 ,'6440000','中心城区','常住人口');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POPULATION',2 ,'6440000','空港','常住人口');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POPULATION',3 ,'6440000','近郊区','常住人口');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('POPULATION',4 ,'6440000','远郊区','常住人口');
commit;


delete from map_code_master where code_category ='TIME_SECTION';
commit;
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('TIME_SECTION',1 ,'00:00:00','05:59:59','00:00-06:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('TIME_SECTION',2 ,'06:00:00','06:59:59','06:00-07:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('TIME_SECTION',3 ,'07:00:00','07:59:59','07:00-08:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('TIME_SECTION',4 ,'08:00:00','08:59:59','08:00-09:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('TIME_SECTION',5 ,'09:00:00','09:59:59','09:00-10:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('TIME_SECTION',6 ,'10:00:00','10:59:59','10:00-11:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('TIME_SECTION',7 ,'11:00:00','11:59:59','11:00-12:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('TIME_SECTION',8 ,'12:00:00','12:59:59','12:00-13:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('TIME_SECTION',9 ,'13:00:00','13:59:59','13:00-14:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('TIME_SECTION',10,'14:00:00','14:59:59','14:00-15:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('TIME_SECTION',11,'15:00:00','15:59:59','15:00-16:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('TIME_SECTION',12,'16:00:00','16:59:59','16:00-17:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('TIME_SECTION',13,'17:00:00','17:59:59','17:00-18:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('TIME_SECTION',14,'18:00:00','18:59:59','18:00-19:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('TIME_SECTION',15,'19:00:00','19:59:59','19:00-20:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('TIME_SECTION',16,'20:00:00','20:59:59','20:00-21:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('TIME_SECTION',17,'21:00:00','21:59:59','21:00-22:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('TIME_SECTION',18,'22:00:00','22:59:59','22:00-23:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('TIME_SECTION',19,'23:00:00','23:59:59','23:00-24:00');
commit;


delete from map_code_master where code_category ='AVG_INTERVAL';
commit;
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AVG_INTERVAL',1 ,'00:00:00','05:29:59','00:00-05:30');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AVG_INTERVAL',2 ,'05:30:00','05:59:59','05:30-06:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AVG_INTERVAL',3 ,'06:00:00','06:59:59','06:00-07:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AVG_INTERVAL',4 ,'07:00:00','07:59:59','07:00-08:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AVG_INTERVAL',5 ,'08:00:00','08:59:59','08:00-09:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AVG_INTERVAL',6 ,'09:00:00','09:59:59','09:00-10:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AVG_INTERVAL',7 ,'10:00:00','10:59:59','10:00-11:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AVG_INTERVAL',8 ,'11:00:00','11:59:59','11:00-12:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AVG_INTERVAL',9 ,'12:00:00','12:59:59','12:00-13:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AVG_INTERVAL',10,'13:00:00','13:59:59','13:00-14:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AVG_INTERVAL',11,'14:00:00','14:59:59','14:00-15:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AVG_INTERVAL',12,'15:00:00','15:59:59','15:00-16:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AVG_INTERVAL',13,'16:00:00','16:59:59','16:00-17:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AVG_INTERVAL',14,'17:00:00','17:59:59','17:00-18:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AVG_INTERVAL',15,'18:00:00','18:59:59','18:00-19:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AVG_INTERVAL',16,'19:00:00','19:59:59','19:00-20:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AVG_INTERVAL',17,'20:00:00','20:59:59','20:00-21:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AVG_INTERVAL',18,'21:00:00','21:59:59','21:00-22:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AVG_INTERVAL',19,'22:00:00','22:59:59','22:00-23:00');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('AVG_INTERVAL',20,'23:00:00','23:59:59','23:00-24:00');
commit;


delete from map_code_master where code_category ='DEP_CLS';
commit;
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('DEP_CLS',1 ,'00:00:01','06:00:00','DEPARTURE');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('DEP_CLS',2 ,'06:00:01','06:30:00','DEPARTURE');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('DEP_CLS',3 ,'06:30:01','07:00:00','DEPARTURE');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('DEP_CLS',4 ,'07:00:00','07:59:59','DEPARTURE');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('DEP_CLS',5 ,'07:00:01','07:30:00','DEPARTURE');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('DEP_CLS',6 ,'07:30:01','08:00:00','DEPARTURE');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('DEP_CLS',7 ,'08:00:01','08:30:00','DEPARTURE');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('DEP_CLS',8 ,'08:30:01','09:00:00','DEPARTURE');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('DEP_CLS',9 ,'16:30:01','19:00:00','CLOSE');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('DEP_CLS',10,'19:00:01','20:00:00','CLOSE');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('DEP_CLS',11,'20:00:01','21:00:00','CLOSE');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('DEP_CLS',12,'21:00:01','21:30:00','CLOSE');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('DEP_CLS',13,'21:30:01','22:00:00','CLOSE');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('DEP_CLS',14,'22:00:01','22:30:00','CLOSE');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('DEP_CLS',15,'22:30:01','23:00:00','CLOSE');
insert into map_code_master (code_category,code_seq,code_value,code_desc,remarks) values ('DEP_CLS',16,'23:00:01','24:00:00','CLOSE');
commit;

