import sqlite3
import os
import ntpath
import datetime


def find_start_end_file(table):
    date = os.path.splitext(ntpath.basename(table))[0].split('_')[0]

    day = int(date[:2])
    month = int(date[2:4])
    year = int(date[4:])

    epoch_start = int(datetime.datetime(year, month, day, 10).timestamp()) * 10
    epoch_end = int(datetime.datetime(year, month, day + 1, 9).timestamp()) * 10

    start_frame, end_frame = find_frames_db(table, str(epoch_start), str(epoch_end))

    start_frame = start_frame[0][0]
    end_frame = end_frame[0][0]

    print(start_frame)
    print(end_frame)
    print('-' * 15)


def find_frames(table, start_time, end_time):
    date = os.path.splitext(ntpath.basename(table))[0].split('_')[0]

    day = int(date[:2])
    month = int(date[2:4])
    year = int(date[4:])

    epoch_start = int(datetime.datetime(year, month, day, start_time[0], start_time[1], start_time[2]).timestamp()) * 10

    if start_time[0] == end_time[0]:
        if start_time[1] == end_time[1]:
            if start_time[2] == end_time[2]:
                print('the timestamps are the same')
            elif start_time[2] < end_time[2]:
                epoch_end = int(
                    datetime.datetime(year, month, day, end_time[0], end_time[1], end_time[2]).timestamp()) * 10
            else:
                print('End time before start')
        elif start_time[1] < end_time[1]:

            epoch_end = int(
                datetime.datetime(year, month, day, end_time[0], end_time[1], end_time[2]).timestamp()) * 10
        else:
            print('End time before start')
    elif start_time < end_time:

        epoch_end = int(datetime.datetime(year, month, day, end_time[0], end_time[1], end_time[2]).timestamp()) * 10
    else:

        epoch_end = int(datetime.datetime(year, month, day + 1, end_time[0], end_time[1], end_time[2]).timestamp()) * 10

    max_time, min_time = find_max_min_time(table)

    if epoch_end*100 > max_time or epoch_start*100 < min_time:
        print('The timestamps are not in the database')
        return None, None
    else:

        start_frame, end_frame = find_frames_db(table, epoch_start, epoch_end)

        start_frame = start_frame[0][0]
        end_frame = end_frame[0][0]

        return start_frame, end_frame


def find_max_min_time(table):
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

    print(result_start)
    print(result_end)
    return result_start, result_end
