import sqlite3
import datetime
from lmtanalysis.FileUtil import getFilesToProcess
from scripts.tools.find_time_frames import find_start_end_file_epoch
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


if __name__ == '__main__':

    files = getFilesToProcess()
    for file in files:
        cut_time_timestamps(file)
