import ntpath
import os
import time
from statistics import stdev

import xlsxwriter

from code_bram.SVM.check_event_count import check_event_count
from lmtanalysis.FileUtil import getFilesToProcess
from scripts.tools.read_db_info import db_animals, read_excel
from scripts.tools.select_db import connection


def create_excel_events():
    """
    When this function is called it asks for a database or folder of databases and produces 2 excel files with
    information about the events in these databases.
    1 excel file per animal and 1 excel file for wildtype and mutant groups.

    In the excel files each sheet represents a database.
    For each event the name, total amount, total time, average time and SD average time is stored.

    """

    list_excluded_events = ['RFID ASSIGN ANONYMOUS TRACK',
                            'RFID MATCH',
                            'RFID MISMATCH',
                            'MACHINE LEARNING ASSOCIATION',
                            'Detection',
                            'Head detected'
                            ]

    files = getFilesToProcess()
    path = os.path.dirname(os.path.abspath(files[0]))
    all_events = check_event_count(files, list_excluded_events)

    # print(all_events)

    overview_dataset = read_excel(path)

    outputFile = path + '\event_information.xlsx'
    workbook = xlsxwriter.Workbook(outputFile)
    outputFile_summary = path + '\group_event_information.xlsx'
    summary_workbook = xlsxwriter.Workbook(outputFile_summary)
    #files.sort(key=lambda x: (x.split('\\')[1].split('_')[0][4:], x.split('\\')[1].split('_')[0][2:4], x.split('\\')[1].split('_')[0][0:2]))
    for file in files:
        sheetName = ntpath.basename(file).split('_')[0]
        summary_worksheet = summary_workbook.add_worksheet(sheetName)
        results = connection(file, list_excluded_events)

        info = db_animals(file)
        info_animals = {}
        for animal in info:
            rfid = '"900' + animal[1] + '"'
            gen = overview_dataset[overview_dataset['Animal RFID'] == rfid]['Genotype']
            print(gen)
            gen = gen.iloc[0]
            animal.append(gen)
            info_animals[animal[0]] = [animal[1], animal[2]]

        counter_list_group, total_time_list_group, avg_list_group, sd_list_group, all_events_group,group1, group2 = calc_avg_count_total_group(
            all_events, results, info_animals)

        summary_worksheet.write(0, 1, 'Wildtype (' + info_animals[group1[0]][0] + ', ' + info_animals[group1[1]][0] + ')')
        summary_worksheet.write(0, 7, 'Heterozygote (' + info_animals[group2[0]][0] + ', ' + info_animals[group2[1]][0] + ')')

        summary_worksheet.write(1, 1, 'Event name')
        summary_worksheet.write(1, 2, 'Amount')
        summary_worksheet.write(1, 3, 'Total time')
        summary_worksheet.write(1, 4, 'Average time')
        summary_worksheet.write(1, 5, 'SD average time')

        summary_worksheet.write(1, 7, 'Event name')
        summary_worksheet.write(1, 8, 'Amount')
        summary_worksheet.write(1, 9, 'Total time')
        summary_worksheet.write(1, 10, 'Average time')
        summary_worksheet.write(1, 11, 'SD average time')

        summary_worksheet.set_column(1, 1, 55)
        summary_worksheet.set_column(2, 2, 15)
        summary_worksheet.set_column(3, 3, 15)
        summary_worksheet.set_column(4, 4, 12)
        summary_worksheet.set_column(5, 5, 18)
        summary_worksheet.set_column(7, 7, 55)
        summary_worksheet.set_column(8, 8, 15)
        summary_worksheet.set_column(9, 9, 15)
        summary_worksheet.set_column(10, 10, 12)
        summary_worksheet.set_column(11, 11, 18)

        place_het = 2
        place_wt = 2

        for i in range(len(all_events_group)):
            if all_events_group[i][1] == 'WT':
                place = place_wt
                name_event_place = 1
                counter_place = 2
                total_time_place = 3
                avg_list_place = 4
                sd_list_place = 5
                place_wt += 1
            else:
                place = place_het
                name_event_place = 7
                counter_place = 8
                total_time_place = 9
                avg_list_place = 10
                sd_list_place = 11
                place_het += 1
            if all_events_group[i][2] == None:
                summary_worksheet.write(place, name_event_place,
                                        str(all_events_group[i][0]))

            elif all_events_group[i][2] != None and all_events_group[i][3] == None:
                summary_worksheet.write(place, name_event_place,
                                        str(all_events_group[i][0]) + " " + all_events_group[i][1] + "-" +
                                            all_events_group[i][2])

            elif all_events_group[i][2] != None and all_events_group[i][3] != None:
                summary_worksheet.write(place, name_event_place,
                                        str(all_events_group[i][0]) + " " + all_events_group[i][1] + "-" +
                                            all_events_group[i][2] + "-" + all_events_group[i][3])
            else:
                summary_worksheet.write(place, name_event_place, str(all_events_group[i][0]))

            # summary_worksheet.write(place, name_event_place, str(all_events_group[i]))
            summary_worksheet.write(place, counter_place, counter_list_group[i])
            summary_worksheet.write(place, total_time_place, total_time_list_group[i])
            summary_worksheet.write(place, avg_list_place, avg_list_group[i])
            summary_worksheet.write(place, sd_list_place, sd_list_group[i])

        sheetName = ntpath.basename(file).split('_')[0]
        worksheet = workbook.add_worksheet(sheetName)

        info = db_animals(file)
        info_animals = {}
        for animal in info:
            rfid = '"900' + animal[1] + '"'
            gen = overview_dataset[overview_dataset['Animal RFID'] == rfid]['Genotype']
            gen = gen.iloc[0]
            animal.append(gen)
            info_animals[animal[0]] = [animal[1], animal[2]]
        # print(info_animals)
        results = connection(file, list_excluded_events)

        counter_list, total_time_list, avg_list, sd_list = calc_avg_count_total(all_events, results)

        k = 0
        for number in range(4):
            worksheet.write(0, k + 1, 'Number in db')
            worksheet.write(0, k + 2, 'RFID TAG')
            worksheet.write(0, k + 3, 'Genotype')
            worksheet.write(1, k + 1, number + 1)
            worksheet.write(1, k + 2, info_animals[number + 1][0])
            worksheet.write(1, k + 3, info_animals[number + 1][1])
            worksheet.write(3, k, 'Event name')
            worksheet.write(3, k + 1, 'Amount')
            worksheet.write(3, k + 2, 'Total time')
            worksheet.write(3, k + 3, 'Average time')
            worksheet.write(3, k + 4, 'SD average time')
            worksheet.set_column(k, k, 55)
            worksheet.set_column(k + 1, k + 1, 15)
            worksheet.set_column(k + 2, k + 3, 12)
            worksheet.set_column(k + 4, k + 4, 18)
            k += 6

        place1 = 4
        place2 = 4
        place3 = 4
        place4 = 4
        for i in range(len(counter_list)):

            if all_events[i][1] == 1:
                place = place1
                name_event_place = 0
                counter_place = 1
                total_time_place = 2
                avg_list_place = 3
                sd_list_place = 4
                place1 += 1
            elif all_events[i][1] == 2:
                place = place2
                name_event_place = 6
                counter_place = 7
                total_time_place = 8
                avg_list_place = 9
                sd_list_place = 10
                place2 += 1
            elif all_events[i][1] == 3:
                name_event_place = 12
                counter_place = 13
                total_time_place = 14
                avg_list_place = 15
                sd_list_place = 16
                place = place3
                place3 += 1
            elif all_events[i][1] == 4:
                place = place4
                name_event_place = 18
                counter_place = 19
                total_time_place = 20
                avg_list_place = 21
                sd_list_place = 22
                place4 += 1

            if all_events[i][2] == None:
                worksheet.write(place, name_event_place,
                                str(all_events[i][0]) + ' ' + info_animals[all_events[i][1]][0][-3:] + ' (' +
                                info_animals[all_events[i][1]][1] + ')')
            elif all_events[i][2] != None and all_events[i][3] == None:
                worksheet.write(place, name_event_place,
                                str(all_events[i][0]) + ' ' + info_animals[all_events[i][1]][0][-3:] + '-' +
                                info_animals[all_events[i][2]][0][-3:] + ' (' + info_animals[all_events[i][1]][
                                    1] + ' - ' + info_animals[all_events[i][2]][1] + ')')
            elif all_events[i][2] != None and all_events[i][3] != None:
                worksheet.write(place, name_event_place,
                                str(all_events[i][0]) + ' ' + info_animals[all_events[i][1]][0][-3:] + '-' +
                                info_animals[all_events[i][2]][0][-3:] + '-' + info_animals[all_events[i][3]][0][
                                                                               -3:] + ' (' +
                                info_animals[all_events[i][1]][1] + ' - ' + info_animals[all_events[i][2]][1] + ' - ' +
                                info_animals[all_events[i][3]][1] + ')')
            else:
                worksheet.write(place, name_event_place, str(all_events[i][0]))

            worksheet.write(place, counter_place, counter_list[i])
            worksheet.write(place, total_time_place, total_time_list[i])
            worksheet.write(place, avg_list_place, avg_list[i])
            worksheet.write(place, sd_list_place, sd_list[i])

    workbook.close()

    summary_workbook.close()


def calc_avg_count_total_group(all_events, results, info_animals):
    """
    This functions takes as input:
    A list of all the events present in all the databases.
    A lists of the rows from the database.
    A dictionary of the form : {id: [rfid, genotype]} for each of the animals in the database.

    It returns the information:
    Where for each list the index corresponds with the all events list.

    counter_list_group: A list with the total count for each event.
    total_time_list_group: A list with the total time in frames for each event.
    avg_list_group: The average time in frames spent during an event.
    sd_list_group: The standard deviation in frames for each event
    all_events_group: A new list with all events without the animal id's
    group1: The id's of the wildtype group
    group2: The id's of the mutant group
    """
    print(info_animals)
    all_events_group = []
    total_time_list_group = []
    counter_list_group = []
    time_list_group = []

    # print(info_animals)

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

    # print(group1, group2)
    # print(all_events)
    # print(list(all_events[0]))

    for event in all_events:
        event = list(event)
        for i in range(1, 5):
            if event[i] in group1:
                event[i] = 'WT'
            elif event[i] in group2:
                event[i] = 'HET'
            else:
                event[i] = None
        if event not in all_events_group:
            all_events_group.append(event)
    # print(all_events_group)

    for row in all_events_group:
        time_list_group.append([])
        total_time_list_group.append(0)
        counter_list_group.append(0)

    for row in results:
        if (row[1], row[5], row[6], row[7], row[8]) not in all_events:
            pass
        else:

            # if row[5] in group1 and row[6] == None:

            for i in range(5, 9):
                if row[i] in group1:
                    row[i] = 'WT'
                elif row[i] in group2:
                    row[i] = 'HET'

            eventName = [row[1], row[5], row[6], row[7], row[8]]
            counter_list_group[all_events_group.index(eventName)] += 1
            # if row[4] - row[3] == 0:
            #     total_time_list_group[all_events_group.index(eventName)] += 1
            #
            #     time_list_group[all_events_group.index(eventName)].append(1)
            #
            # else:
            time_list_group[all_events_group.index(eventName)].append(row[4] - row[3] + 1)

            total_time_list_group[all_events_group.index(eventName)] += row[4] - row[3] + 1

    avg_list_group = []
    sd_list_group = []

    for i in range(len(counter_list_group)):

        try:
            sd_list_group.append(stdev(time_list_group[i]))
        except:
            sd_list_group.append(0)

        if counter_list_group[i] != 0:

            avg_list_group.append(total_time_list_group[i] / counter_list_group[i])

        else:
            avg_list_group.append(0)

    # print(total_time_list_group)

    # print(len(total_time_list_group))

    # counter_list_group = [counter_list_group1, counter_list_group2]
    # total_time_list_group = [total_time_list_group1, total_time_list_group2]
    # avg_list_group = [avg_list_group1, avg_list_group2]
    # sd_list_group = [sd_list_group1, sd_list_group2]


    return counter_list_group, total_time_list_group, avg_list_group, sd_list_group, all_events_group, group1,group2


def calc_avg_count_total(all_events, results):
    """
    This functions takes as input:
    A list of all the events present in all the databases.
    A lists of the rows from the database.

    It returns the information:
    Where for each list the index corresponds with the all events list.

    counter_list: A list with the total count for each event.
    total_time_list: A list with the total time in frames for each event.
    avg_list: The average time in frames spent during an event.
    sd_list: The standard deviation in frames for each event
    """
    total_time_list = []
    counter_list = []
    time_list = []

    for row in all_events:
        time_list.append([])
        total_time_list.append(0)
        counter_list.append(0)

    for row in results:
        if (row[1], row[5], row[6], row[7], row[8]) not in all_events:
            pass
        else:
            counter_list[all_events.index((row[1], row[5], row[6], row[7], row[8]))] += 1

            # if row[4] - row[3] == 0:
            #     total_time_list[all_events.index((row[1], row[5], row[6], row[7], row[8]))] += 1
            #
            #     time_list[all_events.index((row[1], row[5], row[6], row[7], row[8]))].append(1)
            #
            # else:
            time_list[all_events.index((row[1], row[5], row[6], row[7], row[8]))].append(row[4] - row[3] + 1)

            total_time_list[all_events.index((row[1], row[5], row[6], row[7], row[8]))] += row[4] - row[3] + 1

    i = 0
    avg_list = []
    sd_list = []

    for i in range(len(counter_list)):

        try:
            sd_list.append(stdev(time_list[i]))
        except:
            sd_list.append(0)
        if counter_list[i] != 0:

            avg_list.append(total_time_list[i] / counter_list[i])

        else:
            avg_list.append(0)

    return counter_list, total_time_list, avg_list, sd_list


if __name__ == '__main__':
    start = time.time()

    create_excel_events()
    end = time.time()
    print('time elapsed: ' + str(end - start))
