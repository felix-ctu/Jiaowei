/*��Ӫ�ƻ���ѯ��bz_busplanld�ƻ���routeid��Ҫ��mcrouteinfogs.routename��Ӧ��ʾ��·���ƣ���Ҫ��orgid��Ӧ����֯�ṹ��
startdate,bp.enddate�ƻ���ʼ�ͽ���ʱ�䣬bp.createdate,bp.confirmdate�ƻ�����ʱ�������ʱ��  */
  
/*��Ӫ�ƻ���ѯ��bz_busplanseqld�����ƻ���ϸ��routeid��Ҫ��bz_busplanldp.routeid��Ӧ��·ID��planid����ļƻ�ID��Ӧ��ϵ��shiftnum���Σ�groupnum��Σ�
leavetime��arrivetime�ƻ�����ʱ��ͼƻ�����ʱ�䣬leavestationid��arrivestationidbp����վ�͵���վ����Ҫ��mcstationinfogs.stationname��Ӧ��������
������Ҫ�������ѯ������վ���� ��mileage������̣�����ʱ�� = ����ʱ�� - ����ʱ�� */

select bp.routeid,
       bp.planname,
       bp.startdate,
       bp.enddate,
       bp.createdate,
       bp.confirmdate,
       bps.shiftnum,
       bps.groupnum,
       bps.leavetime,
       bps.arrivetime,
       bps.leavestationid,
       bps.arrivestationid,
       bps.mileage,
       bps.seqcount     /*������*/
  from bz_busplanld bp, bz_busplanseqld bps
 where bp.planid = bps.planid


