create or replace procedure p_enrich_tables
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_enrich_tables                                                               	*
*                                                                                               *
*  File Name   : p_enrich_tables.prc                                                           	*
*                                                                                               *
*  Description : 复制center数据库数据表的刷卡及收入数据											*
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 25-Nov-16   1.0      Liu Mingshun      Initial release                                        *
************************************************************************************************/
		v_date				date;
		v_date_from			varchar2(20);
		v_date_to			varchar2(20);
		v_partition		 	varchar2(20);
		v_partition_date	varchar2(20);
		v_date_err 			date := sysdate;	
		v_errcode 			varchar2(20);
		v_errmsg  			varchar2(2000);
		v_count				number;
begin
	
	--delete from v_tbmonth_temp where trunc(consumedate) = v_date;
	--delete from as_sc_icincome where trunc(riqi) = v_date;
	--delete from as_sc_cashincome where trunc(riqi) = v_date;
	--execute immediate 'truncate table pz_bus_oil 			drop storage';
	--execute immediate 'truncate table pz_sc_cash 			drop storage';
	--execute immediate 'truncate table pz_sc_pay 			drop storage';
	--execute immediate 'truncate table as_sc_busrentincome 	drop storage';
	
	v_count:= to_char(trunc(add_months(sysdate,1),'mm')-1,'dd');
	
	if sysdate = trunc(sysdate,'mm')
	then 
		for i in 1..v_count
		loop
			v_partition := 'p_'||to_char(sysdate,'yyyymm')||(case when i<10 then '0'||to_char(i) else to_char(i) end);
			v_partition_date := to_char(sysdate,'yyyymm')||(case when i<10 then '0'||to_char(i) else to_char(i) end);
			
			execute immediate '
			alter table v_tbmonth_temp 
				add partition '||v_partition||' values less than (TO_DATE('''||v_partition_date||' 23:59:59'',''yyyymmdd hh24:mi:ss'')) 
				tablespace tbs_osecdjw_bsvc';
		end loop;
	end if;	
	
	begin
		select trunc(max(consumedate))+1 into v_date
		from v_tbmonth_temp;
		
		v_date_from := to_char(v_date,'yyyymmdd')||' 00:00:00';
		v_date_to 	:= to_char(v_date,'yyyymmdd')||' 23:59:59';
	
	exception when others then
			  null;
	end;
	
	
	
	insert into v_tbmonth_temp (
		cardno     ,
		consume    ,
		remaintimes,
		balance    ,
		consumedate,
		consumetype,
		lineno     ,
		busno      
	)
	select
		cardno     ,
		consume    ,
		remaintimes,
		balance    ,
		consumedate,
		consumetype,
		lineno     ,
		busno      
	from v_tbmonth_temp@center
	where consumedate >= to_date(v_date_from,'yyyymmdd hh24:mi:ss')
	and consumedate <= to_date(v_date_to,'yyyymmdd hh24:mi:ss');
	commit; 


	 /*
	begin
	insert into as_sc_icincome(
		id                 ,
		riqi               ,
		chehao             ,
		dianziqianbao      ,
		dianziqianbaorenci ,
		chengrenrenci      ,
		chengrenshouru     ,
		xueshengrenci      ,
		xueshengshouru     ,
		laonianrenci       ,
		laonianshouru      ,
		jiashiyuanbianhao  ,
		jiashiyuan         ,
		xunishouru         
	)
	select
		id                 ,
		riqi               ,
		chehao             ,
		dianziqianbao      ,
		dianziqianbaorenci ,
		chengrenrenci      ,
		chengrenshouru     ,
		xueshengrenci      ,
		xueshengshouru     ,
		laonianrenci       ,
		laonianshouru      ,
		jiashiyuanbianhao  ,
		jiashiyuan         ,
		xunishouru         
	from as_sc_icincome@center
	where riqi >= trunc(add_months(v_date,-1),'mm')
	and riqi <= trunc(v_date,'mm')-1;
    commit; 
	 
    exception
      when others then
        null;
    end;
	
	begin
	insert into as_sc_cashincome(
		id      , 
		riqi    , 
		chehao  , 
		sijihao , 
		xianjin 
	)
	select
		id      , 
		riqi    , 
		chehao  , 
		sijihao , 
		xianjin 
	from as_sc_cashincome@center
	where riqi >= trunc(add_months(v_date,-1),'mm')
	and riqi <= trunc(v_date,'mm')-1;
    commit; 
	 
    exception
      when others then
        null;
    end;
	
	
	begin
	insert into pz_bus_oil(
		cono        , 
		buscrewname , 
		lineno      , 
		busno       , 
		cph         , 
		nf          , 
		yf          , 
		gas_num     , 
		gas_money   , 
		gas_price   , 
		gas_type    , 
		jqzbh       , 
		khmch       , 
		zdygs       , 
		inputdate   
	)
	select
		cono        , 
		buscrewname , 
		lineno      , 
		busno       , 
		cph         , 
		nf          , 
		yf          , 
		gas_num     , 
		gas_money   , 
		gas_price   , 
		gas_type    , 
		jqzbh       , 
		khmch       , 
		zdygs       , 
		inputdate   
	from pz_bus_oil@center
	where nf = to_char(v_date,'yyyy');
    commit; 
	 
    exception
      when others then
        null;
    end;
	
	begin
	insert into pz_sc_cash(
		cono         , 
		buscrewno    , 
		buscrewname  , 
		lineno       , 
		cashmoney    , 
		yearmonth    , 
		moneytype    , 
		inputdate    
	)
	select
		cono         , 
		buscrewno    , 
		buscrewname  , 
		lineno       , 
		cashmoney    , 
		yearmonth    , 
		moneytype    , 
		inputdate    
	from pz_sc_cash@center
	where yearmonth = to_char(v_date,'yyyy')-1;
    commit; 
	 
    exception
      when others then
        null;
    end;
	
	
	begin
	insert into pz_sc_pay(
		xm         ,
		cono       ,
		dwlb       ,
		bm         ,
		bsy        ,
		sylt       ,
		ltgz       ,
		jbgz       ,
		sggz       ,
		gwgz       ,
		glgz       ,
		jngz       ,
		jsgz       ,
		jjgz       ,
		rcgz       ,
		lcgz       ,
		bcgz       ,
		csgz       ,
		gjj        ,
		ylj        ,
		syj        ,
		ylbx       ,
		zhbx       ,
		gzxbt      ,
		gwjngz     ,
		bfgz       ,
		jbgzh      ,
		gb         ,
		ht         ,
		sbf        ,
		wsf        ,
		zwjt       ,
		zhbt       ,
		qtjt       ,
		xyj        ,
		fwj        ,
		jnj        ,
		mbj        ,
		aqj        ,
		icqj       ,
		qtjx       ,
		kqkhkk     ,
		afzkk      ,
		qtyf       ,
		sgbk       ,
		qtkk       ,
		yfgz       ,
		kkzh       ,
		yjsj       ,
		sfgz       ,
		sfhj       ,
		yfnzj      ,
		nzjyks     ,
		sfnzj      ,
		fwbmj      ,
		qpmjl      ,
		yfnzjmy    ,
		wt         ,
		mt         ,
		lt         ,
		nt         ,
		kq         ,
		pm         ,
		wb         ,
		cd         ,
		bjt        ,
		sjt        ,
		ybwd       ,
		wwrwk      ,
		fwbmkk     ,
		aqbmkk     ,
		jwbmkk     ,
		qqtz       ,
		byns       ,
		szje       ,
		db         ,
		xx         ,
		jt         ,
		jq         ,
		bj         ,
		shj        ,
		wj         ,
		wg         ,
		jw         ,
		csh        ,
		tb         ,
		ybc        ,
		wwrw       ,
		qcww       ,
		zdyy       ,
		zdye       ,
		zdys       ,
		zdysh      ,
		zdyw       ,
		zdyl       ,
		zdyq       ,
		zdyb       ,
		zdyj       ,
		czy        ,
		inputdate  ,
		employeeid ,
		yf         ,
		ffcs       ,
		nf         ,
		ztbm       ,
		ztmc       ,
		bz         ,
		qm         ,
		recordid   ,
		zrsj       ,
		spr        ,
		gzscjj     ,
		jyjqj      ,
		qtbt       ,
		htlx       ,
		ryzt       ,
		gzlx       ,
		qtgz       ,
		jtbz       ,
		zcbz       ,
		xlbz       ,
		jxbz       ,
		jsjs       ,
		dkk        ,
		kqkk       ,
		jzbt       ,
		bzzjt      ,
		nggz       ,
		gwjt       ,
		kskk       ,
		jxgz       ,
		afj        ,
		jzaqj      ,
		gjgz       ,
		wcbt       ,
		qtfy       ,
		khf        ,
		gfbt       ,
		zcjt       ,
		jxjt       ,
		jrf        ,
		bsyjx      ,
		rygw       ,
		sqgz       ,
		khfs       ,
		bbjx       ,
		xs         ,
		bzgj       ,
		ysgz       ,
		sfzh       ,
		lineno     ,
		xb         ,
		gwdj       ,
		rygz       ,
		jsbz       ,
		bzjtf      ,
		shsfl      ,
		zy         ,
		ryshx      ,
		rylb       ,
		typeid     ,
		rzrq       ,
		shgl       ,
		bzwcf      ,
		jbylj      ,
		ycqt       ,
		ecqt       ,
		gzhxbt     ,
		jsbt       ,
		hmbt       ,
		gsbt       ,
		yfbt       ,
		fz         ,
		sd         ,
		sfbt       ,
		qt         ,
		jcgz       ,
		xygz       ,
		jbgzy      ,
		jbgze      ,
		gzbt       ,
		pz         ,
		fdgz       ,
		zwgz       ,
		jyf        ,
		jj         ,
		fspbz      ,
		xlf        ,
		yfhj       ,
		ylsch      ,
		cjgz       ,
		yyj        ,
		yskhj      ,
		jdj        ,
		gwbt       ,
		ccj        ,
		byjl       ,
		gzrc       ,
		gzbx       ,
		zdyys      ,
		zdysy      ,
		zdyse      ,
		zdyss      ,
		zdyshs     ,
		zdyshy     ,
		aqfxj      ,
		xlgz       ,
		zdgz       ,
		clwsks     ,
		dcgz       ,
		qtxl       ,
		nsby       ,
		gjkhkk     ,
		awkhkk     
	)
	select
		xm         ,
		cono       ,
		dwlb       ,
		bm         ,
		bsy        ,
		sylt       ,
		ltgz       ,
		jbgz       ,
		sggz       ,
		gwgz       ,
		glgz       ,
		jngz       ,
		jsgz       ,
		jjgz       ,
		rcgz       ,
		lcgz       ,
		bcgz       ,
		csgz       ,
		gjj        ,
		ylj        ,
		syj        ,
		ylbx       ,
		zhbx       ,
		gzxbt      ,
		gwjngz     ,
		bfgz       ,
		jbgzh      ,
		gb         ,
		ht         ,
		sbf        ,
		wsf        ,
		zwjt       ,
		zhbt       ,
		qtjt       ,
		xyj        ,
		fwj        ,
		jnj        ,
		mbj        ,
		aqj        ,
		icqj       ,
		qtjx       ,
		kqkhkk     ,
		afzkk      ,
		qtyf       ,
		sgbk       ,
		qtkk       ,
		yfgz       ,
		kkzh       ,
		yjsj       ,
		sfgz       ,
		sfhj       ,
		yfnzj      ,
		nzjyks     ,
		sfnzj      ,
		fwbmj      ,
		qpmjl      ,
		yfnzjmy    ,
		wt         ,
		mt         ,
		lt         ,
		nt         ,
		kq         ,
		pm         ,
		wb         ,
		cd         ,
		bjt        ,
		sjt        ,
		ybwd       ,
		wwrwk      ,
		fwbmkk     ,
		aqbmkk     ,
		jwbmkk     ,
		qqtz       ,
		byns       ,
		szje       ,
		db         ,
		xx         ,
		jt         ,
		jq         ,
		bj         ,
		shj        ,
		wj         ,
		wg         ,
		jw         ,
		csh        ,
		tb         ,
		ybc        ,
		wwrw       ,
		qcww       ,
		zdyy       ,
		zdye       ,
		zdys       ,
		zdysh      ,
		zdyw       ,
		zdyl       ,
		zdyq       ,
		zdyb       ,
		zdyj       ,
		czy        ,
		inputdate  ,
		employeeid ,
		yf         ,
		ffcs       ,
		nf         ,
		ztbm       ,
		ztmc       ,
		bz         ,
		qm         ,
		recordid   ,
		zrsj       ,
		spr        ,
		gzscjj     ,
		jyjqj      ,
		qtbt       ,
		htlx       ,
		ryzt       ,
		gzlx       ,
		qtgz       ,
		jtbz       ,
		zcbz       ,
		xlbz       ,
		jxbz       ,
		jsjs       ,
		dkk        ,
		kqkk       ,
		jzbt       ,
		bzzjt      ,
		nggz       ,
		gwjt       ,
		kskk       ,
		jxgz       ,
		afj        ,
		jzaqj      ,
		gjgz       ,
		wcbt       ,
		qtfy       ,
		khf        ,
		gfbt       ,
		zcjt       ,
		jxjt       ,
		jrf        ,
		bsyjx      ,
		rygw       ,
		sqgz       ,
		khfs       ,
		bbjx       ,
		xs         ,
		bzgj       ,
		ysgz       ,
		sfzh       ,
		lineno     ,
		xb         ,
		gwdj       ,
		rygz       ,
		jsbz       ,
		bzjtf      ,
		shsfl      ,
		zy         ,
		ryshx      ,
		rylb       ,
		typeid     ,
		rzrq       ,
		shgl       ,
		bzwcf      ,
		jbylj      ,
		ycqt       ,
		ecqt       ,
		gzhxbt     ,
		jsbt       ,
		hmbt       ,
		gsbt       ,
		yfbt       ,
		fz         ,
		sd         ,
		sfbt       ,
		qt         ,
		jcgz       ,
		xygz       ,
		jbgzy      ,
		jbgze      ,
		gzbt       ,
		pz         ,
		fdgz       ,
		zwgz       ,
		jyf        ,
		jj         ,
		fspbz      ,
		xlf        ,
		yfhj       ,
		ylsch      ,
		cjgz       ,
		yyj        ,
		yskhj      ,
		jdj        ,
		gwbt       ,
		ccj        ,
		byjl       ,
		gzrc       ,
		gzbx       ,
		zdyys      ,
		zdysy      ,
		zdyse      ,
		zdyss      ,
		zdyshs     ,
		zdyshy     ,
		aqfxj      ,
		xlgz       ,
		zdgz       ,
		clwsks     ,
		dcgz       ,
		qtxl       ,
		nsby       ,
		gjkhkk     ,
		awkhkk     
	from pz_sc_pay@center;
    commit; 
	 
    exception
      when others then
        null;
    end;
	*/
	
	
	
	/*
	begin
	insert into as_sc_busrentincome(
		id            ,
		riqi          ,
		chehao        ,
		sijihao       ,
		xianjin       ,
		baocheleixing 
	)
	select
		id            ,
		riqi          ,
		chehao        ,
		sijihao       ,
		xianjin       ,
		baocheleixing 
	from as_sc_busrentincome@center;
    commit; 
	 
    exception
      when others then
        null;
    end;
	*/


end p_enrich_tables;
/
