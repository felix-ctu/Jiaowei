/*����Υ���ѯ��bsvcbusarrlftld5�������м�¼����datatype��¼������Ŀ������վ 4��Υ�� 55��
actdatetime,recdatetimeʵ�ʷ���ʱ��ͼ�¼ʱ�䣬stationnumվ���ţ�����վ��ID��վ�����ƶ�Ӧվ����Ϣ���ã�
stationtypeվ�����ͣ���վ�Ͽ�վ���м�վ����վ�¿�վ������վ�ȣ�isarrlft����վ��־��1��վ��2��վ��
productid��Ʒ��ţ����ػ��ϴ��ı�ţ��ɳ�����Ϣ����productid�ֶζ�Ӧ��ϵ������peccancytypeΥ�����ͣ�
peccancyvalueΥ��ֵ��peccancymaxvalue,peccancyavgvalueΥ�����ֵ��ƽ��ֵ��peccancytimeΥ��ʱ�䣬
peccancystarttime,peccancyendtime,Υ�濪ʼʱ�䡢����ʱ�䣬longitude,latitude��γ�ȣ�
Υ����Ϣ��Ҫ�ñ�׼�ͷ�����Υ��ֵ���бȽϼ����ó�  */

Select Ba.Routeid,
       Ba.Busid,
       Ba.Productid,
       Ba.Datatype,
       ba.peccancytype,
       ba.peccancyvalue,
       ba.peccancymaxvalue,
       ba.peccancyavgvalue,
       ba.peccancystarttime,
       ba.peccancyendtime,
       ba.peccancytime,
       ba.longitude,
       ba.latitude,
       Ba.Stationnum,
       Ba.Stationtype
  From Bsvcbusarrlftld5 Ba
 Where Ba.Datatype = 55
