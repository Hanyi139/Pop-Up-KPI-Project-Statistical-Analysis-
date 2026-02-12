# Luxury Beauty Cosmetics Pop-Up Events KPI 2025 Analysis (R)

## Overview

This project analyzes performance drivers of luxury beauty pop-up events using statistical testing and regression modeling in **R**. The dataset (synthetic, sourced from Kaggle) simulates 2025 KPI data across global regions, brands, retail environments, and event formats.

The objective was to determine whether structural factors (region, brand, location type, event format) or operational variables (footfall, lease length, price) meaningfully influence key outcomes such as:

- Average daily footfall  
- Sell-through percentage  
- Units sold  
- Lease length  

> **Note:** The dataset is synthetic and used solely for analytical demonstration.

---

## Executive Summary

This analysis evaluated whether geography, brand identity, retail setting, or operational variables significantly influence pop-up event performance.

**Key findings:**

- No statistically significant differences in footfall across regions.
- No significant region × brand interaction effects.
- Lease length does not differ meaningfully between Latin America and North America.
- Event type distribution is independent of retail location type.
- Average daily footfall is a statistically significant predictor of sell-through percentage — but the effect size is extremely small (R² ≈ 0.004).
- Price and lease length do not significantly predict sell-through or units sold.

Overall, structural variables do not appear to be primary drivers of KPI variation. Performance differences likely stem from micro-level execution factors rather than geography or brand identity alone.

---

## Skills Demonstrated

- R programming (tidyverse, ggplot2, car)
- Assumption testing (Shapiro-Wilk, Levene’s Test)
- Parametric and non-parametric hypothesis testing
- One-sample Z-test
- Welch two-sample t-test
- One-way and Two-way ANOVA with interaction effects
- Chi-square test of independence
- Linear and multiple regression modeling
- Model diagnostics (VIF, residual interpretation)
- Translating statistical output into business insights

---

## Business Questions Investigated

1. Do regions differ in average daily footfall?
2. Does region and brand jointly impact footfall?
3. Does lease duration differ between Latin America and North America?
4. Is Europe’s average units sold different from the global mean?
5. Is event format associated with retail location type?
6. Do footfall, lease length, or price predict sell-through or units sold?

---

## Key Findings

### Regional Footfall Differences

A Kruskal-Wallis test found no statistically significant differences in average daily footfall across Asia-Pacific, Europe, and North America (χ²(2) = 2.81, p = 0.245). Variances were homogeneous (Levene’s p = 0.854).
<img width="1182" height="936" alt="2df8fb44-08a4-4d30-bcb3-f4c131a384c9" src="https://github.com/user-attachments/assets/b9ac8d2f-cc1a-431a-90f7-da00e54ea2e5" />

**Interpretation:** Geographic region alone does not significantly influence foot traffic volume.

---

### Region × Brand Interaction

A two-way ANOVA on log-transformed footfall found:

- No main effect of region (p = 0.711)
- No main effect of brand (p = 0.859)
- No significant interaction effect (p = 0.278)

Tukey post-hoc comparisons showed no meaningful pairwise differences.
<img width="1182" height="936" alt="f1fc6a14-b161-4920-9cd9-1b2a38b5c377" src="https://github.com/user-attachments/assets/fe6cd4c8-cbb1-4183-bcc5-41f29a9c59b4" />

**Interpretation:** Footfall is not driven by geography, brand identity, or their interaction.

---

### Lease Length Comparison

A Welch two-sample t-test comparing lease length days between Latin America and North America found no significant difference (t(821.8) = 1.02, p = 0.306).

Mean lease duration:

- Latin America: 46.2 days  
- North America: 44.4 days  

**Interpretation:** Lease strategies appear standardized across regions.

---

### Europe Units Sold vs Global Mean

A one-sample z-test comparing Europe’s units sold to the overall mean found no significant difference (z = 0.43, p = 0.666).

**Interpretation:** Europe’s performance aligns with global averages.

---

### Location Type × Event Format

A Chi-square test of independence found no significant association between retail location type and event format (χ²(4) = 3.03, p = 0.552).

**Interpretation:** Event deployment appears balanced across Airport Duty-Free, High-Street, and Luxury Mall environments.

---

### Regression Analysis

#### Footfall → Sell-Through %

Simple linear regression:

- β = 0.0017  
- p = 0.0036  
- R² = 0.004  

Footfall is statistically significant but explains less than 0.5% of sell-through variation.
<img width="1182" height="936" alt="3e3d553c-2ef9-4394-89c6-1a3b9234f152" src="https://github.com/user-attachments/assets/3101527a-e091-4d08-ae9b-5b7e4a7419ca" />

**Interpretation:** Higher traffic slightly improves sell-through, but the practical effect is minimal.

---

#### Lease Length → Sell-Through %

Not statistically significant (p = 0.49).

---

#### Price + Footfall → Units Sold

Multiple regression showed no significant predictors (p = 0.994, R² ≈ 0).

---

#### Full Model: Footfall + Lease Length + Price → Sell-Through

Only footfall remained statistically significant (p = 0.0034), but overall explanatory power remained very small (R² = 0.0043).

**Interpretation:** Operational variables explain minimal performance variation.

---

## Business Implications

- Regional strategy adjustments alone are unlikely to improve KPI performance.
- Brand presence does not significantly impact traffic volume.
- Event type allocation is not structurally tied to retail environment.
- Traffic increases conversion slightly, but not enough to meaningfully drive results.
- Performance differences are likely influenced by execution quality, promotional strategy, product mix, or consumer behavior rather than structural categories.

---

## Repository Structure

- `OneWayANOVA.R`
- `TwoWayANOVA.R`
- `TwoTailTTest.R`
- `OneTailZTest.R`
- `ChiSquare.R`
- `LinearRegression.R`

Each script includes assumption testing, statistical modeling, and/or visualization.

---

## Next Steps

Future analysis could incorporate:

- Marketing channel segmentation
- Inventory allocation strategy
- Promotional intensity
- Nonlinear modeling approaches
- Additional interaction effects beyond region and brand
