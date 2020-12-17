from code_bram.quality.check_match_mismatch import match_mismatch_main
from lmtanalysis.FileUtil import getFilesToProcess
from scripts.tools.find_time_frames import find_start_end_file
import sqlite3
from scripts.tools.find_time_frames import find_start_end_file, find_frames





def difference_day_night(table):
    #table = 'D:\LMT_data_post/11052020_20170048001_Group3_PreTreatment.sqlite'

    start_time = [19,30,0]
    end_time = [7,0,0]


    start_frame, end_frame = find_frames(table, start_time,
        end_time)
    conn = sqlite3.connect(table)  # <- Connect to the database using the variable declared in main
    cursor = conn.cursor()

    query = "select * from EVENT where NAME = 'RFID MISMATCH' and STARTFRAME > ? and STARTFRAME < ? or NAME = 'RFID MATCH' and STARTFRAME > ? and STARTFRAME < ?"

    val = [start_frame,end_frame,start_frame, end_frame]
    cursor.execute(query,val)

    results_night = cursor.fetchall()

    query = "select * from EVENT where NAME = 'RFID MISMATCH'  and STARTFRAME < ? or STARTFRAME > ? or NAME = 'RFID MATCH' and STARTFRAME < ? or STARTFRAME > ?"

    cursor.execute(query,val)
    results_day = cursor.fetchall()


    tempMatch1 = 0
    tempMatch2 = 0
    tempMatch3 = 0
    tempMatch4 = 0
    last_match = [[], [], [], []]
    time_mismatch_last_match = [[], [], [], []]

    j=0
    for row in results_night:
        if row[1] == 'RFID MISMATCH':
            j+= 1

    print('count mismatch night ' + str(j))

    k = 0
    for row in results_day:
        if row[1] == 'RFID MISMATCH':
            k += 1

    print('count mismatch day ' + str(k))


    for row in results_night:
        if row[1] == 'RFID MISMATCH':

            if row[5] == 1:
                #print('time between is: ' + str(row[3]) + str(' ') + str(tempMatch1) + ' for mouse 1')
                #print(row[3]-tempMatch1)

                last_match[0].append(tempMatch1)
                time_mismatch_last_match[0].append(row[3] - tempMatch1)

            elif row[5] == 2:
                last_match[1].append(tempMatch2)
                time_mismatch_last_match[1].append(row[3] - tempMatch2)

            elif row[5] == 3:
                last_match[2].append(tempMatch3)
                time_mismatch_last_match[2].append(row[3] - tempMatch3)

            elif row[5] == 4:
                last_match[3].append(tempMatch4)
                time_mismatch_last_match[3].append(row[3] - tempMatch4)

        if row[5] == 1:
            #print(row)
            tempMatch1 = row[3]
        elif row[5] == 2:
            tempMatch2 = row[3]
        elif row[5] == 3:
            tempMatch3 = row[3]
        else:
            tempMatch4 = row[3]

    i = 0

    atempMatch1 = 0
    atempMatch2 = 0
    atempMatch3 = 0
    atempMatch4 = 0
    alast_match = [[], [], [], []]
    atime_mismatch_last_match = [[], [], [], []]

    for row in results_day:
        if row[1] == 'RFID MISMATCH':

            if row[5] == 1:
                #print('time between is: ' + str(row[3]) + str(' ') + str(tempMatch1) + ' for mouse 1')
                #print(row[3]-tempMatch1)

                alast_match[0].append(atempMatch1)
                atime_mismatch_last_match[0].append(row[3] - atempMatch1)

            elif row[5] == 2:
                alast_match[1].append(atempMatch2)
                atime_mismatch_last_match[1].append(row[3] - atempMatch2)

            elif row[5] == 3:
                alast_match[2].append(atempMatch3)
                atime_mismatch_last_match[2].append(row[3] - atempMatch3)

            elif row[5] == 4:
                alast_match[3].append(atempMatch4)
                atime_mismatch_last_match[3].append(row[3] - atempMatch4)

        if row[5] == 1:
            #print(row)
            atempMatch1 = row[3]
        elif row[5] == 2:
            atempMatch2 = row[3]
        elif row[5] == 3:
            atempMatch3 = row[3]
        else:
            atempMatch4 = row[3]

    i = 0

    for animal in time_mismatch_last_match:
        print('average time mismatch night ' + str(sum(time_mismatch_last_match[i])/len(time_mismatch_last_match[i])))
        i+= 1

    i = 0
    for animal in atime_mismatch_last_match:
        print('average time mismatch day ' + str(sum(atime_mismatch_last_match[i])/len(atime_mismatch_last_match[i])))
        i+= 1

if __name__ == '__main__':
    files = getFilesToProcess()
    for file in files:
        difference_day_night(file)

