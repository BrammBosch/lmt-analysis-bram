import sqlite3
import time
from multiprocessing import Process, Manager
from scripts.tools.select_db import connection
from scripts.tools.sort_split import sort_split
from lmtanalysis.FileUtil import getFilesToProcess

animalResults = []


def main_event_merge(table):
    frames = 15  # <- The amount of frames between events based on which the merge is performed
    listExcludedEvents = ['RFID ASSIGN ANONYMOUS TRACK',
                          'RFID MATCH',
                          'RFID MISMATCH',
                          'MACHINE LEARNING ASSOCIATION',
                          'Detection',
                          'Head detected'
                          ]  # <- All of these events are not looked at to merge
    start = time.time()

    results = connection(table, listExcludedEvents)  # <- Here the even table is pulled
    print('The length of the entire table = ' + str(len(results)))
    #results = sort_split(results)  # <- This takes the event table (2d list) as input and returns a 3d list sorted for each animal
    # i = 0
    # for animal in results:
    #     print("The length of animal " + str(i + 1) + " before merging = " + str(len(animal)))
    #     i += 1
    # print("-" * 15)

    animals = []
    unique_event = []

    for line in results:
        if line[1] not in unique_event:
            unique_event.append(line[1])
            animals.append([])

        animals[unique_event.index(line[1])].append(line)

    it = 0
    for animal in animals:
        animals[it] = sorted(animals[it], key=lambda x: (x[5], (x[6] is None, x[6]), (x[7] is None, x[7]), (x[8] is None, x[8]),
                                                   x[1], x[3]))
        it+= 1


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

    i = 0
    totalLen = 0
    for result in animalResults:
    #     print('The length of animal ' + str(i + 1) + ' after merging = ' + str(len(result)))
        totalLen += len(result)
    #     i += 1
    print('The length of the entire table after merging = ' + str(totalLen))

    #replace_table(table, animalResults)  # <- This calls the function to replace the event table with the new merged events.
    end = time.time()
    print('time elapsed: ' + str(end - start))


def replace_table(table, animalResults):
    conn = sqlite3.connect(table)  # <- Connect to the database using the variable declared in main
    cursor = conn.cursor()
    cursor.execute(
        'DELETE FROM event')  # <- Delete the entire event table. This is faster than looking at each row to see where changes happened
    for animal in animalResults:
        for row in animal:
            sql = "INSERT INTO event VALUES (?,?,?,?,?,?,?,?,?,?)"  # <- Replace the event table row by row with the new merged events.
            val = (row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], '{}')
            cursor.execute(sql, val)

    conn.commit()


def check_events(L, result, frames):
    try:
        k = 0
        for row in result:
            #print(row)
            if result.index(row) + 1 == len(result):
                raise IndexError  # <- If the row that is checked it the last row it raises and catches an error to end the loop

            nextLine = result[result.index(row) + 1]

            if row[1] == nextLine[1] and row[5:] == nextLine[5:] and nextLine[3] - row[
                4] < frames:  # <- If the event name is the same as the next row and the animals are the same as the next row
                # and the frame difference is less than the variable called in the main
                same = True
                # print(row[4])
                # print(nextLine[3])
                # print(nextLine[3] - row[4])
                #
                # print('merging with:')
                # print(nextLine)

                result[result.index(row)][4] = nextLine[4]

                result.remove(nextLine)
                while same:

                    nextLine = result[result.index(row) + 1]

                    if row[1] == nextLine[1] and row[5:] == nextLine[5:] and nextLine[3] - row[
                        4] < frames:  # <- checks the same things as the previous if statements to see if there are more than 1 similar rows
                        result[result.index(row)][4] = nextLine[4]
                        # print('merging with:')
                        # print(nextLine)
                        result.remove(nextLine)
                    else:
                        same = False
            k += 1
            #print(' ')


    except IndexError:
        L.append(result)


if __name__ == '__main__':
    files = getFilesToProcess()
    for file in files:
        main_event_merge(file)
    # table = 'C:/Users/Bram/Documents/radboud/LMT_data/28042020_20170048001_Group2_PreTreatment.sqlite'  # <- This string points to the table that is used as input
