create or replace procedure p_proc_audit(p_date date default null)
as
/************************************************************************************************
*                                                                                               *
*  Module Name : p_proc_audit                                                            		*
*                                                                                               *
*  File Name   : p_proc_audit.prc                                                        		*
*                                                                                               *
*  Description : used for batch run of reports                                             		*
*                                                                                               *
*  Code Section:                                                                                *
* Date      Version     Author               Description                                        *
* --------- -------- ---------------  ----------------------------------------------------      *
*                                                                                               *
* 23-Oct-16   1.0      Liu Mingshun      Initial release                                        *
************************************************************************************************/
	v_date date := sysdate;	
	v_errcode varchar2(20);
	v_errmsg  varchar2(2000);
begin

	--************************设置报表业务日期*******************  
  begin
	 if p_date is not null
	 then 
     P_PRE_BATCH(p_date);
	 else 
	 P_PRE_BATCH;
	 end if;
	 
	insert into rpt_proc_audit values('P_PRE_BATCH',v_date,null,'successful');
	commit;

	exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_PRE_BATCH',v_date,v_errcode,v_errmsg);
	  commit;
  end;

  
	--*******************************维护企业分类数据*******************  
	begin
     P_ENRICH_MAP_ORG_REGIONAL;

	insert into rpt_proc_audit values('P_ENRICH_MAP_ORG_REGIONAL',v_date,null,'successful');
	commit;
	
	exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_ENRICH_MAP_ORG_REGIONAL',v_date,v_errcode,v_errmsg);
	  commit;
  end;

  
	  
	--*******************************业务查询*******************  
  begin
     P_OBJ_CORPORATE;
	
	insert into rpt_proc_audit values('P_OBJ_CORPORATE',v_date,null,'successful');
	commit;
	
	exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_OBJ_CORPORATE',v_date,v_errcode,v_errmsg);
	  commit;
  end;
  
  begin
     P_OBJ_BUSINFO;

	insert into rpt_proc_audit values('P_OBJ_BUSINFO',v_date,null,'successful');
	commit;
	 
	exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_OBJ_BUSINFO',v_date,v_errcode,v_errmsg);
	  commit;
  end;
  
  begin
     P_OBJ_EMPLOYEE;

	insert into rpt_proc_audit values('P_OBJ_EMPLOYEE',v_date,null,'successful');
	commit;
	 
	exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_OBJ_EMPLOYEE',v_date,v_errcode,v_errmsg);
	  commit;
  end;
  
  begin
     P_OBJ_STATION;

	insert into rpt_proc_audit values('P_OBJ_STATION',v_date,null,'successful');
	commit;
	 
	exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_OBJ_STATION',v_date,v_errcode,v_errmsg);
	  commit;
  end;
  
  
  begin
     P_OBJ_SITE;

	insert into rpt_proc_audit values('P_OBJ_SITE',v_date,null,'successful');
	commit;
	 
	exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_OBJ_SITE',v_date,v_errcode,v_errmsg);
	  commit;
  end;
  
  
  begin
     P_OBJ_ROUTE;

	insert into rpt_proc_audit values('P_OBJ_ROUTE',v_date,null,'successful');
	commit;
	 
	exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_OBJ_ROUTE',v_date,v_errcode,v_errmsg);
	  commit;
  end;
/*
  begin
     P_BUSIQUERY_ARRLFT;

	insert into rpt_proc_audit values('P_BUSIQUERY_ARRLFT',v_date,null,'successful');
	commit;
	 
	exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_BUSIQUERY_ARRLFT',v_date,v_errcode,v_errmsg);
	  commit;
  end;
*/
  begin
     P_BUSIQUERY_DISPATCH_RECORD;

	insert into rpt_proc_audit values('P_BUSIQUERY_DISPATCH_RECORD',v_date,null,'successful');
	commit;
	 
	exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_BUSIQUERY_DISPATCH_RECORD',v_date,v_errcode,v_errmsg);
	  commit;
  end;  
   
   --**********************基础设施维护*******************
  begin
     P_INFRA_INFO;
	 
	insert into rpt_proc_audit values('P_INFRA_INFO',v_date,null,'successful');
	commit;

	 exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_INFRA_INFO',v_date,v_errcode,v_errmsg);
	  commit;
  end;
 
 

   --**********************运行表维护*******************
  
  begin
     P_ENRICH_BZ_BUSRUNRECORDLD;
	 
	insert into rpt_proc_audit values('P_ENRICH_BZ_BUSRUNRECORDLD',v_date,null,'successful');
	commit;

	 exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_ENRICH_BZ_BUSRUNRECORDLD',v_date,v_errcode,v_errmsg);
	  commit;
  end;

  
  --**********************车辆监控*******************
	begin
     P_MONITOR_INFO;

	insert into rpt_proc_audit values('P_MONITOR_INFO',v_date,null,'successful');
	commit;
	 
	exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_MONITOR_INFO',v_date,v_errcode,v_errmsg);
	  commit;
  end;
 
 
  --**********************线网分析*******************
  
  begin
     P_NETOPER_AVGDISTANCE;
	 
	insert into rpt_proc_audit values('P_NETOPER_AVGDISTANCE',v_date,null,'successful');
	commit;

	 exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_NETOPER_AVGDISTANCE',v_date,v_errcode,v_errmsg);
	  commit;
  end;
  
    
  --**********************服务质量*******************
  begin
     P_SVCQUALITY_AVGINTERVAL;
	 
	insert into rpt_proc_audit values('P_SVCQUALITY_AVGINTERVAL',v_date,null,'successful');
	commit;

	 exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_SVCQUALITY_AVGINTERVAL',v_date,v_errcode,v_errmsg);
	  commit;
  end;
  
    
  begin
     P_SVCQUALITY_DEPCLS;
	 
	insert into rpt_proc_audit values('P_SVCQUALITY_DEPCLS',v_date,null,'successful');
	commit;

	 exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_SVCQUALITY_DEPCLS',v_date,v_errcode,v_errmsg);
	  commit;
  end;
  
  
  begin
     P_SVCQUALITY_FLONTIME;
	 
	insert into rpt_proc_audit values('P_SVCQUALITY_FLONTIME',v_date,null,'successful');
	commit;

	 exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_SVCQUALITY_FLONTIME',v_date,v_errcode,v_errmsg);
	  commit;
  end;
  
  
  begin
     P_SVCQUALITY_CLSRATIONALITY;
	 
	insert into rpt_proc_audit values('P_SVCQUALITY_CLSRATIONALITY',v_date,null,'successful');
	commit;

	 exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_SVCQUALITY_CLSRATIONALITY',v_date,v_errcode,v_errmsg);
	  commit;
  end;
    
	
  --**********************供应保障*******************
	begin
     P_SPLYSECU_INFO;

	insert into rpt_proc_audit values('P_SPLYSECU_INFO',v_date,null,'successful');
	commit;
	 
	exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_SPLYSECU_INFO',v_date,v_errcode,v_errmsg);
	  commit;
  end;

    --**********************政策优惠*******************
	begin
     P_POLICYPREFER_INFO;
	 
	insert into rpt_proc_audit values('P_POLICYPREFER_INFO',v_date,null,'successful');
	commit;

	 exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_POLICYPREFER_INFO',v_date,v_errcode,v_errmsg);
	  commit;
  end;

  --**********************综合指标*******************
  begin
     P_MACRO_CIA;

	insert into rpt_proc_audit values('P_MACRO_CIA',v_date,null,'successful');
	commit;
	 
	exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_MACRO_CIA',v_date,v_errcode,v_errmsg);
	  commit;
  end;

  --**********************线路信息-excel*******************
  begin
     P_ROUTE_INFO_TMP;

	insert into rpt_proc_audit values('P_ROUTE_INFO_TMP',v_date,null,'successful');
	commit;
	 
	exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_ROUTE_INFO_TMP',v_date,v_errcode,v_errmsg);
	  commit;
  end;

  --**********************到离站信息*******************
  
  begin
     P_BUSIQUERY_ARRLFT;

	insert into rpt_proc_audit values('P_BUSIQUERY_ARRLFT',v_date,null,'successful');
	commit;
	 
	exception when others then
	  v_errcode:=SQLCODE;
	  v_errmsg :=SQLERRM;
	  insert into rpt_proc_audit values('P_BUSIQUERY_ARRLFT',v_date,v_errcode,v_errmsg);
	  commit;
  end;
  
end p_proc_audit;
/
