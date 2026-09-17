import pandas as pd
import os

input_file = "Dataset/AD_Global_Freight.xlsx"
output_file = "Dataset/AD_Global_Freight_Cleaned.xlsx"

df = pd.read_excel(input_file)

print("=" * 60)
print("A&D GLOBAL FREIGHT - DATA CLEANING")
print("=" * 60)

print("\n1. ORIGINAL DATASET")
print("Rows:", len(df))
print("Columns:", len(df.columns))

df["date"] = pd.to_datetime(df["date"], errors="coerce")

df["hs_code"] = df["hs_code"].fillna("Unknown")

df["weight_kg"] = df["weight_kg"].fillna(df["weight_kg"].median())

df["value_usd"] = df["value_usd"].fillna(df["value_usd"].median())

df["remarks"] = df["remarks"].fillna("No Remarks")

df["Delay_Reason"] = df["Delay_Reason"].fillna("No Delay")

text_columns = [
    "origin",
    "destination",
    "mode",
    "product_description",
    "status",
    "bill_of_lading",
    "shipper",
    "consignee",
    "remarks",
    "Delay_Reason"
]

for column in text_columns:
    df[column] = df[column].astype(str).str.strip()

df["shipment_id"] = df["shipment_id"].astype(str).str.strip()

df["weight_kg"] = pd.to_numeric(df["weight_kg"], errors="coerce")

df["value_usd"] = pd.to_numeric(df["value_usd"], errors="coerce")

df["Delay_Time(hrs)"] = pd.to_numeric(df["Delay_Time(hrs)"], errors="coerce")

df = df.drop_duplicates()

df = df.drop_duplicates(subset=["shipment_id"], keep="first")

df = df[df["weight_kg"] > 0]

df = df[df["value_usd"] > 0]

df = df[df["Delay_Time(hrs)"] >= 0]

df["year"] = df["date"].dt.year

df["month"] = df["date"].dt.month_name()

df["month_number"] = df["date"].dt.month

df["quarter"] = df["date"].dt.quarter

df["delay_flag"] = df["Delay_Time(hrs)"] > 0

df["delay_days"] = df["Delay_Time(hrs)"] / 24

print("\n2. CLEANED DATASET")
print("Rows:", len(df))
print("Columns:", len(df.columns))

print("\n3. REMAINING MISSING VALUES")
print(df.isnull().sum())

print("\n4. DUPLICATES AFTER CLEANING")
print("Duplicate rows:", df.duplicated().sum())
print("Duplicate shipment IDs:", df["shipment_id"].duplicated().sum())

print("\n5. DATE RANGE")
print("Minimum date:", df["date"].min())
print("Maximum date:", df["date"].max())

print("\n6. DELAYED SHIPMENTS")
print("Delayed shipments:", df["delay_flag"].sum())
print("On-time shipments:", (~df["delay_flag"]).sum())

df.to_excel(output_file, index=False)

print("\n7. OUTPUT FILE")
print(output_file)

print("\nData cleaning completed.")