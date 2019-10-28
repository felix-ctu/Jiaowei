/*发车计划查询：bz_busdisplanld发车计划表，shiftnum车次，startstationid,endstationid 发车站和到达站，需要与站点信息表中ID对应，显示名称
seqtype车次类型，bdp.leavetime,bdp.arrivetime发车时间和到达时间，milenum里程，车次完成并确认后里程为GPS里程，计划未执行时为标准里程，
driverid,dirvername驾驶员，stewardid,stewardname乘务员，运行时间 = 到达时间 - 发车时间 ， isactive=1为有效车次 */
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
