CREATE OR REPLACE PROCEDURE INSIS_CUST.ADD_LOG (pMessage Varchar2) AS 
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  Insert Into INSIS_CUST.log_table Values (pMessage, CURRENT_TIMESTAMP);
  Commit;
Exception
    When Others Then
        Rollback;
END ADD_LOG;
/