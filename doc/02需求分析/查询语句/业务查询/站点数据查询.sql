/*վ�����ݲ�ѯ����ĩվ�㡢;��վ��������Ҫ����֯����orgid��������ʱ����Ҫ������֯mcorginfogs.parentorgid�ֱ����,
��ֻͳ��isactive=1��Ч����*/

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

/*;����·,��Ҫ��routeid�޸�Ϊ��·���� ������Ҫȷ����·Ϊ��Ч״̬*/
select s.stationid,
       rrs.routeid
  from mcstationinfogs s,mcrroutestationgs rrs
  where s.stationid=rrs.stationid
  order by s.stationid
