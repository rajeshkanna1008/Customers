CREATE ACCOUNT SITE:
SET SERVEROUTPUT ON;
DECLARE
p_cust_acct_site_rec hz_cust_account_site_v2pub.cust_acct_site_rec_type;
x_return_status VARCHAR2(2000);
x_msg_count NUMBER;
x_msg_data VARCHAR2(2000);
x_cust_acct_site_id NUMBER;
BEGIN
-- Setting the Context --
mo_global.init('AR');
fnd_global.apps_initialize ( user_id      => 1318
                            ,resp_id      => 21623
                            ,resp_appl_id => 660);
mo_global.set_policy_context('S',204);
fnd_global.set_nls_context('AMERICAN');
-- Initializing the Mandatory API parameters
p_cust_acct_site_rec.cust_account_id   := 124734;
p_cust_acct_site_rec.party_site_id     := 236632;
p_cust_acct_site_rec.created_by_module := 'BO_API';

DBMS_OUTPUT.PUT_LINE('Calling the API hz_cust_account_site_v2pub.create_cust_acct_site');
HZ_CUST_ACCOUNT_SITE_V2PUB.CREATE_CUST_ACCT_SITE
                   (
                     p_init_msg_list         => FND_API.G_TRUE,
                     p_cust_acct_site_rec    => p_cust_acct_site_rec,
                     x_cust_acct_site_id     => x_cust_acct_site_id,
                     x_return_status         => x_return_status,
                     x_msg_count             => x_msg_count,
                     x_msg_data              => x_msg_data
                   );
IF  x_return_status = fnd_api.g_ret_sts_success THEN
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Creation of Customer Account Site is Successful ');
    DBMS_OUTPUT.PUT_LINE('Output information ....');    
    DBMS_OUTPUT.PUT_LINE('Customer Account Site Id is = '||x_cust_acct_site_id);   
ELSE
    DBMS_OUTPUT.put_line ('Creation of Customer Account Site got failed:'||x_msg_data);
    ROLLBACK;
    FOR i IN 1 .. x_msg_count
    LOOP
      x_msg_data := fnd_msg_pub.get( p_msg_index => i, p_encoded => 'F');
      dbms_output.put_line( i|| ') '|| x_msg_data);
    END LOOP;
END IF;
DBMS_OUTPUT.PUT_LINE('Completion of API');
END;
/
