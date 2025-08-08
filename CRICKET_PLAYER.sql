-- Create Database
CREATE DATABASE CricketAuctionDB;
USE CricketAuctionDB;

-- Create Tables
CREATE TABLE Teams (
    team_id INT PRIMARY KEY AUTO_INCREMENT,
    team_name VARCHAR(50) NOT NULL,
    city VARCHAR(50)
);

CREATE TABLE Players (
    player_id INT PRIMARY KEY AUTO_INCREMENT,
    player_name VARCHAR(50) NOT NULL,
    role VARCHAR(30),
    country VARCHAR(30),
    base_price DECIMAL(10,2)
);

CREATE TABLE PlayerStats (
    stat_id INT PRIMARY KEY AUTO_INCREMENT,
    player_id INT,
    matches INT,
    runs INT,
    wickets INT,
    strike_rate DECIMAL(5,2),
    economy DECIMAL(4,2),
    FOREIGN KEY (player_id) REFERENCES Players(player_id)
);

CREATE TABLE Auctions (
    auction_id INT PRIMARY KEY AUTO_INCREMENT,
    player_id INT,
    team_id INT,
    sold_price DECIMAL(10,2),
    auction_year YEAR,
    FOREIGN KEY (player_id) REFERENCES Players(player_id),
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);

-- Insert Sample Teams
INSERT INTO Teams (team_name, city) VALUES
('Mumbai Indians', 'Mumbai'),
('Chennai Super Kings', 'Chennai'),
('Royal Challengers Bangalore', 'Bangalore');

-- Insert Sample Players
INSERT INTO Players (player_name, role, country, base_price) VALUES
('Virat Kohli', 'Batsman', 'India', 2000000),
('Jasprit Bumrah', 'Bowler', 'India', 1500000),
('Glenn Maxwell', 'All-Rounder', 'Australia', 1700000),
('David Warner', 'Batsman', 'Australia', 1600000);

-- Insert Player Stats
INSERT INTO PlayerStats (player_id, matches, runs, wickets, strike_rate, economy) VALUES
(1, 230, 11300, 4, 130.25, 6.50),
(2, 120, 85, 180, 70.15, 7.10),
(3, 150, 3500, 50, 145.40, 8.20),
(4, 140, 5600, 5, 138.75, 7.50);

-- Insert Auctions
INSERT INTO Auctions (player_id, team_id, sold_price, auction_year) VALUES
(1, 3, 2500000, 2024),
(2, 1, 2000000, 2024),
(3, 3, 1900000, 2024),
(4, 2, 1800000, 2024);

-- Sample Queries

-- 1. List all players with their team and sold price
SELECT p.player_name, t.team_name, a.sold_price
FROM Players p
JOIN Auctions a ON p.player_id = a.player_id
JOIN Teams t ON a.team_id = t.team_id;

-- 2. Find top 2 expensive players in 2024
SELECT p.player_name, a.sold_price
FROM Players p
JOIN Auctions a ON p.player_id = a.player_id
WHERE a.auction_year = 2024
ORDER BY a.sold_price DESC
LIMIT 2;

-- 3. Average strike rate of all batsmen
SELECT AVG(strike_rate) AS avg_strike_rate
FROM PlayerStats ps
JOIN Players p ON ps.player_id = p.player_id
WHERE p.role = 'Batsman';

-- 4. Players with strike rate above 135 and economy below 8
SELECT p.player_name, ps.strike_rate, ps.economy
FROM PlayerStats ps
JOIN Players p ON ps.player_id = p.player_id
WHERE ps.strike_rate > 135 AND ps.economy < 8;

-- 5. Total auction spending by each team
SELECT t.team_name, SUM(a.sold_price) AS total_spent
FROM Auctions a
JOIN Teams t ON a.team_id = t.team_id
GROUP BY t.team_name
ORDER BY total_spent DESC;
