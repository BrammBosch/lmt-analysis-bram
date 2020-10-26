from scripts.tools.sort_split import sort_split
from scripts.tools.select_events import connection


def match_mismatch_main(table):
    result = connection(table)
    count_match, count_mismatch = count_match_mismatch(result)
    time_mismatch_last_match = time_mismatch_match(result)
    print(time_mismatch_last_match)
    print('The amount of matches for mice 1,2,3 and 4 are: ' + str(count_match))
    print('The amount of mismatches for mice 1,2,3 and 4 are: ' + str(count_mismatch))

def count_match_mismatch(result):
    match_and_mismatch = []
    count_match = [0, 0, 0, 0]
    count_mismatch = [0, 0, 0, 0]
    for row in result:
        if row[1] == 'RFID MATCH':
            match_and_mismatch.append(row)
            if row[5] == 1:
                count_match[0] += 1
            elif row[5] == 2:
                count_match[1] += 1
            elif row[5] == 3:
                count_match[2] += 1
            else:
                count_match[3] += 1
        elif row[1] == 'RFID MISMATCH':
            if row[5] == 1:
                count_mismatch[0] += 1
            elif row[5] == 2:
                count_mismatch[1] += 1
            elif row[5] == 3:
                count_mismatch[2] += 1
            else:
                count_mismatch[3] += 1
            match_and_mismatch.append(row)

    # print(match_and_mismatch)
    animals = sort_split(match_and_mismatch)

    return count_match, count_mismatch

def time_mismatch_match(result):
    time_mismatch_last_match = [[], [], [], []]

    for row in result:
        if row[1] == 'RFID MATCH':
            if row[5] == 1:
                tempMatch1 = row[3]

            elif row[5] == 2:
                tempMatch2 = row[3]

            elif row[5] == 3:
                tempMatch3 = row[3]

            else:
                tempMatch4 = row[3]
        if row[1] == 'RFID MISMATCH':
            if row[5] == 1:
                # print('time between is: ' + str(row[3] - tempMatch1) + ' for mouse 1')
                time_mismatch_last_match[0].append(row[3] - tempMatch1)

            elif row[5] == 2:
                # print('time between is: ' + str(row[3] - tempMatch2) + ' for mouse 2')
                time_mismatch_last_match[1].append(row[3] - tempMatch2)

            elif row[5] == 3:
                # print('time between is: ' + str(row[3] - tempMatch3) + ' for mouse 3')
                time_mismatch_last_match[2].append(row[3] - tempMatch3)

            else:
                # print('time between is: ' + str(row[3] - tempMatch4) + ' for mouse 4')
                time_mismatch_last_match[3].append(row[3] - tempMatch4)

    return time_mismatch_last_match
if __name__ == '__main__':
    table = 'C:/Users/Bram/Documents/radboud/LMT_data_original/28042020_20170048001_Group2_PreTreatment.sqlite'
    match_mismatch_main(table)
