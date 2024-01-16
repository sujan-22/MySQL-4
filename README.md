# SQL Triggers Lab

## Overview

This repository contains SQL scripts for implementing triggers to update "year to date sales" values in a master table following INSERT, UPDATE, and DELETE operations on a sales table. The master table stores information about customers, items, or description services.

## Triggers

Three triggers have been implemented:

- **InsertTrigger.sql:** Trigger for handling INSERT operations on the sales table.
- **UpdateTrigger.sql:** Trigger for handling UPDATE operations on the sales table.
- **DeleteTrigger.sql:** Trigger for handling DELETE operations on the sales table.

### Bonus Feature

The triggers are designed to handle one row at a time. A bonus feature includes the ability to handle multiple rows being inserted,

## Usage Instructions

To implement the triggers and verify their functionality, follow these steps:

1. Execute the SQL script containing trigger creation statements. Ensure each trigger is followed by a `GO` statement.

2. Verify Trigger Functionality:

   ```sql
   -- Verification
   PRINT 'Verify triggers'
   PRINT 'Master Table Before Changes'
   -- SELECT all rows and columns from the master table

   -- INSERT a row into the sales table (ensure transaction amount is not zero, pick a large or unusual amount)
   PRINT 'After INSERT'
   -- SELECT all rows and columns from the master table

   -- DELETE the row that just got inserted in the sales table
   PRINT 'After DELETE'
   -- SELECT all rows and columns from the master table

   -- UPDATE the transaction amount in one row in the sales table (ensure transaction amount is not zero, pick a large or unusual amount)
   PRINT 'After UPDATE'
   -- SELECT all rows and columns from the master table
