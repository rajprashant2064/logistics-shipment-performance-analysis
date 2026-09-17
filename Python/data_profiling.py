import pandas as pd

file_path = "Dataset/AD_Global_Freight.xlsx"

df = pd.read_excel(file_path)

print("=" * 60)
print("A&D GLOBAL FREIGHT - DATA PROFILING")
print("=" * 60)

print("\n1. DATASET SIZE")
print("Rows:", df.shape[0])
print("Columns:", df.shape[1])

print("\n2. COLUMN NAMES")
print(df.columns.tolist())

print("\n3. DATA TYPES")
print(df.dtypes)

print("\n4. MISSING VALUES")
missing = df.isnull().sum()
missing_percent = (missing / len(df)) * 100

missing_report = pd.DataFrame({
    "Missing Values": missing,
    "Missing Percentage": missing_percent.round(2)
})

print(missing_report)

print("\n5. DUPLICATES")
print("Duplicate rows:", df.duplicated().sum())
print("Duplicate shipment IDs:", df["shipment_id"].duplicated().sum())

print("\n6. NUMERICAL SUMMARY")
print(df[[
    "weight_kg",
    "value_usd",
    "Delay_Time(hrs)"
]].describe())

print("\n7. UNIQUE VALUES")

for column in ["mode", "status", "Delay_Reason"]:
    print(f"\n{column}:")
    print(df[column].value_counts(dropna=False))

print("\n8. DATE RANGE")

df["date"] = pd.to_datetime(df["date"])

print("Minimum date:", df["date"].min())
print("Maximum date:", df["date"].max())

print("\nProfiling completed.")