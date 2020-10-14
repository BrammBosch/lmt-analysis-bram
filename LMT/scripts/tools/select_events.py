import sqlite3

def connection(table):
    conn = sqlite3.connect(
        table)  # <- Connect to the database using the variable declared in main

    cursor = conn.cursor()

    cursor.execute("select * from event limit 10000")

    results = cursor.fetchall()
    results = [list(elem) for elem in results]  # <- Change list of tuples to a list of lists
    return results