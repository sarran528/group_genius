-- =============================================================
--  GROUP GENIUS  –  COMPLETE DUMMY DATA SEED
--  Run once on a fresh (empty) database after schema.sql.
--  All user passwords are BCrypt of "Password123"
-- =============================================================

-- ---------------------------------------------------------------
-- 0. SAFETY: disable FK checks so we can insert in any order
-- ---------------------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;

-- ---------------------------------------------------------------
-- 1. COURSES  (10 rows – mirrors CourseDataInitializer.java)
-- ---------------------------------------------------------------
INSERT IGNORE INTO courses (course_code, course_name, description, current_enrollment) VALUES
('CS101',   'Introduction to Computer Science',  'Fundamental concepts of computer science, programming basics, and problem-solving techniques.',   0),
('CS201',   'Data Structures and Algorithms',    'Study of fundamental data structures and algorithms, complexity analysis, and implementation.',    0),
('CS301',   'Database Systems',                  'Database design, SQL, NoSQL databases, and database management systems.',                          0),
('CS401',   'Software Engineering',              'Software development lifecycle, design patterns, testing, and project management.',                0),
('MATH101', 'Calculus I',                        'Limits, derivatives, and applications of differential calculus.',                                  0),
('MATH201', 'Calculus II',                       'Integration techniques, infinite series, and parametric equations.',                               0),
('PHYS101', 'General Physics I',                 'Mechanics, waves, and thermodynamics with laboratory component.',                                  0),
('ENG101',  'Composition and Rhetoric',          'Academic writing, critical thinking, and communication skills.',                                   0),
('BUS101',  'Introduction to Business',          'Overview of business functions, entrepreneurship, and business environment.',                      0),
('PSYC101', 'Introduction to Psychology',        'Fundamental concepts in psychology, human behavior, and mental processes.',                        0);

-- ---------------------------------------------------------------
-- 2. USERS  (6 users – BCrypt hash of "Password123")
-- ---------------------------------------------------------------
INSERT IGNORE INTO users (id, first_name, last_name, email, password,
                          university, major, current_year, graduation_year,
                          secondary_school, bio, profile_image_url) VALUES
(1, 'Alice', 'Johnson', 'alice@example.com',
 '$2a$10$7EqJtq98hPqEX7fNZaFWoOe3d68Sl1FJmFBqJQRb1U3J5HS.I0LiS',
 'State University', 'Computer Science',    '3rd Year', '2027',
 'Lincoln High',   'Passionate about algorithms and open-source.',      NULL),

(2, 'Bob',   'Smith',   'bob@example.com',
 '$2a$10$7EqJtq98hPqEX7fNZaFWoOe3d68Sl1FJmFBqJQRb1U3J5HS.I0LiS',
 'State University', 'Computer Science',    '3rd Year', '2027',
 'Jefferson High', 'Full-stack dev by night, student by day.',           NULL),

(3, 'Carol', 'Williams','carol@example.com',
 '$2a$10$7EqJtq98hPqEX7fNZaFWoOe3d68Sl1FJmFBqJQRb1U3J5HS.I0LiS',
 'State University', 'Mathematics',         '2nd Year', '2028',
 'Riverside High', 'Math enthusiast who loves proofs.',                  NULL),

(4, 'David', 'Brown',   'david@example.com',
 '$2a$10$7EqJtq98hPqEX7fNZaFWoOe3d68Sl1FJmFBqJQRb1U3J5HS.I0LiS',
 'Tech Institute',  'Software Engineering', '4th Year', '2026',
 'Oakwood High',   'Building side projects and studying SE.',            NULL),

(5, 'Emma',  'Davis',   'emma@example.com',
 '$2a$10$7EqJtq98hPqEX7fNZaFWoOe3d68Sl1FJmFBqJQRb1U3J5HS.I0LiS',
 'Tech Institute',  'Physics',             '1st Year', '2029',
 'Sunnydale High', 'Physics geek, curious about quantum computing.',     NULL),

(6, 'Frank', 'Miller',  'frank@example.com',
 '$2a$10$7EqJtq98hPqEX7fNZaFWoOe3d68Sl1FJmFBqJQRb1U3J5HS.I0LiS',
 'City College',    'Business',            '2nd Year', '2028',
 'Elmwood High',   'Interested in entrepreneurship and tech startups.', NULL);

-- ---------------------------------------------------------------
-- 3. USER ↔ COURSE ENROLMENTS
--    Each user shares ≥2 courses with others → peer matching works
-- ---------------------------------------------------------------
-- Alice: CS101, CS201, CS301, MATH101
INSERT IGNORE INTO user_courses (user_id, course_id) VALUES
(1, (SELECT id FROM courses WHERE course_code = 'CS101')),
(1, (SELECT id FROM courses WHERE course_code = 'CS201')),
(1, (SELECT id FROM courses WHERE course_code = 'CS301')),
(1, (SELECT id FROM courses WHERE course_code = 'MATH101'));

-- Bob: CS101, CS201, CS401, MATH101
INSERT IGNORE INTO user_courses (user_id, course_id) VALUES
(2, (SELECT id FROM courses WHERE course_code = 'CS101')),
(2, (SELECT id FROM courses WHERE course_code = 'CS201')),
(2, (SELECT id FROM courses WHERE course_code = 'CS401')),
(2, (SELECT id FROM courses WHERE course_code = 'MATH101'));

-- Carol: MATH101, MATH201, CS101, PHYS101
INSERT IGNORE INTO user_courses (user_id, course_id) VALUES
(3, (SELECT id FROM courses WHERE course_code = 'MATH101')),
(3, (SELECT id FROM courses WHERE course_code = 'MATH201')),
(3, (SELECT id FROM courses WHERE course_code = 'CS101')),
(3, (SELECT id FROM courses WHERE course_code = 'PHYS101'));

-- David: CS401, CS301, CS201, ENG101
INSERT IGNORE INTO user_courses (user_id, course_id) VALUES
(4, (SELECT id FROM courses WHERE course_code = 'CS401')),
(4, (SELECT id FROM courses WHERE course_code = 'CS301')),
(4, (SELECT id FROM courses WHERE course_code = 'CS201')),
(4, (SELECT id FROM courses WHERE course_code = 'ENG101'));

-- Emma: PHYS101, MATH101, MATH201, CS101
INSERT IGNORE INTO user_courses (user_id, course_id) VALUES
(5, (SELECT id FROM courses WHERE course_code = 'PHYS101')),
(5, (SELECT id FROM courses WHERE course_code = 'MATH101')),
(5, (SELECT id FROM courses WHERE course_code = 'MATH201')),
(5, (SELECT id FROM courses WHERE course_code = 'CS101'));

-- Frank: BUS101, ENG101, PSYC101, CS101
INSERT IGNORE INTO user_courses (user_id, course_id) VALUES
(6, (SELECT id FROM courses WHERE course_code = 'BUS101')),
(6, (SELECT id FROM courses WHERE course_code = 'ENG101')),
(6, (SELECT id FROM courses WHERE course_code = 'PSYC101')),
(6, (SELECT id FROM courses WHERE course_code = 'CS101'));

-- ---------------------------------------------------------------
-- 4. UPDATE current_enrollment counts
-- ---------------------------------------------------------------
UPDATE courses c
SET    current_enrollment = (
    SELECT COUNT(*) FROM user_courses uc WHERE uc.course_id = c.id
);

-- ---------------------------------------------------------------
-- 5. GROUPS  (5 study groups – PUBLIC and PRIVATE)
-- ---------------------------------------------------------------
INSERT IGNORE INTO `groups`
    (id, group_name, description, course_id, privacy_type, group_password, created_by, created_at) VALUES

(1, 'CS101 Study Crew',
    'A group for mastering intro CS concepts and homework help.',
    (SELECT id FROM courses WHERE course_code = 'CS101'),
    'PUBLIC', NULL, 1, NOW() - INTERVAL 30 DAY),

(2, 'Algorithms Grind',
    'Competitive programmers preparing for coding interviews and DSA mastery.',
    (SELECT id FROM courses WHERE course_code = 'CS201'),
    'PUBLIC', NULL, 2, NOW() - INTERVAL 20 DAY),

(3, 'Calculus Warriors',
    'Weekly sessions to conquer calculus problems together.',
    (SELECT id FROM courses WHERE course_code = 'MATH101'),
    'PUBLIC', NULL, 3, NOW() - INTERVAL 15 DAY),

(4, 'SE Project Team Alpha',
    'Private group for our semester software engineering capstone project.',
    (SELECT id FROM courses WHERE course_code = 'CS401'),
    'PRIVATE', '$2a$10$7EqJtq98hPqEX7fNZaFWoOe3d68Sl1FJmFBqJQRb1U3J5HS.I0LiS', 4, NOW() - INTERVAL 10 DAY),

(5, 'Physics & Math Lab',
    'Cross-course group for physics and advanced math problem solving.',
    (SELECT id FROM courses WHERE course_code = 'PHYS101'),
    'PUBLIC', NULL, 5, NOW() - INTERVAL 5 DAY);

-- ---------------------------------------------------------------
-- 6. GROUP MEMBERS  (ADMIN + MEMBER mix, some PENDING)
-- ---------------------------------------------------------------
-- Group 1 – CS101 Study Crew
INSERT IGNORE INTO group_members (group_id, user_id, role, status, joined_at) VALUES
(1, 1, 'ADMIN',  'APPROVED', NOW() - INTERVAL 30 DAY),
(1, 2, 'MEMBER', 'APPROVED', NOW() - INTERVAL 28 DAY),
(1, 3, 'MEMBER', 'APPROVED', NOW() - INTERVAL 27 DAY),
(1, 5, 'MEMBER', 'APPROVED', NOW() - INTERVAL 25 DAY),
(1, 6, 'MEMBER', 'PENDING',  NOW() - INTERVAL 1  DAY);

-- Group 2 – Algorithms Grind
INSERT IGNORE INTO group_members (group_id, user_id, role, status, joined_at) VALUES
(2, 2, 'ADMIN',  'APPROVED', NOW() - INTERVAL 20 DAY),
(2, 1, 'MEMBER', 'APPROVED', NOW() - INTERVAL 19 DAY),
(2, 4, 'MEMBER', 'APPROVED', NOW() - INTERVAL 18 DAY);

-- Group 3 – Calculus Warriors
INSERT IGNORE INTO group_members (group_id, user_id, role, status, joined_at) VALUES
(3, 3, 'ADMIN',  'APPROVED', NOW() - INTERVAL 15 DAY),
(3, 1, 'MEMBER', 'APPROVED', NOW() - INTERVAL 14 DAY),
(3, 5, 'MEMBER', 'APPROVED', NOW() - INTERVAL 13 DAY);

-- Group 4 – SE Project Team Alpha
INSERT IGNORE INTO group_members (group_id, user_id, role, status, joined_at) VALUES
(4, 4, 'ADMIN',  'APPROVED', NOW() - INTERVAL 10 DAY),
(4, 2, 'MEMBER', 'APPROVED', NOW() - INTERVAL 9  DAY);

-- Group 5 – Physics & Math Lab
INSERT IGNORE INTO group_members (group_id, user_id, role, status, joined_at) VALUES
(5, 5, 'ADMIN',  'APPROVED', NOW() - INTERVAL 5  DAY),
(5, 3, 'MEMBER', 'APPROVED', NOW() - INTERVAL 4  DAY),
(5, 1, 'MEMBER', 'APPROVED', NOW() - INTERVAL 3  DAY),
(5, 6, 'MEMBER', 'PENDING',  NOW() - INTERVAL 1  DAY);

-- ---------------------------------------------------------------
-- 7. SESSIONS  (3 past + 3 upcoming; dates relative to today)
-- ---------------------------------------------------------------
INSERT IGNORE INTO sessions
    (id, group_id, title, description,
     session_date, start_time, end_time, duration_days,
     meeting_link, created_by, archived, archived_at) VALUES

-- Past sessions
(1, 1, 'Week 1 – Variables & Loops',
    'Covering chapter 1: variables, data types, and loop structures.',
    CURDATE() - INTERVAL 14 DAY, '18:00:00', '20:00:00', 1,
    'https://meet.example.com/cs101-w1', 1, FALSE, NULL),

(2, 2, 'Arrays & Linked Lists Deep Dive',
    'Practice problems on arrays, singly and doubly linked lists.',
    CURDATE() - INTERVAL 7  DAY, '19:00:00', '21:00:00', 1,
    'https://meet.example.com/algo-arrays', 2, FALSE, NULL),

(3, 3, 'Derivatives – Practice Sprint',
    'Work through 20 differentiation problems from the textbook.',
    CURDATE() - INTERVAL 5  DAY, '17:00:00', '19:00:00', 1,
    'https://meet.example.com/calc-deriv', 3, FALSE, NULL),

-- Upcoming sessions
(4, 1, 'Week 2 – Functions & Recursion',
    'Introduction to functions, scope, and basic recursion.',
    CURDATE() + INTERVAL 2  DAY, '18:00:00', '20:00:00', 1,
    'https://meet.example.com/cs101-w2', 1, FALSE, NULL),

(5, 2, 'Binary Trees & BST',
    'Tree traversals, insertion, deletion in binary search trees.',
    CURDATE() + INTERVAL 4  DAY, '19:00:00', '21:00:00', 1,
    'https://meet.example.com/algo-bst', 2, FALSE, NULL),

(6, 4, 'Sprint Planning – Capstone',
    'Plan user stories and assign tasks for the upcoming sprint.',
    CURDATE() + INTERVAL 6  DAY, '16:00:00', '17:30:00', 1,
    'https://meet.example.com/se-sprint1', 4, FALSE, NULL);

-- ---------------------------------------------------------------
-- 8. SESSION PARTICIPANTS  (past sessions only – realistic)
-- ---------------------------------------------------------------
INSERT IGNORE INTO session_participants (session_id, user_id, joined_at) VALUES
(1, 1, NOW() - INTERVAL 14 DAY),
(1, 2, NOW() - INTERVAL 14 DAY),
(1, 3, NOW() - INTERVAL 14 DAY),
(2, 2, NOW() - INTERVAL 7  DAY),
(2, 1, NOW() - INTERVAL 7  DAY),
(2, 4, NOW() - INTERVAL 7  DAY),
(3, 3, NOW() - INTERVAL 5  DAY),
(3, 1, NOW() - INTERVAL 5  DAY),
(3, 5, NOW() - INTERVAL 5  DAY);

-- ---------------------------------------------------------------
-- 9. SESSION INVITATIONS  (upcoming sessions only)
-- ---------------------------------------------------------------
INSERT IGNORE INTO session_invitations (session_id, user_id, status, invited_at, responded_at) VALUES
(4, 2, 'ACCEPTED', NOW() - INTERVAL 1 DAY, NOW() - INTERVAL 12 HOUR),
(4, 3, 'PENDING',  NOW() - INTERVAL 1 DAY, NULL),
(5, 1, 'ACCEPTED', NOW() - INTERVAL 1 DAY, NOW() - INTERVAL 10 HOUR),
(5, 4, 'PENDING',  NOW(),                  NULL),
(6, 2, 'PENDING',  NOW(),                  NULL);

-- ---------------------------------------------------------------
-- 10. CHAT MESSAGES
-- ---------------------------------------------------------------
INSERT IGNORE INTO chat_messages
    (group_id, sender_id, content, message_type, `timestamp`) VALUES
-- Group 1 – CS101 Study Crew
(1, 1, 'Hey everyone! Ready for this week''s session?',                   'TEXT', NOW() - INTERVAL 3  DAY),
(1, 2, 'Absolutely! I''ve been reviewing loops all morning.',              'TEXT', NOW() - INTERVAL 3  DAY),
(1, 3, 'Same here. Can someone share a good recursion reference?',         'TEXT', NOW() - INTERVAL 2  DAY),
(1, 1, 'Check out https://visualgo.net - great for visualizations.',       'TEXT', NOW() - INTERVAL 2  DAY),
(1, 5, 'Thanks! That site is super helpful.',                              'TEXT', NOW() - INTERVAL 1  DAY),
-- Group 2 – Algorithms Grind
(2, 2, 'Who solved the two-sum problem yet?',                              'TEXT', NOW() - INTERVAL 5  DAY),
(2, 1, 'I did! Used a hash map for O(n).',                                 'TEXT', NOW() - INTERVAL 5  DAY),
(2, 4, 'Nice. I went brute-force O(n^2) first just to understand it.',     'TEXT', NOW() - INTERVAL 4  DAY),
(2, 2, 'Smart approach. Always understand brute force before optimising.', 'TEXT', NOW() - INTERVAL 1  DAY);

-- ---------------------------------------------------------------
-- 11. NOTIFICATIONS
-- ---------------------------------------------------------------
INSERT IGNORE INTO notifications
    (user_id, session_id, type, message, is_read, created_at) VALUES
-- Session reminders
(1, 4, 'REMINDER',   'Reminder: "Week 2 – Functions & Recursion" starts in 2 days.',   FALSE, NOW() - INTERVAL 1  DAY),
(2, 4, 'REMINDER',   'Reminder: "Week 2 – Functions & Recursion" starts in 2 days.',   FALSE, NOW() - INTERVAL 1  DAY),
-- Invitations
(1, 5, 'INVITATION', 'You have been invited to "Binary Trees & BST".',                 FALSE, NOW()),
(4, 5, 'INVITATION', 'You have been invited to "Binary Trees & BST".',                 FALSE, NOW()),
(2, 6, 'INVITATION', 'You have been invited to "Sprint Planning – Capstone".',         FALSE, NOW()),
-- General
(3, NULL, 'GENERAL', 'Welcome to Group Genius! Start by joining a study group.',       TRUE,  NOW() - INTERVAL 10 DAY),
(5, NULL, 'GENERAL', 'New session scheduled in Physics & Math Lab.',                   FALSE, NOW() - INTERVAL 2  DAY),
(6, NULL, 'GENERAL', 'Your join request for "CS101 Study Crew" is pending approval.',  FALSE, NOW() - INTERVAL 1  DAY);

-- ---------------------------------------------------------------
-- 12. RE-ENABLE FK CHECKS
-- ---------------------------------------------------------------
SET FOREIGN_KEY_CHECKS = 1;
