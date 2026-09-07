# Technology Sector Financial Performance & Investment Analysis

An end-to-end financial analytics project analysing the quarterly financial
performance of nine major technology companies from 2016–2025.

The project combines PostgreSQL, SQL, Power BI and DAX to transform financial
statement data into an interactive financial performance, peer benchmarking
and historical investment analytics dashboard.

The analysis evaluates growth, profitability, operational efficiency, capital
structure and asset utilisation before combining selected indicators into a
0–100 comparative investment scoring framework.

![Investment Insights](dashboard_screenshots/investment_insights.png)

---

## Project Summary

| Area | Details |
|---|---|
| Companies | 9 major technology companies |
| Period | 2016–2025 |
| Frequency | Quarterly |
| Financial Data | Income Statement & Balance Sheet |
| Database | PostgreSQL |
| Data Transformation | SQL |
| Visualisation | Microsoft Power BI |
| Analytical Calculations | DAX |
| Investment Score | 0–100 |
| Dashboard Pages | 4 |

---

## Business Objective

Large technology companies can differ significantly in their growth,
profitability, operating efficiency, capital structure and market performance.

The objective of this project was to develop a structured analytical framework
for comparing major technology companies across multiple financial dimensions.

The analysis focuses on:

- Revenue and earnings growth
- Profitability
- Operational efficiency
- Asset utilisation
- Capital structure
- R&D investment
- Market capitalisation growth

These indicators were then used to develop a historical, peer-relative
investment scoring framework.

---

## Companies Analysed

The analysis covers nine major technology companies:

- Amazon
- Apple
- Google
- Meta
- Microsoft
- Netflix
- Nvidia
- Salesforce
- Tesla

The financial analysis uses quarterly observations covering the period
2016–2025.

---

# Data

The project uses financial statement data covering:

- Income statement information
- Balance sheet information
- Revenue
- Cost of sales
- Gross profit
- Selling, General & Administrative expenses
- Research & Development expenditure
- Operating profit
- Net income
- Total assets
- Current liabilities
- Total liabilities
- Market capitalisation

The raw datasets are stored in the `data/` directory:

```text
data/
├── income_statement.csv
└── balance_sheet.csv
