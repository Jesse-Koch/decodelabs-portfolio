# Project 2: Exploratory Data Analysis

**DecodeLabs Industrial Training**

EDA on 1,200 cleaned e-commerce orders - univariate stats, outliers, correlations, time-series, weekday patterns.

---

## Objectives

- Calculate basic statistics (mean, median, count)
- Identify trends and outliers
- Summarize key observations

---

## Workbook Structure

| Sheet | Contents |
|-------|----------|
| Data_Cleaned | 1,200 rows + 5 helper columns |
| Descriptive_Stats | Mean, median, quartiles, std dev |
| Outliers | IQR analysis + 8 outliers |
| Correlations | Correlation matrix + scatterplots |
| TimeSeries | Monthly, quarterly, yearly trends |
| Charts | All charts gathered |
| Summary | Key metrics dashboard |

---

## Key Metrics

| Metric | Value |
|--------|-------|
| Total Revenue | $1,264,761.96 |
| Total Orders | 1,200 |
| Average Order Value | $1,053.97 |
| 2024 Decline | -13.1% |
| Q4 2024 Decline | -22.2% |
| Best Weekday (Volume) | Sunday (186 orders) |
| Highest AOV Day | Thursday ($1,096.79) |
| Outlier Orders | 8 (above $3,330.42) |


---

## Correlations

| Pair | r |
|------|---|
| Unit Price ↔ Total Price | 0.72 |
| Items in Cart ↔ Quantity | 0.65 |
| Quantity ↔ Total Price | 0.62 |
| Items in Cart ↔ Total Price | 0.39 |
| Quantity ↔ Unit Price | 0.01 |

---

## Key Findings

1. Revenue declined 13.1% in 2024
2. Total Price is right-skewed (Mean $1,053.97 > Median $823.62)
3. 8 outliers - all legitimate high-value purchases (Quantity = 5, premium products)
4. Unit Price is the strongest driver of order value (r = 0.72)
5. Cart abandonment rate - 46% (5.49 cart vs 2.95 ordered)
6. Sunday has highest volume - Thursday has highest AOV

---

## Files

- `DecodeLabs_EDA.xlsx` - Full analysis workbook
- `Project2_EDA_Report.docx` - EDA report
---

## Tools

Excel PivotTables, CORREL, QUARTILE.INC, XLOOKUP
