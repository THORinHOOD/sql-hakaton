CREATE SCHEMA tracker;

create table tracker.request_from_ward_role (
    id serial primary key,
    name text not null,
    description text not null
);
insert into tracker.request_from_ward_role (id, name, description) values
(1, 'Руководитель', 'Доступ на просмотр всех запросов в трекере'),
(2, 'Супервайзер', 'Полный доступ ко всем запросам в трекере'),
(3, 'Оператор', 'Ввод запросов Систему. Перевод на исполнение Координатору'),
(4, 'Координатор', 'Передача запроса Экспертам на исполнение. Закрытие запроса. Отказ запроса.'),
(5, 'Эксперт', 'Исполнение запроса (подготовка ответа на запрос). Отметка о выполнении.');

create table tracker.request_from_ward_status (
    id serial primary key,
    name text not null,
    description text not null
);
insert into tracker.request_from_ward_status (id, name, description) values
(1, 'Новый', 'Присваивается запросу по умолчанию при создании. Запрос не готов для передачи на исполнение.'),
(2, 'Оформлен', 'Запрос полностью оформлен и передан Координатору для исполнения.'),
(3, 'К исполнению', 'Координатор передал запрос на исполнение Эксперту или себе (в последнем случае этот статус может быть пропущен).' ||
                 'Координатор в процессе исполнения может последовательно передавать запрос разным Экспертам.' ||
                 'Координатор можем сам исполнить запрос, без его передачи Эксперту.'),
(4, 'В работе', 'Исполнитель (Координатор, Эксперт) принял запрос к исполнению.'),
(5, 'Выполнен', 'Исполнитель (Координатор, Эксперт) исполнил запрос.'),
(6, 'Закрыт', 'Координатор закрыл запрос (результаты приняты, дальнейших активностей по обработке запроса не планируется).'),
(7, 'Отказан', 'Запрос Исполнителем (Координатор, Эксперт) мотивированно отказан');

create table tracker.request_from_ward_transaction (
    "from" int,
    "to" int,
    role int,
    condition text
);
insert into tracker.request_from_ward_transaction ("from", "to", role, condition)
values
       (1, 2, 3),
       (1, 7, 3),
       (2, 1, 3),
       (2, 1, 4),
       (2, 3, 4),
       (2, 4, 4, 'если не указан исполнитель'),
       (2, 6, 4, 'если не указан исполнитель'),
       (2, 7, 4),
       (3, 2, 4),
       (3, 4, 4),
       (3, 4, 5),
       (3, 7, 5),
       (4, 3, 4),
       (4, 3, 5),
       (4, 5, 4),
       (4, 5, 5),
       (5, 3, 4),
       (5, 4, 4),
       (5, 4, 5),
       (5, 6, 4),
       (6, 3, 4),
       (7, 1, 4),
       (7, 2, 4),
       (7, 3, 4);

create table tracker.message (
    id bigserial primary key,
    creation timestamp not null,
    message text not null
);

create table tracker.request_from_ward (
    id bigserial primary key,
    registration_date timestamp not null,
    name text not null,
    phone varchar(15) not null,
    email varchar(150) not null,
    body text,
    last_transaction timestamp not null,
    trafic text,
    status int,
    report_id bigint
);

create table tracker.request_work_role (
    id serial primary key,
    name text not null,
    description text not null
);
insert into tracker.request_work_role (id, name, description) values
(1, 'Руководитель', 'Доступ на просмотр всех запросов в трекере'),
(2, 'Супервайзер', 'Полный доступ ко всем запросам в трекере'),
(3, 'Отв. за подопечных', 'Обрабатывает и/или исполняет запросы волонтёров'),
(4, 'Отв. за партнёров', 'Обрабатывает и/или исполняет запросы партнёров'),
(5, 'Отв. за спонсоров', 'Обрабатывает и/или исполняет запросы спонсоров'),
(6, 'Отв. за благотворителей', 'Обрабатывает и/или исполняет запросы благотворителей');

create table tracker.request_work_status (
    id serial primary key,
    name text not null,
    description text not null
);
insert into tracker.request_work_status (id, name, description) values
(1, 'Новый', 'Присваивается запросу по умолчанию при создании. Запрос не готов для передачи на исполнение.'),
(2, 'К исполнению', 'Запрос полностью оформлен, в т.ч. указаны: Ответственный за запрос; Исполнитель запроса; и передан на исполнение.'),
(3, 'В работе', 'Исполнитель принял запрос к исполнению.'),
(4, 'Выполнен', 'Исполнитель исполнил запрос.'),
(5, 'Закрыт', 'Запрос исполнен, результаты приняты. Других активностей по его обработке не планируется.');

create table tracker.request_work_transaction (
    "from" int,
    "to" int,
    role_ids int[],
    condition text
);
insert into tracker.request_work_transaction ("from", "to", role_ids, condition)
values
       (1, 2, '{3, 4, 5, 6}'),
       (1, 3, '{3, 4, 5, 6}'),
       (2, 1, '{3, 4, 5, 6}');

create table tracker.request_type (
    id serial primary key,
    name text not null
);
insert into tracker.request_type (id, name) values
(1, 'employee'),
(2, 'sponsor'),
(3, 'partner'),
(4, 'benefactor');

create table tracker.request_work (
    id bigserial primary key,
    registration_date timestamp not null,
    name text not null,
    phone varchar(15) not null,
    email varchar(150) not null,
    body text,
    last_transaction timestamp not null,
    trafic text,
    status int,
    site text,
    social_network text,
    request_type_id int,
    responsible bigint,
    executor bigint,
    supplier_id bigint,
    message_ids bigint[]
);