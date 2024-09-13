SET SERVEROUTPUT ON;
DECLARE
 p_cust_account_rec     HZ_CUST_ACCOUNT_V2PUB.CUST_ACCOUNT_REC_TYPE;
 p_organization_rec     HZ_PARTY_V2PUB.ORGANIZATION_REC_TYPE;
 p_customer_profile_rec HZ_CUSTOMER_PROFILE_V2PUB.CUSTOMER_PROFILE_REC_TYPE;
 x_cust_account_id      NUMBER;
 x_account_number       VARCHAR2(2000);
 x_party_id             NUMBER;
 x_party_number         VARCHAR2(2000);
 x_profile_id           NUMBER;
 x_return_status        VARCHAR2(2000);
 x_msg_count            NUMBER;
 x_msg_data             VARCHAR2(2000);

BEGIN
 p_cust_account_rec.account_name        := 'Sumanth Org';
 p_cust_account_rec.created_by_module   := 'BO_API';
 p_organization_rec.party_rec.party_id  := 423685;

 DBMS_OUTPUT.PUT_LINE('Calling the API hz_cust_account_v2pub.create_cust_account');

 HZ_CUST_ACCOUNT_V2PUB.CREATE_CUST_ACCOUNT
             (
              p_init_msg_list       => FND_API.G_TRUE,
              p_cust_account_rec    =>p_cust_account_rec,
              p_organization_rec    =>p_organization_rec,
              p_customer_profile_rec=>p_customer_profile_rec,
              p_create_profile_amt  =>'F',
              x_cust_account_id     =>x_cust_account_id,
              x_account_number      =>x_account_number,
              x_party_id            =>x_party_id,
              x_party_number        =>x_party_number,
              x_profile_id          =>x_profile_id,
              x_return_status       =>x_return_status,
              x_msg_count           => x_msg_count,
              x_msg_data            =>x_msg_data
                    );

IF x_return_status = fnd_api.g_ret_sts_success THEN
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Creation of Cust account is Successful ');
    DBMS_OUTPUT.PUT_LINE('Output information ....');
    DBMS_OUTPUT.PUT_LINE('x_cust_account_id  : '||x_cust_account_id);
    DBMS_OUTPUT.PUT_LINE('x_account_number   : '||x_account_number);
    DBMS_OUTPUT.PUT_LINE('x_party_id         : '||x_party_id);
    DBMS_OUTPUT.PUT_LINE('x_party_number     : '||x_party_number);
ELSE
    DBMS_OUTPUT.PUT_LINE ('Creation of Cust account got failed:'||x_msg_data);
    ROLLBACK;
    FOR i IN 1 .. x_msg_count
    LOOP
      x_msg_data := oe_msg_pub.get( p_msg_index => i, p_encoded => 'F');
      dbms_output.put_line( i|| ') '|| x_msg_data);
    END LOOP;
END IF;
DBMS_OUTPUT.PUT_LINE('Completion of API');
END;
/