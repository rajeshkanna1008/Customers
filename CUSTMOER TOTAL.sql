CREATE OR REPLACE
PACKAGE XXX_CUSTOMERS
AS
  PROCEDURE MAIN(
      ERRBUF OUT VARCHAR2 ,
      RETCODE OUT VARCHAR2 ,
      p_country           VARCHAR2 ,
      p_address1          VARCHAR2 ,
      p_city              VARCHAR2 ,
      p_postal_code       VARCHAR2 ,
      p_state             VARCHAR2 ,
      L_ORGANIZATION_NAME VARCHAR2 ,
      L_SITE_USE_TYPE     VARCHAR2 ,
      L_ACCOUNT_NAME      VARCHAR2);
END XXX_CUSTOMERS;
/
create or replace 
package body xxx_customers 
AS

PROCEDURE LOG(P_MESSAGE VARCHAR2)
AS
BEGIN
	FND_FILE.PUT_LINE(FND_FILE.LOG,P_MESSAGE);
	FND_FILE.PUT_LINE(FND_FILE.OUTPUT,P_MESSAGE);
	DBMS_OUTPUT.put_line(P_MESSAGE);
	
END;


PROCEDURE XXX_CREATE_ORGANIZATION(P_ORGANIZATION_NAME  VARCHAR2
                                 ,P_LOCATION_ID 	   Number
                                 ,P_party_id       OUT NUMBER)
AS
    p_organization_rec    HZ_PARTY_V2PUB.ORGANIZATION_REC_TYPE;
    l_return_status       VARCHAR2(2000); 
    l_msg_count           NUMBER;
    l_msg_data            VARCHAR2(2000);
    l_party_id            NUMBER;
    l_party_number        VARCHAR2(2000);
    l_profile_id          number;
	L_CNT                 NUMBER ; 
	L_ORGANIZATION_NAME   VARCHAR2(2000);
	l_party_site_id       NUMBER;
	l_party_site_number   VARCHAR2 (200);
	
	

	
 /*   l_return_status         VARCHAR2 (200);
   l_msg_count             NUMBER;
   l_msg_data              VARCHAR2 (200); */
   
    l_party_site_rec_type   hz_party_site_v2pub.party_site_rec_type;

      BEGIN
	  
	  L_ORGANIZATION_NAME := P_ORGANIZATION_NAME;
	  
	  IF L_ORGANIZATION_NAME IS NOT NULL
	  THEN
	  BEGIN
	  SELECT 1 INTO L_CNT FROM HZ_PARTIES WHERE PARTY_NAME = L_ORGANIZATION_NAME;
	  
	  EXCEPTION WHEN no_data_found THEN null;
	  l_cnt := 0;
    when others then 
	  LOG(SQLERRM);
	  LOG('EXCEPTION RAISED ORGANIZATION NAME : '||SQLERRM);
	  END;
	  END IF;
	  IF  L_CNT = 0 THEN 
      p_organization_rec.organization_name := L_ORGANIZATION_NAME;
      p_organization_rec.created_by_module := 'TCA_V1_API';
      LOG('Calling the API hz_party_v2pub.create_organization');
      HZ_PARTY_V2PUB.CREATE_ORGANIZATION( p_init_msg_list    => FND_API.G_TRUE,
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
      LOG('Creation of Organization is Successful ');
      LOG('Output information ....');
      LOG('Party Id         ='|| l_party_id);
      LOG('Party_Number     ='|| l_party_number);
      log('Profile Id       ='|| l_profile_id); 
      p_party_id := l_party_id;
      ELSE
      DBMS_OUTPUT.put_line ('Creation of Organization failed:'||l_msg_data);
	  LOG('Creation of Organization failed:'||l_msg_data);
      ROLLBACK;
      FOR i IN 1 .. l_msg_count
      LOOP
      l_msg_data := oe_msg_pub.get( p_msg_index => i, p_encoded => 'F');
      LOG( i|| ') '|| l_msg_data);
      END LOOP;
      END IF;
	  
	  else 
	  LOG('Party name alreadey existed '||L_ORGANIZATION_NAME);
	  END IF;
	  
	  EXCEPTION WHEN OTHERS THEN
	  LOG('EXCEPTION '||SQLERRM);
	  
END XXX_CREATE_ORGANIZATION;

procedure xxx_create_party_site(P_party_id          number
                               ,P_LOCATION_ID       Number
                               ,P_party_site_id OUT NUMBER)
AS

   l_party_site_id         NUMBER;
   l_party_site_number     VARCHAR2 (200);
   l_return_status         VARCHAR2 (200);
   l_msg_count             NUMBER;
   l_msg_data              VARCHAR2 (200);
   l_party_site_rec_type   hz_party_site_v2pub.party_site_rec_type;
	  --to create Party site
begin
	log(p_party_id ||' / '||P_LOCATION_ID || P_party_site_id);
	IF P_party_id IS NOT NULL AND P_LOCATION_ID IS NOT NULL 
	THEN
	
	l_party_site_rec_type.party_id := p_party_id;
    l_party_site_rec_type.location_id := P_LOCATION_ID;
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
    l_party_site_rec_type.created_by_module := 'TCA_V1_API';
    l_party_site_rec_type.application_id := NULL;
    l_party_site_rec_type.global_location_number := NULL;
    l_party_site_rec_type.duns_number_c := NULL;
    
	 LOG('Calling the API  hz_party_site_v2pub.create_party_site');
    hz_party_site_v2pub.create_party_site (p_init_msg_list       => FND_API.G_FALSE,
                                           p_party_site_rec      => l_party_site_rec_type,
                                           x_party_site_id       => l_party_site_id,
                                           x_party_site_number   => l_party_site_number,
                                           x_return_status       => l_return_status,
                                           x_msg_count           => l_msg_count,
                                           x_msg_data            => l_msg_data);
    P_party_site_id := l_party_site_id;
    LOG('status is ' || l_return_status);
    LOG('Party Site ID is ' || l_party_site_id);
    LOG('Party Site Number is ' || l_party_site_number);
	
	ELSE 
	LOG(SQLERRM);
	END IF;

EXCEPTION WHEN OTHERS 
THEN
LOG(SQLERRM);

END XXX_CREATE_PARTY_SITE;
      
PROCEDURE CREATE_PARTY_SITE_USE(P_SITE_USE_TYPE       VARCHAR2
                               ,l_party_site_id       NUMBER)
AS
p_party_site_use_rec HZ_PARTY_SITE_V2PUB.PARTY_SITE_USE_REC_TYPE;
x_party_site_use_id  NUMBER;
x_return_status      VARCHAR2(2000);
x_msg_count          NUMBER;
x_msg_data           VARCHAR2(2000);

BEGIN

IF P_SITE_USE_TYPE IS NOT NULL AND l_party_site_id IS NOT NULL 
THEN

-- Initializing the Mandatory API parameters
p_party_site_use_rec.site_use_type     := upper(P_SITE_USE_TYPE);
p_party_site_use_rec.party_site_id     := l_party_site_id;
p_party_site_use_rec.created_by_module := 'TCA_V1_API';

LOG('Calling the API hz_party_site_v2pub.create_party_site_use');

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
    LOG('Creation of Party Site use is Successful ');
    LOG('Output information ....');
    LOG('Party Site Id = '||p_party_site_use_rec.party_site_id);
    LOG('Site Use Id   = '||x_party_site_use_id);
ELSE
    LOG('Creation of Party Site use got failed:'||x_msg_data);
    ROLLBACK;
    FOR i IN 1 .. x_msg_count
    LOOP
      x_msg_data := fnd_msg_pub.get( p_msg_index => i, p_encoded => 'F');
      LOG( i|| ') '|| x_msg_data);
    END LOOP;
END IF;
LOG('Completion of API');

END IF;
EXCEPTION WHEN OTHERS 
THEN
LOG(SQLERRM||SQLCODE);

END CREATE_PARTY_SITE_USE; 


PROCEDURE CREATE_CUST_ACCT (P_ACCOUNT_NAME 		VARCHAR2,
							P_PARTY_ID			NUMBER,
							X_ACCOUNT_ID 	OUT	NUMBER
							)
AS

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
 p_cust_account_rec.account_name      := P_ACCOUNT_NAME;
 p_cust_account_rec.created_by_module := 'TCA_V1_API';
 p_organization_rec.party_rec.party_id  := P_PARTY_ID;

 LOG('Calling the API hz_cust_account_v2pub.create_cust_account');

 HZ_CUST_ACCOUNT_V2PUB.CREATE_CUST_ACCOUNT
             (
              p_init_msg_list       => FND_API.G_TRUE,
              p_cust_account_rec    =>p_cust_account_rec,
              p_organization_rec    =>p_organization_rec,
              p_customer_profile_rec=>p_customer_profile_rec,
              p_create_profile_amt  =>FND_API.G_FALSE,
              x_cust_account_id     =>x_cust_account_id,
              x_account_number      =>x_account_number,
              x_party_id            =>x_party_id,
              x_party_number        =>x_party_number,
              x_profile_id          =>x_profile_id,
              x_return_status       =>x_return_status,
              x_msg_count           =>x_msg_count,
              x_msg_data            =>x_msg_data
                    );

IF x_return_status = fnd_api.g_ret_sts_success THEN
    COMMIT;
    LOG('Creation of Party and customer account is Successful ');
    LOG('Output information ....');
    LOG('x_cust_account_id  : '||x_cust_account_id);
    LOG('x_account_number   : '||x_account_number);
    LOG('x_party_id         : '||x_party_id);
    LOG('x_party_number     : '||x_party_number);
    --LOG('x_profile_id       : '||x_profile_id);
	X_ACCOUNT_ID := x_cust_account_id;
ELSE
    LOG ('Creation of Party and customer account failed:'||x_msg_data);
    ROLLBACK;
    FOR i IN 1 .. x_msg_count
    LOOP
      x_msg_data := oe_msg_pub.get( p_msg_index => i, p_encoded => 'F');
      LOG( i|| ') '|| x_msg_data);
    END LOOP;
END IF;
LOG('Completion of API');
END CREATE_CUST_ACCT;

PROCEDURE CREATE_CUST_ACCT_SITE(P_CUST_ACCT_ID 		NUMBER,
								P_PARTY_SITE_ID 	NUMBER,
								P_CUST_ACCT_SITE_ID OUT NUMBER)
AS
p_cust_acct_site_rec hz_cust_account_site_v2pub.cust_acct_site_rec_type;
x_return_status VARCHAR2(2000);
x_msg_count NUMBER;
x_msg_data VARCHAR2(2000);
x_cust_acct_site_id NUMBER;
BEGIN
mo_global.init('AR');
fnd_global.apps_initialize ( user_id      => 1318
                            ,resp_id      => 21623
                            ,resp_appl_id => 660);
mo_global.set_policy_context('S',204);
fnd_global.set_nls_context('AMERICAN');
-- Initializing the Mandatory API parameters
p_cust_acct_site_rec.cust_account_id   := P_CUST_ACCT_ID;
p_cust_acct_site_rec.party_site_id     := P_PARTY_SITE_ID;
p_cust_acct_site_rec.created_by_module := 'TCA_V1_API';

LOG('Calling the API hz_cust_account_site_v2pub.create_cust_acct_site');

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
    LOG('Creation of Customer Account Site is Successful ');
    LOG('Output information ....');    
    LOG('Customer Account Site Id is = '||x_cust_acct_site_id); 
	P_CUST_ACCT_SITE_ID := x_cust_acct_site_id;
ELSE
    LOG('Creation of Customer Account Site got failed:'||x_msg_data);
    ROLLBACK;
    FOR i IN 1 .. x_msg_count
    LOOP
      x_msg_data := fnd_msg_pub.get( p_msg_index => i, p_encoded => 'F');
      LOG( i|| ') '|| x_msg_data);
    END LOOP;
end if;
LOG('Completion of API');
END CREATE_CUST_ACCT_SITE;

PROCEDURE CREATE_CUST_ACCT_SITE_USE(P_CUST_ACCT_SITE_ID  NUMBER,
									P_CUST_SITE_USE 	VARCHAR2,
									P_CUST_SITE_USE_ID OUT NUMBER)
AS
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
p_cust_site_use_rec.cust_acct_site_id := P_CUST_ACCT_SITE_ID;
p_cust_site_use_rec.site_use_code     := P_CUST_SITE_USE;
--p_cust_site_use_rec.location          := P_CUST_LOCATION;
p_cust_site_use_rec.created_by_module := 'TCA_V1_API';

LOG('Calling the API hz_cust_account_site_v2pub.create_cust_site_use');

HZ_CUST_ACCOUNT_SITE_V2PUB.CREATE_CUST_SITE_USE
                   (
                     p_init_msg_list         => FND_API.G_TRUE,
                     p_cust_site_use_rec     => p_cust_site_use_rec,
                     p_customer_profile_rec  => p_customer_profile_rec,
                     p_create_profile        => FND_API.G_TRUE,
                     p_create_profile_amt    => FND_API.G_TRUE,
                     x_site_use_id           => x_site_use_id,
                     x_return_status         => x_return_status,
                     x_msg_count             => x_msg_count,
                     x_msg_data              => x_msg_data
                          );
                         
IF  x_return_status = fnd_api.g_ret_sts_success THEN
    COMMIT;
    LOG('Creation of Customer Accnt Site use is Successful ');
    LOG('Output information ....');   
    LOG('Site Use Id = '||x_site_use_id);
    LOG('Site Use    = '||p_cust_site_use_rec.site_use_code);
    P_CUST_SITE_USE_ID := x_site_use_id;
ELSE
    LOG ('Creation of Customer Accnt Site use got failed:'||x_msg_data);
    ROLLBACK;
    FOR i IN 1 .. x_msg_count
    LOOP
      x_msg_data := fnd_msg_pub.get( p_msg_index => i, p_encoded => 'F');
      LOG( i|| ') '|| x_msg_data);
    END LOOP;
END IF;
LOG('Completion of API');
END CREATE_CUST_ACCT_SITE_USE;
								    
PROCEDURE MAIN(ERRBUF      OUT      VARCHAR2
              ,RETCODE     OUT      VARCHAR2
              ,p_country            VARCHAR2
              ,p_address1           VARCHAR2
			  ,p_city               VARCHAR2
			  ,p_postal_code        VARCHAR2
			  ,p_state              VARCHAR2
			  ,L_ORGANIZATION_NAME  VARCHAR2
			  ,L_SITE_USE_TYPE      VARCHAR2
			  ,L_ACCOUNT_NAME 		VARCHAR2)
AS

   l_location_id     NUMBER;
   l_return_status   VARCHAR2 (200);
   l_msg_count       NUMBER;
   l_msg_data        VARCHAR2 (200);
   l_location_rec    hz_location_v2pub.location_rec_type;
   L_party_id        NUMBER;
   p_party_site_id   number;
   V_ACCOUNT_ID 	 NUMBER;
   L1_party_id      NUMBER;
   V_CUST_ACCT_SITE_ID NUMBER;
   V_CUST_SITE_USE_ID  NUMBER;
   
BEGIN

   IF p_country is not null and p_address1 is not null and p_city is not null and p_postal_code is not null and p_state is not null
   THEN
   
   l_location_rec.country := p_country;
   l_location_rec.address1 := p_address1;
   l_location_rec.city := p_city;
   l_location_rec.postal_code := p_postal_code;
   l_location_rec.state := p_state;
   --l_location_rec.province := NULL;
   l_location_rec.created_by_module := 'TCA_V1_API';
   
   log('Calling the API HZ_LOCATION_V2PUB.CREATE_LOCATION');

   HZ_LOCATION_V2PUB.CREATE_LOCATION (p_init_msg_list   => FND_API.G_FALSE,
                                      p_location_rec    => l_location_rec,
                                      x_location_id     => l_location_id,
                                      x_return_status   => l_return_status,
                                      x_msg_count       => l_msg_count,
                                      x_msg_data        => l_msg_data);
   log('Status is ' || l_return_status||' - '||l_location_id);

   FOR i IN 1 .. l_msg_count
   LOOP
      fnd_msg_pub.get (p_msg_index       => i,
                       p_encoded         => 'F',
                       p_data            => l_msg_data,
                       p_msg_index_out   => l_msg_count);
	  log(l_msg_data);
   END LOOP;
   END IF;

XXX_CREATE_ORGANIZATION(P_ORGANIZATION_NAME => L_ORGANIZATION_NAME
                       ,P_LOCATION_ID => l_location_id
					   ,p_party_id => l_party_id);

L1_party_id := l_party_id;
xxx_create_party_site(P_party_id   => L1_party_id
                     ,p_location_id => l_location_id
				     ,P_party_site_id => P_party_site_id);
					 
CREATE_PARTY_SITE_USE(P_SITE_USE_TYPE    => L_SITE_USE_TYPE
                     ,l_party_site_id    => P_party_site_id);

					 
CREATE_CUST_ACCT(P_ACCOUNT_NAME => L_ACCOUNT_NAME
                ,P_PARTY_ID => L_party_id
				,X_ACCOUNT_ID => V_ACCOUNT_ID);
LOG(V_ACCOUNT_ID);
LOG(P_party_site_id);
				
CREATE_CUST_ACCT_SITE(P_CUST_ACCT_ID => V_ACCOUNT_ID,
					  P_PARTY_SITE_ID=>  P_party_site_id,
					  P_CUST_ACCT_SITE_ID => V_CUST_ACCT_SITE_ID);

LOG(V_CUST_ACCT_SITE_ID);

CREATE_CUST_ACCT_SITE_USE(P_CUST_ACCT_SITE_ID  	=> V_CUST_ACCT_SITE_ID,
						  P_CUST_SITE_USE 		=> L_SITE_USE_TYPE,
						  P_CUST_SITE_USE_ID 	=> V_CUST_SITE_USE_ID);


EXCEPTION WHEN OTHERS 
then 
LOG(SQLERRM||SQLCODE);					 

end main;

END XXX_CUSTOMERS;


/

DECLARE
  ERRBUF VARCHAR2(200);
  RETCODE VARCHAR2(200);
  P_COUNTRY VARCHAR2(200);
  P_ADDRESS1 VARCHAR2(200);
  P_CITY VARCHAR2(200);
  P_POSTAL_CODE VARCHAR2(200);
  P_STATE VARCHAR2(200);
  L_ORGANIZATION_NAME VARCHAR2(200);
  L_SITE_USE_TYPE VARCHAR2(200);
  L_ACCOUNT_NAME VARCHAR2(200);
begin
  p_country := 'US';
  p_address1 := '100 wiggins rd';
  P_CITY := 'Indianola';
  p_postal_code := 38751;
  p_state := 'MS';
  l_organization_name := 'Test_cust_23';
  l_site_use_type := 'BILL_TO';
  L_ACCOUNT_NAME := 'CUST_ACCT_12';

  XXX_CUSTOMERS.MAIN(
    ERRBUF => ERRBUF,
    RETCODE => RETCODE,
    P_COUNTRY => P_COUNTRY,
    P_ADDRESS1 => P_ADDRESS1,
    P_CITY => P_CITY,
    P_POSTAL_CODE => P_POSTAL_CODE,
    P_STATE => P_STATE,
    L_ORGANIZATION_NAME => L_ORGANIZATION_NAME,
    L_SITE_USE_TYPE => L_SITE_USE_TYPE,
    L_ACCOUNT_NAME => L_ACCOUNT_NAME
  );

end;

/

Calling the API HZ_LOCATION_V2PUB.CREATE_LOCATION
Status is S - 26842
Calling the API hz_party_v2pub.create_organization
Creation of Organization is Successful 
Output information ....
Party Id         =423704
Party_Number     =57901
Profile Id       =184448
423704 / 26842
Calling the API  hz_party_site_v2pub.create_party_site
status is S
Party Site ID is 234645
Party Site Number is 24834
Calling the API hz_party_site_v2pub.create_party_site_use
Creation of Party Site use is Successful 
Output information ....
Party Site Id = 234645
Site Use Id   = 244064
Completion of API
Calling the API hz_cust_account_v2pub.create_cust_account
Creation of Party and customer account is Successful 
Output information ....
x_cust_account_id  : 123745
x_account_number   : 5931
x_party_id         : 423704
x_party_number     : 57901
Completion of API
123745
234645
Calling the API hz_cust_account_site_v2pub.create_cust_acct_site
Creation of Customer Account Site is Successful 
Output information ....
Customer Account Site Id is = 11399
Completion of API
11399
Calling the API hz_cust_account_site_v2pub.create_cust_site_use
Creation of Customer Accnt Site use is Successful 
Output information ....
Site Use Id = 13971
Site Use    = BILL_TO
Completion of API
