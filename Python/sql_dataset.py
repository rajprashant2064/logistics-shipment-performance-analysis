import pandas as pd

input_file = "Dataset/AD_Global_Freight_Cleaned.xlsx"
output_file = "Dataset/AD_Global_Freight_SQL.csv"

df = pd.read_excel(input_file)

df["route"] = df["origin"] + " → " + df["destination"]

df["delay_status"] = df["delay_flag"].map({
    True: "Delayed",
    False: "On Time"
})

df["shipment_value_million"] = df["value_usd"] / 1000000

df["weight_tonnes"] = df["weight_kg"] / 1000

df["date"] = pd.to_datetime(df["date"]).dt.strftime("%Y-%m-%d")

df = df[
    [
        "shipment_id",
        "date",
        "year",
        "month",
        "month_number",
        "quarter",
        "origin",
        "destination",
        "route",
        "mode",
        "hs_code",
        "product_description",
        "weight_kg",
        "weight_tonnes",
        "value_usd",
        "shipment_value_million",
        "status",
        "bill_of_lading",
        "shipper",
        "consignee",
        "remarks",
        "Delay_Time(hrs)",
        "delay_days",
        "Delay_Reason",
        "delay_flag",
        "delay_status"
    ]
]

df.to_csv(output_file, index=False)

print("=" * 60)
print("A&D GLOBAL FREIGHT - SQL DATASET PREPARATION")
print("=" * 60)

print("\nRows:", len(df))
print("Columns:", len(df.columns))

print("\nColumns:")
print(df.columns.tolist())

print("\nMissing Values:")
print(df.isnull().sum().sum())

print("\nDuplicate Shipment IDs:")
print(df["shipment_id"].duplicated().sum())

print("\nDate Range:")
print("Minimum:", df["date"].min())
print("Maximum:", df["date"].max())

print("\nOutput File:")
print(output_file)

print("\nSQL dataset preparation completed.")