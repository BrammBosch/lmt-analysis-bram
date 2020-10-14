import sqlite3
import time
from scripts.tools.select_events import connection


def main():
    start = time.time()
    table = 'C:/Users/Bram/Documents/radboud/LMT_data/28042020_20170048001_Group2_PreTreatment.sqlite'  # <- This string points to the table that is used as input
    framesRemoved = 15
    results = connection(table)
    animals = sort_split(results)
    print('The length of the table = ' + str(len(results)))
    results = None


    i = 0
    for animal in animals:

        print('The length of the table from animal ' + str(i) + ' before merging = ' + str(len(animals[i])))
        try:
            animals[i] = check_next_event(animal, 0,framesRemoved)
        except IndexError:
            pass
        print('The length of the table from animal ' + str(i) + ' after merging= ' + str(len(animals[i])))
        i += 1



    end = time.time()
    print('time elapsed: ' + str(end - start))




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


def check_next_event(results, i, framesRemoved):
    listExcludedEvents = ['RFID ASSIGN ANONYMOUS TRACK',
                          'RFID MATCH',
                          'RFID MISMATCH'
                          'MACHINE LEARNING ASSOCIATION',
                          'Detection'
                          'Head detected'
                          ]
    for row in results[i:]:
        # print('Next event')
        # print(len(results))
        # print(results.index(row) + 1)
        if results.index(row) + 1 == len(results):
            raise IndexError

        nextLine = results[results.index(row) + 1]

        if row[1] == nextLine[1] and row[5:] == nextLine[5:] and row[4] - nextLine[3] < framesRemoved and row[
            1] not in listExcludedEvents:
            newResults = merge_events(results, nextLine)

            check_next_event(newResults, newResults.index(row),15)

    return results


def merge_events(results, lineToRemove):
    results[results.index(lineToRemove) - 1][4] = lineToRemove[4]
    results.remove(lineToRemove)
    # print('removed')
    return results


if __name__ == '__main__':
    main()
