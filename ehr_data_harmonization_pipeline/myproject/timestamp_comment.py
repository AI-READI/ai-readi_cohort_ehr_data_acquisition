from datetime import datetime
from zoneinfo import ZoneInfo

def comment(spark, dbname,table_name):
    timestamp = datetime.now(ZoneInfo('America/New_York')).strftime('%Y-%m-%d %H:%M:%S')
    comment = f"""Table created: {timestamp}"""
    spark.sql(f"""
    ALTER TABLE {dbname}.{table_name}
    SET TBLPROPERTIES ('comment' = '{comment}')
    """)
  