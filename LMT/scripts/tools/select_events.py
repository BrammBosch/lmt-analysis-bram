import sqlite3
import sys


def connection(table, *args):
    conn = sqlite3.connect(table)  # <- Connect to the database using the variable declared in main

    cursor = conn.cursor()

    # SQL_Query = pd.read_sql("select * from event", conn)
    # df = pd.DataFrame(SQL_Query)

    if args != ():
        list_excluded_events = args[0]

        placeholder = '?'
        placeholders = ', '.join(placeholder for unused in list_excluded_events)

        query = "select * from event where NAME NOT IN (%s) limit 10000" % placeholders

        cursor.execute(query, list_excluded_events)

    else:
        cursor.execute("select * from event")

    results = cursor.fetchall()
    #print('The lenght of the results in bytes = ' + str(sys.getsizeof(results)))

    #results = [list(elem) for elem in results]  # <- Change list of tuples to a list of lists
    return results
