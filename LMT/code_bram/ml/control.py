import math
import ntpath
import os
import pandas as pd
import sqlite3
from lmtanalysis.FileUtil import getFilesToProcess
from code_bram.ml.find_event_duration import eventDuration
from code_bram.ml.simple_SVM import run_SVM


def main():
    info = read_database_info()
    databases,filenames = database_connection()
    print(info)
    print(databases)
    print(filenames)
    data = eventDuration('C:/Users/Bram/Documents/radboud/LMT_data/28042020_20170048001_Group2_PreTreatment.sqlite')
    print(data)

    run_SVM()

def get_all_events_sequential():
    pass

def database_connection():
    databases = []
    fileNames = []
    files = getFilesToProcess()
    for file in files:
        fileNames.append(os.path.splitext(ntpath.basename(file))[0])
        # connect to database
        connection = sqlite3.connect(file)
        databases.append(connection)
    return databases, fileNames

def read_database_info():
    info = {}
    df = pd.read_excel(r'C:/Users/Bram/Documents/radboud/LMT_data_original/overview_dataset.xlsx')
    for index, row in df.iterrows():
        if row[2] == 'WT':
            row[2] = 0
        else:
            row[2] = 1

        if isinstance(row[0], str):
            fileName = row[0]
        else:
            row[0] = fileName
    for index, row in df.iterrows():
        if row[0] not in info:
            info[row[0]] = [[row[1],row[2],row[3]]]
        else:
            tempList = info[row[0]]
            tempList.append([[row[1],row[2],row[3]]])
            info[row[0]]=tempList
    return info

if __name__ == '__main__':
    main()