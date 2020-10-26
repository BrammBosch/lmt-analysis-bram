from lmtanalysis.FileUtil import getFilesToProcess
from scripts.tools.find_time_frames import find_start_end_file, find_frames


if __name__ == '__main__':
    # files = getFilesToProcess()
    # for file in files:
    #     find_start_end_file(file)



    #The start and end time are based on a list where the 0 value is the hour, the 1 value the minute and the 2 value the seconds

    start_time = [12,0,0]
    end_time = [12,0,30]

    try:
        start_frame, end_frame = find_frames('C:/Users/Bram/Documents/radboud/LMT_data/28042020_20170048001_Group2_PreTreatment.sqlite',start_time,end_time)
        print(start_frame)
        print(end_frame)
    except ValueError:
        print('The numbers are not valid for notating a time')



