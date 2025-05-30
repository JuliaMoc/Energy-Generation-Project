# 🌍 Powering the Future: A Global Energy Generation Analysis ⚡


## 📊 Overview

Welcome to **Powering the Future: A Global Energy Generation Analysis**! This project offers a comprehensive analysis of global electricity generation and capacity trends, covering both **renewable** and **non-renewable** energy sources. Using open-source data from Kaggle, which includes information from the **International Monetary Fund (IMF)** and the **International Renewable Energy Agency (IRENA)**, this project analyzes energy patterns across countries from **2000 to 2022**. Whether you're an energy analyst, researcher, or just curious about global energy trends, this project provides powerful insights into how the world is producing and consuming energy.

## 🏗️ Key Features of the Dataset

- **Energy Types**: Renewable (🌞 Solar, 🌬️ Wind, 💧 Hydropower, 🌱 Bioenergy) vs. Non-Renewable (🔥 Fossil Fuels).
- **Indicators**: Tracks Electricity Generation and Installed Capacity globally.
- **Time Period**: Data from 2000 to 2022 — a valuable longitudinal perspective.
- **Country & Regional Breakdown**: Insights from all over the world, comparing regions and nations.
- **Energy Technologies**: Detailed data on Solar, Wind, Fossil Fuels, and more.

## 🔍 Methodology & Approach

### Data Pipeline

1. **SQL Data Cleanup**:

- Remove unnecessary columns, fix null values (set to 0).
- Merge data from **2000-2022** to analyze global energy trends.
- Use **UNION** and **aggregate functions** to consolidate and enhance data for better analysis.

2. Transform & Normalize:

- Normalize the data for more granular insights like **yearly consumption trends, CAGR,** and **percentage shares**.
- Transform the data into actionable insights for energy forecasts and country comparisons.

3. Advanced Analytics:
- **Time-Series Analysis** with moving averages to spot consumption patterns.
- **Forecasting**: Use **linear regression** to predict future energy trends and analyze country-specific growth.

4. Dynamic Dashboard:
- Interactive visualization of key metrics: trends in energy generation over time, breakdown by technology, and the Top 10 energy-consuming countries. This Dashboard is available on Tableau Public: https://public.tableau.com/app/profile/julia.mochel/viz/PoweringtheFuture/Dashboard. 

<img width="1180" alt="Powering the Future Dashboard" src="https://github.com/user-attachments/assets/33ac68d6-a49f-4bb2-9638-1a5a4f2356a4" />

## 💡 Key Insights & Discoveries

- **Top Consumers**: Identify countries with the highest and lowest energy consumption.
- **Technology Trends**: See how different technologies (e.g., Solar, Wind) are growing in capacity and generation.
- **Growth Metrics**: Compound Annual Growth Rate (CAGR) reveals the speed of energy consumption and renewable adoption across countries.
- **Country Rankings**: Get rankings of countries based on total energy consumption, showing leaders and laggards.
- **Time Series**: Track the progress of energy consumption over time and identify key turning points.
- **Energy Forecasting**: Predict future consumption patterns based on historical data.

## 🛠️ Future Enhancements

The project is not yet fully completed, and the journey continues. Here’s what’s coming next:

1. **API Integration**: Expanding the dataset with real-time or additional external data sources.
2. **Interactive Dashboard (Power BI)**: Creating an engaging and dynamic dashboard to visualize global energy trends. It will offer in-depth, user-friendly reports with customizable filters for deeper insights.

## 🧠 Ideas for Expansion

Here are some ideas that could take this project even further:

1. **Sustainability Tracker**: Add a sustainability index to track progress towards renewable energy goals across countries.
2. **Machine Learning Models**: Use advanced ML models to predict long-term energy trends and help optimize energy production strategies.
3. **Cloud Storage (AWS S3)**: Leveraging the power of AWS for scalable data storage and fast access.

## 🚀 How to Run the Project

1️⃣ Download the dataset, SQL script, and Tableau dashboard.

2️⃣ Run the SQL queries in your preferred database system.

3️⃣ Open the interactive Tableau Public dashboard to explore key insights such as energy generation trends, technology breakdowns, and top-consuming countries.

## Let’s power up the future of energy! 🌞

