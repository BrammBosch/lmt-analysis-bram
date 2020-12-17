from code_bram.SVM.check_event_count import check_event_count
from code_bram.quality.check_match_mismatch import match_mismatch_main
from lmtanalysis.FileUtil import getFilesToProcess
import xlsxwriter
import os
import ntpath
from code_bram.quality.visualize import plots
from code_bram.quality.visualize import boxplot
from scripts.tools.find_time_frames import find_start_end_file
from scripts.tools.select_db import connection_rfid, connection_unique_events
from scripts.tools.select_db import connection_first_match
from scipy import stats
import numpy as np


def create_excel():
    list_excluded_events = ['RFID ASSIGN ANONYMOUS TRACK',
                          'RFID MATCH',
                          'RFID MISMATCH',
                          'MACHINE LEARNING ASSOCIATION',
                          'Detection',
                          'Head detected'
                          ]
    files = getFilesToProcess()
    path = os.path.dirname(os.path.abspath(files[0]))

    outputFile = path + '\quality.xlsx'

    workbook = xlsxwriter.Workbook(outputFile)

    mainsheet = workbook.add_worksheet('main')
    mainsheet.set_column(0, 0, 30)

    all_mismatch_data = []
    all_rfid_list = []
    all_events = check_events(files)
    print(all_events)
    for file in files:

        rfid_list = connection_rfid(file)
        first_list = connection_first_match(file)
        x = 0
        y = 1

        sheetName = ntpath.basename(file).split('_')[0]
        worksheet = workbook.add_worksheet(sheetName)
        worksheet.set_column(0, 4, 20)

        count_match, count_mismatch, time_mismatch_last_match = match_mismatch_main(file)
        i = 0
        for item in time_mismatch_last_match:
            all_mismatch_data.append(item)
            all_rfid_list.append(rfid_list[i])
            i += 1
            # print(sum(item) / len(item))
        kruskal(time_mismatch_last_match)

        worksheet.write(x, y, 'First match')

        worksheet.write(x + 1, y - 1, 'RFID')

        worksheet.write(x + 2, y - 1, 'First match in sec')

        worksheet.write(x + 1, y + 0, rfid_list[0])
        worksheet.write(x + 1, y + 1, rfid_list[1])
        worksheet.write(x + 1, y + 2, rfid_list[2])
        worksheet.write(x + 1, y + 3, rfid_list[3])
        worksheet.write(x + 2, y + 0, round(first_list[0] / 30, 2))
        worksheet.write(x + 2, y + 1, round(first_list[1] / 30, 2))
        worksheet.write(x + 2, y + 2, round(first_list[2] / 30, 2))
        worksheet.write(x + 2, y + 3, round(first_list[3] / 30, 2))

        x = 4

        worksheet.write(x, y, 'Matches')
        worksheet.write(x + 1, y - 1, 'RFID:')
        worksheet.write(x + 2, y - 1, 'Amount of matches')
        worksheet.write(x + 1, y + 0, rfid_list[0])
        worksheet.write(x + 1, y + 1, rfid_list[1])
        worksheet.write(x + 1, y + 2, rfid_list[2])
        worksheet.write(x + 1, y + 3, rfid_list[3])
        worksheet.write(x + 2, y + 0, count_match[0])
        worksheet.write(x + 2, y + 1, count_match[1])
        worksheet.write(x + 2, y + 2, count_match[2])
        worksheet.write(x + 2, y + 3, count_match[3])

        x += 4

        worksheet.write(x, y, 'Mismatches')
        worksheet.write(x + 1, y - 1, 'RFID:')
        worksheet.write(x + 2, y - 1, 'Amount of mismatches')
        worksheet.write(x + 3, y - 1, '% Mismatch per match')
        worksheet.write(x + 1, y + 0, rfid_list[0])
        worksheet.write(x + 1, y + 1, rfid_list[1])
        worksheet.write(x + 1, y + 2, rfid_list[2])
        worksheet.write(x + 1, y + 3, rfid_list[3])
        worksheet.write(x + 2, y + 0, count_mismatch[0])
        worksheet.write(x + 2, y + 1, count_mismatch[1])
        worksheet.write(x + 2, y + 2, count_mismatch[2])
        worksheet.write(x + 2, y + 3, count_mismatch[3])
        worksheet.write(x + 3, y + 0, count_mismatch[0] / count_match[0] * 100)
        worksheet.write(x + 3, y + 1, count_mismatch[1] / count_match[1] * 100)
        worksheet.write(x + 3, y + 2, count_mismatch[2] / count_match[2] * 100)
        worksheet.write(x + 3, y + 3, count_mismatch[3] / count_match[3] * 100)

        x += 5
        worksheet.write(x, y, 'The average time between a match and mismatch is')
        worksheet.write(x + 1, y - 1, 'RFID:')
        worksheet.write(x + 2, y - 1, 'Time in frames')

        worksheet.write(x + 1, y + 0, rfid_list[0])
        worksheet.write(x + 1, y + 1, rfid_list[1])
        worksheet.write(x + 1, y + 2, rfid_list[2])
        worksheet.write(x + 1, y + 3, rfid_list[3])
        worksheet.write(x + 2, y + 0, sum(time_mismatch_last_match[0]) / len(time_mismatch_last_match[0]))
        worksheet.write(x + 2, y + 1, sum(time_mismatch_last_match[1]) / len(time_mismatch_last_match[1]))
        worksheet.write(x + 2, y + 2, sum(time_mismatch_last_match[2]) / len(time_mismatch_last_match[2]))
        worksheet.write(x + 2, y + 3, sum(time_mismatch_last_match[3]) / len(time_mismatch_last_match[3]))

        imgdata = plots(file, count_match, count_mismatch, time_mismatch_last_match)

        x += 5

        start_frame, end_frame = find_start_end_file(file)
        total_time = end_frame - start_frame

        worksheet.write(x, y, '% of total time is mismatch time')
        worksheet.write(x + 1, y - 1, 'RFID:')
        worksheet.write(x + 2, y - 1, 'Average time in frames')

        worksheet.write(x + 1, y + 0, rfid_list[0])
        worksheet.write(x + 1, y + 1, rfid_list[1])
        worksheet.write(x + 1, y + 2, rfid_list[2])
        worksheet.write(x + 1, y + 3, rfid_list[3])
        worksheet.write(x + 2, y + 0, (sum(time_mismatch_last_match[0])/total_time)*100)
        worksheet.write(x + 2, y + 1, (sum(time_mismatch_last_match[1])/total_time)*100)
        worksheet.write(x + 2, y + 2, (sum(time_mismatch_last_match[2])/total_time)*100)
        worksheet.write(x + 2, y + 3, (sum(time_mismatch_last_match[3])/total_time)*100)

        x += 5

        worksheet.insert_image(
            x, 0, "",
            {'image_data': imgdata, 'x_scale': 0.6, 'y_scale': 0.6}

        )

        all_file_events = connection_unique_events(file, list_excluded_events)
        #print(all_file_events)


        x = 0
        y = 7
        worksheet.write(x , y, 'events missing')


        for event in all_events:
            if event not in all_file_events:
                if event not in ['Train3', 'Train4']:
                    worksheet.write(x+1,y, str(event))
                    x+=1

    kruskal_result = kruskal(all_mismatch_data)
    #print(kruskal_result)
    all_data = [j for sub in all_mismatch_data for j in sub]
    all_data = np.array(all_data)

    mainsheet.write(0, 0, 'Standard deviation: ')
    mainsheet.write(0, 1, all_data.std())
    mainsheet.write(1, 0, 'Second standard deviation: ')
    mainsheet.write(1, 1, 2 * all_data.std())
    mainsheet.write(2, 0, 'Third standard deviation: ')
    mainsheet.write(2, 1, 3 * all_data.std())

    imgdata = boxplot(all_data, ['all'])

    mainsheet.insert_image(
        6, 0, "",
        {'image_data': imgdata, 'x_scale': 0.6, 'y_scale': 0.6}
    )
    mainsheet.write(4, 0, 'Kruskal-wallis test p-value:')
    mainsheet.write(4, 1, kruskal_result[1])

    workbook.close()


def check_events(file):
    list_excluded_events = ['RFID ASSIGN ANONYMOUS TRACK',
                          'RFID MATCH',
                          'RFID MISMATCH',
                          'MACHINE LEARNING ASSOCIATION',
                          'Detection',
                          'Head detected'
                          ]
    all_events = check_event_count(file, list_excluded_events)

    return all_events

def kruskal(x):
    list_ = []
    n = 0
    for item in x:
        array_item = np.array(item)
        list_.append(array_item)
        n += 1
    args = [l for l in list_]

    return stats.kruskal(*args)


if __name__ == '__main__':
    create_excel()
