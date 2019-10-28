/*车辆违规查询：bsvcbusarrlftld5车辆运行记录表，由datatype记录数据项目，到离站 4、违章 55，
actdatetime,recdatetime实际发生时间和记录时间，stationnum站点编号，不是站点ID，站点名称对应站点信息表获得，
stationtype站点类型，主站上客站、中间站、副站下客站、返回站等，isarrlft到离站标志，1到站、2离站，
productid产品编号，车载机上传的编号，由车辆信息表中productid字段对应关系关联，peccancytype违规类型，
peccancyvalue违规值，peccancymaxvalue,peccancyavgvalue违规最大值、平均值，peccancytime违规时间，
peccancystarttime,peccancyendtime,违规开始时间、结束时间，longitude,latitude经纬度，
违规信息需要用标准和发生的违规值进行比较计算后得出  */

Select Ba.Routeid,
       Ba.Busid,
       Ba.Productid,
       Ba.Datatype,
       ba.peccancytype,
       ba.peccancyvalue,
       ba.peccancymaxvalue,
       ba.peccancyavgvalue,
       ba.peccancystarttime,
       ba.peccancyendtime,
       ba.peccancytime,
       ba.longitude,
       ba.latitude,
       Ba.Stationnum,
       Ba.Stationtype
  From Bsvcbusarrlftld5 Ba
 Where Ba.Datatype = 55
