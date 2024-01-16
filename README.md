# SQL Triggers Lab

## Overview

This repository contains SQL scripts for implementing triggers to update "year to date sales" values in a master table following INSERT, UPDATE, and DELETE operations on a sales table. The master table stores information about customers, items, or description services.

## Lab Scripts

### Lab4.txt

Author: Sujan Rokad  
Date: Oct 3, 2023  
Authorship statement: I, Sujan Rokad, student number 000882948, certify that this material is my original work. No other person's work has been used without due acknowledgment, and I have not made my work available to anyone else.

#### Contents:

- Setting NOCOUNT ON suppresses completion messages for each INSERT
- Set date format to year, month, day
- Create the mydatabase database
- Create customers and sales tables
- Insert customers and sales records
- Verify inserts
- Create a view displaying credit_limit higher than average

### Lab7.txt

Author: Sujan Rokad  
Date: Nov 14, 2023  
Authorship statement: I, Sujan Rokad, student number 000882948, certify that this material is my original work. No other person's work has been used without due acknowledgment, and I have not made my work available to anyone else.

#### Contents:

- Create INSERT, DELETE, and UPDATE triggers
- Verification and testing of triggers

## Usage Instructions

To run the scripts, follow these steps:

1. Open SQL Server Management Studio (SSMS) or another SQL database client.

2. Copy and paste the content of Lab4.txt into a new query window and execute the script.

3. Copy and paste the content of Lab7.txt into a new query window and execute the script.

4. Verify the results by checking the printed messages and querying the necessary tables.

## Important Notes

- Ensure that the necessary database (`mydatabase`) is created before executing Lab7.txt.
- Make sure to execute each script separately.

Feel free to customize these instructions based on your specific setup and requirements.
