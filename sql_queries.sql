-- SQL schema (for CSV import) and sample queries

-- You can import CSV into a table named sales_billing:
-- CREATE TABLE sales_billing (...);
-- For simplicity columns: OrderID, OrderDate (DATE), CustomerID, Region, CustomerSegment, ProductCategory, Product,
-- Quantity (INT), UnitPrice (NUMERIC), Revenue (NUMERIC), Cost (NUMERIC), Profit (NUMERIC), ProjectID, ResourceID,
-- ResourceRole, HoursWorked (NUMERIC), BillRate (NUMERIC), BillAmount (NUMERIC), InvoiceStatus, PaymentDate (DATE),
-- PO_Created (BOOLEAN), PONumber, CreditNote, DebitNote

-- Sample queries:

-- 1. Top 10 customers by revenue
SELECT CustomerID, SUM(Revenue) AS TotalRevenue, SUM(Profit) AS TotalProfit
FROM sales_billing
GROUP BY CustomerID
ORDER BY TotalRevenue DESC
LIMIT 10;

-- 2. Monthly revenue trend
SELECT DATE_TRUNC('month', OrderDate) AS Month, SUM(Revenue) AS Revenue
FROM sales_billing
GROUP BY Month
ORDER BY Month;

-- 3. Revenue by region and product category
SELECT Region, ProductCategory, SUM(Revenue) AS Revenue
FROM sales_billing
GROUP BY Region, ProductCategory
ORDER BY Region, Revenue DESC;

-- 4. Outstanding invoices (Overdue or Submitted but unpaid)
SELECT InvoiceStatus, COUNT(*) AS CountInvoices, SUM(Revenue - CreditNote + DebitNote) AS Amount
FROM sales_billing
WHERE InvoiceStatus IN ('Submitted','Overdue')
GROUP BY InvoiceStatus;

-- 5. Billable hours and average bill rate by role
SELECT ResourceRole, SUM(HoursWorked) AS TotalHours, AVG(BillRate) AS AvgBillRate
FROM sales_billing
GROUP BY ResourceRole;

-- 6. Projects with highest bill amounts
SELECT ProjectID, SUM(BillAmount) AS TotalBilled
FROM sales_billing
GROUP BY ProjectID
ORDER BY TotalBilled DESC
LIMIT 20;
