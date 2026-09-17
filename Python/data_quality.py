import pandas as pd

df = pd.read_excel("Dataset/AD_Global_Freight.xlsx")

print("=" * 60)
print("A&D GLOBAL FREIGHT - DATA QUALITY ANALYSIS")
print("=" * 60)

print("\n1. MISSING VALUES BY STATUS")
print(pd.crosstab(
    df["status"],
    df["value_usd"].isna(),
    margins=True
))

print("\n2. MISSING WEIGHT BY MODE")
print(pd.crosstab(
    df["mode"],
    df["weight_kg"].isna(),
    margins=True
))

print("\n3. INVALID WEIGHT VALUES")
print(df[df["weight_kg"] <= 0][[
    "shipment_id",
    "weight_kg",
    "mode",
    "status"
]])

print("\n4. INVALID VALUE VALUES")
print(df[df["value_usd"] <= 0][[
    "shipment_id",
    "value_usd",
    "mode",
    "status"
]])

print("\n5. INVALID DELAY VALUES")
print(df[df["Delay_Time(hrs)"] < 0][[
    "shipment_id",
    "Delay_Time(hrs)",
    "status"
]])

print("\n6. DELAY SUMMARY BY MODE")
print(
    df.groupby("mode")["Delay_Time(hrs)"]
    .agg(["count", "mean", "median", "max"])
    .round(2)
)

print("\n7. DELAY SUMMARY BY STATUS")
print(
    df.groupby("status")["Delay_Time(hrs)"]
    .agg(["count", "mean", "median", "max"])
    .round(2)
)

print("\n8. TOP 10 ORIGINS")
print(df["origin"].value_counts().head(10))

print("\n9. TOP 10 DESTINATIONS")
print(df["destination"].value_counts().head(10))

print("\n10. TOP 10 PRODUCTS")
print(df["product_description"].value_counts().head(10))

print("\n11. HIGH VALUE SHIPMENTS")
print(
    df.nlargest(10, "value_usd")[[
        "shipment_id",
        "origin",
        "destination",
        "mode",
        "value_usd",
        "status"
    ]]
)

print("\n12. HIGH DELAY SHIPMENTS")
print(
    df.nlargest(10, "Delay_Time(hrs)")[[
        "shipment_id",
        "origin",
        "destination",
        "mode",
        "Delay_Time(hrs)",
        "Delay_Reason",
        "status"
    ]]
)

print("\nData quality analysis completed.")