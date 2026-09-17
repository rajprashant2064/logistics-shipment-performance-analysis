# Logistics & Shipment Performance Analysis

![Power BI Dashboard Preview](PowerBI/dashboard_preview.png)

## Project Overview

This project is a complete end-to-end Data Analytics portfolio project based on a logistics and freight-forwarding business scenario.

The project demonstrates how shipment data can be processed, cleaned, analyzed and transformed into business insights using:

- Excel
- Python
- SQL / MySQL
- Power BI

The analysis focuses on shipment volume, shipment value, weight, transportation modes, delivery status, delays, delay reasons, routes and destinations.

## Important Dataset Disclaimer

**The dataset included in this repository is NOT company data from A&D Global Freight Pvt. Ltd.**

It is a **synthetic/reconstructed dataset created for portfolio, learning and interview-practice purposes**. It was designed to represent realistic logistics and shipment records while avoiding the use or disclosure of confidential company information.

The company name is used only to provide a realistic business context for the analysis.

Therefore, the numerical results and records shown in this project should not be interpreted as actual operational, financial or performance data of A&D Global Freight Pvt. Ltd.

## Business Problem

A logistics company handles shipments across multiple origins, destinations, transportation modes and product categories.

Large operational datasets can make it difficult to quickly identify:

- Shipment volume trends
- Delayed shipments
- Delay reasons
- Transportation mode performance
- High-volume destinations
- High-value shipments
- Shipment status distribution
- Routes with higher average delays

The objective of this project is to transform raw shipment data into a structured analytical dataset and an interactive Power BI dashboard that makes these patterns easier to understand.

## Project Objectives

1. Profile the raw shipment dataset.
2. Identify missing values, duplicates and invalid records.
3. Clean and validate the data using Python.
4. Perform exploratory data analysis.
5. Analyze the dataset using SQL and MySQL.
6. Create calculated fields required for analysis.
7. Build an interactive Power BI dashboard.
8. Identify operational patterns and potential areas for investigation.
9. Present the complete workflow as a Data Analyst portfolio project.

## Dataset

The dataset contains **12,000 shipment records** and initially contains 16 operational columns.

Important fields include:

- `shipment_id`
- `date`
- `origin`
- `destination`
- `mode`
- `hs_code`
- `product_description`
- `weight_kg`
- `value_usd`
- `status`
- `bill_of_lading`
- `shipper`
- `consignee`
- `remarks`
- `Delay_Time(hrs)`
- `Delay_Reason`

After the Python cleaning and feature-engineering stage, the analytical dataset contains 22 columns.

Additional analytical fields include:

- `year`
- `month`
- `month_number`
- `quarter`
- `delay_flag`
- `delay_days`

## Project Workflow

```text
Raw Shipment Data
        ↓
Data Profiling
        ↓
Data Quality Analysis
        ↓
Data Cleaning & Validation
        ↓
Exploratory Data Analysis
        ↓
SQL Analysis
        ↓
Power BI Data Model & Measures
        ↓
Interactive Dashboard
        ↓
Business Insights
```

## 1. Data Profiling — Python

The first step was to understand the structure and quality of the raw data.

Python was used to inspect:

- Number of rows and columns
- Column names
- Data types
- Missing values
- Duplicate rows
- Duplicate shipment IDs
- Numerical distributions
- Unique categories
- Date range

Script:

`Python/data_profiling.py`

## 2. Data Quality Analysis — Python

The next step was to investigate whether the raw data contained quality issues.

The analysis checked:

- Missing shipment values
- Missing weights
- Invalid weight values
- Invalid shipment values
- Negative delay values
- Delay statistics by transportation mode
- Delay statistics by shipment status
- Major origins and destinations
- Frequently occurring products
- High-value shipments
- High-delay shipments

Script:

`Python/data_quality.py`

## 3. Data Cleaning — Python

Pandas was used to clean and prepare the dataset for analysis.

The cleaning process included:

- Converting dates to datetime
- Handling missing HS codes
- Handling missing weights
- Handling missing shipment values
- Filling missing remarks
- Handling missing delay reasons
- Removing unnecessary whitespace
- Converting numerical fields to numeric types
- Removing duplicate rows
- Removing duplicate shipment IDs
- Filtering invalid weights and values
- Filtering negative delay values

The following analytical fields were also created:

- Year
- Month
- Month Number
- Quarter
- Delay Flag
- Delay Days

Script:

`Python/data_cleaning.py`

## 4. Data Validation — Python

After cleaning, the dataset was validated again.

Validation included:

- Row and column count
- Duplicate checks
- Missing-value checks
- Date validation
- Weight validation
- Shipment-value validation
- Delay validation
- Delay-flag validation
- Status distribution
- Transportation-mode distribution
- Delay-reason distribution
- Year and quarter distribution

Script:

`Python/data_validation.py`

## 5. Exploratory Data Analysis — Python

Exploratory analysis was performed to understand operational patterns in the dataset.

The analysis covered:

- Overall shipment KPIs
- Shipment volume by year
- Shipment volume by month
- Shipment volume by transport mode
- Shipment value by transport mode
- Delay rate by transport mode
- Average delay by transport mode
- Delay rate by shipment status
- Average delay by shipment status
- Delay reasons
- Total delay hours by reason
- Top origins
- Top destinations
- High-volume routes
- Route-level delay analysis
- Top products by shipment count
- Top products by shipment value
- High-value delayed shipments
- Year-level trends

Script:

`Python/eda.py`

## 6. SQL Analysis

MySQL was used to perform structured business analysis on the shipment dataset.

SQL analysis was organized into different levels:

### Basic Analysis

Examples include:

- Viewing shipment records
- Counting total shipments
- Checking date ranges
- Grouping shipments by transportation mode

File:

`SQL/basic_analysis.sql`

### Intermediate Analysis

The analysis was extended using:

- Aggregations
- `GROUP BY`
- `ORDER BY`
- Filtering
- Business-oriented summaries
- Shipment and delay analysis

File:

`SQL/intermediate_analysis.sql`

### Advanced Analysis

More detailed analysis included:

- Route analysis
- Delay analysis
- Ranking
- Window functions
- CTE-based analysis
- Business KPI calculations

File:

`SQL/advance_analysis.sql`

### Logistics Analysis

Business-focused logistics queries were also created for shipment performance and operational analysis.

File:

`SQL/logistics_analysis.sql`

### SQL Data Validation

Data-quality checks were also performed in SQL.

File:

`SQL/data_validation.sql`

## 7. Power BI Dashboard

The final analytical layer was created in Microsoft Power BI.

The dashboard contains:

### KPI Cards

- Total Shipments
- Total Shipment Value
- Total Weight
- Delayed Shipments
- Delay Rate

### Interactive Filters

- Year
- Transport Mode
- Shipment Status

### Visualizations

- Monthly Shipment Volume Trend
- Shipments by Transport Mode
- Delay Rate by Transport Mode
- Top Destinations by Shipments
- Delayed Shipments by Reason
- Average Delay by Shipment Status
- Shipment Status Distribution

The dashboard was designed with a clean professional layout and interactive filtering.

Power BI file:

`PowerBI/AD_Global_Freight_Dashboard.pbix`

## Dashboard Preview

The repository includes a dashboard screenshot so visitors can see the design directly on GitHub.

For the **fully interactive dashboard**, download the `.pbix` file and open it using Power BI Desktop.

> GitHub does not directly run `.pbix` files as an interactive Power BI report. An online interactive version requires publishing the report to a Power BI-supported workspace/service and sharing an appropriate report link.

## Key Project KPIs

Based on the reconstructed synthetic dataset used in this portfolio project:

| KPI | Result |
|---|---:|
| Total Shipments | 12,000 |
| Total Shipment Value | $305.38M |
| Total Weight | 17.09M kg |
| Delayed Shipments | 2,833 |
| On-Time Shipments | 9,167 |
| Delay Rate | 23.61% |
| Total Delay Hours | 65,174.8 |

## Key Analytical Findings

### Transportation Mode

Sea transportation represents the largest share of shipments in the dataset, followed by Air and Road.

The delay rates across the three transportation modes are relatively close, so shipment volume and delay rate should be evaluated separately rather than assuming the highest-volume mode is necessarily the least or most reliable.

### Shipment Status

Delay rates vary considerably across shipment statuses.

The reconstructed dataset shows higher delay rates among:

- Customs Hold
- In Transit
- Pending Pickup

This indicates that shipment status is an important dimension when investigating delays.

### Delay Reasons

Common delay reasons include:

- Customs Clearance
- Traffic Issue
- Weather Delay
- Technical Glitch
- Holiday Closure
- Scheduling Error
- Port Congestion
- Documentation Error
- Vehicle Breakdown
- Staff Shortage

Different metrics provide different perspectives. Frequency identifies common causes, average delay identifies severity per incident, and total delay hours shows overall impact.

### Products

LED lamps have the highest shipment count in the dataset, while Smartphone units represent the highest total shipment value among the listed products.

### Routes

High-volume routes and high-delay routes are not necessarily the same.

This is why route-level analysis is useful for identifying operational patterns that may not be visible in overall shipment counts.

## Important Analytical Considerations

The analysis distinguishes between:

- **Shipment volume** — how many shipments occurred
- **Delay rate** — percentage of shipments with delay
- **Average delay** — typical delay duration
- **Total delay hours** — cumulative delay duration
- **Shipment value** — value represented by shipments

A high count does not automatically mean high operational impact, and correlation between shipment status and delays does not by itself establish causation.

The 2025 data covers only **January through April**, so it should not be compared directly with complete 2023 or 2024 annual totals.

## Tools & Technologies

| Tool | Purpose |
|---|---|
| Excel | Initial data inspection and validation |
| Python | Data cleaning, validation and exploratory analysis |
| Pandas | Data manipulation |
| Matplotlib | Data visualization |
| MySQL | SQL analysis and data validation |
| Power BI | Dashboard, KPIs and interactive reporting |
| GitHub | Version control and portfolio presentation |

## Repository Structure

```text
logistics-shipment-performance-analysis
│
├── Dataset
│   └── AD_Global_Freight_SQL.csv
│
├── PowerBI
│   ├── AD_Global_Freight_Dashboard.pbix
│   └── dashboard_preview.png
│
├── Python
│   ├── data_cleaning.py
│   ├── data_profiling.py
│   ├── data_quality.py
│   ├── data_validation.py
│   ├── eda.py
│   └── sql_dataset.py
│
├── SQL
│   ├── advance_analysis.sql
│   ├── basic_analysis.sql
│   ├── data_validation.sql
│   ├── intermediate_analysis.sql
│   └── logistics_analysis.sql
│
└── README.md
```

## What This Project Demonstrates

This project demonstrates an end-to-end Data Analyst workflow:

- Understanding a business problem
- Working with structured operational data
- Performing data profiling
- Identifying data-quality issues
- Cleaning and transforming data
- Creating analytical features
- Performing exploratory data analysis
- Writing SQL queries
- Calculating business KPIs
- Building an interactive Power BI dashboard
- Interpreting operational patterns
- Presenting analytical findings clearly

## Interview Summary

A concise way to explain the project in an interview:

> "I worked on a logistics and shipment performance analysis project where I followed an end-to-end data analytics workflow. I started by profiling and validating shipment data using Python and Pandas, handled missing values and duplicate records, created analytical fields such as year, month, quarter and delay flags, and then performed exploratory analysis to understand shipment volume, transportation modes, statuses, routes and delay reasons. I used MySQL for business-oriented SQL analysis and Power BI to build an interactive dashboard with KPI cards, filters and operational performance visualizations. The dataset in my portfolio is synthetic/reconstructed and is not company-confidential data."

## Portfolio Note

This repository is intended to demonstrate analytical skills and project workflow. The dataset is synthetic/reconstructed and does not represent confidential records, customer information, financial records or actual operational performance of A&D Global Freight Pvt. Ltd.
