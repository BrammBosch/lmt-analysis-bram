import time
from collections import OrderedDict
from multiprocessing import Process, Manager

from code_bram.SVM.check_event_count import check_event_count
from lmtanalysis.FileUtil import getFilesToProcess
from scripts.tools.read_db_info import link_db_excel
from scripts.tools.find_time_frames import find_start_end_file
from scripts.tools.select_db import connection

allEventInformation = {}


def eventDuration(L, table):
    """
    This function looks at a database and returns a dictionary of each event with the average duration
    It returns a list of dictionaries with events and their average information and a list of dicts with all event durations.
    """
    listExcludedEvents = ['RFID ASSIGN ANONYMOUS TRACK',
                          'RFID MATCH',
                          'RFID MISMATCH',
                          'MACHINE LEARNING ASSOCIATION',
                          'Detection',
                          'Head detected'
                          ]
    start_frame, end_frame = find_start_end_file(table)

    results = connection(table, listExcludedEvents,start_frame,end_frame)
    animals = split(results)

    manager = Manager()
    d = manager.dict()
    processes = []
    for animal in animals:  # <- for each animal a process is generated. Each process runs at the same time to optimise the program.
        p = Process(target=find_event_information, args=(d, animal))
        p.start()
        processes.append(p)
    for p in processes:
        p.join()
    allEventInformation = dict(d)

    avgdict = {}

    for key in allEventInformation:
        avgdict[key] = Average(allEventInformation[key])
    L.append(avgdict)

    return L, allEventInformation


def Average(lst):
    """
    This functino calculates the average value of list
    """
    return sum(lst) / len(lst)


def find_event_information(allEventInformation, animal):
    """
    This function creates the dictionary for each animal with the event duration.
    It also corrects for some events that are not stored for each animal.
    """
    for row in animal:

        if (row[1], row[5], row[6], row[7], row[8]) not in allEventInformation:
            allEventInformation[(row[1], row[5], row[6], row[7], row[8])] = [row[4] - row[3]]
        else:
            newList = allEventInformation[(row[1], row[5], row[6], row[7], row[8])]
            newList.append(row[4] - row[3])
            allEventInformation[(row[1], row[5], row[6], row[7], row[8])] = newList

    if ('Group4', 4, 3, 2, 1) in allEventInformation:
        listGroup = allEventInformation[('Group4', 4, 3, 2, 1)]
        allEventInformation[('Group4', 3, 4, 2, 1)] = listGroup
        allEventInformation[('Group4', 2, 4, 3, 1)] = listGroup
        allEventInformation[('Group4', 1, 4, 3, 2)] = listGroup

    if ('Nest4', None, None, None, None) in allEventInformation:
        listNest = allEventInformation[('Nest4', None, None, None, None)]
        allEventInformation.pop(('Nest4', None, None, None, None))
        allEventInformation[('Group4', 4, 3, 2, 1)] = listNest
        allEventInformation[('Group4', 3, 4, 2, 1)] = listNest
        allEventInformation[('Group4', 2, 4, 3, 1)] = listNest
        allEventInformation[('Group4', 1, 4, 3, 2)] = listNest

    return allEventInformation


def split(results):
    """
    This function splits the original dataset in 4 parts for each of the animals
    """
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

    return animals

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

    with open("avg_all_events.txt", "w") as output:
        output.write(str(avg_all_events))

    with open("data_class.txt", "w") as output:
        output.write(str(data_class))
    return avg_all_events, data_class


if __name__ == '__main__':
    data = []
    table = 'D:/LMT_data_post/28042020_20170048001_Group2_PreTreatment.sqlite'  # <- This string points to the table that is used as input
    data, allData = eventDuration(data, table)
    print(data)
    # print(allData)
