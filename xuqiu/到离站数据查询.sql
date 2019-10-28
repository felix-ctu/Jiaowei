/*到离站数据查询：bsvcbusarrlftld5车辆运行记录表，由datatype记录数据项目，到离站 4、违章 55，
actdatetime,recdatetime实际发生时间和记录时间，stationnum站点编号，不是站点ID，站点名称对应站点信息表获得，
stationtype站点类型，主站上客站、中间站、副站下客站、返回站等，isarrlft到离站标志，1到站、2离站，
productid产品编号，车载机上传的编号，由车辆信息表中productid字段对应关系关联，isappend补发标志，1补发，
ismanulopt是否手动标志，A自动、M手动*/

Select Ba.Routeid,
       Ba.Busid,
       Ba.Productid,
       Ba.Datatype,
       Ba.Actdatetime,
       Ba.Recdatetime,
       Ba.Stationnum,
       Ba.Stationtype,
       Ba.Isarrlft,
       Ba.Isappend,
       Ba.Ismanulopt
  From Bsvcbusarrlftld5 Ba
 Where Ba.Datatype = 4
 
 

