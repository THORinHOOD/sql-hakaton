CREATE SCHEMA catalog;

create table catalog.health_status (
    id serial not null primary key,
    name varchar(100) not null
);
insert into catalog.health_status (name) values
('Здоров'),
('Диагностирована болезнь'),
('На лечении'),
('Реабилитация'),
('Ремиссия');

CREATE TABLE catalog.user (
    id bigserial primary key,
    first_name text not null,
    last_name text not null,
    email varchar(320),
    password text,
    phone_ids bigint[],
    global_role_id int,
    catalog_role_ids int[],
    tracker_role_ids int[],
    additional_info jsonb
);

create table catalog.employee_availability (
    id serial primary key,
    name varchar(100) not null
);
insert into catalog.employee_availability (name) values
('Без ограничений'),
('Будни, в любое время'),
('Будни, вечер'),
('Выходные, любое время'),
('Выходные, несколько часов'),
('Другое');

create table catalog.catalog_role (
    id serial primary key,
    name text not null,
    description text not null
);
insert into catalog.catalog_role (name, description) values
('Руководитель', 'Доступны все справочники в Системе'),
('Отв. за HR', 'Доступен справочник сотрудников/волонтёров.'),
('Отв. за подопечных', 'Доступен справочник подопечных.'),
('Отв. за партнёров', 'Доступен справочник партнёров.'),
('Отв. за спонсоров', 'Доступен справочник спонсоров.'),
('Отв. за благотворителей', 'Доступен справочник благотворителей.'),
('Отв. за мероприятия', 'Доступен справочник мероприятий.');

create table catalog.contact (
    id bigserial primary key,
    name text not null,
    date_of_birth date,
    phone_ids bigint[],
    messenger text,
    email varchar(150),
    subdivision text,
    position text,
    comment text,
    start_date_of_relevance date,
    end_date_of_relevance date
);

create table catalog.partner_type (
    id serial primary key,
    name text not null
);
insert into catalog.partner_type (name) values
('Юридическое лицо'),
('Физическое лицо');

create table catalog.category_benefactor (
    id serial primary key,
    name text not null
);
insert into catalog.category_benefactor (name) values
('ВИП'),
('Обычный');

create table catalog.sphere_of_partnership (
    id serial primary key,
    name text not null
);
insert into catalog.sphere_of_partnership (name) values
('Площадка для мероприятий'),
('Кейтеринг'),
('Подарки и сувениры'),
('Полиграфия'),
('Медицинские услуги'),
('Юридические услуги'),
('Психологи');

create table catalog.event_type (
    id serial primary key,
    name text not null
);
insert into catalog.event_type (name) values
('Подопечные'),
('Бизнес');

create table catalog.event (
    id bigserial primary key,
    name text not null,
    date date not null,
    description text not null,
    headliner text not null,
    place text not null,
    count_people_plan int default 0,
    count_people_real int default 0,
    mark int default 0,
    event_type_id int,
    partner_ids bigint[],
    sponsor_ids bigint[]
);