from code_bram.quality.check_match_mismatch import match_mismatch_main
from lmtanalysis.FileUtil import getFilesToProcess
from scripts.tools.select_db import connection_rfid
from io import BytesIO
import numpy as np
import matplotlib.pyplot as plt
from scripts.tools.read_db_info import read_database_info
import ntpath

def plots(file,count_match, count_mismatch, time_mismatch_last_match):
    rfid_list = connection_rfid(file)

    imgdata = boxplot(time_mismatch_last_match,rfid_list)
    #barchart(time_mismatch_last_match,rfid_list)

    return imgdata

def boxplot(time_mismatch_last_match,rfid_list):

    imgdata = BytesIO()

    fig = plt.figure(1, figsize=(9, 6))
    ax = fig.add_subplot(111)
    ax.set_xticklabels(rfid_list)
    ax.boxplot(time_mismatch_last_match)

    fig.savefig(imgdata, format="png")
    imgdata.seek(0)
    return imgdata

def barchart(time_mismatch_last_match,rfid_list):
    fig, axs = plt.subplots(2, 2)
    axs[0, 0].hist(time_mismatch_last_match[0])
    axs[0, 0].set_title(rfid_list[0])
    axs[0, 1].hist(time_mismatch_last_match[1])
    axs[0, 1].set_title(rfid_list[1])
    axs[1, 0].hist(time_mismatch_last_match[2])
    axs[1, 0].set_title(rfid_list[2])
    axs[1, 1].hist(time_mismatch_last_match[3])
    axs[1, 1].set_title(rfid_list[3])


    plt.show()


if __name__ == '__main__':
    files = getFilesToProcess()
    file = files[0]
    plots(file)
