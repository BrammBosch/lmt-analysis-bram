import sqlite3
import time


def main():
    start = time.time()

    framesRemoved = 15
    results = connection()
    animals = sort_split(results)
    print('The length of the table = ' + str(len(results)))
    results = None

    animalResults = []
    for animal in animals:
        animalResults.append(check_events(animal))
    i=0
    totalLen = 0
    for result in animalResults:

        print('The length of result'+ str(i)+ '= ' + str(len(result)))
        totalLen += len(result)
        i += 1
    print('The total length = ' + str(totalLen))
    end = time.time()
    print('time elapsed: ' + str(end - start))


def connection():
    conn = sqlite3.connect('C:/Users/Bram/Documents/radboud/LMT_data/28042020_20170048001_Group2_PreTreatment.sqlite')

    cursor = conn.cursor()

    cursor.execute("select * from event")

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


def check_events(result):
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



            if row[1] == nextLine[1] and row[5:] == nextLine[5:] and row[4] - nextLine[3] < 15 and row[1] not in listExcludedEvents:

                same = True
                while same:
                    nextLine = result[result.index(row) + 1]
                    if row[1] == nextLine[1] and row[5:] == nextLine[5:] and row[4] - nextLine[3] < 15 and row[
                        1] not in listExcludedEvents:
                        result[result.index(nextLine) - 1][4] = nextLine[4]

                        result.remove(nextLine)
                    else:
                        same = False
    except IndexError:
        return result


def merge_events(row, result):
    same = True


if __name__ == '__main__':
    main()
