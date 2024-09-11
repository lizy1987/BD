CREATE OR REPLACE PACKAGE INSIS_CUST.ADDRESSES
IS

--------------------------------------------------------------------------------
-- RQ1000000998
-- Function sets the address according to the IC rules (if any)
--------------------------------------------------------------------------------
FUNCTION Set_Address( pi_post_code        IN VARCHAR2,
                      pi_city_code        IN VARCHAR2, 
                      pi_country_code     IN VARCHAR2,
                      pi_quarter_id       IN VARCHAR2,
                      pi_street_id        IN VARCHAR2,
                      pi_state_region     IN VARCHAR2,
                      pi_country_state    IN VARCHAR2,
                      pi_quarter_name     IN VARCHAR2,
                      pi_street_name      IN VARCHAR2,
                      pi_street_number    IN VARCHAR2,
                      pi_block_number     IN VARCHAR2,
                      pi_entrance_number  IN VARCHAR2,
                      pi_floor_number     IN VARCHAR2,
                      pi_apartment_number IN VARCHAR2,
                      pio_ErrMsg          IN OUT SrvErr 
                     ) 
RETURN VARCHAR2;
--   

END ADDRESSES;

/