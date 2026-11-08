<div align="center">📊 Automated Sales Analytics
From web data collection to SQL analysis and Power BI reporting
<img width="233" height="20" alt="image" src="https://github.com/user-attachments/assets/4cec9224-4a27-483b-96b7-95ad41a8fbce" />
<img width="127" height="20" alt="image" src="https://github.com/user-attachments/assets/cd7b6f74-c267-4d99-a3a0-0ea4194b6133" />
<img width="138" height="20" alt="image" src="https://github.com/user-attachments/assets/ddbcfe9b-1ec8-49c2-9557-894699f17c84" />
<img width="131" height="20" alt="image" src="https://github.com/user-attachments/assets/e4fc1d36-3356-4500-8b29-a06d5c9e6fbc" />



Project Repository
</div>📌 Project Overview
Automated Sales Analytics is an end-to-end data analytics project that demonstrates how product information can be collected from multiple web sources, transformed into structured datasets, stored in MySQL, analyzed using SQL, and presented through a Power BI dashboard.

The project uses Python for web scraping and data preparation, pandas for data manipulation, MySQL for structured storage, SQL for business analysis, and Power BI for reporting.
Important data clarification: Product attributes are collected from demo/test websites. The sales transactions are programmatically generated sample data, not actual transactions from a retail company. The project is intended for learning and demonstrating an analytics workflow.

🔄 Project Workflow
The following diagram shows how the components in this repository work together:

<img width="2172" height="724" alt="image" src="https://github.com/user-attachments/assets/d1f349fd-4d59-4e19-a024-7a561b9edb31" />

</p>⚙️ How the Project Works
1. Product data collection — Python web scraping
The Jupyter notebook collects product information from three sources:
Source	Information collected or derived
Books to Scrape	Book title, category, listed price, rating, and availability
Webscraper.io test site	Laptop, tablet, and phone product names and listed prices
Quotes to Scrape	Authors are used to generate sample merchandise product records, such as T-shirts, mugs, and posters


The notebook uses Requests to retrieve pages and BeautifulSoup to parse the HTML content. pandas is used to organize the collected records.
2. Product catalog preparation
The notebook combines the collected and generated product records into one product catalog. It removes duplicate product names, assigns product IDs, and saves the result as:
- data/products_master.csv
3. Sample sales transaction generation
The notebook generates 10,000 sample sales transactions using the product catalog. The generated records include:
- Transaction ID and sale date
- Store ID and region
- Product ID and product details
- Quantity, unit price, discount, and calculated revenue
- Customer ID and payment method
The sample data covers five stores and a date range from 1 January 2024 to 31 December 2024. The notebook saves the transaction dataset as:
- data/scraped_sales.csv
The transactions are simulated for analysis and should not be interpreted as real sales or market statistics.
4. MySQL database integration
The notebook uses SQLAlchemy with PyMySQL to connect to MySQL and load the DataFrames into the sales_dashboard_db database.
Table	Contents
products	Prepared product catalog
sales	Generated sales transactions


The database is created before the notebook loads the tables. The notebook's current to_sql(..., if_exists="replace") logic replaces the target table when the data-loading cell is executed again.
5. SQL-based business analysis
The file Sales autoomation.sql contains queries for exploring the sales data and answering business questions, including:
Analysis	Business question
Store and regional performance	Which stores and regions generate the most revenue and orders?
Category performance	Which product categories contribute the most units and revenue?
Payment analysis	Which payment methods are used most frequently and generate the most revenue?
Customer analysis	Which customers have the highest purchase value and visit frequency?
Monthly trend analysis	How does revenue change month over month?
Discount analysis	How do discount levels relate to transaction count, units sold, and revenue?
Product performance	Which products generate the highest revenue?
High-value transactions	Which transactions are significantly larger than the average transaction?
Regional payment mix	How does payment-method usage vary by region?


The monthly growth query uses a SQL window function (LAG), so use MySQL 8.0 or later.
6. Power BI dashboard
The repository includes salesDashboard.pbix, the Power BI report file. Open it in Power BI Desktop to explore the report. When connecting it to your own MySQL instance, verify the data source settings and refresh the report after loading the database tables.
<!-- Add your own Power BI screenshots here after exporting them from Power BI Desktop.
     Save the screenshots in the assets folder, then uncomment and update the image paths below.

<p align="center">
  <img src="assets/powerbi-overview.png" alt="Power BI dashboard overview" width="100%">
</p>

<p align="center">
  <img src="assets/powerbi-regional-analysis.png" alt="Power BI regional analysis" width="100%">
</p>
-->🧰 Technology Stack
Technology	How it is used
Python	Web scraping, data generation, and data preparation
Requests	Fetching web pages
BeautifulSoup	Parsing product information from HTML
pandas and NumPy	Data manipulation and preparation
SQLAlchemy and PyMySQL	Connecting Python to MySQL
MySQL	Storing product and sales tables
SQL	Aggregations, joins, subqueries, and window functions
Power BI	Dashboard creation and visual reporting
Jupyter Notebook	Developing and documenting the workflow


Prerequisites
- Python 3
- Jupyter Notebook
- MySQL Server 8.0 or later
- MySQL Workbench (recommended for running the SQL script)
- Power BI Desktop (to open the .pbix file; Windows required)

1. Install the Python dependencies
pip install pandas numpy matplotlib seaborn beautifulsoup4 requests sqlalchemy pymysql mysql-connector-python faker jupyter
2. Create the MySQL database
Start the MySQL server and create the database:
CREATE DATABASE sales_dashboard_db;
3. Configure the database connection securely
Before running the notebook, update its database-connection cell to read credentials from environment variables. Do not put a real database password directly in a notebook or commit it to GitHub.

For example, set these variables in your local environment:
- MYSQL_USER
- MYSQL_PASSWORD
- MYSQL_HOST
- MYSQL_PORT
- MYSQL_DATABASE
Then configure the SQLAlchemy connection in the notebook using those values. The current notebook contains a hard-coded database credential; rotate it immediately if it is or was a real password. Removing a password from the latest notebook version does not remove it from earlier Git commits.
6. Run the Jupyter notebook
jupyter notebook
Open Data_analysis_salesAutomation (1).ipynb and run its cells in order. The notebook collects product information, prepares the product catalog, generates the sample sales transactions, writes the CSV files, and loads the data into MySQL.
7. Execute the SQL analysis
Open Sales autoomation.sql in MySQL Workbench and run the queries against sales_dashboard_db.
8. Open the Power BI report
Open salesDashboard.pbix in Power BI Desktop. Configure the MySQL data source for your local environment and refresh the report if required.
⚠️ Data and Implementation Notes
- The source websites are demonstration/test sources, not a live retailer's internal data system.
- Merchandise records are generated using author names from the quotes demo website.
- Some product prices are converted using fixed multipliers in the notebook; these are demonstration conversions, not live exchange rates.
- Sales transactions, customer IDs, store assignments, discounts, and payment methods are generated by code. Re-running the notebook can produce a different sample dataset.
- The notebook currently replaces the products and sales tables when it writes them to MySQL. Back up any data you need before rerunning that step.
- The web-scraping code should be enhanced with request timeouts, error handling, and checks on each source page before being used in a more robust pipeline.
💡 Possible Next Improvements
- Add data validation and logging to the scraping and transformation steps.
- Move database settings into environment variables or a local .env file that is excluded from Git.
- Add a data dictionary and document the Power BI measures/KPI definitions.
- Make the data-loading process incremental instead of replacing tables.
- Add automated tests for transformation logic and SQL outputs.
- Add Power BI screenshots and a short project demo video.
👤 Author
Gourav Parmar
GitHub Profile
<div align="center">
  <sub>Python · Web Scraping · MySQL · SQL Analytics · Power BI</sub>
</div>
