from scripts.tools.find_time_frames import find_start_end_file
from scripts.tools.select_db import connection_match


def match_mismatch_main(table):
    """
    If this function is called with a table as input it returns the amount of matches, mismatches and a list of all
    durations in frames between matches and mismatches
    """
    result = connection_match(table)

    count_match, count_mismatch = count_match_mismatch(result)
    time_mismatch_last_match = time_mismatch_match_no_double(result)
    # print('The amount of matches for mice 1,2,3 and 4 are: ' + str(count_match))
    # print('The amount of mismatches for mice 1,2,3 and 4 are: ' + str(count_mismatch))

    return count_match, count_mismatch, time_mismatch_last_match


def count_match_mismatch(result):
    """
    This function takes the database rows as input and counts each match and mismatch for each animal.
    The function returns 2 lists with the counts as values where the animal is the index of the list.
    """
    count_match = [0, 0, 0, 0]
    count_mismatch = [0, 0, 0, 0]
    for row in result:
        if row[1] == 'RFID MATCH':
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

    return count_match, count_mismatch



def time_mismatch_match_no_double(result):
    """
    This function takes as input all the rows of a database
    and returns a 2d list where the animal is the index of the first list.
    The nested lists are all the frame counts between a mismatch and the last match.
    """
    time_mismatch_last_match = [[], [], [], []]
    tempMatch1 = 0
    tempMatch2 = 0
    tempMatch3 = 0
    tempMatch4 = 0
    last_match = [[], [], [], []]

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

                last_match[0].append(tempMatch1)
                time_mismatch_last_match[0].append(row[3] - tempMatch1)

            elif row[5] == 2:
                last_match[1].append(tempMatch2)
                time_mismatch_last_match[1].append(row[3] - tempMatch2)

            elif row[5] == 3:
                last_match[2].append(tempMatch3)
                time_mismatch_last_match[2].append(row[3] - tempMatch3)

            elif row[5] == 4:
                last_match[3].append(tempMatch4)
                time_mismatch_last_match[3].append(row[3] - tempMatch4)

    list_same = [[], [], [], []]

    k = 0
    for animal in last_match:
        temp = 0
        i = 0
        for line in animal:
            if line == temp:
                list_same[k].append(i - 1)
            i += 1
            temp = line
        k += 1

    k = 0
    for same_list in list_same:
        for index in sorted(same_list, reverse=True):
            del time_mismatch_last_match[k][index]
        k += 1

    return time_mismatch_last_match


if __name__ == '__main__':
    table = 'D:\LMT_data_post/25082020_20170048002_Group2_PreTreatment.sqlite'
    a, b, c = match_mismatch_main(table)
    start_frame, end_frame = find_start_end_file(table)
    total_time = end_frame - start_frame
    print('amount of matches ' + str(a))
    print('amount of mismatches ' + str(b))
    print(len(c[0]))
    print(c)
    print(sum(c[0]))
    print('total time: ' + str(total_time) + ' mismatch time: ' + str(sum(c[0])))
    print('percentage mismatch time ' + str((sum(c[0]) / total_time) * 100))

    # print(c[0])
