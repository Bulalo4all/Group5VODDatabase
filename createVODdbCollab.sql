-- Script to create VOD Database --

set echo on

drop table VOD_MOVIE_ACTOR_BRIDGE cascade constraints;
drop table VOD_ACTOR_ACTRESS cascade constraints;
drop table VOD_MOVIE_DIRECTOR_BRIDGE cascade constraints;
drop table VOD_MOVIE_ADVISORY_BRIDGE cascade constraints;
drop table VOD_MOVIE_CATEGORY_BRIDGE cascade constraints;
drop table vod_director cascade constraints;
drop table vod_advisory cascade constraints;
drop table vod_category cascade constraints;
drop table vod_rating cascade constraints;
drop table vod_rental cascade constraints;
drop table vod_movie_rental_bridge cascade constraints;
drop table vod_wishlist cascade constraints;
drop table vod_credit_card cascade constraints;
drop table vod_customers cascade constraints;
drop table vod_movie cascade constraints;


-- VOD_MOVIE TABLE CREATED WITH NULL CONSTRAINTS
CREATE TABLE VOD_MOVIE (
    movie_id NUMBER
        CONSTRAINT sys_vod_movie_pk PRIMARY KEY,
    title VARCHAR2(50)
        CONSTRAINT sys_title_NN NOT NULL,
    release_date DATE
        CONSTRAINT sys_date_NN NOT NULL,
    movied_description VARCHAR2 (1000)
        CONSTRAINT sys_movie_description_NN NOT NULL,
    rating_id NUMBER
        CONSTRAINT sys_rating_id_NN NOT NULL,
    category_id NUMBER
        CONSTRAINT sys_category_id_NN NOT NULL,
    duration NUMBER (4)
        CONSTRAINT sys_duration_NN NOT NULL
        CONSTRAINT sys_duration_check_CK CHECK (duration > 0),
    new_release NUMBER (1)
        CONSTRAINT sys_new_release_NN NOT NULL
        CONSTRAINT sys_new_release_CK CHECK (new_release in (0,1)),
    most_popular NUMBER (1)
        CONSTRAINT sys_most_popular_NN NOT NULL
        CONSTRAINT sys_most_popular_CK CHECK (most_popular in (0,1)),
    coming_soon NUMBER (1)
        CONSTRAINT sys_coming_soon_NN NOT NULL
        CONSTRAINT sys_coming_soon_CK CHECK (coming_soon in (0,1)),
    sd_price NUMBER (4, 2)
        CONSTRAINT sys_sd_price_NN NOT NULL,
    hd_price NUMBER (4, 2)
        CONSTRAINT sys_hd_price NOT NULL
);


CREATE TABLE VOD_CUSTOMERS(
    customer_id NUMBER
        CONSTRAINT sys_customer_id_PK PRIMARY KEY,
    customer_name VARCHAR2 (50)
        CONSTRAINT sys_customer_name_NN NOT NULL,
    customer_email VARCHAR2 (50)
        CONSTRAINT sys_customer_email_UK_1 UNIQUE,
    customer_phone_number NUMBER (12)
        CONSTRAINT sys_customer_phone_number_NN NOT NULL,
    customer_street_address VARCHAR2 (100)
        CONSTRAINT sys_customer_street_address_NN NOT NULL,
    customer_city VARCHAR2 (50)
        CONSTRAINT sys_customer_city_NN NOT NULL,
    customer_province CHAR(2)
        CONSTRAINT sys_customer_province_NN NOT NULL,
        CONSTRAINT sys_customer_province_CK_1 check (customer_province in ('BC', 'AB', 'SK', 'MB', 'ON', 'QB', 'NS', 'NB', 'PE', 'NL', 'NT', 'NU', 'YT')),
    customer_postal_code VARCHAR2(6)
        CONSTRAINT sys_customer_postal_code_NN NOT NULL
);

ALTER TABLE VOD_CUSTOMERS
    ADD CONSTRAINT sys_customer_email_CK_1 CHECK (customer_email NOT LIKE '.%' AND 
                                                  customer_email NOT LIKE '@%' AND
                                                  customer_email NOT LIKE '%.' AND
                                                  customer_email NOT LIKE '%@' );

-- VOD RENTAL table created with not null and some UK keys
CREATE TABLE VOD_RENTAL (
    rental_id NUMBER
        CONSTRAINT sys_rental_id_PK PRIMARY KEY,
    customer_id NUMBER
        CONSTRAINT sys_customer_id_NN NOT NULL
        CONSTRAINT sys_customer_id_FK REFERENCES vod_customers(customer_id),
    rental_date DATE,
    start_date_viewing DATE,
    expiry_date_viewing DATE,
    return_date DATE,
    price_paid NUMBER (4, 2)
        CONSTRAINT sys_price_paid_NN NOT NULL,
    customer_rating NUMBER
        CONSTRAINT sys_customer_rating_CK CHECK (customer_rating between 0 and 5), 
    credit_card_num NUMBER (16)
        CONSTRAINT sys_credit_card_num_NN NOT NULL,
    credit_card_type CHAR(2)
        CONSTRAINT sys_credit_card_type_NN NOT NULL
        CONSTRAINT sys_credit_card_type_CK CHECK (credit_card_type in ('AX', 'MC', 'VS'))
);

ALTER TABLE VOD_RENTAL 
    ADD CONSTRAINT start_date_viewing_CK CHECK (start_date_viewing >= rental_date);  
ALTER TABLE VOD_RENTAL
    ADD CONSTRAINT expiry_date_viewing_CK CHECK (expiry_date_viewing > start_date_viewing); 

CREATE TABLE VOD_ACTOR_ACTRESS(
	actor_actress_id NUMBER 
		CONSTRAINT sys_actor_id_PK PRIMARY KEY,
	first_name VARCHAR2(50) NOT NULL, 
	last_name VARCHAR2(50) NOT NULL, 
	date_of_birth DATE NOT NULL,
	actor_actress_email VARCHAR2(50)
);

ALTER TABLE VOD_ACTOR_ACTRESS
	ADD CONSTRAINT sys_actor_email_UK UNIQUE (actor_actress_email);


CREATE TABLE VOD_MOVIE_ACTOR_BRIDGE(
	actor_actress_id NUMBER,
	movie_id NUMBER,
	role_name VARCHAR2(25),
    PRIMARY KEY (actor_actress_id, movie_id) 
);

ALTER TABLE VOD_MOVIE_ACTOR_BRIDGE
	ADD CONSTRAINT sys_movie_actor_bridge_FK1 FOREIGN KEY(movie_id) REFERENCES vod_movie (movie_id);	
ALTER TABLE VOD_MOVIE_ACTOR_BRIDGE
	ADD CONSTRAINT sys_movie_actor_bridge_FK2 FOREIGN KEY(actor_actress_id) REFERENCES VOD_ACTOR_ACTRESS(actor_actress_id);

CREATE TABLE VOD_DIRECTOR(
	director_id NUMBER CONSTRAINT sys_director_id_PK PRIMARY KEY,
 	first_name VARCHAR2(50) NOT NULL,
 	last_name VARCHAR2(50)NOT NULL, 
 	date_of_birth DATE NOT NULL,
 	director_email VARCHAR2(50)
);

ALTER TABLE VOD_DIRECTOR
	ADD CONSTRAINT sys_director_email_UK UNIQUE (director_email);

CREATE TABLE VOD_MOVIE_DIRECTOR_BRIDGE(
	director_id NUMBER,
	movie_id NUMBER,
	PRIMARY KEY (director_id, movie_id)
);

ALTER TABLE VOD_MOVIE_DIRECTOR_BRIDGE
	ADD CONSTRAINT sys_movie_director_FK1 FOREIGN KEY(movie_id) REFERENCES vod_movie(movie_id);	
ALTER TABLE VOD_MOVIE_DIRECTOR_BRIDGE
	ADD CONSTRAINT sys_movie_director_FK2 FOREIGN KEY(director_id) REFERENCES vod_director (director_id);


--Wishlist bridge created with constraints
CREATE TABLE VOD_WISHLIST(
    wishlist_id NUMBER
        CONSTRAINT sys_wishlist_id_PK PRIMARY KEY,
    customer_id NUMBER
        CONSTRAINT sys_customer_wishlist_bridge_FK REFERENCES vod_customers(customer_id),
    movie_id NUMBER
        CONSTRAINT sys_movie_wishlist_bridge_FK REFERENCES vod_movie(movie_id),
    date_added DATE
        CONSTRAINT sys_date_added_NN NOT NULL
);

--VOD_CREDIT_CARD table created with constraints
CREATE TABLE VOD_CREDIT_CARD(
    customer_id NUMBER
        CONSTRAINT sys_customer_id_credit_card_PK_1 PRIMARY KEY
        CONSTRAINT sys_customer_id_credit_card_FK_1 REFERENCES vod_customers(customer_id),
    customer_credit_card_num NUMBER
        CONSTRAINT sys_customer_credit_card_num_NN NOT NULL,
    customer_credit_card_type CHAR(2)
        CONSTRAINT sys_customer_credit_card_type_NN NOT NULL
        CONSTRAINT sys_customer_credit_card_type_CK CHECK (customer_credit_card_type in ('AX', 'MC', 'VS'))
);

-- VOD_Rating table created 
CREATE TABLE VOD_RATING (
    rating_id NUMBER,
    rating_type NUMBER(1)
        CONSTRAINT sys_rating_type_CK CHECK (rating_type between 1 and 6)
);

CREATE TABLE vod_category (
    category_id NUMBER
        CONSTRAINT vod_category_PK PRIMARY KEY, -- Changed constraint name
    category_name VARCHAR2(15) 
        CONSTRAINT vod_category_name_NN NOT NULL,
    parent_category_id NUMBER 
        CONSTRAINT parent_category_FK REFERENCES vod_category(category_id)
);

-- Creating the ADVISORY table
CREATE TABLE vod_advisory (
    advisory_id NUMBER
        CONSTRAINT vod_advisory_PK PRIMARY KEY, -- Changed constraint name
    advisory_type NUMBER(2) NOT NULL
        CONSTRAINT adv_type_CK CHECK (advisory_type BETWEEN 1 AND 5),
    short_description VARCHAR2(255) NOT NULL,
    full_description VARCHAR2(1000) NOT NULL
);

CREATE TABLE VOD_MOVIE_ADVISORY_BRIDGE (
    advisory_id NUMBER
        CONSTRAINT sys_advisory_id_movie_bridge_FK REFERENCES vod_advisory(advisory_id),
    movie_id NUMBER
        CONSTRAINT sys_movie_id_advisory_bridge_FK REFERENCES vod_movie(movie_id)
    PRIMARY KEY (advisory_id, movie_id)
);

-- Creating the VOD_MOVIE_CATEGORY_BRIDGE
CREATE TABLE VOD_MOVIE_CATEGORY_BRIDGE (
    category_id NUMBER
        CONSTRAINT sys_category_id_movie_bridge_FK REFERENCES vod_category(category_id),
    movie_id NUMBER
        CONSTRAINT sys_movie_id_category_bridge_FK REFERENCES vod_movie(movie_id)
    PRIMARY KEY (category_id, movie_id)
);
