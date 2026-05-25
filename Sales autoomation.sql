use sales_dashboard_db;

select * from products;

select * from sales;


SELECT 'Products Master' AS Table_Name, COUNT(*) AS Total_Records FROM products
UNION ALL
SELECT 'Sales Transactions' AS Table_Name, COUNT(*) AS Total_Records FROM sales;

SELECT 
    store_id, 
    region, 
    COUNT(transaction_id) AS total_orders,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(AVG(revenue), 2) AS average_order_value
FROM sales
GROUP BY store_id, region
ORDER BY total_revenue DESC;

SELECT 
    category, 
    SUM(quantity) AS total_units_sold, 
    ROUND(SUM(revenue), 2) AS category_revenue,
    ROUND(AVG(discount) * 100, 2) AS avg_discount_percentage
FROM sales
GROUP BY category
ORDER BY category_revenue DESC;

SELECT 
    payment_method, 
    COUNT(*) AS usage_count, 
    ROUND(SUM(revenue), 2) AS aggregate_processed_revenue
FROM sales
GROUP BY payment_method
ORDER BY usage_count DESC;

SELECT 
    customer_id, 
    COUNT(transaction_id) AS total_visits, 
    SUM(quantity) AS items_purchased,
    ROUND(SUM(revenue), 2) AS customer_lifetime_value
FROM sales
GROUP BY customer_id
ORDER BY customer_lifetime_value DESC
LIMIT 5;

SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS sale_month,
    ROUND(SUM(revenue), 2) AS current_month_revenue,
    ROUND(LAG(SUM(revenue), 1) OVER (ORDER BY DATE_FORMAT(sale_date, '%Y-%m')), 2) AS previous_month_revenue,
    ROUND(
        ((SUM(revenue) - LAG(SUM(revenue), 1) OVER (ORDER BY DATE_FORMAT(sale_date, '%Y-%m'))) 
        / LAG(SUM(revenue), 1) OVER (ORDER BY DATE_FORMAT(sale_date, '%Y-%m'))) * 100, 
        2
    ) AS mom_growth_percentage
FROM sales
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY sale_month;


SELECT 
    ROUND(discount * 100, 0) AS discount_percentage,
    COUNT(transaction_id) AS total_transactions,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(revenue), 2) AS aggregate_revenue,
    ROUND(AVG(revenue), 2) AS average_order_value
FROM sales
GROUP BY discount
ORDER BY discount_percentage ASC;

SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.source AS data_source,
    SUM(s.quantity) AS total_quantity_sold,
    ROUND(SUM(s.revenue), 2) AS gross_generated_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category, p.source
ORDER BY gross_generated_revenue DESC
LIMIT 10;

SELECT 
    transaction_id,
    sale_date,
    store_id,
    customer_id,
    quantity AS units_in_basket,
    revenue AS basket_total_value,
    payment_method
FROM sales
WHERE revenue > (SELECT AVG(revenue) * 2 FROM sales)
ORDER BY revenue DESC
LIMIT 10;

SELECT 
    region,
    payment_method,
    COUNT(*) AS method_usage_count,
    ROUND(SUM(revenue), 2) AS payment_channel_revenue,
    ROUND((COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY region)) * 100, 2) AS regional_share_percentage
FROM sales
GROUP BY region, payment_method
ORDER BY region ASC, method_usage_count DESC;