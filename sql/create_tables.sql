-- =========================
-- DROP TABLES (в порядке зависимостей)
-- =========================

drop table if exists user_answers

drop table if exists users

drop table if exists step_dialog

drop table if exists authors

drop table if exists step_question

drop table if exists answers

drop table if exists questions

drop table if exists step_video

drop table if exists step_text

drop table if exists steps

drop table if exists chapters

drop table if exists simulators

drop table if exists pages

-- =========================
-- PAGES (SEO и URL)
-- =========================

create table pages (
	id serial primary key, 
	url text, -- адрес страницы (/sql, /blog/...)
	title text,
	description text,
	keywords text -- ключевые слова (храним как текст, без усложнений)
)

-- =========================
-- SIMULATORS (курсы)
-- =========================

create table simulators (
	id serial primary key,
	name text not null,
	price int,
	page_id int, -- ссылка на страницу симулятора
	constraint fk_simulators_pages
		foreign key (page_id)
		references pages (id)
)

-- =========================
-- CHAPTERS (главы курса)
-- =========================

create table chapters (
	id serial primary key,
	simulator_id int,
	constraint fk_chapters_simulators
		foreign key (simulator_id)
		references simulators(id),
	title text,
	"order" int,  -- порядок глав внутри симулятора
	access_type text  -- demo / full / both
)

-- =========================
-- STEPS (шаги внутри главы)
-- =========================

create table steps (
	id serial primary key,
	chapter_id int,
	constraint fk_steps_chapters
		foreign key (chapter_id)
		references chapters (id), 
	type text, -- text / video / question / dialog
	"order" int, -- порядок шагов внутри глав
	access_type text  -- demo / full / both
	)
	
-- =========================
-- STEP_TEXT (текстовые шаги)
-- 1:1 со steps
-- =========================
	
create table step_text (
	step_id int primary key,
	constraint fk_text_steps
		foreign key (step_id)
		references steps (id),
	content text
)

-- =========================
-- STEP_VIDEO (видео шаги)
-- 1:1 со steps
-- =========================

create table step_video (
	step_id int primary key,
	constraint fk_video_steps
		foreign key (step_id)
		references steps (id),
	url text
)

-- =========================
-- QUESTIONS (вопросы)
-- =========================

create table questions (
	id serial primary key,
	question_text text,
	type text  -- single / multiple / text
)

-- =========================
-- ANSWERS (варианты ответов)
-- =========================

create table answers (
	id serial primary key,
	question_id int,
	constraint fk_answers_questions
		foreign key (question_id)
		references questions (id),
	answer_text text,
	is_correct boolean -- признак правильного ответа
)

-- =========================
-- STEP_QUESTION (шаг с вопросом)
-- =========================

create table step_question (
	step_id int primary key,
	constraint fk_question_steps
		foreign key (step_id)
		references steps (id),
	question_id int,
	constraint fk_questions
		foreign key (question_id)
		references questions (id)
)
	
-- =========================
-- AUTHORS (авторы диалогов)
-- =========================	
	
create table authors (
	id serial primary key,
	name text
)

-- =========================
-- STEP_DIALOG (диалоги)
-- =========================

create table step_dialog (
	step_id int primary key,
	constraint fk_dialog_steps
		foreign key (step_id)
		references steps (id),
	message text, 
	is_incoming boolean, -- входящее или исходящее сообщение
	author_id int,  -- nullable: если NULL → "Вы"
	constraint fk_dialog_authors
		foreign key (author_id)
		references authors (id)
)

-- =========================
-- USERS
-- =========================

create table users(
	id serial primary key,
	name text
)

-- =========================
-- USER_ANSWERS (ответы пользователей)
-- =========================

create table user_answers (
	id serial primary key,
	user_id int,
	constraint fk_answers_users
		foreign key (user_id)
		references users (id),
	question_id int,
	constraint fk_user_answers_questions
		foreign key (question_id)
		references questions (id),
	answer_id int, 
	constraint fk_answers
		foreign key (answer_id)
		references answers (id),
	text_answer text
)