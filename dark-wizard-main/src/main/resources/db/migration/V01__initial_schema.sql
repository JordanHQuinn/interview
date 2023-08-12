-- Here's a sample database of the characters in Harry Potter and the spells they cast throughout the series.
-- There's a table called spell_cast_event for tracking the spells cast by wizards.

create table wand (
                      wand_id  integer primary key,
                      length   numeric(5,2) not null,
                      wood     varchar(100) not null,
                      core     varchar(100) not null
);

comment on table wand is 'The wand table';
comment on column wand.wand_id is 'the primary key of the table';
comment on column wand.length is 'the wands length';
comment on column wand.wood is 'the wood used to make the wand';
comment on column wand.core is 'the core of the wand';

create table wizard (
                        wizard_id  integer primary key,
                        name       varchar(255) not null,
                        house      varchar(50),
                        wand_id    integer references wand(wand_id)
);

comment on table wizard is 'The wizard table';
comment on column wizard.wizard_id is 'the primary key of the table';
comment on column wizard.name is 'the wizards full name';
comment on column wizard.house is 'the hogwarts house the wizard went to';
comment on column wizard.wand_id is 'the foreign key to the wand table';

create table spell (
                       spell_id    integer primary key,
                       name        varchar(100) not null,
                       spell_type  varchar(100) not null,
                       description varchar(255) not null
);

comment on table spell is 'The spell table';
comment on column spell.spell_id is 'the primary key of the table';
comment on column spell.name is 'the spells name';
comment on column spell.spell_type is 'the type of spell';
comment on column spell.description is 'the description of the spell';

create table spell_cast_event (
                                  event_id   integer  generated always as identity constraint wizard_pk primary key,
                                  wand_id    integer not null references wand(wand_id),
                                  spell_id   integer not null references spell(spell_id)
);

comment on table spell_cast_event is 'the event stream of spells cast by wands';
comment on column spell_cast_event.spell_id is 'the foreign key to the spell table';
comment on column spell_cast_event.wand_id is 'the foreign key to the wand table';

insert into wand (wand_id, length, wood, core)
values (1, 11, 'Holly', 'Phoenix feather'),
       (2, 13.5, 'Yew', 'Phoenix feather'),
       (3, 14, 'Willow', 'Unicorn tail hair'),
       (4, 10.75, 'Vine', 'Dragon heartstring'),
       (5, 13, 'Connemara ebony', 'Dragon heartstring'),
       (6, 15, 'Elder', 'Thestral tail hair'),
       (7, 10, 'Hawthorn', 'Unicorn hair'),
       (8, 13, 'Cherry', 'Unicorn hair'),
       (9, 10, 'Cedar', 'Unicorn hair'),
       (10, 12.75, 'Walnut', 'Dragon heartstring'),
       (11, 12.25, 'Ash', 'Unicorn hair');

insert into wizard (wizard_id, name, house, wand_id)
values (1, 'Rubeus Hagrid', null, null),
       (2, 'Harry Potter', 'Gryffindor', 1),
       (3, 'Tom Riddle', 'Slytherin', 2),
       (4, 'Ron Weasley', 'Gryffindor', 3),
       (5, 'Hermione Granger', 'Gryffindor', 4),
       (6, 'Severus Snape', 'Slytherin', 5),
       (7, 'Albus Dumbledore', 'Gryffindor', 6),
       (8, 'Draco Malfoy', 'Slytherin', 7),
       (9, 'Neville Longbottom', 'Gryffindor', 8),
       (10, 'Luna Lovegood', 'Ravenclaw', 9),
       (11, 'Bellatrix Lestrange', 'Slytherin', 10),
       (12, 'Cedric Diggory', 'Hufflepuff', 11);

insert into spell (spell_id, name, spell_type, description)
values (1, 'Expelliarmus', 'Charm', 'Disarming Charm'),
       (2, 'Accio', 'Charm', 'Summoning Charm'),
       (3, 'Avada Kedavra', 'Curse', 'Killing Curse'),
       (4, 'Wingardium Leviosa', 'Charm', 'Levitation Charm'),
       (5, 'Stupefy', 'Charm', 'Stunning Spell'),
       (6, 'Petrificus Totalus', 'Curse', 'Full Body-Bind Curse'),
       (7, 'Imperio', 'Curse', 'Imperius Curse'),
       (8, 'Reducio', 'Charm', 'Shrinking Charm'),
       (9, 'Protego', 'Charm', 'Shield Charm'),
       (10, 'Scourgify', 'Charm', 'Scouring Charm'),
       (11, 'Aguamenti', 'Conjuration', 'Water-Making Spell'),
       (12, 'Confundo', 'Charm', 'Confusion Charm'),
       (13, 'Crucio', 'Curse', 'Cruciatus Curse'),
       (14, 'Obliviate', 'Charm', 'Memory Charm'),
       (15, 'Incendio', 'Conjuration', 'Fire-Making Spell'),
       (16, 'Lumos', 'Charm', 'Wand-Lighting Charm'),
       (17, 'Expecto Patronum', 'Charm', 'Patronus Charm'),
       (18, 'Sectumsempra', 'Curse', 'Slashed by Sword Curse'),
       (19, 'Levicorpus', 'Jinx', 'Body Levitation Jinx');

insert into spell_cast_event (wand_id, spell_id)
values (1, 1),(2, 3),(6, 4),(10, 15),(2, 13),(11, 1),(3, 9),(11, 5),(1, 7),
       (6, 5),(4, 11),(9, 17),(1, 11),(10, 13),(2, 3),(2, 13),(8, 1),(7, 15),
       (6, 6),(5, 16),(2, 15),(5, 9),(10, 3),(9, 9),(3, 16),(10, 3),(6, 9),
       (3, 5),(6, 11),(4, 5),(2, 13),(9, 5),(6, 17),(5, 7),(1, 2),(5, 15),
       (9, 1),(10, 13),(1, 4),(4, 2),(9, 2),(1, 5),(7, 13),(6, 8),(5, 18),
       (1, 8),(7, 9),(1, 16),(4, 10),(1, 17),(2, 7),(6, 14),(2, 3),(2, 15),
       (2, 13),(3, 2),(11, 2),(3, 4),(3, 17),(4, 1),(4, 4),(1, 9),(4, 8),
       (4, 9),(4, 12),(4, 16),(5, 1),(5, 3),(5, 13),(6, 1),(6, 2),(6, 10),
       (1, 18),(6, 12),(6, 15),(1, 13),(6, 16),(7, 1),(1, 10),(7, 5),(7, 6),
       (8, 5),(1, 12),(8, 9),(5, 19),(2, 13),(2, 7),(8, 17),(1, 6),(9, 6),
       (9, 16),(2, 3),(10, 7),(3, 1),(2, 7),(10, 7),(4, 17),(1, 19),(5, 17),
       (9, 16),(2, 3),(10, 7),(3, 1),(2, 7),(10, 7),(4, 17),(1, 19),(5, 17),
       (4, 6),(2, 13),(11, 9),(1, 1),(4, 10),(2, 3),(1, 18),(6, 8),(1, 1);
