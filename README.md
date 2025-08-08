# SQL-Cricket-Auction-Project
Cricket Player Stats &amp; Auction Database
# 🏏 Cricket Player Auction Database – MySQL Project

## 📌 Overview
This project is a **MySQL database** designed to store, manage, and query cricket player statistics and auction details.  
It demonstrates SQL skills including:
- Database design
- Table creation
- Data insertion
- Complex queries with JOINs, aggregation, and filtering

The dataset is inspired by the **IPL Auction System** and is perfect for demonstrating database concepts in interviews or academic projects.

---

## 📂 Database Structure
**Database Name:** `CricketAuctionDB`

### 1. Teams
| Column     | Type         | Description |
|------------|--------------|-------------|
| team_id    | INT (PK)     | Unique team ID |
| team_name  | VARCHAR(50)  | Name of the team |
| city       | VARCHAR(50)  | City the team belongs to |

### 2. Players
| Column       | Type         | Description |
|--------------|--------------|-------------|
| player_id    | INT (PK)     | Unique player ID |
| player_name  | VARCHAR(50)  | Player's full name |
| role         | VARCHAR(30)  | Player's role (Batsman, Bowler, All-Rounder) |
| country      | VARCHAR(30)  | Country of origin |
| base_price   | DECIMAL      | Base auction price |

### 3. PlayerStats
| Column       | Type         | Description |
|--------------|--------------|-------------|
| stat_id      | INT (PK)     | Unique stats ID |
| player_id    | INT (FK)     | Linked to Players table |
| matches      | INT          | Matches played |
| runs         | INT          | Runs scored |
| wickets      | INT          | Wickets taken |
| strike_rate  | DECIMAL      | Batting strike rate |
| economy      | DECIMAL      | Bowling economy rate |

### 4. Auctions
| Column       | Type         | Description |
|--------------|--------------|-------------|
| auction_id   | INT (PK)     | Unique auction ID |
| player_id    | INT (FK)     | Linked to Players table |
| team_id      | INT (FK)     | Linked to Teams table |
| sold_price   | DECIMAL      | Final sold price |
| auction_year | YEAR         | Auction year |

---

## 🛠 Features
- **Create & Manage Database** – Table creation with primary & foreign keys
- **Insert Sample Data** – Player, team, and auction details
- **Run Queries** – Filtering, joining, and aggregating data
- **Real-World Use Case** – Simulates an IPL-style player auction

---

## 📊 Example Queries
1️⃣ List all players with their team and sold price  
```sql
SELECT p.player_name, t.team_name, a.sold_price
FROM Players p
JOIN Auctions a ON p.player_id = a.player_id
JOIN Teams t ON a.team_id = t.team_id;
