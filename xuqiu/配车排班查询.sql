/*�䳵�Ű��ѯ��bz_arrangeworkshiftld�䳵�Ű��routeid��Ҫ��mcrouteinfogs.routename��Ӧ��ʾ��·���ƣ���Ҫ��orgid��Ӧ����֯�ṹ��
shiftnum���Σ�groupnum��Σ�driverid��ʻԱID����Ҫ��ְ�����е�ID���ж�Ӧ����ʾ��Ա���ƣ�seqnum����,execdateִ������
busid����ID����Ҫ�ͳ�����Ϣ���е�ID��Ӧ����ʾ���ƺź��Ա�ţ�aw.onworktime1,aw.offworktime1��һ����ʻԱ�����°�ʱ��
��ʱ�ǵ��ռ�ʻԱȫ����������ʱ����ܺϣ����磺��ʻԱA���ճ���8�����ڸ���������ʱ����40���ӣ���ô��ʱ = 8 * 40 (����)
�������ǵ��ռ�ʻԱ�ܵĳ����������������Ҫ��ÿ����¼���һ������ϸ������ϸ������Ϊÿ����ʻԱ�����ĵ���ȫ�������䳵�Ű���� */
select aw.routeid,
       aw.groupnum,
       aw.shiftnum,
       aw.seqnum,
       aw.driverid,
       aw.busid,
       aw.onworktime1,
       aw.offworktime1,
       aw.execdate
  from bz_arrangeworkshiftld aw

