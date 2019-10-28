 /*人员数据查询：司乘人员使用orgid、routeid与mcrouteinfogs表进行关联，员工编号cardid，身份证编号idcard，
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
