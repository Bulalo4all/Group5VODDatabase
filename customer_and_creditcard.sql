set echo on

--remove the table in case it's already there--
drop table CREDIT_CARD cascade constraints;
drop table CUSTOMERS cascade constraints;


--create customer table--

CREATE TABLE CUSTOMERS 
(customer_id NUMBER,
c_name VARCHAR2(50), 
c_email VARCHAR2(50), 
c_phone_number NUMBER(12), 
c_street_address VARCHAR2(100), 
city VARCHAR2(50), 
province CHAR(2), 
postal_code VARCHAR2(6));

--add constraints--

ALTER TABLE CUSTOMERS
    ADD CONSTRAINT sys_customer_pk PRIMARY KEY (customer_id);
ALTER TABLE CUSTOMERS
    MODIFY (c_name NOT NULL);
ALTER TABLE CUSTOMERS
    ADD CONSTRAINT sys_customer_email_UK UNIQUE (c_email);
ALTER TABLE CUSTOMERS
    MODIFY (c_email NOT NULL);
ALTER TABLE CUSTOMERS
    MODIFY (c_phone_number NOT NULL);
ALTER TABLE CUSTOMERS
    MODIFY (c_street_address NOT NULL);
ALTER TABLE CUSTOMERS
    MODIFY (city NOT NULL);
ALTER TABLE CUSTOMERS
    ADD CONSTRAINT sys_customer_province_CK check (province in ('BC', 'AB', 'SK', 'MB', 'ON', 'QB', 'NS', 'NB', 'PE', 'NL', 'NT', 'NU', 'YT'));
ALTER TABLE CUSTOMERS
    MODIFY (province NOT NULL);
ALTER TABLE CUSTOMERS
    MODIFY (postal_code NOT NULL);

    --create credit card table--

CREATE TABLE CREDIT_CARD 
(
    customer_id NUMBER,
    credit_card_num NUMBER(16),
    credit_card_type CHAR(2)
);

--add constraints to credit card table--

ALTER TABLE CREDIT_CARD
    ADD CONSTRAINT sys_customer_id_credit_card_PK PRIMARY KEY(customer_id);
ALTER TABLE CREDIT_CARD
    ADD CONSTRAINT sys_customer_id_credit_card_FK  FOREIGN KEY (customer_id) REFERENCES customers(customer_id);
ALTER TABLE CREDIT_CARD
    MODIFY (credit_card_num NOT NULL);
ALTER TABLE CREDIT_CARD
    ADD CONSTRAINT sys_credit_card_type_CK_1 CHECK (credit_card_type in ('AX', 'MC', 'VS'));
ALTER TABLE CREDIT_CARD
    MODIFY (credit_card_type NOT NULL);