import sqlite3
from multiprocessing import Process, Manager


def check_event_count(filenames, list_excluded_events):
    """
    This function takes as input a list of all files and a list of events not to include.
    It returns a list of all possible events to occur for each animal
    """

    with Manager() as manager:
        list_event_count = manager.list()  # <- declare a special list variable to be used by multiple processes

        processes = []
        for file in filenames:  # <- for each animal a process is generated. Each process runs at the same time to optimise the program.
            p = Process(target=connection_event_types, args=(list_event_count, file, list_excluded_events))
            p.start()
            processes.append(p)
        for p in processes:
            p.join()
        list_event_count = list(list_event_count)

    all_events_1 = []
    all_events_2 = []
    all_events_3 = []
    all_events_4 = []

    for file in list_event_count:
        for event in file:
            if event[1] != None and event[2] == None and event[3] == None and event[4] == None and event[0] not in all_events_1:
                all_events_1.append(event[0])
            elif event[2] != None and event[3] == None and event[4] == None and event[0] not in all_events_2:
                all_events_2.append(event[0])
            elif event[2] != None and event[3] != None and event[4] == None and event[0] not in all_events_3:
                all_events_3.append(event[0])
            elif event[2] != None and event[3] != None and event[4] != None and event[0] not in all_events_4:
                all_events_4.append(event[0])

    all_events = []
    for eventName in all_events_1:
        for i in range(1, 5):
            all_events.append((eventName, i, None, None, None))

    for eventName in all_events_2:
        for i in range(1, 5):
            for j in range(1, 5):
                if i != j:
                    all_events.append((eventName, i, j, None, None))

    for eventName in all_events_3:
        for i in range(1, 5):
            for j in range(1, 5):
                for k in range(1, 5):
                    if i != j and i != k and j != k:
                        all_events.append((eventName, i, j, k, None))


    return all_events


def connection_event_types(L, file, list_excluded_events):
    conn = sqlite3.connect(
        file)  # <- Connect to the database using the variable declared in main

    cursor = conn.cursor()

    placeholder = '?'
    placeholders = ', '.join(placeholder for unused in list_excluded_events)

    query = "select DISTINCT name, IDANIMALA, IDANIMALB, IDANIMALC,IDANIMALD  from event where NAME NOT IN (%s)" % placeholders
    cursor.execute(query, list_excluded_events)

    results = cursor.fetchall()
    # results = [elem for elem in results]  # <- Change list of tuples to a list of lists
    # print(results)

    L.append(results)
    return L


if __name__ == '__main__':
    listExcludedEvents = ['RFID ASSIGN ANONYMOUS TRACK',
                          'RFID MATCH',
                          'RFID MISMATCH',
                          'MACHINE LEARNING ASSOCIATION',
                          'Detection',
                          'Head detected'
                          ]
    a = check_event_count(['C:/Users/Bram/Documents/radboud/LMT_data_post\\11052020_20170048001_Group3_PreTreatment.sqlite',
                       'C:/Users/Bram/Documents/radboud/LMT_data_post\\12052020_20170048001_Group4_PreTreatment.sqlite',
                       'C:/Users/Bram/Documents/radboud/LMT_data_post\\12102020_20170048002_Group4_PreTreatment.sqlite',
                       'C:/Users/Bram/Documents/radboud/LMT_data_post\\13052020_20170048001_Group5_PreTreatment.sqlite',
                       'C:/Users/Bram/Documents/radboud/LMT_data_post\\14102020_20170048002_Group5_PreTreatment.sqlite',
                       'C:/Users/Bram/Documents/radboud/LMT_data_post\\24082020_20170048002_Group1_PreTreatment.sqlite',
                       'C:/Users/Bram/Documents/radboud/LMT_data_post\\25082020_20170048002_Group2_PreTreatment.sqlite',
                       'C:/Users/Bram/Documents/radboud/LMT_data_post\\26082020_20170048002_Group3_PreTreatment.sqlite',
                       'C:/Users/Bram/Documents/radboud/LMT_data_post\\28042020_20170048001_Group2_PreTreatment.sqlite'],
                      listExcludedEvents)
    print(a)
