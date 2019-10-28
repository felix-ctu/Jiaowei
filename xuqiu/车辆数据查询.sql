/*线路数据查询：运营车辆使用orgid、routeid与mcrouteinfogs表进行关联，车牌号cardid，车辆自编号busselfid，
燃油类型oiltype，购买时间buydate，使用时间userdate,座位数seatcount，车载机编号productid，判断是否车辆有效isactive */
select br.routeid,
       b.cardid,
       b.busselfid,
       b.oiltype,
       b.buydate,
       b.usedate,
       b.buslength,
       b.bustype,
       b.seatcount,
       b.productid
    
  from mcbusinfogs b, mcrbusroutegs br
 where b.busid = br.busid
 and b.isactive=1
 
 
 
/* 少核定载客数、车辆分类、车辆状态需要在mcbusinfogs_bus中查询，但mcbusinfogs_bus表数据来源需要落实*/
