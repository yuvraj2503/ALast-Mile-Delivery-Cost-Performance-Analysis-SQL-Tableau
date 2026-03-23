📦 Last Mile Delivery Cost & Performance Analysis
📊 Overview

This project simulates a real-world Last Mile (LM) analytics workflow, focusing on Cost per Delivery (CPD), payout structures, and delivery partner performance across 1P and 3P delivery channels.

The objective is to replicate how a business analyst would build reporting systems, analyze cost drivers, and generate insights for operational and pricing decisions in a quick-commerce delivery network.

🎯 Business Problem

In last-mile logistics, controlling delivery cost while maintaining service levels is critical.

Key questions addressed:

What drives Cost per Delivery (CPD)?
How do 1P vs 3P delivery models impact cost?
What is the effect of traffic and peak demand on payouts?
Where do operational inefficiencies exist?
🧠 Approach
1. Data Preparation & Cleaning
Processed a dataset of 40,000+ delivery records
Removed invalid geolocation entries and outliers
Ensured consistency in time, location, and operational fields
2. Feature Engineering
Calculated delivery distance (km) using latitude-longitude coordinates
Created peak vs non-peak classification based on order time
Segmented deliveries into 1P (in-house) and 3P (third-party)
Generated delivery time buckets for operational analysis
3. Cost Modeling (Rate Card Simulation)

Designed a payout logic to simulate real-world rate cards:

Base payout + distance-based cost
Peak hour surge multipliers
Traffic-based adjustments

This enabled computation of:

Cost per Delivery (CPD)
Cost variation across operational scenarios
4. Data Aggregation & Analysis (SQL)
Built SQL queries to:
Aggregate delivery-level data
Compute KPIs (CPD, cost/km, average payout)
Segment cost across traffic, peak hours, and delivery type
Performed grouped analysis and anomaly checks
5. Dashboard Development (Tableau)

Developed an interactive dashboard to monitor:

CPD across 1P vs 3P channels
Cost impact of traffic conditions and peak hours
Relationship between distance and payout
Area-wise and time-based cost patterns

The dashboard enables quick identification of cost drivers and performance trends.
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/244f3ef8-4ad2-4948-8666-2468b57d3948" />

📈 Key Insights
3P deliveries show higher CPD due to increased per-km payout structures
Traffic congestion significantly increases delivery cost
Peak-hour operations lead to higher payouts due to surge multipliers
Delivery cost shows a strong linear relationship with distance
Longer delivery durations indicate operational inefficiencies impacting cost
🛠️ Tools & Technologies
SQL Server – Data extraction, aggregation, KPI computation
Tableau – Dashboarding and visualization
Excel – Data validation and preprocessing
📌 Key Metrics
Cost per Delivery (CPD)
Average Payout
Cost per KM
Delivery Time Buckets
Traffic-based cost segmentation
💡 Business Impact

This project demonstrates how structured data analysis can:

Identify cost drivers in last-mile delivery
Support pricing and payout optimization
Improve operational decision-making
Enable data-driven capacity and cost planning


📎 Project Assets

Tableau Dashboard: https://public.tableau.com/app/profile/yuvraj.sharma2003/viz/LastMileDeliveryCostPerformanceAnalysisSQLTableau/Dashboard1

SQL Scripts: https://github.com/yuvraj2503/ALast-Mile-Delivery-Cost-Performance-Analysis-SQL-Tableau/tree/main

Dataset: https://www.kaggle.com/datasets/sujalsuthar/amazon-delivery-dataset?resource=download
