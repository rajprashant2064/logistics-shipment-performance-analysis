import pandas as pd

df = pd.read_excel("Dataset/AD_Global_Freight_Cleaned.xlsx")

print("=" * 60)
print("A&D GLOBAL FREIGHT - EXPLORATORY DATA ANALYSIS")
print("=" * 60)

print("\n1. OVERALL KPIs")

total_shipments = len(df)
total_value = df["value_usd"].sum()
total_weight = df["weight_kg"].sum()
total_delay_hours = df["Delay_Time(hrs)"].sum()
delayed_shipments = df["delay_flag"].sum()
delay_rate = df["delay_flag"].mean() * 100

print("Total Shipments:", total_shipments)
print("Total Shipment Value (USD):", round(total_value, 2))
print("Total Shipment Weight (KG):", round(total_weight, 2))
print("Total Delay Hours:", round(total_delay_hours, 2))
print("Delayed Shipments:", delayed_shipments)
print("On-Time Shipments:", total_shipments - delayed_shipments)
print("Delay Rate:", round(delay_rate, 2), "%")

print("\n2. SHIPMENTS BY YEAR")
print(df.groupby("year").size())

print("\n3. SHIPMENTS BY MONTH")
monthly_shipments = df.groupby(
    ["year", "month_number", "month"]
).size().reset_index(name="shipments")

print(monthly_shipments.sort_values(
    ["year", "month_number"]
))

print("\n4. SHIPMENTS BY MODE")
print(df["mode"].value_counts())

print("\n5. SHIPMENT VALUE BY MODE")
print(
    df.groupby("mode")["value_usd"]
    .sum()
    .sort_values(ascending=False)
    .round(2)
)

print("\n6. DELAY RATE BY MODE")
print(
    df.groupby("mode")["delay_flag"]
    .mean()
    .mul(100)
    .round(2)
)

print("\n7. AVERAGE DELAY BY MODE")
print(
    df.groupby("mode")["Delay_Time(hrs)"]
    .mean()
    .round(2)
    .sort_values(ascending=False)
)

print("\n8. DELAY RATE BY STATUS")
print(
    df.groupby("status")["delay_flag"]
    .mean()
    .mul(100)
    .round(2)
    .sort_values(ascending=False)
)

print("\n9. AVERAGE DELAY BY STATUS")
print(
    df.groupby("status")["Delay_Time(hrs)"]
    .mean()
    .round(2)
    .sort_values(ascending=False)
)

print("\n10. DELAY REASONS")
print(
    df[df["Delay_Reason"] != "No Delay"]["Delay_Reason"]
    .value_counts()
)

print("\n11. DELAY HOURS BY REASON")
print(
    df[df["Delay_Reason"] != "No Delay"]
    .groupby("Delay_Reason")["Delay_Time(hrs)"]
    .agg(["count", "mean", "sum"])
    .round(2)
    .sort_values("sum", ascending=False)
)

print("\n12. TOP 10 ORIGINS")
print(df["origin"].value_counts().head(10))

print("\n13. TOP 10 DESTINATIONS")
print(df["destination"].value_counts().head(10))

print("\n14. TOP 10 ROUTES")
df["route"] = df["origin"] + " → " + df["destination"]
print(df["route"].value_counts().head(10))

print("\n15. ROUTE DELAY ANALYSIS")
route_delay = (
    df.groupby("route")
    .agg(
        shipments=("shipment_id", "count"),
        average_delay=("Delay_Time(hrs)", "mean"),
        total_delay=("Delay_Time(hrs)", "sum")
    )
    .sort_values("average_delay", ascending=False)
)

print(route_delay.head(10).round(2))

print("\n16. TOP 10 PRODUCTS BY SHIPMENT COUNT")
print(df["product_description"].value_counts().head(10))

print("\n17. TOP 10 PRODUCTS BY SHIPMENT VALUE")
print(
    df.groupby("product_description")["value_usd"]
    .sum()
    .sort_values(ascending=False)
    .head(10)
    .round(2)
)

print("\n18. HIGH VALUE DELAYED SHIPMENTS")
print(
    df[
        (df["delay_flag"] == True)
    ]
    .nlargest(10, "value_usd")[[
        "shipment_id",
        "origin",
        "destination",
        "mode",
        "value_usd",
        "Delay_Time(hrs)",
        "Delay_Reason",
        "status"
    ]]
)

print("\n19. DELAY RATE BY YEAR")
print(
    df.groupby("year")["delay_flag"]
    .mean()
    .mul(100)
    .round(2)
)

print("\n20. SHIPMENT VALUE BY YEAR")
print(
    df.groupby("year")["value_usd"]
    .sum()
    .round(2)
)

print("\nExploratory data analysis completed.")