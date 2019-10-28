/*站点数据查询：首末站点、途经站点数据需要与组织关联orgid，关联的时候需要按父组织mcorginfogs.parentorgid分别汇总,
即只统计isactive=1有效数据*/

select s.stationid,
       s.stationno,
       s.stationname,
       s.longitude,
       s.latitude,
       s.stationlength,
       s.stationtype,
       s.ishangestation,
       s.isfleetstation
  from mcstationinfogs s

/*途径线路,需要将routeid修改为线路名称 ，还需要确定线路为有效状态*/
select s.stationid,
       rrs.routeid
  from mcstationinfogs s,mcrroutestationgs rrs
  where s.stationid=rrs.stationid
  order by s.stationid
