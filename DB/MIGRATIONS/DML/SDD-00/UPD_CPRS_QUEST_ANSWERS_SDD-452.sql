--SCRIPT UPDATE CFG QUEST_ANSWER MENSAJERO
UPDATE INSIS_GEN_CFG_V10.CPRS_QUEST_ANSWERS
SET ID = 'Mensajero', NAME = 'Mensajero'
WHERE QUEST_ANS_CPRS_ID = 2250029740;

COMMIT;
/