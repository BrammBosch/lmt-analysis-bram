# from scripts.tools.select_events import connection
import datetime
import sqlite3
import os
import ntpath
from scripts.tools.find_time_frames import find_start_end_file, find_frames



if __name__ == '__main__':
    tables = ['C:/Users/Bram/Documents/radboud/LMT_data/11052020_20170048001_Group3_PreTreatment.sqlite',
              'C:/Users/Bram/Documents/radboud/LMT_data/12052020_20170048001_Group4_PreTreatment.sqlite',
              'C:/Users/Bram/Documents/radboud/LMT_data/13052020_20170048001_Group5_PreTreatment.sqlite',
              'C:/Users/Bram/Documents/radboud/LMT_data/24082020_20170048002_Group1_PreTreatment.sqlite',
              'C:/Users/Bram/Documents/radboud/LMT_data/25082020_20170048002_Group2_PreTreatment.sqlite',
              'C:/Users/Bram/Documents/radboud/LMT_data/26082020_20170048002_Group3_PreTreatment.sqlite',
              'C:/Users/Bram/Documents/radboud/LMT_data/28042020_20170048001_Group2_PreTreatment.sqlite']
    # for table in tables:
    #     find_start_end_file(table)

    start_time = [9,40,16]
    end_time = [12,15,17]
    start_frame, end_frame = find_frames('C:/Users/Bram/Documents/radboud/LMT_data/28042020_20170048001_Group2_PreTreatment.sqlite',start_time,end_time)

    print(start_frame)
    print(end_frame)

