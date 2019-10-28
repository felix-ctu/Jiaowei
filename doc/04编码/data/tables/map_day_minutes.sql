DROP TABLE MAP_DAY_MINUTES CASCADE CONSTRAINTS PURGE;
CREATE TABLE MAP_DAY_MINUTES (MINUTES	VARCHAR2(20)) TABLESPACE TBS_OSECDJW_RPT NOLOGGING ;

COMMENT ON TABLE MAP_DAY_MINUTES  IS '在线历史数查询用';

declare
  p_date date;
begin
  delete from MAP_DAY_MINUTES; commit;
  for i in 1..1440
  loop
    p_date := trunc(sysdate)+i/1440;
insert into MAP_DAY_MINUTES select to_char(p_date,'hh24:mi:ss') from dual;
  end loop;
  commit;
end;