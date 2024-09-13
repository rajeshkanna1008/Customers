CREATE PARTY SITE:
set serveroutput on;
DECLARE
   l_party_site_id         NUMBER;
   l_party_site_number     VARCHAR2 (200);
   l_return_status         VARCHAR2 (200);
   l_msg_count             NUMBER;
   l_msg_data              VARCHAR2 (200);
   l_party_site_rec_type   hz_party_site_v2pub.party_site_rec_type;
BEGIN
   l_party_site_rec_type.party_id := 482234;
   l_party_site_rec_type.location_id := 27673;
   l_party_site_rec_type.orig_system_reference := NULL;
   l_party_site_rec_type.orig_system := NULL;
   l_party_site_rec_type.mailstop := NULL;
   l_party_site_rec_type.identifying_address_flag := NULL;
   l_party_site_rec_type.status := 'A';
   l_party_site_rec_type.attribute_category := NULL;
   l_party_site_rec_type.attribute1 := NULL;
   l_party_site_rec_type.attribute2 := NULL;
   l_party_site_rec_type.attribute3 := NULL;
   l_party_site_rec_type.attribute4 := NULL;
   l_party_site_rec_type.attribute5 := NULL;
   l_party_site_rec_type.attribute6 := NULL;
   l_party_site_rec_type.attribute7 := NULL;
   l_party_site_rec_type.attribute8 := NULL;
   l_party_site_rec_type.attribute9 := NULL;
   l_party_site_rec_type.attribute10 := NULL;
   l_party_site_rec_type.attribute11 := NULL;
   l_party_site_rec_type.attribute12 := NULL;
   l_party_site_rec_type.attribute13 := NULL;
   l_party_site_rec_type.attribute14 := NULL;
   l_party_site_rec_type.attribute15 := NULL;
   l_party_site_rec_type.attribute16 := NULL;
   l_party_site_rec_type.attribute17 := NULL;
   l_party_site_rec_type.attribute18 := NULL;
   l_party_site_rec_type.attribute19 := NULL;
   l_party_site_rec_type.attribute20 := NULL;
   l_party_site_rec_type.language := NULL;
   l_party_site_rec_type.addressee := NULL;
   l_party_site_rec_type.created_by_module := 'BO_API';
   l_party_site_rec_type.application_id := NULL;
   l_party_site_rec_type.global_location_number := NULL;
   l_party_site_rec_type.duns_number_c := NULL;

   hz_party_site_v2pub.create_party_site (
      p_init_msg_list       => FND_API.G_FALSE,
      p_party_site_rec      => l_party_site_rec_type,
      x_party_site_id       => l_party_site_id,
      x_party_site_number   => l_party_site_number,
      x_return_status       => l_return_status,
      x_msg_count           => l_msg_count,
      x_msg_data            => l_msg_data);
   DBMS_OUTPUT.put_line ('status is ' || l_return_status);
   DBMS_OUTPUT.put_line ('Party Site ID is ' || l_party_site_id);
   dbms_output.put_line ('Party Site Number is ' || l_party_site_number);
END;
