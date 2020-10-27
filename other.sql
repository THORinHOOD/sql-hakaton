CREATE SCHEMA other;

create table other.event_type (
    id serial primary key,
    name text not null
);
insert into other.event_type (name) values
('Подопечные'),
('Бизнес');

create table other.event (
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