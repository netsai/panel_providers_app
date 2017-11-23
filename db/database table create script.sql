 ---Create database and tables---------------------

 CREATE DATABASE panels;

create table users(
id serial PRIMARY KEY,
name character varying(200),
email character varying(200),
created_at timestamp without time zone,
update_at   timestamp without time zone

);


create table panel_providers(
id serial PRIMARY KEY ,
code character varying(200)
);

create table countries(
id serial PRIMARY KEY,
country_code character varying(200),
panel_provider_id integer,
CONSTRAINT panel_provider_id_fk FOREIGN KEY(panel_provider_id) REFERENCES panel_providers(id)

);

create table target_groups(
id serial PRIMARY KEY,
name character varying(200),
external_id integer,
parent_id integer,
panel_provider_id integer,
secret_code character varying(200),
CONSTRAINT tgt_panel_provider_id_fk FOREIGN KEY(panel_provider_id) REFERENCES panel_providers(id)

);

create table country_target_groups(
id serial PRIMARY KEY,
country_id integer,
target_group_id integer,
CONSTRAINT country_id_fk FOREIGN KEY(country_id) REFERENCES countries(id),
CONSTRAINT target_group_id_fk FOREIGN KEY(target_group_id) REFERENCES target_groups(id)

);


create table location_groups(
id serial PRIMARY KEY,
name character varying(200),
country_id integer,
panel_provider_id integer,
CONSTRAINT lg_panel_provider_id_fk FOREIGN KEY(panel_provider_id) REFERENCES panel_providers(id),
CONSTRAINT country_id_fk FOREIGN KEY(country_id) REFERENCES countries(id)

);

create table locations(
id serial PRIMARY KEY,
name character varying(200),
external_id integer,
secret_code character varying(200)

);

create table location_location_groups(
id serial PRIMARY KEY,
location_id integer,
location_group_id integer,
CONSTRAINT location_id_fk FOREIGN KEY(location_id) REFERENCES locations(id),
CONSTRAINT location_group_fk FOREIGN KEY(location_group_id) REFERENCES location_groups(id)
);
