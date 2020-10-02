import sqlite3
import time
from multiprocessing import Process, Manager

animalResults = []


def main():
    table = 'C:/Users/Bram/Documents/radboud/LMT_data/28042020_20170048001_Group2_PreTreatment.sqlite'  # <- This string points to the table that is used as input
    frames = 15  # <- The amount of frames between events based on which the merge is performed
    start = time.time()

    results = connection(table)  # <- Here the even table is pulled
    print('The length of the entire table = ' + str(len(results)))
    results = sort_split(
        results)  # <- This takes the event table (2d list) as input and returns a 3d list sorted for each animal
    i = 0
    for animal in results:
        print("The length of animal " + str(i + 1) + " before merging = " + str(len(animal)))
        i += 1
    print("-" * 15)

    with Manager() as manager:
        animalResults = manager.list()  # <- declare a special list variable to be used by multiple processes

        processes = []
        for animal in results:  # <- for each animal a process is generated. Each process runs at the same time to optimise the program.
            p = Process(target=check_events, args=(animalResults, animal, frames))
            p.start()
            processes.append(p)
        for p in processes:
            p.join()
        animalResults = list(animalResults)

    i = 0
    totalLen = 0
    for result in animalResults:
        print('The length of animal ' + str(i + 1) + ' after merging = ' + str(len(result)))
        totalLen += len(result)
        i += 1
    print('The length of the entire table after merging = ' + str(totalLen))

    replace_table(table,
                  animalResults)  # <- This calls the function to replace the event table with the new merged events.
    end = time.time()
    print('time elapsed: ' + str(end - start))


def replace_table(table, animalResults):
    conn = sqlite3.connect(table)  # <- Connect to the database using the variable declared in main
    cursor = conn.cursor()
    cursor.execute(
        'DELETE FROM event')  # <- Delete the entire event table. This is faster than looking at each row to see where changes happened
    for animal in animalResults:
        for row in animal:
            sql = "INSERT INTO event VALUES (?,?,?,?,?,?,?,?,?)"  # <- Replace the event table row by row with the new merged events.
            val = (row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8])
            cursor.execute(sql, val)

    conn.commit()


def connection(table):
    conn = sqlite3.connect(table)  # <- Connect to the database using the variable declared in main

    cursor = conn.cursor()

    cursor.execute("select * from event")

    results = cursor.fetchall()
    results = [list(elem) for elem in results]  # <- Change list of tuples to a list of lists
    return results


def sort_split(results):
    animals = [[], [], [], []]

    for line in results:
        if line[5] == 1:
            animals[0].append(line)
        elif line[5] == 2:
            animals[1].append(line)
        elif line[5] == 3:
            animals[2].append(line)
        else:
            animals[3].append(line)

    animals[0] = sorted(animals[0], key=lambda x: ((x[6] is None, x[6]), (x[7] is None, x[7]), (x[8] is None, x[8]),
                                                   x[3]))  # <- Sort the 2d lists animals and then the start frame
    animals[1] = sorted(animals[1], key=lambda x: ((x[6] is None, x[6]), (x[7] is None, x[7]), (x[8] is None, x[8]),
                                                   x[3]))  # <- Sort the 2d lists animals and then the start frame
    animals[2] = sorted(animals[2], key=lambda x: ((x[6] is None, x[6]), (x[7] is None, x[7]), (x[8] is None, x[8]),
                                                   x[3]))  # <- Sort the 2d lists animals and then the start frame
    animals[3] = sorted(animals[3], key=lambda x: ((x[6] is None, x[6]), (x[7] is None, x[7]), (x[8] is None, x[8]),
                                                   x[3]))  # <- Sort the 2d lists animals and then the start frame

    return animals


def check_events(L, result, frames):
    listExcludedEvents = ['RFID ASSIGN ANONYMOUS TRACK',
                          'RFID MATCH',
                          'RFID MISMATCH',
                          'MACHINE LEARNING ASSOCIATION',
                          'Detection',
                          'Head detected'
                          ]  # <- All of these events are not looked at to merge
    try:
        for row in result:

            if result.index(row) + 1 == len(result):
                raise IndexError  # <- If the row that is checked it the last row it raises and catches an error to end the loop

            nextLine = result[result.index(row) + 1]

            if row[1] == nextLine[1] and row[5:] == nextLine[5:] and row[4] - nextLine[3] < frames and row[
                1] not in listExcludedEvents:  # <- If the event name is the same as the next row and the animals are the same as the next row
                # and the frame difference is less than the variable called in the main and the event name is not one of the exceptions
                same = True
                result[result.index(nextLine) - 1][4] = nextLine[4]

                result.remove(nextLine)
                while same:

                    nextLine = result[result.index(row) + 2]
                    if row[1] == nextLine[1] and row[5:] == nextLine[5:] and nextLine[3] - row[4] < frames and row[
                        1] not in listExcludedEvents:  # <- checks the same things as the previous if statements to see if there are more than 1 similar rows

                        result[result.index(nextLine) - 2][4] = nextLine[4]

                        result.remove(nextLine)
                    else:

                        same = False
    except IndexError:
        L.append(result)


if __name__ == '__main__':
    main()
