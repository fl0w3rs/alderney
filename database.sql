-- Alderney database schema. Users and groups come from the IPS4 forum database.

-- Tests. time is the limit in seconds, question_count is how many random questions to give,
-- groups is a comma-separated list of forum group ids that can take the test.
CREATE TABLE tests (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(64),
  time INT,
  question_count INT,
  pass_percent INT,
  `groups` VARCHAR(255),
  is_open TINYINT
);

-- Questions. type: 1 = single choice, 2 = multiple choice, 3 = free text.
-- options are separated by |ALDERNEY|, answers are comma-separated indexes of the correct options.
CREATE TABLE questions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  test_id INT,
  text TEXT,
  options TEXT,
  answers VARCHAR(255),
  type INT
);

-- Attempts. status: 1 = in progress, 2 = passed, 3 = failed, -1 = cancelled.
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

-- A participant's answers within an attempt.
CREATE TABLE ut_answers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  ut_result_id INT,
  question_id INT,
  answers TEXT,
  is_valid TINYINT
);
