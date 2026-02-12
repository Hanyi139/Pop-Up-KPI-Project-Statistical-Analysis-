# Luxury Beauty Cosmetics Pop-Up Events KPI 2025 Analysis (R)

## Overview
This repository showcases statistical testing and regression analysis in **R** using a **synthetic Kaggle dataset** themed around luxury beauty pop-up events (2025). The project demonstrates how to evaluate business KPIs (footfall, sell-through, units sold, lease length, etc.) using hypothesis tests and models that employers commonly expect in analytics roles.

> Data note: The dataset is **synthetic** (no real customer/company information).

## Skills Demonstrated 
- ## R programming, hypothesis testing, assumption checking, modeling and interpretation
  
## Business Goal
Pop-up events are costly and operationally complex. This analysis explores:
- Whether KPIs differ across **regions**, **brands**, **event types**, and **location types**
- Whether operational levers (like **footfall**, **lease length**, **price**) predict outcomes like **sell-through %** and **units sold**

## Key Questions Answered (What the scripts test)
- **Do regions differ in average daily footfall?** (normality checks + non-parametric comparison)
- **Do Latin America vs North America differ in lease length days?** (variance checks + Welch t-test)
- **Is Europe’s units sold higher/lower than the overall mean?** (one-sample z-statistic + p-value)
- **Are location type and event type associated?** (Chi-square test of independence)
- **Do footfall/price/lease length predict sell-through or units sold?** (linear & multiple regression + VIF)
- **Do region and brand jointly impact footfall (including interaction)?** (two-way ANOVA + Tukey HSD)

## Files in This Repo
- `OneWayANOVA.R`
  - Filters 3 regions (Asia-Pacific, Europe, North America)
  - Runs **Shapiro-Wilk** for normality on `avg_daily_footfall`
  - Applies **log transform** attempt
  - Runs **Levene’s test** for variance equality
  - Uses **Kruskal-Wallis** (non-parametric alternative to one-way ANOVA)
  - Creates **boxplot** comparing footfall across regions

- `TwoWayANOVA.R`
  - Cleans brand encoding for **Estée Lauder**
  - Filters to 3 regions + 3 brands (Hourglass, Estée Lauder, Tom Ford Beauty)
  - Uses `avg_daily_footfall_log` and runs:
    - **Shapiro-Wilk**
    - **Levene’s test**
    - **Two-way ANOVA** with interaction: `region * brand`
    - **Tukey HSD** post-hoc
  - Produces summary table (mean/sd/n), boxplots, and interaction plot

- `TwoTailTTest.R`
  - Compares **lease_length_days** between **Latin America vs North America**
  - Runs:
    - Shapiro-Wilk per group
    - Log transform attempt
    - Levene’s test + F test (`var.test`)
    - **Welch two-sample t-test**: `t.test(lease_length_days ~ region)`

- `OneTailZTest.R`
  - Focuses on **Europe** sample `units_sold`
  - Runs Shapiro-Wilk, histogram + density curve, skewness/kurtosis
  - Computes a **z-statistic** comparing Europe mean vs overall mean and calculates a p-value using `pnorm()`

- `ChiSquare.R`
  - Tests whether **location_type** and **event_type** are associated
  - Builds a 3x3 contingency table (selected levels)
  - Runs **Chi-square test of independence**

- `LinearRegression.R`
  - Runs regression models such as:
    - `sell_through_pct ~ avg_daily_footfall`
    - `sell_through_pct ~ lease_length_days`
    - `units_sold ~ price_usd + avg_daily_footfall`
    - `sell_through_pct ~ avg_daily_footfall + lease_length_days + price_usd`
  - Generates scatterplots with regression line
  - Checks multicollinearity using **VIF**

## Key Findings
> Note: data is synthetic and small (2,133 rows). Results may not be significant, but the testing is accurate and can be applied to real business data. 
- A Kruskal-Wallis test found no statistically significant differences in average daily footfall across Asia-Pacific, Europe, and North America (χ²(2) = 2.81, p = 0.245). Variance homogeneity was confirmed via Levene’s test (p = 0.854). Results suggest regional location alone does not significantly impact foot traffic volume.
- A two-way ANOVA examining region and brand effects on log-transformed average daily footfall found no statistically significant main effects for region (F(2,158) = 0.341, p = 0.711) or brand (F(2,158) = 0.152, p = 0.859), nor a significant interaction effect (F(4,158) = 1.286, p = 0.278). Tukey post-hoc comparisons confirmed no meaningful pairwise differences. These findings suggest that foot traffic volume is not significantly driven by geography or brand identity alone.
- A Welch two-sample t-test comparing lease length days between Latin America and North America found no statistically significant difference (t(821.8) = 1.02, p = 0.306). Mean lease duration was 46.2 days in Latin America and 44.4 days in North America, suggesting standardized lease strategies across regions.
- A one-sample z-test comparing Europe’s mean units sold to the overall mean found no statistically significant difference (z = 0.43, p = 0.666). Europe’s performance appears consistent with global averages.
- A Chi-square test of independence found no significant association between location type and event format (χ²(4) = 3.03, p = 0.552). Event distribution appears balanced across Airport Duty-Free, High-Street, and Luxury Mall settings, suggesting standardized deployment strategies.
- A simple linear regression found that average daily footfall significantly predicts sell-through percentage (β = 0.0017, p = 0.0036); however, the effect size was very small (R² = 0.004), indicating limited practical impact. Lease length and price were not significant predictors of sell-through or units sold. Overall, operational variables explained minimal variation in performance metrics.
