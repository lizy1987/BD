CREATE OR REPLACE TYPE INSIS_CUST."BTA_NEW_ROLE"                                          
AS
  object
  (
    --CRF_956, OS, 30062011
    menu_entry VARCHAR2(30),
    parent_id  VARCHAR2(30),
    name       VARCHAR2(100),
    put_1_here VARCHAR2(30) )
/