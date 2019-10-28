/*场站数据查询：*/
select s.id,
       s.siteid,
       s.sitename,
       s.sitetype,
       s.longitude,
       s.latitude,
       s.regionarea,
       s.hasvadio,
       s.sitefrom,
       s.usedate
  from mcsiteinfogs s
 where s.isactive = 1
