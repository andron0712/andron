-- ==========================================
-- БАЗА ДАНИХ: university
-- Варіант 1 — Університет
-- ==========================================

CREATE DATABASE IF NOT EXISTS university;
USE university;

-- 1. Створення таблиць із потрібними зв'язками
CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    group_name VARCHAR(20),
    birth_date DATE
);

CREATE TABLE grades (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject VARCHAR(50),
    grade INT,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

CREATE TABLE scholarships (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    amount DECIMAL(8,2),
    type VARCHAR(30),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE SET NULL
);

CREATE TABLE attendance (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    `date` DATE,
    status ENUM('present', 'absent', 'late'),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE SET NULL
);

-- ==========================================
-- НАПОВНЕННЯ ТАБЛИЦЬ (Завдання 1 - 4)
-- ==========================================

-- 1. Додавання 5 студентів із двох різних груп ('A1' та 'B2')
INSERT INTO students (first_name, last_name, group_name, birth_date) VALUES
('Олег', 'Петренко', 'A1', '2004-05-12'),
('Марія', 'Коваль', 'A1', '2003-11-28'),
('Андрій', 'Бойко', 'B2', '2004-01-15'),
('Анна', 'Шевченко', 'A1', '2005-03-22'),
('Ігор', 'Ткаченко', 'B2', '2003-07-09');

-- 2. Додавання по 2 оцінки для кожного студента
INSERT INTO grades (student_id, subject, grade) VALUES
(1, 'Математика', 95), (1, 'Фізика', 88),
(2, 'Математика', 90), (2, 'Історія', 92),
(3, 'Програмування', 85), (3, 'Фізика', 78),
(4, 'Математика', 98), (4, 'Історія', 95),
(5, 'Програмування', 73), (5, 'Фізика', 81);

-- 3. Додавання стипендій для 3 студентів
INSERT INTO scholarships (student_id, amount, type) VALUES
(1, 2000.00, 'Академічна'),
(2, 2500.00, 'Підвищена'),
(4, 2000.00, 'Академічна');

-- 4. Додавання по 2 записи відвідуваності
INSERT INTO attendance (student_id, `date`, status) VALUES
(1, '2026-05-11', 'present'), (1, '2026-05-12', 'present'),
(2, '2026-05-11', 'present'), (2, '2026-05-12', 'late'),
(3, '2026-05-11', 'absent'),  (3, '2026-05-12', 'present'),
(4, '2026-05-11', 'present'), (4, '2026-05-12', 'present'),
(5, '2026-05-11', 'late'),    (5, '2026-05-12', 'absent');

-- ==========================================
-- ОНОВЛЕННЯ ТА ВИДЛЯЕННЯ ДАНИХ (Завдання 5 - 7)
-- ==========================================

-- 5. Оновлення прізвища студента
UPDATE students SET last_name = 'Бондар' WHERE id = 2;

-- 6. Оновлення оцінки з предмету
UPDATE grades SET grade = 93 WHERE student_id = 1 AND subject = 'Фізика';

-- 7. Видалення одного студента (id = 1) для перевірки каскадних зв'язків
DELETE FROM students WHERE id = 1;

-- Перевірка результатів видалення:
-- SELECT * FROM grades WHERE student_id = 1; -- Поверне порожній результат (Каскад спрацював)
-- SELECT * FROM scholarships WHERE student_id IS NULL; -- Поверне запис, де ID став NULL (Дані збережено)
-- SELECT * FROM attendance WHERE student_id IS NULL; -- Поверне записи, де ID став NULL (Дані збережено)

-- ==========================================
-- ПОШУКОВІ ЗАПИТИ (Завдання 8)
-- ==========================================

-- 8.1 Виведення всіх студентів
SELECT * FROM students;

-- 8.2 Виведення студентів групи 'A1'
SELECT * FROM students WHERE group_name = 'A1';

-- 8.3 Виведення студентів у порядку спадання по даті народження
SELECT * FROM students ORDER BY birth_date DESC;

-- 8.4 Виведення студентів з групи 'A1' у порядку зростання імені
SELECT * FROM students WHERE group_name = 'A1' ORDER BY first_name ASC;
