/*��ҵ���ݲ�ѯ����֯ID����˾���ƣ���ϵ�ˣ���֯������֯parentorgid����֯����orggrade���л��ܣ�ע������regionarea��Ŀǰ�����Ǽٵģ�
����ַaddress����ϵ�绰telephone���ʱ�post������fax��ע��ʱ��registerdate  */
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

/*��ҵ���ݲ�ѯ����Ա������Ҫ����֯����orgid��������ʱ����Ҫ������֯mcorginfogs.parentorgid�ֱ����,��ְ�����ͷֱ����positiontype��
ֻͳ��isactive=1��Ч���ݣ�positiontype=1��ʻԱ  */
select e.orgid, e.empname, e.orgid, e.positiontype,e.isactive from mcemployeeinfogs e

/*��ҵ���ݲ�ѯ������������Ҫ����֯����orgid��������ʱ����Ҫ������֯mcorginfogs.parentorgid��mcbusinfogs.orgidfrom����֯�ֱ����,
����Ӫ������busoperatetype=1�ǹ�������ֻͳ��isactive=1��Ч����  */
select b.orgid,b.busselfid,b.busoperatetype,b.isactive from mcbusinfogs b

/*��ҵ���ݲ�ѯ����·������Ҫ����֯����orgid��������ʱ����Ҫ������֯mcorginfogs.parentorgid�ֱ����,ֻͳ��isactive=1��Ч����  */
select r.routeid,r.routename,r.orgid,r.routestyle,r.routetype,r.routegrade,r.isactive from mcrouteinfogs r

/*��ҵ���ݲ�ѯ����վ������Ҫ����֯����orgid��������ʱ����Ҫ������֯mcorginfogs.parentorgid�ֱ����,ֻͳ��isactive=1��Ч����  */
select s.siteid,s.sitename,s.sitetype,s.sitelevel,s.regionarea,r.isactive from mcsiteinfogs s

