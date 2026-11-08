# Marketing-AB-Test-Analysis
**Tools Used:** SQL (MySQL), R, Power BI  
**Dataset:** Public Marketing A/B Testing Dataset (Kaggle)

## 📌 Project Overview
Marketing companies frequently run A/B tests to determine if their ad campaigns actually drive conversions. The goal of this project is to simulate the workflow of a Performance Marketing Analyst: 
1. Determine if the ad campaign was successful.
2. Attribute the success (if any) specifically to the ads.
3. Identify optimization opportunities regarding ad frequency and timing.

## 📊 Data Overview
The dataset contains **588,101 users** divided into two groups:
*   **Ad Group (564,577 users):** Exposed to the digital advertisement.
*   **PSA Group (23,524 users):** The control group, exposed to a Public Service Announcement instead.

## 🔍 Methodology & Analysis

### 1. Data Extraction & Cleaning (SQL)
Using MySQL the raw data was queried to calculate baseline conversion rates, bucket ad exposure frequencies, and aggregate conversion rates by day and hour. 

### 2. Statistical Validation (R)
To ensure the difference in conversion rates wasn't due to random chance, the 2x2 contingency table was exported to R and r a **Two-Proportion Z-Test** (`prop.test`) was ran.
*   **Ad Group Conv. Rate:** 2.55%
*   **PSA Group Conv. Rate:** 1.79%
*   **P-value:** 8.526e-14 (Highly statistically significant, p < 0.001)

### 3. Visualization & Insights (Power BI)
A dashboard was built to present the findings. 

## 💡 Key Findings & Business Recommendations

*   **Campaign Success:** The ad campaign was highly successful. It drove a **42% relative lift** in conversions compared to the control group. The recommendation is to maintain or increase ad spend.
*   **The Frequency Effect:** Conversion scales exponentially with ad exposure. Users who saw 1-5 ads converted at 0.25%, while those who saw 50+ ads converted at 13.46%. 
    *   *Recommendation:* Implement a frequency cap. Showing 50+ ads costs money; the next step is to calculate the ROAS (Return on Ad Spend) to find the exact "sweet spot" between exposure and ad cost.
*   **Timing Optimization:** User intent is highest on **Mondays** and between **3 PM and 8 PM**.
    *   *Recommendation:* Shift ad budgets (day-parting) to bid more aggressively during these high-converting windows.

## 🚀 How to Replicate This Project
1. Run the `sql/agoda_ab_test_analysis.sql` script in your MySQL environment to generate the aggregated tables.
2. Run the `r_script/significance_test.R` file to view the statistical test output.
3. Open the `dashboard/AB_Testing_Dashboard.pbix` file in Power BI Desktop to see the visuals.
