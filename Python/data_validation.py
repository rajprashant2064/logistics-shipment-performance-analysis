import pandas as pd

df = pd.read_excel("Dataset/AD_Global_Freight_Cleaned.xlsx")

print("=" * 60)
print("A&D GLOBAL FREIGHT - CLEANED DATA VALIDATION")
print("=" * 60)

print("\n1. DATASET SIZE")
print("Rows:", len(df))
print("Columns:", len(df.columns))

print("\n2. DUPLICATE CHECK")
print("Duplicate rows:", df.duplicated().sum())
print("Duplicate shipment IDs:", df["shipment_id"].duplicated().sum())

print("\n3. MISSING VALUES")
print("Total missing values:", df.isnull().sum().sum())

print("\n4. DATE VALIDATION")
print("Minimum date:", df["date"].min())
print("Maximum date:", df["date"].max())
print("Invalid dates:", df["date"].isna().sum())

print("\n5. WEIGHT VALIDATION")
print("Minimum weight:", df["weight_kg"].min())
print("Maximum weight:", df["weight_kg"].max())
print("Invalid weights:", (df["weight_kg"] <= 0).sum())

print("\n6. VALUE VALIDATION")
print("Minimum value:", df["value_usd"].min())
print("Maximum value:", df["value_usd"].max())
print("Invalid values:", (df["value_usd"] <= 0).sum())

print("\n7. DELAY VALIDATION")
print("Minimum delay:", df["Delay_Time(hrs)"].min())
print("Maximum delay:", df["Delay_Time(hrs)"].max())
print("Negative delays:", (df["Delay_Time(hrs)"] < 0).sum())

print("\n8. DELAY FLAG VALIDATION")
print("Delayed shipments:", df["delay_flag"].sum())
print("On-time shipments:", (~df["delay_flag"]).sum())

flag_errors = (
    ((df["Delay_Time(hrs)"] > 0) & (df["delay_flag"] == False)) |
    ((df["Delay_Time(hrs)"] == 0) & (df["delay_flag"] == True))
)

print("Delay flag errors:", flag_errors.sum())

print("\n9. STATUS DISTRIBUTION")
print(df["status"].value_counts())

print("\n10. MODE DISTRIBUTION")
print(df["mode"].value_counts())

print("\n11. DELAY REASON DISTRIBUTION")
print(df["Delay_Reason"].value_counts())

print("\n12. YEAR DISTRIBUTION")
print(df["year"].value_counts().sort_index())

print("\n13. QUARTER DISTRIBUTION")
print(df["quarter"].value_counts().sort_index())

print("\n14. DELAY RATE")
delay_rate = df["delay_flag"].mean() * 100
print("Overall delay rate:", round(delay_rate, 2), "%")

print("\nCleaned data validation completed.")