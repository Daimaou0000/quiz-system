-- Create Database
CREATE DATABASE IF NOT EXISTS quiz_system;
USE quiz_system;

-- Users Table
CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('ADMIN', 'INSTRUCTOR', 'STUDENT') NOT NULL DEFAULT 'STUDENT',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Quizzes Table
CREATE TABLE quizzes (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    instructor_id BIGINT NOT NULL,
    time_limit INT DEFAULT 30,
    total_marks INT DEFAULT 100,
    is_published BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (instructor_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Questions Table
CREATE TABLE questions (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    quiz_id BIGINT NOT NULL,
    text TEXT NOT NULL,
    type ENUM('MULTIPLE_CHOICE', 'TRUE_FALSE', 'SHORT_ANSWER') NOT NULL,
    marks INT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
);

-- Answers Table
CREATE TABLE answers (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    question_id BIGINT NOT NULL,
    text TEXT NOT NULL,
    is_correct BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);

-- Results Table
CREATE TABLE results (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    quiz_id BIGINT NOT NULL,
    score INT DEFAULT 0,
    total_marks INT DEFAULT 0,
    percentage DECIMAL(5,2),
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
);

-- Submissions Table
CREATE TABLE submissions (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    quiz_id BIGINT NOT NULL,
    question_id BIGINT NOT NULL,
    answer_id BIGINT,
    answer_text TEXT,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE,
    FOREIGN KEY (answer_id) REFERENCES answers(id) ON DELETE CASCADE
);

-- Insert Sample Data
INSERT INTO users (name, email, password, role) VALUES
('Admin User', 'admin@quiz.com', '$2a$10$YourHashedPasswordHere', 'ADMIN'),
('Instructor One', 'instructor@quiz.com', '$2a$10$YourHashedPasswordHere', 'INSTRUCTOR'),
('Student One', 'student@quiz.com', '$2a$10$YourHashedPasswordHere', 'STUDENT');

INSERT INTO quizzes (title, description, instructor_id, time_limit, total_marks, is_published) VALUES
('Java Programming Basics', 'Test your Java fundamentals', 2, 45, 100, TRUE),
('Web Development Quiz', 'HTML, CSS, and JavaScript questions', 2, 30, 50, TRUE);

INSERT INTO questions (quiz_id, text, type, marks) VALUES
(1, 'What is Java?', 'MULTIPLE_CHOICE', 5),
(1, 'Java is platform independent', 'TRUE_FALSE', 2),
(1, 'Explain OOP concepts', 'SHORT_ANSWER', 10);

INSERT INTO answers (question_id, text, is_correct) VALUES
(1, 'A programming language', TRUE),
(1, 'A coffee brand', FALSE),
(1, 'An operating system', FALSE),
(2, 'True', TRUE),
(2, 'False', FALSE);

-- Create Indexes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_quizzes_instructor ON quizzes(instructor_id);
CREATE INDEX idx_questions_quiz ON questions(quiz_id);
CREATE INDEX idx_results_user ON results(user_id);
CREATE INDEX idx_results_quiz ON results(quiz_id);
