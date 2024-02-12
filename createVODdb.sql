-- Script to create VOD Database --

set echo on

drop table vod_movie cascade constraints;
drop table vod_rating cascade constraints;

-- TABLE CREATED WITH NULL CONSTRAINTS
CREATE TABLE VOD_MOVIE (
    movie_id NUMBER,
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
        CONSTRAINT sys_duration_NN NOT NULL,
    new_release NUMBER (1)
        CONSTRAINT sys_new_release_NN NOT NULL,
    most_popular NUMBER (1)
        CONSTRAINT sys_most_popular_NN NOT NULL,
    coming_soon NUMBER (1)
        CONSTRAINT sys_coming_soon_NN NOT NULL,
    sd_price NUMBER (4, 2),
        CONSTRAINT sys_sd_price_NN NOT NULL,
    hd_price NUMBER (4, 2)
        CONSTRAINT sys_hd_price NOT NULL
);

-- ADDING UNIQUE KEY RESTRATINTS USING ALTER
ALTER TABLE VOD_MOVIE
    ADD CONSTRAINT sys_vod_movie_pk PRIMARY KEY (movie_id);

ALTER TABLE VOD_MOVIE
    ADD CONSTRAINT sys_duration_check_CK CHECK (duration > 0);

ALTER TABLE VOD_MOVIE
    ADD CONSTRAINT sys_new_release_CK CHECK (new_release in (0,1));

ALTER TABLE VOD_MOVIE
    ADD CONSTRAINT sys_most_popular_CK CHECK (most_popular in (0,1));

ALTER TABLE VOD_MOVIE
    ADD CONSTRAINT sys_coming_soon_CK CHECK (coming_soon in (0,1));

CREATE TABLE VOD_RATING (
    rating_id NUMBER,
    rating_type VARCHAR2(5)
);

