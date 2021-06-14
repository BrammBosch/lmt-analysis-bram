import copy
import os
from numpy import array
import ntpath
from scipy.spatial import distance
import matplotlib.pyplot as plt
import networkx as nx
import numpy as np
import pandas as pd

from lmtanalysis.FileUtil import getFilesToProcess
from scripts.tools.find_time_frames import find_frames
from scripts.tools.read_db_info import db_animals, read_excel
from scripts.tools.select_db import connection_list_events_in_time_frame, connection_events_in_time_frame

pd.set_option("display.max_rows", None, "display.max_columns", None)


def calculate_state_change(file, sum_results_het, sum_results_wt):
    list_excluded_events = ['RFID ASSIGN ANONYMOUS TRACK',
                            'RFID MATCH',
                            'RFID MISMATCH',
                            'MACHINE LEARNING ASSOCIATION',
                            'Detection',
                            'Head detected'
                            ]
    list_events = ['Contact', 'Break contact', 'Group 3 make','Group 3 break','Group 4 make','Group 4 break','Group2','Group3','Group4']
    #list_events = ['Social approach', 'Contact', 'Get away']
    #list_events = ['Contact','Side by side Contact', 'Side by side Contact, opposite way','Oral-oral Contact','Oral-genital Contact','Break contact']
    #list_events = ['WallJump','Rear isolated','SAP','Move isolated', 'Stop isolated']

    date = os.path.splitext(ntpath.basename(file))[0].split('_')[0]
    day = int(date[:2])
    month = int(date[2:4])

    if month in [10,11,12,1,2,3]:

        if month == 10 and day < 25:
            start_time = [19, 30, 0]
            end_time = [20, 30, 0]
        elif month == 3 and day > 28:
            start_time = [19, 30, 0]
            end_time = [20, 30, 0]
        else:

            start_time = [18, 30, 0]
            end_time = [19, 30, 0]
    elif month in [4,5,6,7,8,9]:
        start_time = [19, 30, 0]
        end_time = [20, 30, 0]


    try:
        start_frame, end_frame = find_frames(file, start_time, end_time)
    except ValueError:
        print('The numbers are not valid for notating a time')
    path = os.path.dirname(os.path.abspath(file))

    info = db_animals(file)
    overview_dataset = read_excel(path)

    info_animals = {}
    for animal in info:
        rfid = '"900' + animal[1] + '"'
        gen = overview_dataset[overview_dataset['Animal RFID'] == rfid]['Genotype']
        gen = gen.iloc[0]
        animal.append(gen)
        info_animals[animal[0]] = [animal[1], animal[2]]

    # results = connection_list_events_in_time_frame(file, list_events, start_frame, end_frame)

    results = connection_events_in_time_frame(file, list_excluded_events, start_frame, end_frame)

    sorted_results = sort_results_group(info_animals, results)
    #sorted_results = sort_results_individual(results)

    calculation_results = []
    i = 0
    for animal in sorted_results:
        sum_list, change_count = calc_change(list_events, animal)
        calculation_results.append(sum_list)
        if i == 0:
            sum_results_het.append(change_count)
        else:
            sum_results_wt.append(change_count)

        i += 1

    # with open('your_file.txt', 'w') as f:
    #     f.write(str(sorted_results[0]))
    #visualize(list_events, calculation_results)
    print('On the y axis first event, on the x axis followup event')

    #print(sum_results_het)
    #print(sum_results_wt)
    res = list()

    a = array(sum_results_wt)
    shape = a.shape
    #print(shape)

    list_result_wt = []
    for i in range(shape[1]):
        list_result_wt.append([])
        for j in range(shape[2]):
            list_result_wt[i].append(0)

    for result in sum_results_wt:
        i = 0
        for item in result:

            tmp = 0
            for value in item:
                list_result_wt[i][tmp] = list_result_wt[i][tmp] + value
                tmp += 1

            i += 1

    return list_events

def summary(sum_results_wt,sum_results_het,list_events):
    # print('test')
    # print(sum_results_het)
    # print(sum_results_wt)
    # print('endtest')
    a = array(sum_results_wt)
    shape = a.shape

    list_result_wt = []
    list_result_het = []

    for i in range(shape[1]):
        list_result_wt.append([])
        list_result_het.append([])
        for j in range(shape[2]):
            list_result_wt[i].append(0)
            list_result_het[i].append(0)

    for result in sum_results_wt:
        i = 0
        for item in result:

            tmp = 0
            for value in item:
                list_result_wt[i][tmp] = list_result_wt[i][tmp] + value
                tmp += 1

            i += 1


    for result in sum_results_het:
        i = 0
        for item in result:

            tmp = 0
            for value in item:
                list_result_het[i][tmp] = list_result_het[i][tmp] + value
                tmp += 1

            i += 1
    df_wt = pd.DataFrame(np.array(list_result_wt), list_events, list_events)
    df_het = pd.DataFrame(np.array(list_result_het), list_events, list_events)

    #print(list_result_wt)
    #print(list_result_het)
    print(df_wt)
    print(df_het)

    print("jensen shannon divergence for dataframe = \n")
    for i in range(len(list_result_wt)):
        #print(distance.jensenshannon(list_result_wt[i],list_result_het[i]))
        print(distance.jensenshannon(list_result_wt[i],list_result_het[i]))

        #print(entropy(list_result_wt[i],qk=list_result_het[i]))



def calc_change(list_events, animal):
    change_count = []

    for j in range(len(list_events)):
        change_count.append([])
        for k in range(len(list_events)):
            change_count[j].append(0)
    i = 0
    #print(list_events)
    for event in animal:
        try:
            if event[0] in list_events:
                if animal[i + 1][0] in list_events and event[4] == animal[i + 1][4] and event[5] == animal[i + 1][5] and \
                        event[6] == animal[i + 1][6]:
                    change_count[list_events.index(event[0])][list_events.index(animal[i + 1][0])] += 1
                else:
                    k = i + 1

                    in_list = False

                    # print(animal[i])
                    while not in_list:
                        if k < len(animal):
                            # print(animal[k])
                            if animal[k][0] in list_events and event[4] == animal[k][4] and event[5] == animal[k][5] and \
                                    event[6] == animal[k][6]:

                                if animal[k][1] - animal[i][2] < 15:
                                    # print('smaller')
                                    # print(animal[k][1] - animal[i][1])
                                    change_count[list_events.index(event[0])][list_events.index(animal[k][0])] += 1

                                # else:
                                #     print('bigger')
                                #     print(animal[k][1] - animal[i][1])
                                in_list = True

                            k += 1

                        else:
                            in_list = True

        except Exception as e:
            print(e)
            continue

        i += 1

    sum_list = copy.deepcopy(change_count)
    for row in sum_list:
        row_sum = sum(row)
        j = 0
        for index in row:
            if index == 0:
                row[j] = 0
            else:
                row[j] = round(index / row_sum, 2)
            j += 1

    # print(sum_list)
    pd.set_option('display.expand_frame_repr', False)
    df_counts = pd.DataFrame(np.array(change_count), list_events, list_events)
    df_sum = pd.DataFrame(np.array(sum_list), list_events, list_events)

    print(change_count)
    #print(sum_list)
    #print(df_counts)
    #print(df_sum)
    return sum_list, change_count


def sort_results_individual(results):
    animals = [[], [], [], []]
    for event in results:
        if event[3] != None:
            animals[event[3] - 1].append(event)

    animals[0] = sorted(animals[0], key=lambda x: x[1])
    animals[1] = sorted(animals[1], key=lambda x: x[1])
    animals[2] = sorted(animals[2], key=lambda x: x[1])
    animals[3] = sorted(animals[3], key=lambda x: x[1])
    return animals


def sort_results_group(info_animals, results):
    if info_animals[1][1] == info_animals[2][1]:
        groupa = [1, 2]
        groupb = [3, 4]
    elif info_animals[1][1] == info_animals[3][1]:
        groupa = [1, 3]
        groupb = [2, 4]
    elif info_animals[1][1] == info_animals[4][1]:
        groupa = [1, 4]
        groupb = [2, 3]

    if info_animals[1][1] == 'WT':
        group1 = groupa
        group2 = groupb
    else:
        group1 = groupb
        group2 = groupa
    animals = [[], []]
    # print(group1)
    # print(group2)
    for event in results:
        if event[3] != None:
            if event[3] in group1:
                animals[0].append(event)
            if event[3] in group2:
                animals[1].append(event)

    animals[0] = sorted(animals[0], key=lambda x: (x[3], x[1]))
    animals[1] = sorted(animals[1], key=lambda x: (x[3], x[1]))
    return animals


def visualize(list_events, sum_list_all):
    for sum_list in sum_list_all:
        #print(sum_list)
        G = nx.DiGraph()
        pos = nx.circular_layout(G)

        for event in list_events:
            G.add_node(event)

        self_loops = []
        i = 0
        for percentage_list in sum_list:
            j = 0
            for percentage in percentage_list:
                if percentage != 0:
                    G.add_edge(list_events[i], list_events[j], weight=percentage)
                if list_events[i] == list_events[j]:
                    self_loops.append(percentage)
                    # plt.text(x,y+0.05 , s=percentage, horizontalalignment='center')

                j += 1
            i += 1

        nodes = sorted(G)
        k = 0
        mapping = {}

        for node in nodes:
            mapping[node] = str(node) + ' ' + str(self_loops[k])
            k += 1
        G = nx.relabel_nodes(G, mapping)

        pos = nx.circular_layout(G)

        # print(sum_list)

        mapping = {}
        nx.relabel_nodes(G, mapping)
        edges = G.edges()
        weights = [G[u][v]['weight'] for u, v in edges]

        labels = nx.get_edge_attributes(G, 'weight')
        # print(pos)
        plt.subplot()
        nx.draw_networkx(G, pos, with_labels=True, font_size=7, arrows=False, connectionstyle='arc, rad = 0.1')
        # nx.draw_networkx_edge_labels(G,pos, edge_labels=labels)
        nx.draw_networkx_edge_labels(G, pos, edge_labels=labels, label_pos=0.7, font_size=7)
        l, r = plt.xlim()
        print(l, r)
        plt.xlim(l - 1, r + 1)
        plt.show()


if __name__ == '__main__':
    files = getFilesToProcess()
    sum_results_het = []
    sum_results_wt = []
    for file in files:
        list_events = calculate_state_change(file, sum_results_het, sum_results_wt)
    summary(sum_results_wt,sum_results_het,list_events)


