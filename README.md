# India-US Relations Strategic Intelligence Analysis (2017–2025)

## Project Overview
This project provides a data-driven strategic briefing analyzing over 100 official diplomatic statements, global observations, and geopolitical rhetoric between 2017 and 2025. Using SQL, the analysis maps sentiment volatility, tracks shifts from personality-driven diplomacy to policy-driven institutional frameworks, and measures global reactions (e.g., the Post-Quad perception shift).

## Repository Structure
- `/data`: Contains raw datasets (`US_comments.csv`, `indian_comments.csv`, `Global_comments.csv`).
- `/scripts`: Contains the `research_assignment.sql` data cleaning, transformations, and analytical queries.
- `/presentation`: Contains the final executive summary PDF briefing.

## Core Analytics & SQL Techniques Used
- **Data Cleaning & Type Casting:** Converting date strings using `STR_TO_DATE()` and adjusting table schemas safely (`SET sql_safe_updates=0`).
- **Window Functions:** Utilizing `SUM(...) OVER (PARTITION BY ...)` to calculate evolving percentage distributions of diplomatic sentiment across presidential eras.
- **Aggregations & Segregations:** Identifying sentiment gaps between government officials and opposition parties.
- **Cross-Country Benchmarking:** Tracking regional competitor counter-messaging (China, Pakistan, Russia) during major bilateral highs like the 2023 State Visit.

## Key Insights Summary
- **The Core Shift:** The bilateral relationship successfully transitioned from a leader-centric, transactional focus in 2017 to an institutionalized bedrock centered on defense, space, and semiconductor supply chains by 2025.
- **Geopolitical Alignment:** Despite trade friction and tariff disputes, regional security demands ensure structural resilience and long-term alignment across the Indo-Pacific.

## How to Run the Queries
1. Open MySQL Workbench or any preferred SQL IDE.
2. Run the initial data setup and transformation queries found in `scripts/research_assignment.sql` to clean the data.
3. Execute the core analytical queries to reproduce the sentiment distribution metrics.
