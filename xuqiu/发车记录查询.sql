/*发车记录查询：bz_busrunrecordld车辆运行记录表，记录每个车次详情，seqnum车次数，
startstationid,endstationid,leavetime,arrivetime发车站、到达站、实际发车时间、实际到达时间，
milenum标准里程，gpsmile实际里程，rectype记录方式：1自动、2人工
到站时间 = 到达时间 - 发车时间
发车记录详情应是记录车辆运行过程中的全部到离站详情，与到离站数据查询类似 */

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
       brr.rundatadate,  /*实际运营时间*/
       brr.isfullflag     /* 车次是否全程，1是*/
  from bz_busrunrecordld brr
  where brr.isactive=1
