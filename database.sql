-- Схема базы Alderney. Пользователи и группы берутся из базы форума IPS4.

-- Тесты. time — лимит в секундах, question_count — сколько случайных вопросов выдать,
-- groups — id групп форума через запятую, которым доступен тест.
CREATE TABLE tests (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(64),
  time INT,
  question_count INT,
  pass_percent INT,
  `groups` VARCHAR(255),
  is_open TINYINT
);

-- Вопросы. type: 1 — один ответ, 2 — несколько, 3 — свободный текст.
-- options разделены строкой |ALDERNEY|, answers — индексы правильных вариантов через запятую.
CREATE TABLE questions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  test_id INT,
  text TEXT,
  options TEXT,
  answers VARCHAR(255),
  type INT
);

-- Попытки прохождения. status: 1 — в процессе, 2 — сдан, 3 — не сдан, -1 — аннулирован.
CREATE TABLE ut_results (
  id INT AUTO_INCREMENT PRIMARY KEY,
  test_id INT,
  user_id INT,
  valid_answers INT,
  questions VARCHAR(255),
  total_questions INT,
  last_keepalive INT,
  current_question INT,
  start_time INT,
  end_time INT,
  status INT,
  retest TINYINT DEFAULT 0,
  fail_reason VARCHAR(255) DEFAULT ''
);

-- Ответы участника на вопросы попытки.
CREATE TABLE ut_answers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  ut_result_id INT,
  question_id INT,
  answers TEXT,
  is_valid TINYINT
);
