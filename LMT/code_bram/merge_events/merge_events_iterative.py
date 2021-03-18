import sqlite3
import time
from multiprocessing import Process, Manager

from lmtanalysis.FileUtil import getFilesToProcess
from scripts.tools.find_time_frames import find_start_end_file
from scripts.tools.select_db import connection

animalResults = []


def main_event_merge(table):
    """
    If this function is called with a file location it will replace all events with their merged versions.
    """

    frames = 15  # <- The amount of frames between events based on which the merge is performed
    listExcludedEvents = ['RFID ASSIGN ANONYMOUS TRACK',
                          'RFID MATCH',
                          'RFID MISMATCH',
                          'MACHINE LEARNING ASSOCIATION',
                          'Detection',
                          'Head detected'
                          ]  # <- All of these events are not looked at to merge
    start = time.time()
    start_frame, end_frame = find_start_end_file(table)

    results = connection(table, listExcludedEvents, start_frame, end_frame)  # <- Here the even table is pulled
    print('The length of the entire table = ' + str(len(results)))

    animals = []
    unique_event = []

    """
        This for loop sorts all events based on their name
    """

    for line in results:
        if line[1] not in unique_event:
            unique_event.append(line[1])
            animals.append([])

        animals[unique_event.index(line[1])].append(line)

    """
        This loop sorts each list of events based on the animals and the start frames
    """
    it = 0

    for animal in animals:
        animals[it] = sorted(animals[it],
                             key=lambda x: (x[5], (x[6] is None, x[6]), (x[7] is None, x[7]), (x[8] is None, x[8]),
                                            x[1], x[3]))
        it += 1

    """
    This loops over all of the events and calls the merging script.
    It uses a pool manager to multiprocess the scripts to optimise the program.
    """
    with Manager() as manager:
        animalResults = manager.list()  # <- declare a special list variable to be used by multiple processes

        processes = []
        for event in animals:  # <- for each animal a process is generated. Each process runs at the same time to optimise the program.
            p = Process(target=check_events, args=(animalResults, event, frames))
            p.start()
            processes.append(p)
        for p in processes:
            p.join()
        animalResults = list(animalResults)

    totalLen = 0
    for result in animalResults:
        totalLen += len(result)
    print('The length of the entire table after merging = ' + str(totalLen))

    replace_table(table, animalResults,
                  listExcludedEvents)  # <- This calls the function to replace the event table with the new merged events.
    end = time.time()
    print('time elapsed: ' + str(end - start))


def replace_table(table, animalResults, list_excluded_events):
    """
    This functions deletes the existing event table and completely replaces it with the new merged events table
    """


    conn = sqlite3.connect(table)  # <- Connect to the database using the variable declared in main
    cursor = conn.cursor()
    print('Replacing')

    placeholder = '?'
    placeholders = ', '.join(placeholder for unused in list_excluded_events)

    query = 'DELETE FROM event WHERE name not in (%s)' % placeholders

    val = tuple(list_excluded_events)
    cursor.execute(query, val)

    for animal in animalResults:
        for row in animal:
            sql = "INSERT INTO event VALUES (?,?,?,?,?,?,?,?,?,?)"  # <- Replace the event table row by row with the new merged events.
            val = (row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8],'{}')
            cursor.execute(sql, val)

    conn.commit()


def check_events(L, result, frames):
    """
    This function is where each row is compared to the row after is to see if they should be merged.
    """
    try:
        k = 0
        listTime = []
        for row in result:
            start = time.time()

            if result.index(row) + 1 == len(result):
                raise IndexError  # <- If the row that is checked it the last row it raises and catches an error to end the loop

            nextLine = result[result.index(row) + 1]

            if row[1] == nextLine[1] and row[5:] == nextLine[5:] and nextLine[3] - row[
                4] < frames:  # <- If the event name is the same as the next row and the animals are the same as the next row
                # and the frame difference is less than the variable called in the main
                same = True

                result[result.index(row)][4] = nextLine[4]

                result.remove(nextLine)
                while same:

                    nextLine = result[result.index(row) + 1]

                    if row[1] == nextLine[1] and row[5:] == nextLine[5:] and nextLine[3] - row[
                        4] < frames:  # <- checks the same things as the previous if statements to see if there are more than 1 similar rows
                        result[result.index(row)][4] = nextLine[4]

                        result.remove(nextLine)
                    else:
                        same = False
            k += 1

            end = time.time()
            listTime.append(end - start)

    except IndexError:
        print(result[0][1])
        if len(listTime) > 0:
            print('avg time ' + str(sum(listTime) / len(listTime)))
            print('len ' + str(len(listTime)))
            print('-' * 15)
        L.append(result)


if __name__ == '__main__':
    files = getFilesToProcess()
    for file in files:
        main_event_merge(file)
    # table = 'C:/Users/Bram/Documents/radboud/LMT_data/28042020_20170048001_Group2_PreTreatment.sqlite'  # <- This string points to the table that is used as input
