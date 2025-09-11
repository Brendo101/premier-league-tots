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
- ✅ **Position Bundles**: Finalize metrics used per position.  
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

  ---

## 📊 Metrics Analysed per Position

| Position       | Key Metrics                                                                 |
|----------------|------------------------------------------------------------------------------|
| 🧤 Goalkeepers | Saves, save %, goals prevented (vs xG), pass completion, long distribution (40+ yards), average pass length, crosses faced & stopped, defensive actions outside box, goals conceded (OG not heavily weighted) |
| 🛡️ Defenders  | Tackles won, interceptions, clearances, blocks, aerial duels won, pass completion, progressive passes, fouls, errors leading to shots/goals |
| 🎩 Midfielders | Pass completion, progressive passes, passes into final third, key passes, assists, xA, tackles, interceptions, recoveries, goals, shots on target, dribbles completed |
| 🎯 Forwards   | Goals, non-penalty goals, xG, conversion rate, shots on target %, progressive carries, assists, xA, key passes, dribbles, pressures, light defensive contribution |

---

### 🧤 Goalkeepers  
Evaluated on **shot-stopping, distribution, and command of their area**. Metrics like saves, save %, and goals prevented measure shot-stopping ability, while passing and distribution metrics capture modern sweeper-keeper responsibilities.  

### 🛡️ Defenders  
Judged on **defensive solidity and ball progression**. Tackles, interceptions, and aerial duels highlight defensive strength, while progressive passes and pass accuracy show their role in buildup play.  

### 🎩 Midfielders  
Assessed on **all-around influence** in both attack and defense. Passing metrics (progressive, key, final third) measure creativity, while tackles, interceptions, and recoveries track defensive work. Goals and assists provide an extra dimension for more advanced midfielders.  

### 🎯 Forwards  
Ranked by **scoring efficiency and attacking contribution**. Goals, xG, and conversion rates measure finishing, while xA, key passes, and dribbles capture creativity. Pressures and defensive work are included but weighted lightly.  

