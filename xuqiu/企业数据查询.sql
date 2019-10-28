/*企业数据查询：组织ID，公司名称，联系人，组织按父组织parentorgid和组织级别orggrade进行汇总，注册区域regionarea（目前数据是假的）
，地址address，联系电话telephone，邮编post，传真fax，注册时间registerdate  */
select o.orgid,
       o.orgname,
       o.linkman o.parentorgid,
       o.orggrade,
       o.regionarea,
       o.address,
       o.telephone,
       o.post,
       o.fax,
       o.registerdate
  from mcorginfogs o

/*企业数据查询：人员数据需要与组织关联orgid，关联的时候需要按父组织mcorginfogs.parentorgid分别汇总,按职务类型分别汇总positiontype，
只统计isactive=1有效数据，positiontype=1驾驶员  */
select e.orgid, e.empname, e.orgid, e.positiontype,e.isactive from mcemployeeinfogs e

/*企业数据查询：车辆数据需要与组织关联orgid，关联的时候需要按父组织mcorginfogs.parentorgid和mcbusinfogs.orgidfrom父组织分别汇总,
车辆营运类型busoperatetype=1是公交车，只统计isactive=1有效数据  */
select b.orgid,b.busselfid,b.busoperatetype,b.isactive from mcbusinfogs b

/*企业数据查询：线路数据需要与组织关联orgid，关联的时候需要按父组织mcorginfogs.parentorgid分别汇总,只统计isactive=1有效数据  */
select r.routeid,r.routename,r.orgid,r.routestyle,r.routetype,r.routegrade,r.isactive from mcrouteinfogs r

/*企业数据查询：场站数据需要与组织关联orgid，关联的时候需要按父组织mcorginfogs.parentorgid分别汇总,只统计isactive=1有效数据  */
select s.siteid,s.sitename,s.sitetype,s.sitelevel,s.regionarea,r.isactive from mcsiteinfogs s

