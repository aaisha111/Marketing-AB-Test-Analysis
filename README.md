# Digital Ad Campaign Analysis: A/B Testing & Optimization

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
Using MySQL, the raw data was queried to calculate baseline conversion rates, bucket ad exposure frequencies, and aggregate conversion rates by day and hour. 

### 2. Statistical Validation (R)
To ensure the difference in conversion rates wasn't due to random chance, the 2x2 contingency table was exported to R and a **Two-Proportion Z-Test** (`prop.test`) was run.
*   **Ad Group Conv. Rate:** 2.55%
*   **PSA Group Conv. Rate:** 1.79%
*   **P-value:** 8.526e-14 (Highly statistically significant, p < 0.001)

### 3. Visualization & Insights (Power BI)
An interactive dashboard was built to present the findings.
![Dashboard Screenshot](dashboard/AB_testing_dashboard.png)
## 💡 Key Findings & Business Recommendations

*   **Effect Size & Attribution (The 70% Rule):** While the p-value is highly significant (p < 0.001), large sample sizes can artificially inflate significance. The practical business metric is the absolute lift of 0.77 percentage points, resulting in roughly **4,300 incremental conversions**. This means approximately 70% of the ad group's 14,423 conversions (about 10,077 users) would have converted organically anyway based on the control group's baseline. The campaign can only claim attribution for the remaining 30%.
*   **The Frequency Effect:** Conversion scales with ad exposure. Users who saw 1-5 ads converted at 0.25%, while those who saw 50+ ads converted at 13.46%. 
    *   *Recommendation:* Test frequency caps to see where extra impressions stop adding incremental conversions; the next step is to calculate the ROAS (Return on Ad Spend) to find the exact "sweet spot" between exposure and ad cost.
*   **Timing Optimization:** User intent appears highest on **Mondays** and between **3 PM and 8 PM**.
    *   *Recommendation:* Run a dedicated day-parting test to validate afternoon bid adjustments before reallocating budget. *(Note: Overnight data has high volatility due to low sample sizes. Timezone is unstated in the dataset).*

## ⚠️ Data Limitations
*   **No ROI/ROAS Calculation:** This analysis lacks ad spend (cost) data, meaning a true Return on Ad Spend cannot be calculated. Future tests should integrate cost metrics to determine if the ~4,300 incremental conversions justify the ad budget.
*   **Visual Best Practices:** All y-axes on the dashboard start at 0 to avoid exaggerating differences, and line smoothing was removed to reflect actual data points.


