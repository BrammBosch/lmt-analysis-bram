import sqlite3
import time
from collections import defaultdict
from multiprocessing import Process, Manager
from multiprocessing import Pool
from multiprocessing.managers import BaseManager
from collections import defaultdict
from scripts.tools.select_events import connection



allEventInformation = {}


def eventDuration(table):

    listExcludedEvents = ['RFID ASSIGN ANONYMOUS TRACK',
                          'RFID MATCH',
                          'RFID MISMATCH',
                          'MACHINE LEARNING ASSOCIATION',
                          'Detection',
                          'Head detected'
                          ]
    start = time.time()

    results = connection(table)  # <- Here the even table is pulled
    print('The length of the entire table = ' + str(len(results)))
    listEvents = find_all_events(results, listExcludedEvents)
    print(listEvents)
    animals = sort_split(
        results)  # <- This takes the event table (2d list) as input and returns a 3d list sorted for each animal




    manager = Manager()
    d = manager.dict()
    processes = []
    for animal in animals:  # <- for each animal a process is generated. Each process runs at the same time to optimise the program.
        p = Process(target=find_event_information, args=(d, animal, listExcludedEvents))
        p.start()
        processes.append(p)
    for p in processes:
        p.join()
    allEventInformation = dict(d)

    #print(allEventInformation)

    # for animal in animals:
    #     d = find_event_information(allEventInformation,animal,listExcludedEvents)
    # print(d)

    end = time.time()
    print('time elapsed calculating event data: ' + str(end - start))
    return allEventInformation

def find_event_information(allEventInformation, animal, listExcludedEvents):
    for row in animal:
        if row[1] not in listExcludedEvents:
            if (row[1], row[5], row[6]) not in allEventInformation:
                allEventInformation[(row[1], row[5], row[6])] = [row[4] - row[3]]
            else:
                newList = allEventInformation[(row[1], row[5], row[6])]
                newList.append(row[4]-row[3])
                allEventInformation[(row[1], row[5], row[6])] = newList

    return allEventInformation


def find_all_events(results, listExcludedEvents):
    listEvents = []
    for row in results:
        if row[1] not in listExcludedEvents and row[1] not in listEvents:
            listEvents.append(row[1])

    return listEvents




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

    # animals[0] = sorted(animals[0], key=lambda x: ((x[6] is None, x[6]), (x[7] is None, x[7]), (x[8] is None, x[8]),
    #                                                x[3]))  # <- Sort the 2d lists animals and then the start frame
    # animals[1] = sorted(animals[1], key=lambda x: ((x[6] is None, x[6]), (x[7] is None, x[7]), (x[8] is None, x[8]),
    #                                                x[3]))  # <- Sort the 2d lists animals and then the start frame
    # animals[2] = sorted(animals[2], key=lambda x: ((x[6] is None, x[6]), (x[7] is None, x[7]), (x[8] is None, x[8]),
    #                                                x[3]))  # <- Sort the 2d lists animals and then the start frame
    # animals[3] = sorted(animals[3], key=lambda x: ((x[6] is None, x[6]), (x[7] is None, x[7]), (x[8] is None, x[8]),
    #                                                x[3]))  # <- Sort the 2d lists animals and then the start frame

    return animals


if __name__ == '__main__':
    table = 'C:/Users/Bram/Documents/radboud/LMT_data/28042020_20170048001_Group2_PreTreatment.sqlite'  # <- This string points to the table that is used as input
    data = eventDuration(table)
