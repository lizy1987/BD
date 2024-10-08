CREATE TABLE INSIS_CUST.AFFINITY_TEST
(
  INSR_TYPE      NUMBER(14),
  SPONSOR_ID     NUMBER(14),
  COVER_TYPE     VARCHAR2(20 BYTE),
  P_ASISTENCIAS  NUMBER(2),
  P_EXTRAPRIMA   NUMBER(2),
  P_PROFIT       NUMBER(2),
  P_RECARGO_COM  NUMBER(2),
  P_GASTO_ADQ    NUMBER(2),
  INSURED_VALUE  NUMBER(14),
  PESO           NUMBER(14),
  COSTO_FINAL    NUMBER(14),
  BEGIN_DATE     DATE,
  END_DATE       DATE
)
TABLESPACE USERS
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
/