CREATE OR REPLACE PACKAGE BODY INSIS_CUST.ADDRESSES
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
RETURN VARCHAR2
IS

  /*CURSOR Cquarter_type IS
    SELECT a.name quarter_name, b.name
     FROM h_address_quarter a, h_quarter_type b
    WHERE b.id = a.quarter_type
       a.city_id = pi_city_code
      AND a.id = pi_quarter_id;*/
  --
  CURSOR Cquarter_type IS
    SELECT a.name quarter_name
     FROM h_address_quarter a
    WHERE a.city_id = pi_city_code
      AND a.id = pi_quarter_id;
  --
  CURSOR Cstreet IS
    SELECT name
     FROM h_street_address
    WHERE city_id = pi_city_code
      AND NVL(quarter_id, '-1') = NVL(pi_quarter_id, NVL(quarter_id, '-1'))
      AND NVL(region_id, '-1') = NVL(pi_state_region, '-1')
      AND NVL(state_id, '-1') = NVL(pi_country_state, '-1')
      AND id = pi_street_id
      AND country_id = pi_country_code;
  --
  CURSOR CstreetType IS
    SELECT b.name
    FROM h_street_address a, h_street_type b
    WHERE b.id = a.street_type
     AND NVL(a.city_id, '-1') = NVL(pi_city_code, '-1')
     AND NVL(a.region_id, '-1') = NVL(pi_state_region, '-1')
     AND NVL(a.state_id, '-1') = NVL(pi_country_state, '-1')
     AND a.country_id = pi_country_code
     AND a.id = pi_street_id;
  --
  l_address_rule   VARCHAR2(100);
  l_quarter        VARCHAR2(500);
  l_quarter_name   VARCHAR2(500);
  l_street_name    VARCHAR2(500);
  l_label          VARCHAR2(100);
  l_address        VARCHAR2(4000);
  --
  l_SrvErrMsg      srverrmsg;

BEGIN
    -- Get quarter name
    IF pi_quarter_id IS NOT NULL
    THEN
       OPEN Cquarter_type;
       FETCH Cquarter_type INTO l_quarter_name;--, l_quarter;
       CLOSE Cquarter_type;
    END IF;

    -- Get street name
    IF pi_street_id IS NOT NULL
    THEN
        OPEN Cstreet;
        FETCH Cstreet INTO l_street_name;
        CLOSE Cstreet;
    END IF;
    --
    l_quarter_name := NVL(l_quarter_name, pi_quarter_name);
    l_street_name  := NVL(l_street_name, pi_street_name);
    --
    l_address := pi_post_code;
    --
    IF pi_quarter_name IS NOT NULL
    THEN
       --l_address := l_address || ' ' || l_quarter || l_quarter_name;
       l_address := l_address || ' ' || l_quarter_name;
    END IF;
    --
    IF l_address IS NOT NULL
    THEN
       l_address := l_address || ' ';
    END IF;
    --
     IF pi_street_name IS NOT NULL
     THEN
         OPEN CstreetType;
         FETCH CstreetType INTO l_label;
         CLOSE CstreetType;
         --
         srv_error.SetErrorMsg ( l_SrvErrMsg, NULL, 'ADDRESS.STREET' ) ;
         l_label := NVL(l_label, l_SrvErrMsg.ERRMESSAGE);
         l_address := l_address || l_label ||' '|| l_street_name;
     END IF;
     --
     IF pi_street_number IS NOT NULL
     THEN
         srv_error.SetErrorMsg ( l_SrvErrMsg, NULL, 'ADDRESS.STREET_NUM' ) ;
         l_label := l_SrvErrMsg.ERRMESSAGE;
         l_address := l_address || ' ' || l_label || ' ' ||pi_street_number;
     END IF;
     --
     IF pi_block_number IS NOT NULL
     THEN
         srv_error.SetErrorMsg ( l_SrvErrMsg, NULL, 'ADDRESS.BLOCK' ) ;
         l_label := l_SrvErrMsg.ERRMESSAGE;
         l_address := l_address || ' ' || l_label || ' '|| pi_block_number;
         --
         IF pi_entrance_number IS NOT NULL
         THEN
             srv_error.SetErrorMsg ( l_SrvErrMsg, NULL, 'ADDRESS.ENTRANCE' ) ;
             l_label := l_SrvErrMsg.ERRMESSAGE;
             l_address := l_address || ' ' || l_label || ' ' || pi_entrance_number;
         END IF;
         --
         IF pi_floor_number IS NOT NULL
         THEN
             srv_error.SetErrorMsg ( l_SrvErrMsg, NULL, 'ADDRESS.FLOOR' ) ;
             l_label := l_SrvErrMsg.ERRMESSAGE;
             l_address := l_address || ' ' || l_label || ' ' || pi_floor_number;
         END IF;
         --
         IF pi_apartment_number IS NOT NULL
         THEN
             srv_error.SetErrorMsg ( l_SrvErrMsg, NULL, 'ADDRESS.APARTMENT' ) ;
             l_label := l_SrvErrMsg.ERRMESSAGE;
             l_address := l_address || ' ' || l_label || ' ' || pi_apartment_number;
         END IF;
     END IF;
     --
     RETURN l_address;

EXCEPTION WHEN OTHERS THEN
    srv_error.SetSysErrorMsg( l_SrvErrMsg, 'addresses.Set_Address', SQLERRM );
    srv_error.SetErrorMsg( l_SrvErrMsg, pio_ErrMsg );
    RETURN NULL;
END Set_Address;
--
END ADDRESSES;
/