import sqlite3

from code_bram.quality.check_match_mismatch import count_match_mismatch, time_mismatch_match
from lmtanalysis.FileUtil import getFilesToProcess
from scripts.tools.find_time_frames import find_frames

def difference_day_night(table):


    start_time = [19, 30, 0]
    end_time = [7, 30, 0]

    start_frame, end_frame = find_frames(table, start_time,
                                         end_time)
    #print(start_frame)
    #print(end_frame)
    conn = sqlite3.connect(table)  # <- Connect to the database using the variable declared in main
    cursor = conn.cursor()

    query = "select * from EVENT where (NAME = 'RFID MISMATCH' and (STARTFRAME > ? and STARTFRAME < ?)) or (NAME = 'RFID MATCH' and (STARTFRAME > ? and STARTFRAME < ?))"

    val = [start_frame, end_frame, start_frame, end_frame]
    cursor.execute(query, val)

    results_night = cursor.fetchall()

    results_night = sorted(results_night, key=lambda x: x[3])

    query = "select * from EVENT where (NAME = 'RFID MATCH' and (STARTFRAME < ? or STARTFRAME > ?)) or (NAME = 'RFID MISMATCH' and (STARTFRAME < ? or STARTFRAME > ?))"

    cursor.execute(query, val)
    results_day = cursor.fetchall()

    results_day = sorted(results_day, key=lambda x: x[3])

    times_night = time_mismatch_match(results_night)

    times_day = time_mismatch_match(results_day)

    i = 0

    count_night = count_match_mismatch(results_night)
    count_day = count_match_mismatch(results_day)
    print(table)
    for index in times_night:
        print('animal ' + str(i + 1))
        print('Matches day ' + str(count_day[0][i]))
        print('Mismatches day ' + str(count_day[1][i]))
        print('Matches night ' + str(count_night[0][i]))
        print('Mismatches night ' + str(count_night[1][i]))
        print('Average mismatch time night ' + str(sum(times_night[i]) / len(times_night[i])))
        print('Average mismatch time day ' + str(sum(times_day[i]) / len(times_day[i])))
        print('')
        i += 1
    print('------------------------------')

    for a in times_night:
        print(a)

if __name__ == '__main__':
    files = getFilesToProcess()
    for file in files:
        difference_day_night(file)

