DROP DATABASE IF EXISTS game_store_db;
CREATE DATABASE game_store_db;
USE game_store_db;


-- Create tables
CREATE TABLE IF NOT EXISTS user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_username VARCHAR(20) NOT NULL UNIQUE,
    user_email VARCHAR(30) UNIQUE,
    user_phone CHAR(10),
    user_role VARCHAR(10) NOT NULL,
    user_password VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS game (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    game_title VARCHAR(50) NOT NULL,
    game_developer VARCHAR(30) NOT NULL,
    game_genre VARCHAR(20) NOT NULL,
    game_sizeGB FLOAT(1) NOT NULL,
    game_priceUSD FLOAT(2) NOT NULL
);

CREATE TABLE IF NOT EXISTS transaction (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_user_id INT NOT NULL,
    transaction_date DATE NOT NULL,
    FOREIGN KEY (transaction_user_id) REFERENCES user(user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS purchase_item (
    purchase_item_id INT AUTO_INCREMENT PRIMARY KEY,
    purchase_item_game_id INT NOT NULL,
    purchase_item_transaction_id INT NOT NULL,
    FOREIGN KEY (purchase_item_game_id) REFERENCES game(game_id) ON DELETE CASCADE,
    FOREIGN KEY (purchase_item_transaction_id) REFERENCES transaction(transaction_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS review (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    review_user_id INT NOT NULL,
    review_game_id INT NOT NULL,
    review_score BOOL NOT NULL,
    review_content VARCHAR(500),
    FOREIGN KEY (review_user_id) REFERENCES user(user_id) ON DELETE CASCADE,
    FOREIGN KEY (review_game_id) REFERENCES game(game_id) ON DELETE CASCADE
);


-- Insert example data
INSERT INTO user (user_username, user_role, user_password) VALUES
('EldenLord22', 'customer', 'password000'),
('FPSgamer900', 'customer', 'MyPass123');

INSERT INTO game (game_title, game_developer, game_genre, game_sizeGB, game_priceUSD) VALUES
('Portal 2', 'Valve', 'Puzzle', 11.88, 10.00),
('Undertale', 'Toby Fox', 'RPG', 0.15, 10.00),
('Baldur''s Gate 3', 'Larian Studios', 'RPG', 147.22, 60.00);

INSERT INTO transaction (transaction_user_id, transaction_date, transaction_amt) VALUES
(1, '2024-10-18', 70),
(2, '2025-01-01', 20);

INSERT INTO purchase_item (purchase_item_game_id, purchase_item_transaction_id) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 2);

INSERT INTO review (review_user_id, review_game_id, review_score, review_content) VALUES
(1, 2, 1, 'I made pasta with a cool skeleton and ate burgers with his brother. 10/10.'),
(2, 1, 0, 'Made too many portals and got dizzy. Promptly threw up. I think I''m done with this game.'),
(1, 3, 1, 'im the most powerful wizard that has ever existed.');