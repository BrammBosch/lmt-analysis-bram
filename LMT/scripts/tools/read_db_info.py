import pandas as pd
from lmtanalysis.FileUtil import getFilesToProcess
import os
import sqlite3


def link_db_excel(files):
    """
    This function takes a list of files and looks at the location of these files for the excel file with information.
    It then returns a class list based on the wildtypes and mutants.
    """

    location = os.path.dirname(files[0])

    animal_info = []
    for file in files:
        animal_info.append(db_animals(
            file))  # <- This function returns a 2d list of all animals with their id in the database and their RFID

    overview = read_excel(
        location).values.tolist()  # <- This function returns a pandas dataframe with the excel information

    WT_HET = []


    """
        The loop here checks the database information against the excel file information and returns a class list.
        The class list is based on the order of the files.
        In this list the 0 represents a wildtype and the 1 a mutant.
    """
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
    """
    The excel file at the location of the files is read into a pandas dataframe.
    """
    os.chdir(location)
    location = location + '/' + 'overview_dataset.xlsx'
    xl_file = pd.read_excel(location)
    return xl_file


def db_animals(file):
    """
    This function returns the id and frid of each animal in the database
    """
    conn = sqlite3.connect(
        file)  # <- Connect to the database using the variable declared in main

    cursor = conn.cursor()

    cursor.execute("select ID, RFID from ANIMAL")

    results = cursor.fetchall()
    results = [list(elem) for elem in results]  # <- Change list of tuples to a list of lists
    return results


if __name__ == '__main__':
    files = getFilesToProcess()
    wt_het = link_db_excel(files)
    print(wt_het)
