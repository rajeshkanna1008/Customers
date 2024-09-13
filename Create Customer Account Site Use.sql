CREATE CUSTOMER ACCOUNT SITE USES:
SET SERVEROUTPUT ON;
DECLARE
p_cust_site_use_rec    HZ_CUST_ACCOUNT_SITE_V2PUB.CUST_SITE_USE_REC_TYPE;
p_customer_profile_rec HZ_CUSTOMER_PROFILE_V2PUB.CUSTOMER_PROFILE_REC_TYPE;
x_site_use_id          NUMBER;
x_return_status        VARCHAR2(2000);
x_msg_count            NUMBER;
x_msg_data             VARCHAR2(2000);

BEGIN
-- Setting the Context --
mo_global.init('AR');
fnd_global.apps_initialize ( user_id      => 1318
                            ,resp_id      => 21623
                            ,resp_appl_id => 660);
mo_global.set_policy_context('S',204);
fnd_global.set_nls_context('AMERICAN');

-- Initializing the Mandatory API parameters
p_cust_site_use_rec.cust_acct_site_id := 11415;
p_cust_site_use_rec.site_use_code     := 'SHIP_TO';
--p_cust_site_use_rec.location          := 'NEWYORK';
p_cust_site_use_rec.created_by_module := 'BO_API';  --TCA_V1_API

DBMS_OUTPUT.PUT_LINE('Calling the API hz_cust_account_site_v2pub.create_cust_site_use');

HZ_CUST_ACCOUNT_SITE_V2PUB.CREATE_CUST_SITE_USE(
                     p_init_msg_list         => FND_API.G_TRUE,
                     p_cust_site_use_rec     => p_cust_site_use_rec,
                     p_customer_profile_rec  => p_customer_profile_rec,
                     p_create_profile        => FND_API.G_TRUE,
                     p_create_profile_amt    => FND_API.G_TRUE,
                     x_site_use_id           => x_site_use_id,
                     x_return_status         => x_return_status,
                     x_msg_count             => x_msg_count,
                     x_msg_data              => x_msg_data);
                         
IF  x_return_status = fnd_api.g_ret_sts_success THEN
    COMMIT;
DBMS_OUTPUT.PUT_LINE('Creation of Customer Accnt Site use is Successful');
DBMS_OUTPUT.PUT_LINE('Output information ....');   
DBMS_OUTPUT.PUT_LINE('Site Use Id = '||x_site_use_id);
DBMS_OUTPUT.PUT_LINE('Site Use    = '||p_cust_site_use_rec.site_use_code);     
ELSE
    DBMS_OUTPUT.put_line ('Creation of Customer Accnt Site use got failed:'||x_msg_data);
    ROLLBACK;
    FOR i IN 1 .. x_msg_count
    LOOP
      x_msg_data := fnd_msg_pub.get( p_msg_index => i, p_encoded => 'F');
      dbms_output.put_line( i|| ') '|| x_msg_data);
    END LOOP;
END IF;
DBMS_OUTPUT.PUT_LINE('Completion of API');
END;
