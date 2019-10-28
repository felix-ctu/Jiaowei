/*运营计划查询：bz_busplanld计划表。routeid需要和mcrouteinfogs.routename对应显示线路名称，需要按orgid对应父组织结构，
startdate,bp.enddate计划开始和结束时间，bp.createdate,bp.confirmdate计划建立时间和审批时间  */
  
/*运营计划查询：bz_busplanseqld发车计划明细表。routeid需要和bz_busplanldp.routeid对应线路ID，planid两表的计划ID对应关系，shiftnum车次，groupnum班次，
leavetime，arrivetime计划发车时间和计划到达时间，leavestationid，arrivestationidbp发车站和到达站，需要和mcstationinfogs.stationname对应中文名，
另外需要在这个查询中增加站点编号 ，mileage运行里程，运行时间 = 到达时间 - 发车时间 */

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
       bps.seqcount     /*车次数*/
  from bz_busplanld bp, bz_busplanseqld bps
 where bp.planid = bps.planid


