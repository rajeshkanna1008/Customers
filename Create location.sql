CREATE LOCATIONS:

set serveroutput on
DECLARE
   l_location_id     NUMBER;
   l_return_status   VARCHAR2 (200);
   l_msg_count       NUMBER;
   l_msg_data        VARCHAR2 (200);
   l_location_rec    hz_location_v2pub.location_rec_type;
BEGIN
   l_location_rec.country := 'IN';
   l_location_rec.address1 := ' CHC6+3V5';
   l_location_rec.address2 := 'Adarsh Nagar';
   l_location_rec.address3 := 'Uppal';
   l_location_rec.address4 := 'Secunderabad';
   l_location_rec.city := 'HYDERABAD';
   l_location_rec.postal_code := '500076';
   l_location_rec.state := 'Telangana';
   --l_location_rec.province := NULL;
   --l_location_rec.county := NULL;
   l_location_rec.created_by_module := 'BO_API';

   HZ_LOCATION_V2PUB.CREATE_LOCATION (p_init_msg_list   => FND_API.G_FALSE,
                                      p_location_rec    => l_location_rec,
                                      x_location_id     => l_location_id,
                                      x_return_status   => l_return_status,
                                      x_msg_count       => l_msg_count,
                                      x_msg_data        => l_msg_data);
   DBMS_OUTPUT.put_line ('Status is ' || l_return_status||' - '||l_location_id);

   FOR i IN 1 .. l_msg_count
   LOOP
      fnd_msg_pub.get (p_msg_index       => i,
                       p_encoded         => 'F',
                       p_data            => l_msg_data,
                       p_msg_index_out   => l_msg_count);
      DBMS_OUTPUT.put_line (l_msg_data);
   end loop;
END;
