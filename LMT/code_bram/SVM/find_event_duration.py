from multiprocessing import Process, Manager

from scripts.tools.select_events import connection

allEventInformation = {}


def eventDuration(L, table):
    listExcludedEvents = ['RFID ASSIGN ANONYMOUS TRACK',
                          'RFID MATCH',
                          'RFID MISMATCH',
                          'MACHINE LEARNING ASSOCIATION',
                          'Detection',
                          'Head detected'
                          ]

    results = connection(table, listExcludedEvents)  # <- Here the event table is pulled
    #print('The length of the entire table = ' + str(len(results)))
    #listEvents = find_all_events(results)
    #print(listEvents)
    animals = sort_split(
        results)  # <- This takes the event table (2d list) as input and returns a 3d list sorted for each animal

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

    #print(allEventInformation)
    for key in allEventInformation:
        avgdict[key] = Average(allEventInformation[key])
    #print(avgdict)
    L.append(avgdict)

    return L, allEventInformation


def Average(lst):
    return sum(lst) / len(lst)


def find_event_information(allEventInformation, animal):
    for row in animal:

        if (row[1], row[5], row[6], row[7], row[8]) not in allEventInformation:
            allEventInformation[(row[1], row[5], row[6], row[7], row[8])] = [row[4] - row[3]]
        else:
            newList = allEventInformation[(row[1], row[5], row[6], row[7], row[8])]
            newList.append(row[4] - row[3])
            allEventInformation[(row[1], row[5], row[6], row[7], row[8])] = newList

    return allEventInformation


def find_all_events(results):
    listEvents = []
    for row in results:
        if row[1] not in listEvents:
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

    return animals


if __name__ == '__main__':
    table = 'C:/Users/Bram/Documents/radboud/LMT_data_post/28042020_20170048001_Group2_PreTreatment.sqlite'  # <- This string points to the table that is used as input
    data = eventDuration(table)
    #print(data)