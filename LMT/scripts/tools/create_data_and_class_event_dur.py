import sqlite3
import time
from collections import OrderedDict
from multiprocessing import Process, Manager

from code_bram.SVM.check_event_count import check_event_count
from code_bram.SVM.find_event_duration import eventDuration
from lmtanalysis.FileUtil import getFilesToProcess
from scripts.tools.read_db_info import link_db_excel


def create_data_and_class():
    """
    This function controls the scripts that create the dataset and class list for files based on the event duration.
    """

    listExcludedEvents = ['RFID ASSIGN ANONYMOUS TRACK',
                          'RFID MATCH',
                          'RFID MISMATCH',
                          'MACHINE LEARNING ASSOCIATION',
                          'Detection',
                          'Head detected'
                          ]

    filenames = getFilesToProcess()  # <- Asks the user for a single of multiple files


    avg_all_events = []

    data_class = link_db_excel(filenames)  # <- This function looks at the excel file to return a list of classes

    start = time.time()

    with Manager() as manager:
        listDicts = manager.list()  # <- declare a special list variable to be used by multiple processes

        processes = []
        for file in filenames:  # <- for each file a process is generated. Each process runs at the same time to optimise the program.
            p = Process(target=eventDuration, args=(listDicts, file))
            p.start()
            processes.append(p)
        for p in processes:
            p.join()
        listDicts = list(listDicts)

    end = time.time()
    print('time elapsed calculating event data multiP: ' + str(end - start))

    list_events = check_event_count(filenames, listExcludedEvents)  # <- this function returns a list of all possible events.

    """
        This loop checks if each animal has performed each event at least once.
        If they don't, the event is added with an average time of 0 seconds.
    """

    for animalDict in list(listDicts):
        for event in list_events:
            for key in animalDict:
                if key[1] == event[1] and event not in animalDict:
                    animalDict[event] = 0
                    break


    """
        This loop goes past all animals and adds the average even duration to a list for each animal.
        Since the data for each animal is stored in a dictionary it is first sorted and put into an ordered dict.
        The end result is a 2d list with the average of all events in the same order in the lists.
    """

    i = 0

    for animalDict in listDicts:
        animalDict = OrderedDict(sorted(((k, v) for k, v in animalDict.items()), key=lambda v: (
            (v[0][1] is not None, v[0][1]), (v[0][2] is not None, v[0][2]), (v[0][3] is not None, v[0][3]), (v[0][4] is not None, v[0][4]),
            v[0][0])))

        for j in range(4):
            avg_all_events.append([])
        for key in animalDict:
            #print(key)

            if key[1] == 1:
                avg_all_events[i].append(animalDict[key])
            elif key[1] == 2:
                avg_all_events[i + 1].append(animalDict[key])
            elif key[1] == 3:
                avg_all_events[i + 2].append(animalDict[key])
            elif key[1] == 4:
                avg_all_events[i + 3].append(animalDict[key])
            else:
                pass
        i += 4

    return avg_all_events, data_class
