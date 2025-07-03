import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px
import plotly.figure_factory as ff

# --- Setup ---
st.set_page_config(page_title="Air Quality of the Top 10 Energy-consuming Countries", layout="wide")
sns.set(style="whitegrid")
st.title("Air Quality of the Top 10 Energy-consuming Countries")

# --- Introduction & Project Context ---
st.markdown("""
### Project Context

This dashboard is part of my portfolio project to showcase my work with **APIs**, interactive visualizations, and analytical storytelling.

It complements my project [⚡ Powering the Future](https://public.tableau.com/app/profile/julia.mochel/viz/PoweringtheFuture/Dashboard), where I explore **global energy consumption and generation** from 2000–2022.

Here, I shift the focus to **air quality** for the **Top 10 Energy-consuming Countries** — connecting energy usage and their environmental impact.

---
""")

# Load data
df = pd.read_csv("air_quality_data.csv")
comp_columns = ['co', 'no', 'no2', 'o3', 'so2', 'pm2_5', 'pm10', 'nh3']

# --- Section 1: Interactive AQI Comparison ---
st.header("1. Air Quality Index (AQI) Overview")

fig_aqi = px.bar(
    df,
    x="city",
    y="aqi",
    color="aqi",
    color_continuous_scale="RdBu",
    title="AQI by City",
    labels={"aqi": "Air Quality Index", "city": "City"},
    template="plotly_dark"
)
fig_aqi.update_layout(xaxis_tickangle=-45)
st.plotly_chart(fig_aqi, use_container_width=True)

st.markdown("""
*AQI (Air Quality Index) is a simplified indicator provided by the OpenWeather API to classify air pollution levels.*  

**AQI Scale (1–5):**
- **1 – Good**: Air quality is considered satisfactory  
- **2 – Fair**: Acceptable air quality  
- **3 – Moderate**: Some pollutants may be a concern for sensitive people  
- **4 – Poor**: Unhealthy for sensitive groups  
- **5 – Very Poor**: Health effects may be felt by everyone
""")

# --- Section 2: Pollutant Concentration Heatmap (Plotly) ---
st.header("2. Interactive Heatmap of Pollutant Levels")
z = df[comp_columns].values
x = comp_columns
y = df["city"].tolist()

fig_heatmap = ff.create_annotated_heatmap(
    z,
    x=x,
    y=y,
    colorscale="RdBu",
    showscale=True,
    annotation_text=[[f"{val:.1f}" for val in row] for row in z]
)
fig_heatmap.update_layout(
    title="Pollutant Concentrations by City",
    xaxis_title="Pollutant",
    yaxis_title="City"
)
st.plotly_chart(fig_heatmap, use_container_width=True)

st.markdown("""
*Red indicates higher concentrations, blue indicates lower values.*
""")

# --- Section 3: Grouped Bar Chart for Key Pollutants (Plotly) ---
st.header("3. Comparison of CO, NO₂, and O₃ Levels")
df_melt = df.melt(id_vars=["city"], value_vars=["co", "no2", "o3"],
                  var_name="Pollutant", value_name="Concentration")

custom_colors = ['#d73027', '#4575b4', '#91bfdb']  # Rot, Dunkelblau, Hellblau

fig_multi = px.bar(
    df_melt,
    x="city",
    y="Concentration",
    color="Pollutant",
    barmode="group",
    title="Grouped Concentrations: CO, NO₂, O₃",
    color_discrete_sequence=custom_colors,
    labels={"city": "City", "Concentration": "µg/m³ or ppb"},
    template="plotly_dark"
)
fig_multi.update_layout(xaxis_tickangle=-45)
st.plotly_chart(fig_multi, use_container_width=True)

st.markdown("""
*These pollutants are key indicators of traffic-related air pollution.
When concentrations are high, they can harm human health and degrade overall air quality.*
""")

# --- Section 4: Heatmap with Seaborn ---
st.header("4. Pollutant Heatmap")
st.markdown("A static but detailed heatmap showing absolute concentration levels per pollutant and city.")

fig, ax = plt.subplots(figsize=(14, 8))

# --- Change to Dark Mode ---
fig.patch.set_facecolor('#0e1117')  # Streamlit dark theme background
ax.set_facecolor('#0e1117')

sns.heatmap(
    df.set_index("city")[comp_columns],
    annot=True,
    fmt=".1f",
    cmap="coolwarm",
    ax=ax,
    cbar_kws={'label': 'Concentration'},
    linewidths=0.5,
    linecolor='gray'
)

ax.set_title("Concentration of Pollutants by City", color='white')
ax.set_xlabel("Pollutant", color='white')
ax.set_ylabel("City", color='white')

ax.tick_params(colors='white')

st.pyplot(fig)

# --- Section 5: AQI and PM2.5 Levels (Matplotlib) ---
st.header("5. AQI and PM2.5 Levels")

col1, col2 = st.columns(2)

num_cities = len(df["city"].unique())
rdbu_colors = sns.color_palette("RdBu", n_colors=num_cities)

with col1:
    fig1, ax1 = plt.subplots(figsize=(7, 5))
    fig1.patch.set_facecolor('#0e1117')  # Hintergrund: Streamlit Dark
    ax1.set_facecolor('#0e1117')

    sns.barplot(data=df, x="city", y="aqi", palette=rdbu_colors, ax=ax1)
    ax1.set_title("AQI per City", color='white')
    ax1.set_ylabel("AQI (1 = good, 5 = poor)", color='white')
    ax1.set_xlabel("City", color='white')
    ax1.tick_params(axis="x", rotation=45, colors='white')
    ax1.tick_params(axis="y", colors='white')
    st.pyplot(fig1)

with col2:
    fig2, ax2 = plt.subplots(figsize=(7, 5))
    fig2.patch.set_facecolor('#0e1117')
    ax2.set_facecolor('#0e1117')

    sns.barplot(data=df, x="city", y="pm2_5", palette=rdbu_colors, ax=ax2)
    ax2.set_title("PM2.5 per City", color='white')
    ax2.set_ylabel("µg/m³", color='white')
    ax2.set_xlabel("City", color='white')
    ax2.tick_params(axis="x", rotation=45, colors='white')
    ax2.tick_params(axis="y", colors='white')
    st.pyplot(fig2)

# Feedback Field
st.markdown("---")
st.subheader("What do you think?")

feedback = st.text_input("Leave your feedback or ideas here")
if feedback:
    st.success("Thanks for your input!")

# Footer
st.markdown("---")
st.markdown("""
*Data visualization created using Streamlit, Plotly, Matplotlib, and Seaborn.*  
*Part of the [Energy Generation Project](https://github.com/JuliaMoc/Energy-Generation-Project) data portfolio project by Julia Mochel.*
""")