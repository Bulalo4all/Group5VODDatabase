set echo on

drop table VOD_MOVIE_ACTOR_BRIDGE
drop table VOD_ACTOR_ACTRESS

drop table VOD_MOVIE_DIRECTOR_BRIDGE
drop table VOD_DIRECTOR

drop table VOD_MOVIE_RENTAL_BRIDGE
drop table VOD_RENTAL


--create actor table and bridge --

CREATE TABLE VOD_ACTOR_ACTRESS(
	actor_actress_id NUMBER 
		CONSTRAINT sys_actor_id_PK PRIMARY KEY,
	first_name VARCHAR2(50) NOT NULL, 
	last_name VARCHAR2(50) NOT NULL, 
	date_of_birth DATE NOT NULL,
	actor_actress_email VARCHAR2(50)
);

--creating comp PK at table level--

CREATE TABLE VOD_MOVIE_ACTOR_BRIDGE(
	actor_address_id NUMBER,
	movie_id NUMBER,
	role_name VARCHAR2(25),
	CONSTRAINT sys_movie_actor_bridge_PK1 PRIMARY KEY (actor_actress_id),
	CONSTRAINT sys_movie_ID_bridge_PK2 PRIMARY KEY (movie_id)
);

--add constraints--

ALTER TABLE VOD_ACTOR_ACTRESS
	ADD CONSTRAINT sys_actor_email_UK UNIQUE (actor_actress_email);

ALTER TABLE VOD_MOVIE_ACTOR_BRIDGE
	ADD CONSTRAINT sys_movie_actor_FK1 FOREIGN KEY(actor_actress_id) REFERENCES actor_actress_id(VOD_ACTOR_ACTRESS);	
	ADD CONSTRAINT sys_movie_actor_FK2 FOREIGN KEY(movie_id) REFERENCES movie_ID(VOD_MOVIE);


--create director table and bridge--

CREATE TABLE VOD_DIRECTOR(
	director_id NUMBER CONSTRAINT sys_director_id_PK PRIMARY KEY,
 	first_name VARCHAR2(50) NOT NULL,
 	last_name VARCHAR2(50)NOT NULL, 
 	date_of_birth DATE NOT NULL,
 	director_email VARCHAR2(50)
);


CREATE TABLE VOD_MOVIE_DIRECTOR_BRIDGE(
	director_id NUMBER,
	movie_id NUMBER,
	CONSTRAINT sys_director_bridge_PK1 PRIMARY KEY (director_ID),
	CONSTRAINT sys_movie_id_PK2 PRIMARY KEY (movie_id)
);

--add constraints--

ALTER TABLE VOD_DIRECTOR
	ADD CONSTRAINT sys_director_email_UK UNIQUE (director_email);

ALTER TABLE VOD_MOVIE_ACTOR_BRIDGE
	ADD CONSTRAINT sys_movie_director_FK1 FOREIGN KEY(movie_id) REFERENCES movie_id(VOD_MOVIE);	
	ADD CONSTRAINT sys_movie_director_FK2 FOREIGN KEY(director_id) REFERENCES director_ID(VOD_DIRECTOR);

--create rental table and bridge (after customers parent)--

CREATE TABLE VOD_RENTAL(
	rental_id NUMBER CONSTRAINT sys_rental_id_PK PRIMARY KEY,
 	customer_id NUMBER NOT NULL,
 	rental_date DATE, 
 	start_date_viewing DATE,
 	expiry_date DATE,
	return_date DATE,
	price_paid NUMBER(4,2) NOT NULL,
	customer_rating NUMBER(1),
	credit_card_num NUMBER(16) NOT NULL,
	credit_card_type CHAR(2) NOT NULL,
);

CREATE TABLE VOD_MOVIE_RENTAL_BRIDGE(
	movie_id NUMBER,
	rental_id NUMBER,
	CONSTRAINT sys_movie_rental_PK1 PRIMARY KEY (movie_ID),
	CONSTRAINT sys_movie_id_PK2 PRIMARY KEY (rental_id)
);


--add constraints--

ALTER TABLE VOD_RENTAL
	ADD CONSTRAINT sys_rental_FK FOREIGN KEY(customer_id) REFERENCES customer_id(VOD_CUSTOMERS);
	ADD CONSTRAINT sys_start_date_CK CHECK (start_date >= rental_date);
	ADD CONSTRAINT sys_expiry_date_CK CHECK (expiry_date > start_date);
	ADD CONSTRAINT sys_customer_rating_CK CHECK (customer_rating between 0 and 5);

ALTER TABLE VOD_MOVIE_ACTOR_BRIDGE
	ADD CONSTRAINT sys_movie_rental_FK1 FOREIGN KEY(movie_id) REFERENCES movie_id(VOD_MOVIE);	
	ADD CONSTRAINT sys_movie_rental_FK2 FOREIGN KEY(rental_id) REFERENCES rental_ID(VOD_RENTAL);
