/*�����ƻ���ѯ��bz_busdisplanld�����ƻ���shiftnum���Σ�startstationid,endstationid ����վ�͵���վ����Ҫ��վ����Ϣ����ID��Ӧ����ʾ����
seqtype�������ͣ�bdp.leavetime,bdp.arrivetime����ʱ��͵���ʱ�䣬milenum��̣�������ɲ�ȷ�Ϻ����ΪGPS��̣��ƻ�δִ��ʱΪ��׼��̣�
driverid,dirvername��ʻԱ��stewardid,stewardname����Ա������ʱ�� = ����ʱ�� - ����ʱ�� �� isactive=1Ϊ��Ч���� */
select bdp.routeid,
       bdp.orgid,
       bdp.shiftnum,
       bdp.startstationid,
       bdp.endstationid,
       bdp.seqtype,
       bdp.leavetime,
       bdp.arrivetime,
       bdp.milenum,
       bdp.driverid,
       bdp.dirvername,
       bdp.stewardid,
       bdp.stewardname
  from bz_busdisplanld bdp
  where bdp.isactive=1
