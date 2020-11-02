import sqlite3
import sys
from scripts.tools.find_time_frames import find_start_end_file


def connection(table, *args):
    conn = sqlite3.connect(table)  # <- Connect to the database using the variable declared in main

    cursor = conn.cursor()

    start_frame, end_frame = find_start_end_file(table)
    print(start_frame, end_frame)

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
    # print('The lenght of the results in bytes = ' + str(sys.getsizeof(results)))

    # print(results)

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


def connectioon_first_match(table):
    conn = sqlite3.connect(table)  # <- Connect to the database using the variable declared in main
    cursor = conn.cursor()

    query = "SELECT min(STARTFRAME) from event where name = 'RFID MATCH' and IDANIMALA = 1"

    cursor.execute(query)

    results1 = cursor.fetchall()[0][0]

    query = "SELECT min(STARTFRAME) from event where name = 'RFID MATCH' and IDANIMALA = 2"

    cursor.execute(query)

    results2 = cursor.fetchall()[0][0]

    query = "SELECT min(STARTFRAME) from event where name = 'RFID MATCH' and IDANIMALA = 3"

    cursor.execute(query)

    results3 = cursor.fetchall()[0][0]

    query = "SELECT min(STARTFRAME) from event where name = 'RFID MATCH' and IDANIMALA = 4"

    cursor.execute(query)

    results4 = cursor.fetchall()[0][0]

    list_match = [results1, results2, results3, results4]

    return list_match
