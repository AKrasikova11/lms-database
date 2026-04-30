-- =====================================
-- 1. получение всех шагов с их типом
-- =====================================

select id, type, access_type
from steps;


-- =====================================
-- 2. получение текстовых шагов
-- =====================================

select s.id, st.content
from steps s
join step_text st on s.id = st.step_id;


-- =====================================
-- 3. вопросы и варианты ответов
-- =====================================

select q.question_text, a.answer_text, a.is_correct
from questions q
join answers a on q.id = a.question_id;


-- =====================================
-- 4. ответы пользователей
-- =====================================

select 
    u.name,
    q.question_text,
    a.answer_text as selected_answer,
    ua.text_answer
from user_answers ua
join users u on ua.user_id = u.id
join questions q on ua.question_id = q.id
left join answers a on ua.answer_id = a.id;


-- =====================================
-- результаты пользователя с проверкой правильности ответа
-- =====================================

select 
    u.name as user_name,
    q.question_text,
-- выбранный вариант ответа (если был выбор)
    a.answer_text as selected_answer,
-- текстовый ответ (если ввод вручную)
    ua.text_answer,
-- определяем, правильный ли ответ
    case 
        when a.is_correct = true then 'правильно'
        when a.is_correct = false then 'неправильно'
        else 'нет ответа'
    end as result
from user_answers ua
join users u 
    on ua.user_id = u.id
join questions q 
    on ua.question_id = q.id
left join answers a 
    on ua.answer_id = a.id;