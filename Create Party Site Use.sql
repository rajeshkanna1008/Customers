CREATE PARTY_SITE_USES:
SET SERVEROUTPUT ON;

DECLARE
p_party_site_use_rec HZ_PARTY_SITE_V2PUB.PARTY_SITE_USE_REC_TYPE;
x_party_site_use_id  NUMBER;
x_return_status      VARCHAR2(2000);
x_msg_count          NUMBER;
x_msg_data           VARCHAR2(2000);

BEGIN

-- Initializing the Mandatory API parameters
p_party_site_use_rec.site_use_type     := upper('BILL_TO');
p_party_site_use_rec.party_site_id     := 260918;
p_party_site_use_rec.created_by_module := 'BO_API';

DBMS_OUTPUT.PUT_LINE('Calling the API hz_party_site_v2pub.create_party_site_use');

HZ_PARTY_SITE_V2PUB.CREATE_PARTY_SITE_USE
                   (
                    p_init_msg_list      => FND_API.G_TRUE,
                    p_party_site_use_rec => p_party_site_use_rec,
                    x_party_site_use_id  => x_party_site_use_id,
                    x_return_status      => x_return_status,
                    x_msg_count          => x_msg_count,
                    x_msg_data           => x_msg_data
                   );
                          
IF x_return_status = fnd_api.g_ret_sts_success THEN
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Creation of Party Site use is Successful ');
    DBMS_OUTPUT.PUT_LINE('Output information ....');
    DBMS_OUTPUT.PUT_LINE('Party Site Id = '||p_party_site_use_rec.party_site_id);
      DBMS_OUTPUT.PUT_LINE('Site Use Id   = '||x_party_site_use_id);
ELSE
    DBMS_OUTPUT.put_line ('Creation of Party Site use got failed:'||x_msg_data);
    ROLLBACK;
    FOR i IN 1 .. x_msg_count
    LOOP
      x_msg_data := fnd_msg_pub.get( p_msg_index => i, p_encoded => 'F');
      dbms_output.put_line( i|| ') '|| x_msg_data);
    END LOOP;
END IF;
DBMS_OUTPUT.PUT_LINE('Completion of API');
end;
