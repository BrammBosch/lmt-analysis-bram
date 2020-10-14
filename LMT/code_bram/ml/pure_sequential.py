import sqlite3
from code_bram.ml.simple_SVM import run_SVM


from scripts.tools.select_events import connection



if __name__ == '__main__':

    tables = ['C:/Users/Bram/Documents/radboud/LMT_data/11052020_20170048001_Group3_PreTreatment.sqlite',
              'C:/Users/Bram/Documents/radboud/LMT_data/12052020_20170048001_Group4_PreTreatment.sqlite',
              'C:/Users/Bram/Documents/radboud/LMT_data/13052020_20170048001_Group5_PreTreatment.sqlite',
              'C:/Users/Bram/Documents/radboud/LMT_data/24082020_20170048002_Group1_PreTreatment.sqlite',
              'C:/Users/Bram/Documents/radboud/LMT_data/25082020_20170048002_Group2_PreTreatment.sqlite',
              'C:/Users/Bram/Documents/radboud/LMT_data/26082020_20170048002_Group3_PreTreatment.sqlite',
              'C:/Users/Bram/Documents/radboud/LMT_data/28042020_20170048001_Group2_PreTreatment.sqlite']

    allList = []
    for table in tables:
        allList.append(connection(table))

    # print(allList)

    events = ['Rearing', 'Look down', 'Stop', 'Approach', 'Contact', 'Oral-genital Contact', 'Oral-oral Contact',
              'Break contact', 'Side by side Contact']
    i = 0
    end = []
    for file in allList:
        # print(file)
        m1 = []
        m2 = []
        m3 = []
        m4 = []
        i1 = 0
        i2 = 0
        i3 = 0
        i4 = 0
        for row in file:
            # print(row)

            if row[1] in events:
                if row[5] == 1 and i1 < 500:
                    m1.append(events.index(row[1]))
                    i1 += 1
                elif row[5] == 2 and i2 < 500:
                    m2.append(events.index(row[1]))
                    i2 += 1
                elif row[5] == 3 and i3 < 500:
                    m3.append(events.index(row[1]))
                    i3 += 1
                elif row[5] == 4 and i4 < 500:
                    m4.append(events.index(row[1]))
                    i4 += 1
        # print(m1)
        end.append(m1)
        end.append(m2)
        end.append(m3)
        end.append(m4)
    classList = [0, 1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1]

    run_SVM(end, classList, 42)
