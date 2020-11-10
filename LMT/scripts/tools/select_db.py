import sqlite3
import sys
from scripts.tools.find_time_frames import find_start_end_file


def connection(table, *args):
    """
    In this function all events are searched.
    If you only give a file location to this function it will pull all events.
    If you give it a list of excluded events it will exclude those events
    """
    conn = sqlite3.connect(table)  # <- Connect to the database using the variable declared in main

    cursor = conn.cursor()

    #print(start_frame, end_frame)

    if args != ():
        list_excluded_events = args[0]
        start_frame = args[1]
        end_frame = args[2]

        placeholder = '?'
        placeholders = ', '.join(placeholder for unused in list_excluded_events)

        query = "select * from EVENT where NAME NOT IN (%s) and STARTFRAME > ? and ENDFRAME < ? limit 1000" % placeholders

        list_excluded_events.append(start_frame)
        list_excluded_events.append(end_frame)

        val = tuple(list_excluded_events)
        cursor.execute(query, val)


    else:
        cursor.execute("select * from event")

    results = cursor.fetchall()
    # print('The lenght of the results in bytes = ' + str(sys.getsizeof(results)))

    # print(results)

    results = [list(elem) for elem in results]  # <- Change list of tuples to a list of lists
    return results


def connection_match(table):
    """
    This function returns all RFID MATCH and RFID MISMATCH events from the database.
    """
    conn = sqlite3.connect(table)  # <- Connect to the database using the variable declared in main
    cursor = conn.cursor()

    query = "select * from EVENT where NAME = 'RFID MATCH' or NAME = 'RFID MISMATCH'"

    cursor.execute(query)

    results = cursor.fetchall()
    return results


def connection_rfid(table):
    """
    This function returns a list of RFID's used in the database
    """
    conn = sqlite3.connect(table)  # <- Connect to the database using the variable declared in main
    cursor = conn.cursor()

    query = "select rfid from animal"

    cursor.execute(query)

    results = cursor.fetchall()
    results = [elem[0] for elem in results]
    return results

def find_max_min_time(table):
    """
    This function returns the highest and lowest timestamp value from the database
    """
    conn = sqlite3.connect(
        table)  # <- Connect to the database using the variable declared in main

    cursor = conn.cursor()

    cursor.execute("select max(TIMESTAMP) from FRAME")
    result_max = cursor.fetchall()
    result_max = result_max[0][0]
    cursor.execute("select min(TIMESTAMP) from FRAME")
    result_min = cursor.fetchall()
    result_min = result_min[0][0]

    return result_max, result_min


def find_frames_db(table, epoch_start, epoch_end):
    """
    This function returns the frames closest to the timestamps provided
    """
    conn = sqlite3.connect(
        table)  # <- Connect to the database using the variable declared in main

    cursor = conn.cursor()

    sql = "select * from FRAME where TIMESTAMP like '" + str(epoch_start) + "%'"
    cursor.execute(sql)
    result_start = cursor.fetchall()
    sql = "select * from FRAME where TIMESTAMP like '" + str(epoch_end) + "%'"
    cursor.execute(sql)
    result_end = cursor.fetchall()

    result_start = [list(elem) for elem in result_start]  # <- Change list of tuples to a list of lists
    result_end = [list(elem) for elem in result_end]  # <- Change list of tuples to a list of lists

    return result_start, result_end


def connection_first_match(table):
    """
    This function returns the first RFID MATCH event for each animal
    """

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
