import os
import ntpath
import datetime

from scripts.tools.select_db import find_max_min_time, find_frames_db


def find_start_end_file_epoch(table):
    date = os.path.splitext(ntpath.basename(table))[0].split('_')[0]

    day = int(date[:2])
    month = int(date[2:4])
    year = int(date[4:])

    epoch_start = int(datetime.datetime(year, month, day, 10).timestamp()) * 1000
    epoch_end = int(datetime.datetime(year, month, day + 1, 9).timestamp()) * 1000

    return epoch_start, epoch_end


def find_start_end_file(table):
    """
    This function takes a file location and returns the frames for 10:00 and 09:00 the following day,
    being as close as possible to 23 hours

    """
    date = os.path.splitext(ntpath.basename(table))[0].split('_')[0]
    start_second = 0
    start_minute = 0
    start_hour = 10
    end_second = 59
    end_minute = 59
    end_hour = 8
    day = int(date[:2])
    month = int(date[2:4])
    year = int(date[4:])



    epoch_start = int(datetime.datetime(year, month, day, start_hour,start_minute,start_second).timestamp()) * 10
    if (month in [1, 3, 5, 7, 8, 10] and day == 31) or (month == 2 and day == 28) or (
            month in [4, 6, 9, 11] and day == 30):

        epoch_end = int(datetime.datetime(year, month + 1, 1, end_hour, end_minute, end_second).timestamp()) * 10

    elif month == 12 and day == 31:
        epoch_end = int(datetime.datetime(year + 1, 1, 1, end_hour, end_minute, end_second).timestamp()) * 10

    else:
        epoch_end = int(datetime.datetime(year, month, day + 1, end_hour, end_minute, end_second).timestamp()) * 10

    start_frame, end_frame = find_frames_db(table, str(epoch_start), str(epoch_end))

    # print(start_frame)
    # print(end_frame)
    start_frame = start_frame[0][0]
    end_frame = end_frame[0][0]
    return start_frame, end_frame


def find_frames(table, start_time, end_time):
    """
    This function takes a table, a start time and an end time.
    The start and end times are formatted as a list with 3 indexes like = [hour,minute,second]
    If the end time is before the start time the function assumes it should look at the next day for the end time.
    """

    date = os.path.splitext(ntpath.basename(table))[0].split('_')[0]

    day = int(date[:2])
    month = int(date[2:4])
    year = int(date[4:])

    epoch_start = int(datetime.datetime(year, month, day, start_time[0], start_time[1], start_time[2]).timestamp()) * 10

    print(start_time)
    print(end_time)
    wrong_input = False
    if start_time[0] == end_time[0]:
        if start_time[1] == end_time[1]:
            if start_time[2] == end_time[2]:
                print('the timestamps are the same')
                wrong_input = True
            elif start_time[2] < end_time[2]:
                next_day = False
            else:
                print('End time before start')
                wrong_input = True
        elif start_time[1] < end_time[1]:
            next_day = False
        else:
            print('End time before start')
            wrong_input = True
    elif start_time < end_time:
        next_day = False
    else:

        next_day = True
    if wrong_input != True:

        if next_day == False:
            epoch_end = int(datetime.datetime(year, month, day, end_time[0], end_time[1], end_time[2]).timestamp()) * 10
        else:
            epoch_end = int(
                datetime.datetime(year, month, day + 1, end_time[0], end_time[1], end_time[2]).timestamp()) * 10

        max_time, min_time = find_max_min_time(table)
        if epoch_end * 100 > max_time or epoch_start * 100 < min_time:
            print('The timestamps are not in the database')
            return None, None
        else:

            start_frame, end_frame = find_frames_db(table, epoch_start, epoch_end)

            start_frame = start_frame[0][0]
            end_frame = end_frame[0][0]

            return start_frame, end_frame
    else:
        return None, None
