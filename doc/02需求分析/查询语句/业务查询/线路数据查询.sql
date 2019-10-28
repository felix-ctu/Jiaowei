
/*��·���ݲ�ѯ����·������Ҫ����֯����orgid��������ʱ����Ҫ������֯mcorginfogs.parentorgid�ֱ����,ֻͳ��isactive=1��Ч���ݣ�
��ͨʱ��begindate����·����routegrade����·����toutetype  */
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

/*��·���ݲ�ѯ����ĩվ�㡢;��վ��������Ҫ����֯����orgid��������ʱ����Ҫ������֯mcorginfogs.parentorgid�ֱ����,
ͬʱ��·��������Ҫ��Ӧ������·����Ч����ֻͳ��isactive=1��Ч����
��·������Ϣmcrouteinfoge�����߻�����Ϣmcsubrouteinfogs����·����ͬ������·�ɻ��ֶ�����ߣ���ͬʱ���ں���Ч����
���̻�����Ϣmcsegmentinfogs����·�������С����С�׼���У������з�Ϊ2�����̣�����Ϊ1�����̣� */
/*��վ����վ�γɵ��̣�����·��ʽ1����2������������ߣ���·���ж������ */
/*����˳���sngserialid��˫��˳���dualserialid��վ������stationtype����վ����վ���м�վ������վ�� */
/*stationtype=6 ��վ�Ͽ�վ��stationtype=3 �м�վ��stationtype=9 ��վ�¿�վ��stationtype=8 ��վ�Ͽ�վ��stationtype=7 ��վ�¿�վ*/
/*.rundirection=1��2 stationtype=6 ��վ��stationtype=9 ĩվ��rundirection=3 stationtype=6 ��վ��stationtype=12 ĩվ */

  select s.segmentid,
         s.segmentname,
         s.rundirection, /* ���з����������ֵ���*/
         rss.stationid,
         rss.stationtype,
         rss.sngserialid,
         rss.dualserialid
    from mcsegmentinfogs s, mcrsegmentstationgs rss
   where s.segmentid = rss.segmentid
     and s.isactive = 1
   order by s.segmentid, s.rundirection, rss.dualserialid, rss.sngserialid

/*��·���ݲ�ѯ����Ӫ����ʹ��orgid��routeid��mcrouteinfogs����й��������ƺ�cardid�������Ա��busselfid��
ȼ������oiltype������ʱ��buydate��ʹ��ʱ��userdate,�ж��Ƿ�����Чisactive */
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
 
 /*��·���ݲ�ѯ��˾����Աʹ��orgid��routeid��mcrouteinfogs����й�����Ա�����cardid�����֤���idcard��
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

/*��·���ݲ�ѯ����λ��� */
