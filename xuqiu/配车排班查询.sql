/*配车排班查询：bz_arrangeworkshiftld配车排班表。routeid需要和mcrouteinfogs.routename对应显示线路名称，需要按orgid对应父组织结构，
shiftnum车次，groupnum班次，driverid驾驶员ID，需要和职工表中的ID进行对应，显示人员名称，seqnum班型,execdate执行日期
busid车辆ID，需要和车辆信息表中的ID对应，显示车牌号和自编号，aw.onworktime1,aw.offworktime1第一名驾驶员的上下班时间
工时是当日驾驶员全部车次运行时间的总合，例如：驾驶员A当日车次8个，第个车次运行时长是40分钟，那么工时 = 8 * 40 (分钟)
车次数是当日驾驶员总的车次数量。这个表需要在每条记录后加一个“详细”，详细的内容为每个驾驶员或车辆的当日全部车次配车排班情况 */
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

