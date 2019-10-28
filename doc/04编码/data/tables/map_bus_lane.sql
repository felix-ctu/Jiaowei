DROP TABLE MAP_BUS_LANE CASCADE CONSTRAINTS PURGE;
CREATE TABLE MAP_BUS_LANE 
(	
	SN 							NUMBER,
	LANE_CATEGORY           	VARCHAR2(200),
	LANE_NAME        			VARCHAR2(60),
	START_POSITION            	VARCHAR2(60),
	END_POSITION           		VARCHAR2(60),
	LANE_LENGTH             	NUMBER,
	BUS_LANE_DETAIL             VARCHAR2(60),
	BUS_LANE_LENGTH             NUMBER
) 
TABLESPACE TBS_OSECDJW_RPT
NOLOGGING ;

COMMENT ON TABLE MAP_BUS_LANE  IS '公交专用道';

COMMENT ON COLUMN MAP_BUS_LANE.SN 					IS '序号';
COMMENT ON COLUMN MAP_BUS_LANE.LANE_CATEGORY    	IS '专用道性质';
COMMENT ON COLUMN MAP_BUS_LANE.LANE_NAME        	IS '道路名称';
COMMENT ON COLUMN MAP_BUS_LANE.START_POSITION       IS '起点';
COMMENT ON COLUMN MAP_BUS_LANE.END_POSITION         IS '终点';
COMMENT ON COLUMN MAP_BUS_LANE.LANE_LENGTH          IS '道路长度';
COMMENT ON COLUMN MAP_BUS_LANE.BUS_LANE_DETAIL      IS '公交专用道性质';
COMMENT ON COLUMN MAP_BUS_LANE.BUS_LANE_LENGTH      IS '公交专用道长度';

	


delete from MAP_BUS_LANE; commit;
insert into map_bus_lane values (1,'白天时段公交专用道','一环路全线','','','19.7','7—20','39.4');
insert into map_bus_lane values (1,'白天时段公交专用道','青羊大道','锦城苑','成都花园','3.5','7—20','7');
insert into map_bus_lane values (1,'白天时段公交专用道','武阳大道','成都花园','神仙树','7.6','7—20','15.2');
insert into map_bus_lane values (1,'白天时段公交专用道','新华大道','万年场','通锦桥','6.4','7—20','12.8');
insert into map_bus_lane values (1,'白天时段公交专用道','沙西线','三环路','犀安路','6.1','7—20','12.2');
insert into map_bus_lane values (1,'白天时段公交专用道','西大街','骡马市','老区委路口','3.5','7—20','7');
insert into map_bus_lane values (1,'白天时段公交专用道','老成灌路','三环路','郫县界','9.1','7—20','18.2');
insert into map_bus_lane values (1,'白天时段公交专用道','顺城大街','人民东路','成都旅馆','1.2','7—20','2.4');
insert into map_bus_lane values (1,'白天时段公交专用道','大业路','人东','锦兴路','0.7','7—20','1.4');
insert into map_bus_lane values (1,'白天时段公交专用道','锦兴路','南灯巷','红星路四段','1.25','7—20','2.5');
insert into map_bus_lane values (1,'白天时段公交专用道','川藏路','高升桥','川藏立交','2.6','7—20','5.2');
insert into map_bus_lane values (1,'白天时段公交专用道','川藏路','三环路','绕城','6.3','7—20','12.6');
insert into map_bus_lane values (1,'白天时段公交专用道','府青路','刃具立交','东大街','4','7—20','8');
insert into map_bus_lane values (1,'白天时段公交专用道','草金路','清水河大桥','永康森林公园','6.3','7—20','12.6');
insert into map_bus_lane values (1,'白天时段公交专用道','光华大道','送仙桥','光华立交','3.3','7—20','6.6');
insert into map_bus_lane values (1,'白天时段公交专用道','成龙路','二环路','三环','3.4','7—20','6.8');
insert into map_bus_lane values (1,'白天时段公交专用道','武侯大道','二环路','绕城','7.9','7—20','15.8');
insert into map_bus_lane values (1,'白天时段公交专用道','新成仁路','沙河','石胜路','3','7—20','6');
insert into map_bus_lane values (1,'白天时段公交专用道','老成渝路','静居寺路','东大路','2.9','7—20','5.8');
insert into map_bus_lane values (1,'白天时段公交专用道','成华大道','狮子楼','龙潭立交','6.4','7—20','12.8');
insert into map_bus_lane values (1,'白天时段公交专用道','人民中、北路','火车北站','青龙街','3.38','7—20','6.76');
insert into map_bus_lane values (1,'白天时段公交专用道','人民中路','西大街','天府广场','1.22','7—20','2.44');
insert into map_bus_lane values (1,'白天时段公交专用道','益州大道','绕城高速','和硕东街路口','3.1','7—20','6.2');
insert into map_bus_lane values (1,'白天时段公交专用道','府城大道','府城大道科华南路路口','府城大道新园大道路口','3.4','7—20','6.8');
insert into map_bus_lane values (1,'白天时段公交专用道','新鸿路','电视塔','二环路麻石桥路口','1.7','7—20','3.4');
insert into map_bus_lane values (1,'白天时段公交专用道','杉板桥东延线','二环路麻石桥','十里店','2.61','7—20','5.22');
insert into map_bus_lane values (1,'白天时段公交专用道','北星干道','三环路','绕城','5.75','7—20','11.5');
insert into map_bus_lane values (1,'白天时段公交专用道','建设北路三段','二仙桥','厂北路口','1.8','7—20','3.6');
insert into map_bus_lane values (1,'白天时段公交专用道','东大街','盐市口','航天立交','6.3','7—20','12.6');
insert into map_bus_lane values (1,'白天时段公交专用道','南大街','南灯巷','成雅零公里','4.6','7—20','9.2');
insert into map_bus_lane values (1,'白天时段公交专用道','驷榭路','驷马桥','十里店','4.6','7—20','9.2');
insert into map_bus_lane values (1,'白天时段公交专用道','羊西线','界牌路口','绕城','3.7','7—20','7.4');
insert into map_bus_lane values (1,'白天时段公交专用道','东城根街','五丁桥','金盾路','3.1','7—20','6.2');
insert into map_bus_lane values (1,'白天时段公交专用道','商贸大道','铁路下穿','三环路','1.96','7—20','3.92');
insert into map_bus_lane values (1,'白天时段公交专用道','老成彭路','三环路','南丰大道','3.92','7—20','7.84');
insert into map_bus_lane values (1,'白天时段公交专用道','红星路一线(科华北路-科华中路-科华南路）','一环','2.5环','2.779','7—20','5.558');
insert into map_bus_lane values (1,'白天时段公交专用道','','3环','绕城','3.772','7—20','7.544');
insert into map_bus_lane values (1,'白天时段公交专用道','成洛路','万年场','沙河桥','1.65','7—20','3.3');
insert into map_bus_lane values (1,'白天时段公交专用道','成洛路','沙河','三环路','2.8','7—20','5.6');
insert into map_bus_lane values (1,'白天时段公交专用道','光华大道','三环路光华跨线桥西端','绕城','5.88','7—20','11.76');
insert into map_bus_lane values (1,'白天时段公交专用道','成温路','三环路','绕城','6.07','7—20','12.14');
insert into map_bus_lane values (1,'白天时段公交专用道','3.5环金科路','沙西线','羊西线','3.36','7—20','6.72');
insert into map_bus_lane values (1,'白天时段公交专用道','3.5环武青路','成温路','成双大道（川藏路）','9.64','7—20','19.28');
insert into map_bus_lane values (1,'白天时段公交专用道','3.5环石胜路','红星路南延线','成龙路','6.21','7—20','12.42');
insert into map_bus_lane values (1,'白天时段公交专用道','3.5环十洪大道','成龙路','成渝高速','5.19','7—20','10.38');
insert into map_bus_lane values (1,'白天时段公交专用道','驿都大道','三环路','绕城','5.07','7—20','10.14');
insert into map_bus_lane values (1,'白天时段公交专用道','成龙路','三环路','绕城','5.24','7—20','10.48');
insert into map_bus_lane values (1,'白天时段公交专用道','益州大道','绕城','界牌','4.4','7—20','8.8');
insert into map_bus_lane values (1,'白天时段公交专用道','羊西线','二环路','三环路','4.04','7—20','8.08');
insert into map_bus_lane values (1,'白天时段公交专用道','香樟大道','成龙路','成渝路','2.17','7—20','4.34');
insert into map_bus_lane values (1,'白天时段公交专用道','迎晖路','经华路','成渝立交','3.57','7—20','7.14');
insert into map_bus_lane values (1,'白天时段公交专用道','成飞大道','光华大道','132厂','3.58','7—20','7.16');
insert into map_bus_lane values (1,'白天时段公交专用道','2.5环','成龙路','成洛路','6.72','7—20','13.44');
insert into map_bus_lane values (1,'白天时段公交专用道','2.5环','成洛路','老成华大道','1.78','7—20','3.56');
insert into map_bus_lane values (1,'白天时段公交专用道','金府路','老区委','川陕路','9','7—20','18');
insert into map_bus_lane values (1,'白天时段公交专用道','昭觉寺横街','青龙立交','川陕路','1.67','7—20','3.34');
insert into map_bus_lane values (1,'白天时段公交专用道','机场路东延线','白云小区','成龙路','3.4','7—20','6.8');
insert into map_bus_lane values (1,'白天时段公交专用道','一品天下大街','交大路','老成灌路','1.71','7—20','3.42');
insert into map_bus_lane values (1,'白天时段公交专用道','成新大件路','三环路','绕城','4.18','7—20','8.36');
insert into map_bus_lane values (1,'白天时段公交专用道','交大路','二环路','金府路','2.3','7—20','4.6');
insert into map_bus_lane values (1,'白天时段公交专用道','解放路','成都旅馆','高笋塘','3.2','7—20','6.4');
insert into map_bus_lane values (1,'白天时段公交专用道','川陕路','高笋塘','川陕立交','3.38','7—20','6.76');
insert into map_bus_lane values (1,'白天时段公交专用道','川陕路','川陕立交','天回镇','4.82','7—20','9.64');
insert into map_bus_lane values (1,'白天时段公交专用道','锦城大道','科华南路','剑南大道','2.7','7—20','5.4');
insert into map_bus_lane values (1,'白天时段公交专用道','锦城大道','剑南大道','新园大道','4','7—20','8');
insert into map_bus_lane values (1,'白天时段公交专用道','天府二街','天府大道','大源北一街','3','7—20','6');
insert into map_bus_lane values (1,'白天时段公交专用道','锦华路','锦江大道','绕城高速','2','7—20','4');
insert into map_bus_lane values (1,'白天时段公交专用道','成洛路','三环路','绕城','5.55','7—20','11.1');
                                 
insert into map_bus_lane values (1,'高峰时段公交专用道','成青金快速路','北湖路口','绕城','6','高峰期','12');
insert into map_bus_lane values (1,'高峰时段公交专用道','新双龙路','龙港路口','绕城','4.35','高峰期','8.7');
insert into map_bus_lane values (1,'高峰时段公交专用道','蜀龙路四期','三环路','绕城','7.38','高峰期','14.76');
insert into map_bus_lane values (1,'高峰时段公交专用道','华冠路','双龙路','成致路','2.49','高峰期','4.98');
insert into map_bus_lane values (1,'高峰时段公交专用道','电子路（合作路）','南北大道','天润路','4.06','高峰期','8.12');
insert into map_bus_lane values (1,'高峰时段公交专用道','滨河路（郫县）','南北大道','华润路','5.82','高峰期','11.64');
                                 
insert into map_bus_lane values (1,'潮汐交通公交专用道','羊西线','未来号','二环路','3.7','高峰期','7.4');
insert into map_bus_lane values (1,'潮汐交通公交专用道','青羊上街','冠城路口','送仙桥路口','1.41','高峰期','2.82');
insert into map_bus_lane values (1,'潮汐交通公交专用道','武侯祠大街','金盾路','高升桥路口','2.44','高峰期','4.88');
                                 
insert into map_bus_lane values (1,'单向交通全天候公交专用道','新光路','一环路玉林北路口','紫荆东路口','2.4','24小时','2.4');
insert into map_bus_lane values (1,'单向交通全天候公交专用道','神仙树路','芳草街瑞升路口','紫瑞大道路口','2.8','24小时','2.8');
insert into map_bus_lane values (1,'单向交通全天候公交专用道','九里堤路','九里堤西路口','二环路口','2','24小时','2');
insert into map_bus_lane values (1,'单向交通全天候公交专用道','九里堤南路','二环路口','一环路','1','24小时','1');
insert into map_bus_lane values (1,'单向交通全天候公交专用道','沙湾路','一环路口','二环路口','1.1','24小时','1.1');
insert into map_bus_lane values (1,'单向交通全天候公交专用道','茶店子街','老区委路口','奥林体育场','2.28','7—20','2.28');
                                 
insert into map_bus_lane values (1,'快速路','二环高架全线','','','28.3','24小时','56.6');
commit;                          
