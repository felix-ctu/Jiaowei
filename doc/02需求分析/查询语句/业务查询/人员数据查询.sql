 /*��Ա���ݲ�ѯ��˾����Աʹ��orgid��routeid��mcrouteinfogs����й�����Ա�����cardid�����֤���idcard��
 ��ʻԱpositiontype=1���ж��Ƿ���Чisactive */
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
