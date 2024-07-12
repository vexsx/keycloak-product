#!/bin/bash
set -e

# Wait for the SQL Server to be available
echo "Waiting for SQL Server to be available..."
until /opt/mssql-tools/bin/sqlcmd -S sqlserver -U sa -P "${SQLSERVER_PASSWORD}" -Q "SELECT 1" &> /dev/null
do
  echo "SQL Server is unavailable - sleeping"
  sleep 1
done

echo "SQL Server is up - executing script"
/opt/mssql-tools/bin/sqlcmd -S sqlserver -U sa -P "${SQLSERVER_PASSWORD}" -i /scripts/create_database.sql

echo "Script executed successfully"