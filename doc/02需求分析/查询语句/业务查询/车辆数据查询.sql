/*��·���ݲ�ѯ����Ӫ����ʹ��orgid��routeid��mcrouteinfogs����й��������ƺ�cardid�������Ա��busselfid��
ȼ������oiltype������ʱ��buydate��ʹ��ʱ��userdate,��λ��seatcount�����ػ����productid���ж��Ƿ�����Чisactive */
select br.routeid,
       b.cardid,
       b.busselfid,
       b.oiltype,
       b.buydate,
       b.usedate,
       b.buslength,
       b.bustype,
       b.seatcount,
       b.productid
    
  from mcbusinfogs b, mcrbusroutegs br
 where b.busid = br.busid
 and b.isactive=1
 
 
 
/* �ٺ˶��ؿ������������ࡢ����״̬��Ҫ��mcbusinfogs_bus�в�ѯ����mcbusinfogs_bus��������Դ��Ҫ��ʵ*/
