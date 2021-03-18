import math
import time

import matplotlib.pyplot as plt

from scripts.tools.find_time_frames import find_start_end_file
from scripts.tools.select_db import connection_location


def location(table):
    squares = 16
    start_frame, end_frame = find_start_end_file(table)

    print(start_frame, end_frame)
    start = time.time()

    results = connection_location(table, start_frame, end_frame)
    results = sorted(results,key=lambda l:l[3],)
    print(len(results))
    animalA = []
    animalB = []
    animalC = []
    animalD = []
    frames = []
    for coord in results:
        if coord[1] > 90 and coord[1] < 420 and coord[2] > 40 and coord[2] < 370 and coord[4] != -1:
            if coord[0] == 1:
                animalA.append([coord[1], coord[2]])
                frames.append(coord[3])
            elif coord[0] == 2:
                animalB.append([coord[1], coord[2]])
            elif coord[0] == 3:
                animalC.append([coord[1], coord[2]])
            elif coord[0] == 4:
                animalD.append([coord[1], coord[2]])

    animals  = [animalA,animalB,animalC,animalD]
    print('test ' + str(animalA[0]))

    #plotting(squares, animalA)

    i = 0
    j = 0

    locationList = []
    intervalList = []
    value = 330 / math.sqrt(squares)
    x_interval = value + 90
    y_interval = value + 40

    while i < math.sqrt(squares):
        while j < math.sqrt(squares):

            intervalList.append([x_interval-value,x_interval,y_interval-value,y_interval])

            y_interval+= value
            j+= 1
        i+= 1
        j=0
        y_interval = value + 40
        x_interval += value


    #for animal in animals:
    interval_it = 0
    k=0
    for place in animalA:
        for interval in intervalList:



            if place[0] > interval[0] and place[0] < interval[1] and place[1] > interval[2] and place[1] < interval[3]:

                locationList.append(interval_it)

            try:
                if locationList[interval_it] == 6 and locationList[interval_it-1] == 2 and locationList[interval_it-2] == 6 and locationList[interval_it-3] ==2:
                    print('k' + str(k))
            except:
                pass
            interval_it += 1
            k+= 1
        interval_it = 0

    j=0
    locationTimeList = []
    for locations in locationList:
        if j == 0:
            locationTimeList.append([locations,1])
            j+= 1
        elif locationTimeList[j-1][0] == locations:
            locationTimeList[j-1][1] += 1
        elif locationTimeList[j-1][0] != locations:
            locationTimeList.append([locations,1])
            j+= 1


    tijd = 0
    for a in locationTimeList:
        if a == [10, 1000]:
            print('tijd' + str(tijd))
        tijd += a[1]


    #print(tijd)
    #print(len(locationList))
    #print(locationTimeList)


    #print(locationTimeList)

    print(intervalList)

    with open("allLocation.txt", "w") as output:
        output.write(str(locationList))

    with open("allLocationTime.txt", "w") as output:
        output.write(str(locationTimeList))

    with open("frames.txt", "w") as output:
        output.write(str(frames))

    end = time.time()

    print('time elapsed calculating event data : ' + str(end - start))

def plotting(squares,animalA):

    i = 0
    j = 0
    k = 0
    x = []
    y = []
    value = 330 / math.sqrt(squares)
    x_interval = value + 90
    y_interval = value + 40

    while i < math.sqrt(squares):
        while j < math.sqrt(squares):
            # print(x_interval)
            # print(y_interval)
            x.append([])
            y.append([])
            for place in animalA:
                # print(place)
                if place[0] > (x_interval - value) and place[0] < x_interval and place[1] > (y_interval - value) and place[1] < y_interval:
                    x[k].append(place[0])
                    y[k].append(place[1])

            k += 1
            j += 1
            # print(k)
            y_interval += value

        i += 1
        j = 0
        y_interval = value + 40
        x_interval += value


    #print(y[7])
    plt.scatter(x[0], y[0], c='red')
    plt.scatter(x[13], y[13], c='blue')
    plt.scatter(x[21], y[21], c='green')

    plt.xlim(90, 420)
    plt.ylim(40, 370)
    plt.show()

if __name__ == '__main__':
    table = 'D:/LMT_data_post/28042020_20170048001_Group2_PreTreatment.sqlite'
    location(table)
