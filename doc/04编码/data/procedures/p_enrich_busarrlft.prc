CREATE OR REPLACE PROCEDURE P_ENRICH_BUSARRLFT AS
/***************************************************************************************
*    名称：P_ENRICH_BUSARRLFT                                                          *
*                                                                                      *
*    功能：导入GPS数据                                                                 *
*                                                                                      *
*    作者：Liu Mingshun                                                                *
*    日期：2016-12-20                                                                  *
****************************************************************************************/
    V_DATE     		DATE := GETBUSINESSDATE +1;
    V_DATE_RECORD 	DATE := TRUNC(SYSDATE - 3);
    V_SQL         	VARCHAR2(500);
    V_ERRORMESS   	VARCHAR2(200);
	V_SQLNUM		NUMBER;
	V_START     	NUMBER := 0;
	V_CONNECT		NUMBER;
BEGIN

	FOR i in 0..3 LOOP
	BEGIN
		SELECT 1 INTO V_CONNECT
		FROM BSVCBUSARRLFTLD5@APTS2
		WHERE ROWNUM = 1;
	EXCEPTION WHEN OTHERS 
		THEN NULL;
	END;
	END LOOP;
-------------------------------------------------------------------------------------------------
-- 清除GPS数据
-------------------------------------------------------------------------------------------------
SELECT 'ALTER TABLE BSVCBUSARRLFTLD5 TRUNCATE PARTITION P_' ||
	   TO_CHAR(V_DATE, 'yyyymmdd')
  INTO V_SQL
  FROM DUAL;
EXECUTE IMMEDIATE V_SQL;
COMMIT;
-------------------------------------------------------------------------------------------------
-- 清除GPS数据导入日志
-------------------------------------------------------------------------------------------------
DELETE FROM SYS_GPSIMPORTLOG T WHERE T.ACTDATE = V_DATE;
COMMIT;
-------------------------------------------------------------------------------------------------
-- 分时段导入GPS数据
-------------------------------------------------------------------------------------------------
FOR CUR IN 0 .. 23 LOOP
  INSERT /*+append*/
  INTO BSVCBUSARRLFTLD5
	(BUSRDID,
	 DATATYPE,
	 ROUTEID,
	 SUBROUTEID,
	 PRODUCTID,
	 STATIONSEQNUM,
	 STATIONNUM,
	 ISARRLFT,
	 ACTDATETIME,
	 RECDATETIME,
	 WRITEID,
	 ISAPPEND,
	 BUSSID,
	 LONGITUDE,
	 LATITUDE,
	 ALTITUDE,
	 GPSSPEED,
	 SENSORSPEED,
	 ROTATIONANGLE,
	 STATIONTYPE,
	 ISMANULOPT,
	 PACKCODE,
	 SMCODE,
	 ONPNUM,
	 OFFPNUM,
	 LEFTPNUM,
	 TPTDATA,
	 DOORSTATE,
	 PECCANCYTYPE,
	 PECCANCYTIME,
	 STANDARDVALUE,
	 PECCANCYVALUE,
	 GPSMILE,
	 RESERVECHAR1,
	 RESERVECHAR2,
	 RESERVECHAR3,
	 RESERVECHAR4,
	 RESERVECHAR5,
	 RESERVECHAR6,
	 RESERVECHAR7,
	 RESERVECHAR8,
	 RESERVECHAR9,
	 RESERVECHAR10)
	(SELECT BUSRDID,
			DATATYPE,
			ROUTEID,
			SUBROUTEID,
			PRODUCTID,
			STATIONSEQNUM,
			STATIONNUM,
			ISARRLFT,
			ACTDATETIME,
			RECDATETIME,
			WRITEID,
			ISAPPEND,
			BUSSID,
			LONGITUDE,
			LATITUDE,
			ALTITUDE,
			GPSSPEED,
			SENSORSPEED,
			ROTATIONANGLE,
			STATIONTYPE,
			ISMANULOPT,
			PACKCODE,
			SMCODE,
			ONPNUM,
			OFFPNUM,
			LEFTPNUM,
			TPTDATA,
			DOORSTATE,
			PECCANCYTYPE,
			PECCANCYTIME,
			STANDARDVALUE,
			PECCANCYVALUE,
			GPSMILE,
			RESERVECHAR1,
			RESERVECHAR2,
			RESERVECHAR3,
			RESERVECHAR4,
			RESERVECHAR5,
			RESERVECHAR6,
			RESERVECHAR7,
			RESERVECHAR8,
			RESERVECHAR9,
			RESERVECHAR10
	   FROM BSVCBUSARRLFTLD5@APTS2 T
	  WHERE T.ACTDATETIME >= V_DATE + CUR / 24
		AND T.ACTDATETIME < V_DATE + (CUR + 1) / 24);
  --每cur/24提交一次
  COMMIT;
  --写入导入日志
  SELECT COUNT(*)
	INTO V_SQLNUM
	FROM BSVCBUSARRLFTLD5 T
   WHERE T.ACTDATETIME >= V_DATE + CUR / 24
	 AND T.ACTDATETIME < V_DATE + (CUR + 1) / 24;
  INSERT INTO SYS_GPSIMPORTLOG
	(ID, DESCRIPTION, SUCCESSFLAG, STARTTIME, ENDTIME, ACTDATE, SQLNUM)
  VALUES
	(S_LOG.NEXTVAL,
	 'GPS数据导入' || CUR || '-' || (CUR + 1),
	 '1',
	 CUR,
	 (CUR + 1),
	 V_DATE,
	 V_SQLNUM);
  COMMIT;
  V_START := CUR;
END LOOP;
DELETE FROM SYS_IMPORTRECORD T WHERE T.ACTDATE = V_DATE;
COMMIT;
INSERT INTO SYS_IMPORTRECORD
  (ID, DATATYPE, ACTDATE)
VALUES
  (S_LOG.NEXTVAL, '0', V_DATE);
COMMIT;
EXCEPTION
WHEN OTHERS THEN
  V_ERRORMESS := SUBSTR(SQLERRM, 1, 200);
  INSERT INTO SYS_GPSIMPORTLOG
	(ID, DESCRIPTION, SUCCESSFLAG, STARTTIME, ENDTIME, ACTDATE, SQLNUM)
  VALUES
	(S_LOG.NEXTVAL,
	 'GPS数据导入异常' || V_ERRORMESS,
	 '0',
	 V_START,
	 24,
	 V_DATE,
	 0);
  COMMIT;

END;