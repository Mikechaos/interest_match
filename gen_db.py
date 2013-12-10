import os


users_query = "insert into users(first_name,last_name,email,phone,skype,gender,lat,lon,created_at,updated_at,encrypted_password,reset_password_token,reset_password_sent_at,remember_created_at,sign_in_count,current_sign_in_at,last_sign_in_at,current_sign_in_ip,last_sign_in_ip,provider,uid,name,age) values('first','last','me@gmail.com','1234123233','xyz',1,-30.0,110.0,now(),now(),'',NULL,NULL,NULL,0,now(),now(),'4.5.6.7','1.2.3.4','prov','123123213213','first_last',23);"

int_query = "insert into interests(name,description,lat,lon,user_id,created_at,updated_at) values('peets coffee','lets have coffee',12.3,51.3,1,now(),now());"





