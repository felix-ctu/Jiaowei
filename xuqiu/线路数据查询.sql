
/*线路数据查询：线路数据需要与组织关联orgid，关联的时候需要按父组织mcorginfogs.parentorgid分别汇总,只统计isactive=1有效数据，
开通时间begindate，线路级别routegrade，线路类型toutetype  */
select r.routeid,
       r.routename,
       r.orgid,
       r.routestyle,
       r.routetype,
       r.routegrade,
       sr.begindate,
       o.linkman
  from mcrouteinfogs r, mcsubrouteinfogs sr, mcorginfogs o
 where r.routeid = sr.routeid
   and r.orgid = o.orgid
   and r.isactive = 1
   and sr.isactive = 1

/*线路数据查询：首末站点、途经站点数据需要与组织关联orgid，关联的时候需要按父组织mcorginfogs.parentorgid分别汇总,
同时线路和子线需要对应，且线路都有效，即只统计isactive=1有效数据
线路基础信息mcrouteinfoge，子线基础信息mcsubrouteinfogs（线路按不同运行线路可划分多个子线，可同时存在和有效），
单程基础信息mcsegmentinfogs（线路分上下行、环行、准环行，上下行分为2个单程，环行为1个单程） */
/*主站到副站形成单程，按线路方式1个或2个单程组成子线，线路可有多个子线 */
/*单程顺序号sngserialid，双程顺序号dualserialid，站点类型stationtype（主站、副站、中间站、返回站） */
/*stationtype=6 主站上客站，stationtype=3 中间站，stationtype=9 副站下客站，stationtype=8 副站上客站，stationtype=7 主站下客站*/
/*.rundirection=1或2 stationtype=6 首站，stationtype=9 末站，rundirection=3 stationtype=6 首站，stationtype=12 末站 */

  select s.segmentid,
         s.segmentname,
         s.rundirection, /* 运行方向，用来区分单程*/
         rss.stationid,
         rss.stationtype,
         rss.sngserialid,
         rss.dualserialid
    from mcsegmentinfogs s, mcrsegmentstationgs rss
   where s.segmentid = rss.segmentid
     and s.isactive = 1
   order by s.segmentid, s.rundirection, rss.dualserialid, rss.sngserialid

/*线路数据查询：运营车辆使用orgid、routeid与mcrouteinfogs表进行关联，车牌号cardid，车辆自编号busselfid，
燃油类型oiltype，购买时间buydate，使用时间userdate,判断是否车辆有效isactive */
select br.routeid,
       b.cardid,
       b.busselfid,
       b.oiltype,
       b.buydate,
       b.usedate,
       b.buslength,
       b.bustype
  from mcbusinfogs b, mcrbusroutegs br
 where b.busid = br.busid
 and b.isactive=1
 
 /*线路数据查询：司乘人员使用orgid、routeid与mcrouteinfogs表进行关联，员工编号cardid，身份证编号idcard，
 驾驶员positiontype=1，判断是否有效isactive */
select e.orgid,
       e.empname,
       e.cardid,
       e.sex,
       e.idcard,
       e.startdate,
       er.routeid
  from mcremproutegs er, mcemployeeinfogs e
 where e.empid = er.empid
   and e.positiontype = 1
   and e.isactive = 1

/*线路数据查询：峰段划分 */
