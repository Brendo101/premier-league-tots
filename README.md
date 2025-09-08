# ⚽ Premier League 2024–25: Data-Driven Team of the Season (TOTS)

## 🧠 What is this?
A football analytics project to build a **data-driven Team of the Season (TOTS)** for the Premier League 2024–25.  
Unlike media or fan-voted TOTS, this selection is based **entirely on performance metrics** (goals, assists, defensive actions, goalkeeping stats, etc.), normalized and weighted per position.

---

## 🎯 Project Goal
- Define **stat bundles per position** (GK, DEF, MID, FW).  
- Normalize player stats (min–max scaling in SQL).  
- Apply **custom weightings** to reflect positional responsibilities.  
- Rank players and generate a **TOTS XI**.  
- Compare results against the official/voted TOTS.  

---

## 🔄 Current Status
- ✅ **Database Setup**: Player stats scraped from FBref stored in SQL Server.  
- ✅ **Python Loader**: Python script built to insert scraped data into the database.  
- ✅ **Initial Queries**: Basic SELECT queries to pull raw stats.  
- ✅ **Normalization**: Using SQL `OVER()` for min–max scaling.  
- 🔲 **Position Bundles**: Finalize metrics used per position.  
- 🔲 **Weighting System**: Assign stat weights for GK, DEF, MID, FW.  
- 🔲 **Composite Scores**: SQL queries to calculate ranking scores.  
- 🔲 **Filtering**: Exclude players with too few minutes played.  
- 🔲 **Output & Viz**: Export results for visualization (Power BI, Python, or Excel).  
- 🔲 **Comparison**: Compare with official TOTS (and pundit selections).  

---

## 🧮 Methodology

The project follows a clear SQL-first workflow to move from raw player stats to a final Team of the Season:

### 1. Data Collection & Storage
- Scrape **Premier League 2024–25** player and team data from FBref.
- Store raw data in **SQL Server** via a custom Python loader (`insert_data.py`).

### 2. Data Cleaning
- Standardize column names and data types (e.g., goals as INT, xG as FLOAT).
- Remove duplicates and check for missing values.
- Add a **TOTS flag** column for players included in the official TOTS.

### 3. Filtering
- Exclude players with **too few minutes** (e.g., < 900 minutes played).
- Use `WHERE Minutes >= 900` in queries.

### 4. Normalization
- Apply **min–max scaling** to bring all stats to the same scale (0–1).
- Example:
  ```sql
  (stat - MIN(stat) OVER()) / (MAX(stat) OVER() - MIN(stat) OVER())

