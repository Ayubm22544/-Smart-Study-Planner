CREATE DATABASE smart_study_planner;
USE smart_study_planner;
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);
CREATE TABLE tasks (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    task_name VARCHAR(255),
    subject VARCHAR(100),
    due_date DATE,
    priority_level ENUM('high', 'medium', 'low'),
    time_required INT,
    status ENUM('pending', 'in-progress', 'complete'),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);
CREATE TABLE study_sessions (
    session_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    task_id INT,
    start_time DATETIME,
    end_time DATETIME,
    duration DECIMAL(5, 2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (task_id) REFERENCES tasks(task_id)
);
CREATE TABLE subject_time_summary (
    student_id INT,
    subject VARCHAR(100),
    total_time_spent DECIMAL(6, 2),
    average_time_per_task DECIMAL(5, 2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);
INSERT INTO students (name, email)
VALUES 
('Ayub Mohamed', 'ayubm22544@gmail.com'),
('Sarah Johnson', 'Johnjones22544@gmail.com'),
('David Lee', 'Moha2108@umn.edu');

INSERT INTO tasks (student_id, task_name, subject, due_date, priority_level, time_required, status)
VALUES 
(1, 'Database Assignment', 'Databases', '2024-10-25', 'high', 5, 'pending'),
(1, 'Math Homework', 'Mathematics', '2024-10-22', 'medium', 3, 'in-progress'),
(2, 'Write Essay', 'English', '2024-10-23', 'high', 4, 'pending'),
(3, 'Research Paper', 'Science', '2024-10-28', 'low', 6, 'pending');
INSERT INTO study_sessions (student_id, task_id, start_time, end_time, duration)
VALUES 
(1, 1, '2024-10-21 10:00:00', '2024-10-21 12:00:00', 2.00),
(1, 2, '2024-10-20 15:00:00', '2024-10-20 16:30:00', 1.50),
(2, 3, '2024-10-20 09:00:00', '2024-10-20 11:00:00', 2.00),
(3, 4, '2024-10-19 13:00:00', '2024-10-19 16:00:00', 3.00);
SELECT task_name, subject, due_date
FROM tasks
WHERE due_date <= CURDATE() + INTERVAL 2 DAY
AND status = 'pending'
ORDER BY due_date;
SELECT subject, SUM(duration) AS total_time_spent
FROM tasks
JOIN study_sessions ON tasks.task_id = study_sessions.task_id
WHERE tasks.student_id = 1
GROUP BY subject;
SELECT task_name, subject, due_date, time_required
FROM tasks
WHERE student_id = 1
AND status = 'pending'
ORDER BY due_date ASC;
SELECT CONCAT(ROUND((SUM(CASE WHEN status = 'complete' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2), '%') AS completion_rate
FROM tasks
WHERE student_id = 1;

