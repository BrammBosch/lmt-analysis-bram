import pandas as pd
from lmtanalysis.FileUtil import getFilesToProcess
import os
import sqlite3
import glob

def link_db_excel(files):
    location = os.path.dirname(files[0])

    animal_info = []
    for file in files:
        animal_info.append(db_animals(file))

    overview = read_excel(location).values.tolist()

    WT_HET = []

    for row in animal_info:
        for animal in row:
            for info in overview:
                if animal[1] in info[1]:

                    if info[2] == 'WT':
                        WT_HET.append(0)
                    else:
                        WT_HET.append(1)
    return WT_HET


def read_excel(location):
    os.chdir(location)
    for file in glob.glob("*.xlsx"):
        location = location + '/' + file
    xl_file = pd.read_excel(location)
    return xl_file


def db_animals(file):
    conn = sqlite3.connect(
        file)  # <- Connect to the database using the variable declared in main

    cursor = conn.cursor()

    cursor.execute("select ID, RFID from ANIMAL")

    results = cursor.fetchall()
    results = [list(elem) for elem in results]  # <- Change list of tuples to a list of lists
    return results


def read_database_info(files):
    info = {}
    location = os.path.dirname(files[0])
    os.chdir(location)
    for file in glob.glob("*.xlsx"):
        location = location + '/' + file

    df = pd.read_excel(location)
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
            info[row[0]] = [[row[1], row[2], row[3]]]
        else:
            tempList = info[row[0]]
            tempList.append([[row[1], row[2], row[3]]])
            info[row[0]] = tempList
    return info


if __name__ == '__main__':
    files = getFilesToProcess()
    wt_het = link_db_excel(files)
