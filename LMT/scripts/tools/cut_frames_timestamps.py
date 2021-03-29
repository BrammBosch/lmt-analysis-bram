import sqlite3
import datetime
from lmtanalysis.FileUtil import getFilesToProcess
from scripts.tools.find_time_frames import find_start_end_file_epoch, find_start_end_file
import time

def cut_time_timestamps(file):
    start_epoch, end_epoch = find_start_end_file_epoch(file)
    print(start_epoch,end_epoch)
    conn = sqlite3.connect(file)  # <- Connect to the database using the variable declared in main
    cursor = conn.cursor()
    query = 'delete from frame where timestamp < ? or timestamp > ?'

    val = (start_epoch,end_epoch)
    cursor.execute(query, val)
    conn.commit()

def cut_event_table(file):
    start_frame, end_frame = find_start_end_file(file)
    print(start_frame,end_frame)
    listExcludedEvents = ['RFID ASSIGN ANONYMOUS TRACK',
                          'RFID MATCH',
                          'RFID MISMATCH',
                          'MACHINE LEARNING ASSOCIATION',
                          'Detection',
                          'Head detected'
                          ]

    conn = sqlite3.connect(file)  # <- Connect to the database using the variable declared in main
    cursor = conn.cursor()
    placeholder = '?'
    placeholders = ', '.join(placeholder for unused in listExcludedEvents)

    query = 'delete from event where name not in (%s) and (startframe < ? or endframe > ?)' %placeholders
    listExcludedEvents.append(start_frame)
    listExcludedEvents.append(end_frame)
    val = tuple(listExcludedEvents)
    cursor.execute(query, val)
    conn.commit()

if __name__ == '__main__':

    files = getFilesToProcess()
    for file in files:
        cut_event_table(file)
