/*������¼��ѯ��bz_busrunrecordld�������м�¼����¼ÿ���������飬seqnum��������
startstationid,endstationid,leavetime,arrivetime����վ������վ��ʵ�ʷ���ʱ�䡢ʵ�ʵ���ʱ�䣬
milenum��׼��̣�gpsmileʵ����̣�rectype��¼��ʽ��1�Զ���2�˹�
��վʱ�� = ����ʱ�� - ����ʱ��
������¼����Ӧ�Ǽ�¼�������й����е�ȫ������վ���飬�뵽��վ���ݲ�ѯ���� */

select brr.routeid,
       brr.seqnum,
       brr.busid,
       brr.driverid,
       brr.startstationid,
       brr.endstationid,
       brr.leavetime,
       brr.arrivetime,
       brr.milenum,
       brr.gpsmile,
       brr.rectype,
       brr.rundatadate,  /*ʵ����Ӫʱ��*/
       brr.isfullflag     /* �����Ƿ�ȫ�̣�1��*/
  from bz_busrunrecordld brr
  where brr.isactive=1
