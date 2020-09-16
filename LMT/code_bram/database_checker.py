import sqlite3

conn = sqlite3.connect('C:/Users/Bram/Downloads/11052020_20170048001_Group3_PreTreatment.sqlite')

cursor = conn.cursor()

output = cursor.execute("select * from animal").fetchall()

print(output)