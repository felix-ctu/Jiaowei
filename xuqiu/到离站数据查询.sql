/*����վ���ݲ�ѯ��bsvcbusarrlftld5�������м�¼����datatype��¼������Ŀ������վ 4��Υ�� 55��
actdatetime,recdatetimeʵ�ʷ���ʱ��ͼ�¼ʱ�䣬stationnumվ���ţ�����վ��ID��վ�����ƶ�Ӧվ����Ϣ���ã�
stationtypeվ�����ͣ���վ�Ͽ�վ���м�վ����վ�¿�վ������վ�ȣ�isarrlft����վ��־��1��վ��2��վ��
productid��Ʒ��ţ����ػ��ϴ��ı�ţ��ɳ�����Ϣ����productid�ֶζ�Ӧ��ϵ������isappend������־��1������
ismanulopt�Ƿ��ֶ���־��A�Զ���M�ֶ�*/

Select Ba.Routeid,
       Ba.Busid,
       Ba.Productid,
       Ba.Datatype,
       Ba.Actdatetime,
       Ba.Recdatetime,
       Ba.Stationnum,
       Ba.Stationtype,
       Ba.Isarrlft,
       Ba.Isappend,
       Ba.Ismanulopt
  From Bsvcbusarrlftld5 Ba
 Where Ba.Datatype = 4
 
 

