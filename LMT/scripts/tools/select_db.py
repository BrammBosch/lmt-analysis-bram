import sqlite3
import sys


def connection(table, *args):
    """
    In this function all events are searched.
    If you only give a file location to this function it will pull all events.
    If you give it a list of excluded events it will exclude those events
    """
    conn = sqlite3.connect(table)  # <- Connect to the database using the variable declared in main

    cursor = conn.cursor()

    # print(start_frame, end_frame)

    if len(args) == 3:
        list_excluded_events = args[0]
        start_frame = args[1]
        end_frame = args[2]

        placeholder = '?'
        placeholders = ', '.join(placeholder for unused in list_excluded_events)

        query = "select * from EVENT where NAME NOT IN (%s) and STARTFRAME > ? and ENDFRAME < ?" % placeholders

        list_excluded_events.append(start_frame)
        list_excluded_events.append(end_frame)

        val = tuple(list_excluded_events)
        cursor.execute(query, val)
    elif len(args) == 1:

        list_excluded_events = args[0]

        placeholder = '?'
        placeholders = ', '.join(placeholder for unused in list_excluded_events)

        query = "select * from EVENT where NAME NOT IN (%s)" % placeholders

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


def connection_location(table, startframe, endframe):
    """
    This function returns the location data from a database in a certain timeframe
    """
    conn = sqlite3.connect(table)  # <- Connect to the database using the variable declared in main
    cursor = conn.cursor()
    framenumbers = [startframe, endframe]

    query = "select ANIMALID, MASS_X, MASS_Y, FRAMENUMBER,FRONT_X from DETECTION where FRAMENUMBER > ? and FRAMENUMBER < ?"
    cursor.execute(query, framenumbers)
    results = cursor.fetchall()
    results = [list(elem) for elem in results]
    return results


def connection_unique_events(table, list_excluded_events):
    """
    This function returns all unique events in a database except the events in the list_excluded_events list
    """
    conn = sqlite3.connect(table)  # <- Connect to the database using the variable declared in main
    cursor = conn.cursor()

    placeholder = '?'
    placeholders = ', '.join(placeholder for unused in list_excluded_events)

    query = "select DISTINCT name,IDANIMALA,IDANIMALB,IDANIMALC,IDANIMALD from EVENT where NAME NOT IN (%s)" % placeholders

    val = tuple(list_excluded_events)
    cursor.execute(query, val)

    results = cursor.fetchall()
    # results = [list(elem) for elem in results]
    # print(results)
    return results


def connection_events_in_time_frame(table, list_excluded_events, start_frame, end_frame):
    """
    This function returns all the events for a database except the events in the list_excluded_events list.
    """

    conn = sqlite3.connect(table)

    cursor = conn.cursor()
    placeholder = '?'
    placeholders = ', '.join(placeholder for unused in list_excluded_events)

    query = "select name,startframe,endframe,idanimala, idanimalb,idanimalc,idanimald from EVENT where NAME NOT IN (%s) and STARTFRAME > ? and ENDFRAME < ?" % placeholders

    list_excluded_events.append(start_frame)
    list_excluded_events.append(end_frame)

    val = tuple(list_excluded_events)
    cursor.execute(query, val)
    list_excluded_events.pop()
    list_excluded_events.pop()
    results = cursor.fetchall()
    return results


def connection_list_events_in_time_frame(table, list_events, start_frame, end_frame):
    """
    This function returns all the events for a database if the event name is in the list_events list.
    """
    conn = sqlite3.connect(table)

    cursor = conn.cursor()
    placeholder = '?'
    placeholders = ', '.join(placeholder for unused in list_events)

    query = "select name,startframe,endframe,idanimala, idanimalb,idanimalc,idanimald from EVENT where NAME IN (%s) and STARTFRAME > ? and ENDFRAME < ?" % placeholders

    list_events.append(start_frame)
    list_events.append(end_frame)

    val = tuple(list_events)
    cursor.execute(query, val)
    list_events.pop()
    list_events.pop()
    results = cursor.fetchall()
    return results
