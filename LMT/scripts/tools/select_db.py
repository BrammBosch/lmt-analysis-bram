import sqlite3
import sys
from scripts.tools.find_time_frames import find_start_end_file


def connection(table, *args):
    conn = sqlite3.connect(table)  # <- Connect to the database using the variable declared in main

    cursor = conn.cursor()

    start_frame, end_frame = find_start_end_file(table)
    print(start_frame,end_frame)

    if args != ():
        list_excluded_events = args[0]

        placeholder = '?'
        placeholders = ', '.join(placeholder for unused in list_excluded_events)

        query = "select * from EVENT where NAME NOT IN (%s) and STARTFRAME > ? and ENDFRAME < ? limit 10000" % placeholders


        list_excluded_events.append(start_frame)
        list_excluded_events.append(end_frame)

        val = tuple(list_excluded_events)
        cursor.execute(query, val)


    else:
        cursor.execute("select * from event limit 10000")

    results = cursor.fetchall()
    #print('The lenght of the results in bytes = ' + str(sys.getsizeof(results)))

    #print(results)

    # results = [list(elem) for elem in results]  # <- Change list of tuples to a list of lists
    return results


def connection_match(table):

    conn = sqlite3.connect(table)  # <- Connect to the database using the variable declared in main
    cursor = conn.cursor()

    query = "select * from EVENT where NAME = 'RFID MATCH' or NAME = 'RFID MISMATCH'"

    cursor.execute(query)

    results = cursor.fetchall()
    return results


def connection_rfid(table):
    conn = sqlite3.connect(table)  # <- Connect to the database using the variable declared in main
    cursor = conn.cursor()

    query = "select rfid from animal"

    cursor.execute(query)

    results = cursor.fetchall()
    results = [elem[0] for elem in results]
    return results