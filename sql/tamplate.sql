-- Active: 1690893833419@@127.0.0.1@5432@restaurant

DROP TABLE users;

DROP TABLE recipe;

DROP TABLE category;

CREATE TABLE
    recipe (
        id SERIAL PRIMARY KEY,
        title VARCHAR(255) NOT NULL,
        ingredients TEXT NOT NULL,
        image VARCHAR(255),
        category_id INT NOT NULL,
        users_id INT NOT NULL
    );

ALTER TABLE recipe ADD COLUMN created_at TIMESTAMP DEFAULT NOW();

CREATE TABLE
    category(
        id SERIAL PRIMARY KEY,
        name VARCHAR(255) NOT NULL
    );

ALTER TABLE recipe
ADD
    FOREIGN KEY (category_id) REFERENCES category(id);

CREATE TABLE
    users(
        id SERIAL PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        email VARCHAR(255) NOT NULL,
        password VARCHAR(255) NOT NULL,
        photo VARCHAR(255),
        created_at TIMESTAMP DEFAULT NOW()
    );

ALTER TABLE recipe ADD FOREIGN KEY (users_id) REFERENCES users(id);

SELECT * FROM recipe;

SELECT * FROM category;

SELECT * FROM users;

-- ISI TABLE --

INSERT INTO
    users (name, email, password, photo)
VALUES (
        'admin',
        'admin@gmail.com',
        '123456',
        'https://placehold.co/600x400'
    ), (
        'guest',
        'guest@gmail.com',
        '123456',
        'https://placehold.co/600x400'
    );

INSERT INTO category(name)
VALUES ('main course'), ('dessert'), ('appetizer');

INSERT INTO
    recipe (
        title,
        ingredients,
        image,
        category_id,
        users_id
    )
VALUES (
        'nasi goreng',
        'nasi, telur, sambar',
        'https://placehold.co/600x400',
        1,
        2
    );

-- ALTER TABLE recipe RENAME COLUMN user_id TO users_id;

SELECT
    recipe.id,
    recipe.title,
    recipe.ingredients,
    recipe.image,
    category.name AS category
FROM recipe
    JOIN category ON recipe.category_id = category.id
ORDER BY title DESC
OFFSET 0
LIMIT 5;

-- Test login ---

SELECT * FROM users WHERE email='guest@gmail.com';

-- edit PASSWORD

UPDATE users
SET
    password = '$argon2id$v=19$m=65536,t=3,p=4$J6+YWFQOHBLfcVdNu5tntA$50QnlBhSy5bElJ59pYcJZpe6O0Isl4YSa56bt03lXv4'
WHERE email = 'guest@gmail.com';

-- TRUNCATE TABLE category;

-- TRUNCATE TABLE users;

-- TRUNCATE TABLE recipe;

-- DELETE FROM users WHERE id = 6;

-- SELECT * FROM users;