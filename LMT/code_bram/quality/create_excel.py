from code_bram.quality.check_match_mismatch import match_mismatch_main
from lmtanalysis.FileUtil import getFilesToProcess
import xlsxwriter
import os
import ntpath
from code_bram.quality.visualize import plots
from scripts.tools.select_db import connection_rfid


def create_excel():
    files = getFilesToProcess()
    path = os.path.dirname(os.path.abspath(files[0]))
    rfid_list = connection_rfid(files[0])

    outputFile = path + '\quality.xlsx'

    workbook = xlsxwriter.Workbook(outputFile)
    width = len(rfid_list[0])

    for file in files:
        x = 0
        y = 1

        sheetName = ntpath.basename(file).split('_')[0]
        worksheet = workbook.add_worksheet(sheetName)
        worksheet.set_column(1, 4, width + 4)
        count_match, count_mismatch, time_mismatch_last_match = match_mismatch_main(file)

        worksheet.write(x, y, 'The amount of matches are')
        worksheet.write(x + 1, y - 1, 'RFID:')
        worksheet.write(x + 1, y + 0, rfid_list[0])
        worksheet.write(x + 1, y + 1, rfid_list[1])
        worksheet.write(x + 1, y + 2, rfid_list[2])
        worksheet.write(x + 1, y + 3, rfid_list[3])
        worksheet.write(x + 2, y + 0, count_match[0])
        worksheet.write(x + 2, y + 1, count_match[1])
        worksheet.write(x + 2, y + 2, count_match[2])
        worksheet.write(x + 2, y + 3, count_match[3])

        x = 4

        worksheet.write(x, y + 0, 'The amount of mismatches are')
        worksheet.write(x + 1, y - 1, 'RFID:')
        worksheet.write(x + 1, y + 0, rfid_list[0])
        worksheet.write(x + 1, y + 1, rfid_list[1])
        worksheet.write(x + 1, y + 2, rfid_list[2])
        worksheet.write(x + 1, y + 3, rfid_list[3])
        worksheet.write(x + 2, y + 0, count_mismatch[0])
        worksheet.write(x + 2, y + 1, count_mismatch[1])
        worksheet.write(x + 2, y + 2, count_mismatch[2])
        worksheet.write(x + 2, y + 3, count_mismatch[3])

        x = 8
        worksheet.write(x, y + 0, 'The average time between a match and mismatch is')
        worksheet.write(x + 1, y - 1, 'RFID:')
        worksheet.write(x + 1, y + 0, rfid_list[0])
        worksheet.write(x + 1, y + 1, rfid_list[1])
        worksheet.write(x + 1, y + 2, rfid_list[2])
        worksheet.write(x + 1, y + 3, rfid_list[3])
        worksheet.write(x + 2, y + 0, sum(time_mismatch_last_match[0]) / len(time_mismatch_last_match[0]))
        worksheet.write(x + 2, y + 1, sum(time_mismatch_last_match[1]) / len(time_mismatch_last_match[1]))
        worksheet.write(x + 2, y + 2, sum(time_mismatch_last_match[2]) / len(time_mismatch_last_match[2]))
        worksheet.write(x + 2, y + 3, sum(time_mismatch_last_match[3]) / len(time_mismatch_last_match[3]))

        imgdata = plots(file, count_match, count_mismatch, time_mismatch_last_match)

        worksheet.insert_image(
            13, 0, "",
            {'image_data': imgdata, 'x_scale': 0.6, 'y_scale': 0.6}
        )

    workbook.close()


create_excel()
