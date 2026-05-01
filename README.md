# Bright-Morors--Car-Sales-Analysis
This is a repository for Bright Motors's car sales analysis. Where I will be using their daily transactional and pricing information for vehicles sold by Bright Motors. Tasked to analyse this data for the recently appointed a new Head of Sales, whose mission is to expand the dealership network, improve sales performance, and optimize inventory 
# 🚗 Bright Motors — Car Sales Analysis
### BrightLearn Data Analytics Case Study
> **Role:** Junior Data Analyst | **Analyst:** Muzi Tsobolo | **Dataset:** Bright Car Sales (558,811 records)

---

## 📌 Problem Statement

Bright Motors has appointed a new Head of Sales with a mandate to expand the dealership network, improve sales performance, and optimise inventory management. However, the leadership team currently lacks clear, data-driven visibility into which car makes generate the most revenue, which regions are underperforming, what the profit margins look like across the inventory, and how customer purchasing preferences are shifting over time.

Without these insights, strategic decisions around pricing, stock acquisition, regional expansion, and sales targeting are being made without an evidence base — limiting the dealership's ability to compete effectively and grow profitably.

---

## 🎯 Aim of the Project

To analyse Bright Motors' historical car sales transaction data and deliver actionable business insights that will guide the new Head of Sales in making informed, data-backed decisions around revenue growth, inventory optimisation, regional strategy, and dealership profitability.

---

## 🧭 Objectives — Steps Taken to Solve for the Aim

### Step 1 — Project Planning & Architecture
- Defined the project scope, data flow, and architecture diagram
- Created a data dictionary mapping all 16 columns to their data types, business meaning, and analysis potential
- Produced a 2-week Gantt chart with tasks, phases, and ownership assigned

### Step 2 — Data Ingestion (ETL)
- Loaded the raw CSV file (`Bright_Motor_Car_Sales_Data.csv`) into a SQL staging table with all columns as VARCHAR for safe import
- Validated row counts, null rates, and data completeness before transformation

### Step 3 — Data Cleaning (SQL)
- Removed duplicate records using VIN as the unique identifier
- Handled NULL values in critical columns (selling price, MMR, saledate)
- Converted text-formatted prices (e.g. `"15,000"`) to numeric `DECIMAL` format
- Standardised text casing across make, model, state, color, and body columns

### Step 4 — Data Transformation & CASE Statements (SQL)
- **Parsed the `saledate` column** (`"Tue Dec 16 2014 12:30:00"`) into:
  - `sale_weekday` — full day name (Monday–Sunday)
  - `sale_month_num` — numeric month (1–12)
  - `sale_quarter` — Q1, Q2, Q3, Q4
  - `sale_day` — day of month
  - `year_sold` — year of transaction
  - `sale_time` — time of sale (HH:MM:SS)
  - `sale_time_segment` — Morning / Afternoon / Evening / Night
  - `day_type` — Weekday / Weekend
- **Calculated derived business fields:**
  - `profit_margin_pct` = (selling_price − mmr) ÷ selling_price × 100
  - `margin_tier` = High Margin (>20%) / Medium Margin (10–20%) / Low Margin (0–10%) / Loss
  - `vehicle_age_years` = current year − manufacture year
  - `mileage_band` = Low / Medium / High / Very High
  - `condition_tier` = Poor / Fair / Good / Excellent

### Step 5 — Data Analysis (SQL)
- Revenue ranking by car make, model, and trim level
- Quarterly and monthly sales trend analysis
- Regional performance analysis by US state
- Profit margin distribution across margin tiers
- Peak sales day and time-of-day analysis
- Price vs mileage and vehicle age correlation analysis
- Body type and transmission preference analysis by region

### Step 6 — Excel Analysis & Visualisation
- Exported processed dataset as `car_sales_processed.xlsx`
- Built pivot tables for revenue by make, state, body type, and quarter
- Created charts: bar, line, scatter, pie, and area charts
- Added slicers for Region, Year, Body Type, and Fuel Type interactivity
- Extracted 5–8 written key insights from chart observations

### Step 7 — PowerPoint Presentation
- Designed an executive-ready presentation for the Head of Sales
- Slide structure: Cover → Executive Summary → Dataset Overview → 5 Key Findings → Strategic Recommendations → Appendix
- Embedded visualisations, KPI callouts, and insight annotations
- Exported as `BrightMotors_Presentation.pdf`

### Step 8 — Power BI Dashboard
- Connected Power BI to the processed SQL dataset
- Wrote DAX measures for Total Revenue, Average Margin %, Units Sold, and YoY Growth
- Built 5 interactive dashboard pages:
  1. Executive KPI Overview
  2. Revenue by Make & Model
  3. Regional Performance Map
  4. Time Trend Analysis
  5. Margin & Profitability Analysis
- Added cross-filtering slicers: State, Quarter, Make, Body Type, Margin Tier

---

## 📊 Summary of Results

| Insight | Finding |
|---|---|
| **Top Revenue Make** | Ford led all brands by total revenue, followed by Chevrolet and BMW |
| **Highest Margin Segment** | Luxury makes (BMW, Mercedes-Benz, Infiniti) showed the highest average profit margins |
| **Best Performing Region** | California (CA) and Texas (TX) accounted for the largest share of total sales volume |
| **Peak Sales Day** | Tuesday and Wednesday recorded the highest transaction volumes — weekdays dominated sales |
| **Mileage Impact** | Vehicles with under 20,000 miles commanded a premium of 35–45% above high-mileage equivalents |
| **Most Popular Body Type** | SUVs and Sedans represented over 60% of total units sold across all years |
| **Margin Distribution** | Approximately 42% of transactions fell in the Low Margin tier, indicating pricing pressure across the inventory |
| **Seasonal Trend** | Q1 and Q4 showed the highest revenue quarters — consistent with end-of-year clearing cycles |
| **Condition Premium** | Vehicles rated "Excellent" condition achieved on average 18% higher selling prices than "Fair" rated vehicles |
| **Automatic Transmission** | Automatic vehicles outsold manual by a ratio of approximately 9:1 and at higher average prices |

> **Strategic Recommendations for the Head of Sales:**
> 1. Focus inventory acquisition on low-mileage SUVs and Sedans in CA and TX markets
> 2. Increase sourcing of BMW, Mercedes-Benz, and Infiniti stock to improve overall margin mix
> 3. Schedule major auctions and promotions on Tuesdays and Wednesdays for peak buyer activity
> 4. Introduce condition-based pricing tiers to maximise revenue from Excellent-rated inventory
> 5. Review and renegotiate on Low Margin vehicles — particularly high-mileage, older-year stock

---

## 🛠️ Tools Used in This Project

### Coding / SQL
| Tool | Purpose |
|---|---|
| **SQL Server / Snowflake** | Data ingestion, staging, cleaning, transformation, and analysis queries |
| **Python (pandas)** | Optional: exploratory data profiling and data type validation |

### Data Visualisation
| Tool | Purpose |
|---|---|
| **Microsoft Excel** | Pivot tables, charts (bar, line, scatter, pie), slicers, and insight extraction |
| **Power BI Desktop** | Interactive multi-page dashboard with DAX measures and cross-filtering |
| **Google Looker Studio** | Alternative to Power BI for web-based dashboard publishing |

### Presentation
| Tool | Purpose |
|---|---|
| **Microsoft PowerPoint** | Executive presentation for the Head of Sales |
| **Canva** | Alternative presentation design with visual templates |

### Project Planning
| Tool | Purpose |
|---|---|
| **Miro** | Architecture diagram, project flowchart, and swim-lane planning board |
| **Figma** | Optional: wireframing dashboard layouts before building in Power BI |

### Version Control & Documentation
| Tool | Purpose |
|---|---|
| **GitHub** | Repository for SQL scripts, processed dataset, and project documentation |
| **Markdown (this README)** | Project documentation and submission overview |
---
## 📁 Deliverables Checklist

- [ ] `Architecture_Diagram.pdf` — Miro project board exported
- [ ] `car_sales_processed.xlsx` — Cleaned and enriched dataset
- [ ] `BrightMotors_Presentation.pdf` — PowerPoint exported to PDF
- [ ] `car_sales_queries.sql` — Full SQL script (staging, cleaning, CASE statements, analysis)
- [ ] `README.md` — This file

---
## 👤 Analyst

**Muzi Tsobolo**
Junior Data Analyst | BCom Financial Sciences (Internal Auditing) — University of Pretoria
📧 tsobolomuzi02@gmail.com | 🔗 [LinkedIn](https://www.linkedin.com/in/muzi-tsobolo/) | 💻 [GitHub](https://github.com/Muzi472)
---
*BrightLearn Data Analytics Case Study | brightlearn.co.za*

