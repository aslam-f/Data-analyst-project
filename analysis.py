# analysis.py
# Basic EDA and chart generation using pandas and matplotlib
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("business_analytics_dataset.csv", parse_dates=["OrderDate","PaymentDate"], dayfirst=False)

# KPI summary
total_revenue = df["Revenue"].sum()
total_cost = df["Cost"].sum()
total_profit = df["Profit"].sum()
num_invoices = len(df)
overdue_amount = df.loc[df["InvoiceStatus"]=="Overdue","Revenue"].sum()

print("Total revenue:", round(total_revenue,2))
print("Total cost:", round(total_cost,2))
print("Total profit:", round(total_profit,2))
print("Overdue amount:", round(overdue_amount,2))

# Monthly revenue trend
df['Month'] = df['OrderDate'].dt.to_period('M')
monthly = df.groupby('Month')['Revenue'].sum().reset_index()
monthly['Month'] = monthly['Month'].dt.to_timestamp()

plt.figure(figsize=(10,5))
plt.plot(monthly['Month'], monthly['Revenue'])
plt.title("Monthly Revenue Trend")
plt.xlabel("Month")
plt.ylabel("Revenue")
plt.tight_layout()
plt.savefig("monthly_revenue_trend.png")
plt.close()

# Revenue by Region (bar)
region_rev = df.groupby('Region')['Revenue'].sum().reset_index().sort_values('Revenue', ascending=False)
plt.figure(figsize=(8,5))
plt.bar(region_rev['Region'], region_rev['Revenue'])
plt.title("Revenue by Region")
plt.xlabel("Region")
plt.ylabel("Revenue")
plt.tight_layout()
plt.savefig("revenue_by_region.png")
plt.close()

print("Charts saved: monthly_revenue_trend.png, revenue_by_region.png")
