import csv
import sqlite3

conn = sqlite3.connect('C:/Users/Bram/Documents/radboud/LMT_data_original/28042020_20170048001_Group2_PreTreatment.sqlite')

cursor = conn.cursor()

results = cursor.execute("select * from event").fetchall()
results = [list(elem) for elem in results]

with open("output.csv", "w") as csv_file:
    csv_writer = csv.writer(csv_file, delimiter=",")
    csv_writer.writerow([i[0] for i in cursor.description])
    csv_writer.writerows(results)

conn.close()