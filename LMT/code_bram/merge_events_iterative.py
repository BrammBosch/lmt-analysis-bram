import sqlite3
import time
from multiprocessing import Process, Manager

animalResults = []


def multiMain():
    table = 'C:/Users/Bram/Documents/radboud/LMT_data/28042020_20170048001_Group2_PreTreatment.sqlite'
    start = time.time()

    results = connection(table)
    animals = sort_split(results)
    print('The length of the table = ' + str(len(results)))
    results = None
    frames = 15
    with Manager() as manager:
        animalResults = manager.list()

        processes = []
        for animal in animals:
            p = Process(target=check_events, args=(animalResults, animal,frames))
            p.start()
            processes.append(p)
        for p in processes:
            p.join()
        animalResults = list(animalResults)

    i = 0
    totalLen = 0
    for result in animalResults:
        print('The length of result ' + str(i + 1) + '= ' + str(len(result)))
        totalLen += len(result)
        i += 1
    print('The total length = ' + str(totalLen))

    replace_table(table, animalResults)
    end = time.time()
    print('time elapsed: ' + str(end - start))


def replace_table(table, animalResults):
    conn = sqlite3.connect(table)
    cursor = conn.cursor()
    cursor.execute('DELETE FROM event')
    # print(animalResults)
    for animal in animalResults:
        for row in animal:
            # print(row)
            sql = "INSERT INTO event VALUES (?,?,?,?,?,?,?,?,?)"
            val = (row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8])
            # print(sql,val)
            cursor.execute(sql, val)

    conn.commit()


def connection(table):
    conn = sqlite3.connect(
        "C:/Users/Bram/Documents/radboud/LMT_data_original/28042020_20170048001_Group2_PreTreatment.sqlite")

    cursor = conn.cursor()

    cursor.execute("select * from event limit 10000")

    results = cursor.fetchall()
    results = [list(elem) for elem in results]
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

    animals[0] = sorted(animals[0], key=lambda x: (x[3]))
    animals[1] = sorted(animals[1], key=lambda x: (x[3]))
    animals[2] = sorted(animals[2], key=lambda x: (x[3]))
    animals[3] = sorted(animals[3], key=lambda x: (x[3]))

    return animals


def check_events(L, result,frames):
    listExcludedEvents = ['RFID ASSIGN ANONYMOUS TRACK',
                          'RFID MATCH',
                          'RFID MISMATCH',
                          'MACHINE LEARNING ASSOCIATION',
                          'Detection',
                          'Head detected'
                          ]
    try:
        for row in result:

            if result.index(row) + 1 == len(result):
                raise IndexError

            nextLine = result[result.index(row) + 1]

            if row[1] == nextLine[1] and row[5:] == nextLine[5:] and row[4] - nextLine[3] < frames and row[
                1] not in listExcludedEvents:
                # print(str(row[0]) +' '+ row[1])
                same = True
                while same:
                    nextLine = result[result.index(row) + 1]
                    if row[1] == nextLine[1] and row[5:] == nextLine[5:] and row[4] - nextLine[3] < frames and row[
                        1] not in listExcludedEvents:
                        result[result.index(nextLine) - 1][4] = nextLine[4]

                        result.remove(nextLine)
                    else:
                        same = False
    except IndexError:
        L.append(result)


if __name__ == '__main__':
    multiMain()
