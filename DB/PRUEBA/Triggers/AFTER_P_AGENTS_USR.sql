CREATE OR REPLACE TRIGGER INSIS_CUST.after_p_agents_usr
 AFTER
  INSERT OR DELETE OR UPDATE
 ON INSIS_CUST.P_AGENTS_USR
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
trig_event   VARCHAR2 (10);
BEGIN
    IF INSERTING
   THEN
      trig_event := 'INSERT';
   END IF;

   IF UPDATING
   THEN
      trig_event := 'UPDATE';
      ----------Created regarding CSA_EXPORT Procedure---------------- 14/09/2009 by Niki S and Joro M
      if :new.observation != :old.observation then
      insert into  hist_csa_changed_agents
                     (agent_id, egn, NAME, gname,
                      sname, fname, region_name,
                      observation, life, marriage,
                      life_investment, permanent_health,
                      accident, health, ground_conv,
                      railway_conv, air_conv,
                      maritime_conv, goods_in_transit,
                      fire_natural_cat, property_claims,
                      motor_thrd_part, air_conv_thrd_part,
                      maritime_conv_thrd_part, gen_thrd_part,
                      credit_ins, guarantee_ins,
                      financial_losses, legal_protec,
                      tourism_assistance, event,
                      ID, change_table
                     )
        VALUES      ( :old.agent_id, null, null,
                       null, null, null,
                       null, :old.observation,
                       null, null, null,
                       null, null, null,
                       null, null, null,
                       null, null, null,
                       null, null, null,
                       null, null, null,
                       null, null, null,
                       null,trig_event, hist_csa.nextval,'P_AGENTS_USR'
                       )                     ;


      END IF;
      END IF;

      IF DELETING
   THEN
      trig_event := 'DELETE';
   END IF;
END ;
/