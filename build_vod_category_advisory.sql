set echo on

drop table vod_advisory cascade constraints;
drop table vod_category cascade constraints;

-- Creating the CATEGORY table
CREATE TABLE vod_category (
    category_id NUMBER,
    category_name VARCHAR2(15) CONSTRAINT vod_cat_name_nn NOT NULL,
    parent_category_id NUMBER CONSTRAINT parent_cat_fk REFERENCES vod_category(category_id),
    CONSTRAINT vod_category_pk PRIMARY KEY (category_id) -- Changed constraint name
);

-- Creating the ADVISORY table
CREATE TABLE vod_advisory (
    advisory_id NUMBER,
    advisory_type NUMBER(2) NOT NULL CONSTRAINT adv_type_ck CHECK (advisory_type BETWEEN 1 AND 5),
    short_description VARCHAR2(255) NOT NULL,
    full_description VARCHAR2(1000) NOT NULL,
    CONSTRAINT vod_advisory_pk PRIMARY KEY (advisory_id) -- Changed constraint name
);
