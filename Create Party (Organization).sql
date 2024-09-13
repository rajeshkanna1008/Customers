set serveroutput on
DECLARE
      p_organization_rec HZ_PARTY_V2PUB.ORGANIZATION_REC_TYPE;
      l_return_status    VARCHAR2(2000); 
      l_msg_count        NUMBER;
      l_msg_data         VARCHAR2(2000);
      l_party_id         NUMBER;
      l_party_number     VARCHAR2(2000);
      l_profile_id       NUMBER;

      BEGIN
      p_organization_rec.organization_name := 'X1 Org';
      --p_organization_rec.created_by_module := 'BO_API'; --TCA_V1_API
      DBMS_OUTPUT.PUT_LINE('Calling the API hz_party_v2pub.create_organization');
      hz_party_v2pub.create_organization
             (
              p_init_msg_list    => FND_API.G_TRUE,
              p_organization_rec => p_organization_rec,
              x_return_status    => l_return_status,
              x_msg_count        => l_msg_count,
              x_msg_data         => l_msg_data,
              x_party_id         => l_party_id,
              x_party_number     => l_party_number,
              x_profile_id       => l_profile_id
                   );

      IF l_return_status = fnd_api.g_ret_sts_success THEN
        COMMIT;
      DBMS_OUTPUT.PUT_LINE('Creation of Organization is Successful ');
      DBMS_OUTPUT.PUT_LINE('Output information ....');
      DBMS_OUTPUT.PUT_LINE('Party Id         ='|| l_party_id);
      DBMS_OUTPUT.PUT_LINE('Party_Number     ='|| l_party_number);
      DBMS_OUTPUT.PUT_LINE('Profile Id       ='|| l_profile_id); 
      
      ELSE
      DBMS_OUTPUT.put_line ('Creation of Organization failed:'||l_msg_data);
      ROLLBACK;
      FOR i IN 1 .. l_msg_count
      LOOP
      l_msg_data := oe_msg_pub.get( p_msg_index => i, p_encoded => 'F');
      dbms_output.put_line( i|| ') '|| l_msg_data);
      END LOOP;
      END IF;
      DBMS_OUTPUT.PUT_LINE('Completion of API');
      END;
