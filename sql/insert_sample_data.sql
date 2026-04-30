-- =========================
-- pages
-- =========================

insert into pages (id, url, title)
values (1, '/sql', 'sql курс');

-- =========================
-- simulators
-- =========================

insert into simulators (id, name, price, page_id)
values (1, 'sql для анализа данных', 1000, 1);

-- =========================
-- chapters
-- =========================

insert into chapters (id, simulator_id, title, access_type)
values (1, 1, 'введение', 'both');

-- =========================
-- steps
-- =========================

insert into steps (id, chapter_id, type, access_type)
values 
(1, 1, 'text', 'both'),
(2, 1, 'question', 'both');

-- =========================
-- step_text
-- =========================

insert into step_text (step_id, content)
values (1, 'sql — это язык запросов');

-- =========================
-- questions
-- =========================

insert into questions (id, question_text, type)
values (1, 'что делает select?', 'single');

-- =========================
-- answers
-- =========================

insert into answers (id, question_id, answer_text, is_correct)
values
(1, 1, 'выбирает данные', true),
(2, 1, 'удаляет таблицу', false);

-- =========================
-- step_question
-- =========================

insert into step_question (step_id, question_id)
values (2, 1);

-- =========================
-- users
-- =========================

insert into users (id, name)
values (1, 'анастасия');

-- =========================
-- user_answers
-- =========================

insert into user_answers (user_id, question_id, answer_id)
values (1, 1, 1);