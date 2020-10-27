CREATE SCHEMA persons;

create table persons.health_status (
    id serial not null primary key,
    name varchar(100) not null
);
insert into persons.health_status (name) values
('Здоров'),
('Диагностирована болезнь'),
('На лечении'),
('Реабилитация'),
('Ремиссия');

CREATE TABLE persons.ward (
    id bigserial primary key,
    name text not null,
    date_of_birth date,
    comment text,
    diagnosis text not null,
    phone_main varchar(15) not null,
    phone_backup varchar(15) not null,
    messenger text,
    email varchar(150),
    profession text,
    hobbies text,
    health_status_id int
);
-- example
insert into persons.ward (name, date_of_birth, comment, diagnosis, phone_main, phone_backup, messenger, email, profession, hobbies, health_status_id) values
('name', '2020-09-01', 'hello', 'kek', '+79169500000', '+79169500000', 'telegram', 'a@a.ru', null, null, 1);
---

create table persons.employee_availability (
    id serial primary key,
    name varchar(100) not null
);
insert into persons.employee_availability (name) values
('Без ограничений'),
('Будни, в любое время'),
('Будни, вечер'),
('Выходные, любое время'),
('Выходные, несколько часов'),
('Другое');

create table persons.catalog_role (
    id serial primary key,
    name text not null,
    description text not null
);
insert into persons.catalog_role (name, description) values
('Руководитель', 'Доступны все справочники в Системе'),
('Отв. за HR', 'Доступен справочник сотрудников/волонтёров.'),
('Отв. за подопечных', 'Доступен справочник подопечных.'),
('Отв. за партнёров', 'Доступен справочник партнёров.'),
('Отв. за спонсоров', 'Доступен справочник спонсоров.'),
('Отв. за благотворителей', 'Доступен справочник благотворителей.'),
('Отв. за мероприятия', 'Доступен справочник мероприятий.');


create table persons.employee (
    id bigserial primary key,
    name text not null,
    date_of_birth date not null,
    city_of_residence text not null,
    phone_personal varchar(15) not null,
    phone_work varchar(15) not null,
    email_personal varchar(150),
    messenger text,
    place_of_work text not null,
    position_at_work text not null,
    position_at_fund text not null,
    area_of_responsibility text,
    education_university text,
    education_specialty text,
    availability_comment text,
    level_foreign_languages text,
    hobbies text,
    comment text,
    employee_availability_ids int[],
    catalog_roles_ids int[],
    request_from_ward_role_id int,
    request_work_role_id int
);


create table persons.contact (
    id bigserial primary key,
    name text not null,
    date_of_birth date,
    phone varchar(15),
    messenger text,
    email varchar(150),
    subdivision text,
    position text,
    comment text,
    start_date_of_relevance date,
    end_date_of_relevance date
);

create table persons.partner_type (
    id serial primary key,
    name text not null
);
insert into persons.partner_type (name) values
('Юридическое лицо'),
('Физическое лицо');

create table persons.category (
    id serial primary key,
    name text not null
);
insert into persons.category (name) values
('ВИП'),
('Обычный');

create table persons.sphere_of_partnership (
    id serial primary key,
    name text not null
);
insert into persons.sphere_of_partnership (name) values
('Площадка для мероприятий'),
('Кейтеринг'),
('Подарки и сувениры'),
('Полиграфия'),
('Медицинские услуги'),
('Юридические услуги'),
('Психологи');

create table persons.sponsor (
    id bigserial primary key,
    name text not null,
    registration_details text not null,
    payment_details text,
    phone varchar(15) not null,
    email varchar(150) not null,
    social_networks text[],
    site text not null,
    comment text,
    partner_type_id int,
    contact_ids bigint[],
    category_id int
);

create table persons.benefactor (
    id bigserial primary key,
    name text not null,
    registration_details text not null,
    payment_details text,
    phone varchar(15) not null,
    email varchar(150) not null,
    social_networks text[],
    site text not null,
    comment text,
    category_id int,
    date_of_birth date
);

create table persons.partner (
    id bigserial primary key,
    name text not null,
    registration_details text not null,
    payment_details text,
    phone varchar(15) not null,
    email varchar(150) not null,
    social_networks text[],
    site text not null,
    comment text,
    category_id int,
    sphere_of_partnership_ids int[],
    contact_ids bigint[],
    partner_type_id int
);