import sqlite3
import time
from collections import OrderedDict
from multiprocessing import Process, Manager

import numpy as np

from code_bram.SVM.check_event_count import check_event_count
from code_bram.SVM.find_event_duration import eventDuration
from code_bram.SVM.simple_SVM import run_SVM
from lmtanalysis.FileUtil import getFilesToProcess
from scripts.tools.read_db_info import link_db_excel


def main():
    listExcludedEvents = ['RFID ASSIGN ANONYMOUS TRACK',
                          'RFID MATCH',
                          'RFID MISMATCH',
                          'MACHINE LEARNING ASSOCIATION',
                          'Detection',
                          'Head detected'
                          ]
    databases, filenames = database_connection()
    avg_all_events = []
    #print(filenames)
    data_class = link_db_excel(filenames)

    #print(data_class)
    #print(len(data_class))

    start = time.time()

    with Manager() as manager:
        listDicts = manager.list()  # <- declare a special list variable to be used by multiple processes

        processes = []
        for file in filenames:  # <- for each animal a process is generated. Each process runs at the same time to optimise the program.
            #print(file)
            p = Process(target=eventDuration, args=(listDicts, file))
            p.start()
            processes.append(p)
        for p in processes:
            p.join()
        listDicts = list(listDicts)

    end = time.time()
    print('time elapsed calculating event data multiP: ' + str(end - start))
    #print(listDicts)

    i = 0


    list_events = check_event_count(filenames,listExcludedEvents)

    #print(len(list_events))

    for animalDict in list(listDicts):
        print(list(listDicts))
        for event in list_events:
            for key in animalDict:

                if key[1] == event[1] and event not in animalDict:
                    animalDict[event] = 0
                    break



    for animalDict in listDicts:
        #print(animalDict)
        animalDict = OrderedDict(sorted(((k, v) for k, v in animalDict.items()), key=lambda v: (
            v[0][1], (v[0][2] is not None, v[0][2]), (v[0][3] is not None,v[0][3]), (v[0][4] is not None,v[0][4]), v[0][0])))

        print(animalDict)
        # print('-'*15)
        for j in range(4):
            avg_all_events.append([])
        for key in animalDict:
            if key[1] == 1:
                avg_all_events[i].append(animalDict[key])
            elif key[1] == 2:
                avg_all_events[i + 1].append(animalDict[key])
            elif key[1] == 3:
                avg_all_events[i + 2].append(animalDict[key])
            else:
                avg_all_events[i + 3].append(animalDict[key])

        i += 4


    # print(len(avg_all_events))

    #print(avg_all_events)


    for l in avg_all_events:
        print(len(l))
    for i in range(5):
        run_SVM(np.array(avg_all_events), data_class, i)
    # visualise_2_features(np.array(avg_all_events), data_class)




def database_connection():
    databases = []
    files = getFilesToProcess()
    for file in files:
        connection = sqlite3.connect(file)
        databases.append(connection)
    return databases, files


if __name__ == '__main__':
    main()
