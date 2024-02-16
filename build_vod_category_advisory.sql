set echo on

drop table vod_advisory cascade constraints;
drop table vod_category cascade constraints;

-- Creating the CATEGORY table
CREATE TABLE vod_category (
    category_id NUMBER,
        CONSTRAINT vod_category_PK PRIMARY KEY (category_id) -- Changed constraint name
    category_name VARCHAR2(15) 
        CONSTRAINT vod_category_name_NN NOT NULL,
    parent_category_id NUMBER 
        CONSTRAINT parent_category_FK REFERENCES vod_category(category_id),
    
);

-- Creating the ADVISORY table
CREATE TABLE vod_advisory (
    advisory_id NUMBER,
        CONSTRAINT vod_advisory_PK PRIMARY KEY (advisory_id) -- Changed constraint name
    advisory_type NUMBER(2) NOT NULL
        CONSTRAINT adv_type_CK CHECK (advisory_type BETWEEN 1 AND 5),
    short_description VARCHAR2(255) NOT NULL,
    full_description VARCHAR2(1000) NOT NULL
);

-- Creating the VOD_MOVIE_ADVISORY_BRIDGE
CREATE TABLE VOD_MOVIE_ADVISORY_BRIDGE (
    movie_advisory_bridge_id NUMBER
        CONSTRAINT sys_movie_advisory_bridge_id_PK PRIMARY KEY,
    advisory_id NUMBER
        CONSTRAINT sys_advisory_id_movie_bridge_FK REFERENCES vod_advisory(advisory_id),
    movie_id NUMBER
        CONSTRAINT sys_movie_id_advisory_bridge_FK REFERENCES vod_movie(movie_id)


);

-- Creating the VOD_MOVIE_CATEGORY_BRIDGE
CREATE TABLE VOD_MOVIE_CATEGORY_BRIDGE (
    movie_category_bridge_id NUMBER
        CONSTRAINT sys_movie_category_bridge_id_PK PRIMARY KEY,
    category_id NUMBER
        CONSTRAINT sys_category_id_movie_bridge_FK REFERENCES vod_category(category_id),
    movie_id NUMBER
        CONSTRAINT sys_movie_id_category_bridge_FK REFERENCES vod_movie(movie_id)

);
